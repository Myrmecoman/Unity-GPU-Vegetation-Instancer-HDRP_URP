using UnityEngine;
using Unity.Collections;
using Unity.Jobs;
using Unity.Mathematics;
using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine.Rendering;


// https://github.com/MangoButtermilch/Unity-Grass-Instancer/blob/main/GrassInstancerIndirect.cs
// https://github.com/GarrettGunnell/Grass


// /!\ ATTENTION : will only work with square and unrotated terrains. You should also not have holes in your terrain.
[ExecuteInEditMode]
[RequireComponent(typeof(VegetationManager))]
public class VegetationInstancer : MonoBehaviour
{
    [Header("Visuals")]
    [Tooltip("Run vegetation instancer in editor. Use carrefuly.")]
    public bool runInEditor = false;
    [Tooltip("Display the chunks")]
    public bool displayChunks = false;
    [Tooltip("The positions compute shader")]
    public ComputeShader positionsComputeShader;

    [Header("Procedural parameters")]
    [Tooltip("Random displacement")]
    [Range(0, 5)]
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
    public GameObject plant;
    [Tooltip("The texture index to spawn the corresponding plant on. Set -1 to spawn everywhere.")]
    public int[] textureIndexes;

    [Header("Settings")]
    [Tooltip("The X and Z size of the chunks. Y is determined as chunkSize * 4")]
    public int chunkSize = 20;
    [Tooltip("Maximum display range")]
    public int viewDistance = 50;
    [Tooltip("Distance from which low quality plants are spawned instead of normal plants")]
    private int viewDistanceLOD = 30;
    [Tooltip("Number of plants in a chunk length. 5 means 5*5 plants per chunk")]
    [Range(1, 300)]
    public int plantDistanceInt = 5;


    private FrustrumPlanes frustrumPlanes;
    private int totalChunkPlantsCount;

    private ComputeBuffer heightBuffer;
    private ComputeBuffer texBuffer;
    private ComputeBuffer argsBuffer;

    private ComputeBuffer chunksBuffer;
    private ComputeBuffer positionsBuffer;

    private Mesh mesh;
    private Material mat;

    private uint[] args;

    // for both containers, int4 is real world position and 1 if LOD else 0
    // this contains all the chunks data
    private Dictionary<int4, bool> chunksData;


