using UnityEngine;
using Unity.Collections;
using Unity.Jobs;
using Unity.Mathematics;
using System;
using System.Collections.Generic;
using System.Linq;


// https://github.com/MangoButtermilch/Unity-Grass-Instancer/blob/main/GrassInstancerIndirect.cs
// https://github.com/GarrettGunnell/Grass


// /!\ ATTENTION : will only work with square and unrotated terrains. You should also not have holes in your terrain.
[ExecuteInEditMode]
[RequireComponent(typeof(TerrainGetter))]
public class GrassInstancer : MonoBehaviour
{
    public static GrassInstancer instance;

    [Header("Visuals")]
    [Tooltip("Run vegetation instancer in editor. This makes memory leaks so use carrefuly.")]
    public bool runInEditor = false;

    [Header("Procedural parameters")]
    [Tooltip("Random rotation")]
    public bool randomRotation = true;
    [Tooltip("Random displacement")]
    [Range(0, 5)]
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
    public GameObject plant;
    //public GameObject plantLOD;
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
    private int viewDistanceLOD = 30;
    [Tooltip("Number of plants in a chunk length. 5 means 5*5 plants per chunk")]
    [Range(1, 300)]
    public int plantDistanceInt = 5;


    private FrustrumPlanes frustrumPlanes;
    private int totalChunkPlantsCount;

    public ComputeBuffer heightBuffer;
    public ComputeBuffer texBuffer;

    private Mesh mesh;
    //private Mesh meshLOD;
    private Material mat;

    private uint[] args;

    // for both containers, int4 is real world position and 1 if LOD else 0
    // this contains all the chunks data
    private Dictionary<int4, GrassChunk> chunksData;


    private void UpdateAllVariables()
    {
        FreeContainers();

        // get terrain data
        frustrumPlanes = new FrustrumPlanes();
        chunksData = new Dictionary<int4, GrassChunk>(1024);

        mesh = plant.GetComponent<MeshFilter>().sharedMesh;
        //meshLOD = plantLOD.GetComponent<MeshFilter>().sharedMesh;
        mat = plant.GetComponent<MeshRenderer>().sharedMaterial;

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

        Shader.SetGlobalFloat("randomSeed", 873.304f);
        Shader.SetGlobalFloat("D1Size", plantDistanceInt);
        Shader.SetGlobalFloat("chunkSize", chunkSize);
        Shader.SetGlobalFloat("plantDistance", plantDistanceInt);
        Shader.SetGlobalFloat("maxSlope", maxSlope);
        Shader.SetGlobalFloat("sizeChange", randomSize);
        Shader.SetGlobalInt("rotate", randomRotation ? 1 : 0);
        Shader.SetGlobalFloat("displacement", maxDisplacement);
        Shader.SetGlobalInt("textureIndex", textureIndexes[0]); // for now only support first texture
        Shader.SetGlobalFloat("falloff", falloff);

        heightBuffer = new ComputeBuffer(TerrainGetter.instance.terrainHeight.heightMap.Length, sizeof(float));
        heightBuffer.SetData(TerrainGetter.instance.terrainHeight.heightMap.ToArray());
        Shader.SetGlobalBuffer("heightMap", heightBuffer);
        Shader.SetGlobalInteger("resolution", TerrainGetter.instance.terrainHeight.resolution);
        Shader.SetGlobalVector("sampleSize", new Vector4(TerrainGetter.instance.terrainHeight.sampleSize.x, TerrainGetter.instance.terrainHeight.sampleSize.y, 0, 0));
        Shader.SetGlobalVector("AABBMin", new Vector4(TerrainGetter.instance.terrainHeight.AABB.Min.x, TerrainGetter.instance.terrainHeight.AABB.Min.y, TerrainGetter.instance.terrainHeight.AABB.Min.z, 0));
        Shader.SetGlobalVector("AABBMax", new Vector4(TerrainGetter.instance.terrainHeight.AABB.Max.x, TerrainGetter.instance.terrainHeight.AABB.Max.y, TerrainGetter.instance.terrainHeight.AABB.Max.z, 0));

        texBuffer = new ComputeBuffer(TerrainGetter.instance.terrainTex.textureMapAllTextures.Length, sizeof(float));
        texBuffer.SetData(TerrainGetter.instance.terrainTex.textureMapAllTextures.ToArray());
        Shader.SetGlobalBuffer("textureMapAllTextures", texBuffer);
        Shader.SetGlobalInteger("terrainPosX", TerrainGetter.instance.terrainTex.terrainPos.x);
        Shader.SetGlobalInteger("terrainPosY", TerrainGetter.instance.terrainTex.terrainPos.y);
        Shader.SetGlobalFloat("terrainSizeX", TerrainGetter.instance.terrainTex.terrainSize.x);
        Shader.SetGlobalFloat("terrainSizeY", TerrainGetter.instance.terrainTex.terrainSize.y);
        Shader.SetGlobalInteger("textureArraySizeX", TerrainGetter.instance.terrainTex.textureArraySize.x);
        Shader.SetGlobalInteger("textureArraySizeY", TerrainGetter.instance.terrainTex.textureArraySize.y);
        Shader.SetGlobalInteger("resolutionTex", TerrainGetter.instance.terrainTex.resolution);
        Shader.SetGlobalInteger("textureCount", TerrainGetter.instance.terrainTex.textureCount);
        Shader.SetGlobalFloat("ViewRangeSq", (viewDistance - chunkSize / 2) * (viewDistance - chunkSize / 2));
    }


