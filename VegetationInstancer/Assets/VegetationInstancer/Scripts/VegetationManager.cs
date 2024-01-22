using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.Serialization.Formatters.Binary;
using Unity.Collections;
using Unity.Mathematics;
using UnityEngine;

namespace Myrmecoman
{
    [ExecuteInEditMode]
    public class VegetationManager : MonoBehaviour
    {
        public static VegetationManager instance;

        [Header("Terrain")]
        [Tooltip("The terrains on which vegetation needs to be instanciated")]
        public Terrain[] terrains;
        [Tooltip("Reload terrain data and save it")]
        public bool reloadTerrainData = false;
        [Tooltip("Display the terrains mesh for debug")]
        public bool displayTerrainMesh = false;

        [Header("Common")]
        [Tooltip("Camera")]
        public Camera cam;

        // structs for vegetation and grass instantiation
        [HideInInspector] public TerrainHeight terrainHeight;
        [HideInInspector] public TerrainTextures terrainTex;

        // variables for heightmap
        [HideInInspector] public int heightResolution;
        [HideInInspector] public float2 sampleSize;
        [HideInInspector] public CustomAABB aabb;
        [HideInInspector] public NativeArray<float> heightmap;

        // variables for texturemap
        [HideInInspector] public int texResolution;
        [HideInInspector] public int textureCount;
        [HideInInspector] public int2 textureArraySize;
        [HideInInspector] public int2 terrainPos;
        [HideInInspector] public float2 terrainSize;
        [HideInInspector] public NativeArray<float> textureMap;

        private ComputeBuffer heightBuffer;
        private ComputeBuffer texBuffer;
        private bool loadedTerrainData = false;


        private void Awake()
        {
            // make this a singleton
            if (instance == null)
            {
                instance = this;
                if (!SaveSystemInstancer.FileExists())
                    ReloadTerrains();
                loadedTerrainData = LoadTerrains();
            }
            else
            {
                Destroy(gameObject);
            }
        }


        private void Update()
        {
            if (!loadedTerrainData)
                loadedTerrainData = LoadTerrains();
            if ((!reloadTerrainData || Application.isPlaying) && instance != null)
                return;

            if (instance == null)
                instance = this;

            reloadTerrainData = false;
            ReloadTerrains();
            loadedTerrainData = LoadTerrains();
        }


        private void OnDestroy()
        {
            heightBuffer?.Release();
            heightBuffer = null;
            texBuffer?.Release();
            texBuffer = null;

            if (terrainHeight.heightMap != null && terrainHeight.heightMap.IsCreated)
                terrainHeight.Dispose();
            if (terrainTex.textureMapAllTextures != null && terrainTex.textureMapAllTextures.IsCreated)
                terrainTex.Dispose();

            if (heightmap.IsCreated)
                heightmap.Dispose();
            if (textureMap.IsCreated)
                textureMap.Dispose();
        }


        private bool LoadTerrains()
        {
            // load data
            var data = SaveSystemInstancer.LoadData();
            if (data == null) // means there is no save
            {
                Debug.LogWarning("Terrain data was not loaded. If you did not have a Resources folder, simply wait for it to appear (this can take up to a minute).");
                return false;
            }

            OnDestroy();

            terrainHeight = new TerrainHeight(new NativeArray<float>(data.heightmap, Allocator.Persistent), data.heightResolution, data.sampleSize, data.aabb);
            terrainTex = new TerrainTextures(new NativeArray<float>(data.textureMap, Allocator.Persistent), data.texResolution, data.textureCount, data.textureArraySize, data.terrainPos, data.terrainSize);

            heightBuffer = new ComputeBuffer(terrainHeight.heightMap.Length, sizeof(float));
            heightBuffer.SetData(terrainHeight.heightMap.ToArray());
            Shader.SetGlobalBuffer("heightMap", heightBuffer);
            Shader.SetGlobalInteger("resolution", terrainHeight.resolution);
            Shader.SetGlobalVector("sampleSize", new float4(terrainHeight.sampleSize.x, terrainHeight.sampleSize.y, 0, 0));
            Shader.SetGlobalVector("AABBMin", new float4(terrainHeight.AABB.Min.x, terrainHeight.AABB.Min.y, terrainHeight.AABB.Min.z, 0));
            Shader.SetGlobalVector("AABBMax", new float4(terrainHeight.AABB.Max.x, terrainHeight.AABB.Max.y, terrainHeight.AABB.Max.z, 0));

            texBuffer = new ComputeBuffer(terrainTex.textureMapAllTextures.Length, sizeof(float));
            texBuffer.SetData(terrainTex.textureMapAllTextures.ToArray());
            Shader.SetGlobalBuffer("textureMapAllTextures", texBuffer);
            Shader.SetGlobalInteger("terrainPosX", terrainTex.terrainPos.x);
            Shader.SetGlobalInteger("terrainPosY", terrainTex.terrainPos.y);
            Shader.SetGlobalFloat("terrainSizeX", terrainTex.terrainSize.x);
            Shader.SetGlobalFloat("terrainSizeY", terrainTex.terrainSize.y);
            Shader.SetGlobalInteger("textureArraySizeX", terrainTex.textureArraySize.x);
            Shader.SetGlobalInteger("textureArraySizeY", terrainTex.textureArraySize.y);
            Shader.SetGlobalInteger("resolutionTex", terrainTex.resolution);
            Shader.SetGlobalInteger("textureCount", terrainTex.textureCount);

            data.heightmap = null;  // let the garbage collector free the memory
            data.textureMap = null; // let the garbage collector free the memory

            Debug.Log("Terrains data loaded");
            return true;
        }