    private void UpdateAllVariables()
    {
        FreeContainers();

        // get terrain data
        frustrumPlanes = new FrustrumPlanes();
        chunksData = new Dictionary<int4, bool>(1024);

        mesh = plant.GetComponent<MeshFilter>().sharedMesh;
        //meshLOD = plantLOD.GetComponent<MeshFilter>().sharedMesh;
        mat = new Material(plant.GetComponent<MeshRenderer>().sharedMaterial);

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

        totalChunkPlantsCount = plantDistanceInt * plantDistanceInt;

        args = new uint[5];
        args[0] = (uint)mesh.GetIndexCount(0);
        args[1] = (uint)totalChunkPlantsCount;
        args[2] = (uint)mesh.GetIndexStart(0);
        args[3] = (uint)mesh.GetBaseVertex(0);
        args[4] = 0;

        argsBuffer = new ComputeBuffer(1, 5 * sizeof(uint), ComputeBufferType.IndirectArguments);
        argsBuffer.SetData(args);

        positionsComputeShader.SetFloat("randomSeed", 873.304f);
        positionsComputeShader.SetFloat("D1Size", plantDistanceInt);
        positionsComputeShader.SetFloat("chunkSize", chunkSize);
        positionsComputeShader.SetFloat("plantDistance", plantDistanceInt);
        positionsComputeShader.SetFloat("maxSlope", maxSlope);
        positionsComputeShader.SetFloat("sizeChange", randomSize);
        positionsComputeShader.SetFloat("displacement", maxDisplacement);
        positionsComputeShader.SetInt("textureIndex", textureIndexes[0]); // for now only support first texture
        positionsComputeShader.SetFloat("falloff", falloff);
        positionsComputeShader.SetFloat("sizeBias", sizeBias);

        heightBuffer = new ComputeBuffer(VegetationManager.instance.terrainHeight.heightMap.Length, sizeof(float));
        heightBuffer.SetData(VegetationManager.instance.terrainHeight.heightMap.ToArray());
        positionsComputeShader.SetBuffer(0, "heightMap", heightBuffer);
        positionsComputeShader.SetInt("resolution", VegetationManager.instance.terrainHeight.resolution);
        positionsComputeShader.SetVector("sampleSize", new Vector4(VegetationManager.instance.terrainHeight.sampleSize.x, VegetationManager.instance.terrainHeight.sampleSize.y, 0, 0));
        positionsComputeShader.SetVector("AABBMin", new Vector4(VegetationManager.instance.terrainHeight.AABB.Min.x, VegetationManager.instance.terrainHeight.AABB.Min.y, VegetationManager.instance.terrainHeight.AABB.Min.z, 0));
        positionsComputeShader.SetVector("AABBMax", new Vector4(VegetationManager.instance.terrainHeight.AABB.Max.x, VegetationManager.instance.terrainHeight.AABB.Max.y, VegetationManager.instance.terrainHeight.AABB.Max.z, 0));

        texBuffer = new ComputeBuffer(VegetationManager.instance.terrainTex.textureMapAllTextures.Length, sizeof(float));
        texBuffer.SetData(VegetationManager.instance.terrainTex.textureMapAllTextures.ToArray());
        positionsComputeShader.SetBuffer(0, "textureMapAllTextures", texBuffer);
        positionsComputeShader.SetInt("terrainPosX", VegetationManager.instance.terrainTex.terrainPos.x);
        positionsComputeShader.SetInt("terrainPosY", VegetationManager.instance.terrainTex.terrainPos.y);
        positionsComputeShader.SetFloat("terrainSizeX", VegetationManager.instance.terrainTex.terrainSize.x);
        positionsComputeShader.SetFloat("terrainSizeY", VegetationManager.instance.terrainTex.terrainSize.y);
        positionsComputeShader.SetInt("textureArraySizeX", VegetationManager.instance.terrainTex.textureArraySize.x);
        positionsComputeShader.SetInt("textureArraySizeY", VegetationManager.instance.terrainTex.textureArraySize.y);
        positionsComputeShader.SetInt("resolutionTex", VegetationManager.instance.terrainTex.resolution);
        positionsComputeShader.SetInt("textureCount", VegetationManager.instance.terrainTex.textureCount);
        positionsComputeShader.SetFloat("ViewRangeSq", (viewDistance - chunkSize / 2) * (viewDistance - chunkSize / 2));
    }


    private void Start()
    {
        UpdateAllVariables(); // this is done in a separate function so that it can be called when RunInEditor changes
    }


    private void OnDestroy()
    {
        FreeContainers();
    }


    private void FreeContainers()
    {
        if (chunksData != null)
            chunksData.Clear();

        heightBuffer?.Release();
        texBuffer?.Release();
        positionsBuffer?.Release();
        argsBuffer?.Release();
    }