    private void Start()
    {
        // make this a singleton
        if (instance == null)
            instance = this;
        else
        {
            Destroy(gameObject);
            return;
        }

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
    }


    private void DisposeChunk(GrassChunk g)
    {
        g.argsBuffer?.Release();
        Destroy(g.material);
    }


    private GrassChunk InitializeChunk(int4 center)
    {
        var chunk = new GrassChunk();
        chunk.argsBuffer = new ComputeBuffer(1, 5 * sizeof(uint), ComputeBufferType.IndirectArguments);
        chunk.argsBuffer.SetData(args);
        chunk.material = new Material(mat);
        return chunk;
    }


    // once this function is done, the chunks variable only contains the visible chunks, with info wether they are LOD or not
    private void UpdateChunks()
    {
        // find the chunks which appared on screen, and those which disappeared
        var chunksSampler = new PickVisibleChunksJob
        {
            terrainData = TerrainGetter.instance.terrainHeight,
            newChunks = new NativeList<int4>(Allocator.TempJob),
            deletedChunks = new NativeList<int4>(Allocator.TempJob),
            modifiedChunks = new NativeList<int4>(Allocator.TempJob),
            existingChunks = new NativeArray<int4>(chunksData.Keys.ToArray(), Allocator.TempJob),
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
        for (int i = 0; i < chunksSampler.newChunks.Length; i++)
            chunksData.Add(chunksSampler.newChunks[i], InitializeChunk(chunksSampler.newChunks[i]));

        // remove the chunks which disappeared from view
        for (int i = 0; i < chunksSampler.deletedChunks.Length; i++)
        {
            DisposeChunk(chunksData[chunksSampler.deletedChunks[i]]);
            chunksData.Remove(chunksSampler.deletedChunks[i]);
        }
        /*
        // change the state of chunks which turned from non-LOD to LOD and vice versa
        for (int i = 0; i < chunksSampler.modifiedChunks.Length; i++)
        {
            var savedData = chunksData[chunksSampler.modifiedChunks[i]];
            chunksData.Remove(chunksSampler.modifiedChunks[i]);
            chunksData.Add(
                new int4(chunksSampler.modifiedChunks[i].x,
                chunksSampler.modifiedChunks[i].y,
                chunksSampler.modifiedChunks[i].z,
                math.abs(chunksSampler.modifiedChunks[i].w - 1)),
                savedData);
        }
        */
        chunksSampler.deletedChunks.Dispose();
        chunksSampler.modifiedChunks.Dispose();
        chunksSampler.existingChunks.Dispose();
        chunksSampler.newChunks.Dispose();
    }


    private void Update()
    {
        if (!Application.isPlaying && !runInEditor)
            return;
        if (!Application.isPlaying)
        {
            if (runInEditor && instance == null)
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

        UpdateChunks();

        // update some variables globaly
        var bounds = new Bounds(cam.transform.position, Vector3.one * cam.farClipPlane);
        Vector3 lightDir = lightP.forward;
        Shader.SetGlobalVector("LightDir", new Vector4(lightDir.x, lightDir.y, lightDir.z, 1));
        Shader.SetGlobalVector("CamPos", new Vector4(cam.transform.position.x, cam.transform.position.y, cam.transform.position.z, 1));

        // draw objects
        foreach (var e in chunksData)
        {
            GrassChunk g = e.Value;
            g.material.SetInteger("chunkPosX", e.Key.x);
            g.material.SetInteger("chunkPosZ", e.Key.z);
            Graphics.DrawMeshInstancedIndirect(mesh, 0, g.material, bounds, g.argsBuffer, 0, null, UnityEngine.Rendering.ShadowCastingMode.On);
        }
        
        double chunkDrawing = Time.realtimeSinceStartupAsDouble - t;
        //Debug.Log("Full loop time : " + chunkDrawing + ", total objects spawned : " + totalChunkPlantsCount * chunksData.Count);
    }
}


public struct GrassChunk
{
    public ComputeBuffer argsBuffer;
    public Material material;
}
