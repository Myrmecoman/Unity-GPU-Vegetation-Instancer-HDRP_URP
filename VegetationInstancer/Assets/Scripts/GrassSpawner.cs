using UnityEngine;
using Unity.Collections;
using Unity.Jobs;
using Unity.Mathematics;
using Unity.Collections.LowLevel.Unsafe;
using System;


// https://github.com/MangoButtermilch/Unity-Grass-Instancer/blob/main/GrassInstancerIndirect.cs


// /!\ ATTENTION : will only work with square and unrotated terrains. You should also not have holes in your terrain.
// So far this only works with 1 terrain using Terrain.activeTerrain to find it, but it should not be complicated to handle multiple terrains.
[ExecuteInEditMode]
public class GrassSpawner : MonoBehaviour
{
    public static GrassSpawner instance;

    [Header("Visuals")]
    [Tooltip("Run vegetation instancer in editor")]
    public bool runInEditor = false;

    [Header("Procedural parameters")]
    [Tooltip("Random rotation")]
    public bool randomRotation = true;
    [Tooltip("Random displacement")]
    [Range(0, 1)]
    public float maxDisplacement = 0.5f;
    [Tooltip("Random size difference, 5 means it can go from size/5 to size*5")]
    [Range(1, 5)]
    public float randomSize = 0.5f;
    [Tooltip("Maximum slope to spawn plants on")]
    [Range(0, 1)]
    public float maxSlope = 0.5f;
    [Tooltip("Maximum texture value until no object is spawned")]
    [Range(0, 1)]
    public float falloff = 1f;

    [Header("Objects to spawn")]
    public Mesh[] meshes;
    public Mesh[] meshesLOD;
    public Material[] matPlants;
    public Material[] matPlantsLOD;
    [Tooltip("The texture index to spawn the corresponding plant on. Set -1 to spawn everywhere.")]
    public int[] textureIndexes;

    [Header("Settings")]
    [Tooltip("Camera")]
    public Camera cam;
    [Tooltip("Light")]
    public Transform lightP;
    [Tooltip("The X and Z size of the chunks. Y is determined as chunkSize * 4")]
    public int chunkSize = 20;
    [Tooltip("Maximum display range")]
    public int viewDistance = 50;
    [Tooltip("Distance from which low quality plants are spawned instead of normal plants")]
    public int viewDistanceLOD = 30;
    [Tooltip("Number of plants in a meter. 5 means one plant every 0.2 meter")]
    [Range(1, 10)]
    public int plantDistanceInt = 5;


    private Terrain terrain;
    private FrustrumPlanes frustrumPlanes;
    private TerrainHeight terrainCpy;
    private TerrainTextures terrainTex;
    private int totalChunkPlantsCount;
    private Unity.Mathematics.Random rnd;

    private ComputeBuffer argsBuffer;
    private ComputeBuffer trsBuffer;
    private NativeArray<Matrix4x4> allInstances;

    // for both containers, int4 is real world position and 1 if LOD else 0
    private NativeList<int4> newChunks;
    // this contains all the chunks along with their positions data
    private UnsafeHashMap<int4, NativeArray<Matrix4x4>> chunks;


    private void UpdateAllVariables()
    {
        chunks.Clear();

        if (chunkSize < 2)
            chunkSize = 2;
        if (viewDistanceLOD <= 0)
            viewDistanceLOD = 1;
        if (viewDistanceLOD > 500)
            viewDistanceLOD = 500;
        if (viewDistance <= 0)
            viewDistance = 2;
        if (viewDistance > 500)
            viewDistance = 500;

        totalChunkPlantsCount = plantDistanceInt * chunkSize * plantDistanceInt * chunkSize;
    }


    private void Awake()
    {
        // make this a singleton
        if (instance == null)
            instance = this;
        else
        {
            Destroy(gameObject);
            return;
        }

        // get terrain data
        terrain = Terrain.activeTerrain;

        frustrumPlanes = new FrustrumPlanes();
        chunks = new UnsafeHashMap<int4, NativeArray<Matrix4x4>>(1024, Allocator.Persistent);

        terrainCpy = new TerrainHeight(terrain, Allocator.Persistent);
        terrainTex = new TerrainTextures(terrain, Allocator.Persistent);

        rnd = Unity.Mathematics.Random.CreateFromIndex(4973);

        allInstances = new NativeArray<Matrix4x4>(3000000, Allocator.Persistent);
        trsBuffer = new ComputeBuffer(3000000, 4 * 4 * sizeof(float));
        argsBuffer = new ComputeBuffer(1, 5 * sizeof(uint), ComputeBufferType.IndirectArguments);

        UpdateAllVariables(); // this is done in a separate function so that it can be called when RunInEditor changes
    }


    private void OnDestroy()
    {
        foreach (var e in chunks)
        {
            if (e.Value.IsCreated)
                e.Value.Dispose();
        }

        chunks.Dispose();
        terrainCpy.Dispose();
        terrainTex.Dispose();
        allInstances.Dispose();

        if (argsBuffer != null)
            argsBuffer.Release();
        if (trsBuffer != null)
            trsBuffer.Release();
    }


