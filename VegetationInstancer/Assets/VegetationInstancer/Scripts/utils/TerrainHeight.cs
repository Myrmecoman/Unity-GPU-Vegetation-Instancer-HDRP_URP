using Unity.Collections;
using Unity.Mathematics;
using UnityEngine;

namespace Myrmecoman
{
    // https://discussions.unity.com/t/how-is-terrain-sampleheight-implemented/224833
    // This struct is usefull to get the height of the terrain at a world position in an optimized way.


    public struct TerrainHeight
    {
        public NativeArray<float> heightMap;
        public int resolution;
        public float2 sampleSize;
        public CustomAABB AABB { get; private set; }
        public bool IsValid => heightMap.IsCreated;
        int QuadCount => resolution - 1;


        public TerrainHeight(Terrain terrain, Allocator alloc)
        {
            resolution = terrain.terrainData.heightmapResolution;
            sampleSize = new float2(terrain.terrainData.heightmapScale.x, terrain.terrainData.heightmapScale.z);
            AABB = GetTerrrainAABB(terrain);
            heightMap = GetHeightMap(terrain, alloc);
        }


        public TerrainHeight(NativeArray<float> heightMapT, int resolutionT, float2 sampleSizeT, CustomAABB aabbT)
        {
            heightMap = heightMapT;
            resolution = resolutionT;
            sampleSize = sampleSizeT;
            AABB = aabbT;
        }


        /// <summary>
        /// Returns world height of terrain at x and z position values.
        /// </summary>
        public float SampleHeight(float2 worldPosition)
        {
            if (!IsWithinBounds(worldPosition)) // return crazy value instead of throwing an error
                return -10000f;

            GetTriAtPosition(worldPosition, out Triangle tri);
            return tri.SampleHeight(worldPosition);
        }


        /// <summary>
        /// Returns world height of terrain at x and z position values. Also outputs normalized normal vector of terrain at position.
        /// </summary>
        public float SampleHeight(float2 worldPosition, out float3 normal)
        {
            if (!IsWithinBounds(worldPosition)) // return crazy value instead of throwing an error
            {
                normal = new float3(0, 0, 0);
                return -10000;
            }

            GetTriAtPosition(worldPosition, out Triangle tri);
            normal = tri.Normal;
            return tri.SampleHeight(worldPosition);
        }


        public void GetTriAtPosition(float2 worldPosition, out Triangle tri)
        {
            float2 localPos = new float2(
                worldPosition.x - AABB.Min.x,
                worldPosition.y - AABB.Min.z);
            float2 samplePos = localPos / sampleSize;
            int2 sampleFloor = (int2)math.floor(samplePos);
            float2 sampleDecimal = samplePos - sampleFloor;
            bool upperLeftTri = sampleDecimal.y > sampleDecimal.x;
            int2 v1Offset = upperLeftTri ? new int2(0, 1) : new int2(1, 1);
            int2 v2Offset = upperLeftTri ? new int2(1, 1) : new int2(1, 0);
            float3 v0 = GetWorldVertex(sampleFloor);
            float3 v1 = GetWorldVertex(sampleFloor + v1Offset);
            float3 v2 = GetWorldVertex(sampleFloor + v2Offset);
            tri = new Triangle(v0, v1, v2);
        }


        public void Dispose()
        {
            heightMap.Dispose();
        }


        bool IsWithinBounds(float2 worldPos)
        {
            return
                worldPos.x >= AABB.Min.x &&
                worldPos.y >= AABB.Min.z &&
                worldPos.x <= AABB.Max.x &&
                worldPos.y <= AABB.Max.z;
        }


        float3 GetWorldVertex(int2 heightMapCrds)
        {
            float3 vertexPercentages = new float3(
                (float)heightMapCrds.x / QuadCount,
                heightMap[heightMapCrds.x * resolution + heightMapCrds.y],
                (float)heightMapCrds.y / QuadCount);
            return AABB.Min + AABB.Size * vertexPercentages;
        }


        static CustomAABB GetTerrrainAABB(Terrain terrain)
        {
            float3 min = terrain.transform.position;
            float3 max = min + (float3)terrain.terrainData.size;
            return new CustomAABB(min, max);
        }


        static NativeArray<float> GetHeightMap(Terrain terrain, Allocator alloc)
        {
            int resolution = terrain.terrainData.heightmapResolution;
            var heightList = new NativeArray<float>(resolution * resolution, alloc, NativeArrayOptions.UninitializedMemory);
            var map = terrain.terrainData.GetHeights(0, 0, resolution, resolution);
            for (int y = 0; y < resolution; y++)
            {
                for (int x = 0; x < resolution; x++)
                    heightList[x * resolution + y] = map[y, x];
            }
            return heightList;
        }
    }


    public readonly struct Triangle
    {
        public float3 V0 { get; }
        public float3 V1 { get; }
        public float3 V2 { get; }
        // This is already normalized.
        public float3 Normal { get; }

        public Triangle(float3 v0, float3 v1, float3 v2)
        {
            V0 = v0;
            V1 = v1;
            V2 = v2;
            Normal = math.normalize(math.cross(V1 - V0, V2 - V0));
        }


        public float SampleHeight(float2 position)
        {
            // plane formula: a(x - x0) + b(y - y0) + c(z - z0) = 0
            // <a,b,c> is a normal vector for the plane
            // (x,y,z) and (x0,y0,z0) are any points on the plane
            return (-Normal.x * (position.x - V0.x) - Normal.z * (position.y - V0.z)) / Normal.y + V0.y;
        }
    }
}
