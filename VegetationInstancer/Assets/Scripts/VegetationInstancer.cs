using UnityEngine;
using Unity.Collections;
using Unity.Jobs;
using Unity.Mathematics;
using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine.Rendering;


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
    [Tooltip("Offset objects upwards, usefull when their center does not corresponds to their base.")]
    [Range(0, 5)]
    public float YPositionOffset = 0f;
    [Tooltip("Changes the medium size of the objects")]
    [Range(0.01f, 5f)]
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
    [Tooltip("Set to true if you use a quad to render your grass, this way VegetationInstancer will spawn 2 quads rotated by 90 degrees")]
    public bool billboardMode = false;
    [Tooltip("The X and Z size of the chunks. Y is determined as chunkSize * 4")]
    public int chunkSize = 20;
    [Tooltip("Maximum display range")]
    public int viewDistance = 50;
    [Tooltip("Distance from which low quality plants are spawned instead of normal plants")]
    private int viewDistanceLOD = 30;
    [Tooltip("Number of plants in a chunk length. 5 means 5*5 plants per chunk")]
    [Range(1, 300)]
    public int plantDistanceInt = 5;


    private int instancesPerChunk;
    private Mesh mesh;
    private Material mat;
    private ComputeBuffer argsBuffer;
    private ComputeBuffer chunksBuffer;
    private ComputeBuffer positionsBuffer;

    // int4 is real world position and 1 if LOD else 0, the bool is not used
    private Dictionary<int4, bool> chunksData;


    private void UpdateAllVariables()
    {
        FreeContainers();

        chunksData = new Dictionary<int4, bool>(1024);

        mesh = plant.GetComponent<MeshFilter>().sharedMesh;
        mat = new Material(plant.GetComponent<MeshRenderer>().sharedMaterial);

        if (chunkSize < 2)
            chunkSize = 2;
        if (viewDistanceLOD <= 0)
            viewDistanceLOD = 1;
        if (viewDistanceLOD > 1000)
            viewDistanceLOD = 1000;
        if (viewDistance <= 0)
            viewDistance = 2;
        if (viewDistance > 1000)
            viewDistance = 1000;

        instancesPerChunk = plantDistanceInt * plantDistanceInt;

        positionsComputeShader.SetFloat("randomSeed", 873.304f);
        positionsComputeShader.SetFloat("D1Size", plantDistanceInt);
        positionsComputeShader.SetFloat("chunkSize", chunkSize);
        positionsComputeShader.SetFloat("plantDistance", plantDistanceInt);
        positionsComputeShader.SetFloat("maxSlope", maxSlope);
        positionsComputeShader.SetFloat("sizeChange", randomSize);
        positionsComputeShader.SetFloat("displacement", maxDisplacement);
        positionsComputeShader.SetFloat("falloff", falloff);
        positionsComputeShader.SetFloat("sizeBias", sizeBias);
        positionsComputeShader.SetInt("textureIndex", textureIndexes[0]); // for now only support first texture
        positionsComputeShader.SetFloat("ViewRangeSq", (viewDistance - chunkSize / 2) * (viewDistance - chunkSize / 2));
        positionsComputeShader.SetInt("billboardMode", billboardMode?1:0);
        positionsComputeShader.SetFloat("positionOffset", YPositionOffset);
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
        chunksData?.Clear();
        chunksData = null;
        positionsBuffer?.Release();
        positionsBuffer = null;
        argsBuffer?.Release();
        argsBuffer = null;
    }


    // once this function is done, the chunksData dictionary only contains the visible chunks, with info wether they are LOD or not
    private void UpdateChunks()
    {
        // find the chunks which appared on screen, and those which disappeared
        var chunksSampler = new PickVisibleChunksJob
        {
            terrainData = VegetationManager.instance.terrainHeight,
            newChunks = new NativeList<int4>(Allocator.TempJob),
            deletedChunks = new NativeList<int4>(Allocator.TempJob),
            existingChunks = new NativeArray<int4>(chunksData.Keys.ToArray(), Allocator.TempJob),
            frustrumPlanes = new FrustrumPlanes(GeometryUtility.CalculateFrustumPlanes(VegetationManager.instance.cam)),
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
        chunksSampler.existingChunks.Dispose();
        chunksSampler.newChunks.Dispose();
    }


    private void RunpositionsComputeShader()
    {
        int billboardNb = 1;
        if (billboardMode)
            billboardNb = 2;

        int totalPlants = instancesPerChunk * chunksData.Count * billboardNb;

        // reset args because the number of instances probably changed
        var args = new uint[5];
        args[0] = (uint)mesh.GetIndexCount(0);
        args[1] = (uint)totalPlants;
        args[2] = (uint)mesh.GetIndexStart(0);
        args[3] = (uint)mesh.GetBaseVertex(0);
        args[4] = (uint)0;

        argsBuffer?.Release();
        argsBuffer = null;
        argsBuffer = new ComputeBuffer(1, 5 * sizeof(uint), ComputeBufferType.IndirectArguments);
        argsBuffer.SetData(args);

        // output buffer for objects positions
        positionsBuffer?.Release();
        positionsBuffer = null;
        positionsBuffer = new ComputeBuffer(totalPlants, 16 * sizeof(float) + 16 * sizeof(float) + 4 * sizeof(float));

        // readonly buffer containing chunks positions
        chunksBuffer?.Release();
        chunksBuffer = null;
        chunksBuffer = new ComputeBuffer(chunksData.Count, sizeof(int) * 4);
        chunksBuffer.SetData(chunksData.Keys.ToArray());

        positionsComputeShader.SetVector("camPos", new float4(VegetationManager.instance.cam.transform.position.x, VegetationManager.instance.cam.transform.position.y, VegetationManager.instance.cam.transform.position.z, 1f));
        positionsComputeShader.SetInt("positionsSize", totalPlants);
        positionsComputeShader.SetInt("plantsPerChunk", instancesPerChunk);
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

        UpdateChunks();
        RunpositionsComputeShader();

        // draw objects
        var bounds = new Bounds(VegetationManager.instance.cam.transform.position, Vector3.one * VegetationManager.instance.cam.farClipPlane);
        mat.SetBuffer("GPUInstancedIndirectDataBuffer", positionsBuffer);
        Graphics.DrawMeshInstancedIndirect(mesh, 0, mat, bounds, argsBuffer, 0, null, ShadowCastingMode.On, true);

        double totalTime = Time.realtimeSinceStartupAsDouble - t;
        //Debug.Log("Full loop time : " + totalTime + ", total objects spawned : " + instancesPerChunk * chunksData.Count);
    }


    private void OnDrawGizmos()
    {
        if (!displayChunks || Application.isPlaying || chunksData == null)
            return;

        Gizmos.color = Color.yellow;
        foreach (var e in chunksData)
            Gizmos.DrawWireCube(new float3(e.Key.x, e.Key.y, e.Key.z), new float3(chunkSize, 1, chunkSize));
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
