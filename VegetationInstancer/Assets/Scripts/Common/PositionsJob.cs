using Unity.Burst;
using Unity.Collections;
using Unity.Jobs;
using Unity.Mathematics;
using UnityEngine;


// This job is in charge of finding the position of all the elements inside a chunk.


[BurstCompile(FloatPrecision = FloatPrecision.Low, FloatMode = FloatMode.Fast, DisableSafetyChecks = true, OptimizeFor = OptimizeFor.Performance), NoAlias]
public struct PositionsJob : IJobParallelFor
{
    [WriteOnly]
    public NativeArray<Matrix4x4> outputPlants;
    [ReadOnly]
    public TerrainHeight terrainData;
    [ReadOnly]
    public TerrainTextures terrainTex;
    [ReadOnly]
    public int3 chunkPos;
    [ReadOnly]
    public float D1Size;
    [ReadOnly]
    public float chunkSize;
    [ReadOnly]
    public float plantDistance;

    // procedural parameters
    [ReadOnly]
    public Unity.Mathematics.Random rnd;
    [ReadOnly]
    public float maxSlope;
    [ReadOnly]
    public float sizeChange;
    [ReadOnly]
    public bool rotate;
    [ReadOnly]
    public float displacement;
    [ReadOnly]
    public int textureIndex;
    [ReadOnly]
    public float falloff;


    public void Execute(int index)
    {
        float xDisplacement = rnd.NextFloat(-displacement, displacement);
        float zDisplacement = rnd.NextFloat(-displacement, displacement);

        float3 normal;
        float x = xDisplacement + chunkPos.x - chunkSize / 2 + (index / D1Size) * chunkSize / plantDistance;
        float z = zDisplacement + chunkPos.z - chunkSize / 2 + (index % D1Size) * chunkSize / plantDistance;
        float y = terrainData.SampleHeight(new float2(x, z), out normal);

        // check texture
        float texValueAtPos = terrainTex.GetTextureAtPos(new float2(x, z), textureIndex);
        if (textureIndex != -1 && texValueAtPos < falloff)
        {
            int texIndexAtPos = terrainTex.GetTextureAtPos(new float2(x, z));
            if (textureIndex != texIndexAtPos)
            {
                outputPlants[index] = Matrix4x4.TRS(new float3(0, -10000, 0), quaternion.identity, new float3(1, 1, 1));
                return;
            }
        }

        // check slope
        if (normal.y < maxSlope)
        {
            outputPlants[index] = Matrix4x4.TRS(new float3(0, -10000, 0), quaternion.identity, new float3(1, 1, 1));
            return;
        }

        float3 pos = new float3(x, y, z);
        Quaternion q = Quaternion.FromToRotation(new float3(0, 1, 0), normal);
        if (rotate)
            q *= Quaternion.Euler(0, rnd.NextFloat(0, 360), 0);
        float newSize = rnd.NextFloat(1f/sizeChange, sizeChange);

        if (texValueAtPos >= falloff)
            newSize *= math.max(texValueAtPos, 0.1f);

        outputPlants[index] = Matrix4x4.TRS(pos, q, new float3(newSize, newSize, newSize));
    }


    /*
    private bool IsCulled(float3 pos)
    {
        // -1 here is the vegetation object negative radius
        return frustrumPlanes.p1.GetDistanceToPoint(pos) < -1 ||
               frustrumPlanes.p2.GetDistanceToPoint(pos) < -1 ||
               frustrumPlanes.p3.GetDistanceToPoint(pos) < -1 ||
               frustrumPlanes.p4.GetDistanceToPoint(pos) < -1 ||
               frustrumPlanes.p5.GetDistanceToPoint(pos) < -1 ||
               frustrumPlanes.p6.GetDistanceToPoint(pos) < -1;
    }
    */
}
