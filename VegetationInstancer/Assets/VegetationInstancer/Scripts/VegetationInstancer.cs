using UnityEngine;
using Unity.Collections;
using Unity.Jobs;
using Unity.Mathematics;
using System;
using System.Collections.Generic;
using UnityEngine.Rendering;

namespace Myrmecoman
{
    // /!\ ATTENTION : will only work with square and unrotated terrains. You should also not have holes in your terrain.
    [ExecuteInEditMode]
    public class VegetationInstancer : MonoBehaviour
    {
        [Header("Visuals")]
        [Tooltip("Run vegetation instancer in editor. Use carrefuly.")]
        public bool runInEditor = false;
        [Tooltip("Display the chunks. Chunks are only updated when runInEditor is true of the application is running.")]
        public bool displayChunks = false;
        [Tooltip("The positions compute shader")]
        public ComputeShader positionsComputeShader;
        [Tooltip("Compute shader preparing culling data")]
        public ComputeShader prepareCullingComputeShader;
        [Tooltip("The culling compute shader")]
        public ComputeShader cullingComputeShader;

        [Header("Procedural parameters")]
        [Tooltip("The seed should be different for each instancer, otherwise objects can end up at the exact same position.")]
        public float seed = 1f;
        [Tooltip("Random displacement")]
        [Range(0f, 50f)]
        public float maxDisplacement = 0.5f;
        [Tooltip("Offset objects upwards, usefull when their center does not corresponds to their base.")]
        [Range(0, 5)]
        public float yPositionOffset = 0f;
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
        [Tooltip("Object diameter used by frustrum culling. Use a larger value to make sure objects which cast shadows remain rendered even when they are out of view.")]
        public float plantDiameter = 1;
        [Tooltip("Object to spawn")]
        public GameObject plant;
        [Tooltip("LOD object to spawn")]
        public GameObject LODPlant;
        [Tooltip("The texture index to spawn the corresponding plant on. Set -1 to spawn everywhere. Up to 4 values are supported.")]
        public int[] textureIndexes;

        [Header("Settings")]
        [Tooltip("Set to true if you use unity's quad to render your grass, because it is centered in the middle of the mesh instead of at the base.")]
        public bool centeredMesh = false;
        [Tooltip("The X and Z size of the chunks. Y is determined as chunkSize * 4")]
        public int chunkSize = 20;
        [Tooltip("Maximum display range")]
        public int viewDistance = 50;
        [Tooltip("Distance at which LODs start")]
        public int LODViewDistance = 30;
        [Tooltip("Number of plants in a chunk length. 5 means 5x5 plants per chunk")]
        [Range(1, 300)]
        public int plantDensity = 5;
        [Tooltip("Display shadows for LOD0 objects ?")]
        public ShadowCastingMode LOD0ShadowCastingMode = ShadowCastingMode.On;
        [Tooltip("Display shadows for LOD1 objects ?")]
        public ShadowCastingMode LOD1ShadowCastingMode = ShadowCastingMode.On;
        [Tooltip("Receive shadows for LOD0 objects ?")]
        public bool receiveLOD0Shadows = true;
        [Tooltip("Receive shadows for LOD1 objects ?")]
        public bool receiveLOD1Shadows = true;


        // GPU items positioning
        private int instancesPerChunk;
        private int maxPositionsBufferInstances;
        private int LODmaxPositionsBufferInstances;
        private Mesh mesh;
        private Material[] mat;
        private Mesh LODmesh;
        private Material[] LODmat;
        private ComputeBuffer argsBuffer;
        private ComputeBuffer LODargsBuffer;
        private ComputeBuffer chunksBuffer;
        private ComputeBuffer LODchunksBuffer;
        private ComputeBuffer positionsBuffer;
        private ComputeBuffer LODpositionsBuffer;

        // GPU frustrum culling
        private int totalPlants;
        private int groups;
        private int LODtotalPlants;
        private int LODgroups;
        private ComputeBuffer batchItemsCountBuffer;
        private ComputeBuffer LODbatchItemsCountBuffer;
        private ComputeBuffer batchItemsCountAddedBuffer;
        private ComputeBuffer LODbatchItemsCountAddedBuffer;
        private ComputeBuffer culledPositionsBuffer;
        private ComputeBuffer LODculledPositionsBuffer;
        private ComputeBuffer batchCountersBuffer;
        private ComputeBuffer LODbatchCountersBuffer;

        // lists of chunks
        private List<int3> normalChunksList;
        private List<int3> LODChunksList;

        // variables to not recompute every frame if we stand still
        private Vector3 lastPosition;
        private Quaternion lastRotation;
        private FrustrumPlanes planes;


