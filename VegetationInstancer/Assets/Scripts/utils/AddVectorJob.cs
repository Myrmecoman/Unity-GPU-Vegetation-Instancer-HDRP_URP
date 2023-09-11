using Unity.Burst;
using Unity.Collections;
using Unity.Jobs;


namespace Myrmecoman
{
    [BurstCompile(FloatPrecision = FloatPrecision.Low, FloatMode = FloatMode.Fast, DisableSafetyChecks = true, OptimizeFor = OptimizeFor.Performance), NoAlias]
    public struct AddVectorJob : IJob
    {
        [ReadOnly]
        public NativeArray<uint> input;
        [WriteOnly]
        public NativeArray<uint> output;

        public int total;


        public void Execute()
        {
            for (int i = 0; i < input.Length; i++)
            {
                output[i] = (uint)total;
                total += (int)input[i];
            }
        }
    }
}
