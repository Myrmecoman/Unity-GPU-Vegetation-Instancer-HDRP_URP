using System.Runtime.CompilerServices;
using Unity.Burst;
using Unity.Collections;
using Unity.Jobs;
using Unity.Mathematics;
using UnityEngine;

namespace Myrmecoman
{
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
        public float maxDisplacement; // objects, because of displacement, can end up outside of a chunk. This is here to not have disappearing objects
        [ReadOnly]
        public int viewDistanceSq;
        [ReadOnly]
        public int LODviewDistanceSq;


        // find new visible chunks, but also remove the ones which are not visible anymore
        public void Execute()
        {
            // this way instead of going through all chunks, we only check the ones in viewrange
            int startX = camPos.x - (int)math.sqrt(viewDistanceSq) - (camPos.x - (int)math.sqrt(viewDistanceSq)) % chunkSize;
            if (startX < terrainPos.x)
                startX = terrainPos.x;
            int startZ = camPos.z - (int)math.sqrt(viewDistanceSq) - (camPos.z - (int)math.sqrt(viewDistanceSq)) % chunkSize;
            if (startZ < terrainPos.z)
                startZ = terrainPos.z;
            int endX = camPos.x + (int)math.sqrt(viewDistanceSq) + chunkSize;
            if (endX >= terrainPos.x + size1D)
                endX = terrainPos.x + size1D;
            int endZ = camPos.z + (int)math.sqrt(viewDistanceSq) + chunkSize;
            if (endZ >= terrainPos.z + size1D)
                endZ = terrainPos.z + size1D;

            // add the visible chunks to the corresponding hashmap
            for (int i = startX; i <= endX; i += chunkSize)
            {
                for (int j = startZ; j <= endZ; j += chunkSize)
                {
                    // get the lowest terrain corner of the chunk
                    float height1 = terrainData.SampleHeight(new float2(i + chunkSize, j + chunkSize));
                    float height2 = terrainData.SampleHeight(new float2(i + chunkSize, j));
                    float height3 = terrainData.SampleHeight(new float2(i, j + chunkSize));
                    float height4 = terrainData.SampleHeight(new float2(i, j));
                    int minHeight = (int)(GetMinimum(height1, height2, height3, height4) - maxDisplacement);
                    int maxHeight = (int)(GetMaximum(height1, height2, height3, height4) + 1f + maxDisplacement);
                    int heightDiff = maxHeight - minHeight;

                    int3 pos = new int3(i + chunkSize/2, minHeight, j + chunkSize/2);
                    float distance = (camPos.x - pos.x) * (camPos.x - pos.x) + (camPos.y - pos.y) * (camPos.y - pos.y) + (camPos.z - pos.z) * (camPos.z - pos.z);
                    if (distance <= LODviewDistanceSq && isVisible(pos, heightDiff))
                        normalChunks.Add(new int3(pos.x, minHeight, pos.z));
                    else if (distance <= viewDistanceSq && isVisible(pos, heightDiff))
                        LODChunks.Add(new int3(pos.x, minHeight, pos.z));
                }
            }
        }


        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        private bool isVisible(int3 pos, float heightDiff)
        {
            return isOnOrForwardPlane(frustrumPlanes.p1, pos, heightDiff) &&
                   isOnOrForwardPlane(frustrumPlanes.p2, pos, heightDiff) &&
                   isOnOrForwardPlane(frustrumPlanes.p3, pos, heightDiff) &&
                   isOnOrForwardPlane(frustrumPlanes.p4, pos, heightDiff) &&
                   isOnOrForwardPlane(frustrumPlanes.p5, pos, heightDiff) &&
                   isOnOrForwardPlane(frustrumPlanes.p6, pos, heightDiff);
        }


        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        private bool isOnOrForwardPlane(Plane p, int3 pos, float chunkHeight)
        {
            // Compute the projection interval radius of b onto L(t) = b.c + t * p.n
            // size of bounding box is chunkSize, (chunkHeight + 10f) / 2f, chunksize
            // y here is the chunk highest corner point + 10f, where 10f is the supposed maximum plant height. We can increase this later if it is not sufficient
            float yExtent = (chunkHeight + 10f) / 2f;
            float newChunkSize = chunkSize + 2 * maxDisplacement; // increase size of chunk by the max displacement
            float r = newChunkSize / 2f * math.abs(p.normal.x) + yExtent * math.abs(p.normal.y) + newChunkSize / 2f * math.abs(p.normal.z);
            return -r <= p.GetDistanceToPoint(new float3(pos.x, pos.y + yExtent, pos.z)); ;
        }


        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        private float GetMinimum(float a, float b, float c, float d)
        {
            float min = a;
            if (b < min)
                min = b;
            if (c < min)
                min = c;
            if (d < min)
                min = d;
            return min;
        }


        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        private float GetMaximum(float a, float b, float c, float d)
        {
            float max = a;
            if (b > max)
                max = b;
            if (c > max)
                max = c;
            if (d > max)
                max = d;
            return max;
        }
    }
}