        private void UpdateAllVariables()
        {
            FreeContainers();

            normalChunksList = new List<int3>(1024);
            LODChunksList = new List<int3>(1024);

            mesh = plant.GetComponent<MeshFilter>().sharedMesh;
            LODmesh = LODPlant.GetComponent<MeshFilter>().sharedMesh;

            mat = plant.GetComponent<MeshRenderer>().sharedMaterials;
            LODmat = LODPlant.GetComponent<MeshRenderer>().sharedMaterials;

            // deep copy the materials
            for (int i = 0; i < mat.Length; i++)
                mat[i] = new Material(mat[i]);
            for (int i = 0; i < LODmat.Length; i++)
                LODmat[i] = new Material(LODmat[i]);

            if (chunkSize < 2)
                chunkSize = 2;

            if (viewDistance <= 0)
                viewDistance = 1;
            if (viewDistance > 1000)
                viewDistance = 1000;

            if (LODViewDistance <= 0)
                LODViewDistance = 1;
            if (LODViewDistance >= viewDistance)
                LODViewDistance = viewDistance - 1;

            if (textureIndexes.Length > 4)
            {
                var newTextureIndexes = new int[4];
                newTextureIndexes[0] = textureIndexes[0];
                newTextureIndexes[1] = textureIndexes[1];
                newTextureIndexes[2] = textureIndexes[2];
                newTextureIndexes[3] = textureIndexes[3];
                textureIndexes = newTextureIndexes;
            }

            instancesPerChunk = plantDensity * plantDensity;
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

            chunksBuffer?.Release();
            chunksBuffer = null;
            LODchunksBuffer?.Release();
            LODchunksBuffer = null;

            argsBuffer?.Release();
            argsBuffer = null;
            LODargsBuffer?.Release();
            LODargsBuffer = null;

            batchItemsCountBuffer?.Release();
            batchItemsCountBuffer = null;
            LODbatchItemsCountBuffer?.Release();
            LODbatchItemsCountBuffer = null;
            batchItemsCountAddedBuffer?.Release();
            batchItemsCountAddedBuffer = null;
            LODbatchItemsCountAddedBuffer?.Release();
            LODbatchItemsCountAddedBuffer = null;

            culledPositionsBuffer?.Release();
            culledPositionsBuffer = null;
            LODculledPositionsBuffer?.Release();
            LODculledPositionsBuffer = null;
            batchCountersBuffer?.Release();
            batchCountersBuffer = null;
            LODbatchCountersBuffer?.Release();
            LODbatchCountersBuffer = null;
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
                frustrumPlanes = planes,
                size1D = (int)VegetationManager.instance.terrainHeight.AABB.Max.x - (int)VegetationManager.instance.terrainHeight.AABB.Min.x,
                camPos = new int3((int)VegetationManager.instance.cam.transform.position.x, (int)VegetationManager.instance.cam.transform.position.y, (int)VegetationManager.instance.cam.transform.position.z),
                terrainPos = new int3((int)VegetationManager.instance.terrainHeight.AABB.Min.x, (int)VegetationManager.instance.terrainHeight.AABB.Min.y, (int)VegetationManager.instance.terrainHeight.AABB.Min.z),
                chunkSize = chunkSize,
                maxDisplacement = maxDisplacement,
                viewDistanceSq = viewDistance * viewDistance,
                LODviewDistanceSq = LODViewDistance * LODViewDistance,
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
            positionsComputeShader.SetVector("plane1", new float4(planes.p1.normal.x, planes.p1.normal.y, planes.p1.normal.z, planes.p1.distance));
            positionsComputeShader.SetVector("plane2", new float4(planes.p2.normal.x, planes.p2.normal.y, planes.p2.normal.z, planes.p2.distance));
            positionsComputeShader.SetVector("plane3", new float4(planes.p3.normal.x, planes.p3.normal.y, planes.p3.normal.z, planes.p3.distance));
            positionsComputeShader.SetVector("plane4", new float4(planes.p4.normal.x, planes.p4.normal.y, planes.p4.normal.z, planes.p4.distance));
            positionsComputeShader.SetVector("plane5", new float4(planes.p5.normal.x, planes.p5.normal.y, planes.p5.normal.z, planes.p5.distance));
            positionsComputeShader.SetVector("plane6", new float4(planes.p6.normal.x, planes.p6.normal.y, planes.p6.normal.z, planes.p6.distance));
            positionsComputeShader.SetFloat("objectRadius", plantDiameter);

            positionsComputeShader.SetFloat("randomSeed", seed);
            positionsComputeShader.SetFloat("D1Size", plantDensity);
            positionsComputeShader.SetFloat("chunkSize", chunkSize);
            positionsComputeShader.SetFloat("plantDistance", plantDensity);
            positionsComputeShader.SetFloat("maxSlope", maxSlope);
            positionsComputeShader.SetFloat("sizeChange", randomSize);
            positionsComputeShader.SetFloat("displacement", maxDisplacement);
            positionsComputeShader.SetFloat("falloff", falloff);
            positionsComputeShader.SetFloat("sizeBias", sizeBias);
            positionsComputeShader.SetFloat("ViewRangeSq", (viewDistance - chunkSize / 2) * (viewDistance - chunkSize / 2));
            positionsComputeShader.SetInt("centeredMesh", centeredMesh ? 1 : 0);
            positionsComputeShader.SetFloat("positionOffset", yPositionOffset);
            positionsComputeShader.SetFloat("maxHeight", maxHeight);
            positionsComputeShader.SetFloat("minHeight", minHeight);
            positionsComputeShader.SetInt("plantsPerChunk", instancesPerChunk);

            // only support up to 4 texture indexes
            if (textureIndexes.Length > 0)
                positionsComputeShader.SetInt("textureIndex1", textureIndexes[0]);
            else
                positionsComputeShader.SetInt("textureIndex1", -1);
            if (textureIndexes.Length > 1)
                positionsComputeShader.SetInt("textureIndex2", textureIndexes[1]);
            else
                positionsComputeShader.SetInt("textureIndex2", -1);
            if (textureIndexes.Length > 2)
                positionsComputeShader.SetInt("textureIndex3", textureIndexes[2]);
            else
                positionsComputeShader.SetInt("textureIndex3", -1);
            if (textureIndexes.Length > 3)
                positionsComputeShader.SetInt("textureIndex4", textureIndexes[3]);
            else
                positionsComputeShader.SetInt("textureIndex4", -1);

            // run compute shader for non LOD objects -----------------------------------------------------------
            totalPlants = instancesPerChunk * normalChunksList.Count;
            groups = Mathf.CeilToInt(totalPlants / 1024f);
            if (maxPositionsBufferInstances < totalPlants || positionsBuffer == null)
            {
                // output buffer for objects positions, only increase size if needed
                maxPositionsBufferInstances = totalPlants;

                positionsBuffer?.Release();
                positionsBuffer = null;
                if (totalPlants > 0)
                    positionsBuffer = new ComputeBuffer(totalPlants, 16 * sizeof(float) + 16 * sizeof(float) + 4 * sizeof(float));

                culledPositionsBuffer?.Release();
                culledPositionsBuffer = null;
                if (totalPlants > 0)
                    culledPositionsBuffer = new ComputeBuffer(totalPlants, 16 * sizeof(float) + 16 * sizeof(float) + 4 * sizeof(float));

                batchItemsCountBuffer?.Release();
                batchItemsCountBuffer = null;
                if (totalPlants > 0)
                    batchItemsCountBuffer = new ComputeBuffer(groups, sizeof(uint));
            }

            if (totalPlants != 0)
            {
                batchItemsCountBuffer.SetData(new uint[groups]);

                // readonly buffer containing chunks positions
                chunksBuffer?.Release();
                chunksBuffer = null;
                chunksBuffer = new ComputeBuffer(normalChunksList.Count, sizeof(int) * 3);
                chunksBuffer.SetData(normalChunksList.ToArray());

                positionsComputeShader.SetVector("camPos", new float4((int)VegetationManager.instance.cam.transform.position.x, (int)VegetationManager.instance.cam.transform.position.y, (int)VegetationManager.instance.cam.transform.position.z, 1f));
                positionsComputeShader.SetInt("positionsSize", totalPlants);
                positionsComputeShader.SetBuffer(0, "positions", positionsBuffer);
                positionsComputeShader.SetBuffer(0, "chunksPositions", chunksBuffer);
                positionsComputeShader.SetBuffer(0, "itemsPerBatch", batchItemsCountBuffer);

                positionsComputeShader.Dispatch(0, groups, 1, 1);
            }

            // run compute shader for LOD objects -----------------------------------------------------------
            LODtotalPlants = instancesPerChunk * LODChunksList.Count;
            LODgroups = Mathf.CeilToInt(LODtotalPlants / 1024f);
            if (LODmaxPositionsBufferInstances < LODtotalPlants || LODpositionsBuffer == null)
            {
                // output buffer for objects positions, only increase size if needed
                LODmaxPositionsBufferInstances = LODtotalPlants;

                LODpositionsBuffer?.Release();
                LODpositionsBuffer = null;
                if (LODtotalPlants > 0)
                    LODpositionsBuffer = new ComputeBuffer(LODtotalPlants, 16 * sizeof(float) + 16 * sizeof(float) + 4 * sizeof(float));

                LODculledPositionsBuffer?.Release();
                LODculledPositionsBuffer = null;
                if (LODtotalPlants > 0)
                    LODculledPositionsBuffer = new ComputeBuffer(LODtotalPlants, 16 * sizeof(float) + 16 * sizeof(float) + 4 * sizeof(float));

                LODbatchItemsCountBuffer?.Release();
                LODbatchItemsCountBuffer = null;
                if (LODtotalPlants > 0)
                    LODbatchItemsCountBuffer = new ComputeBuffer(LODgroups, sizeof(uint));
            }

            if (LODtotalPlants != 0)
            {
                LODbatchItemsCountBuffer.SetData(new uint[LODgroups]);

                // readonly buffer containing chunks positions
                LODchunksBuffer?.Release();
                LODchunksBuffer = null;
                LODchunksBuffer = new ComputeBuffer(LODChunksList.Count, sizeof(int) * 3);
                LODchunksBuffer.SetData(LODChunksList.ToArray());

                positionsComputeShader.SetVector("camPos", new float4((int)VegetationManager.instance.cam.transform.position.x, (int)VegetationManager.instance.cam.transform.position.y, (int)VegetationManager.instance.cam.transform.position.z, 1f));
                positionsComputeShader.SetInt("positionsSize", LODtotalPlants);
                positionsComputeShader.SetBuffer(0, "positions", LODpositionsBuffer);
                positionsComputeShader.SetBuffer(0, "chunksPositions", LODchunksBuffer);
                positionsComputeShader.SetBuffer(0, "itemsPerBatch", LODbatchItemsCountBuffer);

                positionsComputeShader.Dispatch(0, LODgroups, 1, 1);
            }
        }


