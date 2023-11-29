#ifdef UNITY_PROCEDURAL_INSTANCING_ENABLED

	struct GPUInstancedIndirectData
	{
		float4x4 positionMatrix;
		float4x4 inversePositionMatrix;
		float4 controlData;
	};

	#if defined(SHADER_API_GLCORE) || defined(SHADER_API_D3D11) || defined(SHADER_API_GLES3) || defined(SHADER_API_METAL) || defined(SHADER_API_VULKAN) || defined(SHADER_API_PSSL) || defined(SHADER_API_XBOXONE)
		StructuredBuffer<GPUInstancedIndirectData> GPUInstancedIndirectDataBuffer;
	#endif	

#endif

void setupGPUInstancedIndirect()
{
#ifdef UNITY_PROCEDURAL_INSTANCING_ENABLED

#ifdef unity_ObjectToWorld
#undef unity_ObjectToWorld
#endif

#ifdef unity_WorldToObject
#undef unity_WorldToObject
#endif
	unity_LODFade = GPUInstancedIndirectDataBuffer[unity_InstanceID].controlData; 
	unity_ObjectToWorld = GPUInstancedIndirectDataBuffer[unity_InstanceID].positionMatrix;
	unity_WorldToObject = GPUInstancedIndirectDataBuffer[unity_InstanceID].inversePositionMatrix;
#endif
}