using UnityEngine;
using Unity.Collections;
using Unity.Jobs;
using Unity.Mathematics;
using System;
using System.Collections.Generic;
using UnityEngine.Rendering;


// /!\ ATTENTION : will only work with square and unrotated terrains. You should also not have holes in your terrain.
[ExecuteInEditMode]
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
    [Tooltip("Maximum height where this object can live")]
    public float maxHeight = 10000f;
    [Tooltip("Minimum height where this object can live")]
    public float minHeight = -10000f;

    [Header("Objects to spawn")]
    public GameObject plant;
    [Header("LOD objects to spawn")]
    public GameObject LODplant;
    [Tooltip("The texture index to spawn the corresponding plant on. Set -1 to spawn everywhere.")]
    public int[] textureIndexes;

    [Header("Settings")]
    [Tooltip("Set to true if you use unity's quad to render your grass, because it is centered in the middle of the mesh instead of at the base.")]
    public bool centeredMesh = false;
    [Tooltip("The X and Z size of the chunks. Y is determined as chunkSize * 4")]
    public int chunkSize = 20;
    [Tooltip("Maximum display range")]
    public int viewDistance = 50;
    [Tooltip("Distance at which LODs start")]
    public int LODviewDistance = 30;
    [Tooltip("Number of plants in a chunk length. 5 means 5*5 plants per chunk")]
    [Range(1, 300)]
    public int plantDistanceInt = 5;


    private int instancesPerChunk;
    private int maxPositionsBufferInstances;
    private int LODmaxPositionsBufferInstances;
    private Mesh mesh;
    private Material mat;
    private Mesh LODmesh;
    private Material LODmat;
    private ComputeBuffer argsBuffer;
    private ComputeBuffer LODargsBuffer;
    private ComputeBuffer chunksBuffer;
    private ComputeBuffer LODchunksBuffer;
    private ComputeBuffer positionsBuffer;
    private ComputeBuffer LODpositionsBuffer;

    // lists of chunks
    private List<int3> normalChunksList;
    private List<int3> LODChunksList;

    // variables to not recompute everyframe if we stand still
    private Vector3 lastPosition;
    private Quaternion lastRotation;


    private void UpdateAllVariables()
    {
        FreeContainers();

        normalChunksList = new List<int3>(1024);
        LODChunksList = new List<int3>(1024);

        mesh = plant.GetComponent<MeshFilter>().sharedMesh;
        mat = new Material(plant.GetComponent<MeshRenderer>().sharedMaterial);
        LODmesh = LODplant.GetComponent<MeshFilter>().sharedMesh;
        LODmat = new Material(LODplant.GetComponent<MeshRenderer>().sharedMaterial);

        if (chunkSize < 2)
            chunkSize = 2;

        if (viewDistance <= 0)
            viewDistance = 1;
        if (viewDistance > 1000)
            viewDistance = 1000;

        if (LODviewDistance <= 0)
            LODviewDistance = 1;
        if (LODviewDistance >= viewDistance)
            LODviewDistance = viewDistance - 1;

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
        positionsComputeShader.SetInt("centeredMesh", centeredMesh ? 1:0);
        positionsComputeShader.SetFloat("positionOffset", YPositionOffset);
        positionsComputeShader.SetFloat("maxHeight", maxHeight);
        positionsComputeShader.SetFloat("minHeight", minHeight);
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
        normalChunksList?.Clear();
        normalChunksList = null;
        LODChunksList?.Clear();
        LODChunksList = null;

        positionsBuffer?.Release();
        positionsBuffer = null;
        LODpositionsBuffer?.Release();
        LODpositionsBuffer = null;

        argsBuffer?.Release();
        argsBuffer = null;
        LODargsBuffer?.Release();
        LODargsBuffer = null;
    }


    // once this function is done, the chunksData dictionary only contains the visible chunks, with info wether they are LOD or not
    private void UpdateChunks()
    {
        // find the chunks which appared on screen, and those which disappeared
        var chunksSampler = new PickVisibleChunksJob
        {
            terrainData = VegetationManager.instance.terrainHeight,
            normalChunks = new NativeList<int3>(Allocator.TempJob),
            LODChunks = new NativeList<int3>(Allocator.TempJob),
            frustrumPlanes = new FrustrumPlanes(GeometryUtility.CalculateFrustumPlanes(VegetationManager.instance.cam)),
            size1D = (int)VegetationManager.instance.terrainTex.terrainSize.x,
            camPos = new int3((int)VegetationManager.instance.cam.transform.position.x, (int)VegetationManager.instance.cam.transform.position.y, (int)VegetationManager.instance.cam.transform.position.z),
            terrainPos = new int3(VegetationManager.instance.terrainTex.terrainPos.x, (int)VegetationManager.instance.terrainHeight.AABB.Min.y, VegetationManager.instance.terrainTex.terrainPos.y),
            chunkSize = chunkSize,
            viewDistanceSq = viewDistance * viewDistance,
            LODviewDistanceSq = LODviewDistance * LODviewDistance,
        };
        chunksSampler.Schedule().Complete();

        // add the chunks which appeared on view
        normalChunksList.Clear();
        for (int i = 0; i < chunksSampler.normalChunks.Length; i++)
            normalChunksList.Add(chunksSampler.normalChunks[i]);

        LODChunksList.Clear();
        for (int i = 0; i < chunksSampler.LODChunks.Length; i++)
            LODChunksList.Add(chunksSampler.LODChunks[i]);

        chunksSampler.normalChunks.Dispose();
        chunksSampler.LODChunks.Dispose();
    }


    private void RunpositionsComputeShader()
    {
        // run compute shader for non LOD objects -----------------------------------------------------------
        int totalPlants = instancesPerChunk * normalChunksList.Count;
        if (maxPositionsBufferInstances < totalPlants || positionsBuffer == null && totalPlants != 0)
        {
            // output buffer for objects positions, only increase size if needed
            maxPositionsBufferInstances = totalPlants;
            positionsBuffer?.Release();
            positionsBuffer = null;
            positionsBuffer = new ComputeBuffer(totalPlants, 16 * sizeof(float) + 16 * sizeof(float) + 4 * sizeof(float));
        }

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

        if (totalPlants != 0)
        {
            // readonly buffer containing chunks positions
            chunksBuffer?.Release();
            chunksBuffer = null;
            chunksBuffer = new ComputeBuffer(normalChunksList.Count, sizeof(int) * 3);
            chunksBuffer.SetData(normalChunksList.ToArray());

            positionsComputeShader.SetVector("camPos", new float4((int)VegetationManager.instance.cam.transform.position.x, (int)VegetationManager.instance.cam.transform.position.y, (int)VegetationManager.instance.cam.transform.position.z, 1f));
            positionsComputeShader.SetInt("positionsSize", totalPlants);
            positionsComputeShader.SetInt("plantsPerChunk", instancesPerChunk);
            positionsComputeShader.SetBuffer(0, "positions", positionsBuffer);
            positionsComputeShader.SetBuffer(0, "chunksPositions", chunksBuffer);

            int groups = Mathf.CeilToInt(totalPlants / 1024f);
            positionsComputeShader.Dispatch(0, groups, 1, 1);
        }

        // run compute shader for LOD objects -----------------------------------------------------------
        int LODtotalPlants = instancesPerChunk * LODChunksList.Count;
        if (LODmaxPositionsBufferInstances < LODtotalPlants || LODpositionsBuffer == null && LODtotalPlants != 0)
        {
            // output buffer for objects positions, only increase size if needed
            LODmaxPositionsBufferInstances = LODtotalPlants;
            LODpositionsBuffer?.Release();
            LODpositionsBuffer = null;
            LODpositionsBuffer = new ComputeBuffer(LODtotalPlants, 16 * sizeof(float) + 16 * sizeof(float) + 4 * sizeof(float));
        }

        // reset args because the number of instances probably changed
        args = new uint[5];
        args[0] = (uint)mesh.GetIndexCount(0);
        args[1] = (uint)LODtotalPlants;
        args[2] = (uint)mesh.GetIndexStart(0);
        args[3] = (uint)mesh.GetBaseVertex(0);
        args[4] = (uint)0;

        LODargsBuffer?.Release();
        LODargsBuffer = null;
        LODargsBuffer = new ComputeBuffer(1, 5 * sizeof(uint), ComputeBufferType.IndirectArguments);
        LODargsBuffer.SetData(args);

        if (LODtotalPlants != 0)
        {
            // readonly buffer containing chunks positions
            LODchunksBuffer?.Release();
            LODchunksBuffer = null;
            LODchunksBuffer = new ComputeBuffer(LODChunksList.Count, sizeof(int) * 3);
            LODchunksBuffer.SetData(LODChunksList.ToArray());

            positionsComputeShader.SetVector("camPos", new float4((int)VegetationManager.instance.cam.transform.position.x, (int)VegetationManager.instance.cam.transform.position.y, (int)VegetationManager.instance.cam.transform.position.z, 1f));
            positionsComputeShader.SetInt("positionsSize", LODtotalPlants);
            positionsComputeShader.SetInt("plantsPerChunk", instancesPerChunk);
            positionsComputeShader.SetBuffer(0, "positions", LODpositionsBuffer);
            positionsComputeShader.SetBuffer(0, "chunksPositions", LODchunksBuffer);

            int LODgroups = Mathf.CeilToInt(LODtotalPlants / 1024f);
            positionsComputeShader.Dispatch(0, LODgroups, 1, 1);
        }
    }


    private void Update()
    {
        if (!Application.isPlaying && !runInEditor)
            return;
        if (!Application.isPlaying && runInEditor)
            UpdateAllVariables();

        double t = Time.realtimeSinceStartupAsDouble;

        // if we did not move, no need to recompute everything
        if (VegetationManager.instance.cam.transform.position != lastPosition || VegetationManager.instance.cam.transform.rotation != lastRotation || (!Application.isPlaying && runInEditor))
        {
            UpdateChunks();
            RunpositionsComputeShader();
        }
        lastPosition = VegetationManager.instance.cam.transform.position;
        lastRotation = VegetationManager.instance.cam.transform.rotation;

        // draw objects
        var bounds = new Bounds(VegetationManager.instance.cam.transform.position, Vector3.one * VegetationManager.instance.cam.farClipPlane);
        mat.SetBuffer("GPUInstancedIndirectDataBuffer", positionsBuffer);
        Graphics.DrawMeshInstancedIndirect(mesh, 0, mat, bounds, argsBuffer, 0, null, ShadowCastingMode.On, true);

        LODmat.SetBuffer("GPUInstancedIndirectDataBuffer", LODpositionsBuffer);
        Graphics.DrawMeshInstancedIndirect(LODmesh, 0, LODmat, bounds, LODargsBuffer, 0, null, ShadowCastingMode.On, true);

        double totalTime = Time.realtimeSinceStartupAsDouble - t;
        //Debug.Log("Full loop time : " + totalTime);
    }


    private void OnDrawGizmos()
    {
        if (!displayChunks || Application.isPlaying || normalChunksList == null)
            return;

        Gizmos.color = Color.red;
        foreach (var e in normalChunksList)
            Gizmos.DrawWireCube(new float3(e.x, e.y, e.z), new float3(chunkSize, 1, chunkSize));
        Gizmos.color = Color.yellow;
        foreach (var e in LODChunksList)
            Gizmos.DrawWireCube(new float3(e.x, e.y, e.z), new float3(chunkSize, 1, chunkSize));
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
