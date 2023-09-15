using System;
using Unity.Mathematics;

namespace Myrmecoman
{
    [Serializable]
    public struct CustomAABB
    {
        public float3 Min;
        public float3 Max;
        public float3 Size;


        public CustomAABB(float3 min, float3 max)
        {
            Min = min;
            Max = max;
            Size = Abs(max - min);
        }


        private static float3 Abs(float3 v)
        {
            float3 res = v;
            if (res.x < 0)
                res.x = -res.x;
            if (res.y < 0)
                res.y = -res.y;
            if (res.z < 0)
                res.z = -res.z;
            return res;
        }
    }
}