        // check that terrains are disposed as a square
        private Terrain[] CheckSquare(out int D1Size)
        {
            // check that we have a meaningfull number of terrains
            int terrainsNb = terrains.Length;
            int found = 0;
            for (int i = terrainsNb; i > 0; i--)
            {
                if (i * i == terrainsNb)
                {
                    found = i;
                    break;
                }
            }
            if (found == 0)
            {
                Debug.LogError("Terrains do not form a square");
                D1Size = 0;
                return null;
            }
            D1Size = found;

            // order terrain by X then by Z
            List<Terrain> terrainsList = new(terrains);
            terrainsList = terrainsList.OrderBy(a => a.transform.position.x).ThenBy(b => b.transform.position.z).ToList();

            // get first line length
            Dictionary<int, bool> xAxis = new();
            Dictionary<int, bool> zAxis = new();
            for (int i = 1; i < terrainsList.Count; i++)
            {
                if (!xAxis.ContainsKey((int)terrainsList[i].transform.position.x))
                    xAxis.Add((int)terrainsList[i].transform.position.x, true);
                if (!zAxis.ContainsKey((int)terrainsList[i].transform.position.z))
                    zAxis.Add((int)terrainsList[i].transform.position.z, true);
            }

            if (xAxis.Count != zAxis.Count)
            {
                Debug.LogError("Terrain chunks are not square");
                return null;
            }

            return terrainsList.ToArray();
        }


        // check that terrains share identical parameters
        private bool CheckSameParameters(Terrain[] terrainsArray)
        {
            int heightmapRes = terrainsArray[0].terrainData.heightmapResolution;
            float2 sampleSize = new float2(terrainsArray[0].terrainData.heightmapScale.x, terrainsArray[0].terrainData.heightmapScale.z);
            int2 textureArraySize = new int2(terrainsArray[0].terrainData.alphamapWidth, terrainsArray[0].terrainData.alphamapHeight);
            float2 terrainSize = new float2(terrainsArray[0].terrainData.size.x, terrainsArray[0].terrainData.size.z);
            int textureCount = terrainsArray[0].terrainData.alphamapLayers;
            int height = (int)terrainsArray[0].transform.position.y;

            for (int i = 1; i < terrainsArray.Length; i++)
            {
                int heightmapResTemp = terrainsArray[i].terrainData.heightmapResolution;
                float2 sampleSizeTemp = new float2(terrainsArray[i].terrainData.heightmapScale.x, terrainsArray[i].terrainData.heightmapScale.z);
                int2 textureArraySizeTemp = new int2(terrainsArray[i].terrainData.alphamapWidth, terrainsArray[i].terrainData.alphamapHeight);
                float2 terrainSizeTemp = new float2(terrainsArray[i].terrainData.size.x, terrainsArray[i].terrainData.size.z);
                int textureCountTemp = terrainsArray[i].terrainData.alphamapLayers;
                int heightTemp = (int)terrainsArray[i].transform.position.y;

                if (heightmapRes != heightmapResTemp)
                {
                    Debug.LogError("Terrains have different heightmap resolutions");
                    return false;
                }
                if (sampleSize.x != sampleSizeTemp.x || sampleSize.y != sampleSizeTemp.y)
                {
                    Debug.LogError("Terrains have different sample sizes");
                    return false;
                }
                if (textureArraySize.x != textureArraySizeTemp.x || textureArraySize.y != textureArraySizeTemp.y)
                {
                    Debug.LogError("Terrains have different texture array sizes");
                    return false;
                }
                if (terrainSize.x != terrainSizeTemp.x || terrainSize.y != terrainSizeTemp.y)
                {
                    Debug.LogError("Terrains have different sizes");
                    return false;
                }
                if (textureCount != textureCountTemp)
                {
                    Debug.LogError("Terrains have different number of textures : one has " + textureCount + " while another has " + textureCountTemp);
                    return false;
                }
                if (height != heightTemp)
                {
                    Debug.LogError("Terrains don't have the same height position");
                    return false;
                }
            }

            return true;
        }


