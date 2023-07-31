using UnityEngine;
using Unity.Collections;
using Unity.Jobs;
using Unity.Mathematics;
using Unity.Collections.LowLevel.Unsafe;
using System;


// /!\ ATTENTION : Vegetation instancer will only work with square and unrotated terrains. You should also not have holes in your terrain.
// So far this only works with 1 terrain using Terrain.activeTerrain to find it, but it should not be complicated to handle multiple terrains.
[ExecuteInEditMode]
public class VegetationInstancer : MonoBehaviour
{
    public static VegetationInstancer instance;

    [Header("Visuals")]
    [Tooltip("Run vegetation instancer in editor")]
    public bool runInEditor = false;

    [Header("Procedural parameters")]
    [Tooltip("Random rotation")]
    public bool randomRotation = true;
    [Tooltip("Random displacement")]
    [Range(0, 100)]
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
    [Tooltip("Plants to spawn")]
    public GameObject[] plants;
    [Tooltip("Low quality plants to spawn after viewDistanceLOD")]
    public GameObject[] plantsLOD;
    [Tooltip("The texture index to spawn the corresponding plant on. Set -1 to spawn everywhere.")]
    public int[] textureIndexes;

    [Header("Settings")]
    [Tooltip("Camera")]
    public Camera cam;
    [Tooltip("The X and Z size of the chunks. Y is determined as chunkSize * 4")]
    public int chunkSize = 20;
    [Tooltip("Maximum display range")]
    public int viewDistance = 50;
    [Tooltip("Distance from which low quality plants are spawned instead of normal plants")]
    public int viewDistanceLOD = 30;
    [Tooltip("Number of plants in a chunk length. 5 means 5*5 plants per chunk")]
    [Range(1, 100)]
    public int plantDistanceInt = 5;


    private Mesh[] meshes;
    private Mesh[] meshesLOD;
    private RenderParams[] rpsPlants;
    private RenderParams[] rpsPlantsLOD;
    private Terrain terrain;
    private FrustrumPlanes frustrumPlanes;
    private TerrainHeight terrainCpy;
    private TerrainTextures terrainTex;
    private int totalChunkPlantsCount;
    private Unity.Mathematics.Random rnd;


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
        if (viewDistanceLOD > 300)
            viewDistanceLOD = 300;
        if (viewDistance <= 0)
            viewDistance = 2;
        if (viewDistance > 300)
            viewDistance = 300;

        meshes = new Mesh[plants.Length];
        meshesLOD = new Mesh[plants.Length];
        rpsPlants = new RenderParams[plants.Length];
        rpsPlantsLOD = new RenderParams[plants.Length];

        for (int i = 0; i < plants.Length; i++)
        {
            meshes[i] = plants[i].GetComponent<MeshFilter>().sharedMesh;
            meshesLOD[i] = plantsLOD[i].GetComponent<MeshFilter>().sharedMesh;
            rpsPlants[i] = new RenderParams(plants[i].GetComponent<MeshRenderer>().sharedMaterial);
            rpsPlantsLOD[i] = new RenderParams(plantsLOD[i].GetComponent<MeshRenderer>().sharedMaterial);
        }

        totalChunkPlantsCount = plantDistanceInt * plantDistanceInt;
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
    }


    // once this function is done, the chunks variable only contains the visible chunks, with info wether they are LOD or not
    private void FindVisibleChunks()
    {
        // find the chunks which appared on screen, and those which disappeared
        newChunks = new NativeList<int4>(Allocator.TempJob);
        var chunksSampler = new PickVisibleChunksJob
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
        int D1Size = plantDistanceInt;

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
        foreach (var e in chunks)
        {
            if (e.Key.w == 0)
                Graphics.RenderMeshInstanced(rpsPlants[0], meshes[0], 0, e.Value); // instanciating object with corresponding mesh and material
            else
                Graphics.RenderMeshInstanced(rpsPlantsLOD[0], meshesLOD[0], 0, e.Value); // instanciating object with corresponding mesh and material
        }

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


public struct FrustrumPlanes
{
    public Plane p1;
    public Plane p2;
    public Plane p3;
    public Plane p4;
    public Plane p5;
    public Plane p6;
}