    // once this function is done, the chunks variable only contains the visible chunks, with info wether they are LOD or not
    private void UpdateChunks()
    {
        // find the chunks which appared on screen, and those which disappeared
        var chunksSampler = new PickVisibleChunksJob
        {
            terrainData = VegetationManager.instance.terrainHeight,
            newChunks = new NativeList<int4>(Allocator.TempJob),
            deletedChunks = new NativeList<int4>(Allocator.TempJob),
            modifiedChunks = new NativeList<int4>(Allocator.TempJob),
            existingChunks = new NativeArray<int4>(chunksData.Keys.ToArray(), Allocator.TempJob),
            frustrumPlanes = frustrumPlanes,
            size1D = (int)VegetationManager.instance.terrainTex.terrainSize.x,
            camPos = new int3((int)VegetationManager.instance.cam.transform.position.x, (int)VegetationManager.instance.cam.transform.position.y, (int)VegetationManager.instance.cam.transform.position.z),
            terrainPos = new int3(VegetationManager.instance.terrainTex.terrainPos.x, (int)VegetationManager.instance.terrainHeight.AABB.Min.y, VegetationManager.instance.terrainTex.terrainPos.y),
            chunkSize = chunkSize,
            viewDistanceLODSq = viewDistanceLOD * viewDistanceLOD,
            viewDistanceSq = viewDistance * viewDistance,
        };
        chunksSampler.Schedule().Complete();

        // add the chunks which appeared on view
        for (int i = 0; i < chunksSampler.newChunks.Length; i++)
            chunksData.Add(chunksSampler.newChunks[i], true);

        // remove the chunks which disappeared from view
        for (int i = 0; i < chunksSampler.deletedChunks.Length; i++)
            chunksData.Remove(chunksSampler.deletedChunks[i]);

        chunksSampler.deletedChunks.Dispose();
        chunksSampler.modifiedChunks.Dispose();
        chunksSampler.existingChunks.Dispose();
        chunksSampler.newChunks.Dispose();
    }


    private void RunpositionsComputeShader()
    {
        int totalPlants = plantDistanceInt * plantDistanceInt * chunksData.Count;
        positionsBuffer?.Release();
        positionsBuffer = null;
        positionsBuffer = new ComputeBuffer(totalPlants, 16 * sizeof(float) + 16 * sizeof(float) + 4 * sizeof(float));

        chunksBuffer?.Release();
        chunksBuffer = null;
        chunksBuffer = new ComputeBuffer(chunksData.Count, sizeof(int) * 4);
        chunksBuffer.SetData(chunksData.Keys.ToArray());

        positionsComputeShader.SetBuffer(0, "positions", positionsBuffer);
        positionsComputeShader.SetBuffer(0, "chunksPositions", chunksBuffer);
        
        int groups = Mathf.CeilToInt(totalPlants / 1024f);
        positionsComputeShader.Dispatch(0, groups, 1, 1);
    }


    private void Update()
    {
        if (!Application.isPlaying && !runInEditor)
            return;
        if (!Application.isPlaying)
        {
            if (runInEditor && chunksData == null)
                Start();
            if (runInEditor)
                UpdateAllVariables();
        }

        double t = Time.realtimeSinceStartupAsDouble;
        var planes = new FrustrumPlanes(GeometryUtility.CalculateFrustumPlanes(VegetationManager.instance.cam));

        UpdateChunks();
        RunpositionsComputeShader();

        // recalculate bounds, and set positions buffer
        var bounds = new Bounds(VegetationManager.instance.cam.transform.position, Vector3.one * VegetationManager.instance.cam.farClipPlane);
        mat.SetBuffer("GPUInstancedIndirectDataBuffer", positionsBuffer);

        // draw objects and free positions
        //Graphics.DrawMeshInstancedIndirect(mesh, 0, mat, bounds, argsBuffer, 0, null, UnityEngine.Rendering.ShadowCastingMode.On, true);
        Graphics.DrawMeshInstancedIndirect(mesh, 0, mat, bounds, argsBuffer, 0, null, ShadowCastingMode.On, true);

        double totalTime = Time.realtimeSinceStartupAsDouble - t;
        //Debug.Log("Full loop time : " + totalTime + ", total objects spawned : " + totalChunkPlantsCount * chunksData.Count);
    }


    private void OnDrawGizmos()
    {
        if (!displayChunks || Application.isPlaying || chunksData == null)
            return;

        foreach (var e in chunksData)
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


    public FrustrumPlanes(Plane[] planes)
    {
        p1 = planes[0];
        p2 = planes[1];
        p3 = planes[2];
        p4 = planes[3];
        p5 = planes[4];
        p6 = planes[5];
    }
}