    // once this function is done, the chunks variable only contains the visible chunks, with info wether they are LOD or not
    private void FindVisibleChunks()
    {
        // find the chunks which appared on screen, and those which disappeared
        newChunks = new NativeList<int4>(Allocator.TempJob);
        PickVisibleChunksJob chunksSampler = new PickVisibleChunksJob
        {
            terrainData = terrainCpy,
            newChunks = newChunks,
            deletedChunks = new NativeList<int4>(Allocator.TempJob),
            modifiedChunks = new NativeList<int4>(Allocator.TempJob),
            existingChunks = chunks.GetKeyArray(Allocator.TempJob),
            frustrumPlanes = frustrumPlanes,
            size1D = (int)terrain.terrainData.size.x,
            camPos = new int3((int)cam.transform.position.x, (int)cam.transform.position.y, (int)cam.transform.position.z),
            terrainPos = new int3((int)terrain.transform.position.x, (int)terrain.transform.position.y, (int)terrain.transform.position.z),
            chunkSize = chunkSize,
            viewDistanceLODSq = viewDistanceLOD * viewDistanceLOD,
            viewDistanceSq = viewDistance * viewDistance,
        };
        chunksSampler.Schedule().Complete();

        // add the chunks which appeared on view
        for (int i = 0; i < newChunks.Length; i++)
            chunks.Add(newChunks[i], new NativeArray<Matrix4x4>(totalChunkPlantsCount, Allocator.Persistent, NativeArrayOptions.UninitializedMemory));

        // remove the chunks which disappeared from view
        for (int i = 0; i < chunksSampler.deletedChunks.Length; i++)
        {
            chunks[chunksSampler.deletedChunks[i]].Dispose();
            chunks.Remove(chunksSampler.deletedChunks[i]);
        }

        // change the state of chunks which turned from non-LOD to LOD and vice versa
        for (int i = 0; i < chunksSampler.modifiedChunks.Length; i++)
        {
            var savedArray = chunks[chunksSampler.modifiedChunks[i]];
            chunks.Remove(chunksSampler.modifiedChunks[i]);
            chunks.Add(
                new int4(chunksSampler.modifiedChunks[i].x,
                chunksSampler.modifiedChunks[i].y,
                chunksSampler.modifiedChunks[i].z,
                math.abs(chunksSampler.modifiedChunks[i].w - 1)),
                savedArray);
        }

        chunksSampler.deletedChunks.Dispose();
        chunksSampler.modifiedChunks.Dispose();
        chunksSampler.existingChunks.Dispose();
    }


    // once the function is done, the 2 jobs resulting struct contain each an array with the positions of the plants
    private void FillVisibleChunks()
    {
        int D1Size = plantDistanceInt * chunkSize;

        for (int i = 0; i < newChunks.Length; i++)
        {
            uint seed = (uint)((newChunks[i].x == 0 ? 1 : newChunks[i].x) + (newChunks[i].z * 10000 == 0 ? 1 : newChunks[i].z * 10000));
            rnd.InitState(seed);
            PositionsJob positionsSampler = new PositionsJob
            {
                outputPlants = chunks[newChunks[i]],
                terrainData = terrainCpy,
                terrainTex = terrainTex,
                chunkPos = new int3(newChunks[i].x, newChunks[i].y, newChunks[i].z),
                D1Size = D1Size,
                chunkSize = chunkSize,
                plantDistance = plantDistanceInt,

                // procedural variables
                rnd = rnd,
                maxSlope = maxSlope,
                sizeChange = randomSize,
                rotate = randomRotation,
                displacement = maxDisplacement,
                textureIndex = textureIndexes[0],
                falloff = falloff,
            };
            positionsSampler.Schedule(totalChunkPlantsCount, 64).Complete();
        }
        newChunks.Dispose();
    }


    private void Update()
    {
        if (!Application.isPlaying && !runInEditor)
            return;
        if (!Application.isPlaying)
        {
            if (runInEditor && !chunks.IsCreated)
                Awake();
            if (runInEditor)
                UpdateAllVariables();
        }

        double t = Time.realtimeSinceStartupAsDouble;

        var planes = GeometryUtility.CalculateFrustumPlanes(cam);
        frustrumPlanes.p1 = planes[0];
        frustrumPlanes.p2 = planes[1];
        frustrumPlanes.p3 = planes[2];
        frustrumPlanes.p4 = planes[3];
        frustrumPlanes.p5 = planes[4];
        frustrumPlanes.p6 = planes[5];

        FindVisibleChunks();
        FillVisibleChunks();

        // draw objects
        int i = 0;
        foreach (var e in chunks)
        {
            allInstances.GetSubArray(i, totalChunkPlantsCount).CopyFrom(e.Value);
            i += totalChunkPlantsCount;
        }

        Vector3 lightDir = lightP.forward;
        matPlants[0].SetVector("_LightDir", new Vector4(lightDir.x, lightDir.y, lightDir.z, 1));

        uint[] args = new uint[5];
        args[0] = (uint)meshes[0].GetIndexCount(0);
        args[1] = (uint)i;
        args[2] = (uint)meshes[0].GetIndexStart(0);
        args[3] = (uint)meshes[0].GetBaseVertex(0);
        args[4] = 0;
        argsBuffer.SetData(args);

        trsBuffer.SetData(allInstances.GetSubArray(0, i - 1));
        matPlants[0].SetBuffer("trsBuffer", trsBuffer);

        Graphics.DrawMeshInstancedIndirect(meshes[0], 0, matPlants[0], new Bounds(cam.transform.position, Vector3.one * cam.farClipPlane), argsBuffer, 0, null,
        UnityEngine.Rendering.ShadowCastingMode.Off);

        double chunkDrawing = Time.realtimeSinceStartupAsDouble - t;
        //Debug.Log("Full loop time : " + chunkDrawing);
    }


    private void OnDrawGizmos()
    {
        if ((!Application.isPlaying && !runInEditor) || !chunks.IsCreated)
            return;

        foreach (var e in chunks)
        {
            if (e.Key.w == 0)
                Gizmos.color = Color.red;
            else
                Gizmos.color = Color.yellow;

            Gizmos.DrawWireCube(new float3(e.Key.x, e.Key.y, e.Key.z), new float3(chunkSize, 1, chunkSize));
        }
    }
}
