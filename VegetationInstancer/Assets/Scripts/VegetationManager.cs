using System;
using System.Collections.Generic;
using System.IO;
using System.Runtime.Serialization.Formatters.Binary;
using Unity.Mathematics;
using UnityEngine;


[ExecuteInEditMode]
public class VegetationManager : MonoBehaviour
{
    public static VegetationManager instance;

    [Header("Terrain")]
    [Tooltip("The terrains on which vegetation needs to be instanciated")]
    public Terrain[] terrains;
    [Tooltip("Reload terrain data and save it")]
    public bool reloadTerrainData = false;

    [Header("Common")]
    [Tooltip("Camera")]
    public Camera cam;

    // structs for vegetation and grass instantiation
    [HideInInspector] public TerrainHeight terrainHeight;
    [HideInInspector] public TerrainTextures terrainTex;

    // variables for heightmap
    [HideInInspector] public int HeightResolution;
    [HideInInspector] public float2 sampleSize;
    [HideInInspector] public AABB aabb;
    [HideInInspector] public float[] heightmap;

    // variables for texturemap
    [HideInInspector] public int texResolution;
    [HideInInspector] public int textureCount;
    [HideInInspector] public int2 textureArraySize;
    [HideInInspector] public int2 terrainPos;
    [HideInInspector] public float2 terrainSize;
    [HideInInspector] public float[] textureMap;

    private ComputeBuffer heightBuffer;
    private ComputeBuffer texBuffer;


    private void Awake()
    {
        // make this a singleton
        if (instance == null)
        {
            instance = this;
            LoadTerrains();
        }
        else
            Destroy(gameObject);
    }


    private void Update()
    {
        if ((!reloadTerrainData || Application.isPlaying) && instance != null)
            return;

        if (instance == null)
            instance = this;

        reloadTerrainData = false;
        ReloadTerrains();
        LoadTerrains();
    }


    private void OnDestroy()
    {
        if (instance == null)
            return;

        if (instance.terrainHeight.heightMap != null && instance.terrainHeight.heightMap.IsCreated)
            instance.terrainHeight.Dispose();
        if (instance.terrainTex.textureMap != null && instance.terrainTex.textureMap.IsCreated)
            instance.terrainTex.Dispose();

        heightBuffer?.Release();
        heightBuffer = null;
        texBuffer?.Release();
        texBuffer = null;
    }


    private void LoadTerrains()
    {
        // load data
        var data = SaveSystemInstancer.LoadData();
        if (data == null) // means there is no save
            return;

        if (instance.terrainHeight.heightMap != null && instance.terrainHeight.heightMap.IsCreated)
            instance.terrainHeight.Dispose();
        if (instance.terrainTex.textureMap != null && instance.terrainTex.textureMap.IsCreated)
            instance.terrainTex.Dispose();

        instance.terrainHeight = new TerrainHeight(data.heightmap, data.HeightResolution, data.sampleSize, data.aabb);
        instance.terrainTex = new TerrainTextures(data.textureMap, data.texResolution, data.textureCount, data.textureArraySize, data.terrainPos, data.terrainSize);

        heightBuffer = new ComputeBuffer(instance.terrainHeight.heightMap.Length, sizeof(float));
        heightBuffer.SetData(instance.terrainHeight.heightMap.ToArray());
        Shader.SetGlobalBuffer("heightMap", heightBuffer);
        Shader.SetGlobalInteger("resolution", instance.terrainHeight.resolution);
        Shader.SetGlobalVector("sampleSize", new Vector4(instance.terrainHeight.sampleSize.x, instance.terrainHeight.sampleSize.y, 0, 0));
        Shader.SetGlobalVector("AABBMin", new Vector4(instance.terrainHeight.AABB.Min.x, instance.terrainHeight.AABB.Min.y, instance.terrainHeight.AABB.Min.z, 0));
        Shader.SetGlobalVector("AABBMax", new Vector4(instance.terrainHeight.AABB.Max.x, instance.terrainHeight.AABB.Max.y, instance.terrainHeight.AABB.Max.z, 0));

        texBuffer = new ComputeBuffer(instance.terrainTex.textureMapAllTextures.Length, sizeof(float));
        texBuffer.SetData(instance.terrainTex.textureMapAllTextures.ToArray());
        Shader.SetGlobalBuffer("textureMapAllTextures", texBuffer);
        Shader.SetGlobalInteger("terrainPosX", instance.terrainTex.terrainPos.x);
        Shader.SetGlobalInteger("terrainPosY", instance.terrainTex.terrainPos.y);
        Shader.SetGlobalFloat("terrainSizeX", instance.terrainTex.terrainSize.x);
        Shader.SetGlobalFloat("terrainSizeY", instance.terrainTex.terrainSize.y);
        Shader.SetGlobalInteger("textureArraySizeX", instance.terrainTex.textureArraySize.x);
        Shader.SetGlobalInteger("textureArraySizeY", instance.terrainTex.textureArraySize.y);
        Shader.SetGlobalInteger("resolutionTex", instance.terrainTex.resolution);
        Shader.SetGlobalInteger("textureCount", instance.terrainTex.textureCount);

        Debug.Log("Terrains data loaded");
    }