        private CustomAABB GetTerrainAABB(Terrain[] terrainsArray, int D1Size)
        {
            float3 pos = terrainsArray[0].transform.position;
            float3 size = new float3(terrainsArray[0].terrainData.size.x * D1Size, terrainsArray[0].terrainData.size.y, terrainsArray[0].terrainData.size.z * D1Size);
            for (int i = 1; i < terrainsArray.Length; i++)
            {
                if (terrainsArray[i].transform.position.x < pos.x)
                    pos.x = terrainsArray[i].transform.position.x;
                if (terrainsArray[i].transform.position.y < pos.y)
                    pos.y = terrainsArray[i].transform.position.y;
                if (terrainsArray[i].transform.position.z < pos.z)
                    pos.z = terrainsArray[i].transform.position.z;
            }

            float3 min = pos;
            float3 max = min + size;
            return new CustomAABB(min, max);
        }


        // return a merged heightmap for all terrains
        private NativeArray<float> BuildNewHeightMap(Terrain[] terrainsArray, int D1Size)
        {
            heightResolution = terrainsArray[0].terrainData.heightmapResolution * D1Size - (D1Size - 1);
            sampleSize = new float2(terrainsArray[0].terrainData.heightmapScale.x, terrainsArray[0].terrainData.heightmapScale.z);

            int resolutionSingle = terrainsArray[0].terrainData.heightmapResolution;
            var heightList = new NativeArray<float>(heightResolution * heightResolution, Allocator.Persistent);

            // get heightmap of each terrain
            List<float[,]> maps = new();
            for (int i = 0; i < terrainsArray.Length; i++)
                maps.Add(terrainsArray[i].terrainData.GetHeights(0, 0, resolutionSingle, resolutionSingle));

            // generate flattened array
            for (int y = 0; y < heightResolution - 1; y++)
            {
                int res = resolutionSingle - 1;
                int arrY = y / res;
                for (int x = 0; x < heightResolution - 1; x++)
                {
                    int arrX = x / res;
                    heightList[y * heightResolution + x] = maps[arrX + D1Size * arrY][x % res, y % res];
                }
            }

            return heightList;
        }


        // return a merged texture map for all terrains
        private NativeArray<float> BuildNewTextureMap(Terrain[] terrainsArray, int D1Size)
        {
            int texResolutionSingle = terrainsArray[0].terrainData.alphamapWidth;
            texResolution = terrainsArray[0].terrainData.alphamapWidth * D1Size;
            textureCount = terrainsArray[0].terrainData.alphamapLayers;
            textureArraySize = new int2(terrainsArray[0].terrainData.alphamapWidth * D1Size, terrainsArray[0].terrainData.alphamapHeight * D1Size);
            terrainPos = new int2((int)aabb.Min.x, (int)aabb.Min.z);
            terrainSize = new float2(terrainsArray[0].terrainData.size.x * D1Size, terrainsArray[0].terrainData.size.z * D1Size);

            List<float[,,]> maps = new();
            for (int i = 0; i < terrainsArray.Length; i++)
                maps.Add(terrainsArray[i].terrainData.GetAlphamaps(0, 0, terrainsArray[0].terrainData.alphamapWidth, terrainsArray[0].terrainData.alphamapHeight));

            // merge row by row
            var textureArray = new NativeArray<float>(texResolution * texResolution * textureCount, Allocator.Persistent);
            for (int y = 0; y < texResolution; y++)
            {
                int arrY = y / texResolutionSingle;
                for (int x = 0; x < texResolution; x++)
                {
                    int arrX = x / texResolutionSingle;
                    for (int z = 0; z < textureCount; z++)
                        textureArray[y + (x * texResolution) + (z * texResolution * texResolution)] = maps[arrX + D1Size * arrY][x % texResolutionSingle, y % texResolutionSingle, z];
                }
            }

            return textureArray;
        }


