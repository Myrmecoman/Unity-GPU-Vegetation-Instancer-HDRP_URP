using System.Runtime.CompilerServices;
using Unity.Burst;
using Unity.Collections;
using Unity.Jobs;
using Unity.Mathematics;
using UnityEngine;


// https://learnopengl.com/Guest-Articles/2021/Scene/Frustum-Culling
// This job is in charge of finding the visible chunks for this frame. It also tells if it distant enough to be an LOD chunk or not.


[BurstCompile(FloatPrecision = FloatPrecision.Low, FloatMode = FloatMode.Fast, DisableSafetyChecks = true, OptimizeFor = OptimizeFor.Performance), NoAlias]
public struct PickVisibleChunksJob : IJob
{
    [ReadOnly]
    public TerrainHeight terrainData;
    [WriteOnly]
    public NativeList<int3> normalChunks;
    [WriteOnly]
    public NativeList<int3> LODChunks;
    [ReadOnly]
    public FrustrumPlanes frustrumPlanes;
    [ReadOnly]
    public int3 camPos;
    [ReadOnly]
    public int3 terrainPos;
    [ReadOnly]
    public int size1D;
    [ReadOnly]
    public int chunkSize;
    [ReadOnly]
    public int viewDistanceSq;
    [ReadOnly]
    public int LODviewDistanceSq;


    // find new visible chunks, but also remove the ones which are not visible anymore
    public void Execute()
    {
        int halfChunk = chunkSize / 2;

        // this way instead of going through all chunks, we only check the ones in viewrange
        int startX = camPos.x - (int)math.sqrt(viewDistanceSq) - camPos.x % chunkSize;
        if (startX < terrainPos.x)
            startX = terrainPos.x;
        int startZ = camPos.z - (int)math.sqrt(viewDistanceSq) - camPos.z % chunkSize;
        if (startZ < terrainPos.z)
            startZ = terrainPos.z;
        int endX = camPos.x + (int)math.sqrt(viewDistanceSq) - camPos.x % chunkSize;
        if (endX >= terrainPos.x + size1D)
            endX = terrainPos.x + size1D;
        int endZ = camPos.z + (int)math.sqrt(viewDistanceSq) - camPos.z % chunkSize;
        if (endZ >= terrainPos.z + size1D)
            endZ = terrainPos.z + size1D;

        // add the visible chunks to the corresponding hashmap
        for (int i = startX; i <= endX; i += chunkSize)
        {
            for (int j = startZ; j < endZ; j += chunkSize)
            {
                int height = (int)terrainData.SampleHeight(new float2(i, j));
                int3 pos = new int3(i + halfChunk, height, j + halfChunk);
                float distance = (camPos.x - pos.x) * (camPos.x - pos.x) + (camPos.y - pos.y) * (camPos.y - pos.y) + (camPos.z - pos.z) * (camPos.z - pos.z);
                if (distance <= LODviewDistanceSq && isVisible(pos))
                    normalChunks.Add(new int3(pos.x, height, pos.z));
                else if (distance <= viewDistanceSq && isVisible(pos))
                    LODChunks.Add(new int3(pos.x, height, pos.z));
            }
        }
    }


    [MethodImpl(MethodImplOptions.AggressiveInlining)]
    private bool isVisible(int3 pos)
    {
        return isOnOrForwardPlane(frustrumPlanes.p1, pos) &&
               isOnOrForwardPlane(frustrumPlanes.p2, pos) &&
               isOnOrForwardPlane(frustrumPlanes.p3, pos) &&
               isOnOrForwardPlane(frustrumPlanes.p4, pos) &&
               isOnOrForwardPlane(frustrumPlanes.p5, pos) &&
               isOnOrForwardPlane(frustrumPlanes.p6, pos);
    }


    [MethodImpl(MethodImplOptions.AggressiveInlining)]
    private bool isOnOrForwardPlane(Plane p, int3 pos)
    {
        // Compute the projection interval radius of b onto L(t) = b.c + t * p.n
        // size of bounding box is chunkSize, chunksize*4, chunksize
        float r = chunkSize/2 * math.abs(p.normal.x) + chunkSize * 2 * math.abs(p.normal.y) + chunkSize/2 * math.abs(p.normal.z);
        return -r <= p.GetDistanceToPoint(new float3(pos.x, pos.y, pos.z)); ;
    }


    [MethodImpl(MethodImplOptions.AggressiveInlining)]
    private bool Contains(int3 pos)
    {
        for (int i = 0; i < existingChunks.Length; i++)
        {
            if (existingChunks[i].x == pos.x && existingChunks[i].y == pos.y && existingChunks[i].z == pos.z)
                return true;
        }
        return false;
    }
}