        private void CullPositionsComputeShader()
        {
            // Items culling ---------------------------------------------------------------------------------------
            if (totalPlants != 0)
            {
                argsBuffer?.Release();
                argsBuffer = null;
                argsBuffer = new ComputeBuffer(1, 5 * sizeof(uint), ComputeBufferType.IndirectArguments);

                batchItemsCountAddedBuffer?.Release();
                batchItemsCountAddedBuffer = null;
                batchItemsCountAddedBuffer = new ComputeBuffer(groups, sizeof(uint));

                prepareCullingComputeShader.SetInt("batchSize", groups);
                prepareCullingComputeShader.SetInt("meshIndexCount", (int)mesh.GetIndexCount(0));
                prepareCullingComputeShader.SetInt("meshIndexStart", (int)mesh.GetIndexStart(0));
                prepareCullingComputeShader.SetInt("meshBaseVertex", (int)mesh.GetBaseVertex(0));
                prepareCullingComputeShader.SetBuffer(0, "itemsPerBatch", batchItemsCountBuffer);
                prepareCullingComputeShader.SetBuffer(0, "itemsPerBatchAdded", batchItemsCountAddedBuffer);
                prepareCullingComputeShader.SetBuffer(0, "argsBuffer", argsBuffer);
                prepareCullingComputeShader.Dispatch(0, 1, 1, 1);

                batchCountersBuffer?.Release();
                batchCountersBuffer = null;
                batchCountersBuffer = new ComputeBuffer(groups, sizeof(uint));
                batchCountersBuffer.SetData(new uint[groups]);

                cullingComputeShader.SetInt("positionsSize", totalPlants);
                cullingComputeShader.SetBuffer(0, "positions", positionsBuffer);
                cullingComputeShader.SetBuffer(0, "itemsPerBatch", batchItemsCountBuffer);
                cullingComputeShader.SetBuffer(0, "itemsPerBatchAdded", batchItemsCountAddedBuffer);
                cullingComputeShader.SetBuffer(0, "batchCounters", batchCountersBuffer);
                cullingComputeShader.SetBuffer(0, "newPositions", culledPositionsBuffer);

                cullingComputeShader.Dispatch(0, groups, 1, 1);
            }

            // LODs culling ---------------------------------------------------------------------------------------
            if (LODtotalPlants != 0)
            {
                LODargsBuffer?.Release();
                LODargsBuffer = null;
                LODargsBuffer = new ComputeBuffer(1, 5 * sizeof(uint), ComputeBufferType.IndirectArguments);

                LODbatchItemsCountAddedBuffer?.Release();
                LODbatchItemsCountAddedBuffer = null;
                LODbatchItemsCountAddedBuffer = new ComputeBuffer(LODgroups, sizeof(uint));

                prepareCullingComputeShader.SetInt("batchSize", LODgroups);
                prepareCullingComputeShader.SetInt("meshIndexCount", (int)LODmesh.GetIndexCount(0));
                prepareCullingComputeShader.SetInt("meshIndexStart", (int)LODmesh.GetIndexStart(0));
                prepareCullingComputeShader.SetInt("meshBaseVertex", (int)LODmesh.GetBaseVertex(0));
                prepareCullingComputeShader.SetBuffer(0, "itemsPerBatch", LODbatchItemsCountBuffer);
                prepareCullingComputeShader.SetBuffer(0, "itemsPerBatchAdded", LODbatchItemsCountAddedBuffer);
                prepareCullingComputeShader.SetBuffer(0, "argsBuffer", LODargsBuffer);
                prepareCullingComputeShader.Dispatch(0, 1, 1, 1);

                LODbatchCountersBuffer?.Release();
                LODbatchCountersBuffer = null;
                LODbatchCountersBuffer = new ComputeBuffer(LODgroups, sizeof(uint));
                LODbatchCountersBuffer.SetData(new uint[LODgroups]);

                cullingComputeShader.SetInt("positionsSize", LODtotalPlants);
                cullingComputeShader.SetBuffer(0, "positions", LODpositionsBuffer);
                cullingComputeShader.SetBuffer(0, "itemsPerBatch", LODbatchItemsCountBuffer);
                cullingComputeShader.SetBuffer(0, "itemsPerBatchAdded", LODbatchItemsCountAddedBuffer);
                cullingComputeShader.SetBuffer(0, "batchCounters", LODbatchCountersBuffer);
                cullingComputeShader.SetBuffer(0, "newPositions", LODculledPositionsBuffer);

                cullingComputeShader.Dispatch(0, LODgroups, 1, 1);
            }
        }


