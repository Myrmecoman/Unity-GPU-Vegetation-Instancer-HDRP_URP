using UnityEngine;
using Unity.Collections;
using Unity.Jobs;
using Unity.Mathematics;
using System;
using System.Collections.Generic;
using System.Linq;


// /!\ ATTENTION : Vegetation instancer will only work with square and unrotated terrains. You should also not have holes in your terrain.
[ExecuteInEditMode]
[RequireComponent(typeof(TerrainGetter))]
public class VegetationInstancer : MonoBehaviour
{
    [Header("Visuals")]
    [Tooltip("Run vegetation instancer in editor")]
    public bool runInEditor = false;

    [Header("Procedural parameters")]
    [Tooltip("Random rotation")]
    public bool randomRotation = true;
    [Tooltip("Random displacement")]
    [Range(0, 100)]
    public float maxDisplacement = 0.5f;
    [Tooltip("Changes the medium size of the objects")]
    [Range(0.01f, 3f)]
    public float sizeBias = 1f;
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
    [Tooltip("Number of plants in a chunk length. 5 means 5*5 plants per chunk")]
    public int[] plantDistanceInt;

    [Header("Settings")]
    [Tooltip("Camera")]
    public Camera cam;
    [Tooltip("The X and Z size of the chunks. Y is determined as chunkSize * 4")]
    public int chunkSize = 20;
    [Tooltip("Maximum display range")]
    public int viewDistance = 50;
    [Tooltip("Distance from which low quality plants are spawned instead of normal plants")]
    public int viewDistanceLOD = 30;


    private Mesh[] meshes;
    private Mesh[] meshesLOD;
    private RenderParams[] rpsPlants;
    private RenderParams[] rpsPlantsLOD;
    private FrustrumPlanes frustrumPlanes;
    private int[] totalChunkPlantsCount;
    private Unity.Mathematics.Random rnd;


    // for both containers, int4 is real world position and 1 if LOD else 0
    private NativeList<int4> newChunks;
    // this contains all the chunks along with their positions data
    private Dictionary<int4, NativeArray<Matrix4x4>[]> chunks;


    private void UpdateAllVariables()
    {
        FreeContainers();

        frustrumPlanes = new FrustrumPlanes();
        chunks = new Dictionary<int4, NativeArray<Matrix4x4>[]>();

        rnd = Unity.Mathematics.Random.CreateFromIndex(4973);

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

        totalChunkPlantsCount = new int[plants.Length];
        for (int i = 0; i < plants.Length; i++)
            totalChunkPlantsCount[i] = plantDistanceInt[i] * plantDistanceInt[i];
    }


    private void Start()
    {
        UpdateAllVariables(); // this is done in a separate function so that it can be called when RunInEditor changes
    }


    private void FreeContainers()
    {
        if (chunks != null)
        {
            foreach (var e in chunks)
            {
                foreach (var i in e.Value)
                {
                    if (i.IsCreated)
                        i.Dispose();
                }
            }
        }
    }


    private void OnDestroy()
    {
        FreeContainers();
    }


    // once this function is done, the chunks variable only contains the visible chunks, with info wether they are LOD or not
    private void FindVisibleChunks()
    {
        // find the chunks which appared on screen, and those which disappeared
        newChunks = new NativeList<int4>(Allocator.TempJob);
        var chunksSampler = new PickVisibleChunksJob
        {
            terrainData = TerrainGetter.instance.terrainHeight,
            newChunks = newChunks,
            deletedChunks = new NativeList<int4>(Allocator.TempJob),
            modifiedChunks = new NativeList<int4>(Allocator.TempJob),
            existingChunks = new NativeArray<int4>(chunks.Keys.ToArray(), Allocator.TempJob),
            frustrumPlanes = frustrumPlanes,
            size1D = (int)TerrainGetter.instance.terrainTex.terrainSize.x,
            camPos = new int3((int)cam.transform.position.x, (int)cam.transform.position.y, (int)cam.transform.position.z),
            terrainPos = new int3(TerrainGetter.instance.terrainTex.terrainPos.x, (int)TerrainGetter.instance.terrainHeight.AABB.Min.y, TerrainGetter.instance.terrainTex.terrainPos.y),
            chunkSize = chunkSize,
            viewDistanceLODSq = viewDistanceLOD * viewDistanceLOD,
            viewDistanceSq = viewDistance * viewDistance,
        };
        chunksSampler.Schedule().Complete();

        // add the chunks which appeared on view
        for (int i = 0; i < newChunks.Length; i++)
        {
            var array = new NativeArray<Matrix4x4>[plants.Length];
            for (int j = 0; j < plants.Length; j++)
                array[j] = new NativeArray<Matrix4x4>(totalChunkPlantsCount[j], Allocator.Persistent, NativeArrayOptions.UninitializedMemory);
            chunks.Add(newChunks[i], array);
        }

        // remove the chunks which disappeared from view
        for (int i = 0; i < chunksSampler.deletedChunks.Length; i++)
        {
            for (int j = 0; j < plants.Length; j++)
                chunks[chunksSampler.deletedChunks[i]][j].Dispose();
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
        for (int i = 0; i < newChunks.Length; i++)
        {
            for (int j = 0; j < plants.Length; j++)
            {
                int D1Size = plantDistanceInt[j];
                uint seed = (uint)((newChunks[i].x + 1) + ((newChunks[i].z + 1) * 10000) + (j * 42));
                rnd.InitState(seed);
                PositionsJob positionsSampler = new PositionsJob
                {
                    outputPlants = chunks[newChunks[i]][j],
                    terrainData = TerrainGetter.instance.terrainHeight,
                    terrainTex = TerrainGetter.instance.terrainTex,
                    chunkPos = new int3(newChunks[i].x, newChunks[i].y, newChunks[i].z),
                    D1Size = D1Size,
                    chunkSize = chunkSize,
                    plantDistance = plantDistanceInt[j],

                    // procedural variables
                    rnd = rnd,
                    maxSlope = maxSlope,
                    sizeBias = sizeBias,
                    sizeChange = randomSize,
                    rotate = randomRotation,
                    displacement = maxDisplacement,
                    textureIndex = textureIndexes[j],
                    falloff = falloff,
                };
                positionsSampler.Schedule(totalChunkPlantsCount[j], 64).Complete();
            }
        }
        newChunks.Dispose();
    }


    private void Update()
    {
        if (!Application.isPlaying && !runInEditor)
            return;
        if (!Application.isPlaying)
        {
            if (runInEditor && chunks == null)
                Start();
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
            {
                for (int j = 0; j < plants.Length; j++)
                    Graphics.RenderMeshInstanced(rpsPlants[j], meshes[j], 0, e.Value[j]);
            }
            else
            {
                for (int j = 0; j < plants.Length; j++)
                    Graphics.RenderMeshInstanced(rpsPlantsLOD[j], meshesLOD[j], 0, e.Value[j]);
            }
        }

        double chunkDrawing = Time.realtimeSinceStartupAsDouble - t;
        //Debug.Log("Full loop time : " + chunkDrawing);
    }


    private void OnDrawGizmos()
    {
        if ((!Application.isPlaying && !runInEditor) || chunks == null)
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