    // check that terrains are disposed as a square
    private Terrain[] CheckSquare(out int D1Size)
    {
        // order terrain by X then by Z
        List<Terrain> terrainsList = new List<Terrain>(terrains);
        List<Terrain> newterrainsList = new List<Terrain>();
        while(terrainsList.Count > 0)
        {
            int minX = (int)terrainsList[0].GetPosition().x;
            int minZ = (int)terrainsList[0].GetPosition().z;
            int savedIndex = 0;
            for (int i = 1; i < terrainsList.Count; i++)
            {
                if (terrainsList[i].GetPosition().x <= minX && terrainsList[i].GetPosition().z <= minZ)
                {
                    minX = (int)terrainsList[i].GetPosition().x;
                    minZ = (int)terrainsList[i].GetPosition().z;
                    savedIndex = i;
                }
            }
            newterrainsList.Add(terrainsList[savedIndex]);
            terrainsList.RemoveAt(savedIndex);
        }
        
        // get first line length
        Dictionary<int, bool> xAxis = new Dictionary<int, bool>();
        Dictionary<int, bool> zAxis = new Dictionary<int, bool>();
        for (int i = 1; i < newterrainsList.Count; i++)
        {
            if (!xAxis.ContainsKey((int)newterrainsList[i].transform.position.x))
                xAxis.Add((int)newterrainsList[i].transform.position.x, true);
            if (!zAxis.ContainsKey((int)newterrainsList[i].transform.position.z))
                zAxis.Add((int)newterrainsList[i].transform.position.z, true);
        }

        D1Size = xAxis.Count;
        if (xAxis.Count != zAxis.Count)
        {
            Debug.LogError("Terrain chunks are not square");
            return null;
        }

        return newterrainsList.ToArray();
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
                Debug.LogError("Terrains have different number of textures");
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


    private AABB GetTerrainAABB(Terrain[] terrainsArray, int D1Size)
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
        float3 extents = (max - min) / 2f;
        return new AABB() { Center = min + extents, Extents = extents };
    }


    // return a merged heightmap for all terrains
    private float[] BuildNewHeightMap(Terrain[] terrainsArray, int D1Size)
    {
        HeightResolution = terrainsArray[0].terrainData.heightmapResolution * D1Size;
        sampleSize = new float2(terrainsArray[0].terrainData.heightmapScale.x, terrainsArray[0].terrainData.heightmapScale.z);

        int resolutionSingle = terrainsArray[0].terrainData.heightmapResolution;
        var heightList = new float[HeightResolution * HeightResolution];
        float[,] arr = new float[HeightResolution, HeightResolution];

        List<float[,]> maps = new List<float[,]>();
        for(int i = 0; i < terrainsArray.Length; i++)
            maps.Add(terrainsArray[i].terrainData.GetHeights(0, 0, resolutionSingle, resolutionSingle));
        // merge row by row
        for (int y = 0; y < HeightResolution; y++)
        {
            int arrY = y / resolutionSingle;
            for (int x = 0; x < HeightResolution; x++)
            {
                int arrX = x / resolutionSingle;
                arr[x, y] = maps[arrX + D1Size * arrY][x % resolutionSingle, y % resolutionSingle];
            }
        }

        // flatten the array
        for (int y = 0; y < HeightResolution; y++)
        {
            for (int x = 0; x < HeightResolution; x++)
                heightList[x * HeightResolution + y] = arr[y, x];
        }

        return heightList;
    }


