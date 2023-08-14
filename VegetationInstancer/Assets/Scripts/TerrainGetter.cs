using System.Collections.Generic;
using Unity.Collections;
using Unity.Entities.UniversalDelegates;
using Unity.Mathematics;
using UnityEngine;


[ExecuteInEditMode]
public class TerrainGetter : MonoBehaviour
{
    public Terrain[] terrains;
    public bool reloadTerrainData = false;


    private void Update()
    {
        if (!reloadTerrainData)
            return;

        reloadTerrainData = false;
        ReloadTerrains();
    }


    // check that terrains are disposed as a square
    private Terrain[] CheckSquare(out int D1Size)
    {
        // order terrain by X then by Z
        List<Terrain> terrainsList = new List<Terrain>(terrains);
        List<Terrain> newterrainsList = new List<Terrain>();
        while(terrainsList.Count > 0)
        {
            int minX = -100000;
            int minZ = -100000;
            int savedIndex = 0;
            for (int i = 0; i < terrainsList.Count; i++)
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
        int firstD1Size = 1;
        int lastZ = (int)newterrainsList[0].GetPosition().z;
        for (int i = 1; i < newterrainsList.Count; i++)
        {
            if ((int)newterrainsList[i].GetPosition().z == lastZ)
                firstD1Size++;
            else
                break;
        }

        // check that all lines have the same length
        int D2Size = 1;
        D1Size = 1;
        for (int i = 1; i < newterrainsList.Count; i++)
        {
            if ((int)newterrainsList[i].GetPosition().z == lastZ)
                D1Size++;
            else
            {
                if (D1Size != firstD1Size)
                {
                    Debug.Log(D1Size + " " + firstD1Size);
                    Debug.LogError("Terrain chunks are not square");
                    return null;
                }
                lastZ = (int)newterrainsList[i].GetPosition().z;
                D1Size = 0;
                D2Size++;
            }
        }

        if (firstD1Size != D2Size)
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

        for(int i = 1; i < terrainsArray.Length; i++)
        {
            int heightmapResTemp = terrainsArray[i].terrainData.heightmapResolution;
            float2 sampleSizeTemp = new float2(terrainsArray[i].terrainData.heightmapScale.x, terrainsArray[i].terrainData.heightmapScale.z);
            int2 textureArraySizeTemp = new int2(terrainsArray[i].terrainData.alphamapWidth, terrainsArray[i].terrainData.alphamapHeight);
            float2 terrainSizeTemp = new float2(terrainsArray[i].terrainData.size.x, terrainsArray[i].terrainData.size.z);
            int textureCountTemp = terrainsArray[i].terrainData.alphamapLayers;

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
        }

        return true;
    }


    // return a merged heightmap for all terrains
    private NativeArray<float> BuildNewHeightMap(Terrain[] terrainsArray, int D1Size)
    {
        int resolution = terrainsArray[0].terrainData.heightmapResolution;
        var heightList = new NativeArray<float>(resolution * D1Size * resolution * D1Size, Allocator.Persistent, NativeArrayOptions.UninitializedMemory);

        List<float[,]> maps = new List<float[,]>();
        for(int i = 0; i < terrainsArray.Length; i++)
            maps.Add(terrainsArray[i].terrainData.GetHeights(0, 0, resolution, resolution));

        // TODO : merge row by row
        /*
        for (int y = 0; y < resolution; y++)
        {
            for (int x = 0; x < resolution; x++)
                heightList[x * resolution + y] = map[y, x];
        }
        */
        return heightList;
    }


    // return a merged texture map for all terrains
    private NativeArray<float> BuildNewTextureMap(Terrain[] terrainsArray, int D1Size)
    {
        // TODO
        return new NativeArray<float>(1, Allocator.Persistent, NativeArrayOptions.UninitializedMemory);
    }


    private void ReloadTerrains()
    {
        Debug.Log("Reloading terrains data");

        int D1Size;
        var terrainsOrdered = CheckSquare(out D1Size);
        if (terrainsOrdered == null)
            return;

        if (!CheckSameParameters(terrainsOrdered))
            return;


    }
}