        private void Update()
        {
            if (!Application.isPlaying && !runInEditor)
                return;
            if (!Application.isPlaying && runInEditor)
                UpdateAllVariables();
            if (VegetationManager.instance == null || !VegetationManager.instance.ReadyToGo())
                return;

            // if we did not move, no need to recompute everything
            if (VegetationManager.instance.cam.transform.position != lastPosition || VegetationManager.instance.cam.transform.rotation != lastRotation || (!Application.isPlaying && runInEditor))
            {
                planes = new FrustrumPlanes(GeometryUtility.CalculateFrustumPlanes(VegetationManager.instance.cam));
                UpdateChunks();
                RunpositionsComputeShader();
                CullPositionsComputeShader();
            }
            lastPosition = VegetationManager.instance.cam.transform.position;
            lastRotation = VegetationManager.instance.cam.transform.rotation;

            // draw objects
            var bounds = new Bounds(VegetationManager.instance.cam.transform.position, Vector3.one * VegetationManager.instance.cam.farClipPlane);

            for (int i = 0; i < mat.Length; i++)
                mat[i].SetBuffer("GPUInstancedIndirectDataBuffer", culledPositionsBuffer);
            for (int i = 0; i < LODmat.Length; i++)
                LODmat[i].SetBuffer("GPUInstancedIndirectDataBuffer", LODculledPositionsBuffer);
            if (totalPlants != 0)
            {
                for (int i = 0; i < mat.Length; i++)
                    Graphics.DrawMeshInstancedIndirect(mesh, 0, mat[i], bounds, argsBuffer, 0, null, LOD0ShadowCastingMode, receiveLOD0Shadows);
            }
            if (LODtotalPlants != 0)
            {
                for (int i = 0; i < LODmat.Length; i++)
                    Graphics.DrawMeshInstancedIndirect(LODmesh, 0, LODmat[i], bounds, LODargsBuffer, 0, null, LOD1ShadowCastingMode, receiveLOD1Shadows);
            }
        }

#if UNITY_EDITOR
        private void OnDrawGizmos()
        {
            // display chunks
            if (displayChunks && normalChunksList != null)
            {
                Gizmos.color = Color.red;
                foreach (var e in normalChunksList)
                    Gizmos.DrawWireCube(new float3(e.x, e.y, e.z), new float3(chunkSize, 1, chunkSize));
                Gizmos.color = Color.yellow;
                foreach (var e in LODChunksList)
                    Gizmos.DrawWireCube(new float3(e.x, e.y, e.z), new float3(chunkSize, 1, chunkSize));
            }
        }
#endif
    }

    [Serializable]
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
}