    // return a merged texture map for all terrains
    private float[] BuildNewTextureMap(Terrain[] terrainsArray, int D1Size)
    {
        int texResolutionSingle = terrainsArray[0].terrainData.alphamapWidth;
        texResolution = terrainsArray[0].terrainData.alphamapWidth * D1Size;
        textureCount = terrainsArray[0].terrainData.alphamapLayers;
        textureArraySize = new int2(terrainsArray[0].terrainData.alphamapWidth * D1Size, terrainsArray[0].terrainData.alphamapHeight * D1Size);
        float2 pos = new float2(0, 0);
        for (int i = 0; i < terrainsArray.Length; i++)
        {
            if (terrainsArray[i].transform.position.x < pos.x)
                pos.x = terrainsArray[i].transform.position.x;
            if (terrainsArray[i].transform.position.z < pos.y)
                pos.y = terrainsArray[i].transform.position.z;
        }
        terrainPos = new int2((int)pos.x, (int)pos.y);
        terrainSize = new float2(terrainsArray[0].terrainData.size.x * D1Size, terrainsArray[0].terrainData.size.z * D1Size);
        float[,,] arr = new float[texResolution, texResolution, textureCount];

        int resolutionX = terrainsArray[0].terrainData.alphamapWidth * D1Size;
        int resolutionY = terrainsArray[0].terrainData.alphamapHeight * D1Size;
        List<float[,,]> maps = new List<float[,,]>();
        for (int i = 0; i < terrainsArray.Length; i++)
            maps.Add(terrainsArray[i].terrainData.GetAlphamaps(0, 0, terrainsArray[0].terrainData.alphamapWidth, terrainsArray[0].terrainData.alphamapHeight));

        // merge row by row
        for (int y = 0; y < texResolution; y++)
        {
            int arrY = y / texResolutionSingle;
            for (int x = 0; x < texResolution; x++)
            {
                int arrX = x / texResolutionSingle;
                for (int z = 0; z < textureCount; z++)
                    arr[x, y, z] = maps[arrX + D1Size * arrY][x % texResolutionSingle, y % texResolutionSingle, z];
            }
        }

        var textureArray = new float[texResolution * texResolution * textureCount];

        // flatten
        for (int x = 0; x < resolutionX; x++)
        {
            for (int y = 0; y < resolutionY; y++)
            {
                for (int z = 0; z < textureCount; z++)
                    textureArray[x + resolutionX * (y + textureCount * z)] = arr[y, x, z];
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
            return;

        if (!CheckSameParameters(terrainsOrdered))
            return;

        aabb = GetTerrainAABB(terrainsOrdered, D1Size);
        heightmap = BuildNewHeightMap(terrainsOrdered, D1Size);
        textureMap = BuildNewTextureMap(terrainsOrdered, D1Size);

        SaveSystemInstancer.SaveData();
    }
}


[Serializable]
public class InstancerData
{
    public int HeightResolution;
    public float2 sampleSize;
    public AABB aabb;
    public float[] heightmap;

    public int texResolution;
    public int textureCount;
    public int2 textureArraySize;
    public int2 terrainPos;
    public float2 terrainSize;
    public float[] textureMap;


    public InstancerData()
    {
        HeightResolution = VegetationManager.instance.HeightResolution;
        sampleSize = VegetationManager.instance.sampleSize;
        aabb = VegetationManager.instance.aabb;
        heightmap = VegetationManager.instance.heightmap;

        texResolution = VegetationManager.instance.texResolution;
        textureCount = VegetationManager.instance.textureCount;
        textureArraySize = VegetationManager.instance.textureArraySize;
        terrainPos = VegetationManager.instance.terrainPos;
        terrainSize = VegetationManager.instance.terrainSize;
        textureMap = VegetationManager.instance.textureMap;
    }
}


public class SaveSystemInstancer
{
    public static void SaveData()
    {
        BinaryFormatter formatter = new BinaryFormatter();
        string path = Application.persistentDataPath + "/save.veg";
        FileStream stream = new FileStream(path, FileMode.Create);

        var data = new InstancerData();

        formatter.Serialize(stream, data);
        stream.Close();
    }


    public static InstancerData LoadData()
    {
        string path = Application.persistentDataPath + "/save.veg";
        if (File.Exists(path))
        {
            BinaryFormatter formatter = new BinaryFormatter();
            FileStream stream = new FileStream(path, FileMode.Open);

            var data = formatter.Deserialize(stream) as InstancerData;
            stream.Close();
            return data;
        }
        else
        {
            Debug.Log("No save yet");
            return null;
        }
    }


    public static void DeleteData()
    {
        string path = Application.persistentDataPath + "/save.veg";
        if (File.Exists(path))
            File.Delete(path);
    }
}
