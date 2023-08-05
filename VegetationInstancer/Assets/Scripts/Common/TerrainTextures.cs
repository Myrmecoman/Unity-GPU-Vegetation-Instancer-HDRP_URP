using Unity.Collections;
using Unity.Mathematics;
using UnityEngine;


// https://github.com/JimmyCushnie/JimmysUnityUtilities/blob/master/Scripts/TerrainTextureDetector.cs
// This struct is used to find the most dominant texture index at a world position on the terrain in a fast way.


public struct TerrainTextures
{
    public NativeArray<int> textureMap; // texture map is the array of most important textures at each index
    public NativeArray<float> textureMapAllTextures; // texture map all textures is the array of all textures, usefull for falloff
    public int resolution;
    public int textureCount;
    public int2 textureArraySize;
    public int2 terrainPos;
    public float2 terrainSize;


    public TerrainTextures(Terrain terrain, Allocator alloc)
    {
        resolution = terrain.terrainData.alphamapWidth;
        textureArraySize = new int2(terrain.terrainData.alphamapWidth, terrain.terrainData.alphamapHeight);
        terrainPos = new int2((int)terrain.transform.position.x, (int)terrain.transform.position.z);
        terrainSize = new float2(terrain.terrainData.size.x, terrain.terrainData.size.z);
        textureCount = terrain.terrainData.alphamapLayers;
        textureMap = GetTextureMap(terrain, alloc);
        textureMapAllTextures = GetTextureMapAllTextures(terrain, alloc);
    }


    /*
    public int GetTextureAtPos(float2 worldPos)
    {
        // terrains cannot be rotated, so we don't have to worry about rotation
        float2 relativePosition = worldPos - new float2(terrainPos.x, terrainPos.y);
        var pos = new int2
        (
            (int)math.round((relativePosition.x / terrainSize.x) * textureArraySize.x),
            (int)math.round((relativePosition.y / terrainSize.y) * textureArraySize.y)
        );

        if (pos.x > textureArraySize.x)
            pos.x = textureArraySize.x - 1;
        if (pos.y > textureArraySize.y)
            pos.y = textureArraySize.y - 1;

        return textureMap[pos.x * resolution + pos.y];
    }
    */

    public float GetTextureAtPos(float2 worldPos, int texIndex)
    {
        if (texIndex >= textureCount || texIndex < 0)
            return 0;

        // terrains cannot be rotated, so we don't have to worry about rotation
        float2 relativePosition = worldPos - new float2(terrainPos.x, terrainPos.y);
        var pos = new int2
        (
            (int)math.round((relativePosition.x / terrainSize.x) * textureArraySize.x),
            (int)math.round((relativePosition.y / terrainSize.y) * textureArraySize.y)
        );

        if (pos.x > textureArraySize.x)
            pos.x = textureArraySize.x - 1;
        if (pos.y > textureArraySize.y)
            pos.y = textureArraySize.y - 1;

        return textureMapAllTextures[pos.x + resolution * (pos.y + textureCount * texIndex)];
    }


    public void Dispose()
    {
        textureMap.Dispose();
        textureMapAllTextures.Dispose();
    }


    static NativeArray<int> GetTextureMap(Terrain terrain, Allocator alloc)
    {
        int resolutionX = terrain.terrainData.alphamapWidth;
        int resolutionY = terrain.terrainData.alphamapHeight;
        var textureArray = new NativeArray<int>(resolutionX * resolutionY, alloc, NativeArrayOptions.UninitializedMemory);
        var terrainAlphamapData = terrain.terrainData.GetAlphamaps(0, 0, resolutionX, resolutionY);

        // get most important texture for all positions
        for (int x = 0; x < resolutionX; x++)
        {
            for (int y = 0; y < resolutionY; y++)
                textureArray[x * resolutionX + y] = DominantTextureAt(terrainAlphamapData, terrain, new int2(x, y));
        }
        return textureArray;
    }


    static NativeArray<float> GetTextureMapAllTextures(Terrain terrain, Allocator alloc)
    {
        int resolutionX = terrain.terrainData.alphamapWidth;
        int resolutionY = terrain.terrainData.alphamapHeight;
        int textureCount = terrain.terrainData.alphamapLayers;
        var textureArray = new NativeArray<float>(resolutionX * resolutionY * textureCount, alloc, NativeArrayOptions.UninitializedMemory);
        var terrainAlphamapData = terrain.terrainData.GetAlphamaps(0, 0, resolutionX, resolutionY);

        // get most important texture for all positions
        for (int x = 0; x < resolutionX; x++)
        {
            for (int y = 0; y < resolutionY; y++)
            {
                for (int z = 0; z < textureCount; z++)
                    textureArray[x + resolutionX * (y + textureCount * z)] = terrainAlphamapData[y, x, z];
            }
        }
        return textureArray;
    }


    static int DominantTextureAt(float[,,] terrainAlphamapData, Terrain t, int2 alphaPosition)
    {
        int mostDominantTextureIndex = 0;
        float greatestTextureWeight = float.MinValue;
        int textureCount = t.terrainData.alphamapLayers;
        for (int i = 0; i < textureCount; i++)
        {
            // not sure why the x and z coordinates are out of order here, Unity stuff
            float textureWeight = terrainAlphamapData[alphaPosition.y, alphaPosition.x, i];
            if (textureWeight > greatestTextureWeight)
            {
                greatestTextureWeight = textureWeight;
                mostDominantTextureIndex = i;
            }
        }

        return mostDominantTextureIndex;
    }
}