        private void ReloadTerrains()
        {
            Debug.Log("Reloading terrains data : starting...");

            if (terrains == null || terrains.Length == 0)
            {
                Debug.LogError("No terrain provided");
                return;
            }

            int D1Size;
            var terrainsOrdered = CheckSquare(out D1Size);
            if (terrainsOrdered == null)
            {
                Debug.LogError("Terrain order error");
                return;
            }

            if (!CheckSameParameters(terrainsOrdered))
            {
                Debug.LogError("Terrains don't have the same parameters");
                return;
            }

            aabb = GetTerrainAABB(terrainsOrdered, D1Size);
            heightmap = BuildNewHeightMap(terrainsOrdered, D1Size);
            textureMap = BuildNewTextureMap(terrainsOrdered, D1Size);

            SaveSystemInstancer.SaveData();
        }


        public bool ReadyToGo()
        {
            return heightBuffer != null &&
                texBuffer != null &&
                terrainHeight.heightMap != null && terrainHeight.heightMap.IsCreated &&
                terrainTex.textureMapAllTextures != null && terrainTex.textureMapAllTextures.IsCreated;
        }


#if UNITY_EDITOR
        private void OnDrawGizmos()
        {
            // display terrains combined mesh
            if (displayTerrainMesh && terrainHeight.IsValid)
            {
                Gizmos.color = Color.cyan;
                Vector3 camPos = cam.transform.position;
                for (int i = (int)camPos.x - 100; i < (int)camPos.x + 100; i++)
                {
                    for (int j = (int)camPos.z - 100; j < (int)camPos.z + 100; j++)
                    {
                        terrainHeight.GetTriAtPosition(new float2(i, j), out Triangle tri);
                        Gizmos.DrawLine(tri.V0, tri.V1);
                        Gizmos.DrawLine(tri.V1, tri.V2);
                    }
                }
            }
        }
#endif
    }


    [Serializable]
    public class InstancerData
    {
        public int heightResolution;
        public float2 sampleSize;
        public CustomAABB aabb;
        public float[] heightmap;

        public int texResolution;
        public int textureCount;
        public int2 textureArraySize;
        public int2 terrainPos;
        public float2 terrainSize;
        public float[] textureMap;


        public InstancerData()
        {
            heightResolution = VegetationManager.instance.heightResolution;
            sampleSize = VegetationManager.instance.sampleSize;
            aabb = VegetationManager.instance.aabb;
            heightmap = VegetationManager.instance.heightmap.ToArray();

            texResolution = VegetationManager.instance.texResolution;
            textureCount = VegetationManager.instance.textureCount;
            textureArraySize = VegetationManager.instance.textureArraySize;
            terrainPos = VegetationManager.instance.terrainPos;
            terrainSize = VegetationManager.instance.terrainSize;
            textureMap = VegetationManager.instance.textureMap.ToArray();
        }
    }


    public class SaveSystemInstancer
    {
        public static void SaveData()
        {
            if (!Directory.Exists(Application.dataPath + "/Resources/"))
                Directory.CreateDirectory(Application.dataPath + "/Resources/");

            string path = Application.dataPath + "/Resources/vegetationInstancerSave.bytes";
            using (Stream stream = File.Open(path, FileMode.Create))
            {
                new BinaryFormatter().Serialize(stream, new InstancerData());
            }
        }


        public static InstancerData LoadData()
        {
            TextAsset dataFile = Resources.Load("vegetationInstancerSave") as TextAsset;
            if (dataFile == null)
                return null;
            using (var stream = new MemoryStream(dataFile.bytes))
            {
                return (InstancerData)new BinaryFormatter().Deserialize(stream);
            }
        }


        public static bool FileExists()
        {
            if (!Directory.Exists(Application.dataPath + "/Resources/"))
                return false;
            TextAsset dataFile = Resources.Load("vegetationInstancerSave") as TextAsset;
            if (dataFile == null)
                return false;
            return true;
        }
    }
}
