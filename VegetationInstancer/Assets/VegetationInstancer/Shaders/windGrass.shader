Shader "VegetationInstancer/windGrass_GPU"
{
    Properties
    {
        [NoScaleOffset]_Texture2D("Texture2D", 2D) = "white" {}
        _Albedo("Albedo", Color) = (1, 1, 1, 1)
        _Smoothness("Smoothness", Float) = 0
        _WindSpeed("WindSpeed", Float) = 1
        _WindStrength("WindStrength", Float) = 1
        [NoScaleOffset]_Normal("Normal", 2D) = "white" {}
        _NormalStrength("NormalStrength", Float) = 1
        [HideInInspector]_DiffusionProfileHash("Float", Float) = 0
        [HideInInspector]_DiffusionProfileAsset("Vector4", Vector) = (0, 0, 0, 0)
        [HideInInspector]_EmissionColor("Color", Color) = (1, 1, 1, 1)
        [HideInInspector]_RenderQueueType("Float", Float) = 1
        [HideInInspector][ToggleUI]_AddPrecomputedVelocity("Boolean", Float) = 0
        [HideInInspector][ToggleUI]_DepthOffsetEnable("Boolean", Float) = 0
        [HideInInspector][ToggleUI]_ConservativeDepthOffsetEnable("Boolean", Float) = 0
        [HideInInspector][ToggleUI]_TransparentWritingMotionVec("Boolean", Float) = 0
        [HideInInspector][ToggleUI]_AlphaCutoffEnable("Boolean", Float) = 1
        [HideInInspector]_TransparentSortPriority("_TransparentSortPriority", Float) = 0
        [HideInInspector][ToggleUI]_UseShadowThreshold("Boolean", Float) = 0
        [HideInInspector][ToggleUI]_DoubleSidedEnable("Boolean", Float) = 0
        [HideInInspector][Enum(Flip, 0, Mirror, 1, None, 2)]_DoubleSidedNormalMode("Float", Float) = 2
        [HideInInspector]_DoubleSidedConstants("Vector4", Vector) = (1, 1, -1, 0)
        [HideInInspector][Enum(Auto, 0, On, 1, Off, 2)]_DoubleSidedGIMode("Float", Float) = 0
        [HideInInspector][ToggleUI]_TransparentDepthPrepassEnable("Boolean", Float) = 0
        [HideInInspector][ToggleUI]_TransparentDepthPostpassEnable("Boolean", Float) = 0
        [HideInInspector][ToggleUI]_PerPixelSorting("Boolean", Float) = 0
        [HideInInspector]_SurfaceType("Float", Float) = 0
        [HideInInspector]_BlendMode("Float", Float) = 0
        [HideInInspector]_SrcBlend("Float", Float) = 1
        [HideInInspector]_DstBlend("Float", Float) = 0
        [HideInInspector]_DstBlend2("Float", Float) = 0
        [HideInInspector]_AlphaSrcBlend("Float", Float) = 1
        [HideInInspector]_AlphaDstBlend("Float", Float) = 0
        [HideInInspector][ToggleUI]_ZWrite("Boolean", Float) = 1
        [HideInInspector][ToggleUI]_TransparentZWrite("Boolean", Float) = 0
        [HideInInspector]_CullMode("Float", Float) = 2
        [HideInInspector][ToggleUI]_EnableFogOnTransparent("Boolean", Float) = 1
        [HideInInspector]_CullModeForward("Float", Float) = 2
        [HideInInspector][Enum(Front, 1, Back, 2)]_TransparentCullMode("Float", Float) = 2
        [HideInInspector][Enum(UnityEditor.Rendering.HighDefinition.OpaqueCullMode)]_OpaqueCullMode("Float", Float) = 2
        [HideInInspector]_ZTestDepthEqualForOpaque("Float", Int) = 3
        [HideInInspector][Enum(UnityEngine.Rendering.CompareFunction)]_ZTestTransparent("Float", Float) = 4
        [HideInInspector][ToggleUI]_TransparentBackfaceEnable("Boolean", Float) = 0
        [HideInInspector][ToggleUI]_RequireSplitLighting("Boolean", Float) = 0
        [HideInInspector][ToggleUI]_ReceivesSSR("Boolean", Float) = 1
        [HideInInspector][ToggleUI]_ReceivesSSRTransparent("Boolean", Float) = 0
        [HideInInspector][ToggleUI]_EnableBlendModePreserveSpecularLighting("Boolean", Float) = 1
        [HideInInspector][ToggleUI]_SupportDecals("Boolean", Float) = 1
        [HideInInspector][ToggleUI]_ExcludeFromTUAndAA("Boolean", Float) = 0
        [HideInInspector]_StencilRef("Float", Int) = 0
        [HideInInspector]_StencilWriteMask("Float", Int) = 6
        [HideInInspector]_StencilRefDepth("Float", Int) = 8
        [HideInInspector]_StencilWriteMaskDepth("Float", Int) = 9
        [HideInInspector]_StencilRefMV("Float", Int) = 40
        [HideInInspector]_StencilWriteMaskMV("Float", Int) = 41
        [HideInInspector]_StencilRefDistortionVec("Float", Int) = 4
        [HideInInspector]_StencilWriteMaskDistortionVec("Float", Int) = 4
        [HideInInspector]_StencilWriteMaskGBuffer("Float", Int) = 15
        [HideInInspector]_StencilRefGBuffer("Float", Int) = 10
        [HideInInspector]_ZTestGBuffer("Float", Int) = 4
        [HideInInspector][ToggleUI]_RayTracing("Boolean", Float) = 0
        [HideInInspector][Enum(None, 0, Planar, 1, Sphere, 2, Thin, 3)]_RefractionModel("Float", Float) = 0
        [HideInInspector][Enum(Translucent, 5)]_MaterialID("_MaterialID", Float) = 5
        [HideInInspector]_MaterialTypeMask("_MaterialTypeMask", Float) = 32
        [HideInInspector][ToggleUI]_TransmissionEnable("Boolean", Float) = 1
        [HideInInspector][NoScaleOffset]unity_Lightmaps("unity_Lightmaps", 2DArray) = "" {}
        [HideInInspector][NoScaleOffset]unity_LightmapsInd("unity_LightmapsInd", 2DArray) = "" {}
        [HideInInspector][NoScaleOffset]unity_ShadowMasks("unity_ShadowMasks", 2DArray) = "" {}
    }
    SubShader
    {
        Tags
        {
            "RenderPipeline"="HDRenderPipeline"
            "RenderType"="HDLitShader"
            "Queue"="AlphaTest+25"
            "DisableBatching"="False"
            "ShaderGraphShader"="true"
            "ShaderGraphTargetId"="HDLitSubTarget"
        }
        Pass
        {
            Name "ShadowCaster"
            Tags
            {
                "LightMode" = "ShadowCaster"
            }
        
            // Render State
            Cull [_CullMode]
        ZWrite On
        ColorMask 0
        ZClip [_ZClip]
        
            // Debug
            // <None>
        
            // --------------------------------------------------
            // Pass
        
            HLSLPROGRAM
        
            // Pragmas
            #pragma multi_compile _ DOTS_INSTANCING_ON
        
        #pragma target 4.5
        #pragma vertex Vert
        #pragma fragment Frag
        #pragma only_renderers d3d11 playstation xboxone xboxseries vulkan metal switch
        
        
            // Keywords
            #pragma shader_feature_local _ _ALPHATEST_ON
        #pragma shader_feature _ _SURFACE_TYPE_TRANSPARENT
        #pragma shader_feature_local _ _DOUBLESIDED_ON
        #pragma shader_feature_local _ _ADD_PRECOMPUTED_VELOCITY
        #pragma shader_feature_local _ _TRANSPARENT_WRITES_MOTION_VEC _TRANSPARENT_REFRACTIVE_SORT
        #pragma shader_feature_local_fragment _ _ENABLE_FOG_ON_TRANSPARENT
        #pragma shader_feature_local_fragment _ _DISABLE_DECALS
        #pragma shader_feature_local_raytracing _ _DISABLE_DECALS
        #pragma shader_feature_local_fragment _ _DISABLE_SSR
        #pragma shader_feature_local_raytracing _ _DISABLE_SSR
        #pragma shader_feature_local_fragment _ _DISABLE_SSR_TRANSPARENT
        #pragma shader_feature_local_raytracing _ _DISABLE_SSR_TRANSPARENT
        #pragma shader_feature_local _ _REFRACTION_PLANE _REFRACTION_SPHERE _REFRACTION_THIN
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_TRANSMISSION
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_TRANSMISSION
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_ANISOTROPY
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_ANISOTROPY
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_IRIDESCENCE
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_IRIDESCENCE
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_SPECULAR_COLOR
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_SPECULAR_COLOR
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_COLORED_TRANSMISSION
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_COLORED_TRANSMISSION
            // GraphKeywords: <None>
        
            // Defines
            #define SHADERPASS SHADERPASS_SHADOWS
        
            // For custom interpolators to inject a substruct definition before FragInputs definition,
            // allowing for FragInputs to capture CI's intended for ShaderGraph's SDI.
            struct CustomInterpolators
        {
        };
        #define USE_CUSTOMINTERP_SUBSTRUCT
        
        
        
            // TODO: Merge FragInputsVFX substruct with CustomInterpolators.
        	#ifdef HAVE_VFX_MODIFICATION
        	struct FragInputsVFX
            {
                /* WARNING: $splice Could not find named fragment 'FragInputsVFX' */
            };
            #endif
        
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl" // Required by Tessellation.hlsl
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Tessellation.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl" // Required to be include before we include properties as it define DECLARE_STACK_CB
            // Always include Shader Graph version
            // Always include last to avoid double macros
            #include "Packages/com.unity.shadergraph/ShaderGraphLibrary/Functions.hlsl" // Need to be here for Gradient struct definition
        
            // --------------------------------------------------
            // Defines
        
            // Attribute
            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define ATTRIBUTES_NEED_TEXCOORD0
            #define VARYINGS_NEED_TEXCOORD0
        
            #define HAVE_MESH_MODIFICATION
        
            //Strip down the FragInputs.hlsl (on graphics), so we can only optimize the interpolators we use.
            //if by accident something requests contents of FragInputs.hlsl, it will be caught as a compiler error
            //Frag inputs stripping is only enabled when FRAG_INPUTS_ENABLE_STRIPPING is set
            #if !defined(SHADER_STAGE_RAY_TRACING) && SHADERPASS != SHADERPASS_RAYTRACING_GBUFFER && SHADERPASS != SHADERPASS_FULL_SCREEN_DEBUG
            #define FRAG_INPUTS_ENABLE_STRIPPING
            #endif
            #define FRAG_INPUTS_USE_TEXCOORD0
        
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
        
        
        
        
            // Following two define are a workaround introduce in 10.1.x for RaytracingQualityNode
            // The ShaderGraph don't support correctly migration of this node as it serialize all the node data
            // in the json file making it impossible to uprgrade. Until we get a fix, we do a workaround here
            // to still allow us to rename the field and keyword of this node without breaking existing code.
            #ifdef RAYTRACING_SHADER_GRAPH_DEFAULT
            #define RAYTRACING_SHADER_GRAPH_HIGH
            #endif
        
            #ifdef RAYTRACING_SHADER_GRAPH_RAYTRACED
            #define RAYTRACING_SHADER_GRAPH_LOW
            #endif
            // end
        
            #ifndef SHADER_UNLIT
            // We need isFrontFace when using double sided - it is not required for unlit as in case of unlit double sided only drive the cullmode
            // VARYINGS_NEED_CULLFACE can be define by VaryingsMeshToPS.FaceSign input if a IsFrontFace Node is included in the shader graph.
            #if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
                #define VARYINGS_NEED_CULLFACE
            #endif
            #endif
        
            // Specific Material Define
        #define _SPECULAR_OCCLUSION_FROM_AO 1
        #define _ENERGY_CONSERVING_SPECULAR 1
        
        #if _MATERIAL_FEATURE_COLORED_TRANSMISSION
            // Colored Transmission doesn't support clear coat
            #undef _MATERIAL_FEATURE_CLEAR_COAT
        #endif
        
        // If we use subsurface scattering, enable output split lighting (for forward pass)
        #if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
            #define OUTPUT_SPLIT_LIGHTING
        #endif
        
        // This shader support recursive rendering for raytracing
        #define HAVE_RECURSIVE_RENDERING
        
        // In Path Tracing, For all single-sided, refractive materials, we want to force a thin refraction model
        #if (SHADERPASS == SHADERPASS_PATH_TRACING) && !defined(_DOUBLESIDED_ON) && (defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE))
            #undef  _REFRACTION_PLANE
            #undef  _REFRACTION_SPHERE
            #define _REFRACTION_THIN
        #endif
            // Caution: we can use the define SHADER_UNLIT onlit after the above Material include as it is the Unlit template who define it
        
            // To handle SSR on transparent correctly with a possibility to enable/disable it per framesettings
            // we should have a code like this:
            // if !defined(_DISABLE_SSR_TRANSPARENT)
            // pragma multi_compile _ WRITE_NORMAL_BUFFER
            // endif
            // i.e we enable the multicompile only if we can receive SSR or not, and then C# code drive
            // it based on if SSR transparent in frame settings and not (and stripper can strip it).
            // this is currently not possible with our current preprocessor as _DISABLE_SSR_TRANSPARENT is a keyword not a define
            // so instead we used this and chose to pay the extra cost of normal write even if SSR transaprent is disabled.
            // Ideally the shader graph generator should handle it but condition below can't be handle correctly for now.
            #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
            #if !defined(_DISABLE_SSR_TRANSPARENT) && !defined(SHADER_UNLIT)
                #define WRITE_NORMAL_BUFFER
            #endif
            #endif
        
            // See Lit.shader
            #if SHADERPASS == SHADERPASS_MOTION_VECTORS && defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)
                #define WRITE_DECAL_BUFFER
            #endif
        
            #ifndef DEBUG_DISPLAY
                // In case of opaque we don't want to perform the alpha test, it is done in depth prepass and we use depth equal for ztest (setup from UI)
                // Don't do it with debug display mode as it is possible there is no depth prepass in this case
                #if !defined(_SURFACE_TYPE_TRANSPARENT)
                    #if SHADERPASS == SHADERPASS_FORWARD
                    #define SHADERPASS_FORWARD_BYPASS_ALPHA_TEST
                    #elif SHADERPASS == SHADERPASS_GBUFFER
                    #define SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST
                    #endif
                #endif
            #endif
        
            // Define _DEFERRED_CAPABLE_MATERIAL for shader capable to run in deferred pass
            #if defined(SHADER_LIT) && !defined(_SURFACE_TYPE_TRANSPARENT)
                #define _DEFERRED_CAPABLE_MATERIAL
            #endif
        
            // Translate transparent motion vector define
            #if (defined(_TRANSPARENT_WRITES_MOTION_VEC) || defined(_TRANSPARENT_REFRACTIVE_SORT)) && defined(_SURFACE_TYPE_TRANSPARENT)
                #define _WRITE_TRANSPARENT_MOTION_VECTOR
            #endif
        
            // -- Graph Properties
            CBUFFER_START(UnityPerMaterial)
        float4 _DiffusionProfileAsset;
        float _DiffusionProfileHash;
        float4 _Texture2D_TexelSize;
        float4 _Albedo;
        float _Smoothness;
        float _WindSpeed;
        float _WindStrength;
        float4 _Normal_TexelSize;
        float _NormalStrength;
        float4 _EmissionColor;
        float _UseShadowThreshold;
        float4 _DoubleSidedConstants;
        float _BlendMode;
        float _EnableBlendModePreserveSpecularLighting;
        float _RayTracing;
        float _RefractionModel;
        float _MaterialID;
        float _MaterialTypeMask;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_Texture2D);
        SAMPLER(sampler_Texture2D);
        TEXTURE2D(_Normal);
        SAMPLER(sampler_Normal);
        
            // -- Property used by ScenePickingPass
            #ifdef SCENEPICKINGPASS
            float4 _SelectionID;
            #endif
        
            // -- Properties used by SceneSelectionPass
            #ifdef SCENESELECTIONPASS
            int _ObjectId;
            int _PassValue;
            #endif
        
            // Includes
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitDecalData.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"
        	// GraphIncludes: <None>
        
            // --------------------------------------------------
            // Structs and Packing
        
            struct AttributesMesh
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct VaryingsMeshToPS
        {
            SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
             float4 texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
             float3 WorldSpacePosition;
             float4 uv0;
             float3 TimeParameters;
        };
        struct SurfaceDescriptionInputs
        {
             float4 uv0;
        };
        struct PackedVaryingsMeshToPS
        {
            SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
             float4 texCoord0 : INTERP0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
        };
        
            PackedVaryingsMeshToPS PackVaryingsMeshToPS (VaryingsMeshToPS input)
        {
            PackedVaryingsMeshToPS output;
            ZERO_INITIALIZE(PackedVaryingsMeshToPS, output);
            output.positionCS = input.positionCS;
            output.texCoord0.xyzw = input.texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            return output;
        }
        
        VaryingsMeshToPS UnpackVaryingsMeshToPS (PackedVaryingsMeshToPS input)
        {
            VaryingsMeshToPS output;
            output.positionCS = input.positionCS;
            output.texCoord0 = input.texCoord0.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            return output;
        }
        
        
            // --------------------------------------------------
            // Graph
        
        
            // Graph Functions
            
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_Sine_float(float In, out float Out)
        {
            Out = sin(In);
        }
        
        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }
        
            // Graph Vertex
            struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            float _Property_8c596e62dce249caa7922ff3d7470d43_Out_0_Float = _WindSpeed;
            float _Split_35af25740d5a404097ccb209d36d5cac_R_1_Float = IN.WorldSpacePosition[0];
            float _Split_35af25740d5a404097ccb209d36d5cac_G_2_Float = IN.WorldSpacePosition[1];
            float _Split_35af25740d5a404097ccb209d36d5cac_B_3_Float = IN.WorldSpacePosition[2];
            float _Split_35af25740d5a404097ccb209d36d5cac_A_4_Float = 0;
            float _Add_c678bc9d08684d01a8e45ad5e636b4b4_Out_2_Float;
            Unity_Add_float(_Split_35af25740d5a404097ccb209d36d5cac_R_1_Float, _Split_35af25740d5a404097ccb209d36d5cac_B_3_Float, _Add_c678bc9d08684d01a8e45ad5e636b4b4_Out_2_Float);
            float _Add_0ec2f296c670483e9dc4250c81fe62a0_Out_2_Float;
            Unity_Add_float(IN.TimeParameters.x, _Add_c678bc9d08684d01a8e45ad5e636b4b4_Out_2_Float, _Add_0ec2f296c670483e9dc4250c81fe62a0_Out_2_Float);
            float _Multiply_ce5f4784040b450499733beaca915393_Out_2_Float;
            Unity_Multiply_float_float(_Property_8c596e62dce249caa7922ff3d7470d43_Out_0_Float, _Add_0ec2f296c670483e9dc4250c81fe62a0_Out_2_Float, _Multiply_ce5f4784040b450499733beaca915393_Out_2_Float);
            float _Sine_3c81889fed534b52996b5063cdc22296_Out_1_Float;
            Unity_Sine_float(_Multiply_ce5f4784040b450499733beaca915393_Out_2_Float, _Sine_3c81889fed534b52996b5063cdc22296_Out_1_Float);
            float _Property_3cdd281375794ed2bcad3550a9c890af_Out_0_Float = _WindStrength;
            float _Multiply_89ad4329fdd44befb161e56947c2670b_Out_2_Float;
            Unity_Multiply_float_float(_Sine_3c81889fed534b52996b5063cdc22296_Out_1_Float, _Property_3cdd281375794ed2bcad3550a9c890af_Out_0_Float, _Multiply_89ad4329fdd44befb161e56947c2670b_Out_2_Float);
            float4 _UV_30b55575e9844728bc3abbcaf84a22ff_Out_0_Vector4 = IN.uv0;
            float _Split_020d1040f8544c0b9d3de77e7fbd9197_R_1_Float = _UV_30b55575e9844728bc3abbcaf84a22ff_Out_0_Vector4[0];
            float _Split_020d1040f8544c0b9d3de77e7fbd9197_G_2_Float = _UV_30b55575e9844728bc3abbcaf84a22ff_Out_0_Vector4[1];
            float _Split_020d1040f8544c0b9d3de77e7fbd9197_B_3_Float = _UV_30b55575e9844728bc3abbcaf84a22ff_Out_0_Vector4[2];
            float _Split_020d1040f8544c0b9d3de77e7fbd9197_A_4_Float = _UV_30b55575e9844728bc3abbcaf84a22ff_Out_0_Vector4[3];
            float _Multiply_17088dc811eb45e4a333912f99b556ec_Out_2_Float;
            Unity_Multiply_float_float(_Multiply_89ad4329fdd44befb161e56947c2670b_Out_2_Float, _Split_020d1040f8544c0b9d3de77e7fbd9197_G_2_Float, _Multiply_17088dc811eb45e4a333912f99b556ec_Out_2_Float);
            float3 _Add_e473a1f67cd1441b9fccfb91c0b5ff75_Out_2_Vector3;
            Unity_Add_float3(IN.WorldSpacePosition, (_Multiply_17088dc811eb45e4a333912f99b556ec_Out_2_Float.xxx), _Add_e473a1f67cd1441b9fccfb91c0b5ff75_Out_2_Vector3);
            float3 _Add_8e06eedaa53749dea4ffc85b774f63ee_Out_2_Vector3;
            Unity_Add_float3(float3(0, 0, 0), _Add_e473a1f67cd1441b9fccfb91c0b5ff75_Out_2_Vector3, _Add_8e06eedaa53749dea4ffc85b774f63ee_Out_2_Vector3);
            float3 _Transform_78fa02a50d4c495cba1111966696417e_Out_1_Vector3;
            _Transform_78fa02a50d4c495cba1111966696417e_Out_1_Vector3 = TransformWorldToObject(_Add_8e06eedaa53749dea4ffc85b774f63ee_Out_2_Vector3.xyz);
            description.Position = _Transform_78fa02a50d4c495cba1111966696417e_Out_1_Vector3;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
            // Graph Pixel
            struct SurfaceDescription
        {
            float Alpha;
            float AlphaClipThreshold;
            float DiffusionProfileHash;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            UnityTexture2D _Property_bb313b600ca3404fb88a2820878a8482_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Texture2D);
            float4 _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_bb313b600ca3404fb88a2820878a8482_Out_0_Texture2D.tex, _Property_bb313b600ca3404fb88a2820878a8482_Out_0_Texture2D.samplerstate, _Property_bb313b600ca3404fb88a2820878a8482_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_R_4_Float = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4.r;
            float _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_G_5_Float = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4.g;
            float _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_B_6_Float = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4.b;
            float _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_A_7_Float = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4.a;
            surface.Alpha = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_A_7_Float;
            surface.AlphaClipThreshold = 0.5;
            surface.DiffusionProfileHash = _DiffusionProfileHash;
            return surface;
        }
        
            // --------------------------------------------------
            // Build Graph Inputs
            #ifdef HAVE_VFX_MODIFICATION
            #define VFX_SRP_ATTRIBUTES AttributesMesh
            #define VaryingsMeshType VaryingsMeshToPS
            #define VFX_SRP_VARYINGS VaryingsMeshType
            #define VFX_SRP_SURFACE_INPUTS FragInputs
            #endif
            
        VertexDescriptionInputs AttributesMeshToVertexDescriptionInputs(AttributesMesh input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
            output.WorldSpacePosition =                         TransformObjectToWorld(input.positionOS);
            output.uv0 =                                        input.uv0;
            output.TimeParameters =                             _TimeParameters.xyz; // Note: in case of animation this will be overwrite (allow to handle motion vector)
        
            return output;
        }
        
        VertexDescription GetVertexDescription(AttributesMesh input, float3 timeParameters
        #ifdef HAVE_VFX_MODIFICATION
            , AttributesElement element
        #endif
        )
        {
            // build graph inputs
            VertexDescriptionInputs vertexDescriptionInputs = AttributesMeshToVertexDescriptionInputs(input);
            // Override time parameters with used one (This is required to correctly handle motion vectors for vertex animation based on time)
            vertexDescriptionInputs.TimeParameters = timeParameters;
        
            // evaluate vertex graph
        #ifdef HAVE_VFX_MODIFICATION
            GraphProperties properties;
            ZERO_INITIALIZE(GraphProperties, properties);
        
            // Fetch the vertex graph properties for the particle instance.
            GetElementVertexProperties(element, properties);
        
            VertexDescription vertexDescription = VertexDescriptionFunction(vertexDescriptionInputs, properties);
        #else
            VertexDescription vertexDescription = VertexDescriptionFunction(vertexDescriptionInputs);
        #endif
            return vertexDescription;
        
        }
        
        AttributesMesh ApplyMeshModification(AttributesMesh input, float3 timeParameters
        #ifdef USE_CUSTOMINTERP_SUBSTRUCT
            #ifdef TESSELLATION_ON
            , inout VaryingsMeshToDS varyings
            #else
            , inout VaryingsMeshToPS varyings
            #endif
        #endif
        #ifdef HAVE_VFX_MODIFICATION
                , AttributesElement element
        #endif
            )
        {
            VertexDescription vertexDescription = GetVertexDescription(input, timeParameters
        #ifdef HAVE_VFX_MODIFICATION
                , element
        #endif
            );
        
            // copy graph output to the results
            input.positionOS = vertexDescription.Position;
            input.normalOS = vertexDescription.Normal;
            input.tangentOS.xyz = vertexDescription.Tangent;
        
            
        
            return input;
        }
        
        #if defined(_ADD_CUSTOM_VELOCITY) // For shader graph custom velocity
        // Return precomputed Velocity in object space
        float3 GetCustomVelocity(AttributesMesh input
        #ifdef HAVE_VFX_MODIFICATION
            , AttributesElement element
        #endif
        )
        {
            VertexDescription vertexDescription = GetVertexDescription(input, _TimeParameters.xyz
        #ifdef HAVE_VFX_MODIFICATION
                , element
        #endif
            );
            return vertexDescription.CustomVelocity;
        }
        #endif
        
        FragInputs BuildFragInputs(VaryingsMeshToPS input)
        {
            FragInputs output;
            ZERO_INITIALIZE(FragInputs, output);
        
            // Init to some default value to make the computer quiet (else it output 'divide by zero' warning even if value is not used).
            // TODO: this is a really poor workaround, but the variable is used in a bunch of places
            // to compute normals which are then passed on elsewhere to compute other values...
            output.tangentToWorld = k_identity3x3;
            output.positionSS = input.positionCS;       // input.positionCS is SV_Position
        
            output.texCoord0 =                  input.texCoord0;
        
        
        #ifdef HAVE_VFX_MODIFICATION
            // FragInputs from VFX come from two places: Interpolator or CBuffer.
        #if VFX_USE_GRAPH_VALUES
            uint instanceActiveIndex = asuint(UNITY_ACCESS_INSTANCED_PROP(PerInstance, _InstanceActiveIndex));
            /* WARNING: $splice Could not find named fragment 'VFXLoadGraphValues' */
        #endif
        
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            // splice point to copy custom interpolator fields from varyings to frag inputs
            
        
            return output;
        }
        
        // existing HDRP code uses the combined function to go directly from packed to frag inputs
        FragInputs UnpackVaryingsMeshToFragInputs(PackedVaryingsMeshToPS input)
        {
            UNITY_SETUP_INSTANCE_ID(input);
        #if defined(HAVE_VFX_MODIFICATION) && defined(UNITY_INSTANCING_ENABLED)
            unity_InstanceID = input.instanceID;
        #endif
            VaryingsMeshToPS unpacked = UnpackVaryingsMeshToPS(input);
            return BuildFragInputs(unpacked);
        }
            SurfaceDescriptionInputs FragInputsToSurfaceDescriptionInputs(FragInputs input, float3 viewWS)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
            #if defined(SHADER_STAGE_RAY_TRACING)
            #else
            #endif
        
        #if UNITY_UV_STARTS_AT_TOP
        #else
        #endif
        
        
            output.uv0 =                                        input.texCoord0;
        
            // splice point to copy frag inputs custom interpolator pack into the SDI
            
        
            return output;
        }
        
            // --------------------------------------------------
            // Build Surface Data (Specific Material)
        
        void ApplyDecalToSurfaceDataNoNormal(DecalSurfaceData decalSurfaceData, inout SurfaceData surfaceData);
        
        void ApplyDecalAndGetNormal(FragInputs fragInputs, PositionInputs posInput, SurfaceDescription surfaceDescription,
            inout SurfaceData surfaceData)
        {
            float3 doubleSidedConstants = GetDoubleSidedConstants();
        
        #ifdef DECAL_NORMAL_BLENDING
            // SG nodes don't ouptut surface gradients, so if decals require surf grad blending, we have to convert
            // the normal to gradient before applying the decal. We then have to resolve the gradient back to world space
            float3 normalTS;
        
        
        
            #if HAVE_DECALS
            if (_EnableDecals)
            {
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                ApplyDecalToSurfaceNormal(decalSurfaceData, fragInputs.tangentToWorld[2], normalTS);
                ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
            }
            #endif
        
            GetNormalWS_SG(fragInputs, normalTS, surfaceData.normalWS, doubleSidedConstants);
        #else
            // normal delivered to master node
        
            #if HAVE_DECALS
            if (_EnableDecals)
            {
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                // Both uses and modifies 'surfaceData.normalWS'.
                DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                ApplyDecalToSurfaceNormal(decalSurfaceData, surfaceData.normalWS.xyz);
                ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
            }
            #endif
        #endif
        }
        void BuildSurfaceData(FragInputs fragInputs, inout SurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
        {
            ZERO_INITIALIZE(SurfaceData, surfaceData);
        
            // specularOcclusion need to be init ahead of decal to quiet the compiler that modify the SurfaceData struct
            // however specularOcclusion can come from the graph, so need to be init here so it can be override.
            surfaceData.specularOcclusion = 1.0;
            surfaceData.thickness = 0.0;
        
            surfaceData.diffusionProfileHash =      asuint(surfaceDescription.DiffusionProfileHash);
        
            #if defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE) || defined(_REFRACTION_THIN)
                if (_EnableSSRefraction)
                {
        
                    surfaceData.transmittanceMask = (1.0 - surfaceDescription.Alpha);
                    surfaceDescription.Alpha = 1.0;
                }
                else
                {
                    surfaceData.ior = 1.0;
                    surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                    surfaceData.atDistance = 1.0;
                    surfaceData.transmittanceMask = 0.0;
                    surfaceDescription.Alpha = 1.0;
                }
            #else
                surfaceData.ior = 1.0;
                surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                surfaceData.atDistance = 1.0;
                surfaceData.transmittanceMask = 0.0;
            #endif
        
            // These static material feature allow compile time optimization
            surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;
            #ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
            #endif
        
            #ifdef _MATERIAL_FEATURE_TRANSMISSION
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
            #endif
        
            #ifdef _MATERIAL_FEATURE_COLORED_TRANSMISSION
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_COLORED_TRANSMISSION;
        
            #endif
        
            #ifdef _MATERIAL_FEATURE_ANISOTROPY
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
        
                // Initialize the normal to something non-zero to avoid a div-zero warning for anisotropy.
                surfaceData.normalWS = float3(0, 1, 0);
            #endif
        
            #ifdef _MATERIAL_FEATURE_IRIDESCENCE
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
            #endif
        
            #ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
            #endif
        
            #ifdef _MATERIAL_FEATURE_CLEAR_COAT
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
            #endif
        
            #if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
                // Require to have setup baseColor
                // Reproduce the energy conservation done in legacy Unity. Not ideal but better for compatibility and users can unchek it
                surfaceData.baseColor *= (1.0 - Max3(surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b));
            #endif
        
            float3 doubleSidedConstants = GetDoubleSidedConstants();
        
            ApplyDecalAndGetNormal(fragInputs, posInput, surfaceDescription, surfaceData);
        
            surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];
        
            surfaceData.tangentWS = normalize(fragInputs.tangentToWorld[0].xyz);    // The tangent is not normalize in tangentToWorld for mikkt. TODO: Check if it expected that we normalize with Morten. Tag: SURFACE_GRADIENT
        
        
            bentNormalWS = surfaceData.normalWS;
        
            surfaceData.tangentWS = Orthonormalize(surfaceData.tangentWS, surfaceData.normalWS);
        
            #ifdef DEBUG_DISPLAY
                if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
                {
                    // TODO: need to update mip info
                    surfaceData.metallic = 0;
                }
        
                // We need to call ApplyDebugToSurfaceData after filling the surfarcedata and before filling builtinData
                // as it can modify attribute use for static lighting
                ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData);
            #endif
        
            // By default we use the ambient occlusion with Tri-ace trick (apply outside) for specular occlusion.
            // If user provide bent normal then we process a better term
            #if defined(_SPECULAR_OCCLUSION_CUSTOM)
                // Just use the value passed through via the slot (not active otherwise)
            #elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
                // If we have bent normal and ambient occlusion, process a specular occlusion
                surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO(V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness(surfaceData.perceptualSmoothness));
            #elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
                surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion(ClampNdotV(dot(surfaceData.normalWS, V)), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness(surfaceData.perceptualSmoothness));
            #endif
        
            #if defined(_ENABLE_GEOMETRIC_SPECULAR_AA) && !defined(SHADER_STAGE_RAY_TRACING)
                surfaceData.perceptualSmoothness = GeometricNormalFiltering(surfaceData.perceptualSmoothness, fragInputs.tangentToWorld[2], surfaceDescription.SpecularAAScreenSpaceVariance, surfaceDescription.SpecularAAThreshold);
            #endif
        }
        
            // --------------------------------------------------
            // Get Surface And BuiltinData
        
            void GetSurfaceAndBuiltinData(FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData RAY_TRACING_OPTIONAL_PARAMETERS)
            {
                // Don't dither if displaced tessellation (we're fading out the displacement instead to match the next LOD)
                #if !defined(SHADER_STAGE_RAY_TRACING) && !defined(_TESSELLATION_DISPLACEMENT)
                #ifdef LOD_FADE_CROSSFADE // enable dithering LOD transition if user select CrossFade transition in LOD group
                LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
                #endif
                #endif
        
                #ifndef SHADER_UNLIT
                #ifdef _DOUBLESIDED_ON
                    float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
                #else
                    float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
                #endif
        
                ApplyDoubleSidedFlipOrMirror(fragInputs, doubleSidedConstants); // Apply double sided flip on the vertex normal
                #endif // SHADER_UNLIT
        
                SurfaceDescriptionInputs surfaceDescriptionInputs = FragInputsToSurfaceDescriptionInputs(fragInputs, V);
        
                #if defined(HAVE_VFX_MODIFICATION)
                GraphProperties properties;
                ZERO_INITIALIZE(GraphProperties, properties);
        
                GetElementPixelProperties(fragInputs, properties);
        
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs, properties);
                #else
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs);
                #endif
        
                // Perform alpha test very early to save performance (a killed pixel will not sample textures)
                // TODO: split graph evaluation to grab just alpha dependencies first? tricky..
                #ifdef _ALPHATEST_ON
                    float alphaCutoff = surfaceDescription.AlphaClipThreshold;
                    #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
                    // The TransparentDepthPrepass is also used with SSR transparent.
                    // If an artists enable transaprent SSR but not the TransparentDepthPrepass itself, then we use AlphaClipThreshold
                    // otherwise if TransparentDepthPrepass is enabled we use AlphaClipThresholdDepthPrepass
                    #elif SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_POSTPASS
                    // DepthPostpass always use its own alpha threshold
                    alphaCutoff = surfaceDescription.AlphaClipThresholdDepthPostpass;
                    #elif (SHADERPASS == SHADERPASS_SHADOWS) || (SHADERPASS == SHADERPASS_RAYTRACING_VISIBILITY)
                    // If use shadow threshold isn't enable we don't allow any test
                    #endif
        
                    GENERIC_ALPHA_TEST(surfaceDescription.Alpha, alphaCutoff);
                #endif
        
                #if !defined(SHADER_STAGE_RAY_TRACING) && _DEPTHOFFSET_ON
                ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
                #endif
        
                #ifndef SHADER_UNLIT
                float3 bentNormalWS;
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS);
        
                #ifdef FRAG_INPUTS_USE_TEXCOORD1
                    float4 lightmapTexCoord1 = fragInputs.texCoord1;
                #else
                    float4 lightmapTexCoord1 = float4(0,0,0,0);
                #endif
        
                #ifdef FRAG_INPUTS_USE_TEXCOORD2
                    float4 lightmapTexCoord2 = fragInputs.texCoord2;
                #else
                    float4 lightmapTexCoord2 = float4(0,0,0,0);
                #endif
        
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                // Builtin Data
                // For back lighting we use the oposite vertex normal
                InitBuiltinData(posInput, alpha, bentNormalWS, -fragInputs.tangentToWorld[2], lightmapTexCoord1, lightmapTexCoord2, builtinData);
        
                #else
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData);
        
                ZERO_BUILTIN_INITIALIZE(builtinData); // No call to InitBuiltinData as we don't have any lighting
                builtinData.opacity = surfaceDescription.Alpha;
        
                #if defined(DEBUG_DISPLAY)
                    // Light Layers are currently not used for the Unlit shader (because it is not lit)
                    // But Unlit objects do cast shadows according to their rendering layer mask, which is what we want to
                    // display in the light layers visualization mode, therefore we need the renderingLayers
                    builtinData.renderingLayers = GetMeshRenderingLayerMask();
                #endif
        
                #endif // SHADER_UNLIT
        
                #ifdef _ALPHATEST_ON
                    // Used for sharpening by alpha to mask - Alpha to covertage is only used with depth only and forward pass (no shadow pass, no transparent pass)
                    builtinData.alphaClipTreshold = alphaCutoff;
                #endif
        
                // override sampleBakedGI - not used by Unlit
        		// When overriding GI, we need to force the isLightmap flag to make sure we don't add APV (sampled in the lightloop) on top of the overridden value (set at GBuffer stage)
        
        
                // Note this will not fully work on transparent surfaces (can check with _SURFACE_TYPE_TRANSPARENT define)
                // We will always overwrite vt feeback with the nearest. So behind transparent surfaces vt will not be resolved
                // This is a limitation of the current MRT approach.
                #ifdef UNITY_VIRTUAL_TEXTURING
                #endif
        
                #if _DEPTHOFFSET_ON
                builtinData.depthOffset = surfaceDescription.DepthOffset;
                #endif
        
                // TODO: We should generate distortion / distortionBlur for non distortion pass
                #if (SHADERPASS == SHADERPASS_DISTORTION)
                builtinData.distortion = surfaceDescription.Distortion;
                builtinData.distortionBlur = surfaceDescription.DistortionBlur;
                #endif
        
                #ifndef SHADER_UNLIT
                // PostInitBuiltinData call ApplyDebugToBuiltinData
                PostInitBuiltinData(V, posInput, surfaceData, builtinData);
                #else
                ApplyDebugToBuiltinData(builtinData);
                #endif
        
                RAY_TRACING_OPTIONAL_ALPHA_TEST_PASS
            }
        
            // --------------------------------------------------
            // Main
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPassDepthOnly.hlsl"
        
            // --------------------------------------------------
            // Visual Effect Vertex Invocations
        
        	#ifdef HAVE_VFX_MODIFICATION
                #if !defined(SHADER_STAGE_RAY_TRACING)
        	    #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/VisualEffectVertex.hlsl"
                #else
                #endif
        	#endif
        
            #include "Assets/VegetationInstancer/Shaders/Include/GPUInstancedIndirectInclude.cginc"
#pragma instancing_options procedural:setupGPUInstancedIndirect
#pragma multi_compile_instancing
ENDHLSL
        }
        Pass
        {
            Name "META"
            Tags
            {
                "LightMode" = "META"
            }
        
            // Render State
            Cull Off
        
            // Debug
            // <None>
        
            // --------------------------------------------------
            // Pass
        
            HLSLPROGRAM
        
            // Pragmas
            #pragma multi_compile _ DOTS_INSTANCING_ON
        
        #pragma target 4.5
        #pragma vertex Vert
        #pragma fragment Frag
        #pragma only_renderers d3d11 playstation xboxone xboxseries vulkan metal switch
        
        
            // Keywords
            #pragma shader_feature _ EDITOR_VISUALIZATION
        #pragma shader_feature_local _ _ALPHATEST_ON
        #pragma shader_feature _ _SURFACE_TYPE_TRANSPARENT
        #pragma shader_feature_local _ _DOUBLESIDED_ON
        #pragma shader_feature_local _ _ADD_PRECOMPUTED_VELOCITY
        #pragma shader_feature_local _ _TRANSPARENT_WRITES_MOTION_VEC _TRANSPARENT_REFRACTIVE_SORT
        #pragma shader_feature_local_fragment _ _ENABLE_FOG_ON_TRANSPARENT
        #pragma shader_feature_local_fragment _ _DISABLE_DECALS
        #pragma shader_feature_local_raytracing _ _DISABLE_DECALS
        #pragma shader_feature_local_fragment _ _DISABLE_SSR
        #pragma shader_feature_local_raytracing _ _DISABLE_SSR
        #pragma shader_feature_local_fragment _ _DISABLE_SSR_TRANSPARENT
        #pragma shader_feature_local_raytracing _ _DISABLE_SSR_TRANSPARENT
        #pragma shader_feature_local _ _REFRACTION_PLANE _REFRACTION_SPHERE _REFRACTION_THIN
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_TRANSMISSION
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_TRANSMISSION
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_ANISOTROPY
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_ANISOTROPY
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_IRIDESCENCE
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_IRIDESCENCE
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_SPECULAR_COLOR
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_SPECULAR_COLOR
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_COLORED_TRANSMISSION
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_COLORED_TRANSMISSION
            // GraphKeywords: <None>
        
            // Defines
            #define SHADERPASS SHADERPASS_LIGHT_TRANSPORT
        #define RAYTRACING_SHADER_GRAPH_DEFAULT
        #define SCENEPICKINGPASS 1
        
            // For custom interpolators to inject a substruct definition before FragInputs definition,
            // allowing for FragInputs to capture CI's intended for ShaderGraph's SDI.
            /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreInclude' */
        
        
            // TODO: Merge FragInputsVFX substruct with CustomInterpolators.
        	#ifdef HAVE_VFX_MODIFICATION
        	struct FragInputsVFX
            {
                /* WARNING: $splice Could not find named fragment 'FragInputsVFX' */
            };
            #endif
        
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl" // Required by Tessellation.hlsl
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Tessellation.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl" // Required to be include before we include properties as it define DECLARE_STACK_CB
            // Always include Shader Graph version
            // Always include last to avoid double macros
            #include "Packages/com.unity.shadergraph/ShaderGraphLibrary/Functions.hlsl" // Need to be here for Gradient struct definition
        
            // --------------------------------------------------
            // Defines
        
            // Attribute
            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TEXCOORD0
            #define ATTRIBUTES_NEED_TEXCOORD1
            #define ATTRIBUTES_NEED_TEXCOORD2
            #define ATTRIBUTES_NEED_TEXCOORD3
            #define VARYINGS_NEED_POSITION_WS
            #define VARYINGS_NEED_POSITIONPREDISPLACEMENT_WS
            #define VARYINGS_NEED_TEXCOORD0
            #define VARYINGS_NEED_TEXCOORD1
            #define VARYINGS_NEED_TEXCOORD2
            #define VARYINGS_NEED_TEXCOORD3
        
            #define HAVE_MESH_MODIFICATION
        
            //Strip down the FragInputs.hlsl (on graphics), so we can only optimize the interpolators we use.
            //if by accident something requests contents of FragInputs.hlsl, it will be caught as a compiler error
            //Frag inputs stripping is only enabled when FRAG_INPUTS_ENABLE_STRIPPING is set
            #if !defined(SHADER_STAGE_RAY_TRACING) && SHADERPASS != SHADERPASS_RAYTRACING_GBUFFER && SHADERPASS != SHADERPASS_FULL_SCREEN_DEBUG
            #define FRAG_INPUTS_ENABLE_STRIPPING
            #endif
            #define FRAG_INPUTS_USE_TEXCOORD0
            #define FRAG_INPUTS_USE_TEXCOORD1
            #define FRAG_INPUTS_USE_TEXCOORD2
            #define FRAG_INPUTS_USE_TEXCOORD3
        
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
        
        
        
        
            // Following two define are a workaround introduce in 10.1.x for RaytracingQualityNode
            // The ShaderGraph don't support correctly migration of this node as it serialize all the node data
            // in the json file making it impossible to uprgrade. Until we get a fix, we do a workaround here
            // to still allow us to rename the field and keyword of this node without breaking existing code.
            #ifdef RAYTRACING_SHADER_GRAPH_DEFAULT
            #define RAYTRACING_SHADER_GRAPH_HIGH
            #endif
        
            #ifdef RAYTRACING_SHADER_GRAPH_RAYTRACED
            #define RAYTRACING_SHADER_GRAPH_LOW
            #endif
            // end
        
            #ifndef SHADER_UNLIT
            // We need isFrontFace when using double sided - it is not required for unlit as in case of unlit double sided only drive the cullmode
            // VARYINGS_NEED_CULLFACE can be define by VaryingsMeshToPS.FaceSign input if a IsFrontFace Node is included in the shader graph.
            #if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
                #define VARYINGS_NEED_CULLFACE
            #endif
            #endif
        
            // Specific Material Define
        #define _SPECULAR_OCCLUSION_FROM_AO 1
        #define _ENERGY_CONSERVING_SPECULAR 1
        
        #if _MATERIAL_FEATURE_COLORED_TRANSMISSION
            // Colored Transmission doesn't support clear coat
            #undef _MATERIAL_FEATURE_CLEAR_COAT
        #endif
        
        // If we use subsurface scattering, enable output split lighting (for forward pass)
        #if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
            #define OUTPUT_SPLIT_LIGHTING
        #endif
        
        // This shader support recursive rendering for raytracing
        #define HAVE_RECURSIVE_RENDERING
        
        // In Path Tracing, For all single-sided, refractive materials, we want to force a thin refraction model
        #if (SHADERPASS == SHADERPASS_PATH_TRACING) && !defined(_DOUBLESIDED_ON) && (defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE))
            #undef  _REFRACTION_PLANE
            #undef  _REFRACTION_SPHERE
            #define _REFRACTION_THIN
        #endif
            // Caution: we can use the define SHADER_UNLIT onlit after the above Material include as it is the Unlit template who define it
        
            // To handle SSR on transparent correctly with a possibility to enable/disable it per framesettings
            // we should have a code like this:
            // if !defined(_DISABLE_SSR_TRANSPARENT)
            // pragma multi_compile _ WRITE_NORMAL_BUFFER
            // endif
            // i.e we enable the multicompile only if we can receive SSR or not, and then C# code drive
            // it based on if SSR transparent in frame settings and not (and stripper can strip it).
            // this is currently not possible with our current preprocessor as _DISABLE_SSR_TRANSPARENT is a keyword not a define
            // so instead we used this and chose to pay the extra cost of normal write even if SSR transaprent is disabled.
            // Ideally the shader graph generator should handle it but condition below can't be handle correctly for now.
            #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
            #if !defined(_DISABLE_SSR_TRANSPARENT) && !defined(SHADER_UNLIT)
                #define WRITE_NORMAL_BUFFER
            #endif
            #endif
        
            // See Lit.shader
            #if SHADERPASS == SHADERPASS_MOTION_VECTORS && defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)
                #define WRITE_DECAL_BUFFER
            #endif
        
            #ifndef DEBUG_DISPLAY
                // In case of opaque we don't want to perform the alpha test, it is done in depth prepass and we use depth equal for ztest (setup from UI)
                // Don't do it with debug display mode as it is possible there is no depth prepass in this case
                #if !defined(_SURFACE_TYPE_TRANSPARENT)
                    #if SHADERPASS == SHADERPASS_FORWARD
                    #define SHADERPASS_FORWARD_BYPASS_ALPHA_TEST
                    #elif SHADERPASS == SHADERPASS_GBUFFER
                    #define SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST
                    #endif
                #endif
            #endif
        
            // Define _DEFERRED_CAPABLE_MATERIAL for shader capable to run in deferred pass
            #if defined(SHADER_LIT) && !defined(_SURFACE_TYPE_TRANSPARENT)
                #define _DEFERRED_CAPABLE_MATERIAL
            #endif
        
            // Translate transparent motion vector define
            #if (defined(_TRANSPARENT_WRITES_MOTION_VEC) || defined(_TRANSPARENT_REFRACTIVE_SORT)) && defined(_SURFACE_TYPE_TRANSPARENT)
                #define _WRITE_TRANSPARENT_MOTION_VECTOR
            #endif
        
            // -- Graph Properties
            CBUFFER_START(UnityPerMaterial)
        float4 _DiffusionProfileAsset;
        float _DiffusionProfileHash;
        float4 _Texture2D_TexelSize;
        float4 _Albedo;
        float _Smoothness;
        float _WindSpeed;
        float _WindStrength;
        float4 _Normal_TexelSize;
        float _NormalStrength;
        float4 _EmissionColor;
        float _UseShadowThreshold;
        float4 _DoubleSidedConstants;
        float _BlendMode;
        float _EnableBlendModePreserveSpecularLighting;
        float _RayTracing;
        float _RefractionModel;
        float _MaterialID;
        float _MaterialTypeMask;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_Texture2D);
        SAMPLER(sampler_Texture2D);
        TEXTURE2D(_Normal);
        SAMPLER(sampler_Normal);
        
            // -- Property used by ScenePickingPass
            #ifdef SCENEPICKINGPASS
            float4 _SelectionID;
            #endif
        
            // -- Properties used by SceneSelectionPass
            #ifdef SCENESELECTIONPASS
            int _ObjectId;
            int _PassValue;
            #endif
        
            // Includes
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/PickingSpaceTransforms.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitDecalData.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"
        	// GraphIncludes: <None>
        
            // --------------------------------------------------
            // Structs and Packing
        
            struct AttributesMesh
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 uv0 : TEXCOORD0;
             float4 uv1 : TEXCOORD1;
             float4 uv2 : TEXCOORD2;
             float4 uv3 : TEXCOORD3;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct VaryingsMeshToPS
        {
            SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
             float3 positionRWS;
             float3 positionPredisplacementRWS;
             float4 texCoord0;
             float4 texCoord1;
             float4 texCoord2;
             float4 texCoord3;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
        };
        struct VertexDescriptionInputs
        {
        };
        struct SurfaceDescriptionInputs
        {
             float3 TangentSpaceNormal;
             float4 uv0;
        };
        struct PackedVaryingsMeshToPS
        {
            SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
             float4 texCoord0 : INTERP0;
             float4 texCoord1 : INTERP1;
             float4 texCoord2 : INTERP2;
             float4 texCoord3 : INTERP3;
             float3 positionRWS : INTERP4;
             float3 positionPredisplacementRWS : INTERP5;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
        };
        
            PackedVaryingsMeshToPS PackVaryingsMeshToPS (VaryingsMeshToPS input)
        {
            PackedVaryingsMeshToPS output;
            ZERO_INITIALIZE(PackedVaryingsMeshToPS, output);
            output.positionCS = input.positionCS;
            output.texCoord0.xyzw = input.texCoord0;
            output.texCoord1.xyzw = input.texCoord1;
            output.texCoord2.xyzw = input.texCoord2;
            output.texCoord3.xyzw = input.texCoord3;
            output.positionRWS.xyz = input.positionRWS;
            output.positionPredisplacementRWS.xyz = input.positionPredisplacementRWS;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            return output;
        }
        
        VaryingsMeshToPS UnpackVaryingsMeshToPS (PackedVaryingsMeshToPS input)
        {
            VaryingsMeshToPS output;
            output.positionCS = input.positionCS;
            output.texCoord0 = input.texCoord0.xyzw;
            output.texCoord1 = input.texCoord1.xyzw;
            output.texCoord2 = input.texCoord2.xyzw;
            output.texCoord3 = input.texCoord3.xyzw;
            output.positionRWS = input.positionRWS.xyz;
            output.positionPredisplacementRWS = input.positionPredisplacementRWS.xyz;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            return output;
        }
        
        
            // --------------------------------------------------
            // Graph
        
        
            // Graph Functions
            
        void Unity_Multiply_float4_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
            // Graph Vertex
            struct VertexDescription
        {
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            return description;
        }
        
            // Graph Pixel
            struct SurfaceDescription
        {
            float3 BaseColor;
            float3 Emission;
            float Alpha;
            float AlphaClipThreshold;
            float3 BentNormal;
            float Smoothness;
            float Occlusion;
            float3 NormalTS;
            float TransmissionMask;
            float Thickness;
            float DiffusionProfileHash;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float4 _Property_35c125abbbcb46e1a2351d8febeb5da1_Out_0_Vector4 = _Albedo;
            UnityTexture2D _Property_bb313b600ca3404fb88a2820878a8482_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Texture2D);
            float4 _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_bb313b600ca3404fb88a2820878a8482_Out_0_Texture2D.tex, _Property_bb313b600ca3404fb88a2820878a8482_Out_0_Texture2D.samplerstate, _Property_bb313b600ca3404fb88a2820878a8482_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_R_4_Float = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4.r;
            float _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_G_5_Float = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4.g;
            float _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_B_6_Float = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4.b;
            float _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_A_7_Float = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4.a;
            float4 _Multiply_c09cca22f04c4a9a996a5ccf8f61afe1_Out_2_Vector4;
            Unity_Multiply_float4_float4(_Property_35c125abbbcb46e1a2351d8febeb5da1_Out_0_Vector4, _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4, _Multiply_c09cca22f04c4a9a996a5ccf8f61afe1_Out_2_Vector4);
            float _Property_925f8cb589d94edda2dcd6b588187f26_Out_0_Float = _Smoothness;
            float _Multiply_a061075fe3794cc5abff5f173997f7f8_Out_2_Float;
            Unity_Multiply_float_float(_Property_925f8cb589d94edda2dcd6b588187f26_Out_0_Float, _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_G_5_Float, _Multiply_a061075fe3794cc5abff5f173997f7f8_Out_2_Float);
            UnityTexture2D _Property_ff2eff189fa74f1f965ec8aca53205ba_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Normal);
            float4 _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_ff2eff189fa74f1f965ec8aca53205ba_Out_0_Texture2D.tex, _Property_ff2eff189fa74f1f965ec8aca53205ba_Out_0_Texture2D.samplerstate, _Property_ff2eff189fa74f1f965ec8aca53205ba_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.rgb = UnpackNormal(_SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4);
            float _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_R_4_Float = _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.r;
            float _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_G_5_Float = _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.g;
            float _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_B_6_Float = _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.b;
            float _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_A_7_Float = _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.a;
            float _Property_915c3b0b5fc04c668c646f2f67b5ab2b_Out_0_Float = _NormalStrength;
            float4 _Multiply_e38eea28614c4b61bfd135ec8591a746_Out_2_Vector4;
            Unity_Multiply_float4_float4(_SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4, (_Property_915c3b0b5fc04c668c646f2f67b5ab2b_Out_0_Float.xxxx), _Multiply_e38eea28614c4b61bfd135ec8591a746_Out_2_Vector4);
            surface.BaseColor = (_Multiply_c09cca22f04c4a9a996a5ccf8f61afe1_Out_2_Vector4.xyz);
            surface.Emission = float3(0, 0, 0);
            surface.Alpha = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_A_7_Float;
            surface.AlphaClipThreshold = 0.5;
            surface.BentNormal = IN.TangentSpaceNormal;
            surface.Smoothness = _Multiply_a061075fe3794cc5abff5f173997f7f8_Out_2_Float;
            surface.Occlusion = 1;
            surface.NormalTS = (_Multiply_e38eea28614c4b61bfd135ec8591a746_Out_2_Vector4.xyz);
            surface.TransmissionMask = 1;
            surface.Thickness = 1;
            surface.DiffusionProfileHash = _DiffusionProfileHash;
            return surface;
        }
        
            // --------------------------------------------------
            // Build Graph Inputs
            #ifdef HAVE_VFX_MODIFICATION
            #define VFX_SRP_ATTRIBUTES AttributesMesh
            #define VaryingsMeshType VaryingsMeshToPS
            #define VFX_SRP_VARYINGS VaryingsMeshType
            #define VFX_SRP_SURFACE_INPUTS FragInputs
            #endif
            
        VertexDescriptionInputs AttributesMeshToVertexDescriptionInputs(AttributesMesh input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
        
            return output;
        }
        
        VertexDescription GetVertexDescription(AttributesMesh input, float3 timeParameters
        #ifdef HAVE_VFX_MODIFICATION
            , AttributesElement element
        #endif
        )
        {
            // build graph inputs
            VertexDescriptionInputs vertexDescriptionInputs = AttributesMeshToVertexDescriptionInputs(input);
            // Override time parameters with used one (This is required to correctly handle motion vectors for vertex animation based on time)
        
            // evaluate vertex graph
        #ifdef HAVE_VFX_MODIFICATION
            GraphProperties properties;
            ZERO_INITIALIZE(GraphProperties, properties);
        
            // Fetch the vertex graph properties for the particle instance.
            GetElementVertexProperties(element, properties);
        
            VertexDescription vertexDescription = VertexDescriptionFunction(vertexDescriptionInputs, properties);
        #else
            VertexDescription vertexDescription = VertexDescriptionFunction(vertexDescriptionInputs);
        #endif
            return vertexDescription;
        
        }
        
        AttributesMesh ApplyMeshModification(AttributesMesh input, float3 timeParameters
        #ifdef USE_CUSTOMINTERP_SUBSTRUCT
            #ifdef TESSELLATION_ON
            , inout VaryingsMeshToDS varyings
            #else
            , inout VaryingsMeshToPS varyings
            #endif
        #endif
        #ifdef HAVE_VFX_MODIFICATION
                , AttributesElement element
        #endif
            )
        {
            VertexDescription vertexDescription = GetVertexDescription(input, timeParameters
        #ifdef HAVE_VFX_MODIFICATION
                , element
        #endif
            );
        
            // copy graph output to the results
        
            /* WARNING: $splice Could not find named fragment 'CustomInterpolatorVertMeshCustomInterpolation' */
        
            return input;
        }
        
        #if defined(_ADD_CUSTOM_VELOCITY) // For shader graph custom velocity
        // Return precomputed Velocity in object space
        float3 GetCustomVelocity(AttributesMesh input
        #ifdef HAVE_VFX_MODIFICATION
            , AttributesElement element
        #endif
        )
        {
            VertexDescription vertexDescription = GetVertexDescription(input, _TimeParameters.xyz
        #ifdef HAVE_VFX_MODIFICATION
                , element
        #endif
            );
            return vertexDescription.CustomVelocity;
        }
        #endif
        
        FragInputs BuildFragInputs(VaryingsMeshToPS input)
        {
            FragInputs output;
            ZERO_INITIALIZE(FragInputs, output);
        
            // Init to some default value to make the computer quiet (else it output 'divide by zero' warning even if value is not used).
            // TODO: this is a really poor workaround, but the variable is used in a bunch of places
            // to compute normals which are then passed on elsewhere to compute other values...
            output.tangentToWorld = k_identity3x3;
            output.positionSS = input.positionCS;       // input.positionCS is SV_Position
        
            output.positionRWS =                input.positionRWS;
            output.positionPredisplacementRWS = input.positionPredisplacementRWS;
            output.texCoord0 =                  input.texCoord0;
            output.texCoord1 =                  input.texCoord1;
            output.texCoord2 =                  input.texCoord2;
            output.texCoord3 =                  input.texCoord3;
        
        
        #ifdef HAVE_VFX_MODIFICATION
            // FragInputs from VFX come from two places: Interpolator or CBuffer.
        #if VFX_USE_GRAPH_VALUES
            uint instanceActiveIndex = asuint(UNITY_ACCESS_INSTANCED_PROP(PerInstance, _InstanceActiveIndex));
            /* WARNING: $splice Could not find named fragment 'VFXLoadGraphValues' */
        #endif
        
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            // splice point to copy custom interpolator fields from varyings to frag inputs
            /* WARNING: $splice Could not find named fragment 'CustomInterpolatorVaryingsToFragInputs' */
        
            return output;
        }
        
        // existing HDRP code uses the combined function to go directly from packed to frag inputs
        FragInputs UnpackVaryingsMeshToFragInputs(PackedVaryingsMeshToPS input)
        {
            UNITY_SETUP_INSTANCE_ID(input);
        #if defined(HAVE_VFX_MODIFICATION) && defined(UNITY_INSTANCING_ENABLED)
            unity_InstanceID = input.instanceID;
        #endif
            VaryingsMeshToPS unpacked = UnpackVaryingsMeshToPS(input);
            return BuildFragInputs(unpacked);
        }
            SurfaceDescriptionInputs FragInputsToSurfaceDescriptionInputs(FragInputs input, float3 viewWS)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
            #if defined(SHADER_STAGE_RAY_TRACING)
            #else
            #endif
            output.TangentSpaceNormal =                         float3(0.0f, 0.0f, 1.0f);
        
        #if UNITY_UV_STARTS_AT_TOP
        #else
        #endif
        
        
            output.uv0 =                                        input.texCoord0;
        
            // splice point to copy frag inputs custom interpolator pack into the SDI
            /* WARNING: $splice Could not find named fragment 'CustomInterpolatorCopyToSDI' */
        
            return output;
        }
        
            // --------------------------------------------------
            // Build Surface Data (Specific Material)
        
        void ApplyDecalToSurfaceDataNoNormal(DecalSurfaceData decalSurfaceData, inout SurfaceData surfaceData);
        
        void ApplyDecalAndGetNormal(FragInputs fragInputs, PositionInputs posInput, SurfaceDescription surfaceDescription,
            inout SurfaceData surfaceData)
        {
            float3 doubleSidedConstants = GetDoubleSidedConstants();
        
        #ifdef DECAL_NORMAL_BLENDING
            // SG nodes don't ouptut surface gradients, so if decals require surf grad blending, we have to convert
            // the normal to gradient before applying the decal. We then have to resolve the gradient back to world space
            float3 normalTS;
        
            normalTS = SurfaceGradientFromTangentSpaceNormalAndFromTBN(surfaceDescription.NormalTS,
            fragInputs.tangentToWorld[0], fragInputs.tangentToWorld[1]);
        
        
            #if HAVE_DECALS
            if (_EnableDecals)
            {
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                ApplyDecalToSurfaceNormal(decalSurfaceData, fragInputs.tangentToWorld[2], normalTS);
                ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
            }
            #endif
        
            GetNormalWS_SG(fragInputs, normalTS, surfaceData.normalWS, doubleSidedConstants);
        #else
            // normal delivered to master node
            GetNormalWS(fragInputs, surfaceDescription.NormalTS, surfaceData.normalWS, doubleSidedConstants);
        
            #if HAVE_DECALS
            if (_EnableDecals)
            {
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                // Both uses and modifies 'surfaceData.normalWS'.
                DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                ApplyDecalToSurfaceNormal(decalSurfaceData, surfaceData.normalWS.xyz);
                ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
            }
            #endif
        #endif
        }
        void BuildSurfaceData(FragInputs fragInputs, inout SurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
        {
            ZERO_INITIALIZE(SurfaceData, surfaceData);
        
            // specularOcclusion need to be init ahead of decal to quiet the compiler that modify the SurfaceData struct
            // however specularOcclusion can come from the graph, so need to be init here so it can be override.
            surfaceData.specularOcclusion = 1.0;
            surfaceData.thickness = 0.0;
        
            surfaceData.baseColor =                 surfaceDescription.BaseColor;
            surfaceData.perceptualSmoothness =      surfaceDescription.Smoothness;
            surfaceData.ambientOcclusion =          surfaceDescription.Occlusion;
            surfaceData.transmissionMask =          surfaceDescription.TransmissionMask.xxx;
            surfaceData.thickness =                 surfaceDescription.Thickness;
            surfaceData.diffusionProfileHash =      asuint(surfaceDescription.DiffusionProfileHash);
        
            #if defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE) || defined(_REFRACTION_THIN)
                if (_EnableSSRefraction)
                {
        
                    surfaceData.transmittanceMask = (1.0 - surfaceDescription.Alpha);
                    surfaceDescription.Alpha = 1.0;
                }
                else
                {
                    surfaceData.ior = 1.0;
                    surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                    surfaceData.atDistance = 1.0;
                    surfaceData.transmittanceMask = 0.0;
                    surfaceDescription.Alpha = 1.0;
                }
            #else
                surfaceData.ior = 1.0;
                surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                surfaceData.atDistance = 1.0;
                surfaceData.transmittanceMask = 0.0;
            #endif
        
            // These static material feature allow compile time optimization
            surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;
            #ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
            #endif
        
            #ifdef _MATERIAL_FEATURE_TRANSMISSION
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
            #endif
        
            #ifdef _MATERIAL_FEATURE_COLORED_TRANSMISSION
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_COLORED_TRANSMISSION;
        
            #endif
        
            #ifdef _MATERIAL_FEATURE_ANISOTROPY
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
        
                // Initialize the normal to something non-zero to avoid a div-zero warning for anisotropy.
                surfaceData.normalWS = float3(0, 1, 0);
            #endif
        
            #ifdef _MATERIAL_FEATURE_IRIDESCENCE
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
            #endif
        
            #ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
            #endif
        
            #ifdef _MATERIAL_FEATURE_CLEAR_COAT
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
            #endif
        
            #if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
                // Require to have setup baseColor
                // Reproduce the energy conservation done in legacy Unity. Not ideal but better for compatibility and users can unchek it
                surfaceData.baseColor *= (1.0 - Max3(surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b));
            #endif
        
            float3 doubleSidedConstants = GetDoubleSidedConstants();
        
            ApplyDecalAndGetNormal(fragInputs, posInput, surfaceDescription, surfaceData);
        
            surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];
        
            surfaceData.tangentWS = normalize(fragInputs.tangentToWorld[0].xyz);    // The tangent is not normalize in tangentToWorld for mikkt. TODO: Check if it expected that we normalize with Morten. Tag: SURFACE_GRADIENT
        
        
            bentNormalWS = surfaceData.normalWS;
        
            surfaceData.tangentWS = Orthonormalize(surfaceData.tangentWS, surfaceData.normalWS);
        
            #ifdef DEBUG_DISPLAY
                if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
                {
                    // TODO: need to update mip info
                    surfaceData.metallic = 0;
                }
        
                // We need to call ApplyDebugToSurfaceData after filling the surfarcedata and before filling builtinData
                // as it can modify attribute use for static lighting
                ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData);
            #endif
        
            // By default we use the ambient occlusion with Tri-ace trick (apply outside) for specular occlusion.
            // If user provide bent normal then we process a better term
            #if defined(_SPECULAR_OCCLUSION_CUSTOM)
                // Just use the value passed through via the slot (not active otherwise)
            #elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
                // If we have bent normal and ambient occlusion, process a specular occlusion
                surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO(V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness(surfaceData.perceptualSmoothness));
            #elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
                surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion(ClampNdotV(dot(surfaceData.normalWS, V)), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness(surfaceData.perceptualSmoothness));
            #endif
        
            #if defined(_ENABLE_GEOMETRIC_SPECULAR_AA) && !defined(SHADER_STAGE_RAY_TRACING)
                surfaceData.perceptualSmoothness = GeometricNormalFiltering(surfaceData.perceptualSmoothness, fragInputs.tangentToWorld[2], surfaceDescription.SpecularAAScreenSpaceVariance, surfaceDescription.SpecularAAThreshold);
            #endif
        }
        
            // --------------------------------------------------
            // Get Surface And BuiltinData
        
            void GetSurfaceAndBuiltinData(FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData RAY_TRACING_OPTIONAL_PARAMETERS)
            {
                // Don't dither if displaced tessellation (we're fading out the displacement instead to match the next LOD)
                #if !defined(SHADER_STAGE_RAY_TRACING) && !defined(_TESSELLATION_DISPLACEMENT)
                #ifdef LOD_FADE_CROSSFADE // enable dithering LOD transition if user select CrossFade transition in LOD group
                LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
                #endif
                #endif
        
                #ifndef SHADER_UNLIT
                #ifdef _DOUBLESIDED_ON
                    float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
                #else
                    float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
                #endif
        
                ApplyDoubleSidedFlipOrMirror(fragInputs, doubleSidedConstants); // Apply double sided flip on the vertex normal
                #endif // SHADER_UNLIT
        
                SurfaceDescriptionInputs surfaceDescriptionInputs = FragInputsToSurfaceDescriptionInputs(fragInputs, V);
        
                #if defined(HAVE_VFX_MODIFICATION)
                GraphProperties properties;
                ZERO_INITIALIZE(GraphProperties, properties);
        
                GetElementPixelProperties(fragInputs, properties);
        
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs, properties);
                #else
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs);
                #endif
        
                // Perform alpha test very early to save performance (a killed pixel will not sample textures)
                // TODO: split graph evaluation to grab just alpha dependencies first? tricky..
                #ifdef _ALPHATEST_ON
                    float alphaCutoff = surfaceDescription.AlphaClipThreshold;
                    #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
                    // The TransparentDepthPrepass is also used with SSR transparent.
                    // If an artists enable transaprent SSR but not the TransparentDepthPrepass itself, then we use AlphaClipThreshold
                    // otherwise if TransparentDepthPrepass is enabled we use AlphaClipThresholdDepthPrepass
                    #elif SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_POSTPASS
                    // DepthPostpass always use its own alpha threshold
                    alphaCutoff = surfaceDescription.AlphaClipThresholdDepthPostpass;
                    #elif (SHADERPASS == SHADERPASS_SHADOWS) || (SHADERPASS == SHADERPASS_RAYTRACING_VISIBILITY)
                    // If use shadow threshold isn't enable we don't allow any test
                    #endif
        
                    GENERIC_ALPHA_TEST(surfaceDescription.Alpha, alphaCutoff);
                #endif
        
                #if !defined(SHADER_STAGE_RAY_TRACING) && _DEPTHOFFSET_ON
                ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
                #endif
        
                #ifndef SHADER_UNLIT
                float3 bentNormalWS;
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS);
        
                #ifdef FRAG_INPUTS_USE_TEXCOORD1
                    float4 lightmapTexCoord1 = fragInputs.texCoord1;
                #else
                    float4 lightmapTexCoord1 = float4(0,0,0,0);
                #endif
        
                #ifdef FRAG_INPUTS_USE_TEXCOORD2
                    float4 lightmapTexCoord2 = fragInputs.texCoord2;
                #else
                    float4 lightmapTexCoord2 = float4(0,0,0,0);
                #endif
        
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                // Builtin Data
                // For back lighting we use the oposite vertex normal
                InitBuiltinData(posInput, alpha, bentNormalWS, -fragInputs.tangentToWorld[2], lightmapTexCoord1, lightmapTexCoord2, builtinData);
        
                #else
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData);
        
                ZERO_BUILTIN_INITIALIZE(builtinData); // No call to InitBuiltinData as we don't have any lighting
                builtinData.opacity = surfaceDescription.Alpha;
        
                #if defined(DEBUG_DISPLAY)
                    // Light Layers are currently not used for the Unlit shader (because it is not lit)
                    // But Unlit objects do cast shadows according to their rendering layer mask, which is what we want to
                    // display in the light layers visualization mode, therefore we need the renderingLayers
                    builtinData.renderingLayers = GetMeshRenderingLayerMask();
                #endif
        
                #endif // SHADER_UNLIT
        
                #ifdef _ALPHATEST_ON
                    // Used for sharpening by alpha to mask - Alpha to covertage is only used with depth only and forward pass (no shadow pass, no transparent pass)
                    builtinData.alphaClipTreshold = alphaCutoff;
                #endif
        
                // override sampleBakedGI - not used by Unlit
        		// When overriding GI, we need to force the isLightmap flag to make sure we don't add APV (sampled in the lightloop) on top of the overridden value (set at GBuffer stage)
        
                builtinData.emissiveColor = surfaceDescription.Emission;
        
                // Note this will not fully work on transparent surfaces (can check with _SURFACE_TYPE_TRANSPARENT define)
                // We will always overwrite vt feeback with the nearest. So behind transparent surfaces vt will not be resolved
                // This is a limitation of the current MRT approach.
                #ifdef UNITY_VIRTUAL_TEXTURING
                #endif
        
                #if _DEPTHOFFSET_ON
                builtinData.depthOffset = surfaceDescription.DepthOffset;
                #endif
        
                // TODO: We should generate distortion / distortionBlur for non distortion pass
                #if (SHADERPASS == SHADERPASS_DISTORTION)
                builtinData.distortion = surfaceDescription.Distortion;
                builtinData.distortionBlur = surfaceDescription.DistortionBlur;
                #endif
        
                #ifndef SHADER_UNLIT
                // PostInitBuiltinData call ApplyDebugToBuiltinData
                PostInitBuiltinData(V, posInput, surfaceData, builtinData);
                #else
                ApplyDebugToBuiltinData(builtinData);
                #endif
        
                RAY_TRACING_OPTIONAL_ALPHA_TEST_PASS
            }
        
            // --------------------------------------------------
            // Main
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPassLightTransport.hlsl"
        
            // --------------------------------------------------
            // Visual Effect Vertex Invocations
        
        	#ifdef HAVE_VFX_MODIFICATION
                #if !defined(SHADER_STAGE_RAY_TRACING)
        	    #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/VisualEffectVertex.hlsl"
                #else
                #endif
        	#endif
        
            #include "Assets/VegetationInstancer/Shaders/Include/GPUInstancedIndirectInclude.cginc"
#pragma instancing_options procedural:setupGPUInstancedIndirect
#pragma multi_compile_instancing
ENDHLSL
        }
        Pass
        {
            Name "ScenePickingPass"
            Tags
            {
                "LightMode" = "Picking"
            }
        
            // Render State
            Cull [_CullMode]
        
            // Debug
            // <None>
        
            // --------------------------------------------------
            // Pass
        
            HLSLPROGRAM
        
            // Pragmas
            #pragma multi_compile _ DOTS_INSTANCING_ON
        #pragma editor_sync_compilation
        
        #pragma target 4.5
        #pragma vertex Vert
        #pragma fragment Frag
        #pragma only_renderers d3d11 playstation xboxone xboxseries vulkan metal switch
        
        
            // Keywords
            #pragma shader_feature_local _ _ALPHATEST_ON
        #pragma shader_feature _ _SURFACE_TYPE_TRANSPARENT
        #pragma shader_feature_local _ _DOUBLESIDED_ON
        #pragma shader_feature_local _ _ADD_PRECOMPUTED_VELOCITY
        #pragma shader_feature_local _ _TRANSPARENT_WRITES_MOTION_VEC _TRANSPARENT_REFRACTIVE_SORT
        #pragma shader_feature_local_fragment _ _ENABLE_FOG_ON_TRANSPARENT
        #pragma shader_feature_local_fragment _ _DISABLE_DECALS
        #pragma shader_feature_local_raytracing _ _DISABLE_DECALS
        #pragma shader_feature_local_fragment _ _DISABLE_SSR
        #pragma shader_feature_local_raytracing _ _DISABLE_SSR
        #pragma shader_feature_local_fragment _ _DISABLE_SSR_TRANSPARENT
        #pragma shader_feature_local_raytracing _ _DISABLE_SSR_TRANSPARENT
        #pragma shader_feature_local _ _REFRACTION_PLANE _REFRACTION_SPHERE _REFRACTION_THIN
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_TRANSMISSION
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_TRANSMISSION
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_ANISOTROPY
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_ANISOTROPY
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_IRIDESCENCE
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_IRIDESCENCE
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_SPECULAR_COLOR
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_SPECULAR_COLOR
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_COLORED_TRANSMISSION
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_COLORED_TRANSMISSION
            // GraphKeywords: <None>
        
            // Defines
            #define SHADERPASS SHADERPASS_DEPTH_ONLY
        #define SCENEPICKINGPASS 1
        
            // For custom interpolators to inject a substruct definition before FragInputs definition,
            // allowing for FragInputs to capture CI's intended for ShaderGraph's SDI.
            struct CustomInterpolators
        {
        };
        #define USE_CUSTOMINTERP_SUBSTRUCT
        
        
        
            // TODO: Merge FragInputsVFX substruct with CustomInterpolators.
        	#ifdef HAVE_VFX_MODIFICATION
        	struct FragInputsVFX
            {
                /* WARNING: $splice Could not find named fragment 'FragInputsVFX' */
            };
            #endif
        
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl" // Required by Tessellation.hlsl
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Tessellation.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl" // Required to be include before we include properties as it define DECLARE_STACK_CB
            // Always include Shader Graph version
            // Always include last to avoid double macros
            #include "Packages/com.unity.shadergraph/ShaderGraphLibrary/Functions.hlsl" // Need to be here for Gradient struct definition
        
            // --------------------------------------------------
            // Defines
        
            // Attribute
            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define ATTRIBUTES_NEED_TEXCOORD0
            #define VARYINGS_NEED_TANGENT_TO_WORLD
            #define VARYINGS_NEED_TEXCOORD0
        
            #define HAVE_MESH_MODIFICATION
        
            //Strip down the FragInputs.hlsl (on graphics), so we can only optimize the interpolators we use.
            //if by accident something requests contents of FragInputs.hlsl, it will be caught as a compiler error
            //Frag inputs stripping is only enabled when FRAG_INPUTS_ENABLE_STRIPPING is set
            #if !defined(SHADER_STAGE_RAY_TRACING) && SHADERPASS != SHADERPASS_RAYTRACING_GBUFFER && SHADERPASS != SHADERPASS_FULL_SCREEN_DEBUG
            #define FRAG_INPUTS_ENABLE_STRIPPING
            #endif
            #define FRAG_INPUTS_USE_TEXCOORD0
        
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
        
        
        
        
            // Following two define are a workaround introduce in 10.1.x for RaytracingQualityNode
            // The ShaderGraph don't support correctly migration of this node as it serialize all the node data
            // in the json file making it impossible to uprgrade. Until we get a fix, we do a workaround here
            // to still allow us to rename the field and keyword of this node without breaking existing code.
            #ifdef RAYTRACING_SHADER_GRAPH_DEFAULT
            #define RAYTRACING_SHADER_GRAPH_HIGH
            #endif
        
            #ifdef RAYTRACING_SHADER_GRAPH_RAYTRACED
            #define RAYTRACING_SHADER_GRAPH_LOW
            #endif
            // end
        
            #ifndef SHADER_UNLIT
            // We need isFrontFace when using double sided - it is not required for unlit as in case of unlit double sided only drive the cullmode
            // VARYINGS_NEED_CULLFACE can be define by VaryingsMeshToPS.FaceSign input if a IsFrontFace Node is included in the shader graph.
            #if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
                #define VARYINGS_NEED_CULLFACE
            #endif
            #endif
        
            // Specific Material Define
        #define _SPECULAR_OCCLUSION_FROM_AO 1
        #define _ENERGY_CONSERVING_SPECULAR 1
        
        #if _MATERIAL_FEATURE_COLORED_TRANSMISSION
            // Colored Transmission doesn't support clear coat
            #undef _MATERIAL_FEATURE_CLEAR_COAT
        #endif
        
        // If we use subsurface scattering, enable output split lighting (for forward pass)
        #if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
            #define OUTPUT_SPLIT_LIGHTING
        #endif
        
        // This shader support recursive rendering for raytracing
        #define HAVE_RECURSIVE_RENDERING
        
        // In Path Tracing, For all single-sided, refractive materials, we want to force a thin refraction model
        #if (SHADERPASS == SHADERPASS_PATH_TRACING) && !defined(_DOUBLESIDED_ON) && (defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE))
            #undef  _REFRACTION_PLANE
            #undef  _REFRACTION_SPHERE
            #define _REFRACTION_THIN
        #endif
            // Caution: we can use the define SHADER_UNLIT onlit after the above Material include as it is the Unlit template who define it
        
            // To handle SSR on transparent correctly with a possibility to enable/disable it per framesettings
            // we should have a code like this:
            // if !defined(_DISABLE_SSR_TRANSPARENT)
            // pragma multi_compile _ WRITE_NORMAL_BUFFER
            // endif
            // i.e we enable the multicompile only if we can receive SSR or not, and then C# code drive
            // it based on if SSR transparent in frame settings and not (and stripper can strip it).
            // this is currently not possible with our current preprocessor as _DISABLE_SSR_TRANSPARENT is a keyword not a define
            // so instead we used this and chose to pay the extra cost of normal write even if SSR transaprent is disabled.
            // Ideally the shader graph generator should handle it but condition below can't be handle correctly for now.
            #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
            #if !defined(_DISABLE_SSR_TRANSPARENT) && !defined(SHADER_UNLIT)
                #define WRITE_NORMAL_BUFFER
            #endif
            #endif
        
            // See Lit.shader
            #if SHADERPASS == SHADERPASS_MOTION_VECTORS && defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)
                #define WRITE_DECAL_BUFFER
            #endif
        
            #ifndef DEBUG_DISPLAY
                // In case of opaque we don't want to perform the alpha test, it is done in depth prepass and we use depth equal for ztest (setup from UI)
                // Don't do it with debug display mode as it is possible there is no depth prepass in this case
                #if !defined(_SURFACE_TYPE_TRANSPARENT)
                    #if SHADERPASS == SHADERPASS_FORWARD
                    #define SHADERPASS_FORWARD_BYPASS_ALPHA_TEST
                    #elif SHADERPASS == SHADERPASS_GBUFFER
                    #define SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST
                    #endif
                #endif
            #endif
        
            // Define _DEFERRED_CAPABLE_MATERIAL for shader capable to run in deferred pass
            #if defined(SHADER_LIT) && !defined(_SURFACE_TYPE_TRANSPARENT)
                #define _DEFERRED_CAPABLE_MATERIAL
            #endif
        
            // Translate transparent motion vector define
            #if (defined(_TRANSPARENT_WRITES_MOTION_VEC) || defined(_TRANSPARENT_REFRACTIVE_SORT)) && defined(_SURFACE_TYPE_TRANSPARENT)
                #define _WRITE_TRANSPARENT_MOTION_VECTOR
            #endif
        
            // -- Graph Properties
            CBUFFER_START(UnityPerMaterial)
        float4 _DiffusionProfileAsset;
        float _DiffusionProfileHash;
        float4 _Texture2D_TexelSize;
        float4 _Albedo;
        float _Smoothness;
        float _WindSpeed;
        float _WindStrength;
        float4 _Normal_TexelSize;
        float _NormalStrength;
        float4 _EmissionColor;
        float _UseShadowThreshold;
        float4 _DoubleSidedConstants;
        float _BlendMode;
        float _EnableBlendModePreserveSpecularLighting;
        float _RayTracing;
        float _RefractionModel;
        float _MaterialID;
        float _MaterialTypeMask;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_Texture2D);
        SAMPLER(sampler_Texture2D);
        TEXTURE2D(_Normal);
        SAMPLER(sampler_Normal);
        
            // -- Property used by ScenePickingPass
            #ifdef SCENEPICKINGPASS
            float4 _SelectionID;
            #endif
        
            // -- Properties used by SceneSelectionPass
            #ifdef SCENESELECTIONPASS
            int _ObjectId;
            int _PassValue;
            #endif
        
            // Includes
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/PickingSpaceTransforms.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"
        	// GraphIncludes: <None>
        
            // --------------------------------------------------
            // Structs and Packing
        
            struct AttributesMesh
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct VaryingsMeshToPS
        {
            SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
             float3 normalWS;
             float4 tangentWS;
             float4 texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
             float3 WorldSpacePosition;
             float4 uv0;
             float3 TimeParameters;
        };
        struct SurfaceDescriptionInputs
        {
             float3 TangentSpaceNormal;
             float4 uv0;
        };
        struct PackedVaryingsMeshToPS
        {
            SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
             float4 tangentWS : INTERP0;
             float4 texCoord0 : INTERP1;
             float3 normalWS : INTERP2;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
        };
        
            PackedVaryingsMeshToPS PackVaryingsMeshToPS (VaryingsMeshToPS input)
        {
            PackedVaryingsMeshToPS output;
            ZERO_INITIALIZE(PackedVaryingsMeshToPS, output);
            output.positionCS = input.positionCS;
            output.tangentWS.xyzw = input.tangentWS;
            output.texCoord0.xyzw = input.texCoord0;
            output.normalWS.xyz = input.normalWS;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            return output;
        }
        
        VaryingsMeshToPS UnpackVaryingsMeshToPS (PackedVaryingsMeshToPS input)
        {
            VaryingsMeshToPS output;
            output.positionCS = input.positionCS;
            output.tangentWS = input.tangentWS.xyzw;
            output.texCoord0 = input.texCoord0.xyzw;
            output.normalWS = input.normalWS.xyz;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            return output;
        }
        
        
            // --------------------------------------------------
            // Graph
        
        
            // Graph Functions
            
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_Sine_float(float In, out float Out)
        {
            Out = sin(In);
        }
        
        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }
        
        void Unity_Multiply_float4_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }
        
            // Graph Vertex
            struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            float _Property_8c596e62dce249caa7922ff3d7470d43_Out_0_Float = _WindSpeed;
            float _Split_35af25740d5a404097ccb209d36d5cac_R_1_Float = IN.WorldSpacePosition[0];
            float _Split_35af25740d5a404097ccb209d36d5cac_G_2_Float = IN.WorldSpacePosition[1];
            float _Split_35af25740d5a404097ccb209d36d5cac_B_3_Float = IN.WorldSpacePosition[2];
            float _Split_35af25740d5a404097ccb209d36d5cac_A_4_Float = 0;
            float _Add_c678bc9d08684d01a8e45ad5e636b4b4_Out_2_Float;
            Unity_Add_float(_Split_35af25740d5a404097ccb209d36d5cac_R_1_Float, _Split_35af25740d5a404097ccb209d36d5cac_B_3_Float, _Add_c678bc9d08684d01a8e45ad5e636b4b4_Out_2_Float);
            float _Add_0ec2f296c670483e9dc4250c81fe62a0_Out_2_Float;
            Unity_Add_float(IN.TimeParameters.x, _Add_c678bc9d08684d01a8e45ad5e636b4b4_Out_2_Float, _Add_0ec2f296c670483e9dc4250c81fe62a0_Out_2_Float);
            float _Multiply_ce5f4784040b450499733beaca915393_Out_2_Float;
            Unity_Multiply_float_float(_Property_8c596e62dce249caa7922ff3d7470d43_Out_0_Float, _Add_0ec2f296c670483e9dc4250c81fe62a0_Out_2_Float, _Multiply_ce5f4784040b450499733beaca915393_Out_2_Float);
            float _Sine_3c81889fed534b52996b5063cdc22296_Out_1_Float;
            Unity_Sine_float(_Multiply_ce5f4784040b450499733beaca915393_Out_2_Float, _Sine_3c81889fed534b52996b5063cdc22296_Out_1_Float);
            float _Property_3cdd281375794ed2bcad3550a9c890af_Out_0_Float = _WindStrength;
            float _Multiply_89ad4329fdd44befb161e56947c2670b_Out_2_Float;
            Unity_Multiply_float_float(_Sine_3c81889fed534b52996b5063cdc22296_Out_1_Float, _Property_3cdd281375794ed2bcad3550a9c890af_Out_0_Float, _Multiply_89ad4329fdd44befb161e56947c2670b_Out_2_Float);
            float4 _UV_30b55575e9844728bc3abbcaf84a22ff_Out_0_Vector4 = IN.uv0;
            float _Split_020d1040f8544c0b9d3de77e7fbd9197_R_1_Float = _UV_30b55575e9844728bc3abbcaf84a22ff_Out_0_Vector4[0];
            float _Split_020d1040f8544c0b9d3de77e7fbd9197_G_2_Float = _UV_30b55575e9844728bc3abbcaf84a22ff_Out_0_Vector4[1];
            float _Split_020d1040f8544c0b9d3de77e7fbd9197_B_3_Float = _UV_30b55575e9844728bc3abbcaf84a22ff_Out_0_Vector4[2];
            float _Split_020d1040f8544c0b9d3de77e7fbd9197_A_4_Float = _UV_30b55575e9844728bc3abbcaf84a22ff_Out_0_Vector4[3];
            float _Multiply_17088dc811eb45e4a333912f99b556ec_Out_2_Float;
            Unity_Multiply_float_float(_Multiply_89ad4329fdd44befb161e56947c2670b_Out_2_Float, _Split_020d1040f8544c0b9d3de77e7fbd9197_G_2_Float, _Multiply_17088dc811eb45e4a333912f99b556ec_Out_2_Float);
            float3 _Add_e473a1f67cd1441b9fccfb91c0b5ff75_Out_2_Vector3;
            Unity_Add_float3(IN.WorldSpacePosition, (_Multiply_17088dc811eb45e4a333912f99b556ec_Out_2_Float.xxx), _Add_e473a1f67cd1441b9fccfb91c0b5ff75_Out_2_Vector3);
            float3 _Add_8e06eedaa53749dea4ffc85b774f63ee_Out_2_Vector3;
            Unity_Add_float3(float3(0, 0, 0), _Add_e473a1f67cd1441b9fccfb91c0b5ff75_Out_2_Vector3, _Add_8e06eedaa53749dea4ffc85b774f63ee_Out_2_Vector3);
            float3 _Transform_78fa02a50d4c495cba1111966696417e_Out_1_Vector3;
            _Transform_78fa02a50d4c495cba1111966696417e_Out_1_Vector3 = TransformWorldToObject(_Add_8e06eedaa53749dea4ffc85b774f63ee_Out_2_Vector3.xyz);
            description.Position = _Transform_78fa02a50d4c495cba1111966696417e_Out_1_Vector3;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
            // Graph Pixel
            struct SurfaceDescription
        {
            float3 BaseColor;
            float3 Emission;
            float Alpha;
            float AlphaClipThreshold;
            float3 BentNormal;
            float Smoothness;
            float Occlusion;
            float3 NormalTS;
            float TransmissionMask;
            float Thickness;
            float DiffusionProfileHash;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float4 _Property_35c125abbbcb46e1a2351d8febeb5da1_Out_0_Vector4 = _Albedo;
            UnityTexture2D _Property_bb313b600ca3404fb88a2820878a8482_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Texture2D);
            float4 _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_bb313b600ca3404fb88a2820878a8482_Out_0_Texture2D.tex, _Property_bb313b600ca3404fb88a2820878a8482_Out_0_Texture2D.samplerstate, _Property_bb313b600ca3404fb88a2820878a8482_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_R_4_Float = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4.r;
            float _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_G_5_Float = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4.g;
            float _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_B_6_Float = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4.b;
            float _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_A_7_Float = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4.a;
            float4 _Multiply_c09cca22f04c4a9a996a5ccf8f61afe1_Out_2_Vector4;
            Unity_Multiply_float4_float4(_Property_35c125abbbcb46e1a2351d8febeb5da1_Out_0_Vector4, _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4, _Multiply_c09cca22f04c4a9a996a5ccf8f61afe1_Out_2_Vector4);
            float _Property_925f8cb589d94edda2dcd6b588187f26_Out_0_Float = _Smoothness;
            float _Multiply_a061075fe3794cc5abff5f173997f7f8_Out_2_Float;
            Unity_Multiply_float_float(_Property_925f8cb589d94edda2dcd6b588187f26_Out_0_Float, _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_G_5_Float, _Multiply_a061075fe3794cc5abff5f173997f7f8_Out_2_Float);
            UnityTexture2D _Property_ff2eff189fa74f1f965ec8aca53205ba_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Normal);
            float4 _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_ff2eff189fa74f1f965ec8aca53205ba_Out_0_Texture2D.tex, _Property_ff2eff189fa74f1f965ec8aca53205ba_Out_0_Texture2D.samplerstate, _Property_ff2eff189fa74f1f965ec8aca53205ba_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.rgb = UnpackNormal(_SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4);
            float _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_R_4_Float = _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.r;
            float _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_G_5_Float = _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.g;
            float _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_B_6_Float = _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.b;
            float _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_A_7_Float = _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.a;
            float _Property_915c3b0b5fc04c668c646f2f67b5ab2b_Out_0_Float = _NormalStrength;
            float4 _Multiply_e38eea28614c4b61bfd135ec8591a746_Out_2_Vector4;
            Unity_Multiply_float4_float4(_SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4, (_Property_915c3b0b5fc04c668c646f2f67b5ab2b_Out_0_Float.xxxx), _Multiply_e38eea28614c4b61bfd135ec8591a746_Out_2_Vector4);
            surface.BaseColor = (_Multiply_c09cca22f04c4a9a996a5ccf8f61afe1_Out_2_Vector4.xyz);
            surface.Emission = float3(0, 0, 0);
            surface.Alpha = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_A_7_Float;
            surface.AlphaClipThreshold = 0.5;
            surface.BentNormal = IN.TangentSpaceNormal;
            surface.Smoothness = _Multiply_a061075fe3794cc5abff5f173997f7f8_Out_2_Float;
            surface.Occlusion = 1;
            surface.NormalTS = (_Multiply_e38eea28614c4b61bfd135ec8591a746_Out_2_Vector4.xyz);
            surface.TransmissionMask = 1;
            surface.Thickness = 1;
            surface.DiffusionProfileHash = _DiffusionProfileHash;
            return surface;
        }
        
            // --------------------------------------------------
            // Build Graph Inputs
            #ifdef HAVE_VFX_MODIFICATION
            #define VFX_SRP_ATTRIBUTES AttributesMesh
            #define VaryingsMeshType VaryingsMeshToPS
            #define VFX_SRP_VARYINGS VaryingsMeshType
            #define VFX_SRP_SURFACE_INPUTS FragInputs
            #endif
            
        VertexDescriptionInputs AttributesMeshToVertexDescriptionInputs(AttributesMesh input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
            output.WorldSpacePosition =                         TransformObjectToWorld(input.positionOS);
            output.uv0 =                                        input.uv0;
            output.TimeParameters =                             _TimeParameters.xyz; // Note: in case of animation this will be overwrite (allow to handle motion vector)
        
            return output;
        }
        
        VertexDescription GetVertexDescription(AttributesMesh input, float3 timeParameters
        #ifdef HAVE_VFX_MODIFICATION
            , AttributesElement element
        #endif
        )
        {
            // build graph inputs
            VertexDescriptionInputs vertexDescriptionInputs = AttributesMeshToVertexDescriptionInputs(input);
            // Override time parameters with used one (This is required to correctly handle motion vectors for vertex animation based on time)
            vertexDescriptionInputs.TimeParameters = timeParameters;
        
            // evaluate vertex graph
        #ifdef HAVE_VFX_MODIFICATION
            GraphProperties properties;
            ZERO_INITIALIZE(GraphProperties, properties);
        
            // Fetch the vertex graph properties for the particle instance.
            GetElementVertexProperties(element, properties);
        
            VertexDescription vertexDescription = VertexDescriptionFunction(vertexDescriptionInputs, properties);
        #else
            VertexDescription vertexDescription = VertexDescriptionFunction(vertexDescriptionInputs);
        #endif
            return vertexDescription;
        
        }
        
        AttributesMesh ApplyMeshModification(AttributesMesh input, float3 timeParameters
        #ifdef USE_CUSTOMINTERP_SUBSTRUCT
            #ifdef TESSELLATION_ON
            , inout VaryingsMeshToDS varyings
            #else
            , inout VaryingsMeshToPS varyings
            #endif
        #endif
        #ifdef HAVE_VFX_MODIFICATION
                , AttributesElement element
        #endif
            )
        {
            VertexDescription vertexDescription = GetVertexDescription(input, timeParameters
        #ifdef HAVE_VFX_MODIFICATION
                , element
        #endif
            );
        
            // copy graph output to the results
            input.positionOS = vertexDescription.Position;
            input.normalOS = vertexDescription.Normal;
            input.tangentOS.xyz = vertexDescription.Tangent;
        
            
        
            return input;
        }
        
        #if defined(_ADD_CUSTOM_VELOCITY) // For shader graph custom velocity
        // Return precomputed Velocity in object space
        float3 GetCustomVelocity(AttributesMesh input
        #ifdef HAVE_VFX_MODIFICATION
            , AttributesElement element
        #endif
        )
        {
            VertexDescription vertexDescription = GetVertexDescription(input, _TimeParameters.xyz
        #ifdef HAVE_VFX_MODIFICATION
                , element
        #endif
            );
            return vertexDescription.CustomVelocity;
        }
        #endif
        
        FragInputs BuildFragInputs(VaryingsMeshToPS input)
        {
            FragInputs output;
            ZERO_INITIALIZE(FragInputs, output);
        
            // Init to some default value to make the computer quiet (else it output 'divide by zero' warning even if value is not used).
            // TODO: this is a really poor workaround, but the variable is used in a bunch of places
            // to compute normals which are then passed on elsewhere to compute other values...
            output.tangentToWorld = k_identity3x3;
            output.positionSS = input.positionCS;       // input.positionCS is SV_Position
        
            output.tangentToWorld =             BuildTangentToWorld(input.tangentWS, input.normalWS);
            output.texCoord0 =                  input.texCoord0;
        
        
        #ifdef HAVE_VFX_MODIFICATION
            // FragInputs from VFX come from two places: Interpolator or CBuffer.
        #if VFX_USE_GRAPH_VALUES
            uint instanceActiveIndex = asuint(UNITY_ACCESS_INSTANCED_PROP(PerInstance, _InstanceActiveIndex));
            /* WARNING: $splice Could not find named fragment 'VFXLoadGraphValues' */
        #endif
        
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            // splice point to copy custom interpolator fields from varyings to frag inputs
            
        
            return output;
        }
        
        // existing HDRP code uses the combined function to go directly from packed to frag inputs
        FragInputs UnpackVaryingsMeshToFragInputs(PackedVaryingsMeshToPS input)
        {
            UNITY_SETUP_INSTANCE_ID(input);
        #if defined(HAVE_VFX_MODIFICATION) && defined(UNITY_INSTANCING_ENABLED)
            unity_InstanceID = input.instanceID;
        #endif
            VaryingsMeshToPS unpacked = UnpackVaryingsMeshToPS(input);
            return BuildFragInputs(unpacked);
        }
            SurfaceDescriptionInputs FragInputsToSurfaceDescriptionInputs(FragInputs input, float3 viewWS)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
            #if defined(SHADER_STAGE_RAY_TRACING)
            #else
            #endif
            output.TangentSpaceNormal =                         float3(0.0f, 0.0f, 1.0f);
        
        #if UNITY_UV_STARTS_AT_TOP
        #else
        #endif
        
        
            output.uv0 =                                        input.texCoord0;
        
            // splice point to copy frag inputs custom interpolator pack into the SDI
            
        
            return output;
        }
        
            // --------------------------------------------------
            // Build Surface Data (Specific Material)
        
        void ApplyDecalToSurfaceDataNoNormal(DecalSurfaceData decalSurfaceData, inout SurfaceData surfaceData);
        
        void ApplyDecalAndGetNormal(FragInputs fragInputs, PositionInputs posInput, SurfaceDescription surfaceDescription,
            inout SurfaceData surfaceData)
        {
            float3 doubleSidedConstants = GetDoubleSidedConstants();
        
        #ifdef DECAL_NORMAL_BLENDING
            // SG nodes don't ouptut surface gradients, so if decals require surf grad blending, we have to convert
            // the normal to gradient before applying the decal. We then have to resolve the gradient back to world space
            float3 normalTS;
        
            normalTS = SurfaceGradientFromTangentSpaceNormalAndFromTBN(surfaceDescription.NormalTS,
            fragInputs.tangentToWorld[0], fragInputs.tangentToWorld[1]);
        
        
            #if HAVE_DECALS
            if (_EnableDecals)
            {
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                ApplyDecalToSurfaceNormal(decalSurfaceData, fragInputs.tangentToWorld[2], normalTS);
                ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
            }
            #endif
        
            GetNormalWS_SG(fragInputs, normalTS, surfaceData.normalWS, doubleSidedConstants);
        #else
            // normal delivered to master node
            GetNormalWS(fragInputs, surfaceDescription.NormalTS, surfaceData.normalWS, doubleSidedConstants);
        
            #if HAVE_DECALS
            if (_EnableDecals)
            {
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                // Both uses and modifies 'surfaceData.normalWS'.
                DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                ApplyDecalToSurfaceNormal(decalSurfaceData, surfaceData.normalWS.xyz);
                ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
            }
            #endif
        #endif
        }
        void BuildSurfaceData(FragInputs fragInputs, inout SurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
        {
            ZERO_INITIALIZE(SurfaceData, surfaceData);
        
            // specularOcclusion need to be init ahead of decal to quiet the compiler that modify the SurfaceData struct
            // however specularOcclusion can come from the graph, so need to be init here so it can be override.
            surfaceData.specularOcclusion = 1.0;
            surfaceData.thickness = 0.0;
        
            surfaceData.baseColor =                 surfaceDescription.BaseColor;
            surfaceData.perceptualSmoothness =      surfaceDescription.Smoothness;
            surfaceData.ambientOcclusion =          surfaceDescription.Occlusion;
            surfaceData.transmissionMask =          surfaceDescription.TransmissionMask.xxx;
            surfaceData.thickness =                 surfaceDescription.Thickness;
            surfaceData.diffusionProfileHash =      asuint(surfaceDescription.DiffusionProfileHash);
        
            #if defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE) || defined(_REFRACTION_THIN)
                if (_EnableSSRefraction)
                {
        
                    surfaceData.transmittanceMask = (1.0 - surfaceDescription.Alpha);
                    surfaceDescription.Alpha = 1.0;
                }
                else
                {
                    surfaceData.ior = 1.0;
                    surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                    surfaceData.atDistance = 1.0;
                    surfaceData.transmittanceMask = 0.0;
                    surfaceDescription.Alpha = 1.0;
                }
            #else
                surfaceData.ior = 1.0;
                surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                surfaceData.atDistance = 1.0;
                surfaceData.transmittanceMask = 0.0;
            #endif
        
            // These static material feature allow compile time optimization
            surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;
            #ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
            #endif
        
            #ifdef _MATERIAL_FEATURE_TRANSMISSION
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
            #endif
        
            #ifdef _MATERIAL_FEATURE_COLORED_TRANSMISSION
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_COLORED_TRANSMISSION;
        
            #endif
        
            #ifdef _MATERIAL_FEATURE_ANISOTROPY
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
        
                // Initialize the normal to something non-zero to avoid a div-zero warning for anisotropy.
                surfaceData.normalWS = float3(0, 1, 0);
            #endif
        
            #ifdef _MATERIAL_FEATURE_IRIDESCENCE
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
            #endif
        
            #ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
            #endif
        
            #ifdef _MATERIAL_FEATURE_CLEAR_COAT
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
            #endif
        
            #if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
                // Require to have setup baseColor
                // Reproduce the energy conservation done in legacy Unity. Not ideal but better for compatibility and users can unchek it
                surfaceData.baseColor *= (1.0 - Max3(surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b));
            #endif
        
            float3 doubleSidedConstants = GetDoubleSidedConstants();
        
            ApplyDecalAndGetNormal(fragInputs, posInput, surfaceDescription, surfaceData);
        
            surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];
        
            surfaceData.tangentWS = normalize(fragInputs.tangentToWorld[0].xyz);    // The tangent is not normalize in tangentToWorld for mikkt. TODO: Check if it expected that we normalize with Morten. Tag: SURFACE_GRADIENT
        
        
            bentNormalWS = surfaceData.normalWS;
        
            surfaceData.tangentWS = Orthonormalize(surfaceData.tangentWS, surfaceData.normalWS);
        
            #ifdef DEBUG_DISPLAY
                if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
                {
                    // TODO: need to update mip info
                    surfaceData.metallic = 0;
                }
        
                // We need to call ApplyDebugToSurfaceData after filling the surfarcedata and before filling builtinData
                // as it can modify attribute use for static lighting
                ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData);
            #endif
        
            // By default we use the ambient occlusion with Tri-ace trick (apply outside) for specular occlusion.
            // If user provide bent normal then we process a better term
            #if defined(_SPECULAR_OCCLUSION_CUSTOM)
                // Just use the value passed through via the slot (not active otherwise)
            #elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
                // If we have bent normal and ambient occlusion, process a specular occlusion
                surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO(V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness(surfaceData.perceptualSmoothness));
            #elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
                surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion(ClampNdotV(dot(surfaceData.normalWS, V)), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness(surfaceData.perceptualSmoothness));
            #endif
        
            #if defined(_ENABLE_GEOMETRIC_SPECULAR_AA) && !defined(SHADER_STAGE_RAY_TRACING)
                surfaceData.perceptualSmoothness = GeometricNormalFiltering(surfaceData.perceptualSmoothness, fragInputs.tangentToWorld[2], surfaceDescription.SpecularAAScreenSpaceVariance, surfaceDescription.SpecularAAThreshold);
            #endif
        }
        
            // --------------------------------------------------
            // Get Surface And BuiltinData
        
            void GetSurfaceAndBuiltinData(FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData RAY_TRACING_OPTIONAL_PARAMETERS)
            {
                // Don't dither if displaced tessellation (we're fading out the displacement instead to match the next LOD)
                #if !defined(SHADER_STAGE_RAY_TRACING) && !defined(_TESSELLATION_DISPLACEMENT)
                #ifdef LOD_FADE_CROSSFADE // enable dithering LOD transition if user select CrossFade transition in LOD group
                LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
                #endif
                #endif
        
                #ifndef SHADER_UNLIT
                #ifdef _DOUBLESIDED_ON
                    float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
                #else
                    float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
                #endif
        
                ApplyDoubleSidedFlipOrMirror(fragInputs, doubleSidedConstants); // Apply double sided flip on the vertex normal
                #endif // SHADER_UNLIT
        
                SurfaceDescriptionInputs surfaceDescriptionInputs = FragInputsToSurfaceDescriptionInputs(fragInputs, V);
        
                #if defined(HAVE_VFX_MODIFICATION)
                GraphProperties properties;
                ZERO_INITIALIZE(GraphProperties, properties);
        
                GetElementPixelProperties(fragInputs, properties);
        
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs, properties);
                #else
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs);
                #endif
        
                // Perform alpha test very early to save performance (a killed pixel will not sample textures)
                // TODO: split graph evaluation to grab just alpha dependencies first? tricky..
                #ifdef _ALPHATEST_ON
                    float alphaCutoff = surfaceDescription.AlphaClipThreshold;
                    #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
                    // The TransparentDepthPrepass is also used with SSR transparent.
                    // If an artists enable transaprent SSR but not the TransparentDepthPrepass itself, then we use AlphaClipThreshold
                    // otherwise if TransparentDepthPrepass is enabled we use AlphaClipThresholdDepthPrepass
                    #elif SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_POSTPASS
                    // DepthPostpass always use its own alpha threshold
                    alphaCutoff = surfaceDescription.AlphaClipThresholdDepthPostpass;
                    #elif (SHADERPASS == SHADERPASS_SHADOWS) || (SHADERPASS == SHADERPASS_RAYTRACING_VISIBILITY)
                    // If use shadow threshold isn't enable we don't allow any test
                    #endif
        
                    GENERIC_ALPHA_TEST(surfaceDescription.Alpha, alphaCutoff);
                #endif
        
                #if !defined(SHADER_STAGE_RAY_TRACING) && _DEPTHOFFSET_ON
                ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
                #endif
        
                #ifndef SHADER_UNLIT
                float3 bentNormalWS;
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS);
        
                #ifdef FRAG_INPUTS_USE_TEXCOORD1
                    float4 lightmapTexCoord1 = fragInputs.texCoord1;
                #else
                    float4 lightmapTexCoord1 = float4(0,0,0,0);
                #endif
        
                #ifdef FRAG_INPUTS_USE_TEXCOORD2
                    float4 lightmapTexCoord2 = fragInputs.texCoord2;
                #else
                    float4 lightmapTexCoord2 = float4(0,0,0,0);
                #endif
        
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                // Builtin Data
                // For back lighting we use the oposite vertex normal
                InitBuiltinData(posInput, alpha, bentNormalWS, -fragInputs.tangentToWorld[2], lightmapTexCoord1, lightmapTexCoord2, builtinData);
        
                #else
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData);
        
                ZERO_BUILTIN_INITIALIZE(builtinData); // No call to InitBuiltinData as we don't have any lighting
                builtinData.opacity = surfaceDescription.Alpha;
        
                #if defined(DEBUG_DISPLAY)
                    // Light Layers are currently not used for the Unlit shader (because it is not lit)
                    // But Unlit objects do cast shadows according to their rendering layer mask, which is what we want to
                    // display in the light layers visualization mode, therefore we need the renderingLayers
                    builtinData.renderingLayers = GetMeshRenderingLayerMask();
                #endif
        
                #endif // SHADER_UNLIT
        
                #ifdef _ALPHATEST_ON
                    // Used for sharpening by alpha to mask - Alpha to covertage is only used with depth only and forward pass (no shadow pass, no transparent pass)
                    builtinData.alphaClipTreshold = alphaCutoff;
                #endif
        
                // override sampleBakedGI - not used by Unlit
        		// When overriding GI, we need to force the isLightmap flag to make sure we don't add APV (sampled in the lightloop) on top of the overridden value (set at GBuffer stage)
        
                builtinData.emissiveColor = surfaceDescription.Emission;
        
                // Note this will not fully work on transparent surfaces (can check with _SURFACE_TYPE_TRANSPARENT define)
                // We will always overwrite vt feeback with the nearest. So behind transparent surfaces vt will not be resolved
                // This is a limitation of the current MRT approach.
                #ifdef UNITY_VIRTUAL_TEXTURING
                #endif
        
                #if _DEPTHOFFSET_ON
                builtinData.depthOffset = surfaceDescription.DepthOffset;
                #endif
        
                // TODO: We should generate distortion / distortionBlur for non distortion pass
                #if (SHADERPASS == SHADERPASS_DISTORTION)
                builtinData.distortion = surfaceDescription.Distortion;
                builtinData.distortionBlur = surfaceDescription.DistortionBlur;
                #endif
        
                #ifndef SHADER_UNLIT
                // PostInitBuiltinData call ApplyDebugToBuiltinData
                PostInitBuiltinData(V, posInput, surfaceData, builtinData);
                #else
                ApplyDebugToBuiltinData(builtinData);
                #endif
        
                RAY_TRACING_OPTIONAL_ALPHA_TEST_PASS
            }
        
            // --------------------------------------------------
            // Main
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPassDepthOnly.hlsl"
        
            // --------------------------------------------------
            // Visual Effect Vertex Invocations
        
        	#ifdef HAVE_VFX_MODIFICATION
                #if !defined(SHADER_STAGE_RAY_TRACING)
        	    #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/VisualEffectVertex.hlsl"
                #else
                #endif
        	#endif
        
            #include "Assets/VegetationInstancer/Shaders/Include/GPUInstancedIndirectInclude.cginc"
#pragma instancing_options procedural:setupGPUInstancedIndirect
#pragma multi_compile_instancing
ENDHLSL
        }
        Pass
        {
            Name "SceneSelectionPass"
            Tags
            {
                "LightMode" = "SceneSelectionPass"
            }
        
            // Render State
            Cull Off
        
            // Debug
            // <None>
        
            // --------------------------------------------------
            // Pass
        
            HLSLPROGRAM
        
            // Pragmas
            #pragma multi_compile _ DOTS_INSTANCING_ON
        #pragma editor_sync_compilation
        
        #pragma target 4.5
        #pragma vertex Vert
        #pragma fragment Frag
        #pragma only_renderers d3d11 playstation xboxone xboxseries vulkan metal switch
        
        
            // Keywords
            #pragma shader_feature_local _ _ALPHATEST_ON
        #pragma shader_feature _ _SURFACE_TYPE_TRANSPARENT
        #pragma shader_feature_local _ _DOUBLESIDED_ON
        #pragma shader_feature_local _ _ADD_PRECOMPUTED_VELOCITY
        #pragma shader_feature_local _ _TRANSPARENT_WRITES_MOTION_VEC _TRANSPARENT_REFRACTIVE_SORT
        #pragma shader_feature_local_fragment _ _ENABLE_FOG_ON_TRANSPARENT
        #pragma shader_feature_local_fragment _ _DISABLE_DECALS
        #pragma shader_feature_local_raytracing _ _DISABLE_DECALS
        #pragma shader_feature_local_fragment _ _DISABLE_SSR
        #pragma shader_feature_local_raytracing _ _DISABLE_SSR
        #pragma shader_feature_local_fragment _ _DISABLE_SSR_TRANSPARENT
        #pragma shader_feature_local_raytracing _ _DISABLE_SSR_TRANSPARENT
        #pragma shader_feature_local _ _REFRACTION_PLANE _REFRACTION_SPHERE _REFRACTION_THIN
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_TRANSMISSION
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_TRANSMISSION
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_ANISOTROPY
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_ANISOTROPY
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_IRIDESCENCE
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_IRIDESCENCE
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_SPECULAR_COLOR
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_SPECULAR_COLOR
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_COLORED_TRANSMISSION
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_COLORED_TRANSMISSION
            // GraphKeywords: <None>
        
            // Defines
            #define SHADERPASS SHADERPASS_DEPTH_ONLY
        #define RAYTRACING_SHADER_GRAPH_DEFAULT
        #define SCENESELECTIONPASS 1
        
            // For custom interpolators to inject a substruct definition before FragInputs definition,
            // allowing for FragInputs to capture CI's intended for ShaderGraph's SDI.
            struct CustomInterpolators
        {
        };
        #define USE_CUSTOMINTERP_SUBSTRUCT
        
        
        
            // TODO: Merge FragInputsVFX substruct with CustomInterpolators.
        	#ifdef HAVE_VFX_MODIFICATION
        	struct FragInputsVFX
            {
                /* WARNING: $splice Could not find named fragment 'FragInputsVFX' */
            };
            #endif
        
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl" // Required by Tessellation.hlsl
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Tessellation.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl" // Required to be include before we include properties as it define DECLARE_STACK_CB
            // Always include Shader Graph version
            // Always include last to avoid double macros
            #include "Packages/com.unity.shadergraph/ShaderGraphLibrary/Functions.hlsl" // Need to be here for Gradient struct definition
        
            // --------------------------------------------------
            // Defines
        
            // Attribute
            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define ATTRIBUTES_NEED_TEXCOORD0
            #define VARYINGS_NEED_TEXCOORD0
        
            #define HAVE_MESH_MODIFICATION
        
            //Strip down the FragInputs.hlsl (on graphics), so we can only optimize the interpolators we use.
            //if by accident something requests contents of FragInputs.hlsl, it will be caught as a compiler error
            //Frag inputs stripping is only enabled when FRAG_INPUTS_ENABLE_STRIPPING is set
            #if !defined(SHADER_STAGE_RAY_TRACING) && SHADERPASS != SHADERPASS_RAYTRACING_GBUFFER && SHADERPASS != SHADERPASS_FULL_SCREEN_DEBUG
            #define FRAG_INPUTS_ENABLE_STRIPPING
            #endif
            #define FRAG_INPUTS_USE_TEXCOORD0
        
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
        
        
        
        
            // Following two define are a workaround introduce in 10.1.x for RaytracingQualityNode
            // The ShaderGraph don't support correctly migration of this node as it serialize all the node data
            // in the json file making it impossible to uprgrade. Until we get a fix, we do a workaround here
            // to still allow us to rename the field and keyword of this node without breaking existing code.
            #ifdef RAYTRACING_SHADER_GRAPH_DEFAULT
            #define RAYTRACING_SHADER_GRAPH_HIGH
            #endif
        
            #ifdef RAYTRACING_SHADER_GRAPH_RAYTRACED
            #define RAYTRACING_SHADER_GRAPH_LOW
            #endif
            // end
        
            #ifndef SHADER_UNLIT
            // We need isFrontFace when using double sided - it is not required for unlit as in case of unlit double sided only drive the cullmode
            // VARYINGS_NEED_CULLFACE can be define by VaryingsMeshToPS.FaceSign input if a IsFrontFace Node is included in the shader graph.
            #if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
                #define VARYINGS_NEED_CULLFACE
            #endif
            #endif
        
            // Specific Material Define
        #define _SPECULAR_OCCLUSION_FROM_AO 1
        #define _ENERGY_CONSERVING_SPECULAR 1
        
        #if _MATERIAL_FEATURE_COLORED_TRANSMISSION
            // Colored Transmission doesn't support clear coat
            #undef _MATERIAL_FEATURE_CLEAR_COAT
        #endif
        
        // If we use subsurface scattering, enable output split lighting (for forward pass)
        #if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
            #define OUTPUT_SPLIT_LIGHTING
        #endif
        
        // This shader support recursive rendering for raytracing
        #define HAVE_RECURSIVE_RENDERING
        
        // In Path Tracing, For all single-sided, refractive materials, we want to force a thin refraction model
        #if (SHADERPASS == SHADERPASS_PATH_TRACING) && !defined(_DOUBLESIDED_ON) && (defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE))
            #undef  _REFRACTION_PLANE
            #undef  _REFRACTION_SPHERE
            #define _REFRACTION_THIN
        #endif
            // Caution: we can use the define SHADER_UNLIT onlit after the above Material include as it is the Unlit template who define it
        
            // To handle SSR on transparent correctly with a possibility to enable/disable it per framesettings
            // we should have a code like this:
            // if !defined(_DISABLE_SSR_TRANSPARENT)
            // pragma multi_compile _ WRITE_NORMAL_BUFFER
            // endif
            // i.e we enable the multicompile only if we can receive SSR or not, and then C# code drive
            // it based on if SSR transparent in frame settings and not (and stripper can strip it).
            // this is currently not possible with our current preprocessor as _DISABLE_SSR_TRANSPARENT is a keyword not a define
            // so instead we used this and chose to pay the extra cost of normal write even if SSR transaprent is disabled.
            // Ideally the shader graph generator should handle it but condition below can't be handle correctly for now.
            #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
            #if !defined(_DISABLE_SSR_TRANSPARENT) && !defined(SHADER_UNLIT)
                #define WRITE_NORMAL_BUFFER
            #endif
            #endif
        
            // See Lit.shader
            #if SHADERPASS == SHADERPASS_MOTION_VECTORS && defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)
                #define WRITE_DECAL_BUFFER
            #endif
        
            #ifndef DEBUG_DISPLAY
                // In case of opaque we don't want to perform the alpha test, it is done in depth prepass and we use depth equal for ztest (setup from UI)
                // Don't do it with debug display mode as it is possible there is no depth prepass in this case
                #if !defined(_SURFACE_TYPE_TRANSPARENT)
                    #if SHADERPASS == SHADERPASS_FORWARD
                    #define SHADERPASS_FORWARD_BYPASS_ALPHA_TEST
                    #elif SHADERPASS == SHADERPASS_GBUFFER
                    #define SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST
                    #endif
                #endif
            #endif
        
            // Define _DEFERRED_CAPABLE_MATERIAL for shader capable to run in deferred pass
            #if defined(SHADER_LIT) && !defined(_SURFACE_TYPE_TRANSPARENT)
                #define _DEFERRED_CAPABLE_MATERIAL
            #endif
        
            // Translate transparent motion vector define
            #if (defined(_TRANSPARENT_WRITES_MOTION_VEC) || defined(_TRANSPARENT_REFRACTIVE_SORT)) && defined(_SURFACE_TYPE_TRANSPARENT)
                #define _WRITE_TRANSPARENT_MOTION_VECTOR
            #endif
        
            // -- Graph Properties
            CBUFFER_START(UnityPerMaterial)
        float4 _DiffusionProfileAsset;
        float _DiffusionProfileHash;
        float4 _Texture2D_TexelSize;
        float4 _Albedo;
        float _Smoothness;
        float _WindSpeed;
        float _WindStrength;
        float4 _Normal_TexelSize;
        float _NormalStrength;
        float4 _EmissionColor;
        float _UseShadowThreshold;
        float4 _DoubleSidedConstants;
        float _BlendMode;
        float _EnableBlendModePreserveSpecularLighting;
        float _RayTracing;
        float _RefractionModel;
        float _MaterialID;
        float _MaterialTypeMask;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_Texture2D);
        SAMPLER(sampler_Texture2D);
        TEXTURE2D(_Normal);
        SAMPLER(sampler_Normal);
        
            // -- Property used by ScenePickingPass
            #ifdef SCENEPICKINGPASS
            float4 _SelectionID;
            #endif
        
            // -- Properties used by SceneSelectionPass
            #ifdef SCENESELECTIONPASS
            int _ObjectId;
            int _PassValue;
            #endif
        
            // Includes
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/PickingSpaceTransforms.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitDecalData.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"
        	// GraphIncludes: <None>
        
            // --------------------------------------------------
            // Structs and Packing
        
            struct AttributesMesh
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct VaryingsMeshToPS
        {
            SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
             float4 texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
             float3 WorldSpacePosition;
             float4 uv0;
             float3 TimeParameters;
        };
        struct SurfaceDescriptionInputs
        {
             float3 TangentSpaceNormal;
             float4 uv0;
        };
        struct PackedVaryingsMeshToPS
        {
            SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
             float4 texCoord0 : INTERP0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
        };
        
            PackedVaryingsMeshToPS PackVaryingsMeshToPS (VaryingsMeshToPS input)
        {
            PackedVaryingsMeshToPS output;
            ZERO_INITIALIZE(PackedVaryingsMeshToPS, output);
            output.positionCS = input.positionCS;
            output.texCoord0.xyzw = input.texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            return output;
        }
        
        VaryingsMeshToPS UnpackVaryingsMeshToPS (PackedVaryingsMeshToPS input)
        {
            VaryingsMeshToPS output;
            output.positionCS = input.positionCS;
            output.texCoord0 = input.texCoord0.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            return output;
        }
        
        
            // --------------------------------------------------
            // Graph
        
        
            // Graph Functions
            
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_Sine_float(float In, out float Out)
        {
            Out = sin(In);
        }
        
        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }
        
        void Unity_Multiply_float4_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }
        
            // Graph Vertex
            struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            float _Property_8c596e62dce249caa7922ff3d7470d43_Out_0_Float = _WindSpeed;
            float _Split_35af25740d5a404097ccb209d36d5cac_R_1_Float = IN.WorldSpacePosition[0];
            float _Split_35af25740d5a404097ccb209d36d5cac_G_2_Float = IN.WorldSpacePosition[1];
            float _Split_35af25740d5a404097ccb209d36d5cac_B_3_Float = IN.WorldSpacePosition[2];
            float _Split_35af25740d5a404097ccb209d36d5cac_A_4_Float = 0;
            float _Add_c678bc9d08684d01a8e45ad5e636b4b4_Out_2_Float;
            Unity_Add_float(_Split_35af25740d5a404097ccb209d36d5cac_R_1_Float, _Split_35af25740d5a404097ccb209d36d5cac_B_3_Float, _Add_c678bc9d08684d01a8e45ad5e636b4b4_Out_2_Float);
            float _Add_0ec2f296c670483e9dc4250c81fe62a0_Out_2_Float;
            Unity_Add_float(IN.TimeParameters.x, _Add_c678bc9d08684d01a8e45ad5e636b4b4_Out_2_Float, _Add_0ec2f296c670483e9dc4250c81fe62a0_Out_2_Float);
            float _Multiply_ce5f4784040b450499733beaca915393_Out_2_Float;
            Unity_Multiply_float_float(_Property_8c596e62dce249caa7922ff3d7470d43_Out_0_Float, _Add_0ec2f296c670483e9dc4250c81fe62a0_Out_2_Float, _Multiply_ce5f4784040b450499733beaca915393_Out_2_Float);
            float _Sine_3c81889fed534b52996b5063cdc22296_Out_1_Float;
            Unity_Sine_float(_Multiply_ce5f4784040b450499733beaca915393_Out_2_Float, _Sine_3c81889fed534b52996b5063cdc22296_Out_1_Float);
            float _Property_3cdd281375794ed2bcad3550a9c890af_Out_0_Float = _WindStrength;
            float _Multiply_89ad4329fdd44befb161e56947c2670b_Out_2_Float;
            Unity_Multiply_float_float(_Sine_3c81889fed534b52996b5063cdc22296_Out_1_Float, _Property_3cdd281375794ed2bcad3550a9c890af_Out_0_Float, _Multiply_89ad4329fdd44befb161e56947c2670b_Out_2_Float);
            float4 _UV_30b55575e9844728bc3abbcaf84a22ff_Out_0_Vector4 = IN.uv0;
            float _Split_020d1040f8544c0b9d3de77e7fbd9197_R_1_Float = _UV_30b55575e9844728bc3abbcaf84a22ff_Out_0_Vector4[0];
            float _Split_020d1040f8544c0b9d3de77e7fbd9197_G_2_Float = _UV_30b55575e9844728bc3abbcaf84a22ff_Out_0_Vector4[1];
            float _Split_020d1040f8544c0b9d3de77e7fbd9197_B_3_Float = _UV_30b55575e9844728bc3abbcaf84a22ff_Out_0_Vector4[2];
            float _Split_020d1040f8544c0b9d3de77e7fbd9197_A_4_Float = _UV_30b55575e9844728bc3abbcaf84a22ff_Out_0_Vector4[3];
            float _Multiply_17088dc811eb45e4a333912f99b556ec_Out_2_Float;
            Unity_Multiply_float_float(_Multiply_89ad4329fdd44befb161e56947c2670b_Out_2_Float, _Split_020d1040f8544c0b9d3de77e7fbd9197_G_2_Float, _Multiply_17088dc811eb45e4a333912f99b556ec_Out_2_Float);
            float3 _Add_e473a1f67cd1441b9fccfb91c0b5ff75_Out_2_Vector3;
            Unity_Add_float3(IN.WorldSpacePosition, (_Multiply_17088dc811eb45e4a333912f99b556ec_Out_2_Float.xxx), _Add_e473a1f67cd1441b9fccfb91c0b5ff75_Out_2_Vector3);
            float3 _Add_8e06eedaa53749dea4ffc85b774f63ee_Out_2_Vector3;
            Unity_Add_float3(float3(0, 0, 0), _Add_e473a1f67cd1441b9fccfb91c0b5ff75_Out_2_Vector3, _Add_8e06eedaa53749dea4ffc85b774f63ee_Out_2_Vector3);
            float3 _Transform_78fa02a50d4c495cba1111966696417e_Out_1_Vector3;
            _Transform_78fa02a50d4c495cba1111966696417e_Out_1_Vector3 = TransformWorldToObject(_Add_8e06eedaa53749dea4ffc85b774f63ee_Out_2_Vector3.xyz);
            description.Position = _Transform_78fa02a50d4c495cba1111966696417e_Out_1_Vector3;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
            // Graph Pixel
            struct SurfaceDescription
        {
            float3 BaseColor;
            float3 Emission;
            float Alpha;
            float AlphaClipThreshold;
            float3 BentNormal;
            float Smoothness;
            float Occlusion;
            float3 NormalTS;
            float TransmissionMask;
            float Thickness;
            float DiffusionProfileHash;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float4 _Property_35c125abbbcb46e1a2351d8febeb5da1_Out_0_Vector4 = _Albedo;
            UnityTexture2D _Property_bb313b600ca3404fb88a2820878a8482_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Texture2D);
            float4 _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_bb313b600ca3404fb88a2820878a8482_Out_0_Texture2D.tex, _Property_bb313b600ca3404fb88a2820878a8482_Out_0_Texture2D.samplerstate, _Property_bb313b600ca3404fb88a2820878a8482_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_R_4_Float = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4.r;
            float _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_G_5_Float = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4.g;
            float _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_B_6_Float = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4.b;
            float _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_A_7_Float = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4.a;
            float4 _Multiply_c09cca22f04c4a9a996a5ccf8f61afe1_Out_2_Vector4;
            Unity_Multiply_float4_float4(_Property_35c125abbbcb46e1a2351d8febeb5da1_Out_0_Vector4, _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4, _Multiply_c09cca22f04c4a9a996a5ccf8f61afe1_Out_2_Vector4);
            float _Property_925f8cb589d94edda2dcd6b588187f26_Out_0_Float = _Smoothness;
            float _Multiply_a061075fe3794cc5abff5f173997f7f8_Out_2_Float;
            Unity_Multiply_float_float(_Property_925f8cb589d94edda2dcd6b588187f26_Out_0_Float, _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_G_5_Float, _Multiply_a061075fe3794cc5abff5f173997f7f8_Out_2_Float);
            UnityTexture2D _Property_ff2eff189fa74f1f965ec8aca53205ba_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Normal);
            float4 _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_ff2eff189fa74f1f965ec8aca53205ba_Out_0_Texture2D.tex, _Property_ff2eff189fa74f1f965ec8aca53205ba_Out_0_Texture2D.samplerstate, _Property_ff2eff189fa74f1f965ec8aca53205ba_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.rgb = UnpackNormal(_SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4);
            float _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_R_4_Float = _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.r;
            float _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_G_5_Float = _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.g;
            float _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_B_6_Float = _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.b;
            float _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_A_7_Float = _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.a;
            float _Property_915c3b0b5fc04c668c646f2f67b5ab2b_Out_0_Float = _NormalStrength;
            float4 _Multiply_e38eea28614c4b61bfd135ec8591a746_Out_2_Vector4;
            Unity_Multiply_float4_float4(_SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4, (_Property_915c3b0b5fc04c668c646f2f67b5ab2b_Out_0_Float.xxxx), _Multiply_e38eea28614c4b61bfd135ec8591a746_Out_2_Vector4);
            surface.BaseColor = (_Multiply_c09cca22f04c4a9a996a5ccf8f61afe1_Out_2_Vector4.xyz);
            surface.Emission = float3(0, 0, 0);
            surface.Alpha = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_A_7_Float;
            surface.AlphaClipThreshold = 0.5;
            surface.BentNormal = IN.TangentSpaceNormal;
            surface.Smoothness = _Multiply_a061075fe3794cc5abff5f173997f7f8_Out_2_Float;
            surface.Occlusion = 1;
            surface.NormalTS = (_Multiply_e38eea28614c4b61bfd135ec8591a746_Out_2_Vector4.xyz);
            surface.TransmissionMask = 1;
            surface.Thickness = 1;
            surface.DiffusionProfileHash = _DiffusionProfileHash;
            return surface;
        }
        
            // --------------------------------------------------
            // Build Graph Inputs
            #ifdef HAVE_VFX_MODIFICATION
            #define VFX_SRP_ATTRIBUTES AttributesMesh
            #define VaryingsMeshType VaryingsMeshToPS
            #define VFX_SRP_VARYINGS VaryingsMeshType
            #define VFX_SRP_SURFACE_INPUTS FragInputs
            #endif
            
        VertexDescriptionInputs AttributesMeshToVertexDescriptionInputs(AttributesMesh input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
            output.WorldSpacePosition =                         TransformObjectToWorld(input.positionOS);
            output.uv0 =                                        input.uv0;
            output.TimeParameters =                             _TimeParameters.xyz; // Note: in case of animation this will be overwrite (allow to handle motion vector)
        
            return output;
        }
        
        VertexDescription GetVertexDescription(AttributesMesh input, float3 timeParameters
        #ifdef HAVE_VFX_MODIFICATION
            , AttributesElement element
        #endif
        )
        {
            // build graph inputs
            VertexDescriptionInputs vertexDescriptionInputs = AttributesMeshToVertexDescriptionInputs(input);
            // Override time parameters with used one (This is required to correctly handle motion vectors for vertex animation based on time)
            vertexDescriptionInputs.TimeParameters = timeParameters;
        
            // evaluate vertex graph
        #ifdef HAVE_VFX_MODIFICATION
            GraphProperties properties;
            ZERO_INITIALIZE(GraphProperties, properties);
        
            // Fetch the vertex graph properties for the particle instance.
            GetElementVertexProperties(element, properties);
        
            VertexDescription vertexDescription = VertexDescriptionFunction(vertexDescriptionInputs, properties);
        #else
            VertexDescription vertexDescription = VertexDescriptionFunction(vertexDescriptionInputs);
        #endif
            return vertexDescription;
        
        }
        
        AttributesMesh ApplyMeshModification(AttributesMesh input, float3 timeParameters
        #ifdef USE_CUSTOMINTERP_SUBSTRUCT
            #ifdef TESSELLATION_ON
            , inout VaryingsMeshToDS varyings
            #else
            , inout VaryingsMeshToPS varyings
            #endif
        #endif
        #ifdef HAVE_VFX_MODIFICATION
                , AttributesElement element
        #endif
            )
        {
            VertexDescription vertexDescription = GetVertexDescription(input, timeParameters
        #ifdef HAVE_VFX_MODIFICATION
                , element
        #endif
            );
        
            // copy graph output to the results
            input.positionOS = vertexDescription.Position;
            input.normalOS = vertexDescription.Normal;
            input.tangentOS.xyz = vertexDescription.Tangent;
        
            
        
            return input;
        }
        
        #if defined(_ADD_CUSTOM_VELOCITY) // For shader graph custom velocity
        // Return precomputed Velocity in object space
        float3 GetCustomVelocity(AttributesMesh input
        #ifdef HAVE_VFX_MODIFICATION
            , AttributesElement element
        #endif
        )
        {
            VertexDescription vertexDescription = GetVertexDescription(input, _TimeParameters.xyz
        #ifdef HAVE_VFX_MODIFICATION
                , element
        #endif
            );
            return vertexDescription.CustomVelocity;
        }
        #endif
        
        FragInputs BuildFragInputs(VaryingsMeshToPS input)
        {
            FragInputs output;
            ZERO_INITIALIZE(FragInputs, output);
        
            // Init to some default value to make the computer quiet (else it output 'divide by zero' warning even if value is not used).
            // TODO: this is a really poor workaround, but the variable is used in a bunch of places
            // to compute normals which are then passed on elsewhere to compute other values...
            output.tangentToWorld = k_identity3x3;
            output.positionSS = input.positionCS;       // input.positionCS is SV_Position
        
            output.texCoord0 =                  input.texCoord0;
        
        
        #ifdef HAVE_VFX_MODIFICATION
            // FragInputs from VFX come from two places: Interpolator or CBuffer.
        #if VFX_USE_GRAPH_VALUES
            uint instanceActiveIndex = asuint(UNITY_ACCESS_INSTANCED_PROP(PerInstance, _InstanceActiveIndex));
            /* WARNING: $splice Could not find named fragment 'VFXLoadGraphValues' */
        #endif
        
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            // splice point to copy custom interpolator fields from varyings to frag inputs
            
        
            return output;
        }
        
        // existing HDRP code uses the combined function to go directly from packed to frag inputs
        FragInputs UnpackVaryingsMeshToFragInputs(PackedVaryingsMeshToPS input)
        {
            UNITY_SETUP_INSTANCE_ID(input);
        #if defined(HAVE_VFX_MODIFICATION) && defined(UNITY_INSTANCING_ENABLED)
            unity_InstanceID = input.instanceID;
        #endif
            VaryingsMeshToPS unpacked = UnpackVaryingsMeshToPS(input);
            return BuildFragInputs(unpacked);
        }
            SurfaceDescriptionInputs FragInputsToSurfaceDescriptionInputs(FragInputs input, float3 viewWS)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
            #if defined(SHADER_STAGE_RAY_TRACING)
            #else
            #endif
            output.TangentSpaceNormal =                         float3(0.0f, 0.0f, 1.0f);
        
        #if UNITY_UV_STARTS_AT_TOP
        #else
        #endif
        
        
            output.uv0 =                                        input.texCoord0;
        
            // splice point to copy frag inputs custom interpolator pack into the SDI
            
        
            return output;
        }
        
            // --------------------------------------------------
            // Build Surface Data (Specific Material)
        
        void ApplyDecalToSurfaceDataNoNormal(DecalSurfaceData decalSurfaceData, inout SurfaceData surfaceData);
        
        void ApplyDecalAndGetNormal(FragInputs fragInputs, PositionInputs posInput, SurfaceDescription surfaceDescription,
            inout SurfaceData surfaceData)
        {
            float3 doubleSidedConstants = GetDoubleSidedConstants();
        
        #ifdef DECAL_NORMAL_BLENDING
            // SG nodes don't ouptut surface gradients, so if decals require surf grad blending, we have to convert
            // the normal to gradient before applying the decal. We then have to resolve the gradient back to world space
            float3 normalTS;
        
            normalTS = SurfaceGradientFromTangentSpaceNormalAndFromTBN(surfaceDescription.NormalTS,
            fragInputs.tangentToWorld[0], fragInputs.tangentToWorld[1]);
        
        
            #if HAVE_DECALS
            if (_EnableDecals)
            {
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                ApplyDecalToSurfaceNormal(decalSurfaceData, fragInputs.tangentToWorld[2], normalTS);
                ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
            }
            #endif
        
            GetNormalWS_SG(fragInputs, normalTS, surfaceData.normalWS, doubleSidedConstants);
        #else
            // normal delivered to master node
            GetNormalWS(fragInputs, surfaceDescription.NormalTS, surfaceData.normalWS, doubleSidedConstants);
        
            #if HAVE_DECALS
            if (_EnableDecals)
            {
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                // Both uses and modifies 'surfaceData.normalWS'.
                DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                ApplyDecalToSurfaceNormal(decalSurfaceData, surfaceData.normalWS.xyz);
                ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
            }
            #endif
        #endif
        }
        void BuildSurfaceData(FragInputs fragInputs, inout SurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
        {
            ZERO_INITIALIZE(SurfaceData, surfaceData);
        
            // specularOcclusion need to be init ahead of decal to quiet the compiler that modify the SurfaceData struct
            // however specularOcclusion can come from the graph, so need to be init here so it can be override.
            surfaceData.specularOcclusion = 1.0;
            surfaceData.thickness = 0.0;
        
            surfaceData.baseColor =                 surfaceDescription.BaseColor;
            surfaceData.perceptualSmoothness =      surfaceDescription.Smoothness;
            surfaceData.ambientOcclusion =          surfaceDescription.Occlusion;
            surfaceData.transmissionMask =          surfaceDescription.TransmissionMask.xxx;
            surfaceData.thickness =                 surfaceDescription.Thickness;
            surfaceData.diffusionProfileHash =      asuint(surfaceDescription.DiffusionProfileHash);
        
            #if defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE) || defined(_REFRACTION_THIN)
                if (_EnableSSRefraction)
                {
        
                    surfaceData.transmittanceMask = (1.0 - surfaceDescription.Alpha);
                    surfaceDescription.Alpha = 1.0;
                }
                else
                {
                    surfaceData.ior = 1.0;
                    surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                    surfaceData.atDistance = 1.0;
                    surfaceData.transmittanceMask = 0.0;
                    surfaceDescription.Alpha = 1.0;
                }
            #else
                surfaceData.ior = 1.0;
                surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                surfaceData.atDistance = 1.0;
                surfaceData.transmittanceMask = 0.0;
            #endif
        
            // These static material feature allow compile time optimization
            surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;
            #ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
            #endif
        
            #ifdef _MATERIAL_FEATURE_TRANSMISSION
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
            #endif
        
            #ifdef _MATERIAL_FEATURE_COLORED_TRANSMISSION
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_COLORED_TRANSMISSION;
        
            #endif
        
            #ifdef _MATERIAL_FEATURE_ANISOTROPY
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
        
                // Initialize the normal to something non-zero to avoid a div-zero warning for anisotropy.
                surfaceData.normalWS = float3(0, 1, 0);
            #endif
        
            #ifdef _MATERIAL_FEATURE_IRIDESCENCE
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
            #endif
        
            #ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
            #endif
        
            #ifdef _MATERIAL_FEATURE_CLEAR_COAT
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
            #endif
        
            #if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
                // Require to have setup baseColor
                // Reproduce the energy conservation done in legacy Unity. Not ideal but better for compatibility and users can unchek it
                surfaceData.baseColor *= (1.0 - Max3(surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b));
            #endif
        
            float3 doubleSidedConstants = GetDoubleSidedConstants();
        
            ApplyDecalAndGetNormal(fragInputs, posInput, surfaceDescription, surfaceData);
        
            surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];
        
            surfaceData.tangentWS = normalize(fragInputs.tangentToWorld[0].xyz);    // The tangent is not normalize in tangentToWorld for mikkt. TODO: Check if it expected that we normalize with Morten. Tag: SURFACE_GRADIENT
        
        
            bentNormalWS = surfaceData.normalWS;
        
            surfaceData.tangentWS = Orthonormalize(surfaceData.tangentWS, surfaceData.normalWS);
        
            #ifdef DEBUG_DISPLAY
                if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
                {
                    // TODO: need to update mip info
                    surfaceData.metallic = 0;
                }
        
                // We need to call ApplyDebugToSurfaceData after filling the surfarcedata and before filling builtinData
                // as it can modify attribute use for static lighting
                ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData);
            #endif
        
            // By default we use the ambient occlusion with Tri-ace trick (apply outside) for specular occlusion.
            // If user provide bent normal then we process a better term
            #if defined(_SPECULAR_OCCLUSION_CUSTOM)
                // Just use the value passed through via the slot (not active otherwise)
            #elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
                // If we have bent normal and ambient occlusion, process a specular occlusion
                surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO(V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness(surfaceData.perceptualSmoothness));
            #elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
                surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion(ClampNdotV(dot(surfaceData.normalWS, V)), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness(surfaceData.perceptualSmoothness));
            #endif
        
            #if defined(_ENABLE_GEOMETRIC_SPECULAR_AA) && !defined(SHADER_STAGE_RAY_TRACING)
                surfaceData.perceptualSmoothness = GeometricNormalFiltering(surfaceData.perceptualSmoothness, fragInputs.tangentToWorld[2], surfaceDescription.SpecularAAScreenSpaceVariance, surfaceDescription.SpecularAAThreshold);
            #endif
        }
        
            // --------------------------------------------------
            // Get Surface And BuiltinData
        
            void GetSurfaceAndBuiltinData(FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData RAY_TRACING_OPTIONAL_PARAMETERS)
            {
                // Don't dither if displaced tessellation (we're fading out the displacement instead to match the next LOD)
                #if !defined(SHADER_STAGE_RAY_TRACING) && !defined(_TESSELLATION_DISPLACEMENT)
                #ifdef LOD_FADE_CROSSFADE // enable dithering LOD transition if user select CrossFade transition in LOD group
                LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
                #endif
                #endif
        
                #ifndef SHADER_UNLIT
                #ifdef _DOUBLESIDED_ON
                    float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
                #else
                    float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
                #endif
        
                ApplyDoubleSidedFlipOrMirror(fragInputs, doubleSidedConstants); // Apply double sided flip on the vertex normal
                #endif // SHADER_UNLIT
        
                SurfaceDescriptionInputs surfaceDescriptionInputs = FragInputsToSurfaceDescriptionInputs(fragInputs, V);
        
                #if defined(HAVE_VFX_MODIFICATION)
                GraphProperties properties;
                ZERO_INITIALIZE(GraphProperties, properties);
        
                GetElementPixelProperties(fragInputs, properties);
        
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs, properties);
                #else
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs);
                #endif
        
                // Perform alpha test very early to save performance (a killed pixel will not sample textures)
                // TODO: split graph evaluation to grab just alpha dependencies first? tricky..
                #ifdef _ALPHATEST_ON
                    float alphaCutoff = surfaceDescription.AlphaClipThreshold;
                    #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
                    // The TransparentDepthPrepass is also used with SSR transparent.
                    // If an artists enable transaprent SSR but not the TransparentDepthPrepass itself, then we use AlphaClipThreshold
                    // otherwise if TransparentDepthPrepass is enabled we use AlphaClipThresholdDepthPrepass
                    #elif SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_POSTPASS
                    // DepthPostpass always use its own alpha threshold
                    alphaCutoff = surfaceDescription.AlphaClipThresholdDepthPostpass;
                    #elif (SHADERPASS == SHADERPASS_SHADOWS) || (SHADERPASS == SHADERPASS_RAYTRACING_VISIBILITY)
                    // If use shadow threshold isn't enable we don't allow any test
                    #endif
        
                    GENERIC_ALPHA_TEST(surfaceDescription.Alpha, alphaCutoff);
                #endif
        
                #if !defined(SHADER_STAGE_RAY_TRACING) && _DEPTHOFFSET_ON
                ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
                #endif
        
                #ifndef SHADER_UNLIT
                float3 bentNormalWS;
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS);
        
                #ifdef FRAG_INPUTS_USE_TEXCOORD1
                    float4 lightmapTexCoord1 = fragInputs.texCoord1;
                #else
                    float4 lightmapTexCoord1 = float4(0,0,0,0);
                #endif
        
                #ifdef FRAG_INPUTS_USE_TEXCOORD2
                    float4 lightmapTexCoord2 = fragInputs.texCoord2;
                #else
                    float4 lightmapTexCoord2 = float4(0,0,0,0);
                #endif
        
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                // Builtin Data
                // For back lighting we use the oposite vertex normal
                InitBuiltinData(posInput, alpha, bentNormalWS, -fragInputs.tangentToWorld[2], lightmapTexCoord1, lightmapTexCoord2, builtinData);
        
                #else
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData);
        
                ZERO_BUILTIN_INITIALIZE(builtinData); // No call to InitBuiltinData as we don't have any lighting
                builtinData.opacity = surfaceDescription.Alpha;
        
                #if defined(DEBUG_DISPLAY)
                    // Light Layers are currently not used for the Unlit shader (because it is not lit)
                    // But Unlit objects do cast shadows according to their rendering layer mask, which is what we want to
                    // display in the light layers visualization mode, therefore we need the renderingLayers
                    builtinData.renderingLayers = GetMeshRenderingLayerMask();
                #endif
        
                #endif // SHADER_UNLIT
        
                #ifdef _ALPHATEST_ON
                    // Used for sharpening by alpha to mask - Alpha to covertage is only used with depth only and forward pass (no shadow pass, no transparent pass)
                    builtinData.alphaClipTreshold = alphaCutoff;
                #endif
        
                // override sampleBakedGI - not used by Unlit
        		// When overriding GI, we need to force the isLightmap flag to make sure we don't add APV (sampled in the lightloop) on top of the overridden value (set at GBuffer stage)
        
                builtinData.emissiveColor = surfaceDescription.Emission;
        
                // Note this will not fully work on transparent surfaces (can check with _SURFACE_TYPE_TRANSPARENT define)
                // We will always overwrite vt feeback with the nearest. So behind transparent surfaces vt will not be resolved
                // This is a limitation of the current MRT approach.
                #ifdef UNITY_VIRTUAL_TEXTURING
                #endif
        
                #if _DEPTHOFFSET_ON
                builtinData.depthOffset = surfaceDescription.DepthOffset;
                #endif
        
                // TODO: We should generate distortion / distortionBlur for non distortion pass
                #if (SHADERPASS == SHADERPASS_DISTORTION)
                builtinData.distortion = surfaceDescription.Distortion;
                builtinData.distortionBlur = surfaceDescription.DistortionBlur;
                #endif
        
                #ifndef SHADER_UNLIT
                // PostInitBuiltinData call ApplyDebugToBuiltinData
                PostInitBuiltinData(V, posInput, surfaceData, builtinData);
                #else
                ApplyDebugToBuiltinData(builtinData);
                #endif
        
                RAY_TRACING_OPTIONAL_ALPHA_TEST_PASS
            }
        
            // --------------------------------------------------
            // Main
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPassDepthOnly.hlsl"
        
            // --------------------------------------------------
            // Visual Effect Vertex Invocations
        
        	#ifdef HAVE_VFX_MODIFICATION
                #if !defined(SHADER_STAGE_RAY_TRACING)
        	    #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/VisualEffectVertex.hlsl"
                #else
                #endif
        	#endif
        
            #include "Assets/VegetationInstancer/Shaders/Include/GPUInstancedIndirectInclude.cginc"
#pragma instancing_options procedural:setupGPUInstancedIndirect
#pragma multi_compile_instancing
ENDHLSL
        }
        Pass
        {
            Name "MotionVectors"
            Tags
            {
                "LightMode" = "MotionVectors"
            }
        
            // Render State
            Cull [_CullMode]
        ZWrite On
        Stencil
        {
        WriteMask [_StencilWriteMaskMV]
        Ref [_StencilRefMV]
        CompFront Always
        PassFront Replace
        CompBack Always
        PassBack Replace
        }
        AlphaToMask [_AlphaCutoffEnable]
        
            // Debug
            // <None>
        
            // --------------------------------------------------
            // Pass
        
            HLSLPROGRAM
        
            // Pragmas
            #pragma multi_compile _ DOTS_INSTANCING_ON
        
        #pragma target 4.5
        #pragma vertex Vert
        #pragma fragment Frag
        #pragma only_renderers d3d11 playstation xboxone xboxseries vulkan metal switch
        
        
            // Keywords
            #pragma shader_feature_local _ _ALPHATEST_ON
        #pragma multi_compile_fragment _ WRITE_MSAA_DEPTH
        #pragma shader_feature _ _SURFACE_TYPE_TRANSPARENT
        #pragma shader_feature_local _ _DOUBLESIDED_ON
        #pragma shader_feature_local _ _ADD_PRECOMPUTED_VELOCITY
        #pragma shader_feature_local _ _TRANSPARENT_WRITES_MOTION_VEC _TRANSPARENT_REFRACTIVE_SORT
        #pragma shader_feature_local_fragment _ _ENABLE_FOG_ON_TRANSPARENT
        #pragma multi_compile _ WRITE_NORMAL_BUFFER
        #pragma shader_feature_local_fragment _ _DISABLE_DECALS
        #pragma shader_feature_local_raytracing _ _DISABLE_DECALS
        #pragma shader_feature_local_fragment _ _DISABLE_SSR
        #pragma shader_feature_local_raytracing _ _DISABLE_SSR
        #pragma shader_feature_local_fragment _ _DISABLE_SSR_TRANSPARENT
        #pragma shader_feature_local_raytracing _ _DISABLE_SSR_TRANSPARENT
        #pragma multi_compile_fragment _ WRITE_DECAL_BUFFER_AND_RENDERING_LAYER
        #pragma shader_feature_local _ _REFRACTION_PLANE _REFRACTION_SPHERE _REFRACTION_THIN
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_TRANSMISSION
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_TRANSMISSION
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_ANISOTROPY
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_ANISOTROPY
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_IRIDESCENCE
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_IRIDESCENCE
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_SPECULAR_COLOR
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_SPECULAR_COLOR
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_COLORED_TRANSMISSION
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_COLORED_TRANSMISSION
            // GraphKeywords: <None>
        
            // Defines
            #define SHADERPASS SHADERPASS_MOTION_VECTORS
        
            // For custom interpolators to inject a substruct definition before FragInputs definition,
            // allowing for FragInputs to capture CI's intended for ShaderGraph's SDI.
            struct CustomInterpolators
        {
        };
        #define USE_CUSTOMINTERP_SUBSTRUCT
        
        
        
            // TODO: Merge FragInputsVFX substruct with CustomInterpolators.
        	#ifdef HAVE_VFX_MODIFICATION
        	struct FragInputsVFX
            {
                /* WARNING: $splice Could not find named fragment 'FragInputsVFX' */
            };
            #endif
        
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl" // Required by Tessellation.hlsl
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Tessellation.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl" // Required to be include before we include properties as it define DECLARE_STACK_CB
            // Always include Shader Graph version
            // Always include last to avoid double macros
            #include "Packages/com.unity.shadergraph/ShaderGraphLibrary/Functions.hlsl" // Need to be here for Gradient struct definition
        
            // --------------------------------------------------
            // Defines
        
            // Attribute
            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define ATTRIBUTES_NEED_TEXCOORD0
            #define VARYINGS_NEED_POSITION_WS
            #define VARYINGS_NEED_TANGENT_TO_WORLD
            #define VARYINGS_NEED_TEXCOORD0
        
            #define HAVE_MESH_MODIFICATION
        
            //Strip down the FragInputs.hlsl (on graphics), so we can only optimize the interpolators we use.
            //if by accident something requests contents of FragInputs.hlsl, it will be caught as a compiler error
            //Frag inputs stripping is only enabled when FRAG_INPUTS_ENABLE_STRIPPING is set
            #if !defined(SHADER_STAGE_RAY_TRACING) && SHADERPASS != SHADERPASS_RAYTRACING_GBUFFER && SHADERPASS != SHADERPASS_FULL_SCREEN_DEBUG
            #define FRAG_INPUTS_ENABLE_STRIPPING
            #endif
            #define FRAG_INPUTS_USE_TEXCOORD0
        
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
        
        
        
        
            // Following two define are a workaround introduce in 10.1.x for RaytracingQualityNode
            // The ShaderGraph don't support correctly migration of this node as it serialize all the node data
            // in the json file making it impossible to uprgrade. Until we get a fix, we do a workaround here
            // to still allow us to rename the field and keyword of this node without breaking existing code.
            #ifdef RAYTRACING_SHADER_GRAPH_DEFAULT
            #define RAYTRACING_SHADER_GRAPH_HIGH
            #endif
        
            #ifdef RAYTRACING_SHADER_GRAPH_RAYTRACED
            #define RAYTRACING_SHADER_GRAPH_LOW
            #endif
            // end
        
            #ifndef SHADER_UNLIT
            // We need isFrontFace when using double sided - it is not required for unlit as in case of unlit double sided only drive the cullmode
            // VARYINGS_NEED_CULLFACE can be define by VaryingsMeshToPS.FaceSign input if a IsFrontFace Node is included in the shader graph.
            #if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
                #define VARYINGS_NEED_CULLFACE
            #endif
            #endif
        
            // Specific Material Define
        #define _SPECULAR_OCCLUSION_FROM_AO 1
        #define _ENERGY_CONSERVING_SPECULAR 1
        
        #if _MATERIAL_FEATURE_COLORED_TRANSMISSION
            // Colored Transmission doesn't support clear coat
            #undef _MATERIAL_FEATURE_CLEAR_COAT
        #endif
        
        // If we use subsurface scattering, enable output split lighting (for forward pass)
        #if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
            #define OUTPUT_SPLIT_LIGHTING
        #endif
        
        // This shader support recursive rendering for raytracing
        #define HAVE_RECURSIVE_RENDERING
        
        // In Path Tracing, For all single-sided, refractive materials, we want to force a thin refraction model
        #if (SHADERPASS == SHADERPASS_PATH_TRACING) && !defined(_DOUBLESIDED_ON) && (defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE))
            #undef  _REFRACTION_PLANE
            #undef  _REFRACTION_SPHERE
            #define _REFRACTION_THIN
        #endif
            // Caution: we can use the define SHADER_UNLIT onlit after the above Material include as it is the Unlit template who define it
        
            // To handle SSR on transparent correctly with a possibility to enable/disable it per framesettings
            // we should have a code like this:
            // if !defined(_DISABLE_SSR_TRANSPARENT)
            // pragma multi_compile _ WRITE_NORMAL_BUFFER
            // endif
            // i.e we enable the multicompile only if we can receive SSR or not, and then C# code drive
            // it based on if SSR transparent in frame settings and not (and stripper can strip it).
            // this is currently not possible with our current preprocessor as _DISABLE_SSR_TRANSPARENT is a keyword not a define
            // so instead we used this and chose to pay the extra cost of normal write even if SSR transaprent is disabled.
            // Ideally the shader graph generator should handle it but condition below can't be handle correctly for now.
            #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
            #if !defined(_DISABLE_SSR_TRANSPARENT) && !defined(SHADER_UNLIT)
                #define WRITE_NORMAL_BUFFER
            #endif
            #endif
        
            // See Lit.shader
            #if SHADERPASS == SHADERPASS_MOTION_VECTORS && defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)
                #define WRITE_DECAL_BUFFER
            #endif
        
            #ifndef DEBUG_DISPLAY
                // In case of opaque we don't want to perform the alpha test, it is done in depth prepass and we use depth equal for ztest (setup from UI)
                // Don't do it with debug display mode as it is possible there is no depth prepass in this case
                #if !defined(_SURFACE_TYPE_TRANSPARENT)
                    #if SHADERPASS == SHADERPASS_FORWARD
                    #define SHADERPASS_FORWARD_BYPASS_ALPHA_TEST
                    #elif SHADERPASS == SHADERPASS_GBUFFER
                    #define SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST
                    #endif
                #endif
            #endif
        
            // Define _DEFERRED_CAPABLE_MATERIAL for shader capable to run in deferred pass
            #if defined(SHADER_LIT) && !defined(_SURFACE_TYPE_TRANSPARENT)
                #define _DEFERRED_CAPABLE_MATERIAL
            #endif
        
            // Translate transparent motion vector define
            #if (defined(_TRANSPARENT_WRITES_MOTION_VEC) || defined(_TRANSPARENT_REFRACTIVE_SORT)) && defined(_SURFACE_TYPE_TRANSPARENT)
                #define _WRITE_TRANSPARENT_MOTION_VECTOR
            #endif
        
            // -- Graph Properties
            CBUFFER_START(UnityPerMaterial)
        float4 _DiffusionProfileAsset;
        float _DiffusionProfileHash;
        float4 _Texture2D_TexelSize;
        float4 _Albedo;
        float _Smoothness;
        float _WindSpeed;
        float _WindStrength;
        float4 _Normal_TexelSize;
        float _NormalStrength;
        float4 _EmissionColor;
        float _UseShadowThreshold;
        float4 _DoubleSidedConstants;
        float _BlendMode;
        float _EnableBlendModePreserveSpecularLighting;
        float _RayTracing;
        float _RefractionModel;
        float _MaterialID;
        float _MaterialTypeMask;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_Texture2D);
        SAMPLER(sampler_Texture2D);
        TEXTURE2D(_Normal);
        SAMPLER(sampler_Normal);
        
            // -- Property used by ScenePickingPass
            #ifdef SCENEPICKINGPASS
            float4 _SelectionID;
            #endif
        
            // -- Properties used by SceneSelectionPass
            #ifdef SCENESELECTIONPASS
            int _ObjectId;
            int _PassValue;
            #endif
        
            // Includes
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitDecalData.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"
        	// GraphIncludes: <None>
        
            // --------------------------------------------------
            // Structs and Packing
        
            struct AttributesMesh
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct VaryingsMeshToPS
        {
            SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
             float3 positionRWS;
             float3 normalWS;
             float4 tangentWS;
             float4 texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
             float3 WorldSpacePosition;
             float4 uv0;
             float3 TimeParameters;
        };
        struct SurfaceDescriptionInputs
        {
             float3 TangentSpaceNormal;
             float4 uv0;
        };
        struct PackedVaryingsMeshToPS
        {
            SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
             float4 tangentWS : INTERP0;
             float4 texCoord0 : INTERP1;
             float3 positionRWS : INTERP2;
             float3 normalWS : INTERP3;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
        };
        
            PackedVaryingsMeshToPS PackVaryingsMeshToPS (VaryingsMeshToPS input)
        {
            PackedVaryingsMeshToPS output;
            ZERO_INITIALIZE(PackedVaryingsMeshToPS, output);
            output.positionCS = input.positionCS;
            output.tangentWS.xyzw = input.tangentWS;
            output.texCoord0.xyzw = input.texCoord0;
            output.positionRWS.xyz = input.positionRWS;
            output.normalWS.xyz = input.normalWS;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            return output;
        }
        
        VaryingsMeshToPS UnpackVaryingsMeshToPS (PackedVaryingsMeshToPS input)
        {
            VaryingsMeshToPS output;
            output.positionCS = input.positionCS;
            output.tangentWS = input.tangentWS.xyzw;
            output.texCoord0 = input.texCoord0.xyzw;
            output.positionRWS = input.positionRWS.xyz;
            output.normalWS = input.normalWS.xyz;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            return output;
        }
        
        
            // --------------------------------------------------
            // Graph
        
        
            // Graph Functions
            
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_Sine_float(float In, out float Out)
        {
            Out = sin(In);
        }
        
        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }
        
        void Unity_Multiply_float4_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }
        
            // Graph Vertex
            struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            float _Property_8c596e62dce249caa7922ff3d7470d43_Out_0_Float = _WindSpeed;
            float _Split_35af25740d5a404097ccb209d36d5cac_R_1_Float = IN.WorldSpacePosition[0];
            float _Split_35af25740d5a404097ccb209d36d5cac_G_2_Float = IN.WorldSpacePosition[1];
            float _Split_35af25740d5a404097ccb209d36d5cac_B_3_Float = IN.WorldSpacePosition[2];
            float _Split_35af25740d5a404097ccb209d36d5cac_A_4_Float = 0;
            float _Add_c678bc9d08684d01a8e45ad5e636b4b4_Out_2_Float;
            Unity_Add_float(_Split_35af25740d5a404097ccb209d36d5cac_R_1_Float, _Split_35af25740d5a404097ccb209d36d5cac_B_3_Float, _Add_c678bc9d08684d01a8e45ad5e636b4b4_Out_2_Float);
            float _Add_0ec2f296c670483e9dc4250c81fe62a0_Out_2_Float;
            Unity_Add_float(IN.TimeParameters.x, _Add_c678bc9d08684d01a8e45ad5e636b4b4_Out_2_Float, _Add_0ec2f296c670483e9dc4250c81fe62a0_Out_2_Float);
            float _Multiply_ce5f4784040b450499733beaca915393_Out_2_Float;
            Unity_Multiply_float_float(_Property_8c596e62dce249caa7922ff3d7470d43_Out_0_Float, _Add_0ec2f296c670483e9dc4250c81fe62a0_Out_2_Float, _Multiply_ce5f4784040b450499733beaca915393_Out_2_Float);
            float _Sine_3c81889fed534b52996b5063cdc22296_Out_1_Float;
            Unity_Sine_float(_Multiply_ce5f4784040b450499733beaca915393_Out_2_Float, _Sine_3c81889fed534b52996b5063cdc22296_Out_1_Float);
            float _Property_3cdd281375794ed2bcad3550a9c890af_Out_0_Float = _WindStrength;
            float _Multiply_89ad4329fdd44befb161e56947c2670b_Out_2_Float;
            Unity_Multiply_float_float(_Sine_3c81889fed534b52996b5063cdc22296_Out_1_Float, _Property_3cdd281375794ed2bcad3550a9c890af_Out_0_Float, _Multiply_89ad4329fdd44befb161e56947c2670b_Out_2_Float);
            float4 _UV_30b55575e9844728bc3abbcaf84a22ff_Out_0_Vector4 = IN.uv0;
            float _Split_020d1040f8544c0b9d3de77e7fbd9197_R_1_Float = _UV_30b55575e9844728bc3abbcaf84a22ff_Out_0_Vector4[0];
            float _Split_020d1040f8544c0b9d3de77e7fbd9197_G_2_Float = _UV_30b55575e9844728bc3abbcaf84a22ff_Out_0_Vector4[1];
            float _Split_020d1040f8544c0b9d3de77e7fbd9197_B_3_Float = _UV_30b55575e9844728bc3abbcaf84a22ff_Out_0_Vector4[2];
            float _Split_020d1040f8544c0b9d3de77e7fbd9197_A_4_Float = _UV_30b55575e9844728bc3abbcaf84a22ff_Out_0_Vector4[3];
            float _Multiply_17088dc811eb45e4a333912f99b556ec_Out_2_Float;
            Unity_Multiply_float_float(_Multiply_89ad4329fdd44befb161e56947c2670b_Out_2_Float, _Split_020d1040f8544c0b9d3de77e7fbd9197_G_2_Float, _Multiply_17088dc811eb45e4a333912f99b556ec_Out_2_Float);
            float3 _Add_e473a1f67cd1441b9fccfb91c0b5ff75_Out_2_Vector3;
            Unity_Add_float3(IN.WorldSpacePosition, (_Multiply_17088dc811eb45e4a333912f99b556ec_Out_2_Float.xxx), _Add_e473a1f67cd1441b9fccfb91c0b5ff75_Out_2_Vector3);
            float3 _Add_8e06eedaa53749dea4ffc85b774f63ee_Out_2_Vector3;
            Unity_Add_float3(float3(0, 0, 0), _Add_e473a1f67cd1441b9fccfb91c0b5ff75_Out_2_Vector3, _Add_8e06eedaa53749dea4ffc85b774f63ee_Out_2_Vector3);
            float3 _Transform_78fa02a50d4c495cba1111966696417e_Out_1_Vector3;
            _Transform_78fa02a50d4c495cba1111966696417e_Out_1_Vector3 = TransformWorldToObject(_Add_8e06eedaa53749dea4ffc85b774f63ee_Out_2_Vector3.xyz);
            description.Position = _Transform_78fa02a50d4c495cba1111966696417e_Out_1_Vector3;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
            // Graph Pixel
            struct SurfaceDescription
        {
            float3 BaseColor;
            float3 Emission;
            float Alpha;
            float AlphaClipThreshold;
            float3 BentNormal;
            float Smoothness;
            float Occlusion;
            float3 NormalTS;
            float TransmissionMask;
            float Thickness;
            float DiffusionProfileHash;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float4 _Property_35c125abbbcb46e1a2351d8febeb5da1_Out_0_Vector4 = _Albedo;
            UnityTexture2D _Property_bb313b600ca3404fb88a2820878a8482_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Texture2D);
            float4 _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_bb313b600ca3404fb88a2820878a8482_Out_0_Texture2D.tex, _Property_bb313b600ca3404fb88a2820878a8482_Out_0_Texture2D.samplerstate, _Property_bb313b600ca3404fb88a2820878a8482_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_R_4_Float = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4.r;
            float _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_G_5_Float = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4.g;
            float _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_B_6_Float = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4.b;
            float _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_A_7_Float = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4.a;
            float4 _Multiply_c09cca22f04c4a9a996a5ccf8f61afe1_Out_2_Vector4;
            Unity_Multiply_float4_float4(_Property_35c125abbbcb46e1a2351d8febeb5da1_Out_0_Vector4, _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4, _Multiply_c09cca22f04c4a9a996a5ccf8f61afe1_Out_2_Vector4);
            float _Property_925f8cb589d94edda2dcd6b588187f26_Out_0_Float = _Smoothness;
            float _Multiply_a061075fe3794cc5abff5f173997f7f8_Out_2_Float;
            Unity_Multiply_float_float(_Property_925f8cb589d94edda2dcd6b588187f26_Out_0_Float, _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_G_5_Float, _Multiply_a061075fe3794cc5abff5f173997f7f8_Out_2_Float);
            UnityTexture2D _Property_ff2eff189fa74f1f965ec8aca53205ba_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Normal);
            float4 _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_ff2eff189fa74f1f965ec8aca53205ba_Out_0_Texture2D.tex, _Property_ff2eff189fa74f1f965ec8aca53205ba_Out_0_Texture2D.samplerstate, _Property_ff2eff189fa74f1f965ec8aca53205ba_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.rgb = UnpackNormal(_SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4);
            float _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_R_4_Float = _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.r;
            float _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_G_5_Float = _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.g;
            float _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_B_6_Float = _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.b;
            float _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_A_7_Float = _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.a;
            float _Property_915c3b0b5fc04c668c646f2f67b5ab2b_Out_0_Float = _NormalStrength;
            float4 _Multiply_e38eea28614c4b61bfd135ec8591a746_Out_2_Vector4;
            Unity_Multiply_float4_float4(_SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4, (_Property_915c3b0b5fc04c668c646f2f67b5ab2b_Out_0_Float.xxxx), _Multiply_e38eea28614c4b61bfd135ec8591a746_Out_2_Vector4);
            surface.BaseColor = (_Multiply_c09cca22f04c4a9a996a5ccf8f61afe1_Out_2_Vector4.xyz);
            surface.Emission = float3(0, 0, 0);
            surface.Alpha = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_A_7_Float;
            surface.AlphaClipThreshold = 0.5;
            surface.BentNormal = IN.TangentSpaceNormal;
            surface.Smoothness = _Multiply_a061075fe3794cc5abff5f173997f7f8_Out_2_Float;
            surface.Occlusion = 1;
            surface.NormalTS = (_Multiply_e38eea28614c4b61bfd135ec8591a746_Out_2_Vector4.xyz);
            surface.TransmissionMask = 1;
            surface.Thickness = 1;
            surface.DiffusionProfileHash = _DiffusionProfileHash;
            return surface;
        }
        
            // --------------------------------------------------
            // Build Graph Inputs
            #ifdef HAVE_VFX_MODIFICATION
            #define VFX_SRP_ATTRIBUTES AttributesMesh
            #define VaryingsMeshType VaryingsMeshToPS
            #define VFX_SRP_VARYINGS VaryingsMeshType
            #define VFX_SRP_SURFACE_INPUTS FragInputs
            #endif
            
        VertexDescriptionInputs AttributesMeshToVertexDescriptionInputs(AttributesMesh input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
            output.WorldSpacePosition =                         TransformObjectToWorld(input.positionOS);
            output.uv0 =                                        input.uv0;
            output.TimeParameters =                             _TimeParameters.xyz; // Note: in case of animation this will be overwrite (allow to handle motion vector)
        
            return output;
        }
        
        VertexDescription GetVertexDescription(AttributesMesh input, float3 timeParameters
        #ifdef HAVE_VFX_MODIFICATION
            , AttributesElement element
        #endif
        )
        {
            // build graph inputs
            VertexDescriptionInputs vertexDescriptionInputs = AttributesMeshToVertexDescriptionInputs(input);
            // Override time parameters with used one (This is required to correctly handle motion vectors for vertex animation based on time)
            vertexDescriptionInputs.TimeParameters = timeParameters;
        
            // evaluate vertex graph
        #ifdef HAVE_VFX_MODIFICATION
            GraphProperties properties;
            ZERO_INITIALIZE(GraphProperties, properties);
        
            // Fetch the vertex graph properties for the particle instance.
            GetElementVertexProperties(element, properties);
        
            VertexDescription vertexDescription = VertexDescriptionFunction(vertexDescriptionInputs, properties);
        #else
            VertexDescription vertexDescription = VertexDescriptionFunction(vertexDescriptionInputs);
        #endif
            return vertexDescription;
        
        }
        
        AttributesMesh ApplyMeshModification(AttributesMesh input, float3 timeParameters
        #ifdef USE_CUSTOMINTERP_SUBSTRUCT
            #ifdef TESSELLATION_ON
            , inout VaryingsMeshToDS varyings
            #else
            , inout VaryingsMeshToPS varyings
            #endif
        #endif
        #ifdef HAVE_VFX_MODIFICATION
                , AttributesElement element
        #endif
            )
        {
            VertexDescription vertexDescription = GetVertexDescription(input, timeParameters
        #ifdef HAVE_VFX_MODIFICATION
                , element
        #endif
            );
        
            // copy graph output to the results
            input.positionOS = vertexDescription.Position;
            input.normalOS = vertexDescription.Normal;
            input.tangentOS.xyz = vertexDescription.Tangent;
        
            
        
            return input;
        }
        
        #if defined(_ADD_CUSTOM_VELOCITY) // For shader graph custom velocity
        // Return precomputed Velocity in object space
        float3 GetCustomVelocity(AttributesMesh input
        #ifdef HAVE_VFX_MODIFICATION
            , AttributesElement element
        #endif
        )
        {
            VertexDescription vertexDescription = GetVertexDescription(input, _TimeParameters.xyz
        #ifdef HAVE_VFX_MODIFICATION
                , element
        #endif
            );
            return vertexDescription.CustomVelocity;
        }
        #endif
        
        FragInputs BuildFragInputs(VaryingsMeshToPS input)
        {
            FragInputs output;
            ZERO_INITIALIZE(FragInputs, output);
        
            // Init to some default value to make the computer quiet (else it output 'divide by zero' warning even if value is not used).
            // TODO: this is a really poor workaround, but the variable is used in a bunch of places
            // to compute normals which are then passed on elsewhere to compute other values...
            output.tangentToWorld = k_identity3x3;
            output.positionSS = input.positionCS;       // input.positionCS is SV_Position
        
            output.positionRWS =                input.positionRWS;
            output.tangentToWorld =             BuildTangentToWorld(input.tangentWS, input.normalWS);
            output.texCoord0 =                  input.texCoord0;
        
        
        #ifdef HAVE_VFX_MODIFICATION
            // FragInputs from VFX come from two places: Interpolator or CBuffer.
        #if VFX_USE_GRAPH_VALUES
            uint instanceActiveIndex = asuint(UNITY_ACCESS_INSTANCED_PROP(PerInstance, _InstanceActiveIndex));
            /* WARNING: $splice Could not find named fragment 'VFXLoadGraphValues' */
        #endif
        
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            // splice point to copy custom interpolator fields from varyings to frag inputs
            
        
            return output;
        }
        
        // existing HDRP code uses the combined function to go directly from packed to frag inputs
        FragInputs UnpackVaryingsMeshToFragInputs(PackedVaryingsMeshToPS input)
        {
            UNITY_SETUP_INSTANCE_ID(input);
        #if defined(HAVE_VFX_MODIFICATION) && defined(UNITY_INSTANCING_ENABLED)
            unity_InstanceID = input.instanceID;
        #endif
            VaryingsMeshToPS unpacked = UnpackVaryingsMeshToPS(input);
            return BuildFragInputs(unpacked);
        }
            SurfaceDescriptionInputs FragInputsToSurfaceDescriptionInputs(FragInputs input, float3 viewWS)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
            #if defined(SHADER_STAGE_RAY_TRACING)
            #else
            #endif
            output.TangentSpaceNormal =                         float3(0.0f, 0.0f, 1.0f);
        
        #if UNITY_UV_STARTS_AT_TOP
        #else
        #endif
        
        
            output.uv0 =                                        input.texCoord0;
        
            // splice point to copy frag inputs custom interpolator pack into the SDI
            
        
            return output;
        }
        
            // --------------------------------------------------
            // Build Surface Data (Specific Material)
        
        void ApplyDecalToSurfaceDataNoNormal(DecalSurfaceData decalSurfaceData, inout SurfaceData surfaceData);
        
        void ApplyDecalAndGetNormal(FragInputs fragInputs, PositionInputs posInput, SurfaceDescription surfaceDescription,
            inout SurfaceData surfaceData)
        {
            float3 doubleSidedConstants = GetDoubleSidedConstants();
        
        #ifdef DECAL_NORMAL_BLENDING
            // SG nodes don't ouptut surface gradients, so if decals require surf grad blending, we have to convert
            // the normal to gradient before applying the decal. We then have to resolve the gradient back to world space
            float3 normalTS;
        
            normalTS = SurfaceGradientFromTangentSpaceNormalAndFromTBN(surfaceDescription.NormalTS,
            fragInputs.tangentToWorld[0], fragInputs.tangentToWorld[1]);
        
        
            #if HAVE_DECALS
            if (_EnableDecals)
            {
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                ApplyDecalToSurfaceNormal(decalSurfaceData, fragInputs.tangentToWorld[2], normalTS);
                ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
            }
            #endif
        
            GetNormalWS_SG(fragInputs, normalTS, surfaceData.normalWS, doubleSidedConstants);
        #else
            // normal delivered to master node
            GetNormalWS(fragInputs, surfaceDescription.NormalTS, surfaceData.normalWS, doubleSidedConstants);
        
            #if HAVE_DECALS
            if (_EnableDecals)
            {
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                // Both uses and modifies 'surfaceData.normalWS'.
                DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                ApplyDecalToSurfaceNormal(decalSurfaceData, surfaceData.normalWS.xyz);
                ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
            }
            #endif
        #endif
        }
        void BuildSurfaceData(FragInputs fragInputs, inout SurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
        {
            ZERO_INITIALIZE(SurfaceData, surfaceData);
        
            // specularOcclusion need to be init ahead of decal to quiet the compiler that modify the SurfaceData struct
            // however specularOcclusion can come from the graph, so need to be init here so it can be override.
            surfaceData.specularOcclusion = 1.0;
            surfaceData.thickness = 0.0;
        
            surfaceData.baseColor =                 surfaceDescription.BaseColor;
            surfaceData.perceptualSmoothness =      surfaceDescription.Smoothness;
            surfaceData.ambientOcclusion =          surfaceDescription.Occlusion;
            surfaceData.transmissionMask =          surfaceDescription.TransmissionMask.xxx;
            surfaceData.thickness =                 surfaceDescription.Thickness;
            surfaceData.diffusionProfileHash =      asuint(surfaceDescription.DiffusionProfileHash);
        
            #if defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE) || defined(_REFRACTION_THIN)
                if (_EnableSSRefraction)
                {
        
                    surfaceData.transmittanceMask = (1.0 - surfaceDescription.Alpha);
                    surfaceDescription.Alpha = 1.0;
                }
                else
                {
                    surfaceData.ior = 1.0;
                    surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                    surfaceData.atDistance = 1.0;
                    surfaceData.transmittanceMask = 0.0;
                    surfaceDescription.Alpha = 1.0;
                }
            #else
                surfaceData.ior = 1.0;
                surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                surfaceData.atDistance = 1.0;
                surfaceData.transmittanceMask = 0.0;
            #endif
        
            // These static material feature allow compile time optimization
            surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;
            #ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
            #endif
        
            #ifdef _MATERIAL_FEATURE_TRANSMISSION
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
            #endif
        
            #ifdef _MATERIAL_FEATURE_COLORED_TRANSMISSION
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_COLORED_TRANSMISSION;
        
            #endif
        
            #ifdef _MATERIAL_FEATURE_ANISOTROPY
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
        
                // Initialize the normal to something non-zero to avoid a div-zero warning for anisotropy.
                surfaceData.normalWS = float3(0, 1, 0);
            #endif
        
            #ifdef _MATERIAL_FEATURE_IRIDESCENCE
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
            #endif
        
            #ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
            #endif
        
            #ifdef _MATERIAL_FEATURE_CLEAR_COAT
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
            #endif
        
            #if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
                // Require to have setup baseColor
                // Reproduce the energy conservation done in legacy Unity. Not ideal but better for compatibility and users can unchek it
                surfaceData.baseColor *= (1.0 - Max3(surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b));
            #endif
        
            float3 doubleSidedConstants = GetDoubleSidedConstants();
        
            ApplyDecalAndGetNormal(fragInputs, posInput, surfaceDescription, surfaceData);
        
            surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];
        
            surfaceData.tangentWS = normalize(fragInputs.tangentToWorld[0].xyz);    // The tangent is not normalize in tangentToWorld for mikkt. TODO: Check if it expected that we normalize with Morten. Tag: SURFACE_GRADIENT
        
        
            bentNormalWS = surfaceData.normalWS;
        
            surfaceData.tangentWS = Orthonormalize(surfaceData.tangentWS, surfaceData.normalWS);
        
            #ifdef DEBUG_DISPLAY
                if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
                {
                    // TODO: need to update mip info
                    surfaceData.metallic = 0;
                }
        
                // We need to call ApplyDebugToSurfaceData after filling the surfarcedata and before filling builtinData
                // as it can modify attribute use for static lighting
                ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData);
            #endif
        
            // By default we use the ambient occlusion with Tri-ace trick (apply outside) for specular occlusion.
            // If user provide bent normal then we process a better term
            #if defined(_SPECULAR_OCCLUSION_CUSTOM)
                // Just use the value passed through via the slot (not active otherwise)
            #elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
                // If we have bent normal and ambient occlusion, process a specular occlusion
                surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO(V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness(surfaceData.perceptualSmoothness));
            #elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
                surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion(ClampNdotV(dot(surfaceData.normalWS, V)), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness(surfaceData.perceptualSmoothness));
            #endif
        
            #if defined(_ENABLE_GEOMETRIC_SPECULAR_AA) && !defined(SHADER_STAGE_RAY_TRACING)
                surfaceData.perceptualSmoothness = GeometricNormalFiltering(surfaceData.perceptualSmoothness, fragInputs.tangentToWorld[2], surfaceDescription.SpecularAAScreenSpaceVariance, surfaceDescription.SpecularAAThreshold);
            #endif
        }
        
            // --------------------------------------------------
            // Get Surface And BuiltinData
        
            void GetSurfaceAndBuiltinData(FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData RAY_TRACING_OPTIONAL_PARAMETERS)
            {
                // Don't dither if displaced tessellation (we're fading out the displacement instead to match the next LOD)
                #if !defined(SHADER_STAGE_RAY_TRACING) && !defined(_TESSELLATION_DISPLACEMENT)
                #ifdef LOD_FADE_CROSSFADE // enable dithering LOD transition if user select CrossFade transition in LOD group
                LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
                #endif
                #endif
        
                #ifndef SHADER_UNLIT
                #ifdef _DOUBLESIDED_ON
                    float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
                #else
                    float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
                #endif
        
                ApplyDoubleSidedFlipOrMirror(fragInputs, doubleSidedConstants); // Apply double sided flip on the vertex normal
                #endif // SHADER_UNLIT
        
                SurfaceDescriptionInputs surfaceDescriptionInputs = FragInputsToSurfaceDescriptionInputs(fragInputs, V);
        
                #if defined(HAVE_VFX_MODIFICATION)
                GraphProperties properties;
                ZERO_INITIALIZE(GraphProperties, properties);
        
                GetElementPixelProperties(fragInputs, properties);
        
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs, properties);
                #else
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs);
                #endif
        
                // Perform alpha test very early to save performance (a killed pixel will not sample textures)
                // TODO: split graph evaluation to grab just alpha dependencies first? tricky..
                #ifdef _ALPHATEST_ON
                    float alphaCutoff = surfaceDescription.AlphaClipThreshold;
                    #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
                    // The TransparentDepthPrepass is also used with SSR transparent.
                    // If an artists enable transaprent SSR but not the TransparentDepthPrepass itself, then we use AlphaClipThreshold
                    // otherwise if TransparentDepthPrepass is enabled we use AlphaClipThresholdDepthPrepass
                    #elif SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_POSTPASS
                    // DepthPostpass always use its own alpha threshold
                    alphaCutoff = surfaceDescription.AlphaClipThresholdDepthPostpass;
                    #elif (SHADERPASS == SHADERPASS_SHADOWS) || (SHADERPASS == SHADERPASS_RAYTRACING_VISIBILITY)
                    // If use shadow threshold isn't enable we don't allow any test
                    #endif
        
                    GENERIC_ALPHA_TEST(surfaceDescription.Alpha, alphaCutoff);
                #endif
        
                #if !defined(SHADER_STAGE_RAY_TRACING) && _DEPTHOFFSET_ON
                ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
                #endif
        
                #ifndef SHADER_UNLIT
                float3 bentNormalWS;
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS);
        
                #ifdef FRAG_INPUTS_USE_TEXCOORD1
                    float4 lightmapTexCoord1 = fragInputs.texCoord1;
                #else
                    float4 lightmapTexCoord1 = float4(0,0,0,0);
                #endif
        
                #ifdef FRAG_INPUTS_USE_TEXCOORD2
                    float4 lightmapTexCoord2 = fragInputs.texCoord2;
                #else
                    float4 lightmapTexCoord2 = float4(0,0,0,0);
                #endif
        
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                // Builtin Data
                // For back lighting we use the oposite vertex normal
                InitBuiltinData(posInput, alpha, bentNormalWS, -fragInputs.tangentToWorld[2], lightmapTexCoord1, lightmapTexCoord2, builtinData);
        
                #else
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData);
        
                ZERO_BUILTIN_INITIALIZE(builtinData); // No call to InitBuiltinData as we don't have any lighting
                builtinData.opacity = surfaceDescription.Alpha;
        
                #if defined(DEBUG_DISPLAY)
                    // Light Layers are currently not used for the Unlit shader (because it is not lit)
                    // But Unlit objects do cast shadows according to their rendering layer mask, which is what we want to
                    // display in the light layers visualization mode, therefore we need the renderingLayers
                    builtinData.renderingLayers = GetMeshRenderingLayerMask();
                #endif
        
                #endif // SHADER_UNLIT
        
                #ifdef _ALPHATEST_ON
                    // Used for sharpening by alpha to mask - Alpha to covertage is only used with depth only and forward pass (no shadow pass, no transparent pass)
                    builtinData.alphaClipTreshold = alphaCutoff;
                #endif
        
                // override sampleBakedGI - not used by Unlit
        		// When overriding GI, we need to force the isLightmap flag to make sure we don't add APV (sampled in the lightloop) on top of the overridden value (set at GBuffer stage)
        
                builtinData.emissiveColor = surfaceDescription.Emission;
        
                // Note this will not fully work on transparent surfaces (can check with _SURFACE_TYPE_TRANSPARENT define)
                // We will always overwrite vt feeback with the nearest. So behind transparent surfaces vt will not be resolved
                // This is a limitation of the current MRT approach.
                #ifdef UNITY_VIRTUAL_TEXTURING
                #endif
        
                #if _DEPTHOFFSET_ON
                builtinData.depthOffset = surfaceDescription.DepthOffset;
                #endif
        
                // TODO: We should generate distortion / distortionBlur for non distortion pass
                #if (SHADERPASS == SHADERPASS_DISTORTION)
                builtinData.distortion = surfaceDescription.Distortion;
                builtinData.distortionBlur = surfaceDescription.DistortionBlur;
                #endif
        
                #ifndef SHADER_UNLIT
                // PostInitBuiltinData call ApplyDebugToBuiltinData
                PostInitBuiltinData(V, posInput, surfaceData, builtinData);
                #else
                ApplyDebugToBuiltinData(builtinData);
                #endif
        
                RAY_TRACING_OPTIONAL_ALPHA_TEST_PASS
            }
        
            // --------------------------------------------------
            // Main
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPassMotionVectors.hlsl"
        
            // --------------------------------------------------
            // Visual Effect Vertex Invocations
        
        	#ifdef HAVE_VFX_MODIFICATION
                #if !defined(SHADER_STAGE_RAY_TRACING)
        	    #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/VisualEffectVertex.hlsl"
                #else
                #endif
        	#endif
        
            #include "Assets/VegetationInstancer/Shaders/Include/GPUInstancedIndirectInclude.cginc"
#pragma instancing_options procedural:setupGPUInstancedIndirect
#pragma multi_compile_instancing
ENDHLSL
        }
        Pass
        {
            Name "TransparentDepthPrepass"
            Tags
            {
                "LightMode" = "TransparentDepthPrepass"
            }
        
            // Render State
            Cull [_CullMode]
        Blend One Zero
        ZWrite On
        Stencil
        {
        WriteMask [_StencilWriteMaskDepth]
        Ref [_StencilRefDepth]
        CompFront Always
        PassFront Replace
        CompBack Always
        PassBack Replace
        }
        
            // Debug
            // <None>
        
            // --------------------------------------------------
            // Pass
        
            HLSLPROGRAM
        
            // Pragmas
            #pragma multi_compile _ DOTS_INSTANCING_ON
        
        #pragma target 4.5
        #pragma vertex Vert
        #pragma fragment Frag
        #pragma only_renderers d3d11 playstation xboxone xboxseries vulkan metal switch
        
        
            // Keywords
            #pragma shader_feature_local _ _ALPHATEST_ON
        #pragma shader_feature _ _SURFACE_TYPE_TRANSPARENT
        #pragma shader_feature_local _ _DOUBLESIDED_ON
        #pragma shader_feature_local _ _ADD_PRECOMPUTED_VELOCITY
        #pragma shader_feature_local _ _TRANSPARENT_WRITES_MOTION_VEC _TRANSPARENT_REFRACTIVE_SORT
        #pragma shader_feature_local_fragment _ _ENABLE_FOG_ON_TRANSPARENT
        #pragma shader_feature_local_fragment _ _DISABLE_DECALS
        #pragma shader_feature_local_raytracing _ _DISABLE_DECALS
        #pragma shader_feature_local_fragment _ _DISABLE_SSR
        #pragma shader_feature_local_raytracing _ _DISABLE_SSR
        #pragma shader_feature_local_fragment _ _DISABLE_SSR_TRANSPARENT
        #pragma shader_feature_local_raytracing _ _DISABLE_SSR_TRANSPARENT
        #pragma shader_feature_local _ _REFRACTION_PLANE _REFRACTION_SPHERE _REFRACTION_THIN
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_TRANSMISSION
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_TRANSMISSION
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_ANISOTROPY
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_ANISOTROPY
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_IRIDESCENCE
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_IRIDESCENCE
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_SPECULAR_COLOR
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_SPECULAR_COLOR
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_COLORED_TRANSMISSION
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_COLORED_TRANSMISSION
            // GraphKeywords: <None>
        
            // Defines
            #define SHADERPASS SHADERPASS_TRANSPARENT_DEPTH_PREPASS
        #define RAYTRACING_SHADER_GRAPH_DEFAULT
        
            // For custom interpolators to inject a substruct definition before FragInputs definition,
            // allowing for FragInputs to capture CI's intended for ShaderGraph's SDI.
            struct CustomInterpolators
        {
        };
        #define USE_CUSTOMINTERP_SUBSTRUCT
        
        
        
            // TODO: Merge FragInputsVFX substruct with CustomInterpolators.
        	#ifdef HAVE_VFX_MODIFICATION
        	struct FragInputsVFX
            {
                /* WARNING: $splice Could not find named fragment 'FragInputsVFX' */
            };
            #endif
        
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl" // Required by Tessellation.hlsl
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Tessellation.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl" // Required to be include before we include properties as it define DECLARE_STACK_CB
            // Always include Shader Graph version
            // Always include last to avoid double macros
            #include "Packages/com.unity.shadergraph/ShaderGraphLibrary/Functions.hlsl" // Need to be here for Gradient struct definition
        
            // --------------------------------------------------
            // Defines
        
            // Attribute
            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define ATTRIBUTES_NEED_TEXCOORD0
            #define VARYINGS_NEED_TANGENT_TO_WORLD
            #define VARYINGS_NEED_TEXCOORD0
        
            #define HAVE_MESH_MODIFICATION
        
            //Strip down the FragInputs.hlsl (on graphics), so we can only optimize the interpolators we use.
            //if by accident something requests contents of FragInputs.hlsl, it will be caught as a compiler error
            //Frag inputs stripping is only enabled when FRAG_INPUTS_ENABLE_STRIPPING is set
            #if !defined(SHADER_STAGE_RAY_TRACING) && SHADERPASS != SHADERPASS_RAYTRACING_GBUFFER && SHADERPASS != SHADERPASS_FULL_SCREEN_DEBUG
            #define FRAG_INPUTS_ENABLE_STRIPPING
            #endif
            #define FRAG_INPUTS_USE_TEXCOORD0
        
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
        
        
        
        
            // Following two define are a workaround introduce in 10.1.x for RaytracingQualityNode
            // The ShaderGraph don't support correctly migration of this node as it serialize all the node data
            // in the json file making it impossible to uprgrade. Until we get a fix, we do a workaround here
            // to still allow us to rename the field and keyword of this node without breaking existing code.
            #ifdef RAYTRACING_SHADER_GRAPH_DEFAULT
            #define RAYTRACING_SHADER_GRAPH_HIGH
            #endif
        
            #ifdef RAYTRACING_SHADER_GRAPH_RAYTRACED
            #define RAYTRACING_SHADER_GRAPH_LOW
            #endif
            // end
        
            #ifndef SHADER_UNLIT
            // We need isFrontFace when using double sided - it is not required for unlit as in case of unlit double sided only drive the cullmode
            // VARYINGS_NEED_CULLFACE can be define by VaryingsMeshToPS.FaceSign input if a IsFrontFace Node is included in the shader graph.
            #if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
                #define VARYINGS_NEED_CULLFACE
            #endif
            #endif
        
            // Specific Material Define
        #define _SPECULAR_OCCLUSION_FROM_AO 1
        #define _ENERGY_CONSERVING_SPECULAR 1
        
        #if _MATERIAL_FEATURE_COLORED_TRANSMISSION
            // Colored Transmission doesn't support clear coat
            #undef _MATERIAL_FEATURE_CLEAR_COAT
        #endif
        
        // If we use subsurface scattering, enable output split lighting (for forward pass)
        #if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
            #define OUTPUT_SPLIT_LIGHTING
        #endif
        
        // This shader support recursive rendering for raytracing
        #define HAVE_RECURSIVE_RENDERING
        
        // In Path Tracing, For all single-sided, refractive materials, we want to force a thin refraction model
        #if (SHADERPASS == SHADERPASS_PATH_TRACING) && !defined(_DOUBLESIDED_ON) && (defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE))
            #undef  _REFRACTION_PLANE
            #undef  _REFRACTION_SPHERE
            #define _REFRACTION_THIN
        #endif
            // Caution: we can use the define SHADER_UNLIT onlit after the above Material include as it is the Unlit template who define it
        
            // To handle SSR on transparent correctly with a possibility to enable/disable it per framesettings
            // we should have a code like this:
            // if !defined(_DISABLE_SSR_TRANSPARENT)
            // pragma multi_compile _ WRITE_NORMAL_BUFFER
            // endif
            // i.e we enable the multicompile only if we can receive SSR or not, and then C# code drive
            // it based on if SSR transparent in frame settings and not (and stripper can strip it).
            // this is currently not possible with our current preprocessor as _DISABLE_SSR_TRANSPARENT is a keyword not a define
            // so instead we used this and chose to pay the extra cost of normal write even if SSR transaprent is disabled.
            // Ideally the shader graph generator should handle it but condition below can't be handle correctly for now.
            #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
            #if !defined(_DISABLE_SSR_TRANSPARENT) && !defined(SHADER_UNLIT)
                #define WRITE_NORMAL_BUFFER
            #endif
            #endif
        
            // See Lit.shader
            #if SHADERPASS == SHADERPASS_MOTION_VECTORS && defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)
                #define WRITE_DECAL_BUFFER
            #endif
        
            #ifndef DEBUG_DISPLAY
                // In case of opaque we don't want to perform the alpha test, it is done in depth prepass and we use depth equal for ztest (setup from UI)
                // Don't do it with debug display mode as it is possible there is no depth prepass in this case
                #if !defined(_SURFACE_TYPE_TRANSPARENT)
                    #if SHADERPASS == SHADERPASS_FORWARD
                    #define SHADERPASS_FORWARD_BYPASS_ALPHA_TEST
                    #elif SHADERPASS == SHADERPASS_GBUFFER
                    #define SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST
                    #endif
                #endif
            #endif
        
            // Define _DEFERRED_CAPABLE_MATERIAL for shader capable to run in deferred pass
            #if defined(SHADER_LIT) && !defined(_SURFACE_TYPE_TRANSPARENT)
                #define _DEFERRED_CAPABLE_MATERIAL
            #endif
        
            // Translate transparent motion vector define
            #if (defined(_TRANSPARENT_WRITES_MOTION_VEC) || defined(_TRANSPARENT_REFRACTIVE_SORT)) && defined(_SURFACE_TYPE_TRANSPARENT)
                #define _WRITE_TRANSPARENT_MOTION_VECTOR
            #endif
        
            // -- Graph Properties
            CBUFFER_START(UnityPerMaterial)
        float4 _DiffusionProfileAsset;
        float _DiffusionProfileHash;
        float4 _Texture2D_TexelSize;
        float4 _Albedo;
        float _Smoothness;
        float _WindSpeed;
        float _WindStrength;
        float4 _Normal_TexelSize;
        float _NormalStrength;
        float4 _EmissionColor;
        float _UseShadowThreshold;
        float4 _DoubleSidedConstants;
        float _BlendMode;
        float _EnableBlendModePreserveSpecularLighting;
        float _RayTracing;
        float _RefractionModel;
        float _MaterialID;
        float _MaterialTypeMask;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_Texture2D);
        SAMPLER(sampler_Texture2D);
        TEXTURE2D(_Normal);
        SAMPLER(sampler_Normal);
        
            // -- Property used by ScenePickingPass
            #ifdef SCENEPICKINGPASS
            float4 _SelectionID;
            #endif
        
            // -- Properties used by SceneSelectionPass
            #ifdef SCENESELECTIONPASS
            int _ObjectId;
            int _PassValue;
            #endif
        
            // Includes
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitDecalData.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"
        	// GraphIncludes: <None>
        
            // --------------------------------------------------
            // Structs and Packing
        
            struct AttributesMesh
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct VaryingsMeshToPS
        {
            SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
             float3 normalWS;
             float4 tangentWS;
             float4 texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
             float3 WorldSpacePosition;
             float4 uv0;
             float3 TimeParameters;
        };
        struct SurfaceDescriptionInputs
        {
             float3 TangentSpaceNormal;
             float4 uv0;
        };
        struct PackedVaryingsMeshToPS
        {
            SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
             float4 tangentWS : INTERP0;
             float4 texCoord0 : INTERP1;
             float3 normalWS : INTERP2;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
        };
        
            PackedVaryingsMeshToPS PackVaryingsMeshToPS (VaryingsMeshToPS input)
        {
            PackedVaryingsMeshToPS output;
            ZERO_INITIALIZE(PackedVaryingsMeshToPS, output);
            output.positionCS = input.positionCS;
            output.tangentWS.xyzw = input.tangentWS;
            output.texCoord0.xyzw = input.texCoord0;
            output.normalWS.xyz = input.normalWS;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            return output;
        }
        
        VaryingsMeshToPS UnpackVaryingsMeshToPS (PackedVaryingsMeshToPS input)
        {
            VaryingsMeshToPS output;
            output.positionCS = input.positionCS;
            output.tangentWS = input.tangentWS.xyzw;
            output.texCoord0 = input.texCoord0.xyzw;
            output.normalWS = input.normalWS.xyz;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            return output;
        }
        
        
            // --------------------------------------------------
            // Graph
        
        
            // Graph Functions
            
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_Sine_float(float In, out float Out)
        {
            Out = sin(In);
        }
        
        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }
        
        void Unity_Multiply_float4_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }
        
            // Graph Vertex
            struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            float _Property_8c596e62dce249caa7922ff3d7470d43_Out_0_Float = _WindSpeed;
            float _Split_35af25740d5a404097ccb209d36d5cac_R_1_Float = IN.WorldSpacePosition[0];
            float _Split_35af25740d5a404097ccb209d36d5cac_G_2_Float = IN.WorldSpacePosition[1];
            float _Split_35af25740d5a404097ccb209d36d5cac_B_3_Float = IN.WorldSpacePosition[2];
            float _Split_35af25740d5a404097ccb209d36d5cac_A_4_Float = 0;
            float _Add_c678bc9d08684d01a8e45ad5e636b4b4_Out_2_Float;
            Unity_Add_float(_Split_35af25740d5a404097ccb209d36d5cac_R_1_Float, _Split_35af25740d5a404097ccb209d36d5cac_B_3_Float, _Add_c678bc9d08684d01a8e45ad5e636b4b4_Out_2_Float);
            float _Add_0ec2f296c670483e9dc4250c81fe62a0_Out_2_Float;
            Unity_Add_float(IN.TimeParameters.x, _Add_c678bc9d08684d01a8e45ad5e636b4b4_Out_2_Float, _Add_0ec2f296c670483e9dc4250c81fe62a0_Out_2_Float);
            float _Multiply_ce5f4784040b450499733beaca915393_Out_2_Float;
            Unity_Multiply_float_float(_Property_8c596e62dce249caa7922ff3d7470d43_Out_0_Float, _Add_0ec2f296c670483e9dc4250c81fe62a0_Out_2_Float, _Multiply_ce5f4784040b450499733beaca915393_Out_2_Float);
            float _Sine_3c81889fed534b52996b5063cdc22296_Out_1_Float;
            Unity_Sine_float(_Multiply_ce5f4784040b450499733beaca915393_Out_2_Float, _Sine_3c81889fed534b52996b5063cdc22296_Out_1_Float);
            float _Property_3cdd281375794ed2bcad3550a9c890af_Out_0_Float = _WindStrength;
            float _Multiply_89ad4329fdd44befb161e56947c2670b_Out_2_Float;
            Unity_Multiply_float_float(_Sine_3c81889fed534b52996b5063cdc22296_Out_1_Float, _Property_3cdd281375794ed2bcad3550a9c890af_Out_0_Float, _Multiply_89ad4329fdd44befb161e56947c2670b_Out_2_Float);
            float4 _UV_30b55575e9844728bc3abbcaf84a22ff_Out_0_Vector4 = IN.uv0;
            float _Split_020d1040f8544c0b9d3de77e7fbd9197_R_1_Float = _UV_30b55575e9844728bc3abbcaf84a22ff_Out_0_Vector4[0];
            float _Split_020d1040f8544c0b9d3de77e7fbd9197_G_2_Float = _UV_30b55575e9844728bc3abbcaf84a22ff_Out_0_Vector4[1];
            float _Split_020d1040f8544c0b9d3de77e7fbd9197_B_3_Float = _UV_30b55575e9844728bc3abbcaf84a22ff_Out_0_Vector4[2];
            float _Split_020d1040f8544c0b9d3de77e7fbd9197_A_4_Float = _UV_30b55575e9844728bc3abbcaf84a22ff_Out_0_Vector4[3];
            float _Multiply_17088dc811eb45e4a333912f99b556ec_Out_2_Float;
            Unity_Multiply_float_float(_Multiply_89ad4329fdd44befb161e56947c2670b_Out_2_Float, _Split_020d1040f8544c0b9d3de77e7fbd9197_G_2_Float, _Multiply_17088dc811eb45e4a333912f99b556ec_Out_2_Float);
            float3 _Add_e473a1f67cd1441b9fccfb91c0b5ff75_Out_2_Vector3;
            Unity_Add_float3(IN.WorldSpacePosition, (_Multiply_17088dc811eb45e4a333912f99b556ec_Out_2_Float.xxx), _Add_e473a1f67cd1441b9fccfb91c0b5ff75_Out_2_Vector3);
            float3 _Add_8e06eedaa53749dea4ffc85b774f63ee_Out_2_Vector3;
            Unity_Add_float3(float3(0, 0, 0), _Add_e473a1f67cd1441b9fccfb91c0b5ff75_Out_2_Vector3, _Add_8e06eedaa53749dea4ffc85b774f63ee_Out_2_Vector3);
            float3 _Transform_78fa02a50d4c495cba1111966696417e_Out_1_Vector3;
            _Transform_78fa02a50d4c495cba1111966696417e_Out_1_Vector3 = TransformWorldToObject(_Add_8e06eedaa53749dea4ffc85b774f63ee_Out_2_Vector3.xyz);
            description.Position = _Transform_78fa02a50d4c495cba1111966696417e_Out_1_Vector3;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
            // Graph Pixel
            struct SurfaceDescription
        {
            float Alpha;
            float AlphaClipThreshold;
            float3 NormalTS;
            float Smoothness;
            float DiffusionProfileHash;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            UnityTexture2D _Property_bb313b600ca3404fb88a2820878a8482_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Texture2D);
            float4 _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_bb313b600ca3404fb88a2820878a8482_Out_0_Texture2D.tex, _Property_bb313b600ca3404fb88a2820878a8482_Out_0_Texture2D.samplerstate, _Property_bb313b600ca3404fb88a2820878a8482_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_R_4_Float = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4.r;
            float _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_G_5_Float = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4.g;
            float _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_B_6_Float = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4.b;
            float _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_A_7_Float = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4.a;
            UnityTexture2D _Property_ff2eff189fa74f1f965ec8aca53205ba_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Normal);
            float4 _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_ff2eff189fa74f1f965ec8aca53205ba_Out_0_Texture2D.tex, _Property_ff2eff189fa74f1f965ec8aca53205ba_Out_0_Texture2D.samplerstate, _Property_ff2eff189fa74f1f965ec8aca53205ba_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.rgb = UnpackNormal(_SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4);
            float _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_R_4_Float = _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.r;
            float _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_G_5_Float = _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.g;
            float _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_B_6_Float = _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.b;
            float _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_A_7_Float = _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.a;
            float _Property_915c3b0b5fc04c668c646f2f67b5ab2b_Out_0_Float = _NormalStrength;
            float4 _Multiply_e38eea28614c4b61bfd135ec8591a746_Out_2_Vector4;
            Unity_Multiply_float4_float4(_SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4, (_Property_915c3b0b5fc04c668c646f2f67b5ab2b_Out_0_Float.xxxx), _Multiply_e38eea28614c4b61bfd135ec8591a746_Out_2_Vector4);
            float _Property_925f8cb589d94edda2dcd6b588187f26_Out_0_Float = _Smoothness;
            float _Multiply_a061075fe3794cc5abff5f173997f7f8_Out_2_Float;
            Unity_Multiply_float_float(_Property_925f8cb589d94edda2dcd6b588187f26_Out_0_Float, _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_G_5_Float, _Multiply_a061075fe3794cc5abff5f173997f7f8_Out_2_Float);
            surface.Alpha = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_A_7_Float;
            surface.AlphaClipThreshold = 0.5;
            surface.NormalTS = (_Multiply_e38eea28614c4b61bfd135ec8591a746_Out_2_Vector4.xyz);
            surface.Smoothness = _Multiply_a061075fe3794cc5abff5f173997f7f8_Out_2_Float;
            surface.DiffusionProfileHash = _DiffusionProfileHash;
            return surface;
        }
        
            // --------------------------------------------------
            // Build Graph Inputs
            #ifdef HAVE_VFX_MODIFICATION
            #define VFX_SRP_ATTRIBUTES AttributesMesh
            #define VaryingsMeshType VaryingsMeshToPS
            #define VFX_SRP_VARYINGS VaryingsMeshType
            #define VFX_SRP_SURFACE_INPUTS FragInputs
            #endif
            
        VertexDescriptionInputs AttributesMeshToVertexDescriptionInputs(AttributesMesh input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
            output.WorldSpacePosition =                         TransformObjectToWorld(input.positionOS);
            output.uv0 =                                        input.uv0;
            output.TimeParameters =                             _TimeParameters.xyz; // Note: in case of animation this will be overwrite (allow to handle motion vector)
        
            return output;
        }
        
        VertexDescription GetVertexDescription(AttributesMesh input, float3 timeParameters
        #ifdef HAVE_VFX_MODIFICATION
            , AttributesElement element
        #endif
        )
        {
            // build graph inputs
            VertexDescriptionInputs vertexDescriptionInputs = AttributesMeshToVertexDescriptionInputs(input);
            // Override time parameters with used one (This is required to correctly handle motion vectors for vertex animation based on time)
            vertexDescriptionInputs.TimeParameters = timeParameters;
        
            // evaluate vertex graph
        #ifdef HAVE_VFX_MODIFICATION
            GraphProperties properties;
            ZERO_INITIALIZE(GraphProperties, properties);
        
            // Fetch the vertex graph properties for the particle instance.
            GetElementVertexProperties(element, properties);
        
            VertexDescription vertexDescription = VertexDescriptionFunction(vertexDescriptionInputs, properties);
        #else
            VertexDescription vertexDescription = VertexDescriptionFunction(vertexDescriptionInputs);
        #endif
            return vertexDescription;
        
        }
        
        AttributesMesh ApplyMeshModification(AttributesMesh input, float3 timeParameters
        #ifdef USE_CUSTOMINTERP_SUBSTRUCT
            #ifdef TESSELLATION_ON
            , inout VaryingsMeshToDS varyings
            #else
            , inout VaryingsMeshToPS varyings
            #endif
        #endif
        #ifdef HAVE_VFX_MODIFICATION
                , AttributesElement element
        #endif
            )
        {
            VertexDescription vertexDescription = GetVertexDescription(input, timeParameters
        #ifdef HAVE_VFX_MODIFICATION
                , element
        #endif
            );
        
            // copy graph output to the results
            input.positionOS = vertexDescription.Position;
            input.normalOS = vertexDescription.Normal;
            input.tangentOS.xyz = vertexDescription.Tangent;
        
            
        
            return input;
        }
        
        #if defined(_ADD_CUSTOM_VELOCITY) // For shader graph custom velocity
        // Return precomputed Velocity in object space
        float3 GetCustomVelocity(AttributesMesh input
        #ifdef HAVE_VFX_MODIFICATION
            , AttributesElement element
        #endif
        )
        {
            VertexDescription vertexDescription = GetVertexDescription(input, _TimeParameters.xyz
        #ifdef HAVE_VFX_MODIFICATION
                , element
        #endif
            );
            return vertexDescription.CustomVelocity;
        }
        #endif
        
        FragInputs BuildFragInputs(VaryingsMeshToPS input)
        {
            FragInputs output;
            ZERO_INITIALIZE(FragInputs, output);
        
            // Init to some default value to make the computer quiet (else it output 'divide by zero' warning even if value is not used).
            // TODO: this is a really poor workaround, but the variable is used in a bunch of places
            // to compute normals which are then passed on elsewhere to compute other values...
            output.tangentToWorld = k_identity3x3;
            output.positionSS = input.positionCS;       // input.positionCS is SV_Position
        
            output.tangentToWorld =             BuildTangentToWorld(input.tangentWS, input.normalWS);
            output.texCoord0 =                  input.texCoord0;
        
        
        #ifdef HAVE_VFX_MODIFICATION
            // FragInputs from VFX come from two places: Interpolator or CBuffer.
        #if VFX_USE_GRAPH_VALUES
            uint instanceActiveIndex = asuint(UNITY_ACCESS_INSTANCED_PROP(PerInstance, _InstanceActiveIndex));
            /* WARNING: $splice Could not find named fragment 'VFXLoadGraphValues' */
        #endif
        
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            // splice point to copy custom interpolator fields from varyings to frag inputs
            
        
            return output;
        }
        
        // existing HDRP code uses the combined function to go directly from packed to frag inputs
        FragInputs UnpackVaryingsMeshToFragInputs(PackedVaryingsMeshToPS input)
        {
            UNITY_SETUP_INSTANCE_ID(input);
        #if defined(HAVE_VFX_MODIFICATION) && defined(UNITY_INSTANCING_ENABLED)
            unity_InstanceID = input.instanceID;
        #endif
            VaryingsMeshToPS unpacked = UnpackVaryingsMeshToPS(input);
            return BuildFragInputs(unpacked);
        }
            SurfaceDescriptionInputs FragInputsToSurfaceDescriptionInputs(FragInputs input, float3 viewWS)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
            #if defined(SHADER_STAGE_RAY_TRACING)
            #else
            #endif
            output.TangentSpaceNormal =                         float3(0.0f, 0.0f, 1.0f);
        
        #if UNITY_UV_STARTS_AT_TOP
        #else
        #endif
        
        
            output.uv0 =                                        input.texCoord0;
        
            // splice point to copy frag inputs custom interpolator pack into the SDI
            
        
            return output;
        }
        
            // --------------------------------------------------
            // Build Surface Data (Specific Material)
        
        void ApplyDecalToSurfaceDataNoNormal(DecalSurfaceData decalSurfaceData, inout SurfaceData surfaceData);
        
        void ApplyDecalAndGetNormal(FragInputs fragInputs, PositionInputs posInput, SurfaceDescription surfaceDescription,
            inout SurfaceData surfaceData)
        {
            float3 doubleSidedConstants = GetDoubleSidedConstants();
        
        #ifdef DECAL_NORMAL_BLENDING
            // SG nodes don't ouptut surface gradients, so if decals require surf grad blending, we have to convert
            // the normal to gradient before applying the decal. We then have to resolve the gradient back to world space
            float3 normalTS;
        
            normalTS = SurfaceGradientFromTangentSpaceNormalAndFromTBN(surfaceDescription.NormalTS,
            fragInputs.tangentToWorld[0], fragInputs.tangentToWorld[1]);
        
        
            #if HAVE_DECALS
            if (_EnableDecals)
            {
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                ApplyDecalToSurfaceNormal(decalSurfaceData, fragInputs.tangentToWorld[2], normalTS);
                ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
            }
            #endif
        
            GetNormalWS_SG(fragInputs, normalTS, surfaceData.normalWS, doubleSidedConstants);
        #else
            // normal delivered to master node
            GetNormalWS(fragInputs, surfaceDescription.NormalTS, surfaceData.normalWS, doubleSidedConstants);
        
            #if HAVE_DECALS
            if (_EnableDecals)
            {
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                // Both uses and modifies 'surfaceData.normalWS'.
                DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                ApplyDecalToSurfaceNormal(decalSurfaceData, surfaceData.normalWS.xyz);
                ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
            }
            #endif
        #endif
        }
        void BuildSurfaceData(FragInputs fragInputs, inout SurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
        {
            ZERO_INITIALIZE(SurfaceData, surfaceData);
        
            // specularOcclusion need to be init ahead of decal to quiet the compiler that modify the SurfaceData struct
            // however specularOcclusion can come from the graph, so need to be init here so it can be override.
            surfaceData.specularOcclusion = 1.0;
            surfaceData.thickness = 0.0;
        
            surfaceData.perceptualSmoothness =      surfaceDescription.Smoothness;
            surfaceData.diffusionProfileHash =      asuint(surfaceDescription.DiffusionProfileHash);
        
            #if defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE) || defined(_REFRACTION_THIN)
                if (_EnableSSRefraction)
                {
        
                    surfaceData.transmittanceMask = (1.0 - surfaceDescription.Alpha);
                    surfaceDescription.Alpha = 1.0;
                }
                else
                {
                    surfaceData.ior = 1.0;
                    surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                    surfaceData.atDistance = 1.0;
                    surfaceData.transmittanceMask = 0.0;
                    surfaceDescription.Alpha = 1.0;
                }
            #else
                surfaceData.ior = 1.0;
                surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                surfaceData.atDistance = 1.0;
                surfaceData.transmittanceMask = 0.0;
            #endif
        
            // These static material feature allow compile time optimization
            surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;
            #ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
            #endif
        
            #ifdef _MATERIAL_FEATURE_TRANSMISSION
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
            #endif
        
            #ifdef _MATERIAL_FEATURE_COLORED_TRANSMISSION
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_COLORED_TRANSMISSION;
        
            #endif
        
            #ifdef _MATERIAL_FEATURE_ANISOTROPY
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
        
                // Initialize the normal to something non-zero to avoid a div-zero warning for anisotropy.
                surfaceData.normalWS = float3(0, 1, 0);
            #endif
        
            #ifdef _MATERIAL_FEATURE_IRIDESCENCE
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
            #endif
        
            #ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
            #endif
        
            #ifdef _MATERIAL_FEATURE_CLEAR_COAT
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
            #endif
        
            #if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
                // Require to have setup baseColor
                // Reproduce the energy conservation done in legacy Unity. Not ideal but better for compatibility and users can unchek it
                surfaceData.baseColor *= (1.0 - Max3(surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b));
            #endif
        
            float3 doubleSidedConstants = GetDoubleSidedConstants();
        
            ApplyDecalAndGetNormal(fragInputs, posInput, surfaceDescription, surfaceData);
        
            surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];
        
            surfaceData.tangentWS = normalize(fragInputs.tangentToWorld[0].xyz);    // The tangent is not normalize in tangentToWorld for mikkt. TODO: Check if it expected that we normalize with Morten. Tag: SURFACE_GRADIENT
        
        
            bentNormalWS = surfaceData.normalWS;
        
            surfaceData.tangentWS = Orthonormalize(surfaceData.tangentWS, surfaceData.normalWS);
        
            #ifdef DEBUG_DISPLAY
                if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
                {
                    // TODO: need to update mip info
                    surfaceData.metallic = 0;
                }
        
                // We need to call ApplyDebugToSurfaceData after filling the surfarcedata and before filling builtinData
                // as it can modify attribute use for static lighting
                ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData);
            #endif
        
            // By default we use the ambient occlusion with Tri-ace trick (apply outside) for specular occlusion.
            // If user provide bent normal then we process a better term
            #if defined(_SPECULAR_OCCLUSION_CUSTOM)
                // Just use the value passed through via the slot (not active otherwise)
            #elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
                // If we have bent normal and ambient occlusion, process a specular occlusion
                surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO(V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness(surfaceData.perceptualSmoothness));
            #elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
                surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion(ClampNdotV(dot(surfaceData.normalWS, V)), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness(surfaceData.perceptualSmoothness));
            #endif
        
            #if defined(_ENABLE_GEOMETRIC_SPECULAR_AA) && !defined(SHADER_STAGE_RAY_TRACING)
                surfaceData.perceptualSmoothness = GeometricNormalFiltering(surfaceData.perceptualSmoothness, fragInputs.tangentToWorld[2], surfaceDescription.SpecularAAScreenSpaceVariance, surfaceDescription.SpecularAAThreshold);
            #endif
        }
        
            // --------------------------------------------------
            // Get Surface And BuiltinData
        
            void GetSurfaceAndBuiltinData(FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData RAY_TRACING_OPTIONAL_PARAMETERS)
            {
                // Don't dither if displaced tessellation (we're fading out the displacement instead to match the next LOD)
                #if !defined(SHADER_STAGE_RAY_TRACING) && !defined(_TESSELLATION_DISPLACEMENT)
                #ifdef LOD_FADE_CROSSFADE // enable dithering LOD transition if user select CrossFade transition in LOD group
                LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
                #endif
                #endif
        
                #ifndef SHADER_UNLIT
                #ifdef _DOUBLESIDED_ON
                    float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
                #else
                    float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
                #endif
        
                ApplyDoubleSidedFlipOrMirror(fragInputs, doubleSidedConstants); // Apply double sided flip on the vertex normal
                #endif // SHADER_UNLIT
        
                SurfaceDescriptionInputs surfaceDescriptionInputs = FragInputsToSurfaceDescriptionInputs(fragInputs, V);
        
                #if defined(HAVE_VFX_MODIFICATION)
                GraphProperties properties;
                ZERO_INITIALIZE(GraphProperties, properties);
        
                GetElementPixelProperties(fragInputs, properties);
        
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs, properties);
                #else
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs);
                #endif
        
                // Perform alpha test very early to save performance (a killed pixel will not sample textures)
                // TODO: split graph evaluation to grab just alpha dependencies first? tricky..
                #ifdef _ALPHATEST_ON
                    float alphaCutoff = surfaceDescription.AlphaClipThreshold;
                    #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
                    // The TransparentDepthPrepass is also used with SSR transparent.
                    // If an artists enable transaprent SSR but not the TransparentDepthPrepass itself, then we use AlphaClipThreshold
                    // otherwise if TransparentDepthPrepass is enabled we use AlphaClipThresholdDepthPrepass
                    #elif SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_POSTPASS
                    // DepthPostpass always use its own alpha threshold
                    alphaCutoff = surfaceDescription.AlphaClipThresholdDepthPostpass;
                    #elif (SHADERPASS == SHADERPASS_SHADOWS) || (SHADERPASS == SHADERPASS_RAYTRACING_VISIBILITY)
                    // If use shadow threshold isn't enable we don't allow any test
                    #endif
        
                    GENERIC_ALPHA_TEST(surfaceDescription.Alpha, alphaCutoff);
                #endif
        
                #if !defined(SHADER_STAGE_RAY_TRACING) && _DEPTHOFFSET_ON
                ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
                #endif
        
                #ifndef SHADER_UNLIT
                float3 bentNormalWS;
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS);
        
                #ifdef FRAG_INPUTS_USE_TEXCOORD1
                    float4 lightmapTexCoord1 = fragInputs.texCoord1;
                #else
                    float4 lightmapTexCoord1 = float4(0,0,0,0);
                #endif
        
                #ifdef FRAG_INPUTS_USE_TEXCOORD2
                    float4 lightmapTexCoord2 = fragInputs.texCoord2;
                #else
                    float4 lightmapTexCoord2 = float4(0,0,0,0);
                #endif
        
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                // Builtin Data
                // For back lighting we use the oposite vertex normal
                InitBuiltinData(posInput, alpha, bentNormalWS, -fragInputs.tangentToWorld[2], lightmapTexCoord1, lightmapTexCoord2, builtinData);
        
                #else
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData);
        
                ZERO_BUILTIN_INITIALIZE(builtinData); // No call to InitBuiltinData as we don't have any lighting
                builtinData.opacity = surfaceDescription.Alpha;
        
                #if defined(DEBUG_DISPLAY)
                    // Light Layers are currently not used for the Unlit shader (because it is not lit)
                    // But Unlit objects do cast shadows according to their rendering layer mask, which is what we want to
                    // display in the light layers visualization mode, therefore we need the renderingLayers
                    builtinData.renderingLayers = GetMeshRenderingLayerMask();
                #endif
        
                #endif // SHADER_UNLIT
        
                #ifdef _ALPHATEST_ON
                    // Used for sharpening by alpha to mask - Alpha to covertage is only used with depth only and forward pass (no shadow pass, no transparent pass)
                    builtinData.alphaClipTreshold = alphaCutoff;
                #endif
        
                // override sampleBakedGI - not used by Unlit
        		// When overriding GI, we need to force the isLightmap flag to make sure we don't add APV (sampled in the lightloop) on top of the overridden value (set at GBuffer stage)
        
        
                // Note this will not fully work on transparent surfaces (can check with _SURFACE_TYPE_TRANSPARENT define)
                // We will always overwrite vt feeback with the nearest. So behind transparent surfaces vt will not be resolved
                // This is a limitation of the current MRT approach.
                #ifdef UNITY_VIRTUAL_TEXTURING
                #endif
        
                #if _DEPTHOFFSET_ON
                builtinData.depthOffset = surfaceDescription.DepthOffset;
                #endif
        
                // TODO: We should generate distortion / distortionBlur for non distortion pass
                #if (SHADERPASS == SHADERPASS_DISTORTION)
                builtinData.distortion = surfaceDescription.Distortion;
                builtinData.distortionBlur = surfaceDescription.DistortionBlur;
                #endif
        
                #ifndef SHADER_UNLIT
                // PostInitBuiltinData call ApplyDebugToBuiltinData
                PostInitBuiltinData(V, posInput, surfaceData, builtinData);
                #else
                ApplyDebugToBuiltinData(builtinData);
                #endif
        
                RAY_TRACING_OPTIONAL_ALPHA_TEST_PASS
            }
        
            // --------------------------------------------------
            // Main
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPassDepthOnly.hlsl"
        
            // --------------------------------------------------
            // Visual Effect Vertex Invocations
        
        	#ifdef HAVE_VFX_MODIFICATION
                #if !defined(SHADER_STAGE_RAY_TRACING)
        	    #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/VisualEffectVertex.hlsl"
                #else
                #endif
        	#endif
        
            #include "Assets/VegetationInstancer/Shaders/Include/GPUInstancedIndirectInclude.cginc"
#pragma instancing_options procedural:setupGPUInstancedIndirect
#pragma multi_compile_instancing
ENDHLSL
        }
        Pass
        {
            Name "FullScreenDebug"
            Tags
            {
                "LightMode" = "FullScreenDebug"
            }
        
            // Render State
            Cull [_CullMode]
        ZTest LEqual
        ZWrite Off
        
            // Debug
            // <None>
        
            // --------------------------------------------------
            // Pass
        
            HLSLPROGRAM
        
            // Pragmas
            #pragma multi_compile _ DOTS_INSTANCING_ON
        
        #pragma target 4.5
        #pragma vertex Vert
        #pragma fragment Frag
        #pragma only_renderers d3d11 playstation xboxone xboxseries vulkan metal switch
        
        
            // Keywords
            #pragma shader_feature_local _ _ALPHATEST_ON
        #pragma shader_feature _ _SURFACE_TYPE_TRANSPARENT
        #pragma shader_feature_local _ _DOUBLESIDED_ON
        #pragma shader_feature_local _ _ADD_PRECOMPUTED_VELOCITY
        #pragma shader_feature_local _ _TRANSPARENT_WRITES_MOTION_VEC _TRANSPARENT_REFRACTIVE_SORT
        #pragma shader_feature_local_fragment _ _ENABLE_FOG_ON_TRANSPARENT
        #pragma shader_feature_local_fragment _ _DISABLE_DECALS
        #pragma shader_feature_local_raytracing _ _DISABLE_DECALS
        #pragma shader_feature_local_fragment _ _DISABLE_SSR
        #pragma shader_feature_local_raytracing _ _DISABLE_SSR
        #pragma shader_feature_local_fragment _ _DISABLE_SSR_TRANSPARENT
        #pragma shader_feature_local_raytracing _ _DISABLE_SSR_TRANSPARENT
        #pragma shader_feature_local _ _REFRACTION_PLANE _REFRACTION_SPHERE _REFRACTION_THIN
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_TRANSMISSION
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_TRANSMISSION
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_ANISOTROPY
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_ANISOTROPY
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_IRIDESCENCE
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_IRIDESCENCE
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_SPECULAR_COLOR
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_SPECULAR_COLOR
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_COLORED_TRANSMISSION
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_COLORED_TRANSMISSION
            // GraphKeywords: <None>
        
            // Defines
            #define SHADERPASS SHADERPASS_FULL_SCREEN_DEBUG
        #define RAYTRACING_SHADER_GRAPH_DEFAULT
        
            // For custom interpolators to inject a substruct definition before FragInputs definition,
            // allowing for FragInputs to capture CI's intended for ShaderGraph's SDI.
            struct CustomInterpolators
        {
        };
        #define USE_CUSTOMINTERP_SUBSTRUCT
        
        
        
            // TODO: Merge FragInputsVFX substruct with CustomInterpolators.
        	#ifdef HAVE_VFX_MODIFICATION
        	struct FragInputsVFX
            {
                /* WARNING: $splice Could not find named fragment 'FragInputsVFX' */
            };
            #endif
        
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl" // Required by Tessellation.hlsl
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Tessellation.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl" // Required to be include before we include properties as it define DECLARE_STACK_CB
            // Always include Shader Graph version
            // Always include last to avoid double macros
            #include "Packages/com.unity.shadergraph/ShaderGraphLibrary/Functions.hlsl" // Need to be here for Gradient struct definition
        
            // --------------------------------------------------
            // Defines
        
            // Attribute
            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define ATTRIBUTES_NEED_TEXCOORD0
            #define VARYINGS_NEED_TEXCOORD0
        
            #define HAVE_MESH_MODIFICATION
        
            //Strip down the FragInputs.hlsl (on graphics), so we can only optimize the interpolators we use.
            //if by accident something requests contents of FragInputs.hlsl, it will be caught as a compiler error
            //Frag inputs stripping is only enabled when FRAG_INPUTS_ENABLE_STRIPPING is set
            #if !defined(SHADER_STAGE_RAY_TRACING) && SHADERPASS != SHADERPASS_RAYTRACING_GBUFFER && SHADERPASS != SHADERPASS_FULL_SCREEN_DEBUG
            #define FRAG_INPUTS_ENABLE_STRIPPING
            #endif
            #define FRAG_INPUTS_USE_TEXCOORD0
        
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
        
        
        
        
            // Following two define are a workaround introduce in 10.1.x for RaytracingQualityNode
            // The ShaderGraph don't support correctly migration of this node as it serialize all the node data
            // in the json file making it impossible to uprgrade. Until we get a fix, we do a workaround here
            // to still allow us to rename the field and keyword of this node without breaking existing code.
            #ifdef RAYTRACING_SHADER_GRAPH_DEFAULT
            #define RAYTRACING_SHADER_GRAPH_HIGH
            #endif
        
            #ifdef RAYTRACING_SHADER_GRAPH_RAYTRACED
            #define RAYTRACING_SHADER_GRAPH_LOW
            #endif
            // end
        
            #ifndef SHADER_UNLIT
            // We need isFrontFace when using double sided - it is not required for unlit as in case of unlit double sided only drive the cullmode
            // VARYINGS_NEED_CULLFACE can be define by VaryingsMeshToPS.FaceSign input if a IsFrontFace Node is included in the shader graph.
            #if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
                #define VARYINGS_NEED_CULLFACE
            #endif
            #endif
        
            // Specific Material Define
        #define _SPECULAR_OCCLUSION_FROM_AO 1
        #define _ENERGY_CONSERVING_SPECULAR 1
        
        #if _MATERIAL_FEATURE_COLORED_TRANSMISSION
            // Colored Transmission doesn't support clear coat
            #undef _MATERIAL_FEATURE_CLEAR_COAT
        #endif
        
        // If we use subsurface scattering, enable output split lighting (for forward pass)
        #if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
            #define OUTPUT_SPLIT_LIGHTING
        #endif
        
        // This shader support recursive rendering for raytracing
        #define HAVE_RECURSIVE_RENDERING
        
        // In Path Tracing, For all single-sided, refractive materials, we want to force a thin refraction model
        #if (SHADERPASS == SHADERPASS_PATH_TRACING) && !defined(_DOUBLESIDED_ON) && (defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE))
            #undef  _REFRACTION_PLANE
            #undef  _REFRACTION_SPHERE
            #define _REFRACTION_THIN
        #endif
            // Caution: we can use the define SHADER_UNLIT onlit after the above Material include as it is the Unlit template who define it
        
            // To handle SSR on transparent correctly with a possibility to enable/disable it per framesettings
            // we should have a code like this:
            // if !defined(_DISABLE_SSR_TRANSPARENT)
            // pragma multi_compile _ WRITE_NORMAL_BUFFER
            // endif
            // i.e we enable the multicompile only if we can receive SSR or not, and then C# code drive
            // it based on if SSR transparent in frame settings and not (and stripper can strip it).
            // this is currently not possible with our current preprocessor as _DISABLE_SSR_TRANSPARENT is a keyword not a define
            // so instead we used this and chose to pay the extra cost of normal write even if SSR transaprent is disabled.
            // Ideally the shader graph generator should handle it but condition below can't be handle correctly for now.
            #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
            #if !defined(_DISABLE_SSR_TRANSPARENT) && !defined(SHADER_UNLIT)
                #define WRITE_NORMAL_BUFFER
            #endif
            #endif
        
            // See Lit.shader
            #if SHADERPASS == SHADERPASS_MOTION_VECTORS && defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)
                #define WRITE_DECAL_BUFFER
            #endif
        
            #ifndef DEBUG_DISPLAY
                // In case of opaque we don't want to perform the alpha test, it is done in depth prepass and we use depth equal for ztest (setup from UI)
                // Don't do it with debug display mode as it is possible there is no depth prepass in this case
                #if !defined(_SURFACE_TYPE_TRANSPARENT)
                    #if SHADERPASS == SHADERPASS_FORWARD
                    #define SHADERPASS_FORWARD_BYPASS_ALPHA_TEST
                    #elif SHADERPASS == SHADERPASS_GBUFFER
                    #define SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST
                    #endif
                #endif
            #endif
        
            // Define _DEFERRED_CAPABLE_MATERIAL for shader capable to run in deferred pass
            #if defined(SHADER_LIT) && !defined(_SURFACE_TYPE_TRANSPARENT)
                #define _DEFERRED_CAPABLE_MATERIAL
            #endif
        
            // Translate transparent motion vector define
            #if (defined(_TRANSPARENT_WRITES_MOTION_VEC) || defined(_TRANSPARENT_REFRACTIVE_SORT)) && defined(_SURFACE_TYPE_TRANSPARENT)
                #define _WRITE_TRANSPARENT_MOTION_VECTOR
            #endif
        
            // -- Graph Properties
            CBUFFER_START(UnityPerMaterial)
        float4 _DiffusionProfileAsset;
        float _DiffusionProfileHash;
        float4 _Texture2D_TexelSize;
        float4 _Albedo;
        float _Smoothness;
        float _WindSpeed;
        float _WindStrength;
        float4 _Normal_TexelSize;
        float _NormalStrength;
        float4 _EmissionColor;
        float _UseShadowThreshold;
        float4 _DoubleSidedConstants;
        float _BlendMode;
        float _EnableBlendModePreserveSpecularLighting;
        float _RayTracing;
        float _RefractionModel;
        float _MaterialID;
        float _MaterialTypeMask;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_Texture2D);
        SAMPLER(sampler_Texture2D);
        TEXTURE2D(_Normal);
        SAMPLER(sampler_Normal);
        
            // -- Property used by ScenePickingPass
            #ifdef SCENEPICKINGPASS
            float4 _SelectionID;
            #endif
        
            // -- Properties used by SceneSelectionPass
            #ifdef SCENESELECTIONPASS
            int _ObjectId;
            int _PassValue;
            #endif
        
            // Includes
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"
        	// GraphIncludes: <None>
        
            // --------------------------------------------------
            // Structs and Packing
        
            struct AttributesMesh
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct VaryingsMeshToPS
        {
            SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
             float4 texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
             float3 WorldSpacePosition;
             float4 uv0;
             float3 TimeParameters;
        };
        struct SurfaceDescriptionInputs
        {
             float3 TangentSpaceNormal;
             float4 uv0;
        };
        struct PackedVaryingsMeshToPS
        {
            SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
             float4 texCoord0 : INTERP0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
        };
        
            PackedVaryingsMeshToPS PackVaryingsMeshToPS (VaryingsMeshToPS input)
        {
            PackedVaryingsMeshToPS output;
            ZERO_INITIALIZE(PackedVaryingsMeshToPS, output);
            output.positionCS = input.positionCS;
            output.texCoord0.xyzw = input.texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            return output;
        }
        
        VaryingsMeshToPS UnpackVaryingsMeshToPS (PackedVaryingsMeshToPS input)
        {
            VaryingsMeshToPS output;
            output.positionCS = input.positionCS;
            output.texCoord0 = input.texCoord0.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            return output;
        }
        
        
            // --------------------------------------------------
            // Graph
        
        
            // Graph Functions
            
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_Sine_float(float In, out float Out)
        {
            Out = sin(In);
        }
        
        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }
        
        void Unity_Multiply_float4_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }
        
            // Graph Vertex
            struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            float _Property_8c596e62dce249caa7922ff3d7470d43_Out_0_Float = _WindSpeed;
            float _Split_35af25740d5a404097ccb209d36d5cac_R_1_Float = IN.WorldSpacePosition[0];
            float _Split_35af25740d5a404097ccb209d36d5cac_G_2_Float = IN.WorldSpacePosition[1];
            float _Split_35af25740d5a404097ccb209d36d5cac_B_3_Float = IN.WorldSpacePosition[2];
            float _Split_35af25740d5a404097ccb209d36d5cac_A_4_Float = 0;
            float _Add_c678bc9d08684d01a8e45ad5e636b4b4_Out_2_Float;
            Unity_Add_float(_Split_35af25740d5a404097ccb209d36d5cac_R_1_Float, _Split_35af25740d5a404097ccb209d36d5cac_B_3_Float, _Add_c678bc9d08684d01a8e45ad5e636b4b4_Out_2_Float);
            float _Add_0ec2f296c670483e9dc4250c81fe62a0_Out_2_Float;
            Unity_Add_float(IN.TimeParameters.x, _Add_c678bc9d08684d01a8e45ad5e636b4b4_Out_2_Float, _Add_0ec2f296c670483e9dc4250c81fe62a0_Out_2_Float);
            float _Multiply_ce5f4784040b450499733beaca915393_Out_2_Float;
            Unity_Multiply_float_float(_Property_8c596e62dce249caa7922ff3d7470d43_Out_0_Float, _Add_0ec2f296c670483e9dc4250c81fe62a0_Out_2_Float, _Multiply_ce5f4784040b450499733beaca915393_Out_2_Float);
            float _Sine_3c81889fed534b52996b5063cdc22296_Out_1_Float;
            Unity_Sine_float(_Multiply_ce5f4784040b450499733beaca915393_Out_2_Float, _Sine_3c81889fed534b52996b5063cdc22296_Out_1_Float);
            float _Property_3cdd281375794ed2bcad3550a9c890af_Out_0_Float = _WindStrength;
            float _Multiply_89ad4329fdd44befb161e56947c2670b_Out_2_Float;
            Unity_Multiply_float_float(_Sine_3c81889fed534b52996b5063cdc22296_Out_1_Float, _Property_3cdd281375794ed2bcad3550a9c890af_Out_0_Float, _Multiply_89ad4329fdd44befb161e56947c2670b_Out_2_Float);
            float4 _UV_30b55575e9844728bc3abbcaf84a22ff_Out_0_Vector4 = IN.uv0;
            float _Split_020d1040f8544c0b9d3de77e7fbd9197_R_1_Float = _UV_30b55575e9844728bc3abbcaf84a22ff_Out_0_Vector4[0];
            float _Split_020d1040f8544c0b9d3de77e7fbd9197_G_2_Float = _UV_30b55575e9844728bc3abbcaf84a22ff_Out_0_Vector4[1];
            float _Split_020d1040f8544c0b9d3de77e7fbd9197_B_3_Float = _UV_30b55575e9844728bc3abbcaf84a22ff_Out_0_Vector4[2];
            float _Split_020d1040f8544c0b9d3de77e7fbd9197_A_4_Float = _UV_30b55575e9844728bc3abbcaf84a22ff_Out_0_Vector4[3];
            float _Multiply_17088dc811eb45e4a333912f99b556ec_Out_2_Float;
            Unity_Multiply_float_float(_Multiply_89ad4329fdd44befb161e56947c2670b_Out_2_Float, _Split_020d1040f8544c0b9d3de77e7fbd9197_G_2_Float, _Multiply_17088dc811eb45e4a333912f99b556ec_Out_2_Float);
            float3 _Add_e473a1f67cd1441b9fccfb91c0b5ff75_Out_2_Vector3;
            Unity_Add_float3(IN.WorldSpacePosition, (_Multiply_17088dc811eb45e4a333912f99b556ec_Out_2_Float.xxx), _Add_e473a1f67cd1441b9fccfb91c0b5ff75_Out_2_Vector3);
            float3 _Add_8e06eedaa53749dea4ffc85b774f63ee_Out_2_Vector3;
            Unity_Add_float3(float3(0, 0, 0), _Add_e473a1f67cd1441b9fccfb91c0b5ff75_Out_2_Vector3, _Add_8e06eedaa53749dea4ffc85b774f63ee_Out_2_Vector3);
            float3 _Transform_78fa02a50d4c495cba1111966696417e_Out_1_Vector3;
            _Transform_78fa02a50d4c495cba1111966696417e_Out_1_Vector3 = TransformWorldToObject(_Add_8e06eedaa53749dea4ffc85b774f63ee_Out_2_Vector3.xyz);
            description.Position = _Transform_78fa02a50d4c495cba1111966696417e_Out_1_Vector3;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
            // Graph Pixel
            struct SurfaceDescription
        {
            float3 BaseColor;
            float3 Emission;
            float Alpha;
            float AlphaClipThreshold;
            float3 BentNormal;
            float Smoothness;
            float Occlusion;
            float3 NormalTS;
            float TransmissionMask;
            float Thickness;
            float DiffusionProfileHash;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float4 _Property_35c125abbbcb46e1a2351d8febeb5da1_Out_0_Vector4 = _Albedo;
            UnityTexture2D _Property_bb313b600ca3404fb88a2820878a8482_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Texture2D);
            float4 _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_bb313b600ca3404fb88a2820878a8482_Out_0_Texture2D.tex, _Property_bb313b600ca3404fb88a2820878a8482_Out_0_Texture2D.samplerstate, _Property_bb313b600ca3404fb88a2820878a8482_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_R_4_Float = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4.r;
            float _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_G_5_Float = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4.g;
            float _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_B_6_Float = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4.b;
            float _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_A_7_Float = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4.a;
            float4 _Multiply_c09cca22f04c4a9a996a5ccf8f61afe1_Out_2_Vector4;
            Unity_Multiply_float4_float4(_Property_35c125abbbcb46e1a2351d8febeb5da1_Out_0_Vector4, _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4, _Multiply_c09cca22f04c4a9a996a5ccf8f61afe1_Out_2_Vector4);
            float _Property_925f8cb589d94edda2dcd6b588187f26_Out_0_Float = _Smoothness;
            float _Multiply_a061075fe3794cc5abff5f173997f7f8_Out_2_Float;
            Unity_Multiply_float_float(_Property_925f8cb589d94edda2dcd6b588187f26_Out_0_Float, _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_G_5_Float, _Multiply_a061075fe3794cc5abff5f173997f7f8_Out_2_Float);
            UnityTexture2D _Property_ff2eff189fa74f1f965ec8aca53205ba_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Normal);
            float4 _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_ff2eff189fa74f1f965ec8aca53205ba_Out_0_Texture2D.tex, _Property_ff2eff189fa74f1f965ec8aca53205ba_Out_0_Texture2D.samplerstate, _Property_ff2eff189fa74f1f965ec8aca53205ba_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.rgb = UnpackNormal(_SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4);
            float _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_R_4_Float = _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.r;
            float _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_G_5_Float = _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.g;
            float _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_B_6_Float = _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.b;
            float _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_A_7_Float = _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.a;
            float _Property_915c3b0b5fc04c668c646f2f67b5ab2b_Out_0_Float = _NormalStrength;
            float4 _Multiply_e38eea28614c4b61bfd135ec8591a746_Out_2_Vector4;
            Unity_Multiply_float4_float4(_SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4, (_Property_915c3b0b5fc04c668c646f2f67b5ab2b_Out_0_Float.xxxx), _Multiply_e38eea28614c4b61bfd135ec8591a746_Out_2_Vector4);
            surface.BaseColor = (_Multiply_c09cca22f04c4a9a996a5ccf8f61afe1_Out_2_Vector4.xyz);
            surface.Emission = float3(0, 0, 0);
            surface.Alpha = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_A_7_Float;
            surface.AlphaClipThreshold = 0.5;
            surface.BentNormal = IN.TangentSpaceNormal;
            surface.Smoothness = _Multiply_a061075fe3794cc5abff5f173997f7f8_Out_2_Float;
            surface.Occlusion = 1;
            surface.NormalTS = (_Multiply_e38eea28614c4b61bfd135ec8591a746_Out_2_Vector4.xyz);
            surface.TransmissionMask = 1;
            surface.Thickness = 1;
            surface.DiffusionProfileHash = _DiffusionProfileHash;
            return surface;
        }
        
            // --------------------------------------------------
            // Build Graph Inputs
            #ifdef HAVE_VFX_MODIFICATION
            #define VFX_SRP_ATTRIBUTES AttributesMesh
            #define VaryingsMeshType VaryingsMeshToPS
            #define VFX_SRP_VARYINGS VaryingsMeshType
            #define VFX_SRP_SURFACE_INPUTS FragInputs
            #endif
            
        VertexDescriptionInputs AttributesMeshToVertexDescriptionInputs(AttributesMesh input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
            output.WorldSpacePosition =                         TransformObjectToWorld(input.positionOS);
            output.uv0 =                                        input.uv0;
            output.TimeParameters =                             _TimeParameters.xyz; // Note: in case of animation this will be overwrite (allow to handle motion vector)
        
            return output;
        }
        
        VertexDescription GetVertexDescription(AttributesMesh input, float3 timeParameters
        #ifdef HAVE_VFX_MODIFICATION
            , AttributesElement element
        #endif
        )
        {
            // build graph inputs
            VertexDescriptionInputs vertexDescriptionInputs = AttributesMeshToVertexDescriptionInputs(input);
            // Override time parameters with used one (This is required to correctly handle motion vectors for vertex animation based on time)
            vertexDescriptionInputs.TimeParameters = timeParameters;
        
            // evaluate vertex graph
        #ifdef HAVE_VFX_MODIFICATION
            GraphProperties properties;
            ZERO_INITIALIZE(GraphProperties, properties);
        
            // Fetch the vertex graph properties for the particle instance.
            GetElementVertexProperties(element, properties);
        
            VertexDescription vertexDescription = VertexDescriptionFunction(vertexDescriptionInputs, properties);
        #else
            VertexDescription vertexDescription = VertexDescriptionFunction(vertexDescriptionInputs);
        #endif
            return vertexDescription;
        
        }
        
        AttributesMesh ApplyMeshModification(AttributesMesh input, float3 timeParameters
        #ifdef USE_CUSTOMINTERP_SUBSTRUCT
            #ifdef TESSELLATION_ON
            , inout VaryingsMeshToDS varyings
            #else
            , inout VaryingsMeshToPS varyings
            #endif
        #endif
        #ifdef HAVE_VFX_MODIFICATION
                , AttributesElement element
        #endif
            )
        {
            VertexDescription vertexDescription = GetVertexDescription(input, timeParameters
        #ifdef HAVE_VFX_MODIFICATION
                , element
        #endif
            );
        
            // copy graph output to the results
            input.positionOS = vertexDescription.Position;
            input.normalOS = vertexDescription.Normal;
            input.tangentOS.xyz = vertexDescription.Tangent;
        
            
        
            return input;
        }
        
        #if defined(_ADD_CUSTOM_VELOCITY) // For shader graph custom velocity
        // Return precomputed Velocity in object space
        float3 GetCustomVelocity(AttributesMesh input
        #ifdef HAVE_VFX_MODIFICATION
            , AttributesElement element
        #endif
        )
        {
            VertexDescription vertexDescription = GetVertexDescription(input, _TimeParameters.xyz
        #ifdef HAVE_VFX_MODIFICATION
                , element
        #endif
            );
            return vertexDescription.CustomVelocity;
        }
        #endif
        
        FragInputs BuildFragInputs(VaryingsMeshToPS input)
        {
            FragInputs output;
            ZERO_INITIALIZE(FragInputs, output);
        
            // Init to some default value to make the computer quiet (else it output 'divide by zero' warning even if value is not used).
            // TODO: this is a really poor workaround, but the variable is used in a bunch of places
            // to compute normals which are then passed on elsewhere to compute other values...
            output.tangentToWorld = k_identity3x3;
            output.positionSS = input.positionCS;       // input.positionCS is SV_Position
        
            output.texCoord0 =                  input.texCoord0;
        
        
        #ifdef HAVE_VFX_MODIFICATION
            // FragInputs from VFX come from two places: Interpolator or CBuffer.
        #if VFX_USE_GRAPH_VALUES
            uint instanceActiveIndex = asuint(UNITY_ACCESS_INSTANCED_PROP(PerInstance, _InstanceActiveIndex));
            /* WARNING: $splice Could not find named fragment 'VFXLoadGraphValues' */
        #endif
        
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            // splice point to copy custom interpolator fields from varyings to frag inputs
            
        
            return output;
        }
        
        // existing HDRP code uses the combined function to go directly from packed to frag inputs
        FragInputs UnpackVaryingsMeshToFragInputs(PackedVaryingsMeshToPS input)
        {
            UNITY_SETUP_INSTANCE_ID(input);
        #if defined(HAVE_VFX_MODIFICATION) && defined(UNITY_INSTANCING_ENABLED)
            unity_InstanceID = input.instanceID;
        #endif
            VaryingsMeshToPS unpacked = UnpackVaryingsMeshToPS(input);
            return BuildFragInputs(unpacked);
        }
            SurfaceDescriptionInputs FragInputsToSurfaceDescriptionInputs(FragInputs input, float3 viewWS)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
            #if defined(SHADER_STAGE_RAY_TRACING)
            #else
            #endif
            output.TangentSpaceNormal =                         float3(0.0f, 0.0f, 1.0f);
        
        #if UNITY_UV_STARTS_AT_TOP
        #else
        #endif
        
        
            output.uv0 =                                        input.texCoord0;
        
            // splice point to copy frag inputs custom interpolator pack into the SDI
            
        
            return output;
        }
        
            // --------------------------------------------------
            // Build Surface Data (Specific Material)
        
        void ApplyDecalToSurfaceDataNoNormal(DecalSurfaceData decalSurfaceData, inout SurfaceData surfaceData);
        
        void ApplyDecalAndGetNormal(FragInputs fragInputs, PositionInputs posInput, SurfaceDescription surfaceDescription,
            inout SurfaceData surfaceData)
        {
            float3 doubleSidedConstants = GetDoubleSidedConstants();
        
        #ifdef DECAL_NORMAL_BLENDING
            // SG nodes don't ouptut surface gradients, so if decals require surf grad blending, we have to convert
            // the normal to gradient before applying the decal. We then have to resolve the gradient back to world space
            float3 normalTS;
        
            normalTS = SurfaceGradientFromTangentSpaceNormalAndFromTBN(surfaceDescription.NormalTS,
            fragInputs.tangentToWorld[0], fragInputs.tangentToWorld[1]);
        
        
            #if HAVE_DECALS
            if (_EnableDecals)
            {
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                ApplyDecalToSurfaceNormal(decalSurfaceData, fragInputs.tangentToWorld[2], normalTS);
                ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
            }
            #endif
        
            GetNormalWS_SG(fragInputs, normalTS, surfaceData.normalWS, doubleSidedConstants);
        #else
            // normal delivered to master node
            GetNormalWS(fragInputs, surfaceDescription.NormalTS, surfaceData.normalWS, doubleSidedConstants);
        
            #if HAVE_DECALS
            if (_EnableDecals)
            {
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                // Both uses and modifies 'surfaceData.normalWS'.
                DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                ApplyDecalToSurfaceNormal(decalSurfaceData, surfaceData.normalWS.xyz);
                ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
            }
            #endif
        #endif
        }
        void BuildSurfaceData(FragInputs fragInputs, inout SurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
        {
            ZERO_INITIALIZE(SurfaceData, surfaceData);
        
            // specularOcclusion need to be init ahead of decal to quiet the compiler that modify the SurfaceData struct
            // however specularOcclusion can come from the graph, so need to be init here so it can be override.
            surfaceData.specularOcclusion = 1.0;
            surfaceData.thickness = 0.0;
        
            surfaceData.baseColor =                 surfaceDescription.BaseColor;
            surfaceData.perceptualSmoothness =      surfaceDescription.Smoothness;
            surfaceData.ambientOcclusion =          surfaceDescription.Occlusion;
            surfaceData.transmissionMask =          surfaceDescription.TransmissionMask.xxx;
            surfaceData.thickness =                 surfaceDescription.Thickness;
            surfaceData.diffusionProfileHash =      asuint(surfaceDescription.DiffusionProfileHash);
        
            #if defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE) || defined(_REFRACTION_THIN)
                if (_EnableSSRefraction)
                {
        
                    surfaceData.transmittanceMask = (1.0 - surfaceDescription.Alpha);
                    surfaceDescription.Alpha = 1.0;
                }
                else
                {
                    surfaceData.ior = 1.0;
                    surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                    surfaceData.atDistance = 1.0;
                    surfaceData.transmittanceMask = 0.0;
                    surfaceDescription.Alpha = 1.0;
                }
            #else
                surfaceData.ior = 1.0;
                surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                surfaceData.atDistance = 1.0;
                surfaceData.transmittanceMask = 0.0;
            #endif
        
            // These static material feature allow compile time optimization
            surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;
            #ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
            #endif
        
            #ifdef _MATERIAL_FEATURE_TRANSMISSION
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
            #endif
        
            #ifdef _MATERIAL_FEATURE_COLORED_TRANSMISSION
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_COLORED_TRANSMISSION;
        
            #endif
        
            #ifdef _MATERIAL_FEATURE_ANISOTROPY
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
        
                // Initialize the normal to something non-zero to avoid a div-zero warning for anisotropy.
                surfaceData.normalWS = float3(0, 1, 0);
            #endif
        
            #ifdef _MATERIAL_FEATURE_IRIDESCENCE
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
            #endif
        
            #ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
            #endif
        
            #ifdef _MATERIAL_FEATURE_CLEAR_COAT
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
            #endif
        
            #if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
                // Require to have setup baseColor
                // Reproduce the energy conservation done in legacy Unity. Not ideal but better for compatibility and users can unchek it
                surfaceData.baseColor *= (1.0 - Max3(surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b));
            #endif
        
            float3 doubleSidedConstants = GetDoubleSidedConstants();
        
            ApplyDecalAndGetNormal(fragInputs, posInput, surfaceDescription, surfaceData);
        
            surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];
        
            surfaceData.tangentWS = normalize(fragInputs.tangentToWorld[0].xyz);    // The tangent is not normalize in tangentToWorld for mikkt. TODO: Check if it expected that we normalize with Morten. Tag: SURFACE_GRADIENT
        
        
            bentNormalWS = surfaceData.normalWS;
        
            surfaceData.tangentWS = Orthonormalize(surfaceData.tangentWS, surfaceData.normalWS);
        
            #ifdef DEBUG_DISPLAY
                if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
                {
                    // TODO: need to update mip info
                    surfaceData.metallic = 0;
                }
        
                // We need to call ApplyDebugToSurfaceData after filling the surfarcedata and before filling builtinData
                // as it can modify attribute use for static lighting
                ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData);
            #endif
        
            // By default we use the ambient occlusion with Tri-ace trick (apply outside) for specular occlusion.
            // If user provide bent normal then we process a better term
            #if defined(_SPECULAR_OCCLUSION_CUSTOM)
                // Just use the value passed through via the slot (not active otherwise)
            #elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
                // If we have bent normal and ambient occlusion, process a specular occlusion
                surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO(V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness(surfaceData.perceptualSmoothness));
            #elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
                surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion(ClampNdotV(dot(surfaceData.normalWS, V)), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness(surfaceData.perceptualSmoothness));
            #endif
        
            #if defined(_ENABLE_GEOMETRIC_SPECULAR_AA) && !defined(SHADER_STAGE_RAY_TRACING)
                surfaceData.perceptualSmoothness = GeometricNormalFiltering(surfaceData.perceptualSmoothness, fragInputs.tangentToWorld[2], surfaceDescription.SpecularAAScreenSpaceVariance, surfaceDescription.SpecularAAThreshold);
            #endif
        }
        
            // --------------------------------------------------
            // Get Surface And BuiltinData
        
            void GetSurfaceAndBuiltinData(FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData RAY_TRACING_OPTIONAL_PARAMETERS)
            {
                // Don't dither if displaced tessellation (we're fading out the displacement instead to match the next LOD)
                #if !defined(SHADER_STAGE_RAY_TRACING) && !defined(_TESSELLATION_DISPLACEMENT)
                #ifdef LOD_FADE_CROSSFADE // enable dithering LOD transition if user select CrossFade transition in LOD group
                LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
                #endif
                #endif
        
                #ifndef SHADER_UNLIT
                #ifdef _DOUBLESIDED_ON
                    float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
                #else
                    float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
                #endif
        
                ApplyDoubleSidedFlipOrMirror(fragInputs, doubleSidedConstants); // Apply double sided flip on the vertex normal
                #endif // SHADER_UNLIT
        
                SurfaceDescriptionInputs surfaceDescriptionInputs = FragInputsToSurfaceDescriptionInputs(fragInputs, V);
        
                #if defined(HAVE_VFX_MODIFICATION)
                GraphProperties properties;
                ZERO_INITIALIZE(GraphProperties, properties);
        
                GetElementPixelProperties(fragInputs, properties);
        
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs, properties);
                #else
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs);
                #endif
        
                // Perform alpha test very early to save performance (a killed pixel will not sample textures)
                // TODO: split graph evaluation to grab just alpha dependencies first? tricky..
                #ifdef _ALPHATEST_ON
                    float alphaCutoff = surfaceDescription.AlphaClipThreshold;
                    #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
                    // The TransparentDepthPrepass is also used with SSR transparent.
                    // If an artists enable transaprent SSR but not the TransparentDepthPrepass itself, then we use AlphaClipThreshold
                    // otherwise if TransparentDepthPrepass is enabled we use AlphaClipThresholdDepthPrepass
                    #elif SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_POSTPASS
                    // DepthPostpass always use its own alpha threshold
                    alphaCutoff = surfaceDescription.AlphaClipThresholdDepthPostpass;
                    #elif (SHADERPASS == SHADERPASS_SHADOWS) || (SHADERPASS == SHADERPASS_RAYTRACING_VISIBILITY)
                    // If use shadow threshold isn't enable we don't allow any test
                    #endif
        
                    GENERIC_ALPHA_TEST(surfaceDescription.Alpha, alphaCutoff);
                #endif
        
                #if !defined(SHADER_STAGE_RAY_TRACING) && _DEPTHOFFSET_ON
                ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
                #endif
        
                #ifndef SHADER_UNLIT
                float3 bentNormalWS;
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS);
        
                #ifdef FRAG_INPUTS_USE_TEXCOORD1
                    float4 lightmapTexCoord1 = fragInputs.texCoord1;
                #else
                    float4 lightmapTexCoord1 = float4(0,0,0,0);
                #endif
        
                #ifdef FRAG_INPUTS_USE_TEXCOORD2
                    float4 lightmapTexCoord2 = fragInputs.texCoord2;
                #else
                    float4 lightmapTexCoord2 = float4(0,0,0,0);
                #endif
        
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                // Builtin Data
                // For back lighting we use the oposite vertex normal
                InitBuiltinData(posInput, alpha, bentNormalWS, -fragInputs.tangentToWorld[2], lightmapTexCoord1, lightmapTexCoord2, builtinData);
        
                #else
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData);
        
                ZERO_BUILTIN_INITIALIZE(builtinData); // No call to InitBuiltinData as we don't have any lighting
                builtinData.opacity = surfaceDescription.Alpha;
        
                #if defined(DEBUG_DISPLAY)
                    // Light Layers are currently not used for the Unlit shader (because it is not lit)
                    // But Unlit objects do cast shadows according to their rendering layer mask, which is what we want to
                    // display in the light layers visualization mode, therefore we need the renderingLayers
                    builtinData.renderingLayers = GetMeshRenderingLayerMask();
                #endif
        
                #endif // SHADER_UNLIT
        
                #ifdef _ALPHATEST_ON
                    // Used for sharpening by alpha to mask - Alpha to covertage is only used with depth only and forward pass (no shadow pass, no transparent pass)
                    builtinData.alphaClipTreshold = alphaCutoff;
                #endif
        
                // override sampleBakedGI - not used by Unlit
        		// When overriding GI, we need to force the isLightmap flag to make sure we don't add APV (sampled in the lightloop) on top of the overridden value (set at GBuffer stage)
        
                builtinData.emissiveColor = surfaceDescription.Emission;
        
                // Note this will not fully work on transparent surfaces (can check with _SURFACE_TYPE_TRANSPARENT define)
                // We will always overwrite vt feeback with the nearest. So behind transparent surfaces vt will not be resolved
                // This is a limitation of the current MRT approach.
                #ifdef UNITY_VIRTUAL_TEXTURING
                #endif
        
                #if _DEPTHOFFSET_ON
                builtinData.depthOffset = surfaceDescription.DepthOffset;
                #endif
        
                // TODO: We should generate distortion / distortionBlur for non distortion pass
                #if (SHADERPASS == SHADERPASS_DISTORTION)
                builtinData.distortion = surfaceDescription.Distortion;
                builtinData.distortionBlur = surfaceDescription.DistortionBlur;
                #endif
        
                #ifndef SHADER_UNLIT
                // PostInitBuiltinData call ApplyDebugToBuiltinData
                PostInitBuiltinData(V, posInput, surfaceData, builtinData);
                #else
                ApplyDebugToBuiltinData(builtinData);
                #endif
        
                RAY_TRACING_OPTIONAL_ALPHA_TEST_PASS
            }
        
            // --------------------------------------------------
            // Main
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPassFullScreenDebug.hlsl"
        
            // --------------------------------------------------
            // Visual Effect Vertex Invocations
        
        	#ifdef HAVE_VFX_MODIFICATION
                #if !defined(SHADER_STAGE_RAY_TRACING)
        	    #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/VisualEffectVertex.hlsl"
                #else
                #endif
        	#endif
        
            #include "Assets/VegetationInstancer/Shaders/Include/GPUInstancedIndirectInclude.cginc"
#pragma instancing_options procedural:setupGPUInstancedIndirect
#pragma multi_compile_instancing
ENDHLSL
        }
        Pass
        {
            Name "DepthOnly"
            Tags
            {
                "LightMode" = "DepthOnly"
            }
        
            // Render State
            Cull [_CullMode]
        ZWrite On
        Stencil
        {
        WriteMask [_StencilWriteMaskDepth]
        Ref [_StencilRefDepth]
        CompFront Always
        PassFront Replace
        CompBack Always
        PassBack Replace
        }
        AlphaToMask [_AlphaCutoffEnable]
        
            // Debug
            // <None>
        
            // --------------------------------------------------
            // Pass
        
            HLSLPROGRAM
        
            // Pragmas
            #pragma multi_compile _ DOTS_INSTANCING_ON
        
        #pragma target 4.5
        #pragma vertex Vert
        #pragma fragment Frag
        #pragma only_renderers d3d11 playstation xboxone xboxseries vulkan metal switch
        
        
            // Keywords
            #pragma multi_compile _ WRITE_NORMAL_BUFFER
        #pragma shader_feature_local _ _ALPHATEST_ON
        #pragma multi_compile_fragment _ WRITE_MSAA_DEPTH
        #pragma shader_feature _ _SURFACE_TYPE_TRANSPARENT
        #pragma shader_feature_local _ _DOUBLESIDED_ON
        #pragma shader_feature_local _ _ADD_PRECOMPUTED_VELOCITY
        #pragma shader_feature_local _ _TRANSPARENT_WRITES_MOTION_VEC _TRANSPARENT_REFRACTIVE_SORT
        #pragma shader_feature_local_fragment _ _ENABLE_FOG_ON_TRANSPARENT
        #pragma shader_feature_local_fragment _ _DISABLE_DECALS
        #pragma shader_feature_local_raytracing _ _DISABLE_DECALS
        #pragma shader_feature_local_fragment _ _DISABLE_SSR
        #pragma shader_feature_local_raytracing _ _DISABLE_SSR
        #pragma shader_feature_local_fragment _ _DISABLE_SSR_TRANSPARENT
        #pragma shader_feature_local_raytracing _ _DISABLE_SSR_TRANSPARENT
        #pragma multi_compile_fragment _ WRITE_DECAL_BUFFER WRITE_RENDERING_LAYER
        #pragma shader_feature_local _ _REFRACTION_PLANE _REFRACTION_SPHERE _REFRACTION_THIN
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_TRANSMISSION
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_TRANSMISSION
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_ANISOTROPY
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_ANISOTROPY
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_IRIDESCENCE
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_IRIDESCENCE
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_SPECULAR_COLOR
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_SPECULAR_COLOR
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_COLORED_TRANSMISSION
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_COLORED_TRANSMISSION
            // GraphKeywords: <None>
        
            // Defines
            #define SHADERPASS SHADERPASS_DEPTH_ONLY
        #define RAYTRACING_SHADER_GRAPH_DEFAULT
        
            // For custom interpolators to inject a substruct definition before FragInputs definition,
            // allowing for FragInputs to capture CI's intended for ShaderGraph's SDI.
            struct CustomInterpolators
        {
        };
        #define USE_CUSTOMINTERP_SUBSTRUCT
        
        
        
            // TODO: Merge FragInputsVFX substruct with CustomInterpolators.
        	#ifdef HAVE_VFX_MODIFICATION
        	struct FragInputsVFX
            {
                /* WARNING: $splice Could not find named fragment 'FragInputsVFX' */
            };
            #endif
        
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl" // Required by Tessellation.hlsl
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Tessellation.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl" // Required to be include before we include properties as it define DECLARE_STACK_CB
            // Always include Shader Graph version
            // Always include last to avoid double macros
            #include "Packages/com.unity.shadergraph/ShaderGraphLibrary/Functions.hlsl" // Need to be here for Gradient struct definition
        
            // --------------------------------------------------
            // Defines
        
            // Attribute
            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define ATTRIBUTES_NEED_TEXCOORD0
            #define VARYINGS_NEED_TANGENT_TO_WORLD
            #define VARYINGS_NEED_TEXCOORD0
        
            #define HAVE_MESH_MODIFICATION
        
            //Strip down the FragInputs.hlsl (on graphics), so we can only optimize the interpolators we use.
            //if by accident something requests contents of FragInputs.hlsl, it will be caught as a compiler error
            //Frag inputs stripping is only enabled when FRAG_INPUTS_ENABLE_STRIPPING is set
            #if !defined(SHADER_STAGE_RAY_TRACING) && SHADERPASS != SHADERPASS_RAYTRACING_GBUFFER && SHADERPASS != SHADERPASS_FULL_SCREEN_DEBUG
            #define FRAG_INPUTS_ENABLE_STRIPPING
            #endif
            #define FRAG_INPUTS_USE_TEXCOORD0
        
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
        
        
        
        
            // Following two define are a workaround introduce in 10.1.x for RaytracingQualityNode
            // The ShaderGraph don't support correctly migration of this node as it serialize all the node data
            // in the json file making it impossible to uprgrade. Until we get a fix, we do a workaround here
            // to still allow us to rename the field and keyword of this node without breaking existing code.
            #ifdef RAYTRACING_SHADER_GRAPH_DEFAULT
            #define RAYTRACING_SHADER_GRAPH_HIGH
            #endif
        
            #ifdef RAYTRACING_SHADER_GRAPH_RAYTRACED
            #define RAYTRACING_SHADER_GRAPH_LOW
            #endif
            // end
        
            #ifndef SHADER_UNLIT
            // We need isFrontFace when using double sided - it is not required for unlit as in case of unlit double sided only drive the cullmode
            // VARYINGS_NEED_CULLFACE can be define by VaryingsMeshToPS.FaceSign input if a IsFrontFace Node is included in the shader graph.
            #if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
                #define VARYINGS_NEED_CULLFACE
            #endif
            #endif
        
            // Specific Material Define
        #define _SPECULAR_OCCLUSION_FROM_AO 1
        #define _ENERGY_CONSERVING_SPECULAR 1
        
        #if _MATERIAL_FEATURE_COLORED_TRANSMISSION
            // Colored Transmission doesn't support clear coat
            #undef _MATERIAL_FEATURE_CLEAR_COAT
        #endif
        
        // If we use subsurface scattering, enable output split lighting (for forward pass)
        #if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
            #define OUTPUT_SPLIT_LIGHTING
        #endif
        
        // This shader support recursive rendering for raytracing
        #define HAVE_RECURSIVE_RENDERING
        
        // In Path Tracing, For all single-sided, refractive materials, we want to force a thin refraction model
        #if (SHADERPASS == SHADERPASS_PATH_TRACING) && !defined(_DOUBLESIDED_ON) && (defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE))
            #undef  _REFRACTION_PLANE
            #undef  _REFRACTION_SPHERE
            #define _REFRACTION_THIN
        #endif
            // Caution: we can use the define SHADER_UNLIT onlit after the above Material include as it is the Unlit template who define it
        
            // To handle SSR on transparent correctly with a possibility to enable/disable it per framesettings
            // we should have a code like this:
            // if !defined(_DISABLE_SSR_TRANSPARENT)
            // pragma multi_compile _ WRITE_NORMAL_BUFFER
            // endif
            // i.e we enable the multicompile only if we can receive SSR or not, and then C# code drive
            // it based on if SSR transparent in frame settings and not (and stripper can strip it).
            // this is currently not possible with our current preprocessor as _DISABLE_SSR_TRANSPARENT is a keyword not a define
            // so instead we used this and chose to pay the extra cost of normal write even if SSR transaprent is disabled.
            // Ideally the shader graph generator should handle it but condition below can't be handle correctly for now.
            #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
            #if !defined(_DISABLE_SSR_TRANSPARENT) && !defined(SHADER_UNLIT)
                #define WRITE_NORMAL_BUFFER
            #endif
            #endif
        
            // See Lit.shader
            #if SHADERPASS == SHADERPASS_MOTION_VECTORS && defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)
                #define WRITE_DECAL_BUFFER
            #endif
        
            #ifndef DEBUG_DISPLAY
                // In case of opaque we don't want to perform the alpha test, it is done in depth prepass and we use depth equal for ztest (setup from UI)
                // Don't do it with debug display mode as it is possible there is no depth prepass in this case
                #if !defined(_SURFACE_TYPE_TRANSPARENT)
                    #if SHADERPASS == SHADERPASS_FORWARD
                    #define SHADERPASS_FORWARD_BYPASS_ALPHA_TEST
                    #elif SHADERPASS == SHADERPASS_GBUFFER
                    #define SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST
                    #endif
                #endif
            #endif
        
            // Define _DEFERRED_CAPABLE_MATERIAL for shader capable to run in deferred pass
            #if defined(SHADER_LIT) && !defined(_SURFACE_TYPE_TRANSPARENT)
                #define _DEFERRED_CAPABLE_MATERIAL
            #endif
        
            // Translate transparent motion vector define
            #if (defined(_TRANSPARENT_WRITES_MOTION_VEC) || defined(_TRANSPARENT_REFRACTIVE_SORT)) && defined(_SURFACE_TYPE_TRANSPARENT)
                #define _WRITE_TRANSPARENT_MOTION_VECTOR
            #endif
        
            // -- Graph Properties
            CBUFFER_START(UnityPerMaterial)
        float4 _DiffusionProfileAsset;
        float _DiffusionProfileHash;
        float4 _Texture2D_TexelSize;
        float4 _Albedo;
        float _Smoothness;
        float _WindSpeed;
        float _WindStrength;
        float4 _Normal_TexelSize;
        float _NormalStrength;
        float4 _EmissionColor;
        float _UseShadowThreshold;
        float4 _DoubleSidedConstants;
        float _BlendMode;
        float _EnableBlendModePreserveSpecularLighting;
        float _RayTracing;
        float _RefractionModel;
        float _MaterialID;
        float _MaterialTypeMask;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_Texture2D);
        SAMPLER(sampler_Texture2D);
        TEXTURE2D(_Normal);
        SAMPLER(sampler_Normal);
        
            // -- Property used by ScenePickingPass
            #ifdef SCENEPICKINGPASS
            float4 _SelectionID;
            #endif
        
            // -- Properties used by SceneSelectionPass
            #ifdef SCENESELECTIONPASS
            int _ObjectId;
            int _PassValue;
            #endif
        
            // Includes
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitDecalData.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"
        	// GraphIncludes: <None>
        
            // --------------------------------------------------
            // Structs and Packing
        
            struct AttributesMesh
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct VaryingsMeshToPS
        {
            SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
             float3 normalWS;
             float4 tangentWS;
             float4 texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
             float3 WorldSpacePosition;
             float4 uv0;
             float3 TimeParameters;
        };
        struct SurfaceDescriptionInputs
        {
             float3 TangentSpaceNormal;
             float4 uv0;
        };
        struct PackedVaryingsMeshToPS
        {
            SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
             float4 tangentWS : INTERP0;
             float4 texCoord0 : INTERP1;
             float3 normalWS : INTERP2;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
        };
        
            PackedVaryingsMeshToPS PackVaryingsMeshToPS (VaryingsMeshToPS input)
        {
            PackedVaryingsMeshToPS output;
            ZERO_INITIALIZE(PackedVaryingsMeshToPS, output);
            output.positionCS = input.positionCS;
            output.tangentWS.xyzw = input.tangentWS;
            output.texCoord0.xyzw = input.texCoord0;
            output.normalWS.xyz = input.normalWS;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            return output;
        }
        
        VaryingsMeshToPS UnpackVaryingsMeshToPS (PackedVaryingsMeshToPS input)
        {
            VaryingsMeshToPS output;
            output.positionCS = input.positionCS;
            output.tangentWS = input.tangentWS.xyzw;
            output.texCoord0 = input.texCoord0.xyzw;
            output.normalWS = input.normalWS.xyz;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            return output;
        }
        
        
            // --------------------------------------------------
            // Graph
        
        
            // Graph Functions
            
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_Sine_float(float In, out float Out)
        {
            Out = sin(In);
        }
        
        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }
        
        void Unity_Multiply_float4_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }
        
            // Graph Vertex
            struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            float _Property_8c596e62dce249caa7922ff3d7470d43_Out_0_Float = _WindSpeed;
            float _Split_35af25740d5a404097ccb209d36d5cac_R_1_Float = IN.WorldSpacePosition[0];
            float _Split_35af25740d5a404097ccb209d36d5cac_G_2_Float = IN.WorldSpacePosition[1];
            float _Split_35af25740d5a404097ccb209d36d5cac_B_3_Float = IN.WorldSpacePosition[2];
            float _Split_35af25740d5a404097ccb209d36d5cac_A_4_Float = 0;
            float _Add_c678bc9d08684d01a8e45ad5e636b4b4_Out_2_Float;
            Unity_Add_float(_Split_35af25740d5a404097ccb209d36d5cac_R_1_Float, _Split_35af25740d5a404097ccb209d36d5cac_B_3_Float, _Add_c678bc9d08684d01a8e45ad5e636b4b4_Out_2_Float);
            float _Add_0ec2f296c670483e9dc4250c81fe62a0_Out_2_Float;
            Unity_Add_float(IN.TimeParameters.x, _Add_c678bc9d08684d01a8e45ad5e636b4b4_Out_2_Float, _Add_0ec2f296c670483e9dc4250c81fe62a0_Out_2_Float);
            float _Multiply_ce5f4784040b450499733beaca915393_Out_2_Float;
            Unity_Multiply_float_float(_Property_8c596e62dce249caa7922ff3d7470d43_Out_0_Float, _Add_0ec2f296c670483e9dc4250c81fe62a0_Out_2_Float, _Multiply_ce5f4784040b450499733beaca915393_Out_2_Float);
            float _Sine_3c81889fed534b52996b5063cdc22296_Out_1_Float;
            Unity_Sine_float(_Multiply_ce5f4784040b450499733beaca915393_Out_2_Float, _Sine_3c81889fed534b52996b5063cdc22296_Out_1_Float);
            float _Property_3cdd281375794ed2bcad3550a9c890af_Out_0_Float = _WindStrength;
            float _Multiply_89ad4329fdd44befb161e56947c2670b_Out_2_Float;
            Unity_Multiply_float_float(_Sine_3c81889fed534b52996b5063cdc22296_Out_1_Float, _Property_3cdd281375794ed2bcad3550a9c890af_Out_0_Float, _Multiply_89ad4329fdd44befb161e56947c2670b_Out_2_Float);
            float4 _UV_30b55575e9844728bc3abbcaf84a22ff_Out_0_Vector4 = IN.uv0;
            float _Split_020d1040f8544c0b9d3de77e7fbd9197_R_1_Float = _UV_30b55575e9844728bc3abbcaf84a22ff_Out_0_Vector4[0];
            float _Split_020d1040f8544c0b9d3de77e7fbd9197_G_2_Float = _UV_30b55575e9844728bc3abbcaf84a22ff_Out_0_Vector4[1];
            float _Split_020d1040f8544c0b9d3de77e7fbd9197_B_3_Float = _UV_30b55575e9844728bc3abbcaf84a22ff_Out_0_Vector4[2];
            float _Split_020d1040f8544c0b9d3de77e7fbd9197_A_4_Float = _UV_30b55575e9844728bc3abbcaf84a22ff_Out_0_Vector4[3];
            float _Multiply_17088dc811eb45e4a333912f99b556ec_Out_2_Float;
            Unity_Multiply_float_float(_Multiply_89ad4329fdd44befb161e56947c2670b_Out_2_Float, _Split_020d1040f8544c0b9d3de77e7fbd9197_G_2_Float, _Multiply_17088dc811eb45e4a333912f99b556ec_Out_2_Float);
            float3 _Add_e473a1f67cd1441b9fccfb91c0b5ff75_Out_2_Vector3;
            Unity_Add_float3(IN.WorldSpacePosition, (_Multiply_17088dc811eb45e4a333912f99b556ec_Out_2_Float.xxx), _Add_e473a1f67cd1441b9fccfb91c0b5ff75_Out_2_Vector3);
            float3 _Add_8e06eedaa53749dea4ffc85b774f63ee_Out_2_Vector3;
            Unity_Add_float3(float3(0, 0, 0), _Add_e473a1f67cd1441b9fccfb91c0b5ff75_Out_2_Vector3, _Add_8e06eedaa53749dea4ffc85b774f63ee_Out_2_Vector3);
            float3 _Transform_78fa02a50d4c495cba1111966696417e_Out_1_Vector3;
            _Transform_78fa02a50d4c495cba1111966696417e_Out_1_Vector3 = TransformWorldToObject(_Add_8e06eedaa53749dea4ffc85b774f63ee_Out_2_Vector3.xyz);
            description.Position = _Transform_78fa02a50d4c495cba1111966696417e_Out_1_Vector3;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
            // Graph Pixel
            struct SurfaceDescription
        {
            float3 BaseColor;
            float3 Emission;
            float Alpha;
            float AlphaClipThreshold;
            float3 BentNormal;
            float Smoothness;
            float Occlusion;
            float3 NormalTS;
            float TransmissionMask;
            float Thickness;
            float DiffusionProfileHash;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float4 _Property_35c125abbbcb46e1a2351d8febeb5da1_Out_0_Vector4 = _Albedo;
            UnityTexture2D _Property_bb313b600ca3404fb88a2820878a8482_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Texture2D);
            float4 _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_bb313b600ca3404fb88a2820878a8482_Out_0_Texture2D.tex, _Property_bb313b600ca3404fb88a2820878a8482_Out_0_Texture2D.samplerstate, _Property_bb313b600ca3404fb88a2820878a8482_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_R_4_Float = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4.r;
            float _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_G_5_Float = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4.g;
            float _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_B_6_Float = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4.b;
            float _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_A_7_Float = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4.a;
            float4 _Multiply_c09cca22f04c4a9a996a5ccf8f61afe1_Out_2_Vector4;
            Unity_Multiply_float4_float4(_Property_35c125abbbcb46e1a2351d8febeb5da1_Out_0_Vector4, _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4, _Multiply_c09cca22f04c4a9a996a5ccf8f61afe1_Out_2_Vector4);
            float _Property_925f8cb589d94edda2dcd6b588187f26_Out_0_Float = _Smoothness;
            float _Multiply_a061075fe3794cc5abff5f173997f7f8_Out_2_Float;
            Unity_Multiply_float_float(_Property_925f8cb589d94edda2dcd6b588187f26_Out_0_Float, _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_G_5_Float, _Multiply_a061075fe3794cc5abff5f173997f7f8_Out_2_Float);
            UnityTexture2D _Property_ff2eff189fa74f1f965ec8aca53205ba_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Normal);
            float4 _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_ff2eff189fa74f1f965ec8aca53205ba_Out_0_Texture2D.tex, _Property_ff2eff189fa74f1f965ec8aca53205ba_Out_0_Texture2D.samplerstate, _Property_ff2eff189fa74f1f965ec8aca53205ba_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.rgb = UnpackNormal(_SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4);
            float _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_R_4_Float = _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.r;
            float _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_G_5_Float = _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.g;
            float _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_B_6_Float = _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.b;
            float _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_A_7_Float = _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.a;
            float _Property_915c3b0b5fc04c668c646f2f67b5ab2b_Out_0_Float = _NormalStrength;
            float4 _Multiply_e38eea28614c4b61bfd135ec8591a746_Out_2_Vector4;
            Unity_Multiply_float4_float4(_SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4, (_Property_915c3b0b5fc04c668c646f2f67b5ab2b_Out_0_Float.xxxx), _Multiply_e38eea28614c4b61bfd135ec8591a746_Out_2_Vector4);
            surface.BaseColor = (_Multiply_c09cca22f04c4a9a996a5ccf8f61afe1_Out_2_Vector4.xyz);
            surface.Emission = float3(0, 0, 0);
            surface.Alpha = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_A_7_Float;
            surface.AlphaClipThreshold = 0.5;
            surface.BentNormal = IN.TangentSpaceNormal;
            surface.Smoothness = _Multiply_a061075fe3794cc5abff5f173997f7f8_Out_2_Float;
            surface.Occlusion = 1;
            surface.NormalTS = (_Multiply_e38eea28614c4b61bfd135ec8591a746_Out_2_Vector4.xyz);
            surface.TransmissionMask = 1;
            surface.Thickness = 1;
            surface.DiffusionProfileHash = _DiffusionProfileHash;
            return surface;
        }
        
            // --------------------------------------------------
            // Build Graph Inputs
            #ifdef HAVE_VFX_MODIFICATION
            #define VFX_SRP_ATTRIBUTES AttributesMesh
            #define VaryingsMeshType VaryingsMeshToPS
            #define VFX_SRP_VARYINGS VaryingsMeshType
            #define VFX_SRP_SURFACE_INPUTS FragInputs
            #endif
            
        VertexDescriptionInputs AttributesMeshToVertexDescriptionInputs(AttributesMesh input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
            output.WorldSpacePosition =                         TransformObjectToWorld(input.positionOS);
            output.uv0 =                                        input.uv0;
            output.TimeParameters =                             _TimeParameters.xyz; // Note: in case of animation this will be overwrite (allow to handle motion vector)
        
            return output;
        }
        
        VertexDescription GetVertexDescription(AttributesMesh input, float3 timeParameters
        #ifdef HAVE_VFX_MODIFICATION
            , AttributesElement element
        #endif
        )
        {
            // build graph inputs
            VertexDescriptionInputs vertexDescriptionInputs = AttributesMeshToVertexDescriptionInputs(input);
            // Override time parameters with used one (This is required to correctly handle motion vectors for vertex animation based on time)
            vertexDescriptionInputs.TimeParameters = timeParameters;
        
            // evaluate vertex graph
        #ifdef HAVE_VFX_MODIFICATION
            GraphProperties properties;
            ZERO_INITIALIZE(GraphProperties, properties);
        
            // Fetch the vertex graph properties for the particle instance.
            GetElementVertexProperties(element, properties);
        
            VertexDescription vertexDescription = VertexDescriptionFunction(vertexDescriptionInputs, properties);
        #else
            VertexDescription vertexDescription = VertexDescriptionFunction(vertexDescriptionInputs);
        #endif
            return vertexDescription;
        
        }
        
        AttributesMesh ApplyMeshModification(AttributesMesh input, float3 timeParameters
        #ifdef USE_CUSTOMINTERP_SUBSTRUCT
            #ifdef TESSELLATION_ON
            , inout VaryingsMeshToDS varyings
            #else
            , inout VaryingsMeshToPS varyings
            #endif
        #endif
        #ifdef HAVE_VFX_MODIFICATION
                , AttributesElement element
        #endif
            )
        {
            VertexDescription vertexDescription = GetVertexDescription(input, timeParameters
        #ifdef HAVE_VFX_MODIFICATION
                , element
        #endif
            );
        
            // copy graph output to the results
            input.positionOS = vertexDescription.Position;
            input.normalOS = vertexDescription.Normal;
            input.tangentOS.xyz = vertexDescription.Tangent;
        
            
        
            return input;
        }
        
        #if defined(_ADD_CUSTOM_VELOCITY) // For shader graph custom velocity
        // Return precomputed Velocity in object space
        float3 GetCustomVelocity(AttributesMesh input
        #ifdef HAVE_VFX_MODIFICATION
            , AttributesElement element
        #endif
        )
        {
            VertexDescription vertexDescription = GetVertexDescription(input, _TimeParameters.xyz
        #ifdef HAVE_VFX_MODIFICATION
                , element
        #endif
            );
            return vertexDescription.CustomVelocity;
        }
        #endif
        
        FragInputs BuildFragInputs(VaryingsMeshToPS input)
        {
            FragInputs output;
            ZERO_INITIALIZE(FragInputs, output);
        
            // Init to some default value to make the computer quiet (else it output 'divide by zero' warning even if value is not used).
            // TODO: this is a really poor workaround, but the variable is used in a bunch of places
            // to compute normals which are then passed on elsewhere to compute other values...
            output.tangentToWorld = k_identity3x3;
            output.positionSS = input.positionCS;       // input.positionCS is SV_Position
        
            output.tangentToWorld =             BuildTangentToWorld(input.tangentWS, input.normalWS);
            output.texCoord0 =                  input.texCoord0;
        
        
        #ifdef HAVE_VFX_MODIFICATION
            // FragInputs from VFX come from two places: Interpolator or CBuffer.
        #if VFX_USE_GRAPH_VALUES
            uint instanceActiveIndex = asuint(UNITY_ACCESS_INSTANCED_PROP(PerInstance, _InstanceActiveIndex));
            /* WARNING: $splice Could not find named fragment 'VFXLoadGraphValues' */
        #endif
        
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            // splice point to copy custom interpolator fields from varyings to frag inputs
            
        
            return output;
        }
        
        // existing HDRP code uses the combined function to go directly from packed to frag inputs
        FragInputs UnpackVaryingsMeshToFragInputs(PackedVaryingsMeshToPS input)
        {
            UNITY_SETUP_INSTANCE_ID(input);
        #if defined(HAVE_VFX_MODIFICATION) && defined(UNITY_INSTANCING_ENABLED)
            unity_InstanceID = input.instanceID;
        #endif
            VaryingsMeshToPS unpacked = UnpackVaryingsMeshToPS(input);
            return BuildFragInputs(unpacked);
        }
            SurfaceDescriptionInputs FragInputsToSurfaceDescriptionInputs(FragInputs input, float3 viewWS)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
            #if defined(SHADER_STAGE_RAY_TRACING)
            #else
            #endif
            output.TangentSpaceNormal =                         float3(0.0f, 0.0f, 1.0f);
        
        #if UNITY_UV_STARTS_AT_TOP
        #else
        #endif
        
        
            output.uv0 =                                        input.texCoord0;
        
            // splice point to copy frag inputs custom interpolator pack into the SDI
            
        
            return output;
        }
        
            // --------------------------------------------------
            // Build Surface Data (Specific Material)
        
        void ApplyDecalToSurfaceDataNoNormal(DecalSurfaceData decalSurfaceData, inout SurfaceData surfaceData);
        
        void ApplyDecalAndGetNormal(FragInputs fragInputs, PositionInputs posInput, SurfaceDescription surfaceDescription,
            inout SurfaceData surfaceData)
        {
            float3 doubleSidedConstants = GetDoubleSidedConstants();
        
        #ifdef DECAL_NORMAL_BLENDING
            // SG nodes don't ouptut surface gradients, so if decals require surf grad blending, we have to convert
            // the normal to gradient before applying the decal. We then have to resolve the gradient back to world space
            float3 normalTS;
        
            normalTS = SurfaceGradientFromTangentSpaceNormalAndFromTBN(surfaceDescription.NormalTS,
            fragInputs.tangentToWorld[0], fragInputs.tangentToWorld[1]);
        
        
            #if HAVE_DECALS
            if (_EnableDecals)
            {
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                ApplyDecalToSurfaceNormal(decalSurfaceData, fragInputs.tangentToWorld[2], normalTS);
                ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
            }
            #endif
        
            GetNormalWS_SG(fragInputs, normalTS, surfaceData.normalWS, doubleSidedConstants);
        #else
            // normal delivered to master node
            GetNormalWS(fragInputs, surfaceDescription.NormalTS, surfaceData.normalWS, doubleSidedConstants);
        
            #if HAVE_DECALS
            if (_EnableDecals)
            {
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                // Both uses and modifies 'surfaceData.normalWS'.
                DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                ApplyDecalToSurfaceNormal(decalSurfaceData, surfaceData.normalWS.xyz);
                ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
            }
            #endif
        #endif
        }
        void BuildSurfaceData(FragInputs fragInputs, inout SurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
        {
            ZERO_INITIALIZE(SurfaceData, surfaceData);
        
            // specularOcclusion need to be init ahead of decal to quiet the compiler that modify the SurfaceData struct
            // however specularOcclusion can come from the graph, so need to be init here so it can be override.
            surfaceData.specularOcclusion = 1.0;
            surfaceData.thickness = 0.0;
        
            surfaceData.baseColor =                 surfaceDescription.BaseColor;
            surfaceData.perceptualSmoothness =      surfaceDescription.Smoothness;
            surfaceData.ambientOcclusion =          surfaceDescription.Occlusion;
            surfaceData.transmissionMask =          surfaceDescription.TransmissionMask.xxx;
            surfaceData.thickness =                 surfaceDescription.Thickness;
            surfaceData.diffusionProfileHash =      asuint(surfaceDescription.DiffusionProfileHash);
        
            #if defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE) || defined(_REFRACTION_THIN)
                if (_EnableSSRefraction)
                {
        
                    surfaceData.transmittanceMask = (1.0 - surfaceDescription.Alpha);
                    surfaceDescription.Alpha = 1.0;
                }
                else
                {
                    surfaceData.ior = 1.0;
                    surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                    surfaceData.atDistance = 1.0;
                    surfaceData.transmittanceMask = 0.0;
                    surfaceDescription.Alpha = 1.0;
                }
            #else
                surfaceData.ior = 1.0;
                surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                surfaceData.atDistance = 1.0;
                surfaceData.transmittanceMask = 0.0;
            #endif
        
            // These static material feature allow compile time optimization
            surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;
            #ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
            #endif
        
            #ifdef _MATERIAL_FEATURE_TRANSMISSION
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
            #endif
        
            #ifdef _MATERIAL_FEATURE_COLORED_TRANSMISSION
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_COLORED_TRANSMISSION;
        
            #endif
        
            #ifdef _MATERIAL_FEATURE_ANISOTROPY
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
        
                // Initialize the normal to something non-zero to avoid a div-zero warning for anisotropy.
                surfaceData.normalWS = float3(0, 1, 0);
            #endif
        
            #ifdef _MATERIAL_FEATURE_IRIDESCENCE
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
            #endif
        
            #ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
            #endif
        
            #ifdef _MATERIAL_FEATURE_CLEAR_COAT
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
            #endif
        
            #if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
                // Require to have setup baseColor
                // Reproduce the energy conservation done in legacy Unity. Not ideal but better for compatibility and users can unchek it
                surfaceData.baseColor *= (1.0 - Max3(surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b));
            #endif
        
            float3 doubleSidedConstants = GetDoubleSidedConstants();
        
            ApplyDecalAndGetNormal(fragInputs, posInput, surfaceDescription, surfaceData);
        
            surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];
        
            surfaceData.tangentWS = normalize(fragInputs.tangentToWorld[0].xyz);    // The tangent is not normalize in tangentToWorld for mikkt. TODO: Check if it expected that we normalize with Morten. Tag: SURFACE_GRADIENT
        
        
            bentNormalWS = surfaceData.normalWS;
        
            surfaceData.tangentWS = Orthonormalize(surfaceData.tangentWS, surfaceData.normalWS);
        
            #ifdef DEBUG_DISPLAY
                if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
                {
                    // TODO: need to update mip info
                    surfaceData.metallic = 0;
                }
        
                // We need to call ApplyDebugToSurfaceData after filling the surfarcedata and before filling builtinData
                // as it can modify attribute use for static lighting
                ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData);
            #endif
        
            // By default we use the ambient occlusion with Tri-ace trick (apply outside) for specular occlusion.
            // If user provide bent normal then we process a better term
            #if defined(_SPECULAR_OCCLUSION_CUSTOM)
                // Just use the value passed through via the slot (not active otherwise)
            #elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
                // If we have bent normal and ambient occlusion, process a specular occlusion
                surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO(V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness(surfaceData.perceptualSmoothness));
            #elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
                surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion(ClampNdotV(dot(surfaceData.normalWS, V)), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness(surfaceData.perceptualSmoothness));
            #endif
        
            #if defined(_ENABLE_GEOMETRIC_SPECULAR_AA) && !defined(SHADER_STAGE_RAY_TRACING)
                surfaceData.perceptualSmoothness = GeometricNormalFiltering(surfaceData.perceptualSmoothness, fragInputs.tangentToWorld[2], surfaceDescription.SpecularAAScreenSpaceVariance, surfaceDescription.SpecularAAThreshold);
            #endif
        }
        
            // --------------------------------------------------
            // Get Surface And BuiltinData
        
            void GetSurfaceAndBuiltinData(FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData RAY_TRACING_OPTIONAL_PARAMETERS)
            {
                // Don't dither if displaced tessellation (we're fading out the displacement instead to match the next LOD)
                #if !defined(SHADER_STAGE_RAY_TRACING) && !defined(_TESSELLATION_DISPLACEMENT)
                #ifdef LOD_FADE_CROSSFADE // enable dithering LOD transition if user select CrossFade transition in LOD group
                LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
                #endif
                #endif
        
                #ifndef SHADER_UNLIT
                #ifdef _DOUBLESIDED_ON
                    float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
                #else
                    float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
                #endif
        
                ApplyDoubleSidedFlipOrMirror(fragInputs, doubleSidedConstants); // Apply double sided flip on the vertex normal
                #endif // SHADER_UNLIT
        
                SurfaceDescriptionInputs surfaceDescriptionInputs = FragInputsToSurfaceDescriptionInputs(fragInputs, V);
        
                #if defined(HAVE_VFX_MODIFICATION)
                GraphProperties properties;
                ZERO_INITIALIZE(GraphProperties, properties);
        
                GetElementPixelProperties(fragInputs, properties);
        
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs, properties);
                #else
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs);
                #endif
        
                // Perform alpha test very early to save performance (a killed pixel will not sample textures)
                // TODO: split graph evaluation to grab just alpha dependencies first? tricky..
                #ifdef _ALPHATEST_ON
                    float alphaCutoff = surfaceDescription.AlphaClipThreshold;
                    #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
                    // The TransparentDepthPrepass is also used with SSR transparent.
                    // If an artists enable transaprent SSR but not the TransparentDepthPrepass itself, then we use AlphaClipThreshold
                    // otherwise if TransparentDepthPrepass is enabled we use AlphaClipThresholdDepthPrepass
                    #elif SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_POSTPASS
                    // DepthPostpass always use its own alpha threshold
                    alphaCutoff = surfaceDescription.AlphaClipThresholdDepthPostpass;
                    #elif (SHADERPASS == SHADERPASS_SHADOWS) || (SHADERPASS == SHADERPASS_RAYTRACING_VISIBILITY)
                    // If use shadow threshold isn't enable we don't allow any test
                    #endif
        
                    GENERIC_ALPHA_TEST(surfaceDescription.Alpha, alphaCutoff);
                #endif
        
                #if !defined(SHADER_STAGE_RAY_TRACING) && _DEPTHOFFSET_ON
                ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
                #endif
        
                #ifndef SHADER_UNLIT
                float3 bentNormalWS;
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS);
        
                #ifdef FRAG_INPUTS_USE_TEXCOORD1
                    float4 lightmapTexCoord1 = fragInputs.texCoord1;
                #else
                    float4 lightmapTexCoord1 = float4(0,0,0,0);
                #endif
        
                #ifdef FRAG_INPUTS_USE_TEXCOORD2
                    float4 lightmapTexCoord2 = fragInputs.texCoord2;
                #else
                    float4 lightmapTexCoord2 = float4(0,0,0,0);
                #endif
        
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                // Builtin Data
                // For back lighting we use the oposite vertex normal
                InitBuiltinData(posInput, alpha, bentNormalWS, -fragInputs.tangentToWorld[2], lightmapTexCoord1, lightmapTexCoord2, builtinData);
        
                #else
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData);
        
                ZERO_BUILTIN_INITIALIZE(builtinData); // No call to InitBuiltinData as we don't have any lighting
                builtinData.opacity = surfaceDescription.Alpha;
        
                #if defined(DEBUG_DISPLAY)
                    // Light Layers are currently not used for the Unlit shader (because it is not lit)
                    // But Unlit objects do cast shadows according to their rendering layer mask, which is what we want to
                    // display in the light layers visualization mode, therefore we need the renderingLayers
                    builtinData.renderingLayers = GetMeshRenderingLayerMask();
                #endif
        
                #endif // SHADER_UNLIT
        
                #ifdef _ALPHATEST_ON
                    // Used for sharpening by alpha to mask - Alpha to covertage is only used with depth only and forward pass (no shadow pass, no transparent pass)
                    builtinData.alphaClipTreshold = alphaCutoff;
                #endif
        
                // override sampleBakedGI - not used by Unlit
        		// When overriding GI, we need to force the isLightmap flag to make sure we don't add APV (sampled in the lightloop) on top of the overridden value (set at GBuffer stage)
        
                builtinData.emissiveColor = surfaceDescription.Emission;
        
                // Note this will not fully work on transparent surfaces (can check with _SURFACE_TYPE_TRANSPARENT define)
                // We will always overwrite vt feeback with the nearest. So behind transparent surfaces vt will not be resolved
                // This is a limitation of the current MRT approach.
                #ifdef UNITY_VIRTUAL_TEXTURING
                #endif
        
                #if _DEPTHOFFSET_ON
                builtinData.depthOffset = surfaceDescription.DepthOffset;
                #endif
        
                // TODO: We should generate distortion / distortionBlur for non distortion pass
                #if (SHADERPASS == SHADERPASS_DISTORTION)
                builtinData.distortion = surfaceDescription.Distortion;
                builtinData.distortionBlur = surfaceDescription.DistortionBlur;
                #endif
        
                #ifndef SHADER_UNLIT
                // PostInitBuiltinData call ApplyDebugToBuiltinData
                PostInitBuiltinData(V, posInput, surfaceData, builtinData);
                #else
                ApplyDebugToBuiltinData(builtinData);
                #endif
        
                RAY_TRACING_OPTIONAL_ALPHA_TEST_PASS
            }
        
            // --------------------------------------------------
            // Main
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPassDepthOnly.hlsl"
        
            // --------------------------------------------------
            // Visual Effect Vertex Invocations
        
        	#ifdef HAVE_VFX_MODIFICATION
                #if !defined(SHADER_STAGE_RAY_TRACING)
        	    #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/VisualEffectVertex.hlsl"
                #else
                #endif
        	#endif
        
            #include "Assets/VegetationInstancer/Shaders/Include/GPUInstancedIndirectInclude.cginc"
#pragma instancing_options procedural:setupGPUInstancedIndirect
#pragma multi_compile_instancing
ENDHLSL
        }
        Pass
        {
            Name "GBuffer"
            Tags
            {
                "LightMode" = "GBuffer"
            }
        
            // Render State
            Cull [_CullMode]
        ZTest [_ZTestGBuffer]
        Stencil
        {
        WriteMask [_StencilWriteMaskGBuffer]
        Ref [_StencilRefGBuffer]
        CompFront Always
        PassFront Replace
        CompBack Always
        PassBack Replace
        }
        
            // Debug
            // <None>
        
            // --------------------------------------------------
            // Pass
        
            HLSLPROGRAM
        
            // Pragmas
            #pragma multi_compile _ DOTS_INSTANCING_ON
        
        #pragma target 4.5
        #pragma vertex Vert
        #pragma fragment Frag
        #pragma only_renderers d3d11 playstation xboxone xboxseries vulkan metal switch
        
        
            // Keywords
            #pragma multi_compile_fragment _ RENDERING_LAYERS
        #pragma multi_compile_raytracing _ RENDERING_LAYERS
        #pragma shader_feature_local _ _ALPHATEST_ON
        #pragma shader_feature _ _SURFACE_TYPE_TRANSPARENT
        #pragma shader_feature_local _ _DOUBLESIDED_ON
        #pragma shader_feature_local _ _ADD_PRECOMPUTED_VELOCITY
        #pragma shader_feature_local _ _TRANSPARENT_WRITES_MOTION_VEC _TRANSPARENT_REFRACTIVE_SORT
        #pragma shader_feature_local_fragment _ _ENABLE_FOG_ON_TRANSPARENT
        #pragma multi_compile _ DEBUG_DISPLAY
        #pragma shader_feature_local_fragment _ _DISABLE_DECALS
        #pragma shader_feature_local_raytracing _ _DISABLE_DECALS
        #pragma shader_feature_local_fragment _ _DISABLE_SSR
        #pragma shader_feature_local_raytracing _ _DISABLE_SSR
        #pragma shader_feature_local_fragment _ _DISABLE_SSR_TRANSPARENT
        #pragma shader_feature_local_raytracing _ _DISABLE_SSR_TRANSPARENT
        #pragma multi_compile _ LIGHTMAP_ON
        #pragma multi_compile _ DIRLIGHTMAP_COMBINED
        #pragma multi_compile_fragment _ PROBE_VOLUMES_L1 PROBE_VOLUMES_L2
        #pragma multi_compile_raytracing _ PROBE_VOLUMES_L1 PROBE_VOLUMES_L2
        #pragma multi_compile _ DYNAMICLIGHTMAP_ON
        #pragma multi_compile_fragment _ SHADOWS_SHADOWMASK
        #pragma multi_compile_raytracing _ SHADOWS_SHADOWMASK
        #pragma multi_compile_fragment DECALS_OFF DECALS_3RT DECALS_4RT
        #pragma multi_compile_fragment _ DECAL_SURFACE_GRADIENT
        #pragma shader_feature_local _ _REFRACTION_PLANE _REFRACTION_SPHERE _REFRACTION_THIN
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_TRANSMISSION
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_TRANSMISSION
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_ANISOTROPY
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_ANISOTROPY
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_IRIDESCENCE
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_IRIDESCENCE
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_SPECULAR_COLOR
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_SPECULAR_COLOR
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_COLORED_TRANSMISSION
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_COLORED_TRANSMISSION
            // GraphKeywords: <None>
        
            // Defines
            #define SHADERPASS SHADERPASS_GBUFFER
        #define RAYTRACING_SHADER_GRAPH_DEFAULT
        
            // For custom interpolators to inject a substruct definition before FragInputs definition,
            // allowing for FragInputs to capture CI's intended for ShaderGraph's SDI.
            struct CustomInterpolators
        {
        };
        #define USE_CUSTOMINTERP_SUBSTRUCT
        
        
        
            // TODO: Merge FragInputsVFX substruct with CustomInterpolators.
        	#ifdef HAVE_VFX_MODIFICATION
        	struct FragInputsVFX
            {
                /* WARNING: $splice Could not find named fragment 'FragInputsVFX' */
            };
            #endif
        
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl" // Required by Tessellation.hlsl
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Tessellation.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl" // Required to be include before we include properties as it define DECLARE_STACK_CB
            // Always include Shader Graph version
            // Always include last to avoid double macros
            #include "Packages/com.unity.shadergraph/ShaderGraphLibrary/Functions.hlsl" // Need to be here for Gradient struct definition
        
            // --------------------------------------------------
            // Defines
        
            // Attribute
            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define ATTRIBUTES_NEED_TEXCOORD0
            #define ATTRIBUTES_NEED_TEXCOORD1
            #define ATTRIBUTES_NEED_TEXCOORD2
            #define VARYINGS_NEED_POSITION_WS
            #define VARYINGS_NEED_TANGENT_TO_WORLD
            #define VARYINGS_NEED_TEXCOORD0
            #define VARYINGS_NEED_TEXCOORD1
            #define VARYINGS_NEED_TEXCOORD2
        
            #define HAVE_MESH_MODIFICATION
        
            //Strip down the FragInputs.hlsl (on graphics), so we can only optimize the interpolators we use.
            //if by accident something requests contents of FragInputs.hlsl, it will be caught as a compiler error
            //Frag inputs stripping is only enabled when FRAG_INPUTS_ENABLE_STRIPPING is set
            #if !defined(SHADER_STAGE_RAY_TRACING) && SHADERPASS != SHADERPASS_RAYTRACING_GBUFFER && SHADERPASS != SHADERPASS_FULL_SCREEN_DEBUG
            #define FRAG_INPUTS_ENABLE_STRIPPING
            #endif
            #define FRAG_INPUTS_USE_TEXCOORD0
            #define FRAG_INPUTS_USE_TEXCOORD1
            #define FRAG_INPUTS_USE_TEXCOORD2
        
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
        
        
        
        
            // Following two define are a workaround introduce in 10.1.x for RaytracingQualityNode
            // The ShaderGraph don't support correctly migration of this node as it serialize all the node data
            // in the json file making it impossible to uprgrade. Until we get a fix, we do a workaround here
            // to still allow us to rename the field and keyword of this node without breaking existing code.
            #ifdef RAYTRACING_SHADER_GRAPH_DEFAULT
            #define RAYTRACING_SHADER_GRAPH_HIGH
            #endif
        
            #ifdef RAYTRACING_SHADER_GRAPH_RAYTRACED
            #define RAYTRACING_SHADER_GRAPH_LOW
            #endif
            // end
        
            #ifndef SHADER_UNLIT
            // We need isFrontFace when using double sided - it is not required for unlit as in case of unlit double sided only drive the cullmode
            // VARYINGS_NEED_CULLFACE can be define by VaryingsMeshToPS.FaceSign input if a IsFrontFace Node is included in the shader graph.
            #if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
                #define VARYINGS_NEED_CULLFACE
            #endif
            #endif
        
            // Specific Material Define
        #define _SPECULAR_OCCLUSION_FROM_AO 1
        #define _ENERGY_CONSERVING_SPECULAR 1
        
        #if _MATERIAL_FEATURE_COLORED_TRANSMISSION
            // Colored Transmission doesn't support clear coat
            #undef _MATERIAL_FEATURE_CLEAR_COAT
        #endif
        
        // If we use subsurface scattering, enable output split lighting (for forward pass)
        #if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
            #define OUTPUT_SPLIT_LIGHTING
        #endif
        
        // This shader support recursive rendering for raytracing
        #define HAVE_RECURSIVE_RENDERING
        
        // In Path Tracing, For all single-sided, refractive materials, we want to force a thin refraction model
        #if (SHADERPASS == SHADERPASS_PATH_TRACING) && !defined(_DOUBLESIDED_ON) && (defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE))
            #undef  _REFRACTION_PLANE
            #undef  _REFRACTION_SPHERE
            #define _REFRACTION_THIN
        #endif
            // Caution: we can use the define SHADER_UNLIT onlit after the above Material include as it is the Unlit template who define it
        
            // To handle SSR on transparent correctly with a possibility to enable/disable it per framesettings
            // we should have a code like this:
            // if !defined(_DISABLE_SSR_TRANSPARENT)
            // pragma multi_compile _ WRITE_NORMAL_BUFFER
            // endif
            // i.e we enable the multicompile only if we can receive SSR or not, and then C# code drive
            // it based on if SSR transparent in frame settings and not (and stripper can strip it).
            // this is currently not possible with our current preprocessor as _DISABLE_SSR_TRANSPARENT is a keyword not a define
            // so instead we used this and chose to pay the extra cost of normal write even if SSR transaprent is disabled.
            // Ideally the shader graph generator should handle it but condition below can't be handle correctly for now.
            #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
            #if !defined(_DISABLE_SSR_TRANSPARENT) && !defined(SHADER_UNLIT)
                #define WRITE_NORMAL_BUFFER
            #endif
            #endif
        
            // See Lit.shader
            #if SHADERPASS == SHADERPASS_MOTION_VECTORS && defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)
                #define WRITE_DECAL_BUFFER
            #endif
        
            #ifndef DEBUG_DISPLAY
                // In case of opaque we don't want to perform the alpha test, it is done in depth prepass and we use depth equal for ztest (setup from UI)
                // Don't do it with debug display mode as it is possible there is no depth prepass in this case
                #if !defined(_SURFACE_TYPE_TRANSPARENT)
                    #if SHADERPASS == SHADERPASS_FORWARD
                    #define SHADERPASS_FORWARD_BYPASS_ALPHA_TEST
                    #elif SHADERPASS == SHADERPASS_GBUFFER
                    #define SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST
                    #endif
                #endif
            #endif
        
            // Define _DEFERRED_CAPABLE_MATERIAL for shader capable to run in deferred pass
            #if defined(SHADER_LIT) && !defined(_SURFACE_TYPE_TRANSPARENT)
                #define _DEFERRED_CAPABLE_MATERIAL
            #endif
        
            // Translate transparent motion vector define
            #if (defined(_TRANSPARENT_WRITES_MOTION_VEC) || defined(_TRANSPARENT_REFRACTIVE_SORT)) && defined(_SURFACE_TYPE_TRANSPARENT)
                #define _WRITE_TRANSPARENT_MOTION_VECTOR
            #endif
        
            // -- Graph Properties
            CBUFFER_START(UnityPerMaterial)
        float4 _DiffusionProfileAsset;
        float _DiffusionProfileHash;
        float4 _Texture2D_TexelSize;
        float4 _Albedo;
        float _Smoothness;
        float _WindSpeed;
        float _WindStrength;
        float4 _Normal_TexelSize;
        float _NormalStrength;
        float4 _EmissionColor;
        float _UseShadowThreshold;
        float4 _DoubleSidedConstants;
        float _BlendMode;
        float _EnableBlendModePreserveSpecularLighting;
        float _RayTracing;
        float _RefractionModel;
        float _MaterialID;
        float _MaterialTypeMask;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_Texture2D);
        SAMPLER(sampler_Texture2D);
        TEXTURE2D(_Normal);
        SAMPLER(sampler_Normal);
        
            // -- Property used by ScenePickingPass
            #ifdef SCENEPICKINGPASS
            float4 _SelectionID;
            #endif
        
            // -- Properties used by SceneSelectionPass
            #ifdef SCENESELECTIONPASS
            int _ObjectId;
            int _PassValue;
            #endif
        
            // Includes
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitDecalData.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"
        	// GraphIncludes: <None>
        
            // --------------------------------------------------
            // Structs and Packing
        
            struct AttributesMesh
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
             float4 uv1 : TEXCOORD1;
             float4 uv2 : TEXCOORD2;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct VaryingsMeshToPS
        {
            SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
             float3 positionRWS;
             float3 normalWS;
             float4 tangentWS;
             float4 texCoord0;
             float4 texCoord1;
             float4 texCoord2;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
             float3 WorldSpacePosition;
             float4 uv0;
             float3 TimeParameters;
        };
        struct SurfaceDescriptionInputs
        {
             float3 TangentSpaceNormal;
             float4 uv0;
        };
        struct PackedVaryingsMeshToPS
        {
            SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
             float4 tangentWS : INTERP0;
             float4 texCoord0 : INTERP1;
             float4 texCoord1 : INTERP2;
             float4 texCoord2 : INTERP3;
             float3 positionRWS : INTERP4;
             float3 normalWS : INTERP5;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
        };
        
            PackedVaryingsMeshToPS PackVaryingsMeshToPS (VaryingsMeshToPS input)
        {
            PackedVaryingsMeshToPS output;
            ZERO_INITIALIZE(PackedVaryingsMeshToPS, output);
            output.positionCS = input.positionCS;
            output.tangentWS.xyzw = input.tangentWS;
            output.texCoord0.xyzw = input.texCoord0;
            output.texCoord1.xyzw = input.texCoord1;
            output.texCoord2.xyzw = input.texCoord2;
            output.positionRWS.xyz = input.positionRWS;
            output.normalWS.xyz = input.normalWS;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            return output;
        }
        
        VaryingsMeshToPS UnpackVaryingsMeshToPS (PackedVaryingsMeshToPS input)
        {
            VaryingsMeshToPS output;
            output.positionCS = input.positionCS;
            output.tangentWS = input.tangentWS.xyzw;
            output.texCoord0 = input.texCoord0.xyzw;
            output.texCoord1 = input.texCoord1.xyzw;
            output.texCoord2 = input.texCoord2.xyzw;
            output.positionRWS = input.positionRWS.xyz;
            output.normalWS = input.normalWS.xyz;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            return output;
        }
        
        
            // --------------------------------------------------
            // Graph
        
        
            // Graph Functions
            
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_Sine_float(float In, out float Out)
        {
            Out = sin(In);
        }
        
        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }
        
        void Unity_Multiply_float4_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }
        
            // Graph Vertex
            struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            float _Property_8c596e62dce249caa7922ff3d7470d43_Out_0_Float = _WindSpeed;
            float _Split_35af25740d5a404097ccb209d36d5cac_R_1_Float = IN.WorldSpacePosition[0];
            float _Split_35af25740d5a404097ccb209d36d5cac_G_2_Float = IN.WorldSpacePosition[1];
            float _Split_35af25740d5a404097ccb209d36d5cac_B_3_Float = IN.WorldSpacePosition[2];
            float _Split_35af25740d5a404097ccb209d36d5cac_A_4_Float = 0;
            float _Add_c678bc9d08684d01a8e45ad5e636b4b4_Out_2_Float;
            Unity_Add_float(_Split_35af25740d5a404097ccb209d36d5cac_R_1_Float, _Split_35af25740d5a404097ccb209d36d5cac_B_3_Float, _Add_c678bc9d08684d01a8e45ad5e636b4b4_Out_2_Float);
            float _Add_0ec2f296c670483e9dc4250c81fe62a0_Out_2_Float;
            Unity_Add_float(IN.TimeParameters.x, _Add_c678bc9d08684d01a8e45ad5e636b4b4_Out_2_Float, _Add_0ec2f296c670483e9dc4250c81fe62a0_Out_2_Float);
            float _Multiply_ce5f4784040b450499733beaca915393_Out_2_Float;
            Unity_Multiply_float_float(_Property_8c596e62dce249caa7922ff3d7470d43_Out_0_Float, _Add_0ec2f296c670483e9dc4250c81fe62a0_Out_2_Float, _Multiply_ce5f4784040b450499733beaca915393_Out_2_Float);
            float _Sine_3c81889fed534b52996b5063cdc22296_Out_1_Float;
            Unity_Sine_float(_Multiply_ce5f4784040b450499733beaca915393_Out_2_Float, _Sine_3c81889fed534b52996b5063cdc22296_Out_1_Float);
            float _Property_3cdd281375794ed2bcad3550a9c890af_Out_0_Float = _WindStrength;
            float _Multiply_89ad4329fdd44befb161e56947c2670b_Out_2_Float;
            Unity_Multiply_float_float(_Sine_3c81889fed534b52996b5063cdc22296_Out_1_Float, _Property_3cdd281375794ed2bcad3550a9c890af_Out_0_Float, _Multiply_89ad4329fdd44befb161e56947c2670b_Out_2_Float);
            float4 _UV_30b55575e9844728bc3abbcaf84a22ff_Out_0_Vector4 = IN.uv0;
            float _Split_020d1040f8544c0b9d3de77e7fbd9197_R_1_Float = _UV_30b55575e9844728bc3abbcaf84a22ff_Out_0_Vector4[0];
            float _Split_020d1040f8544c0b9d3de77e7fbd9197_G_2_Float = _UV_30b55575e9844728bc3abbcaf84a22ff_Out_0_Vector4[1];
            float _Split_020d1040f8544c0b9d3de77e7fbd9197_B_3_Float = _UV_30b55575e9844728bc3abbcaf84a22ff_Out_0_Vector4[2];
            float _Split_020d1040f8544c0b9d3de77e7fbd9197_A_4_Float = _UV_30b55575e9844728bc3abbcaf84a22ff_Out_0_Vector4[3];
            float _Multiply_17088dc811eb45e4a333912f99b556ec_Out_2_Float;
            Unity_Multiply_float_float(_Multiply_89ad4329fdd44befb161e56947c2670b_Out_2_Float, _Split_020d1040f8544c0b9d3de77e7fbd9197_G_2_Float, _Multiply_17088dc811eb45e4a333912f99b556ec_Out_2_Float);
            float3 _Add_e473a1f67cd1441b9fccfb91c0b5ff75_Out_2_Vector3;
            Unity_Add_float3(IN.WorldSpacePosition, (_Multiply_17088dc811eb45e4a333912f99b556ec_Out_2_Float.xxx), _Add_e473a1f67cd1441b9fccfb91c0b5ff75_Out_2_Vector3);
            float3 _Add_8e06eedaa53749dea4ffc85b774f63ee_Out_2_Vector3;
            Unity_Add_float3(float3(0, 0, 0), _Add_e473a1f67cd1441b9fccfb91c0b5ff75_Out_2_Vector3, _Add_8e06eedaa53749dea4ffc85b774f63ee_Out_2_Vector3);
            float3 _Transform_78fa02a50d4c495cba1111966696417e_Out_1_Vector3;
            _Transform_78fa02a50d4c495cba1111966696417e_Out_1_Vector3 = TransformWorldToObject(_Add_8e06eedaa53749dea4ffc85b774f63ee_Out_2_Vector3.xyz);
            description.Position = _Transform_78fa02a50d4c495cba1111966696417e_Out_1_Vector3;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
            // Graph Pixel
            struct SurfaceDescription
        {
            float3 BaseColor;
            float3 Emission;
            float Alpha;
            float AlphaClipThreshold;
            float3 BentNormal;
            float Smoothness;
            float Occlusion;
            float3 NormalTS;
            float TransmissionMask;
            float Thickness;
            float DiffusionProfileHash;
            float4 VTPackedFeedback;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float4 _Property_35c125abbbcb46e1a2351d8febeb5da1_Out_0_Vector4 = _Albedo;
            UnityTexture2D _Property_bb313b600ca3404fb88a2820878a8482_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Texture2D);
            float4 _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_bb313b600ca3404fb88a2820878a8482_Out_0_Texture2D.tex, _Property_bb313b600ca3404fb88a2820878a8482_Out_0_Texture2D.samplerstate, _Property_bb313b600ca3404fb88a2820878a8482_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_R_4_Float = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4.r;
            float _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_G_5_Float = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4.g;
            float _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_B_6_Float = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4.b;
            float _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_A_7_Float = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4.a;
            float4 _Multiply_c09cca22f04c4a9a996a5ccf8f61afe1_Out_2_Vector4;
            Unity_Multiply_float4_float4(_Property_35c125abbbcb46e1a2351d8febeb5da1_Out_0_Vector4, _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4, _Multiply_c09cca22f04c4a9a996a5ccf8f61afe1_Out_2_Vector4);
            float _Property_925f8cb589d94edda2dcd6b588187f26_Out_0_Float = _Smoothness;
            float _Multiply_a061075fe3794cc5abff5f173997f7f8_Out_2_Float;
            Unity_Multiply_float_float(_Property_925f8cb589d94edda2dcd6b588187f26_Out_0_Float, _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_G_5_Float, _Multiply_a061075fe3794cc5abff5f173997f7f8_Out_2_Float);
            UnityTexture2D _Property_ff2eff189fa74f1f965ec8aca53205ba_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Normal);
            float4 _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_ff2eff189fa74f1f965ec8aca53205ba_Out_0_Texture2D.tex, _Property_ff2eff189fa74f1f965ec8aca53205ba_Out_0_Texture2D.samplerstate, _Property_ff2eff189fa74f1f965ec8aca53205ba_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.rgb = UnpackNormal(_SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4);
            float _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_R_4_Float = _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.r;
            float _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_G_5_Float = _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.g;
            float _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_B_6_Float = _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.b;
            float _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_A_7_Float = _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.a;
            float _Property_915c3b0b5fc04c668c646f2f67b5ab2b_Out_0_Float = _NormalStrength;
            float4 _Multiply_e38eea28614c4b61bfd135ec8591a746_Out_2_Vector4;
            Unity_Multiply_float4_float4(_SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4, (_Property_915c3b0b5fc04c668c646f2f67b5ab2b_Out_0_Float.xxxx), _Multiply_e38eea28614c4b61bfd135ec8591a746_Out_2_Vector4);
            surface.BaseColor = (_Multiply_c09cca22f04c4a9a996a5ccf8f61afe1_Out_2_Vector4.xyz);
            surface.Emission = float3(0, 0, 0);
            surface.Alpha = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_A_7_Float;
            surface.AlphaClipThreshold = 0.5;
            surface.BentNormal = IN.TangentSpaceNormal;
            surface.Smoothness = _Multiply_a061075fe3794cc5abff5f173997f7f8_Out_2_Float;
            surface.Occlusion = 1;
            surface.NormalTS = (_Multiply_e38eea28614c4b61bfd135ec8591a746_Out_2_Vector4.xyz);
            surface.TransmissionMask = 1;
            surface.Thickness = 1;
            surface.DiffusionProfileHash = _DiffusionProfileHash;
            {
                surface.VTPackedFeedback = float4(1.0f,1.0f,1.0f,1.0f);
            }
            return surface;
        }
        
            // --------------------------------------------------
            // Build Graph Inputs
            #ifdef HAVE_VFX_MODIFICATION
            #define VFX_SRP_ATTRIBUTES AttributesMesh
            #define VaryingsMeshType VaryingsMeshToPS
            #define VFX_SRP_VARYINGS VaryingsMeshType
            #define VFX_SRP_SURFACE_INPUTS FragInputs
            #endif
            
        VertexDescriptionInputs AttributesMeshToVertexDescriptionInputs(AttributesMesh input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
            output.WorldSpacePosition =                         TransformObjectToWorld(input.positionOS);
            output.uv0 =                                        input.uv0;
            output.TimeParameters =                             _TimeParameters.xyz; // Note: in case of animation this will be overwrite (allow to handle motion vector)
        
            return output;
        }
        
        VertexDescription GetVertexDescription(AttributesMesh input, float3 timeParameters
        #ifdef HAVE_VFX_MODIFICATION
            , AttributesElement element
        #endif
        )
        {
            // build graph inputs
            VertexDescriptionInputs vertexDescriptionInputs = AttributesMeshToVertexDescriptionInputs(input);
            // Override time parameters with used one (This is required to correctly handle motion vectors for vertex animation based on time)
            vertexDescriptionInputs.TimeParameters = timeParameters;
        
            // evaluate vertex graph
        #ifdef HAVE_VFX_MODIFICATION
            GraphProperties properties;
            ZERO_INITIALIZE(GraphProperties, properties);
        
            // Fetch the vertex graph properties for the particle instance.
            GetElementVertexProperties(element, properties);
        
            VertexDescription vertexDescription = VertexDescriptionFunction(vertexDescriptionInputs, properties);
        #else
            VertexDescription vertexDescription = VertexDescriptionFunction(vertexDescriptionInputs);
        #endif
            return vertexDescription;
        
        }
        
        AttributesMesh ApplyMeshModification(AttributesMesh input, float3 timeParameters
        #ifdef USE_CUSTOMINTERP_SUBSTRUCT
            #ifdef TESSELLATION_ON
            , inout VaryingsMeshToDS varyings
            #else
            , inout VaryingsMeshToPS varyings
            #endif
        #endif
        #ifdef HAVE_VFX_MODIFICATION
                , AttributesElement element
        #endif
            )
        {
            VertexDescription vertexDescription = GetVertexDescription(input, timeParameters
        #ifdef HAVE_VFX_MODIFICATION
                , element
        #endif
            );
        
            // copy graph output to the results
            input.positionOS = vertexDescription.Position;
            input.normalOS = vertexDescription.Normal;
            input.tangentOS.xyz = vertexDescription.Tangent;
        
            
        
            return input;
        }
        
        #if defined(_ADD_CUSTOM_VELOCITY) // For shader graph custom velocity
        // Return precomputed Velocity in object space
        float3 GetCustomVelocity(AttributesMesh input
        #ifdef HAVE_VFX_MODIFICATION
            , AttributesElement element
        #endif
        )
        {
            VertexDescription vertexDescription = GetVertexDescription(input, _TimeParameters.xyz
        #ifdef HAVE_VFX_MODIFICATION
                , element
        #endif
            );
            return vertexDescription.CustomVelocity;
        }
        #endif
        
        FragInputs BuildFragInputs(VaryingsMeshToPS input)
        {
            FragInputs output;
            ZERO_INITIALIZE(FragInputs, output);
        
            // Init to some default value to make the computer quiet (else it output 'divide by zero' warning even if value is not used).
            // TODO: this is a really poor workaround, but the variable is used in a bunch of places
            // to compute normals which are then passed on elsewhere to compute other values...
            output.tangentToWorld = k_identity3x3;
            output.positionSS = input.positionCS;       // input.positionCS is SV_Position
        
            output.positionRWS =                input.positionRWS;
            output.tangentToWorld =             BuildTangentToWorld(input.tangentWS, input.normalWS);
            output.texCoord0 =                  input.texCoord0;
            output.texCoord1 =                  input.texCoord1;
            output.texCoord2 =                  input.texCoord2;
        
        
        #ifdef HAVE_VFX_MODIFICATION
            // FragInputs from VFX come from two places: Interpolator or CBuffer.
        #if VFX_USE_GRAPH_VALUES
            uint instanceActiveIndex = asuint(UNITY_ACCESS_INSTANCED_PROP(PerInstance, _InstanceActiveIndex));
            /* WARNING: $splice Could not find named fragment 'VFXLoadGraphValues' */
        #endif
        
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            // splice point to copy custom interpolator fields from varyings to frag inputs
            
        
            return output;
        }
        
        // existing HDRP code uses the combined function to go directly from packed to frag inputs
        FragInputs UnpackVaryingsMeshToFragInputs(PackedVaryingsMeshToPS input)
        {
            UNITY_SETUP_INSTANCE_ID(input);
        #if defined(HAVE_VFX_MODIFICATION) && defined(UNITY_INSTANCING_ENABLED)
            unity_InstanceID = input.instanceID;
        #endif
            VaryingsMeshToPS unpacked = UnpackVaryingsMeshToPS(input);
            return BuildFragInputs(unpacked);
        }
            SurfaceDescriptionInputs FragInputsToSurfaceDescriptionInputs(FragInputs input, float3 viewWS)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
            #if defined(SHADER_STAGE_RAY_TRACING)
            #else
            #endif
            output.TangentSpaceNormal =                         float3(0.0f, 0.0f, 1.0f);
        
        #if UNITY_UV_STARTS_AT_TOP
        #else
        #endif
        
        
            output.uv0 =                                        input.texCoord0;
        
            // splice point to copy frag inputs custom interpolator pack into the SDI
            
        
            return output;
        }
        
            // --------------------------------------------------
            // Build Surface Data (Specific Material)
        
        void ApplyDecalToSurfaceDataNoNormal(DecalSurfaceData decalSurfaceData, inout SurfaceData surfaceData);
        
        void ApplyDecalAndGetNormal(FragInputs fragInputs, PositionInputs posInput, SurfaceDescription surfaceDescription,
            inout SurfaceData surfaceData)
        {
            float3 doubleSidedConstants = GetDoubleSidedConstants();
        
        #ifdef DECAL_NORMAL_BLENDING
            // SG nodes don't ouptut surface gradients, so if decals require surf grad blending, we have to convert
            // the normal to gradient before applying the decal. We then have to resolve the gradient back to world space
            float3 normalTS;
        
            normalTS = SurfaceGradientFromTangentSpaceNormalAndFromTBN(surfaceDescription.NormalTS,
            fragInputs.tangentToWorld[0], fragInputs.tangentToWorld[1]);
        
        
            #if HAVE_DECALS
            if (_EnableDecals)
            {
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                ApplyDecalToSurfaceNormal(decalSurfaceData, fragInputs.tangentToWorld[2], normalTS);
                ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
            }
            #endif
        
            GetNormalWS_SG(fragInputs, normalTS, surfaceData.normalWS, doubleSidedConstants);
        #else
            // normal delivered to master node
            GetNormalWS(fragInputs, surfaceDescription.NormalTS, surfaceData.normalWS, doubleSidedConstants);
        
            #if HAVE_DECALS
            if (_EnableDecals)
            {
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                // Both uses and modifies 'surfaceData.normalWS'.
                DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                ApplyDecalToSurfaceNormal(decalSurfaceData, surfaceData.normalWS.xyz);
                ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
            }
            #endif
        #endif
        }
        void BuildSurfaceData(FragInputs fragInputs, inout SurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
        {
            ZERO_INITIALIZE(SurfaceData, surfaceData);
        
            // specularOcclusion need to be init ahead of decal to quiet the compiler that modify the SurfaceData struct
            // however specularOcclusion can come from the graph, so need to be init here so it can be override.
            surfaceData.specularOcclusion = 1.0;
            surfaceData.thickness = 0.0;
        
            surfaceData.baseColor =                 surfaceDescription.BaseColor;
            surfaceData.perceptualSmoothness =      surfaceDescription.Smoothness;
            surfaceData.ambientOcclusion =          surfaceDescription.Occlusion;
            surfaceData.transmissionMask =          surfaceDescription.TransmissionMask.xxx;
            surfaceData.thickness =                 surfaceDescription.Thickness;
            surfaceData.diffusionProfileHash =      asuint(surfaceDescription.DiffusionProfileHash);
        
            #if defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE) || defined(_REFRACTION_THIN)
                if (_EnableSSRefraction)
                {
        
                    surfaceData.transmittanceMask = (1.0 - surfaceDescription.Alpha);
                    surfaceDescription.Alpha = 1.0;
                }
                else
                {
                    surfaceData.ior = 1.0;
                    surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                    surfaceData.atDistance = 1.0;
                    surfaceData.transmittanceMask = 0.0;
                    surfaceDescription.Alpha = 1.0;
                }
            #else
                surfaceData.ior = 1.0;
                surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                surfaceData.atDistance = 1.0;
                surfaceData.transmittanceMask = 0.0;
            #endif
        
            // These static material feature allow compile time optimization
            surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;
            #ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
            #endif
        
            #ifdef _MATERIAL_FEATURE_TRANSMISSION
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
            #endif
        
            #ifdef _MATERIAL_FEATURE_COLORED_TRANSMISSION
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_COLORED_TRANSMISSION;
        
            #endif
        
            #ifdef _MATERIAL_FEATURE_ANISOTROPY
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
        
                // Initialize the normal to something non-zero to avoid a div-zero warning for anisotropy.
                surfaceData.normalWS = float3(0, 1, 0);
            #endif
        
            #ifdef _MATERIAL_FEATURE_IRIDESCENCE
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
            #endif
        
            #ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
            #endif
        
            #ifdef _MATERIAL_FEATURE_CLEAR_COAT
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
            #endif
        
            #if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
                // Require to have setup baseColor
                // Reproduce the energy conservation done in legacy Unity. Not ideal but better for compatibility and users can unchek it
                surfaceData.baseColor *= (1.0 - Max3(surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b));
            #endif
        
            float3 doubleSidedConstants = GetDoubleSidedConstants();
        
            ApplyDecalAndGetNormal(fragInputs, posInput, surfaceDescription, surfaceData);
        
            surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];
        
            surfaceData.tangentWS = normalize(fragInputs.tangentToWorld[0].xyz);    // The tangent is not normalize in tangentToWorld for mikkt. TODO: Check if it expected that we normalize with Morten. Tag: SURFACE_GRADIENT
        
        
            bentNormalWS = surfaceData.normalWS;
        
            surfaceData.tangentWS = Orthonormalize(surfaceData.tangentWS, surfaceData.normalWS);
        
            #ifdef DEBUG_DISPLAY
                if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
                {
                    // TODO: need to update mip info
                    surfaceData.metallic = 0;
                }
        
                // We need to call ApplyDebugToSurfaceData after filling the surfarcedata and before filling builtinData
                // as it can modify attribute use for static lighting
                ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData);
            #endif
        
            // By default we use the ambient occlusion with Tri-ace trick (apply outside) for specular occlusion.
            // If user provide bent normal then we process a better term
            #if defined(_SPECULAR_OCCLUSION_CUSTOM)
                // Just use the value passed through via the slot (not active otherwise)
            #elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
                // If we have bent normal and ambient occlusion, process a specular occlusion
                surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO(V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness(surfaceData.perceptualSmoothness));
            #elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
                surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion(ClampNdotV(dot(surfaceData.normalWS, V)), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness(surfaceData.perceptualSmoothness));
            #endif
        
            #if defined(_ENABLE_GEOMETRIC_SPECULAR_AA) && !defined(SHADER_STAGE_RAY_TRACING)
                surfaceData.perceptualSmoothness = GeometricNormalFiltering(surfaceData.perceptualSmoothness, fragInputs.tangentToWorld[2], surfaceDescription.SpecularAAScreenSpaceVariance, surfaceDescription.SpecularAAThreshold);
            #endif
        }
        
            // --------------------------------------------------
            // Get Surface And BuiltinData
        
            void GetSurfaceAndBuiltinData(FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData RAY_TRACING_OPTIONAL_PARAMETERS)
            {
                // Don't dither if displaced tessellation (we're fading out the displacement instead to match the next LOD)
                #if !defined(SHADER_STAGE_RAY_TRACING) && !defined(_TESSELLATION_DISPLACEMENT)
                #ifdef LOD_FADE_CROSSFADE // enable dithering LOD transition if user select CrossFade transition in LOD group
                LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
                #endif
                #endif
        
                #ifndef SHADER_UNLIT
                #ifdef _DOUBLESIDED_ON
                    float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
                #else
                    float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
                #endif
        
                ApplyDoubleSidedFlipOrMirror(fragInputs, doubleSidedConstants); // Apply double sided flip on the vertex normal
                #endif // SHADER_UNLIT
        
                SurfaceDescriptionInputs surfaceDescriptionInputs = FragInputsToSurfaceDescriptionInputs(fragInputs, V);
        
                #if defined(HAVE_VFX_MODIFICATION)
                GraphProperties properties;
                ZERO_INITIALIZE(GraphProperties, properties);
        
                GetElementPixelProperties(fragInputs, properties);
        
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs, properties);
                #else
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs);
                #endif
        
                // Perform alpha test very early to save performance (a killed pixel will not sample textures)
                // TODO: split graph evaluation to grab just alpha dependencies first? tricky..
                #ifdef _ALPHATEST_ON
                    float alphaCutoff = surfaceDescription.AlphaClipThreshold;
                    #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
                    // The TransparentDepthPrepass is also used with SSR transparent.
                    // If an artists enable transaprent SSR but not the TransparentDepthPrepass itself, then we use AlphaClipThreshold
                    // otherwise if TransparentDepthPrepass is enabled we use AlphaClipThresholdDepthPrepass
                    #elif SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_POSTPASS
                    // DepthPostpass always use its own alpha threshold
                    alphaCutoff = surfaceDescription.AlphaClipThresholdDepthPostpass;
                    #elif (SHADERPASS == SHADERPASS_SHADOWS) || (SHADERPASS == SHADERPASS_RAYTRACING_VISIBILITY)
                    // If use shadow threshold isn't enable we don't allow any test
                    #endif
        
                    GENERIC_ALPHA_TEST(surfaceDescription.Alpha, alphaCutoff);
                #endif
        
                #if !defined(SHADER_STAGE_RAY_TRACING) && _DEPTHOFFSET_ON
                ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
                #endif
        
                #ifndef SHADER_UNLIT
                float3 bentNormalWS;
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS);
        
                #ifdef FRAG_INPUTS_USE_TEXCOORD1
                    float4 lightmapTexCoord1 = fragInputs.texCoord1;
                #else
                    float4 lightmapTexCoord1 = float4(0,0,0,0);
                #endif
        
                #ifdef FRAG_INPUTS_USE_TEXCOORD2
                    float4 lightmapTexCoord2 = fragInputs.texCoord2;
                #else
                    float4 lightmapTexCoord2 = float4(0,0,0,0);
                #endif
        
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                // Builtin Data
                // For back lighting we use the oposite vertex normal
                InitBuiltinData(posInput, alpha, bentNormalWS, -fragInputs.tangentToWorld[2], lightmapTexCoord1, lightmapTexCoord2, builtinData);
        
                #else
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData);
        
                ZERO_BUILTIN_INITIALIZE(builtinData); // No call to InitBuiltinData as we don't have any lighting
                builtinData.opacity = surfaceDescription.Alpha;
        
                #if defined(DEBUG_DISPLAY)
                    // Light Layers are currently not used for the Unlit shader (because it is not lit)
                    // But Unlit objects do cast shadows according to their rendering layer mask, which is what we want to
                    // display in the light layers visualization mode, therefore we need the renderingLayers
                    builtinData.renderingLayers = GetMeshRenderingLayerMask();
                #endif
        
                #endif // SHADER_UNLIT
        
                #ifdef _ALPHATEST_ON
                    // Used for sharpening by alpha to mask - Alpha to covertage is only used with depth only and forward pass (no shadow pass, no transparent pass)
                    builtinData.alphaClipTreshold = alphaCutoff;
                #endif
        
                // override sampleBakedGI - not used by Unlit
        		// When overriding GI, we need to force the isLightmap flag to make sure we don't add APV (sampled in the lightloop) on top of the overridden value (set at GBuffer stage)
        
                builtinData.emissiveColor = surfaceDescription.Emission;
        
                // Note this will not fully work on transparent surfaces (can check with _SURFACE_TYPE_TRANSPARENT define)
                // We will always overwrite vt feeback with the nearest. So behind transparent surfaces vt will not be resolved
                // This is a limitation of the current MRT approach.
                #ifdef UNITY_VIRTUAL_TEXTURING
                builtinData.vtPackedFeedback = surfaceDescription.VTPackedFeedback;
                #endif
        
                #if _DEPTHOFFSET_ON
                builtinData.depthOffset = surfaceDescription.DepthOffset;
                #endif
        
                // TODO: We should generate distortion / distortionBlur for non distortion pass
                #if (SHADERPASS == SHADERPASS_DISTORTION)
                builtinData.distortion = surfaceDescription.Distortion;
                builtinData.distortionBlur = surfaceDescription.DistortionBlur;
                #endif
        
                #ifndef SHADER_UNLIT
                // PostInitBuiltinData call ApplyDebugToBuiltinData
                PostInitBuiltinData(V, posInput, surfaceData, builtinData);
                #else
                ApplyDebugToBuiltinData(builtinData);
                #endif
        
                RAY_TRACING_OPTIONAL_ALPHA_TEST_PASS
            }
        
            // --------------------------------------------------
            // Main
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPassGBuffer.hlsl"
        
            // --------------------------------------------------
            // Visual Effect Vertex Invocations
        
        	#ifdef HAVE_VFX_MODIFICATION
                #if !defined(SHADER_STAGE_RAY_TRACING)
        	    #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/VisualEffectVertex.hlsl"
                #else
                #endif
        	#endif
        
            #include "Assets/VegetationInstancer/Shaders/Include/GPUInstancedIndirectInclude.cginc"
#pragma instancing_options procedural:setupGPUInstancedIndirect
#pragma multi_compile_instancing
ENDHLSL
        }
        Pass
        {
            Name "Forward"
            Tags
            {
                "LightMode" = "Forward"
            }
        
            // Render State
            Cull [_CullModeForward]
        Blend [_SrcBlend] [_DstBlend], [_AlphaSrcBlend] [_AlphaDstBlend]
        Blend 1 One OneMinusSrcAlpha
        Blend 2 One [_DstBlend2]
        Blend 3 One [_DstBlend2]
        Blend 4 One OneMinusSrcAlpha
        ZTest [_ZTestDepthEqualForOpaque]
        ZWrite [_ZWrite]
        ColorMask [_ColorMaskTransparentVelOne] 1
        ColorMask [_ColorMaskTransparentVelTwo] 2
        Stencil
        {
        WriteMask [_StencilWriteMask]
        Ref [_StencilRef]
        CompFront Always
        PassFront Replace
        CompBack Always
        PassBack Replace
        }
        
            // Debug
            // <None>
        
            // --------------------------------------------------
            // Pass
        
            HLSLPROGRAM
        
            // Pragmas
            #pragma multi_compile _ DOTS_INSTANCING_ON
        
        #pragma target 4.5
        #pragma vertex Vert
        #pragma fragment Frag
        #pragma only_renderers d3d11 playstation xboxone xboxseries vulkan metal switch
        
        
            // Keywords
            #pragma shader_feature_local _ _ALPHATEST_ON
        #pragma shader_feature _ _SURFACE_TYPE_TRANSPARENT
        #pragma shader_feature_local _ _DOUBLESIDED_ON
        #pragma shader_feature_local _ _ADD_PRECOMPUTED_VELOCITY
        #pragma shader_feature_local _ _TRANSPARENT_WRITES_MOTION_VEC _TRANSPARENT_REFRACTIVE_SORT
        #pragma shader_feature_local_fragment _ _ENABLE_FOG_ON_TRANSPARENT
        #pragma multi_compile _ DEBUG_DISPLAY
        #pragma shader_feature_local_fragment _ _DISABLE_DECALS
        #pragma shader_feature_local_raytracing _ _DISABLE_DECALS
        #pragma shader_feature_local_fragment _ _DISABLE_SSR
        #pragma shader_feature_local_raytracing _ _DISABLE_SSR
        #pragma shader_feature_local_fragment _ _DISABLE_SSR_TRANSPARENT
        #pragma shader_feature_local_raytracing _ _DISABLE_SSR_TRANSPARENT
        #pragma multi_compile _ LIGHTMAP_ON
        #pragma multi_compile _ DIRLIGHTMAP_COMBINED
        #pragma multi_compile_fragment _ PROBE_VOLUMES_L1 PROBE_VOLUMES_L2
        #pragma multi_compile_raytracing _ PROBE_VOLUMES_L1 PROBE_VOLUMES_L2
        #pragma multi_compile _ DYNAMICLIGHTMAP_ON
        #pragma multi_compile_fragment _ SHADOWS_SHADOWMASK
        #pragma multi_compile_raytracing _ SHADOWS_SHADOWMASK
        #pragma multi_compile_fragment DECALS_OFF DECALS_3RT DECALS_4RT
        #pragma multi_compile_fragment _ DECAL_SURFACE_GRADIENT
        #pragma multi_compile_fragment PUNCTUAL_SHADOW_LOW PUNCTUAL_SHADOW_MEDIUM PUNCTUAL_SHADOW_HIGH
        #pragma multi_compile_fragment DIRECTIONAL_SHADOW_LOW DIRECTIONAL_SHADOW_MEDIUM DIRECTIONAL_SHADOW_HIGH
        #pragma multi_compile_fragment AREA_SHADOW_MEDIUM AREA_SHADOW_HIGH
        #pragma multi_compile_fragment SCREEN_SPACE_SHADOWS_OFF SCREEN_SPACE_SHADOWS_ON
        #pragma multi_compile_fragment USE_FPTL_LIGHTLIST USE_CLUSTERED_LIGHTLIST
        #pragma shader_feature_local _ _REFRACTION_PLANE _REFRACTION_SPHERE _REFRACTION_THIN
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_TRANSMISSION
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_TRANSMISSION
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_ANISOTROPY
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_ANISOTROPY
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_IRIDESCENCE
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_IRIDESCENCE
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_SPECULAR_COLOR
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_SPECULAR_COLOR
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_COLORED_TRANSMISSION
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_COLORED_TRANSMISSION
            // GraphKeywords: <None>
        
            // Defines
            #define SHADERPASS SHADERPASS_FORWARD
        #define SUPPORT_BLENDMODE_PRESERVE_SPECULAR_LIGHTING 1
        #define HAS_LIGHTLOOP 1
        #define RAYTRACING_SHADER_GRAPH_DEFAULT
        #define SHADER_LIT 1
        
            // For custom interpolators to inject a substruct definition before FragInputs definition,
            // allowing for FragInputs to capture CI's intended for ShaderGraph's SDI.
            struct CustomInterpolators
        {
        };
        #define USE_CUSTOMINTERP_SUBSTRUCT
        
        
        
            // TODO: Merge FragInputsVFX substruct with CustomInterpolators.
        	#ifdef HAVE_VFX_MODIFICATION
        	struct FragInputsVFX
            {
                /* WARNING: $splice Could not find named fragment 'FragInputsVFX' */
            };
            #endif
        
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl" // Required by Tessellation.hlsl
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Tessellation.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl" // Required to be include before we include properties as it define DECLARE_STACK_CB
            // Always include Shader Graph version
            // Always include last to avoid double macros
            #include "Packages/com.unity.shadergraph/ShaderGraphLibrary/Functions.hlsl" // Need to be here for Gradient struct definition
        
            // --------------------------------------------------
            // Defines
        
            // Attribute
            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define ATTRIBUTES_NEED_TEXCOORD0
            #define ATTRIBUTES_NEED_TEXCOORD1
            #define ATTRIBUTES_NEED_TEXCOORD2
            #define VARYINGS_NEED_POSITION_WS
            #define VARYINGS_NEED_TANGENT_TO_WORLD
            #define VARYINGS_NEED_TEXCOORD0
            #define VARYINGS_NEED_TEXCOORD1
            #define VARYINGS_NEED_TEXCOORD2
        
            #define HAVE_MESH_MODIFICATION
        
            //Strip down the FragInputs.hlsl (on graphics), so we can only optimize the interpolators we use.
            //if by accident something requests contents of FragInputs.hlsl, it will be caught as a compiler error
            //Frag inputs stripping is only enabled when FRAG_INPUTS_ENABLE_STRIPPING is set
            #if !defined(SHADER_STAGE_RAY_TRACING) && SHADERPASS != SHADERPASS_RAYTRACING_GBUFFER && SHADERPASS != SHADERPASS_FULL_SCREEN_DEBUG
            #define FRAG_INPUTS_ENABLE_STRIPPING
            #endif
            #define FRAG_INPUTS_USE_TEXCOORD0
            #define FRAG_INPUTS_USE_TEXCOORD1
            #define FRAG_INPUTS_USE_TEXCOORD2
        
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
        
        
        
        
            // Following two define are a workaround introduce in 10.1.x for RaytracingQualityNode
            // The ShaderGraph don't support correctly migration of this node as it serialize all the node data
            // in the json file making it impossible to uprgrade. Until we get a fix, we do a workaround here
            // to still allow us to rename the field and keyword of this node without breaking existing code.
            #ifdef RAYTRACING_SHADER_GRAPH_DEFAULT
            #define RAYTRACING_SHADER_GRAPH_HIGH
            #endif
        
            #ifdef RAYTRACING_SHADER_GRAPH_RAYTRACED
            #define RAYTRACING_SHADER_GRAPH_LOW
            #endif
            // end
        
            #ifndef SHADER_UNLIT
            // We need isFrontFace when using double sided - it is not required for unlit as in case of unlit double sided only drive the cullmode
            // VARYINGS_NEED_CULLFACE can be define by VaryingsMeshToPS.FaceSign input if a IsFrontFace Node is included in the shader graph.
            #if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
                #define VARYINGS_NEED_CULLFACE
            #endif
            #endif
        
            // Specific Material Define
        #define _SPECULAR_OCCLUSION_FROM_AO 1
        #define _ENERGY_CONSERVING_SPECULAR 1
        
        #if _MATERIAL_FEATURE_COLORED_TRANSMISSION
            // Colored Transmission doesn't support clear coat
            #undef _MATERIAL_FEATURE_CLEAR_COAT
        #endif
        
        // If we use subsurface scattering, enable output split lighting (for forward pass)
        #if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
            #define OUTPUT_SPLIT_LIGHTING
        #endif
        
        // This shader support recursive rendering for raytracing
        #define HAVE_RECURSIVE_RENDERING
        
        // In Path Tracing, For all single-sided, refractive materials, we want to force a thin refraction model
        #if (SHADERPASS == SHADERPASS_PATH_TRACING) && !defined(_DOUBLESIDED_ON) && (defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE))
            #undef  _REFRACTION_PLANE
            #undef  _REFRACTION_SPHERE
            #define _REFRACTION_THIN
        #endif
            // Caution: we can use the define SHADER_UNLIT onlit after the above Material include as it is the Unlit template who define it
        
            // To handle SSR on transparent correctly with a possibility to enable/disable it per framesettings
            // we should have a code like this:
            // if !defined(_DISABLE_SSR_TRANSPARENT)
            // pragma multi_compile _ WRITE_NORMAL_BUFFER
            // endif
            // i.e we enable the multicompile only if we can receive SSR or not, and then C# code drive
            // it based on if SSR transparent in frame settings and not (and stripper can strip it).
            // this is currently not possible with our current preprocessor as _DISABLE_SSR_TRANSPARENT is a keyword not a define
            // so instead we used this and chose to pay the extra cost of normal write even if SSR transaprent is disabled.
            // Ideally the shader graph generator should handle it but condition below can't be handle correctly for now.
            #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
            #if !defined(_DISABLE_SSR_TRANSPARENT) && !defined(SHADER_UNLIT)
                #define WRITE_NORMAL_BUFFER
            #endif
            #endif
        
            // See Lit.shader
            #if SHADERPASS == SHADERPASS_MOTION_VECTORS && defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)
                #define WRITE_DECAL_BUFFER
            #endif
        
            #ifndef DEBUG_DISPLAY
                // In case of opaque we don't want to perform the alpha test, it is done in depth prepass and we use depth equal for ztest (setup from UI)
                // Don't do it with debug display mode as it is possible there is no depth prepass in this case
                #if !defined(_SURFACE_TYPE_TRANSPARENT)
                    #if SHADERPASS == SHADERPASS_FORWARD
                    #define SHADERPASS_FORWARD_BYPASS_ALPHA_TEST
                    #elif SHADERPASS == SHADERPASS_GBUFFER
                    #define SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST
                    #endif
                #endif
            #endif
        
            // Define _DEFERRED_CAPABLE_MATERIAL for shader capable to run in deferred pass
            #if defined(SHADER_LIT) && !defined(_SURFACE_TYPE_TRANSPARENT)
                #define _DEFERRED_CAPABLE_MATERIAL
            #endif
        
            // Translate transparent motion vector define
            #if (defined(_TRANSPARENT_WRITES_MOTION_VEC) || defined(_TRANSPARENT_REFRACTIVE_SORT)) && defined(_SURFACE_TYPE_TRANSPARENT)
                #define _WRITE_TRANSPARENT_MOTION_VECTOR
            #endif
        
            // -- Graph Properties
            CBUFFER_START(UnityPerMaterial)
        float4 _DiffusionProfileAsset;
        float _DiffusionProfileHash;
        float4 _Texture2D_TexelSize;
        float4 _Albedo;
        float _Smoothness;
        float _WindSpeed;
        float _WindStrength;
        float4 _Normal_TexelSize;
        float _NormalStrength;
        float4 _EmissionColor;
        float _UseShadowThreshold;
        float4 _DoubleSidedConstants;
        float _BlendMode;
        float _EnableBlendModePreserveSpecularLighting;
        float _RayTracing;
        float _RefractionModel;
        float _MaterialID;
        float _MaterialTypeMask;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_Texture2D);
        SAMPLER(sampler_Texture2D);
        TEXTURE2D(_Normal);
        SAMPLER(sampler_Normal);
        
            // -- Property used by ScenePickingPass
            #ifdef SCENEPICKINGPASS
            float4 _SelectionID;
            #endif
        
            // -- Properties used by SceneSelectionPass
            #ifdef SCENESELECTIONPASS
            int _ObjectId;
            int _PassValue;
            #endif
        
            // Includes
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/LightLoop/LightLoopDef.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/LightLoop/LightLoop.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitDecalData.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"
        	// GraphIncludes: <None>
        
            // --------------------------------------------------
            // Structs and Packing
        
            struct AttributesMesh
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
             float4 uv1 : TEXCOORD1;
             float4 uv2 : TEXCOORD2;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct VaryingsMeshToPS
        {
            SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
             float3 positionRWS;
             float3 normalWS;
             float4 tangentWS;
             float4 texCoord0;
             float4 texCoord1;
             float4 texCoord2;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
             float3 WorldSpacePosition;
             float4 uv0;
             float3 TimeParameters;
        };
        struct SurfaceDescriptionInputs
        {
             float3 TangentSpaceNormal;
             float4 uv0;
        };
        struct PackedVaryingsMeshToPS
        {
            SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
             float4 tangentWS : INTERP0;
             float4 texCoord0 : INTERP1;
             float4 texCoord1 : INTERP2;
             float4 texCoord2 : INTERP3;
             float3 positionRWS : INTERP4;
             float3 normalWS : INTERP5;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
        };
        
            PackedVaryingsMeshToPS PackVaryingsMeshToPS (VaryingsMeshToPS input)
        {
            PackedVaryingsMeshToPS output;
            ZERO_INITIALIZE(PackedVaryingsMeshToPS, output);
            output.positionCS = input.positionCS;
            output.tangentWS.xyzw = input.tangentWS;
            output.texCoord0.xyzw = input.texCoord0;
            output.texCoord1.xyzw = input.texCoord1;
            output.texCoord2.xyzw = input.texCoord2;
            output.positionRWS.xyz = input.positionRWS;
            output.normalWS.xyz = input.normalWS;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            return output;
        }
        
        VaryingsMeshToPS UnpackVaryingsMeshToPS (PackedVaryingsMeshToPS input)
        {
            VaryingsMeshToPS output;
            output.positionCS = input.positionCS;
            output.tangentWS = input.tangentWS.xyzw;
            output.texCoord0 = input.texCoord0.xyzw;
            output.texCoord1 = input.texCoord1.xyzw;
            output.texCoord2 = input.texCoord2.xyzw;
            output.positionRWS = input.positionRWS.xyz;
            output.normalWS = input.normalWS.xyz;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            return output;
        }
        
        
            // --------------------------------------------------
            // Graph
        
        
            // Graph Functions
            
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_Sine_float(float In, out float Out)
        {
            Out = sin(In);
        }
        
        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }
        
        void Unity_Multiply_float4_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }
        
            // Graph Vertex
            struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            float _Property_8c596e62dce249caa7922ff3d7470d43_Out_0_Float = _WindSpeed;
            float _Split_35af25740d5a404097ccb209d36d5cac_R_1_Float = IN.WorldSpacePosition[0];
            float _Split_35af25740d5a404097ccb209d36d5cac_G_2_Float = IN.WorldSpacePosition[1];
            float _Split_35af25740d5a404097ccb209d36d5cac_B_3_Float = IN.WorldSpacePosition[2];
            float _Split_35af25740d5a404097ccb209d36d5cac_A_4_Float = 0;
            float _Add_c678bc9d08684d01a8e45ad5e636b4b4_Out_2_Float;
            Unity_Add_float(_Split_35af25740d5a404097ccb209d36d5cac_R_1_Float, _Split_35af25740d5a404097ccb209d36d5cac_B_3_Float, _Add_c678bc9d08684d01a8e45ad5e636b4b4_Out_2_Float);
            float _Add_0ec2f296c670483e9dc4250c81fe62a0_Out_2_Float;
            Unity_Add_float(IN.TimeParameters.x, _Add_c678bc9d08684d01a8e45ad5e636b4b4_Out_2_Float, _Add_0ec2f296c670483e9dc4250c81fe62a0_Out_2_Float);
            float _Multiply_ce5f4784040b450499733beaca915393_Out_2_Float;
            Unity_Multiply_float_float(_Property_8c596e62dce249caa7922ff3d7470d43_Out_0_Float, _Add_0ec2f296c670483e9dc4250c81fe62a0_Out_2_Float, _Multiply_ce5f4784040b450499733beaca915393_Out_2_Float);
            float _Sine_3c81889fed534b52996b5063cdc22296_Out_1_Float;
            Unity_Sine_float(_Multiply_ce5f4784040b450499733beaca915393_Out_2_Float, _Sine_3c81889fed534b52996b5063cdc22296_Out_1_Float);
            float _Property_3cdd281375794ed2bcad3550a9c890af_Out_0_Float = _WindStrength;
            float _Multiply_89ad4329fdd44befb161e56947c2670b_Out_2_Float;
            Unity_Multiply_float_float(_Sine_3c81889fed534b52996b5063cdc22296_Out_1_Float, _Property_3cdd281375794ed2bcad3550a9c890af_Out_0_Float, _Multiply_89ad4329fdd44befb161e56947c2670b_Out_2_Float);
            float4 _UV_30b55575e9844728bc3abbcaf84a22ff_Out_0_Vector4 = IN.uv0;
            float _Split_020d1040f8544c0b9d3de77e7fbd9197_R_1_Float = _UV_30b55575e9844728bc3abbcaf84a22ff_Out_0_Vector4[0];
            float _Split_020d1040f8544c0b9d3de77e7fbd9197_G_2_Float = _UV_30b55575e9844728bc3abbcaf84a22ff_Out_0_Vector4[1];
            float _Split_020d1040f8544c0b9d3de77e7fbd9197_B_3_Float = _UV_30b55575e9844728bc3abbcaf84a22ff_Out_0_Vector4[2];
            float _Split_020d1040f8544c0b9d3de77e7fbd9197_A_4_Float = _UV_30b55575e9844728bc3abbcaf84a22ff_Out_0_Vector4[3];
            float _Multiply_17088dc811eb45e4a333912f99b556ec_Out_2_Float;
            Unity_Multiply_float_float(_Multiply_89ad4329fdd44befb161e56947c2670b_Out_2_Float, _Split_020d1040f8544c0b9d3de77e7fbd9197_G_2_Float, _Multiply_17088dc811eb45e4a333912f99b556ec_Out_2_Float);
            float3 _Add_e473a1f67cd1441b9fccfb91c0b5ff75_Out_2_Vector3;
            Unity_Add_float3(IN.WorldSpacePosition, (_Multiply_17088dc811eb45e4a333912f99b556ec_Out_2_Float.xxx), _Add_e473a1f67cd1441b9fccfb91c0b5ff75_Out_2_Vector3);
            float3 _Add_8e06eedaa53749dea4ffc85b774f63ee_Out_2_Vector3;
            Unity_Add_float3(float3(0, 0, 0), _Add_e473a1f67cd1441b9fccfb91c0b5ff75_Out_2_Vector3, _Add_8e06eedaa53749dea4ffc85b774f63ee_Out_2_Vector3);
            float3 _Transform_78fa02a50d4c495cba1111966696417e_Out_1_Vector3;
            _Transform_78fa02a50d4c495cba1111966696417e_Out_1_Vector3 = TransformWorldToObject(_Add_8e06eedaa53749dea4ffc85b774f63ee_Out_2_Vector3.xyz);
            description.Position = _Transform_78fa02a50d4c495cba1111966696417e_Out_1_Vector3;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
            // Graph Pixel
            struct SurfaceDescription
        {
            float3 BaseColor;
            float3 Emission;
            float Alpha;
            float AlphaClipThreshold;
            float3 BentNormal;
            float Smoothness;
            float Occlusion;
            float3 NormalTS;
            float TransmissionMask;
            float Thickness;
            float DiffusionProfileHash;
            float4 VTPackedFeedback;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float4 _Property_35c125abbbcb46e1a2351d8febeb5da1_Out_0_Vector4 = _Albedo;
            UnityTexture2D _Property_bb313b600ca3404fb88a2820878a8482_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Texture2D);
            float4 _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_bb313b600ca3404fb88a2820878a8482_Out_0_Texture2D.tex, _Property_bb313b600ca3404fb88a2820878a8482_Out_0_Texture2D.samplerstate, _Property_bb313b600ca3404fb88a2820878a8482_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_R_4_Float = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4.r;
            float _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_G_5_Float = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4.g;
            float _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_B_6_Float = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4.b;
            float _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_A_7_Float = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4.a;
            float4 _Multiply_c09cca22f04c4a9a996a5ccf8f61afe1_Out_2_Vector4;
            Unity_Multiply_float4_float4(_Property_35c125abbbcb46e1a2351d8febeb5da1_Out_0_Vector4, _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4, _Multiply_c09cca22f04c4a9a996a5ccf8f61afe1_Out_2_Vector4);
            float _Property_925f8cb589d94edda2dcd6b588187f26_Out_0_Float = _Smoothness;
            float _Multiply_a061075fe3794cc5abff5f173997f7f8_Out_2_Float;
            Unity_Multiply_float_float(_Property_925f8cb589d94edda2dcd6b588187f26_Out_0_Float, _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_G_5_Float, _Multiply_a061075fe3794cc5abff5f173997f7f8_Out_2_Float);
            UnityTexture2D _Property_ff2eff189fa74f1f965ec8aca53205ba_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Normal);
            float4 _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_ff2eff189fa74f1f965ec8aca53205ba_Out_0_Texture2D.tex, _Property_ff2eff189fa74f1f965ec8aca53205ba_Out_0_Texture2D.samplerstate, _Property_ff2eff189fa74f1f965ec8aca53205ba_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.rgb = UnpackNormal(_SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4);
            float _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_R_4_Float = _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.r;
            float _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_G_5_Float = _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.g;
            float _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_B_6_Float = _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.b;
            float _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_A_7_Float = _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.a;
            float _Property_915c3b0b5fc04c668c646f2f67b5ab2b_Out_0_Float = _NormalStrength;
            float4 _Multiply_e38eea28614c4b61bfd135ec8591a746_Out_2_Vector4;
            Unity_Multiply_float4_float4(_SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4, (_Property_915c3b0b5fc04c668c646f2f67b5ab2b_Out_0_Float.xxxx), _Multiply_e38eea28614c4b61bfd135ec8591a746_Out_2_Vector4);
            surface.BaseColor = (_Multiply_c09cca22f04c4a9a996a5ccf8f61afe1_Out_2_Vector4.xyz);
            surface.Emission = float3(0, 0, 0);
            surface.Alpha = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_A_7_Float;
            surface.AlphaClipThreshold = 0.5;
            surface.BentNormal = IN.TangentSpaceNormal;
            surface.Smoothness = _Multiply_a061075fe3794cc5abff5f173997f7f8_Out_2_Float;
            surface.Occlusion = 1;
            surface.NormalTS = (_Multiply_e38eea28614c4b61bfd135ec8591a746_Out_2_Vector4.xyz);
            surface.TransmissionMask = 1;
            surface.Thickness = 1;
            surface.DiffusionProfileHash = _DiffusionProfileHash;
            {
                surface.VTPackedFeedback = float4(1.0f,1.0f,1.0f,1.0f);
            }
            return surface;
        }
        
            // --------------------------------------------------
            // Build Graph Inputs
            #ifdef HAVE_VFX_MODIFICATION
            #define VFX_SRP_ATTRIBUTES AttributesMesh
            #define VaryingsMeshType VaryingsMeshToPS
            #define VFX_SRP_VARYINGS VaryingsMeshType
            #define VFX_SRP_SURFACE_INPUTS FragInputs
            #endif
            
        VertexDescriptionInputs AttributesMeshToVertexDescriptionInputs(AttributesMesh input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
            output.WorldSpacePosition =                         TransformObjectToWorld(input.positionOS);
            output.uv0 =                                        input.uv0;
            output.TimeParameters =                             _TimeParameters.xyz; // Note: in case of animation this will be overwrite (allow to handle motion vector)
        
            return output;
        }
        
        VertexDescription GetVertexDescription(AttributesMesh input, float3 timeParameters
        #ifdef HAVE_VFX_MODIFICATION
            , AttributesElement element
        #endif
        )
        {
            // build graph inputs
            VertexDescriptionInputs vertexDescriptionInputs = AttributesMeshToVertexDescriptionInputs(input);
            // Override time parameters with used one (This is required to correctly handle motion vectors for vertex animation based on time)
            vertexDescriptionInputs.TimeParameters = timeParameters;
        
            // evaluate vertex graph
        #ifdef HAVE_VFX_MODIFICATION
            GraphProperties properties;
            ZERO_INITIALIZE(GraphProperties, properties);
        
            // Fetch the vertex graph properties for the particle instance.
            GetElementVertexProperties(element, properties);
        
            VertexDescription vertexDescription = VertexDescriptionFunction(vertexDescriptionInputs, properties);
        #else
            VertexDescription vertexDescription = VertexDescriptionFunction(vertexDescriptionInputs);
        #endif
            return vertexDescription;
        
        }
        
        AttributesMesh ApplyMeshModification(AttributesMesh input, float3 timeParameters
        #ifdef USE_CUSTOMINTERP_SUBSTRUCT
            #ifdef TESSELLATION_ON
            , inout VaryingsMeshToDS varyings
            #else
            , inout VaryingsMeshToPS varyings
            #endif
        #endif
        #ifdef HAVE_VFX_MODIFICATION
                , AttributesElement element
        #endif
            )
        {
            VertexDescription vertexDescription = GetVertexDescription(input, timeParameters
        #ifdef HAVE_VFX_MODIFICATION
                , element
        #endif
            );
        
            // copy graph output to the results
            input.positionOS = vertexDescription.Position;
            input.normalOS = vertexDescription.Normal;
            input.tangentOS.xyz = vertexDescription.Tangent;
        
            
        
            return input;
        }
        
        #if defined(_ADD_CUSTOM_VELOCITY) // For shader graph custom velocity
        // Return precomputed Velocity in object space
        float3 GetCustomVelocity(AttributesMesh input
        #ifdef HAVE_VFX_MODIFICATION
            , AttributesElement element
        #endif
        )
        {
            VertexDescription vertexDescription = GetVertexDescription(input, _TimeParameters.xyz
        #ifdef HAVE_VFX_MODIFICATION
                , element
        #endif
            );
            return vertexDescription.CustomVelocity;
        }
        #endif
        
        FragInputs BuildFragInputs(VaryingsMeshToPS input)
        {
            FragInputs output;
            ZERO_INITIALIZE(FragInputs, output);
        
            // Init to some default value to make the computer quiet (else it output 'divide by zero' warning even if value is not used).
            // TODO: this is a really poor workaround, but the variable is used in a bunch of places
            // to compute normals which are then passed on elsewhere to compute other values...
            output.tangentToWorld = k_identity3x3;
            output.positionSS = input.positionCS;       // input.positionCS is SV_Position
        
            output.positionRWS =                input.positionRWS;
            output.tangentToWorld =             BuildTangentToWorld(input.tangentWS, input.normalWS);
            output.texCoord0 =                  input.texCoord0;
            output.texCoord1 =                  input.texCoord1;
            output.texCoord2 =                  input.texCoord2;
        
        
        #ifdef HAVE_VFX_MODIFICATION
            // FragInputs from VFX come from two places: Interpolator or CBuffer.
        #if VFX_USE_GRAPH_VALUES
            uint instanceActiveIndex = asuint(UNITY_ACCESS_INSTANCED_PROP(PerInstance, _InstanceActiveIndex));
            /* WARNING: $splice Could not find named fragment 'VFXLoadGraphValues' */
        #endif
        
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            // splice point to copy custom interpolator fields from varyings to frag inputs
            
        
            return output;
        }
        
        // existing HDRP code uses the combined function to go directly from packed to frag inputs
        FragInputs UnpackVaryingsMeshToFragInputs(PackedVaryingsMeshToPS input)
        {
            UNITY_SETUP_INSTANCE_ID(input);
        #if defined(HAVE_VFX_MODIFICATION) && defined(UNITY_INSTANCING_ENABLED)
            unity_InstanceID = input.instanceID;
        #endif
            VaryingsMeshToPS unpacked = UnpackVaryingsMeshToPS(input);
            return BuildFragInputs(unpacked);
        }
            SurfaceDescriptionInputs FragInputsToSurfaceDescriptionInputs(FragInputs input, float3 viewWS)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
            #if defined(SHADER_STAGE_RAY_TRACING)
            #else
            #endif
            output.TangentSpaceNormal =                         float3(0.0f, 0.0f, 1.0f);
        
        #if UNITY_UV_STARTS_AT_TOP
        #else
        #endif
        
        
            output.uv0 =                                        input.texCoord0;
        
            // splice point to copy frag inputs custom interpolator pack into the SDI
            
        
            return output;
        }
        
            // --------------------------------------------------
            // Build Surface Data (Specific Material)
        
        void ApplyDecalToSurfaceDataNoNormal(DecalSurfaceData decalSurfaceData, inout SurfaceData surfaceData);
        
        void ApplyDecalAndGetNormal(FragInputs fragInputs, PositionInputs posInput, SurfaceDescription surfaceDescription,
            inout SurfaceData surfaceData)
        {
            float3 doubleSidedConstants = GetDoubleSidedConstants();
        
        #ifdef DECAL_NORMAL_BLENDING
            // SG nodes don't ouptut surface gradients, so if decals require surf grad blending, we have to convert
            // the normal to gradient before applying the decal. We then have to resolve the gradient back to world space
            float3 normalTS;
        
            normalTS = SurfaceGradientFromTangentSpaceNormalAndFromTBN(surfaceDescription.NormalTS,
            fragInputs.tangentToWorld[0], fragInputs.tangentToWorld[1]);
        
        
            #if HAVE_DECALS
            if (_EnableDecals)
            {
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                ApplyDecalToSurfaceNormal(decalSurfaceData, fragInputs.tangentToWorld[2], normalTS);
                ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
            }
            #endif
        
            GetNormalWS_SG(fragInputs, normalTS, surfaceData.normalWS, doubleSidedConstants);
        #else
            // normal delivered to master node
            GetNormalWS(fragInputs, surfaceDescription.NormalTS, surfaceData.normalWS, doubleSidedConstants);
        
            #if HAVE_DECALS
            if (_EnableDecals)
            {
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                // Both uses and modifies 'surfaceData.normalWS'.
                DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                ApplyDecalToSurfaceNormal(decalSurfaceData, surfaceData.normalWS.xyz);
                ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
            }
            #endif
        #endif
        }
        void BuildSurfaceData(FragInputs fragInputs, inout SurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
        {
            ZERO_INITIALIZE(SurfaceData, surfaceData);
        
            // specularOcclusion need to be init ahead of decal to quiet the compiler that modify the SurfaceData struct
            // however specularOcclusion can come from the graph, so need to be init here so it can be override.
            surfaceData.specularOcclusion = 1.0;
            surfaceData.thickness = 0.0;
        
            surfaceData.baseColor =                 surfaceDescription.BaseColor;
            surfaceData.perceptualSmoothness =      surfaceDescription.Smoothness;
            surfaceData.ambientOcclusion =          surfaceDescription.Occlusion;
            surfaceData.transmissionMask =          surfaceDescription.TransmissionMask.xxx;
            surfaceData.thickness =                 surfaceDescription.Thickness;
            surfaceData.diffusionProfileHash =      asuint(surfaceDescription.DiffusionProfileHash);
        
            #if defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE) || defined(_REFRACTION_THIN)
                if (_EnableSSRefraction)
                {
        
                    surfaceData.transmittanceMask = (1.0 - surfaceDescription.Alpha);
                    surfaceDescription.Alpha = 1.0;
                }
                else
                {
                    surfaceData.ior = 1.0;
                    surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                    surfaceData.atDistance = 1.0;
                    surfaceData.transmittanceMask = 0.0;
                    surfaceDescription.Alpha = 1.0;
                }
            #else
                surfaceData.ior = 1.0;
                surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                surfaceData.atDistance = 1.0;
                surfaceData.transmittanceMask = 0.0;
            #endif
        
            // These static material feature allow compile time optimization
            surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;
            #ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
            #endif
        
            #ifdef _MATERIAL_FEATURE_TRANSMISSION
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
            #endif
        
            #ifdef _MATERIAL_FEATURE_COLORED_TRANSMISSION
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_COLORED_TRANSMISSION;
        
            #endif
        
            #ifdef _MATERIAL_FEATURE_ANISOTROPY
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
        
                // Initialize the normal to something non-zero to avoid a div-zero warning for anisotropy.
                surfaceData.normalWS = float3(0, 1, 0);
            #endif
        
            #ifdef _MATERIAL_FEATURE_IRIDESCENCE
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
            #endif
        
            #ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
            #endif
        
            #ifdef _MATERIAL_FEATURE_CLEAR_COAT
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
            #endif
        
            #if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
                // Require to have setup baseColor
                // Reproduce the energy conservation done in legacy Unity. Not ideal but better for compatibility and users can unchek it
                surfaceData.baseColor *= (1.0 - Max3(surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b));
            #endif
        
            float3 doubleSidedConstants = GetDoubleSidedConstants();
        
            ApplyDecalAndGetNormal(fragInputs, posInput, surfaceDescription, surfaceData);
        
            surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];
        
            surfaceData.tangentWS = normalize(fragInputs.tangentToWorld[0].xyz);    // The tangent is not normalize in tangentToWorld for mikkt. TODO: Check if it expected that we normalize with Morten. Tag: SURFACE_GRADIENT
        
        
            bentNormalWS = surfaceData.normalWS;
        
            surfaceData.tangentWS = Orthonormalize(surfaceData.tangentWS, surfaceData.normalWS);
        
            #ifdef DEBUG_DISPLAY
                if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
                {
                    // TODO: need to update mip info
                    surfaceData.metallic = 0;
                }
        
                // We need to call ApplyDebugToSurfaceData after filling the surfarcedata and before filling builtinData
                // as it can modify attribute use for static lighting
                ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData);
            #endif
        
            // By default we use the ambient occlusion with Tri-ace trick (apply outside) for specular occlusion.
            // If user provide bent normal then we process a better term
            #if defined(_SPECULAR_OCCLUSION_CUSTOM)
                // Just use the value passed through via the slot (not active otherwise)
            #elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
                // If we have bent normal and ambient occlusion, process a specular occlusion
                surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO(V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness(surfaceData.perceptualSmoothness));
            #elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
                surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion(ClampNdotV(dot(surfaceData.normalWS, V)), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness(surfaceData.perceptualSmoothness));
            #endif
        
            #if defined(_ENABLE_GEOMETRIC_SPECULAR_AA) && !defined(SHADER_STAGE_RAY_TRACING)
                surfaceData.perceptualSmoothness = GeometricNormalFiltering(surfaceData.perceptualSmoothness, fragInputs.tangentToWorld[2], surfaceDescription.SpecularAAScreenSpaceVariance, surfaceDescription.SpecularAAThreshold);
            #endif
        }
        
            // --------------------------------------------------
            // Get Surface And BuiltinData
        
            void GetSurfaceAndBuiltinData(FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData RAY_TRACING_OPTIONAL_PARAMETERS)
            {
                // Don't dither if displaced tessellation (we're fading out the displacement instead to match the next LOD)
                #if !defined(SHADER_STAGE_RAY_TRACING) && !defined(_TESSELLATION_DISPLACEMENT)
                #ifdef LOD_FADE_CROSSFADE // enable dithering LOD transition if user select CrossFade transition in LOD group
                LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
                #endif
                #endif
        
                #ifndef SHADER_UNLIT
                #ifdef _DOUBLESIDED_ON
                    float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
                #else
                    float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
                #endif
        
                ApplyDoubleSidedFlipOrMirror(fragInputs, doubleSidedConstants); // Apply double sided flip on the vertex normal
                #endif // SHADER_UNLIT
        
                SurfaceDescriptionInputs surfaceDescriptionInputs = FragInputsToSurfaceDescriptionInputs(fragInputs, V);
        
                #if defined(HAVE_VFX_MODIFICATION)
                GraphProperties properties;
                ZERO_INITIALIZE(GraphProperties, properties);
        
                GetElementPixelProperties(fragInputs, properties);
        
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs, properties);
                #else
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs);
                #endif
        
                // Perform alpha test very early to save performance (a killed pixel will not sample textures)
                // TODO: split graph evaluation to grab just alpha dependencies first? tricky..
                #ifdef _ALPHATEST_ON
                    float alphaCutoff = surfaceDescription.AlphaClipThreshold;
                    #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
                    // The TransparentDepthPrepass is also used with SSR transparent.
                    // If an artists enable transaprent SSR but not the TransparentDepthPrepass itself, then we use AlphaClipThreshold
                    // otherwise if TransparentDepthPrepass is enabled we use AlphaClipThresholdDepthPrepass
                    #elif SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_POSTPASS
                    // DepthPostpass always use its own alpha threshold
                    alphaCutoff = surfaceDescription.AlphaClipThresholdDepthPostpass;
                    #elif (SHADERPASS == SHADERPASS_SHADOWS) || (SHADERPASS == SHADERPASS_RAYTRACING_VISIBILITY)
                    // If use shadow threshold isn't enable we don't allow any test
                    #endif
        
                    GENERIC_ALPHA_TEST(surfaceDescription.Alpha, alphaCutoff);
                #endif
        
                #if !defined(SHADER_STAGE_RAY_TRACING) && _DEPTHOFFSET_ON
                ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
                #endif
        
                #ifndef SHADER_UNLIT
                float3 bentNormalWS;
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS);
        
                #ifdef FRAG_INPUTS_USE_TEXCOORD1
                    float4 lightmapTexCoord1 = fragInputs.texCoord1;
                #else
                    float4 lightmapTexCoord1 = float4(0,0,0,0);
                #endif
        
                #ifdef FRAG_INPUTS_USE_TEXCOORD2
                    float4 lightmapTexCoord2 = fragInputs.texCoord2;
                #else
                    float4 lightmapTexCoord2 = float4(0,0,0,0);
                #endif
        
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                // Builtin Data
                // For back lighting we use the oposite vertex normal
                InitBuiltinData(posInput, alpha, bentNormalWS, -fragInputs.tangentToWorld[2], lightmapTexCoord1, lightmapTexCoord2, builtinData);
        
                #else
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData);
        
                ZERO_BUILTIN_INITIALIZE(builtinData); // No call to InitBuiltinData as we don't have any lighting
                builtinData.opacity = surfaceDescription.Alpha;
        
                #if defined(DEBUG_DISPLAY)
                    // Light Layers are currently not used for the Unlit shader (because it is not lit)
                    // But Unlit objects do cast shadows according to their rendering layer mask, which is what we want to
                    // display in the light layers visualization mode, therefore we need the renderingLayers
                    builtinData.renderingLayers = GetMeshRenderingLayerMask();
                #endif
        
                #endif // SHADER_UNLIT
        
                #ifdef _ALPHATEST_ON
                    // Used for sharpening by alpha to mask - Alpha to covertage is only used with depth only and forward pass (no shadow pass, no transparent pass)
                    builtinData.alphaClipTreshold = alphaCutoff;
                #endif
        
                // override sampleBakedGI - not used by Unlit
        		// When overriding GI, we need to force the isLightmap flag to make sure we don't add APV (sampled in the lightloop) on top of the overridden value (set at GBuffer stage)
        
                builtinData.emissiveColor = surfaceDescription.Emission;
        
                // Note this will not fully work on transparent surfaces (can check with _SURFACE_TYPE_TRANSPARENT define)
                // We will always overwrite vt feeback with the nearest. So behind transparent surfaces vt will not be resolved
                // This is a limitation of the current MRT approach.
                #ifdef UNITY_VIRTUAL_TEXTURING
                builtinData.vtPackedFeedback = surfaceDescription.VTPackedFeedback;
                #endif
        
                #if _DEPTHOFFSET_ON
                builtinData.depthOffset = surfaceDescription.DepthOffset;
                #endif
        
                // TODO: We should generate distortion / distortionBlur for non distortion pass
                #if (SHADERPASS == SHADERPASS_DISTORTION)
                builtinData.distortion = surfaceDescription.Distortion;
                builtinData.distortionBlur = surfaceDescription.DistortionBlur;
                #endif
        
                #ifndef SHADER_UNLIT
                // PostInitBuiltinData call ApplyDebugToBuiltinData
                PostInitBuiltinData(V, posInput, surfaceData, builtinData);
                #else
                ApplyDebugToBuiltinData(builtinData);
                #endif
        
                RAY_TRACING_OPTIONAL_ALPHA_TEST_PASS
            }
        
            // --------------------------------------------------
            // Main
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPassForward.hlsl"
        
            // --------------------------------------------------
            // Visual Effect Vertex Invocations
        
        	#ifdef HAVE_VFX_MODIFICATION
                #if !defined(SHADER_STAGE_RAY_TRACING)
        	    #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/VisualEffectVertex.hlsl"
                #else
                #endif
        	#endif
        
            #include "Assets/VegetationInstancer/Shaders/Include/GPUInstancedIndirectInclude.cginc"
#pragma instancing_options procedural:setupGPUInstancedIndirect
#pragma multi_compile_instancing
ENDHLSL
        }
        Pass
        {
            Name "RayTracingPrepass"
            Tags
            {
                "LightMode" = "RayTracingPrepass"
            }
        
            // Render State
            Cull [_CullMode]
        Blend One Zero
        ZWrite On
        
            // Debug
            // <None>
        
            // --------------------------------------------------
            // Pass
        
            HLSLPROGRAM
        
            // Pragmas
            #pragma target 4.5
        #pragma vertex Vert
        #pragma fragment Frag
        #pragma only_renderers d3d11 playstation xboxone xboxseries vulkan metal switch
        
        
            // Keywords
            #pragma shader_feature_local _ _ALPHATEST_ON
        #pragma shader_feature _ _SURFACE_TYPE_TRANSPARENT
        #pragma shader_feature_local _ _DOUBLESIDED_ON
        #pragma shader_feature_local _ _ADD_PRECOMPUTED_VELOCITY
        #pragma shader_feature_local _ _TRANSPARENT_WRITES_MOTION_VEC _TRANSPARENT_REFRACTIVE_SORT
        #pragma shader_feature_local_fragment _ _ENABLE_FOG_ON_TRANSPARENT
        #pragma shader_feature_local_fragment _ _DISABLE_DECALS
        #pragma shader_feature_local_raytracing _ _DISABLE_DECALS
        #pragma shader_feature_local_fragment _ _DISABLE_SSR
        #pragma shader_feature_local_raytracing _ _DISABLE_SSR
        #pragma shader_feature_local_fragment _ _DISABLE_SSR_TRANSPARENT
        #pragma shader_feature_local_raytracing _ _DISABLE_SSR_TRANSPARENT
        #pragma shader_feature_local _ _REFRACTION_PLANE _REFRACTION_SPHERE _REFRACTION_THIN
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_TRANSMISSION
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_TRANSMISSION
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_ANISOTROPY
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_ANISOTROPY
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_IRIDESCENCE
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_IRIDESCENCE
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_SPECULAR_COLOR
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_SPECULAR_COLOR
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_COLORED_TRANSMISSION
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_COLORED_TRANSMISSION
            // GraphKeywords: <None>
        
            // Defines
            #define SHADERPASS SHADERPASS_CONSTANT
        #define RAYTRACING_SHADER_GRAPH_DEFAULT
        
            // For custom interpolators to inject a substruct definition before FragInputs definition,
            // allowing for FragInputs to capture CI's intended for ShaderGraph's SDI.
            struct CustomInterpolators
        {
        };
        #define USE_CUSTOMINTERP_SUBSTRUCT
        
        
        
            // TODO: Merge FragInputsVFX substruct with CustomInterpolators.
        	#ifdef HAVE_VFX_MODIFICATION
        	struct FragInputsVFX
            {
                /* WARNING: $splice Could not find named fragment 'FragInputsVFX' */
            };
            #endif
        
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl" // Required by Tessellation.hlsl
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Tessellation.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl" // Required to be include before we include properties as it define DECLARE_STACK_CB
            // Always include Shader Graph version
            // Always include last to avoid double macros
            #include "Packages/com.unity.shadergraph/ShaderGraphLibrary/Functions.hlsl" // Need to be here for Gradient struct definition
        
            // --------------------------------------------------
            // Defines
        
            // Attribute
            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define ATTRIBUTES_NEED_TEXCOORD0
            #define VARYINGS_NEED_TEXCOORD0
        
            #define HAVE_MESH_MODIFICATION
        
            //Strip down the FragInputs.hlsl (on graphics), so we can only optimize the interpolators we use.
            //if by accident something requests contents of FragInputs.hlsl, it will be caught as a compiler error
            //Frag inputs stripping is only enabled when FRAG_INPUTS_ENABLE_STRIPPING is set
            #if !defined(SHADER_STAGE_RAY_TRACING) && SHADERPASS != SHADERPASS_RAYTRACING_GBUFFER && SHADERPASS != SHADERPASS_FULL_SCREEN_DEBUG
            #define FRAG_INPUTS_ENABLE_STRIPPING
            #endif
            #define FRAG_INPUTS_USE_TEXCOORD0
        
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
        
        
        
        
            // Following two define are a workaround introduce in 10.1.x for RaytracingQualityNode
            // The ShaderGraph don't support correctly migration of this node as it serialize all the node data
            // in the json file making it impossible to uprgrade. Until we get a fix, we do a workaround here
            // to still allow us to rename the field and keyword of this node without breaking existing code.
            #ifdef RAYTRACING_SHADER_GRAPH_DEFAULT
            #define RAYTRACING_SHADER_GRAPH_HIGH
            #endif
        
            #ifdef RAYTRACING_SHADER_GRAPH_RAYTRACED
            #define RAYTRACING_SHADER_GRAPH_LOW
            #endif
            // end
        
            #ifndef SHADER_UNLIT
            // We need isFrontFace when using double sided - it is not required for unlit as in case of unlit double sided only drive the cullmode
            // VARYINGS_NEED_CULLFACE can be define by VaryingsMeshToPS.FaceSign input if a IsFrontFace Node is included in the shader graph.
            #if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
                #define VARYINGS_NEED_CULLFACE
            #endif
            #endif
        
            // Specific Material Define
        #define _SPECULAR_OCCLUSION_FROM_AO 1
        #define _ENERGY_CONSERVING_SPECULAR 1
        
        #if _MATERIAL_FEATURE_COLORED_TRANSMISSION
            // Colored Transmission doesn't support clear coat
            #undef _MATERIAL_FEATURE_CLEAR_COAT
        #endif
        
        // If we use subsurface scattering, enable output split lighting (for forward pass)
        #if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
            #define OUTPUT_SPLIT_LIGHTING
        #endif
        
        // This shader support recursive rendering for raytracing
        #define HAVE_RECURSIVE_RENDERING
        
        // In Path Tracing, For all single-sided, refractive materials, we want to force a thin refraction model
        #if (SHADERPASS == SHADERPASS_PATH_TRACING) && !defined(_DOUBLESIDED_ON) && (defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE))
            #undef  _REFRACTION_PLANE
            #undef  _REFRACTION_SPHERE
            #define _REFRACTION_THIN
        #endif
            // Caution: we can use the define SHADER_UNLIT onlit after the above Material include as it is the Unlit template who define it
        
            // To handle SSR on transparent correctly with a possibility to enable/disable it per framesettings
            // we should have a code like this:
            // if !defined(_DISABLE_SSR_TRANSPARENT)
            // pragma multi_compile _ WRITE_NORMAL_BUFFER
            // endif
            // i.e we enable the multicompile only if we can receive SSR or not, and then C# code drive
            // it based on if SSR transparent in frame settings and not (and stripper can strip it).
            // this is currently not possible with our current preprocessor as _DISABLE_SSR_TRANSPARENT is a keyword not a define
            // so instead we used this and chose to pay the extra cost of normal write even if SSR transaprent is disabled.
            // Ideally the shader graph generator should handle it but condition below can't be handle correctly for now.
            #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
            #if !defined(_DISABLE_SSR_TRANSPARENT) && !defined(SHADER_UNLIT)
                #define WRITE_NORMAL_BUFFER
            #endif
            #endif
        
            // See Lit.shader
            #if SHADERPASS == SHADERPASS_MOTION_VECTORS && defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)
                #define WRITE_DECAL_BUFFER
            #endif
        
            #ifndef DEBUG_DISPLAY
                // In case of opaque we don't want to perform the alpha test, it is done in depth prepass and we use depth equal for ztest (setup from UI)
                // Don't do it with debug display mode as it is possible there is no depth prepass in this case
                #if !defined(_SURFACE_TYPE_TRANSPARENT)
                    #if SHADERPASS == SHADERPASS_FORWARD
                    #define SHADERPASS_FORWARD_BYPASS_ALPHA_TEST
                    #elif SHADERPASS == SHADERPASS_GBUFFER
                    #define SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST
                    #endif
                #endif
            #endif
        
            // Define _DEFERRED_CAPABLE_MATERIAL for shader capable to run in deferred pass
            #if defined(SHADER_LIT) && !defined(_SURFACE_TYPE_TRANSPARENT)
                #define _DEFERRED_CAPABLE_MATERIAL
            #endif
        
            // Translate transparent motion vector define
            #if (defined(_TRANSPARENT_WRITES_MOTION_VEC) || defined(_TRANSPARENT_REFRACTIVE_SORT)) && defined(_SURFACE_TYPE_TRANSPARENT)
                #define _WRITE_TRANSPARENT_MOTION_VECTOR
            #endif
        
            // -- Graph Properties
            CBUFFER_START(UnityPerMaterial)
        float4 _DiffusionProfileAsset;
        float _DiffusionProfileHash;
        float4 _Texture2D_TexelSize;
        float4 _Albedo;
        float _Smoothness;
        float _WindSpeed;
        float _WindStrength;
        float4 _Normal_TexelSize;
        float _NormalStrength;
        float4 _EmissionColor;
        float _UseShadowThreshold;
        float4 _DoubleSidedConstants;
        float _BlendMode;
        float _EnableBlendModePreserveSpecularLighting;
        float _RayTracing;
        float _RefractionModel;
        float _MaterialID;
        float _MaterialTypeMask;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_Texture2D);
        SAMPLER(sampler_Texture2D);
        TEXTURE2D(_Normal);
        SAMPLER(sampler_Normal);
        
            // -- Property used by ScenePickingPass
            #ifdef SCENEPICKINGPASS
            float4 _SelectionID;
            #endif
        
            // -- Properties used by SceneSelectionPass
            #ifdef SCENESELECTIONPASS
            int _ObjectId;
            int _PassValue;
            #endif
        
            // Includes
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitDecalData.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"
        	// GraphIncludes: <None>
        
            // --------------------------------------------------
            // Structs and Packing
        
            struct AttributesMesh
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct VaryingsMeshToPS
        {
            SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
             float4 texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
             float3 WorldSpacePosition;
             float4 uv0;
             float3 TimeParameters;
        };
        struct SurfaceDescriptionInputs
        {
             float3 TangentSpaceNormal;
             float4 uv0;
        };
        struct PackedVaryingsMeshToPS
        {
            SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
             float4 texCoord0 : INTERP0;
            #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
        };
        
            PackedVaryingsMeshToPS PackVaryingsMeshToPS (VaryingsMeshToPS input)
        {
            PackedVaryingsMeshToPS output;
            ZERO_INITIALIZE(PackedVaryingsMeshToPS, output);
            output.positionCS = input.positionCS;
            output.texCoord0.xyzw = input.texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            return output;
        }
        
        VaryingsMeshToPS UnpackVaryingsMeshToPS (PackedVaryingsMeshToPS input)
        {
            VaryingsMeshToPS output;
            output.positionCS = input.positionCS;
            output.texCoord0 = input.texCoord0.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            return output;
        }
        
        
            // --------------------------------------------------
            // Graph
        
        
            // Graph Functions
            
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_Sine_float(float In, out float Out)
        {
            Out = sin(In);
        }
        
        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }
        
        void Unity_Multiply_float4_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }
        
            // Graph Vertex
            struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            float _Property_8c596e62dce249caa7922ff3d7470d43_Out_0_Float = _WindSpeed;
            float _Split_35af25740d5a404097ccb209d36d5cac_R_1_Float = IN.WorldSpacePosition[0];
            float _Split_35af25740d5a404097ccb209d36d5cac_G_2_Float = IN.WorldSpacePosition[1];
            float _Split_35af25740d5a404097ccb209d36d5cac_B_3_Float = IN.WorldSpacePosition[2];
            float _Split_35af25740d5a404097ccb209d36d5cac_A_4_Float = 0;
            float _Add_c678bc9d08684d01a8e45ad5e636b4b4_Out_2_Float;
            Unity_Add_float(_Split_35af25740d5a404097ccb209d36d5cac_R_1_Float, _Split_35af25740d5a404097ccb209d36d5cac_B_3_Float, _Add_c678bc9d08684d01a8e45ad5e636b4b4_Out_2_Float);
            float _Add_0ec2f296c670483e9dc4250c81fe62a0_Out_2_Float;
            Unity_Add_float(IN.TimeParameters.x, _Add_c678bc9d08684d01a8e45ad5e636b4b4_Out_2_Float, _Add_0ec2f296c670483e9dc4250c81fe62a0_Out_2_Float);
            float _Multiply_ce5f4784040b450499733beaca915393_Out_2_Float;
            Unity_Multiply_float_float(_Property_8c596e62dce249caa7922ff3d7470d43_Out_0_Float, _Add_0ec2f296c670483e9dc4250c81fe62a0_Out_2_Float, _Multiply_ce5f4784040b450499733beaca915393_Out_2_Float);
            float _Sine_3c81889fed534b52996b5063cdc22296_Out_1_Float;
            Unity_Sine_float(_Multiply_ce5f4784040b450499733beaca915393_Out_2_Float, _Sine_3c81889fed534b52996b5063cdc22296_Out_1_Float);
            float _Property_3cdd281375794ed2bcad3550a9c890af_Out_0_Float = _WindStrength;
            float _Multiply_89ad4329fdd44befb161e56947c2670b_Out_2_Float;
            Unity_Multiply_float_float(_Sine_3c81889fed534b52996b5063cdc22296_Out_1_Float, _Property_3cdd281375794ed2bcad3550a9c890af_Out_0_Float, _Multiply_89ad4329fdd44befb161e56947c2670b_Out_2_Float);
            float4 _UV_30b55575e9844728bc3abbcaf84a22ff_Out_0_Vector4 = IN.uv0;
            float _Split_020d1040f8544c0b9d3de77e7fbd9197_R_1_Float = _UV_30b55575e9844728bc3abbcaf84a22ff_Out_0_Vector4[0];
            float _Split_020d1040f8544c0b9d3de77e7fbd9197_G_2_Float = _UV_30b55575e9844728bc3abbcaf84a22ff_Out_0_Vector4[1];
            float _Split_020d1040f8544c0b9d3de77e7fbd9197_B_3_Float = _UV_30b55575e9844728bc3abbcaf84a22ff_Out_0_Vector4[2];
            float _Split_020d1040f8544c0b9d3de77e7fbd9197_A_4_Float = _UV_30b55575e9844728bc3abbcaf84a22ff_Out_0_Vector4[3];
            float _Multiply_17088dc811eb45e4a333912f99b556ec_Out_2_Float;
            Unity_Multiply_float_float(_Multiply_89ad4329fdd44befb161e56947c2670b_Out_2_Float, _Split_020d1040f8544c0b9d3de77e7fbd9197_G_2_Float, _Multiply_17088dc811eb45e4a333912f99b556ec_Out_2_Float);
            float3 _Add_e473a1f67cd1441b9fccfb91c0b5ff75_Out_2_Vector3;
            Unity_Add_float3(IN.WorldSpacePosition, (_Multiply_17088dc811eb45e4a333912f99b556ec_Out_2_Float.xxx), _Add_e473a1f67cd1441b9fccfb91c0b5ff75_Out_2_Vector3);
            float3 _Add_8e06eedaa53749dea4ffc85b774f63ee_Out_2_Vector3;
            Unity_Add_float3(float3(0, 0, 0), _Add_e473a1f67cd1441b9fccfb91c0b5ff75_Out_2_Vector3, _Add_8e06eedaa53749dea4ffc85b774f63ee_Out_2_Vector3);
            float3 _Transform_78fa02a50d4c495cba1111966696417e_Out_1_Vector3;
            _Transform_78fa02a50d4c495cba1111966696417e_Out_1_Vector3 = TransformWorldToObject(_Add_8e06eedaa53749dea4ffc85b774f63ee_Out_2_Vector3.xyz);
            description.Position = _Transform_78fa02a50d4c495cba1111966696417e_Out_1_Vector3;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
            // Graph Pixel
            struct SurfaceDescription
        {
            float3 BaseColor;
            float3 Emission;
            float Alpha;
            float AlphaClipThreshold;
            float3 BentNormal;
            float Smoothness;
            float Occlusion;
            float3 NormalTS;
            float TransmissionMask;
            float Thickness;
            float DiffusionProfileHash;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float4 _Property_35c125abbbcb46e1a2351d8febeb5da1_Out_0_Vector4 = _Albedo;
            UnityTexture2D _Property_bb313b600ca3404fb88a2820878a8482_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Texture2D);
            float4 _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_bb313b600ca3404fb88a2820878a8482_Out_0_Texture2D.tex, _Property_bb313b600ca3404fb88a2820878a8482_Out_0_Texture2D.samplerstate, _Property_bb313b600ca3404fb88a2820878a8482_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_R_4_Float = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4.r;
            float _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_G_5_Float = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4.g;
            float _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_B_6_Float = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4.b;
            float _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_A_7_Float = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4.a;
            float4 _Multiply_c09cca22f04c4a9a996a5ccf8f61afe1_Out_2_Vector4;
            Unity_Multiply_float4_float4(_Property_35c125abbbcb46e1a2351d8febeb5da1_Out_0_Vector4, _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4, _Multiply_c09cca22f04c4a9a996a5ccf8f61afe1_Out_2_Vector4);
            float _Property_925f8cb589d94edda2dcd6b588187f26_Out_0_Float = _Smoothness;
            float _Multiply_a061075fe3794cc5abff5f173997f7f8_Out_2_Float;
            Unity_Multiply_float_float(_Property_925f8cb589d94edda2dcd6b588187f26_Out_0_Float, _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_G_5_Float, _Multiply_a061075fe3794cc5abff5f173997f7f8_Out_2_Float);
            UnityTexture2D _Property_ff2eff189fa74f1f965ec8aca53205ba_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Normal);
            float4 _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_ff2eff189fa74f1f965ec8aca53205ba_Out_0_Texture2D.tex, _Property_ff2eff189fa74f1f965ec8aca53205ba_Out_0_Texture2D.samplerstate, _Property_ff2eff189fa74f1f965ec8aca53205ba_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.rgb = UnpackNormal(_SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4);
            float _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_R_4_Float = _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.r;
            float _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_G_5_Float = _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.g;
            float _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_B_6_Float = _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.b;
            float _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_A_7_Float = _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.a;
            float _Property_915c3b0b5fc04c668c646f2f67b5ab2b_Out_0_Float = _NormalStrength;
            float4 _Multiply_e38eea28614c4b61bfd135ec8591a746_Out_2_Vector4;
            Unity_Multiply_float4_float4(_SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4, (_Property_915c3b0b5fc04c668c646f2f67b5ab2b_Out_0_Float.xxxx), _Multiply_e38eea28614c4b61bfd135ec8591a746_Out_2_Vector4);
            surface.BaseColor = (_Multiply_c09cca22f04c4a9a996a5ccf8f61afe1_Out_2_Vector4.xyz);
            surface.Emission = float3(0, 0, 0);
            surface.Alpha = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_A_7_Float;
            surface.AlphaClipThreshold = 0.5;
            surface.BentNormal = IN.TangentSpaceNormal;
            surface.Smoothness = _Multiply_a061075fe3794cc5abff5f173997f7f8_Out_2_Float;
            surface.Occlusion = 1;
            surface.NormalTS = (_Multiply_e38eea28614c4b61bfd135ec8591a746_Out_2_Vector4.xyz);
            surface.TransmissionMask = 1;
            surface.Thickness = 1;
            surface.DiffusionProfileHash = _DiffusionProfileHash;
            return surface;
        }
        
            // --------------------------------------------------
            // Build Graph Inputs
            #ifdef HAVE_VFX_MODIFICATION
            #define VFX_SRP_ATTRIBUTES AttributesMesh
            #define VaryingsMeshType VaryingsMeshToPS
            #define VFX_SRP_VARYINGS VaryingsMeshType
            #define VFX_SRP_SURFACE_INPUTS FragInputs
            #endif
            
        VertexDescriptionInputs AttributesMeshToVertexDescriptionInputs(AttributesMesh input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
            output.WorldSpacePosition =                         TransformObjectToWorld(input.positionOS);
            output.uv0 =                                        input.uv0;
            output.TimeParameters =                             _TimeParameters.xyz; // Note: in case of animation this will be overwrite (allow to handle motion vector)
        
            return output;
        }
        
        VertexDescription GetVertexDescription(AttributesMesh input, float3 timeParameters
        #ifdef HAVE_VFX_MODIFICATION
            , AttributesElement element
        #endif
        )
        {
            // build graph inputs
            VertexDescriptionInputs vertexDescriptionInputs = AttributesMeshToVertexDescriptionInputs(input);
            // Override time parameters with used one (This is required to correctly handle motion vectors for vertex animation based on time)
            vertexDescriptionInputs.TimeParameters = timeParameters;
        
            // evaluate vertex graph
        #ifdef HAVE_VFX_MODIFICATION
            GraphProperties properties;
            ZERO_INITIALIZE(GraphProperties, properties);
        
            // Fetch the vertex graph properties for the particle instance.
            GetElementVertexProperties(element, properties);
        
            VertexDescription vertexDescription = VertexDescriptionFunction(vertexDescriptionInputs, properties);
        #else
            VertexDescription vertexDescription = VertexDescriptionFunction(vertexDescriptionInputs);
        #endif
            return vertexDescription;
        
        }
        
        AttributesMesh ApplyMeshModification(AttributesMesh input, float3 timeParameters
        #ifdef USE_CUSTOMINTERP_SUBSTRUCT
            #ifdef TESSELLATION_ON
            , inout VaryingsMeshToDS varyings
            #else
            , inout VaryingsMeshToPS varyings
            #endif
        #endif
        #ifdef HAVE_VFX_MODIFICATION
                , AttributesElement element
        #endif
            )
        {
            VertexDescription vertexDescription = GetVertexDescription(input, timeParameters
        #ifdef HAVE_VFX_MODIFICATION
                , element
        #endif
            );
        
            // copy graph output to the results
            input.positionOS = vertexDescription.Position;
            input.normalOS = vertexDescription.Normal;
            input.tangentOS.xyz = vertexDescription.Tangent;
        
            
        
            return input;
        }
        
        #if defined(_ADD_CUSTOM_VELOCITY) // For shader graph custom velocity
        // Return precomputed Velocity in object space
        float3 GetCustomVelocity(AttributesMesh input
        #ifdef HAVE_VFX_MODIFICATION
            , AttributesElement element
        #endif
        )
        {
            VertexDescription vertexDescription = GetVertexDescription(input, _TimeParameters.xyz
        #ifdef HAVE_VFX_MODIFICATION
                , element
        #endif
            );
            return vertexDescription.CustomVelocity;
        }
        #endif
        
        FragInputs BuildFragInputs(VaryingsMeshToPS input)
        {
            FragInputs output;
            ZERO_INITIALIZE(FragInputs, output);
        
            // Init to some default value to make the computer quiet (else it output 'divide by zero' warning even if value is not used).
            // TODO: this is a really poor workaround, but the variable is used in a bunch of places
            // to compute normals which are then passed on elsewhere to compute other values...
            output.tangentToWorld = k_identity3x3;
            output.positionSS = input.positionCS;       // input.positionCS is SV_Position
        
            output.texCoord0 =                  input.texCoord0;
        
        
        #ifdef HAVE_VFX_MODIFICATION
            // FragInputs from VFX come from two places: Interpolator or CBuffer.
        #if VFX_USE_GRAPH_VALUES
            uint instanceActiveIndex = asuint(UNITY_ACCESS_INSTANCED_PROP(PerInstance, _InstanceActiveIndex));
            /* WARNING: $splice Could not find named fragment 'VFXLoadGraphValues' */
        #endif
        
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            // splice point to copy custom interpolator fields from varyings to frag inputs
            
        
            return output;
        }
        
        // existing HDRP code uses the combined function to go directly from packed to frag inputs
        FragInputs UnpackVaryingsMeshToFragInputs(PackedVaryingsMeshToPS input)
        {
            UNITY_SETUP_INSTANCE_ID(input);
        #if defined(HAVE_VFX_MODIFICATION) && defined(UNITY_INSTANCING_ENABLED)
            unity_InstanceID = input.instanceID;
        #endif
            VaryingsMeshToPS unpacked = UnpackVaryingsMeshToPS(input);
            return BuildFragInputs(unpacked);
        }
            SurfaceDescriptionInputs FragInputsToSurfaceDescriptionInputs(FragInputs input, float3 viewWS)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
            #if defined(SHADER_STAGE_RAY_TRACING)
            #else
            #endif
            output.TangentSpaceNormal =                         float3(0.0f, 0.0f, 1.0f);
        
        #if UNITY_UV_STARTS_AT_TOP
        #else
        #endif
        
        
            output.uv0 =                                        input.texCoord0;
        
            // splice point to copy frag inputs custom interpolator pack into the SDI
            
        
            return output;
        }
        
            // --------------------------------------------------
            // Build Surface Data (Specific Material)
        
        void ApplyDecalToSurfaceDataNoNormal(DecalSurfaceData decalSurfaceData, inout SurfaceData surfaceData);
        
        void ApplyDecalAndGetNormal(FragInputs fragInputs, PositionInputs posInput, SurfaceDescription surfaceDescription,
            inout SurfaceData surfaceData)
        {
            float3 doubleSidedConstants = GetDoubleSidedConstants();
        
        #ifdef DECAL_NORMAL_BLENDING
            // SG nodes don't ouptut surface gradients, so if decals require surf grad blending, we have to convert
            // the normal to gradient before applying the decal. We then have to resolve the gradient back to world space
            float3 normalTS;
        
            normalTS = SurfaceGradientFromTangentSpaceNormalAndFromTBN(surfaceDescription.NormalTS,
            fragInputs.tangentToWorld[0], fragInputs.tangentToWorld[1]);
        
        
            #if HAVE_DECALS
            if (_EnableDecals)
            {
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                ApplyDecalToSurfaceNormal(decalSurfaceData, fragInputs.tangentToWorld[2], normalTS);
                ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
            }
            #endif
        
            GetNormalWS_SG(fragInputs, normalTS, surfaceData.normalWS, doubleSidedConstants);
        #else
            // normal delivered to master node
            GetNormalWS(fragInputs, surfaceDescription.NormalTS, surfaceData.normalWS, doubleSidedConstants);
        
            #if HAVE_DECALS
            if (_EnableDecals)
            {
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                // Both uses and modifies 'surfaceData.normalWS'.
                DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                ApplyDecalToSurfaceNormal(decalSurfaceData, surfaceData.normalWS.xyz);
                ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
            }
            #endif
        #endif
        }
        void BuildSurfaceData(FragInputs fragInputs, inout SurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
        {
            ZERO_INITIALIZE(SurfaceData, surfaceData);
        
            // specularOcclusion need to be init ahead of decal to quiet the compiler that modify the SurfaceData struct
            // however specularOcclusion can come from the graph, so need to be init here so it can be override.
            surfaceData.specularOcclusion = 1.0;
            surfaceData.thickness = 0.0;
        
            surfaceData.baseColor =                 surfaceDescription.BaseColor;
            surfaceData.perceptualSmoothness =      surfaceDescription.Smoothness;
            surfaceData.ambientOcclusion =          surfaceDescription.Occlusion;
            surfaceData.transmissionMask =          surfaceDescription.TransmissionMask.xxx;
            surfaceData.thickness =                 surfaceDescription.Thickness;
            surfaceData.diffusionProfileHash =      asuint(surfaceDescription.DiffusionProfileHash);
        
            #if defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE) || defined(_REFRACTION_THIN)
                if (_EnableSSRefraction)
                {
        
                    surfaceData.transmittanceMask = (1.0 - surfaceDescription.Alpha);
                    surfaceDescription.Alpha = 1.0;
                }
                else
                {
                    surfaceData.ior = 1.0;
                    surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                    surfaceData.atDistance = 1.0;
                    surfaceData.transmittanceMask = 0.0;
                    surfaceDescription.Alpha = 1.0;
                }
            #else
                surfaceData.ior = 1.0;
                surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                surfaceData.atDistance = 1.0;
                surfaceData.transmittanceMask = 0.0;
            #endif
        
            // These static material feature allow compile time optimization
            surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;
            #ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
            #endif
        
            #ifdef _MATERIAL_FEATURE_TRANSMISSION
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
            #endif
        
            #ifdef _MATERIAL_FEATURE_COLORED_TRANSMISSION
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_COLORED_TRANSMISSION;
        
            #endif
        
            #ifdef _MATERIAL_FEATURE_ANISOTROPY
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
        
                // Initialize the normal to something non-zero to avoid a div-zero warning for anisotropy.
                surfaceData.normalWS = float3(0, 1, 0);
            #endif
        
            #ifdef _MATERIAL_FEATURE_IRIDESCENCE
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
            #endif
        
            #ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
            #endif
        
            #ifdef _MATERIAL_FEATURE_CLEAR_COAT
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
            #endif
        
            #if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
                // Require to have setup baseColor
                // Reproduce the energy conservation done in legacy Unity. Not ideal but better for compatibility and users can unchek it
                surfaceData.baseColor *= (1.0 - Max3(surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b));
            #endif
        
            float3 doubleSidedConstants = GetDoubleSidedConstants();
        
            ApplyDecalAndGetNormal(fragInputs, posInput, surfaceDescription, surfaceData);
        
            surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];
        
            surfaceData.tangentWS = normalize(fragInputs.tangentToWorld[0].xyz);    // The tangent is not normalize in tangentToWorld for mikkt. TODO: Check if it expected that we normalize with Morten. Tag: SURFACE_GRADIENT
        
        
            bentNormalWS = surfaceData.normalWS;
        
            surfaceData.tangentWS = Orthonormalize(surfaceData.tangentWS, surfaceData.normalWS);
        
            #ifdef DEBUG_DISPLAY
                if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
                {
                    // TODO: need to update mip info
                    surfaceData.metallic = 0;
                }
        
                // We need to call ApplyDebugToSurfaceData after filling the surfarcedata and before filling builtinData
                // as it can modify attribute use for static lighting
                ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData);
            #endif
        
            // By default we use the ambient occlusion with Tri-ace trick (apply outside) for specular occlusion.
            // If user provide bent normal then we process a better term
            #if defined(_SPECULAR_OCCLUSION_CUSTOM)
                // Just use the value passed through via the slot (not active otherwise)
            #elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
                // If we have bent normal and ambient occlusion, process a specular occlusion
                surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO(V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness(surfaceData.perceptualSmoothness));
            #elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
                surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion(ClampNdotV(dot(surfaceData.normalWS, V)), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness(surfaceData.perceptualSmoothness));
            #endif
        
            #if defined(_ENABLE_GEOMETRIC_SPECULAR_AA) && !defined(SHADER_STAGE_RAY_TRACING)
                surfaceData.perceptualSmoothness = GeometricNormalFiltering(surfaceData.perceptualSmoothness, fragInputs.tangentToWorld[2], surfaceDescription.SpecularAAScreenSpaceVariance, surfaceDescription.SpecularAAThreshold);
            #endif
        }
        
            // --------------------------------------------------
            // Get Surface And BuiltinData
        
            void GetSurfaceAndBuiltinData(FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData RAY_TRACING_OPTIONAL_PARAMETERS)
            {
                // Don't dither if displaced tessellation (we're fading out the displacement instead to match the next LOD)
                #if !defined(SHADER_STAGE_RAY_TRACING) && !defined(_TESSELLATION_DISPLACEMENT)
                #ifdef LOD_FADE_CROSSFADE // enable dithering LOD transition if user select CrossFade transition in LOD group
                LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
                #endif
                #endif
        
                #ifndef SHADER_UNLIT
                #ifdef _DOUBLESIDED_ON
                    float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
                #else
                    float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
                #endif
        
                ApplyDoubleSidedFlipOrMirror(fragInputs, doubleSidedConstants); // Apply double sided flip on the vertex normal
                #endif // SHADER_UNLIT
        
                SurfaceDescriptionInputs surfaceDescriptionInputs = FragInputsToSurfaceDescriptionInputs(fragInputs, V);
        
                #if defined(HAVE_VFX_MODIFICATION)
                GraphProperties properties;
                ZERO_INITIALIZE(GraphProperties, properties);
        
                GetElementPixelProperties(fragInputs, properties);
        
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs, properties);
                #else
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs);
                #endif
        
                // Perform alpha test very early to save performance (a killed pixel will not sample textures)
                // TODO: split graph evaluation to grab just alpha dependencies first? tricky..
                #ifdef _ALPHATEST_ON
                    float alphaCutoff = surfaceDescription.AlphaClipThreshold;
                    #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
                    // The TransparentDepthPrepass is also used with SSR transparent.
                    // If an artists enable transaprent SSR but not the TransparentDepthPrepass itself, then we use AlphaClipThreshold
                    // otherwise if TransparentDepthPrepass is enabled we use AlphaClipThresholdDepthPrepass
                    #elif SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_POSTPASS
                    // DepthPostpass always use its own alpha threshold
                    alphaCutoff = surfaceDescription.AlphaClipThresholdDepthPostpass;
                    #elif (SHADERPASS == SHADERPASS_SHADOWS) || (SHADERPASS == SHADERPASS_RAYTRACING_VISIBILITY)
                    // If use shadow threshold isn't enable we don't allow any test
                    #endif
        
                    GENERIC_ALPHA_TEST(surfaceDescription.Alpha, alphaCutoff);
                #endif
        
                #if !defined(SHADER_STAGE_RAY_TRACING) && _DEPTHOFFSET_ON
                ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
                #endif
        
                #ifndef SHADER_UNLIT
                float3 bentNormalWS;
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS);
        
                #ifdef FRAG_INPUTS_USE_TEXCOORD1
                    float4 lightmapTexCoord1 = fragInputs.texCoord1;
                #else
                    float4 lightmapTexCoord1 = float4(0,0,0,0);
                #endif
        
                #ifdef FRAG_INPUTS_USE_TEXCOORD2
                    float4 lightmapTexCoord2 = fragInputs.texCoord2;
                #else
                    float4 lightmapTexCoord2 = float4(0,0,0,0);
                #endif
        
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                // Builtin Data
                // For back lighting we use the oposite vertex normal
                InitBuiltinData(posInput, alpha, bentNormalWS, -fragInputs.tangentToWorld[2], lightmapTexCoord1, lightmapTexCoord2, builtinData);
        
                #else
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData);
        
                ZERO_BUILTIN_INITIALIZE(builtinData); // No call to InitBuiltinData as we don't have any lighting
                builtinData.opacity = surfaceDescription.Alpha;
        
                #if defined(DEBUG_DISPLAY)
                    // Light Layers are currently not used for the Unlit shader (because it is not lit)
                    // But Unlit objects do cast shadows according to their rendering layer mask, which is what we want to
                    // display in the light layers visualization mode, therefore we need the renderingLayers
                    builtinData.renderingLayers = GetMeshRenderingLayerMask();
                #endif
        
                #endif // SHADER_UNLIT
        
                #ifdef _ALPHATEST_ON
                    // Used for sharpening by alpha to mask - Alpha to covertage is only used with depth only and forward pass (no shadow pass, no transparent pass)
                    builtinData.alphaClipTreshold = alphaCutoff;
                #endif
        
                // override sampleBakedGI - not used by Unlit
        		// When overriding GI, we need to force the isLightmap flag to make sure we don't add APV (sampled in the lightloop) on top of the overridden value (set at GBuffer stage)
        
                builtinData.emissiveColor = surfaceDescription.Emission;
        
                // Note this will not fully work on transparent surfaces (can check with _SURFACE_TYPE_TRANSPARENT define)
                // We will always overwrite vt feeback with the nearest. So behind transparent surfaces vt will not be resolved
                // This is a limitation of the current MRT approach.
                #ifdef UNITY_VIRTUAL_TEXTURING
                #endif
        
                #if _DEPTHOFFSET_ON
                builtinData.depthOffset = surfaceDescription.DepthOffset;
                #endif
        
                // TODO: We should generate distortion / distortionBlur for non distortion pass
                #if (SHADERPASS == SHADERPASS_DISTORTION)
                builtinData.distortion = surfaceDescription.Distortion;
                builtinData.distortionBlur = surfaceDescription.DistortionBlur;
                #endif
        
                #ifndef SHADER_UNLIT
                // PostInitBuiltinData call ApplyDebugToBuiltinData
                PostInitBuiltinData(V, posInput, surfaceData, builtinData);
                #else
                ApplyDebugToBuiltinData(builtinData);
                #endif
        
                RAY_TRACING_OPTIONAL_ALPHA_TEST_PASS
            }
        
            // --------------------------------------------------
            // Main
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPassConstant.hlsl"
        
            // --------------------------------------------------
            // Visual Effect Vertex Invocations
        
        	#ifdef HAVE_VFX_MODIFICATION
                #if !defined(SHADER_STAGE_RAY_TRACING)
        	    #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/VisualEffectVertex.hlsl"
                #else
                #endif
        	#endif
        
            #include "Assets/VegetationInstancer/Shaders/Include/GPUInstancedIndirectInclude.cginc"
#pragma instancing_options procedural:setupGPUInstancedIndirect
#pragma multi_compile_instancing
ENDHLSL
        }
    }
    SubShader
    {
        Tags
        {
            "RenderPipeline"="HDRenderPipeline"
            "RenderType"="HDLitShader"
            "Queue"="AlphaTest+25"
            "DisableBatching"="False"
            "ShaderGraphShader"="true"
            "ShaderGraphTargetId"="HDLitSubTarget"
        }
        Pass
        {
            Name "IndirectDXR"
            Tags
            {
                "LightMode" = "IndirectDXR"
            }
        
            // Render State
            // RenderState: <None>
        
            // Debug
            // <None>
        
            // --------------------------------------------------
            // Pass
        
            HLSLPROGRAM
        
            // Pragmas
            #pragma target 5.0
        #pragma raytracing surface_shader
        #pragma only_renderers d3d11 xboxseries ps5
        
            // Keywords
            #pragma multi_compile _ MULTI_BOUNCE_INDIRECT
        #pragma shader_feature_local _ _ALPHATEST_ON
        #pragma shader_feature _ _SURFACE_TYPE_TRANSPARENT
        #pragma shader_feature_local _ _DOUBLESIDED_ON
        #pragma shader_feature_local _ _ADD_PRECOMPUTED_VELOCITY
        #pragma shader_feature_local _ _TRANSPARENT_WRITES_MOTION_VEC _TRANSPARENT_REFRACTIVE_SORT
        #pragma shader_feature_local_fragment _ _ENABLE_FOG_ON_TRANSPARENT
        #pragma multi_compile _ DEBUG_DISPLAY
        #pragma shader_feature_local_fragment _ _DISABLE_DECALS
        #pragma shader_feature_local_raytracing _ _DISABLE_DECALS
        #pragma shader_feature_local_fragment _ _DISABLE_SSR
        #pragma shader_feature_local_raytracing _ _DISABLE_SSR
        #pragma shader_feature_local_fragment _ _DISABLE_SSR_TRANSPARENT
        #pragma shader_feature_local_raytracing _ _DISABLE_SSR_TRANSPARENT
        #pragma multi_compile _ LIGHTMAP_ON
        #pragma multi_compile _ DIRLIGHTMAP_COMBINED
        #pragma multi_compile_fragment _ PROBE_VOLUMES_L1 PROBE_VOLUMES_L2
        #pragma multi_compile_raytracing _ PROBE_VOLUMES_L1 PROBE_VOLUMES_L2
        #pragma multi_compile _ DYNAMICLIGHTMAP_ON
        #pragma shader_feature_local _ _REFRACTION_PLANE _REFRACTION_SPHERE _REFRACTION_THIN
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_TRANSMISSION
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_TRANSMISSION
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_ANISOTROPY
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_ANISOTROPY
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_IRIDESCENCE
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_IRIDESCENCE
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_SPECULAR_COLOR
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_SPECULAR_COLOR
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_COLORED_TRANSMISSION
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_COLORED_TRANSMISSION
            // GraphKeywords: <None>
        
            // Defines
            #define SHADERPASS SHADERPASS_RAYTRACING_INDIRECT
        #define PUNCTUAL_SHADOW_LOW
        #define DIRECTIONAL_SHADOW_LOW
        #define RAYTRACING_SHADER_GRAPH_RAYTRACED
        #define HAS_LIGHTLOOP 1
        
            // For custom interpolators to inject a substruct definition before FragInputs definition,
            // allowing for FragInputs to capture CI's intended for ShaderGraph's SDI.
            /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreInclude' */
        
        
            // TODO: Merge FragInputsVFX substruct with CustomInterpolators.
        	#ifdef HAVE_VFX_MODIFICATION
        	struct FragInputsVFX
            {
                /* WARNING: $splice Could not find named fragment 'FragInputsVFX' */
            };
            #endif
        
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl" // Required by Tessellation.hlsl
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Tessellation.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl" // Required to be include before we include properties as it define DECLARE_STACK_CB
            // Always include Shader Graph version
            // Always include last to avoid double macros
            #include "Packages/com.unity.shadergraph/ShaderGraphLibrary/Functions.hlsl" // Need to be here for Gradient struct definition
        
            // --------------------------------------------------
            // Defines
        
            // Attribute
            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define ATTRIBUTES_NEED_TEXCOORD0
            #define ATTRIBUTES_NEED_TEXCOORD1
            #define ATTRIBUTES_NEED_TEXCOORD2
            #define VARYINGS_NEED_POSITION_WS
            #define VARYINGS_NEED_TANGENT_TO_WORLD
            #define VARYINGS_NEED_TEXCOORD0
            #define VARYINGS_NEED_TEXCOORD1
            #define VARYINGS_NEED_TEXCOORD2
        
        
            //Strip down the FragInputs.hlsl (on graphics), so we can only optimize the interpolators we use.
            //if by accident something requests contents of FragInputs.hlsl, it will be caught as a compiler error
            //Frag inputs stripping is only enabled when FRAG_INPUTS_ENABLE_STRIPPING is set
            #if !defined(SHADER_STAGE_RAY_TRACING) && SHADERPASS != SHADERPASS_RAYTRACING_GBUFFER && SHADERPASS != SHADERPASS_FULL_SCREEN_DEBUG
            #define FRAG_INPUTS_ENABLE_STRIPPING
            #endif
            #define FRAG_INPUTS_USE_TEXCOORD0
            #define FRAG_INPUTS_USE_TEXCOORD1
            #define FRAG_INPUTS_USE_TEXCOORD2
        
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
        
        
        
        
            // Following two define are a workaround introduce in 10.1.x for RaytracingQualityNode
            // The ShaderGraph don't support correctly migration of this node as it serialize all the node data
            // in the json file making it impossible to uprgrade. Until we get a fix, we do a workaround here
            // to still allow us to rename the field and keyword of this node without breaking existing code.
            #ifdef RAYTRACING_SHADER_GRAPH_DEFAULT
            #define RAYTRACING_SHADER_GRAPH_HIGH
            #endif
        
            #ifdef RAYTRACING_SHADER_GRAPH_RAYTRACED
            #define RAYTRACING_SHADER_GRAPH_LOW
            #endif
            // end
        
            #ifndef SHADER_UNLIT
            // We need isFrontFace when using double sided - it is not required for unlit as in case of unlit double sided only drive the cullmode
            // VARYINGS_NEED_CULLFACE can be define by VaryingsMeshToPS.FaceSign input if a IsFrontFace Node is included in the shader graph.
            #if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
                #define VARYINGS_NEED_CULLFACE
            #endif
            #endif
        
            // Specific Material Define
        #define _SPECULAR_OCCLUSION_FROM_AO 1
        #define _ENERGY_CONSERVING_SPECULAR 1
        
        #if _MATERIAL_FEATURE_COLORED_TRANSMISSION
            // Colored Transmission doesn't support clear coat
            #undef _MATERIAL_FEATURE_CLEAR_COAT
        #endif
        
        // If we use subsurface scattering, enable output split lighting (for forward pass)
        #if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
            #define OUTPUT_SPLIT_LIGHTING
        #endif
        
        // This shader support recursive rendering for raytracing
        #define HAVE_RECURSIVE_RENDERING
        
        // In Path Tracing, For all single-sided, refractive materials, we want to force a thin refraction model
        #if (SHADERPASS == SHADERPASS_PATH_TRACING) && !defined(_DOUBLESIDED_ON) && (defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE))
            #undef  _REFRACTION_PLANE
            #undef  _REFRACTION_SPHERE
            #define _REFRACTION_THIN
        #endif
            // Caution: we can use the define SHADER_UNLIT onlit after the above Material include as it is the Unlit template who define it
        
            // To handle SSR on transparent correctly with a possibility to enable/disable it per framesettings
            // we should have a code like this:
            // if !defined(_DISABLE_SSR_TRANSPARENT)
            // pragma multi_compile _ WRITE_NORMAL_BUFFER
            // endif
            // i.e we enable the multicompile only if we can receive SSR or not, and then C# code drive
            // it based on if SSR transparent in frame settings and not (and stripper can strip it).
            // this is currently not possible with our current preprocessor as _DISABLE_SSR_TRANSPARENT is a keyword not a define
            // so instead we used this and chose to pay the extra cost of normal write even if SSR transaprent is disabled.
            // Ideally the shader graph generator should handle it but condition below can't be handle correctly for now.
            #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
            #if !defined(_DISABLE_SSR_TRANSPARENT) && !defined(SHADER_UNLIT)
                #define WRITE_NORMAL_BUFFER
            #endif
            #endif
        
            // See Lit.shader
            #if SHADERPASS == SHADERPASS_MOTION_VECTORS && defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)
                #define WRITE_DECAL_BUFFER
            #endif
        
            #ifndef DEBUG_DISPLAY
                // In case of opaque we don't want to perform the alpha test, it is done in depth prepass and we use depth equal for ztest (setup from UI)
                // Don't do it with debug display mode as it is possible there is no depth prepass in this case
                #if !defined(_SURFACE_TYPE_TRANSPARENT)
                    #if SHADERPASS == SHADERPASS_FORWARD
                    #define SHADERPASS_FORWARD_BYPASS_ALPHA_TEST
                    #elif SHADERPASS == SHADERPASS_GBUFFER
                    #define SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST
                    #endif
                #endif
            #endif
        
            // Define _DEFERRED_CAPABLE_MATERIAL for shader capable to run in deferred pass
            #if defined(SHADER_LIT) && !defined(_SURFACE_TYPE_TRANSPARENT)
                #define _DEFERRED_CAPABLE_MATERIAL
            #endif
        
            // Translate transparent motion vector define
            #if (defined(_TRANSPARENT_WRITES_MOTION_VEC) || defined(_TRANSPARENT_REFRACTIVE_SORT)) && defined(_SURFACE_TYPE_TRANSPARENT)
                #define _WRITE_TRANSPARENT_MOTION_VECTOR
            #endif
        
            // -- Graph Properties
            CBUFFER_START(UnityPerMaterial)
        float4 _DiffusionProfileAsset;
        float _DiffusionProfileHash;
        float4 _Texture2D_TexelSize;
        float4 _Albedo;
        float _Smoothness;
        float _WindSpeed;
        float _WindStrength;
        float4 _Normal_TexelSize;
        float _NormalStrength;
        float4 _EmissionColor;
        float _UseShadowThreshold;
        float4 _DoubleSidedConstants;
        float _BlendMode;
        float _EnableBlendModePreserveSpecularLighting;
        float _RayTracing;
        float _RefractionModel;
        float _MaterialID;
        float _MaterialTypeMask;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_Texture2D);
        SAMPLER(sampler_Texture2D);
        TEXTURE2D(_Normal);
        SAMPLER(sampler_Normal);
        
            // -- Property used by ScenePickingPass
            #ifdef SCENEPICKINGPASS
            float4 _SelectionID;
            #endif
        
            // -- Properties used by SceneSelectionPass
            #ifdef SCENESELECTIONPASS
            int _ObjectId;
            int _PassValue;
            #endif
        
            // Includes
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingMacros.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/ShaderVariablesRaytracing.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/ShaderVariablesRaytracingLightLoop.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingIntersection.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/LightLoop/LightLoopDef.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitRayTracing.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingLightLoop.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RayTracingCommon.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"
        	// GraphIncludes: <None>
        
            // --------------------------------------------------
            // Structs and Packing
        
            struct SurfaceDescriptionInputs
        {
             float3 TangentSpaceNormal;
             float4 uv0;
        };
        
            //Interpolator Packs: <None>
        
            // --------------------------------------------------
            // Graph
        
        
            // Graph Functions
            
        void Unity_Multiply_float4_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
            // Graph Vertex
            // GraphVertex: <None>
        
            // Graph Pixel
            struct SurfaceDescription
        {
            float3 BaseColor;
            float3 Emission;
            float Alpha;
            float AlphaClipThreshold;
            float3 BentNormal;
            float Smoothness;
            float Occlusion;
            float3 NormalTS;
            float TransmissionMask;
            float Thickness;
            float DiffusionProfileHash;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float4 _Property_35c125abbbcb46e1a2351d8febeb5da1_Out_0_Vector4 = _Albedo;
            UnityTexture2D _Property_bb313b600ca3404fb88a2820878a8482_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Texture2D);
            float4 _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_bb313b600ca3404fb88a2820878a8482_Out_0_Texture2D.tex, _Property_bb313b600ca3404fb88a2820878a8482_Out_0_Texture2D.samplerstate, _Property_bb313b600ca3404fb88a2820878a8482_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_R_4_Float = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4.r;
            float _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_G_5_Float = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4.g;
            float _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_B_6_Float = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4.b;
            float _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_A_7_Float = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4.a;
            float4 _Multiply_c09cca22f04c4a9a996a5ccf8f61afe1_Out_2_Vector4;
            Unity_Multiply_float4_float4(_Property_35c125abbbcb46e1a2351d8febeb5da1_Out_0_Vector4, _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4, _Multiply_c09cca22f04c4a9a996a5ccf8f61afe1_Out_2_Vector4);
            float _Property_925f8cb589d94edda2dcd6b588187f26_Out_0_Float = _Smoothness;
            float _Multiply_a061075fe3794cc5abff5f173997f7f8_Out_2_Float;
            Unity_Multiply_float_float(_Property_925f8cb589d94edda2dcd6b588187f26_Out_0_Float, _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_G_5_Float, _Multiply_a061075fe3794cc5abff5f173997f7f8_Out_2_Float);
            UnityTexture2D _Property_ff2eff189fa74f1f965ec8aca53205ba_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Normal);
            float4 _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_ff2eff189fa74f1f965ec8aca53205ba_Out_0_Texture2D.tex, _Property_ff2eff189fa74f1f965ec8aca53205ba_Out_0_Texture2D.samplerstate, _Property_ff2eff189fa74f1f965ec8aca53205ba_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.rgb = UnpackNormal(_SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4);
            float _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_R_4_Float = _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.r;
            float _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_G_5_Float = _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.g;
            float _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_B_6_Float = _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.b;
            float _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_A_7_Float = _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.a;
            float _Property_915c3b0b5fc04c668c646f2f67b5ab2b_Out_0_Float = _NormalStrength;
            float4 _Multiply_e38eea28614c4b61bfd135ec8591a746_Out_2_Vector4;
            Unity_Multiply_float4_float4(_SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4, (_Property_915c3b0b5fc04c668c646f2f67b5ab2b_Out_0_Float.xxxx), _Multiply_e38eea28614c4b61bfd135ec8591a746_Out_2_Vector4);
            surface.BaseColor = (_Multiply_c09cca22f04c4a9a996a5ccf8f61afe1_Out_2_Vector4.xyz);
            surface.Emission = float3(0, 0, 0);
            surface.Alpha = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_A_7_Float;
            surface.AlphaClipThreshold = 0.5;
            surface.BentNormal = IN.TangentSpaceNormal;
            surface.Smoothness = _Multiply_a061075fe3794cc5abff5f173997f7f8_Out_2_Float;
            surface.Occlusion = 1;
            surface.NormalTS = (_Multiply_e38eea28614c4b61bfd135ec8591a746_Out_2_Vector4.xyz);
            surface.TransmissionMask = 1;
            surface.Thickness = 1;
            surface.DiffusionProfileHash = _DiffusionProfileHash;
            return surface;
        }
        
            // --------------------------------------------------
            // Build Graph Inputs
            #ifdef HAVE_VFX_MODIFICATION
            #define VFX_SRP_ATTRIBUTES AttributesMesh
            #define VaryingsMeshType VaryingsMeshToPS
            #define VFX_SRP_VARYINGS VaryingsMeshType
            #define VFX_SRP_SURFACE_INPUTS FragInputs
            #endif
            SurfaceDescriptionInputs FragInputsToSurfaceDescriptionInputs(FragInputs input, float3 viewWS)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
            #if defined(SHADER_STAGE_RAY_TRACING)
            #else
            #endif
            output.TangentSpaceNormal =                         float3(0.0f, 0.0f, 1.0f);
        
        #if UNITY_UV_STARTS_AT_TOP
        #else
        #endif
        
        
            output.uv0 =                                        input.texCoord0;
        
            // splice point to copy frag inputs custom interpolator pack into the SDI
            /* WARNING: $splice Could not find named fragment 'CustomInterpolatorCopyToSDI' */
        
            return output;
        }
        
            // --------------------------------------------------
            // Build Surface Data (Specific Material)
        
        void ApplyDecalToSurfaceDataNoNormal(DecalSurfaceData decalSurfaceData, inout SurfaceData surfaceData);
        
        void ApplyDecalAndGetNormal(FragInputs fragInputs, PositionInputs posInput, SurfaceDescription surfaceDescription,
            inout SurfaceData surfaceData)
        {
            float3 doubleSidedConstants = GetDoubleSidedConstants();
        
        #ifdef DECAL_NORMAL_BLENDING
            // SG nodes don't ouptut surface gradients, so if decals require surf grad blending, we have to convert
            // the normal to gradient before applying the decal. We then have to resolve the gradient back to world space
            float3 normalTS;
        
            normalTS = SurfaceGradientFromTangentSpaceNormalAndFromTBN(surfaceDescription.NormalTS,
            fragInputs.tangentToWorld[0], fragInputs.tangentToWorld[1]);
        
        
            #if HAVE_DECALS
            if (_EnableDecals)
            {
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                ApplyDecalToSurfaceNormal(decalSurfaceData, fragInputs.tangentToWorld[2], normalTS);
                ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
            }
            #endif
        
            GetNormalWS_SG(fragInputs, normalTS, surfaceData.normalWS, doubleSidedConstants);
        #else
            // normal delivered to master node
            GetNormalWS(fragInputs, surfaceDescription.NormalTS, surfaceData.normalWS, doubleSidedConstants);
        
            #if HAVE_DECALS
            if (_EnableDecals)
            {
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                // Both uses and modifies 'surfaceData.normalWS'.
                DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                ApplyDecalToSurfaceNormal(decalSurfaceData, surfaceData.normalWS.xyz);
                ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
            }
            #endif
        #endif
        }
        void BuildSurfaceData(FragInputs fragInputs, inout SurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
        {
            ZERO_INITIALIZE(SurfaceData, surfaceData);
        
            // specularOcclusion need to be init ahead of decal to quiet the compiler that modify the SurfaceData struct
            // however specularOcclusion can come from the graph, so need to be init here so it can be override.
            surfaceData.specularOcclusion = 1.0;
            surfaceData.thickness = 0.0;
        
            surfaceData.baseColor =                 surfaceDescription.BaseColor;
            surfaceData.perceptualSmoothness =      surfaceDescription.Smoothness;
            surfaceData.ambientOcclusion =          surfaceDescription.Occlusion;
            surfaceData.transmissionMask =          surfaceDescription.TransmissionMask.xxx;
            surfaceData.thickness =                 surfaceDescription.Thickness;
            surfaceData.diffusionProfileHash =      asuint(surfaceDescription.DiffusionProfileHash);
        
            #if defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE) || defined(_REFRACTION_THIN)
                if (_EnableSSRefraction)
                {
        
                    surfaceData.transmittanceMask = (1.0 - surfaceDescription.Alpha);
                    surfaceDescription.Alpha = 1.0;
                }
                else
                {
                    surfaceData.ior = 1.0;
                    surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                    surfaceData.atDistance = 1.0;
                    surfaceData.transmittanceMask = 0.0;
                    surfaceDescription.Alpha = 1.0;
                }
            #else
                surfaceData.ior = 1.0;
                surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                surfaceData.atDistance = 1.0;
                surfaceData.transmittanceMask = 0.0;
            #endif
        
            // These static material feature allow compile time optimization
            surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;
            #ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
            #endif
        
            #ifdef _MATERIAL_FEATURE_TRANSMISSION
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
            #endif
        
            #ifdef _MATERIAL_FEATURE_COLORED_TRANSMISSION
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_COLORED_TRANSMISSION;
        
            #endif
        
            #ifdef _MATERIAL_FEATURE_ANISOTROPY
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
        
                // Initialize the normal to something non-zero to avoid a div-zero warning for anisotropy.
                surfaceData.normalWS = float3(0, 1, 0);
            #endif
        
            #ifdef _MATERIAL_FEATURE_IRIDESCENCE
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
            #endif
        
            #ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
            #endif
        
            #ifdef _MATERIAL_FEATURE_CLEAR_COAT
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
            #endif
        
            #if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
                // Require to have setup baseColor
                // Reproduce the energy conservation done in legacy Unity. Not ideal but better for compatibility and users can unchek it
                surfaceData.baseColor *= (1.0 - Max3(surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b));
            #endif
        
            float3 doubleSidedConstants = GetDoubleSidedConstants();
        
            ApplyDecalAndGetNormal(fragInputs, posInput, surfaceDescription, surfaceData);
        
            surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];
        
            surfaceData.tangentWS = normalize(fragInputs.tangentToWorld[0].xyz);    // The tangent is not normalize in tangentToWorld for mikkt. TODO: Check if it expected that we normalize with Morten. Tag: SURFACE_GRADIENT
        
        
            bentNormalWS = surfaceData.normalWS;
        
            surfaceData.tangentWS = Orthonormalize(surfaceData.tangentWS, surfaceData.normalWS);
        
            #ifdef DEBUG_DISPLAY
                if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
                {
                    // TODO: need to update mip info
                    surfaceData.metallic = 0;
                }
        
                // We need to call ApplyDebugToSurfaceData after filling the surfarcedata and before filling builtinData
                // as it can modify attribute use for static lighting
                ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData);
            #endif
        
            // By default we use the ambient occlusion with Tri-ace trick (apply outside) for specular occlusion.
            // If user provide bent normal then we process a better term
            #if defined(_SPECULAR_OCCLUSION_CUSTOM)
                // Just use the value passed through via the slot (not active otherwise)
            #elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
                // If we have bent normal and ambient occlusion, process a specular occlusion
                surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO(V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness(surfaceData.perceptualSmoothness));
            #elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
                surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion(ClampNdotV(dot(surfaceData.normalWS, V)), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness(surfaceData.perceptualSmoothness));
            #endif
        
            #if defined(_ENABLE_GEOMETRIC_SPECULAR_AA) && !defined(SHADER_STAGE_RAY_TRACING)
                surfaceData.perceptualSmoothness = GeometricNormalFiltering(surfaceData.perceptualSmoothness, fragInputs.tangentToWorld[2], surfaceDescription.SpecularAAScreenSpaceVariance, surfaceDescription.SpecularAAThreshold);
            #endif
        }
        
            // --------------------------------------------------
            // Get Surface And BuiltinData
        
            void GetSurfaceAndBuiltinData(FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData RAY_TRACING_OPTIONAL_PARAMETERS)
            {
                // Don't dither if displaced tessellation (we're fading out the displacement instead to match the next LOD)
                #if !defined(SHADER_STAGE_RAY_TRACING) && !defined(_TESSELLATION_DISPLACEMENT)
                #ifdef LOD_FADE_CROSSFADE // enable dithering LOD transition if user select CrossFade transition in LOD group
                LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
                #endif
                #endif
        
                #ifndef SHADER_UNLIT
                #ifdef _DOUBLESIDED_ON
                    float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
                #else
                    float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
                #endif
        
                ApplyDoubleSidedFlipOrMirror(fragInputs, doubleSidedConstants); // Apply double sided flip on the vertex normal
                #endif // SHADER_UNLIT
        
                SurfaceDescriptionInputs surfaceDescriptionInputs = FragInputsToSurfaceDescriptionInputs(fragInputs, V);
        
                #if defined(HAVE_VFX_MODIFICATION)
                GraphProperties properties;
                ZERO_INITIALIZE(GraphProperties, properties);
        
                GetElementPixelProperties(fragInputs, properties);
        
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs, properties);
                #else
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs);
                #endif
        
                // Perform alpha test very early to save performance (a killed pixel will not sample textures)
                // TODO: split graph evaluation to grab just alpha dependencies first? tricky..
                #ifdef _ALPHATEST_ON
                    float alphaCutoff = surfaceDescription.AlphaClipThreshold;
                    #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
                    // The TransparentDepthPrepass is also used with SSR transparent.
                    // If an artists enable transaprent SSR but not the TransparentDepthPrepass itself, then we use AlphaClipThreshold
                    // otherwise if TransparentDepthPrepass is enabled we use AlphaClipThresholdDepthPrepass
                    #elif SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_POSTPASS
                    // DepthPostpass always use its own alpha threshold
                    alphaCutoff = surfaceDescription.AlphaClipThresholdDepthPostpass;
                    #elif (SHADERPASS == SHADERPASS_SHADOWS) || (SHADERPASS == SHADERPASS_RAYTRACING_VISIBILITY)
                    // If use shadow threshold isn't enable we don't allow any test
                    #endif
        
                    GENERIC_ALPHA_TEST(surfaceDescription.Alpha, alphaCutoff);
                #endif
        
                #if !defined(SHADER_STAGE_RAY_TRACING) && _DEPTHOFFSET_ON
                ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
                #endif
        
                #ifndef SHADER_UNLIT
                float3 bentNormalWS;
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS);
        
                #ifdef FRAG_INPUTS_USE_TEXCOORD1
                    float4 lightmapTexCoord1 = fragInputs.texCoord1;
                #else
                    float4 lightmapTexCoord1 = float4(0,0,0,0);
                #endif
        
                #ifdef FRAG_INPUTS_USE_TEXCOORD2
                    float4 lightmapTexCoord2 = fragInputs.texCoord2;
                #else
                    float4 lightmapTexCoord2 = float4(0,0,0,0);
                #endif
        
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                // Builtin Data
                // For back lighting we use the oposite vertex normal
                InitBuiltinData(posInput, alpha, bentNormalWS, -fragInputs.tangentToWorld[2], lightmapTexCoord1, lightmapTexCoord2, builtinData);
        
                #else
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData);
        
                ZERO_BUILTIN_INITIALIZE(builtinData); // No call to InitBuiltinData as we don't have any lighting
                builtinData.opacity = surfaceDescription.Alpha;
        
                #if defined(DEBUG_DISPLAY)
                    // Light Layers are currently not used for the Unlit shader (because it is not lit)
                    // But Unlit objects do cast shadows according to their rendering layer mask, which is what we want to
                    // display in the light layers visualization mode, therefore we need the renderingLayers
                    builtinData.renderingLayers = GetMeshRenderingLayerMask();
                #endif
        
                #endif // SHADER_UNLIT
        
                #ifdef _ALPHATEST_ON
                    // Used for sharpening by alpha to mask - Alpha to covertage is only used with depth only and forward pass (no shadow pass, no transparent pass)
                    builtinData.alphaClipTreshold = alphaCutoff;
                #endif
        
                // override sampleBakedGI - not used by Unlit
        		// When overriding GI, we need to force the isLightmap flag to make sure we don't add APV (sampled in the lightloop) on top of the overridden value (set at GBuffer stage)
        
                builtinData.emissiveColor = surfaceDescription.Emission;
        
                // Note this will not fully work on transparent surfaces (can check with _SURFACE_TYPE_TRANSPARENT define)
                // We will always overwrite vt feeback with the nearest. So behind transparent surfaces vt will not be resolved
                // This is a limitation of the current MRT approach.
                #ifdef UNITY_VIRTUAL_TEXTURING
                #endif
        
                #if _DEPTHOFFSET_ON
                builtinData.depthOffset = surfaceDescription.DepthOffset;
                #endif
        
                // TODO: We should generate distortion / distortionBlur for non distortion pass
                #if (SHADERPASS == SHADERPASS_DISTORTION)
                builtinData.distortion = surfaceDescription.Distortion;
                builtinData.distortionBlur = surfaceDescription.DistortionBlur;
                #endif
        
                #ifndef SHADER_UNLIT
                // PostInitBuiltinData call ApplyDebugToBuiltinData
                PostInitBuiltinData(V, posInput, surfaceData, builtinData);
                #else
                ApplyDebugToBuiltinData(builtinData);
                #endif
        
                RAY_TRACING_OPTIONAL_ALPHA_TEST_PASS
            }
        
            // --------------------------------------------------
            // Main
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPassRaytracingIndirect.hlsl"
        
            // --------------------------------------------------
            // Visual Effect Vertex Invocations
        
        	#ifdef HAVE_VFX_MODIFICATION
                #if !defined(SHADER_STAGE_RAY_TRACING)
        	    #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/VisualEffectVertex.hlsl"
                #else
                #endif
        	#endif
        
            #include "Assets/VegetationInstancer/Shaders/Include/GPUInstancedIndirectInclude.cginc"
#pragma instancing_options procedural:setupGPUInstancedIndirect
#pragma multi_compile_instancing
ENDHLSL
        }
        Pass
        {
            Name "VisibilityDXR"
            Tags
            {
                "LightMode" = "VisibilityDXR"
            }
        
            // Render State
            // RenderState: <None>
        
            // Debug
            // <None>
        
            // --------------------------------------------------
            // Pass
        
            HLSLPROGRAM
        
            // Pragmas
            #pragma target 5.0
        #pragma raytracing surface_shader
        #pragma only_renderers d3d11 xboxseries ps5
        
            // Keywords
            #pragma multi_compile _ TRANSPARENT_COLOR_SHADOW
        #pragma shader_feature_local _ _ALPHATEST_ON
        #pragma shader_feature _ _SURFACE_TYPE_TRANSPARENT
        #pragma shader_feature_local _ _DOUBLESIDED_ON
        #pragma shader_feature_local _ _ADD_PRECOMPUTED_VELOCITY
        #pragma shader_feature_local _ _TRANSPARENT_WRITES_MOTION_VEC _TRANSPARENT_REFRACTIVE_SORT
        #pragma shader_feature_local_fragment _ _ENABLE_FOG_ON_TRANSPARENT
        #pragma shader_feature_local_fragment _ _DISABLE_DECALS
        #pragma shader_feature_local_raytracing _ _DISABLE_DECALS
        #pragma shader_feature_local_fragment _ _DISABLE_SSR
        #pragma shader_feature_local_raytracing _ _DISABLE_SSR
        #pragma shader_feature_local_fragment _ _DISABLE_SSR_TRANSPARENT
        #pragma shader_feature_local_raytracing _ _DISABLE_SSR_TRANSPARENT
        #pragma shader_feature_local _ _REFRACTION_PLANE _REFRACTION_SPHERE _REFRACTION_THIN
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_TRANSMISSION
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_TRANSMISSION
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_ANISOTROPY
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_ANISOTROPY
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_IRIDESCENCE
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_IRIDESCENCE
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_SPECULAR_COLOR
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_SPECULAR_COLOR
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_COLORED_TRANSMISSION
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_COLORED_TRANSMISSION
            // GraphKeywords: <None>
        
            // Defines
            #define SHADERPASS SHADERPASS_RAYTRACING_VISIBILITY
        #define RAYTRACING_SHADER_GRAPH_RAYTRACED
        
            // For custom interpolators to inject a substruct definition before FragInputs definition,
            // allowing for FragInputs to capture CI's intended for ShaderGraph's SDI.
            /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreInclude' */
        
        
            // TODO: Merge FragInputsVFX substruct with CustomInterpolators.
        	#ifdef HAVE_VFX_MODIFICATION
        	struct FragInputsVFX
            {
                /* WARNING: $splice Could not find named fragment 'FragInputsVFX' */
            };
            #endif
        
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl" // Required by Tessellation.hlsl
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Tessellation.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl" // Required to be include before we include properties as it define DECLARE_STACK_CB
            // Always include Shader Graph version
            // Always include last to avoid double macros
            #include "Packages/com.unity.shadergraph/ShaderGraphLibrary/Functions.hlsl" // Need to be here for Gradient struct definition
        
            // --------------------------------------------------
            // Defines
        
            // Attribute
            #define ATTRIBUTES_NEED_TEXCOORD0
            #define VARYINGS_NEED_TEXCOORD0
        
        
            //Strip down the FragInputs.hlsl (on graphics), so we can only optimize the interpolators we use.
            //if by accident something requests contents of FragInputs.hlsl, it will be caught as a compiler error
            //Frag inputs stripping is only enabled when FRAG_INPUTS_ENABLE_STRIPPING is set
            #if !defined(SHADER_STAGE_RAY_TRACING) && SHADERPASS != SHADERPASS_RAYTRACING_GBUFFER && SHADERPASS != SHADERPASS_FULL_SCREEN_DEBUG
            #define FRAG_INPUTS_ENABLE_STRIPPING
            #endif
            #define FRAG_INPUTS_USE_TEXCOORD0
        
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
        
        
        
        
            // Following two define are a workaround introduce in 10.1.x for RaytracingQualityNode
            // The ShaderGraph don't support correctly migration of this node as it serialize all the node data
            // in the json file making it impossible to uprgrade. Until we get a fix, we do a workaround here
            // to still allow us to rename the field and keyword of this node without breaking existing code.
            #ifdef RAYTRACING_SHADER_GRAPH_DEFAULT
            #define RAYTRACING_SHADER_GRAPH_HIGH
            #endif
        
            #ifdef RAYTRACING_SHADER_GRAPH_RAYTRACED
            #define RAYTRACING_SHADER_GRAPH_LOW
            #endif
            // end
        
            #ifndef SHADER_UNLIT
            // We need isFrontFace when using double sided - it is not required for unlit as in case of unlit double sided only drive the cullmode
            // VARYINGS_NEED_CULLFACE can be define by VaryingsMeshToPS.FaceSign input if a IsFrontFace Node is included in the shader graph.
            #if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
                #define VARYINGS_NEED_CULLFACE
            #endif
            #endif
        
            // Specific Material Define
        #define _SPECULAR_OCCLUSION_FROM_AO 1
        #define _ENERGY_CONSERVING_SPECULAR 1
        
        #if _MATERIAL_FEATURE_COLORED_TRANSMISSION
            // Colored Transmission doesn't support clear coat
            #undef _MATERIAL_FEATURE_CLEAR_COAT
        #endif
        
        // If we use subsurface scattering, enable output split lighting (for forward pass)
        #if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
            #define OUTPUT_SPLIT_LIGHTING
        #endif
        
        // This shader support recursive rendering for raytracing
        #define HAVE_RECURSIVE_RENDERING
        
        // In Path Tracing, For all single-sided, refractive materials, we want to force a thin refraction model
        #if (SHADERPASS == SHADERPASS_PATH_TRACING) && !defined(_DOUBLESIDED_ON) && (defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE))
            #undef  _REFRACTION_PLANE
            #undef  _REFRACTION_SPHERE
            #define _REFRACTION_THIN
        #endif
            // Caution: we can use the define SHADER_UNLIT onlit after the above Material include as it is the Unlit template who define it
        
            // To handle SSR on transparent correctly with a possibility to enable/disable it per framesettings
            // we should have a code like this:
            // if !defined(_DISABLE_SSR_TRANSPARENT)
            // pragma multi_compile _ WRITE_NORMAL_BUFFER
            // endif
            // i.e we enable the multicompile only if we can receive SSR or not, and then C# code drive
            // it based on if SSR transparent in frame settings and not (and stripper can strip it).
            // this is currently not possible with our current preprocessor as _DISABLE_SSR_TRANSPARENT is a keyword not a define
            // so instead we used this and chose to pay the extra cost of normal write even if SSR transaprent is disabled.
            // Ideally the shader graph generator should handle it but condition below can't be handle correctly for now.
            #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
            #if !defined(_DISABLE_SSR_TRANSPARENT) && !defined(SHADER_UNLIT)
                #define WRITE_NORMAL_BUFFER
            #endif
            #endif
        
            // See Lit.shader
            #if SHADERPASS == SHADERPASS_MOTION_VECTORS && defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)
                #define WRITE_DECAL_BUFFER
            #endif
        
            #ifndef DEBUG_DISPLAY
                // In case of opaque we don't want to perform the alpha test, it is done in depth prepass and we use depth equal for ztest (setup from UI)
                // Don't do it with debug display mode as it is possible there is no depth prepass in this case
                #if !defined(_SURFACE_TYPE_TRANSPARENT)
                    #if SHADERPASS == SHADERPASS_FORWARD
                    #define SHADERPASS_FORWARD_BYPASS_ALPHA_TEST
                    #elif SHADERPASS == SHADERPASS_GBUFFER
                    #define SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST
                    #endif
                #endif
            #endif
        
            // Define _DEFERRED_CAPABLE_MATERIAL for shader capable to run in deferred pass
            #if defined(SHADER_LIT) && !defined(_SURFACE_TYPE_TRANSPARENT)
                #define _DEFERRED_CAPABLE_MATERIAL
            #endif
        
            // Translate transparent motion vector define
            #if (defined(_TRANSPARENT_WRITES_MOTION_VEC) || defined(_TRANSPARENT_REFRACTIVE_SORT)) && defined(_SURFACE_TYPE_TRANSPARENT)
                #define _WRITE_TRANSPARENT_MOTION_VECTOR
            #endif
        
            // -- Graph Properties
            CBUFFER_START(UnityPerMaterial)
        float4 _DiffusionProfileAsset;
        float _DiffusionProfileHash;
        float4 _Texture2D_TexelSize;
        float4 _Albedo;
        float _Smoothness;
        float _WindSpeed;
        float _WindStrength;
        float4 _Normal_TexelSize;
        float _NormalStrength;
        float4 _EmissionColor;
        float _UseShadowThreshold;
        float4 _DoubleSidedConstants;
        float _BlendMode;
        float _EnableBlendModePreserveSpecularLighting;
        float _RayTracing;
        float _RefractionModel;
        float _MaterialID;
        float _MaterialTypeMask;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_Texture2D);
        SAMPLER(sampler_Texture2D);
        TEXTURE2D(_Normal);
        SAMPLER(sampler_Normal);
        
            // -- Property used by ScenePickingPass
            #ifdef SCENEPICKINGPASS
            float4 _SelectionID;
            #endif
        
            // -- Properties used by SceneSelectionPass
            #ifdef SCENESELECTIONPASS
            int _ObjectId;
            int _PassValue;
            #endif
        
            // Includes
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingMacros.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/ShaderVariablesRaytracing.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/ShaderVariablesRaytracingLightLoop.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingIntersection.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitRayTracing.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RayTracingCommon.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"
        	// GraphIncludes: <None>
        
            // --------------------------------------------------
            // Structs and Packing
        
            struct SurfaceDescriptionInputs
        {
             float3 TangentSpaceNormal;
             float4 uv0;
        };
        
            //Interpolator Packs: <None>
        
            // --------------------------------------------------
            // Graph
        
        
            // Graph Functions
            
        void Unity_Multiply_float4_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
            // Graph Vertex
            // GraphVertex: <None>
        
            // Graph Pixel
            struct SurfaceDescription
        {
            float3 BaseColor;
            float3 Emission;
            float Alpha;
            float AlphaClipThreshold;
            float3 BentNormal;
            float Smoothness;
            float Occlusion;
            float3 NormalTS;
            float TransmissionMask;
            float Thickness;
            float DiffusionProfileHash;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float4 _Property_35c125abbbcb46e1a2351d8febeb5da1_Out_0_Vector4 = _Albedo;
            UnityTexture2D _Property_bb313b600ca3404fb88a2820878a8482_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Texture2D);
            float4 _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_bb313b600ca3404fb88a2820878a8482_Out_0_Texture2D.tex, _Property_bb313b600ca3404fb88a2820878a8482_Out_0_Texture2D.samplerstate, _Property_bb313b600ca3404fb88a2820878a8482_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_R_4_Float = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4.r;
            float _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_G_5_Float = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4.g;
            float _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_B_6_Float = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4.b;
            float _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_A_7_Float = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4.a;
            float4 _Multiply_c09cca22f04c4a9a996a5ccf8f61afe1_Out_2_Vector4;
            Unity_Multiply_float4_float4(_Property_35c125abbbcb46e1a2351d8febeb5da1_Out_0_Vector4, _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4, _Multiply_c09cca22f04c4a9a996a5ccf8f61afe1_Out_2_Vector4);
            float _Property_925f8cb589d94edda2dcd6b588187f26_Out_0_Float = _Smoothness;
            float _Multiply_a061075fe3794cc5abff5f173997f7f8_Out_2_Float;
            Unity_Multiply_float_float(_Property_925f8cb589d94edda2dcd6b588187f26_Out_0_Float, _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_G_5_Float, _Multiply_a061075fe3794cc5abff5f173997f7f8_Out_2_Float);
            UnityTexture2D _Property_ff2eff189fa74f1f965ec8aca53205ba_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Normal);
            float4 _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_ff2eff189fa74f1f965ec8aca53205ba_Out_0_Texture2D.tex, _Property_ff2eff189fa74f1f965ec8aca53205ba_Out_0_Texture2D.samplerstate, _Property_ff2eff189fa74f1f965ec8aca53205ba_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.rgb = UnpackNormal(_SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4);
            float _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_R_4_Float = _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.r;
            float _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_G_5_Float = _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.g;
            float _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_B_6_Float = _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.b;
            float _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_A_7_Float = _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.a;
            float _Property_915c3b0b5fc04c668c646f2f67b5ab2b_Out_0_Float = _NormalStrength;
            float4 _Multiply_e38eea28614c4b61bfd135ec8591a746_Out_2_Vector4;
            Unity_Multiply_float4_float4(_SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4, (_Property_915c3b0b5fc04c668c646f2f67b5ab2b_Out_0_Float.xxxx), _Multiply_e38eea28614c4b61bfd135ec8591a746_Out_2_Vector4);
            surface.BaseColor = (_Multiply_c09cca22f04c4a9a996a5ccf8f61afe1_Out_2_Vector4.xyz);
            surface.Emission = float3(0, 0, 0);
            surface.Alpha = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_A_7_Float;
            surface.AlphaClipThreshold = 0.5;
            surface.BentNormal = IN.TangentSpaceNormal;
            surface.Smoothness = _Multiply_a061075fe3794cc5abff5f173997f7f8_Out_2_Float;
            surface.Occlusion = 1;
            surface.NormalTS = (_Multiply_e38eea28614c4b61bfd135ec8591a746_Out_2_Vector4.xyz);
            surface.TransmissionMask = 1;
            surface.Thickness = 1;
            surface.DiffusionProfileHash = _DiffusionProfileHash;
            return surface;
        }
        
            // --------------------------------------------------
            // Build Graph Inputs
            #ifdef HAVE_VFX_MODIFICATION
            #define VFX_SRP_ATTRIBUTES AttributesMesh
            #define VaryingsMeshType VaryingsMeshToPS
            #define VFX_SRP_VARYINGS VaryingsMeshType
            #define VFX_SRP_SURFACE_INPUTS FragInputs
            #endif
            SurfaceDescriptionInputs FragInputsToSurfaceDescriptionInputs(FragInputs input, float3 viewWS)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
            #if defined(SHADER_STAGE_RAY_TRACING)
            #else
            #endif
            output.TangentSpaceNormal =                         float3(0.0f, 0.0f, 1.0f);
        
        #if UNITY_UV_STARTS_AT_TOP
        #else
        #endif
        
        
            output.uv0 =                                        input.texCoord0;
        
            // splice point to copy frag inputs custom interpolator pack into the SDI
            /* WARNING: $splice Could not find named fragment 'CustomInterpolatorCopyToSDI' */
        
            return output;
        }
        
            // --------------------------------------------------
            // Build Surface Data (Specific Material)
        
        void ApplyDecalToSurfaceDataNoNormal(DecalSurfaceData decalSurfaceData, inout SurfaceData surfaceData);
        
        void ApplyDecalAndGetNormal(FragInputs fragInputs, PositionInputs posInput, SurfaceDescription surfaceDescription,
            inout SurfaceData surfaceData)
        {
            float3 doubleSidedConstants = GetDoubleSidedConstants();
        
        #ifdef DECAL_NORMAL_BLENDING
            // SG nodes don't ouptut surface gradients, so if decals require surf grad blending, we have to convert
            // the normal to gradient before applying the decal. We then have to resolve the gradient back to world space
            float3 normalTS;
        
            normalTS = SurfaceGradientFromTangentSpaceNormalAndFromTBN(surfaceDescription.NormalTS,
            fragInputs.tangentToWorld[0], fragInputs.tangentToWorld[1]);
        
        
            #if HAVE_DECALS
            if (_EnableDecals)
            {
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                ApplyDecalToSurfaceNormal(decalSurfaceData, fragInputs.tangentToWorld[2], normalTS);
                ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
            }
            #endif
        
            GetNormalWS_SG(fragInputs, normalTS, surfaceData.normalWS, doubleSidedConstants);
        #else
            // normal delivered to master node
            GetNormalWS(fragInputs, surfaceDescription.NormalTS, surfaceData.normalWS, doubleSidedConstants);
        
            #if HAVE_DECALS
            if (_EnableDecals)
            {
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                // Both uses and modifies 'surfaceData.normalWS'.
                DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                ApplyDecalToSurfaceNormal(decalSurfaceData, surfaceData.normalWS.xyz);
                ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
            }
            #endif
        #endif
        }
        void BuildSurfaceData(FragInputs fragInputs, inout SurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
        {
            ZERO_INITIALIZE(SurfaceData, surfaceData);
        
            // specularOcclusion need to be init ahead of decal to quiet the compiler that modify the SurfaceData struct
            // however specularOcclusion can come from the graph, so need to be init here so it can be override.
            surfaceData.specularOcclusion = 1.0;
            surfaceData.thickness = 0.0;
        
            surfaceData.baseColor =                 surfaceDescription.BaseColor;
            surfaceData.perceptualSmoothness =      surfaceDescription.Smoothness;
            surfaceData.ambientOcclusion =          surfaceDescription.Occlusion;
            surfaceData.transmissionMask =          surfaceDescription.TransmissionMask.xxx;
            surfaceData.thickness =                 surfaceDescription.Thickness;
            surfaceData.diffusionProfileHash =      asuint(surfaceDescription.DiffusionProfileHash);
        
            #if defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE) || defined(_REFRACTION_THIN)
                if (_EnableSSRefraction)
                {
        
                    surfaceData.transmittanceMask = (1.0 - surfaceDescription.Alpha);
                    surfaceDescription.Alpha = 1.0;
                }
                else
                {
                    surfaceData.ior = 1.0;
                    surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                    surfaceData.atDistance = 1.0;
                    surfaceData.transmittanceMask = 0.0;
                    surfaceDescription.Alpha = 1.0;
                }
            #else
                surfaceData.ior = 1.0;
                surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                surfaceData.atDistance = 1.0;
                surfaceData.transmittanceMask = 0.0;
            #endif
        
            // These static material feature allow compile time optimization
            surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;
            #ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
            #endif
        
            #ifdef _MATERIAL_FEATURE_TRANSMISSION
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
            #endif
        
            #ifdef _MATERIAL_FEATURE_COLORED_TRANSMISSION
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_COLORED_TRANSMISSION;
        
            #endif
        
            #ifdef _MATERIAL_FEATURE_ANISOTROPY
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
        
                // Initialize the normal to something non-zero to avoid a div-zero warning for anisotropy.
                surfaceData.normalWS = float3(0, 1, 0);
            #endif
        
            #ifdef _MATERIAL_FEATURE_IRIDESCENCE
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
            #endif
        
            #ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
            #endif
        
            #ifdef _MATERIAL_FEATURE_CLEAR_COAT
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
            #endif
        
            #if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
                // Require to have setup baseColor
                // Reproduce the energy conservation done in legacy Unity. Not ideal but better for compatibility and users can unchek it
                surfaceData.baseColor *= (1.0 - Max3(surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b));
            #endif
        
            float3 doubleSidedConstants = GetDoubleSidedConstants();
        
            ApplyDecalAndGetNormal(fragInputs, posInput, surfaceDescription, surfaceData);
        
            surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];
        
            surfaceData.tangentWS = normalize(fragInputs.tangentToWorld[0].xyz);    // The tangent is not normalize in tangentToWorld for mikkt. TODO: Check if it expected that we normalize with Morten. Tag: SURFACE_GRADIENT
        
        
            bentNormalWS = surfaceData.normalWS;
        
            surfaceData.tangentWS = Orthonormalize(surfaceData.tangentWS, surfaceData.normalWS);
        
            #ifdef DEBUG_DISPLAY
                if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
                {
                    // TODO: need to update mip info
                    surfaceData.metallic = 0;
                }
        
                // We need to call ApplyDebugToSurfaceData after filling the surfarcedata and before filling builtinData
                // as it can modify attribute use for static lighting
                ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData);
            #endif
        
            // By default we use the ambient occlusion with Tri-ace trick (apply outside) for specular occlusion.
            // If user provide bent normal then we process a better term
            #if defined(_SPECULAR_OCCLUSION_CUSTOM)
                // Just use the value passed through via the slot (not active otherwise)
            #elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
                // If we have bent normal and ambient occlusion, process a specular occlusion
                surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO(V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness(surfaceData.perceptualSmoothness));
            #elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
                surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion(ClampNdotV(dot(surfaceData.normalWS, V)), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness(surfaceData.perceptualSmoothness));
            #endif
        
            #if defined(_ENABLE_GEOMETRIC_SPECULAR_AA) && !defined(SHADER_STAGE_RAY_TRACING)
                surfaceData.perceptualSmoothness = GeometricNormalFiltering(surfaceData.perceptualSmoothness, fragInputs.tangentToWorld[2], surfaceDescription.SpecularAAScreenSpaceVariance, surfaceDescription.SpecularAAThreshold);
            #endif
        }
        
            // --------------------------------------------------
            // Get Surface And BuiltinData
        
            void GetSurfaceAndBuiltinData(FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData RAY_TRACING_OPTIONAL_PARAMETERS)
            {
                // Don't dither if displaced tessellation (we're fading out the displacement instead to match the next LOD)
                #if !defined(SHADER_STAGE_RAY_TRACING) && !defined(_TESSELLATION_DISPLACEMENT)
                #ifdef LOD_FADE_CROSSFADE // enable dithering LOD transition if user select CrossFade transition in LOD group
                LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
                #endif
                #endif
        
                #ifndef SHADER_UNLIT
                #ifdef _DOUBLESIDED_ON
                    float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
                #else
                    float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
                #endif
        
                ApplyDoubleSidedFlipOrMirror(fragInputs, doubleSidedConstants); // Apply double sided flip on the vertex normal
                #endif // SHADER_UNLIT
        
                SurfaceDescriptionInputs surfaceDescriptionInputs = FragInputsToSurfaceDescriptionInputs(fragInputs, V);
        
                #if defined(HAVE_VFX_MODIFICATION)
                GraphProperties properties;
                ZERO_INITIALIZE(GraphProperties, properties);
        
                GetElementPixelProperties(fragInputs, properties);
        
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs, properties);
                #else
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs);
                #endif
        
                // Perform alpha test very early to save performance (a killed pixel will not sample textures)
                // TODO: split graph evaluation to grab just alpha dependencies first? tricky..
                #ifdef _ALPHATEST_ON
                    float alphaCutoff = surfaceDescription.AlphaClipThreshold;
                    #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
                    // The TransparentDepthPrepass is also used with SSR transparent.
                    // If an artists enable transaprent SSR but not the TransparentDepthPrepass itself, then we use AlphaClipThreshold
                    // otherwise if TransparentDepthPrepass is enabled we use AlphaClipThresholdDepthPrepass
                    #elif SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_POSTPASS
                    // DepthPostpass always use its own alpha threshold
                    alphaCutoff = surfaceDescription.AlphaClipThresholdDepthPostpass;
                    #elif (SHADERPASS == SHADERPASS_SHADOWS) || (SHADERPASS == SHADERPASS_RAYTRACING_VISIBILITY)
                    // If use shadow threshold isn't enable we don't allow any test
                    #endif
        
                    GENERIC_ALPHA_TEST(surfaceDescription.Alpha, alphaCutoff);
                #endif
        
                #if !defined(SHADER_STAGE_RAY_TRACING) && _DEPTHOFFSET_ON
                ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
                #endif
        
                #ifndef SHADER_UNLIT
                float3 bentNormalWS;
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS);
        
                #ifdef FRAG_INPUTS_USE_TEXCOORD1
                    float4 lightmapTexCoord1 = fragInputs.texCoord1;
                #else
                    float4 lightmapTexCoord1 = float4(0,0,0,0);
                #endif
        
                #ifdef FRAG_INPUTS_USE_TEXCOORD2
                    float4 lightmapTexCoord2 = fragInputs.texCoord2;
                #else
                    float4 lightmapTexCoord2 = float4(0,0,0,0);
                #endif
        
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                // Builtin Data
                // For back lighting we use the oposite vertex normal
                InitBuiltinData(posInput, alpha, bentNormalWS, -fragInputs.tangentToWorld[2], lightmapTexCoord1, lightmapTexCoord2, builtinData);
        
                #else
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData);
        
                ZERO_BUILTIN_INITIALIZE(builtinData); // No call to InitBuiltinData as we don't have any lighting
                builtinData.opacity = surfaceDescription.Alpha;
        
                #if defined(DEBUG_DISPLAY)
                    // Light Layers are currently not used for the Unlit shader (because it is not lit)
                    // But Unlit objects do cast shadows according to their rendering layer mask, which is what we want to
                    // display in the light layers visualization mode, therefore we need the renderingLayers
                    builtinData.renderingLayers = GetMeshRenderingLayerMask();
                #endif
        
                #endif // SHADER_UNLIT
        
                #ifdef _ALPHATEST_ON
                    // Used for sharpening by alpha to mask - Alpha to covertage is only used with depth only and forward pass (no shadow pass, no transparent pass)
                    builtinData.alphaClipTreshold = alphaCutoff;
                #endif
        
                // override sampleBakedGI - not used by Unlit
        		// When overriding GI, we need to force the isLightmap flag to make sure we don't add APV (sampled in the lightloop) on top of the overridden value (set at GBuffer stage)
        
                builtinData.emissiveColor = surfaceDescription.Emission;
        
                // Note this will not fully work on transparent surfaces (can check with _SURFACE_TYPE_TRANSPARENT define)
                // We will always overwrite vt feeback with the nearest. So behind transparent surfaces vt will not be resolved
                // This is a limitation of the current MRT approach.
                #ifdef UNITY_VIRTUAL_TEXTURING
                #endif
        
                #if _DEPTHOFFSET_ON
                builtinData.depthOffset = surfaceDescription.DepthOffset;
                #endif
        
                // TODO: We should generate distortion / distortionBlur for non distortion pass
                #if (SHADERPASS == SHADERPASS_DISTORTION)
                builtinData.distortion = surfaceDescription.Distortion;
                builtinData.distortionBlur = surfaceDescription.DistortionBlur;
                #endif
        
                #ifndef SHADER_UNLIT
                // PostInitBuiltinData call ApplyDebugToBuiltinData
                PostInitBuiltinData(V, posInput, surfaceData, builtinData);
                #else
                ApplyDebugToBuiltinData(builtinData);
                #endif
        
                RAY_TRACING_OPTIONAL_ALPHA_TEST_PASS
            }
        
            // --------------------------------------------------
            // Main
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPassRaytracingVisibility.hlsl"
        
            // --------------------------------------------------
            // Visual Effect Vertex Invocations
        
        	#ifdef HAVE_VFX_MODIFICATION
                #if !defined(SHADER_STAGE_RAY_TRACING)
        	    #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/VisualEffectVertex.hlsl"
                #else
                #endif
        	#endif
        
            #include "Assets/VegetationInstancer/Shaders/Include/GPUInstancedIndirectInclude.cginc"
#pragma instancing_options procedural:setupGPUInstancedIndirect
#pragma multi_compile_instancing
ENDHLSL
        }
        Pass
        {
            Name "ForwardDXR"
            Tags
            {
                "LightMode" = "ForwardDXR"
            }
        
            // Render State
            // RenderState: <None>
        
            // Debug
            // <None>
        
            // --------------------------------------------------
            // Pass
        
            HLSLPROGRAM
        
            // Pragmas
            #pragma target 5.0
        #pragma raytracing surface_shader
        #pragma only_renderers d3d11 xboxseries ps5
        
            // Keywords
            #pragma shader_feature_local _ _ALPHATEST_ON
        #pragma shader_feature _ _SURFACE_TYPE_TRANSPARENT
        #pragma shader_feature_local _ _DOUBLESIDED_ON
        #pragma shader_feature_local _ _ADD_PRECOMPUTED_VELOCITY
        #pragma shader_feature_local _ _TRANSPARENT_WRITES_MOTION_VEC _TRANSPARENT_REFRACTIVE_SORT
        #pragma shader_feature_local_fragment _ _ENABLE_FOG_ON_TRANSPARENT
        #pragma multi_compile _ DEBUG_DISPLAY
        #pragma shader_feature_local_fragment _ _DISABLE_DECALS
        #pragma shader_feature_local_raytracing _ _DISABLE_DECALS
        #pragma shader_feature_local_fragment _ _DISABLE_SSR
        #pragma shader_feature_local_raytracing _ _DISABLE_SSR
        #pragma shader_feature_local_fragment _ _DISABLE_SSR_TRANSPARENT
        #pragma shader_feature_local_raytracing _ _DISABLE_SSR_TRANSPARENT
        #pragma multi_compile _ LIGHTMAP_ON
        #pragma multi_compile _ DIRLIGHTMAP_COMBINED
        #pragma multi_compile_fragment _ PROBE_VOLUMES_L1 PROBE_VOLUMES_L2
        #pragma multi_compile_raytracing _ PROBE_VOLUMES_L1 PROBE_VOLUMES_L2
        #pragma multi_compile _ DYNAMICLIGHTMAP_ON
        #pragma shader_feature_local _ _REFRACTION_PLANE _REFRACTION_SPHERE _REFRACTION_THIN
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_TRANSMISSION
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_TRANSMISSION
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_ANISOTROPY
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_ANISOTROPY
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_IRIDESCENCE
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_IRIDESCENCE
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_SPECULAR_COLOR
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_SPECULAR_COLOR
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_COLORED_TRANSMISSION
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_COLORED_TRANSMISSION
            // GraphKeywords: <None>
        
            // Defines
            #define SHADERPASS SHADERPASS_RAYTRACING_FORWARD
        #define PUNCTUAL_SHADOW_LOW
        #define DIRECTIONAL_SHADOW_LOW
        #define RAYTRACING_SHADER_GRAPH_RAYTRACED
        #define HAS_LIGHTLOOP 1
        
            // For custom interpolators to inject a substruct definition before FragInputs definition,
            // allowing for FragInputs to capture CI's intended for ShaderGraph's SDI.
            /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreInclude' */
        
        
            // TODO: Merge FragInputsVFX substruct with CustomInterpolators.
        	#ifdef HAVE_VFX_MODIFICATION
        	struct FragInputsVFX
            {
                /* WARNING: $splice Could not find named fragment 'FragInputsVFX' */
            };
            #endif
        
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl" // Required by Tessellation.hlsl
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Tessellation.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl" // Required to be include before we include properties as it define DECLARE_STACK_CB
            // Always include Shader Graph version
            // Always include last to avoid double macros
            #include "Packages/com.unity.shadergraph/ShaderGraphLibrary/Functions.hlsl" // Need to be here for Gradient struct definition
        
            // --------------------------------------------------
            // Defines
        
            // Attribute
            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define ATTRIBUTES_NEED_TEXCOORD0
            #define ATTRIBUTES_NEED_TEXCOORD1
            #define ATTRIBUTES_NEED_TEXCOORD2
            #define VARYINGS_NEED_POSITION_WS
            #define VARYINGS_NEED_TANGENT_TO_WORLD
            #define VARYINGS_NEED_TEXCOORD0
            #define VARYINGS_NEED_TEXCOORD1
            #define VARYINGS_NEED_TEXCOORD2
        
        
            //Strip down the FragInputs.hlsl (on graphics), so we can only optimize the interpolators we use.
            //if by accident something requests contents of FragInputs.hlsl, it will be caught as a compiler error
            //Frag inputs stripping is only enabled when FRAG_INPUTS_ENABLE_STRIPPING is set
            #if !defined(SHADER_STAGE_RAY_TRACING) && SHADERPASS != SHADERPASS_RAYTRACING_GBUFFER && SHADERPASS != SHADERPASS_FULL_SCREEN_DEBUG
            #define FRAG_INPUTS_ENABLE_STRIPPING
            #endif
            #define FRAG_INPUTS_USE_TEXCOORD0
            #define FRAG_INPUTS_USE_TEXCOORD1
            #define FRAG_INPUTS_USE_TEXCOORD2
        
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
        
        
        
        
            // Following two define are a workaround introduce in 10.1.x for RaytracingQualityNode
            // The ShaderGraph don't support correctly migration of this node as it serialize all the node data
            // in the json file making it impossible to uprgrade. Until we get a fix, we do a workaround here
            // to still allow us to rename the field and keyword of this node without breaking existing code.
            #ifdef RAYTRACING_SHADER_GRAPH_DEFAULT
            #define RAYTRACING_SHADER_GRAPH_HIGH
            #endif
        
            #ifdef RAYTRACING_SHADER_GRAPH_RAYTRACED
            #define RAYTRACING_SHADER_GRAPH_LOW
            #endif
            // end
        
            #ifndef SHADER_UNLIT
            // We need isFrontFace when using double sided - it is not required for unlit as in case of unlit double sided only drive the cullmode
            // VARYINGS_NEED_CULLFACE can be define by VaryingsMeshToPS.FaceSign input if a IsFrontFace Node is included in the shader graph.
            #if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
                #define VARYINGS_NEED_CULLFACE
            #endif
            #endif
        
            // Specific Material Define
        #define _SPECULAR_OCCLUSION_FROM_AO 1
        #define _ENERGY_CONSERVING_SPECULAR 1
        
        #if _MATERIAL_FEATURE_COLORED_TRANSMISSION
            // Colored Transmission doesn't support clear coat
            #undef _MATERIAL_FEATURE_CLEAR_COAT
        #endif
        
        // If we use subsurface scattering, enable output split lighting (for forward pass)
        #if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
            #define OUTPUT_SPLIT_LIGHTING
        #endif
        
        // This shader support recursive rendering for raytracing
        #define HAVE_RECURSIVE_RENDERING
        
        // In Path Tracing, For all single-sided, refractive materials, we want to force a thin refraction model
        #if (SHADERPASS == SHADERPASS_PATH_TRACING) && !defined(_DOUBLESIDED_ON) && (defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE))
            #undef  _REFRACTION_PLANE
            #undef  _REFRACTION_SPHERE
            #define _REFRACTION_THIN
        #endif
            // Caution: we can use the define SHADER_UNLIT onlit after the above Material include as it is the Unlit template who define it
        
            // To handle SSR on transparent correctly with a possibility to enable/disable it per framesettings
            // we should have a code like this:
            // if !defined(_DISABLE_SSR_TRANSPARENT)
            // pragma multi_compile _ WRITE_NORMAL_BUFFER
            // endif
            // i.e we enable the multicompile only if we can receive SSR or not, and then C# code drive
            // it based on if SSR transparent in frame settings and not (and stripper can strip it).
            // this is currently not possible with our current preprocessor as _DISABLE_SSR_TRANSPARENT is a keyword not a define
            // so instead we used this and chose to pay the extra cost of normal write even if SSR transaprent is disabled.
            // Ideally the shader graph generator should handle it but condition below can't be handle correctly for now.
            #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
            #if !defined(_DISABLE_SSR_TRANSPARENT) && !defined(SHADER_UNLIT)
                #define WRITE_NORMAL_BUFFER
            #endif
            #endif
        
            // See Lit.shader
            #if SHADERPASS == SHADERPASS_MOTION_VECTORS && defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)
                #define WRITE_DECAL_BUFFER
            #endif
        
            #ifndef DEBUG_DISPLAY
                // In case of opaque we don't want to perform the alpha test, it is done in depth prepass and we use depth equal for ztest (setup from UI)
                // Don't do it with debug display mode as it is possible there is no depth prepass in this case
                #if !defined(_SURFACE_TYPE_TRANSPARENT)
                    #if SHADERPASS == SHADERPASS_FORWARD
                    #define SHADERPASS_FORWARD_BYPASS_ALPHA_TEST
                    #elif SHADERPASS == SHADERPASS_GBUFFER
                    #define SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST
                    #endif
                #endif
            #endif
        
            // Define _DEFERRED_CAPABLE_MATERIAL for shader capable to run in deferred pass
            #if defined(SHADER_LIT) && !defined(_SURFACE_TYPE_TRANSPARENT)
                #define _DEFERRED_CAPABLE_MATERIAL
            #endif
        
            // Translate transparent motion vector define
            #if (defined(_TRANSPARENT_WRITES_MOTION_VEC) || defined(_TRANSPARENT_REFRACTIVE_SORT)) && defined(_SURFACE_TYPE_TRANSPARENT)
                #define _WRITE_TRANSPARENT_MOTION_VECTOR
            #endif
        
            // -- Graph Properties
            CBUFFER_START(UnityPerMaterial)
        float4 _DiffusionProfileAsset;
        float _DiffusionProfileHash;
        float4 _Texture2D_TexelSize;
        float4 _Albedo;
        float _Smoothness;
        float _WindSpeed;
        float _WindStrength;
        float4 _Normal_TexelSize;
        float _NormalStrength;
        float4 _EmissionColor;
        float _UseShadowThreshold;
        float4 _DoubleSidedConstants;
        float _BlendMode;
        float _EnableBlendModePreserveSpecularLighting;
        float _RayTracing;
        float _RefractionModel;
        float _MaterialID;
        float _MaterialTypeMask;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_Texture2D);
        SAMPLER(sampler_Texture2D);
        TEXTURE2D(_Normal);
        SAMPLER(sampler_Normal);
        
            // -- Property used by ScenePickingPass
            #ifdef SCENEPICKINGPASS
            float4 _SelectionID;
            #endif
        
            // -- Properties used by SceneSelectionPass
            #ifdef SCENESELECTIONPASS
            int _ObjectId;
            int _PassValue;
            #endif
        
            // Includes
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingMacros.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/ShaderVariablesRaytracing.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/ShaderVariablesRaytracingLightLoop.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingIntersection.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/LightLoop/LightLoopDef.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitRayTracing.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingLightLoop.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RayTracingCommon.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"
        	// GraphIncludes: <None>
        
            // --------------------------------------------------
            // Structs and Packing
        
            struct SurfaceDescriptionInputs
        {
             float3 TangentSpaceNormal;
             float4 uv0;
        };
        
            //Interpolator Packs: <None>
        
            // --------------------------------------------------
            // Graph
        
        
            // Graph Functions
            
        void Unity_Multiply_float4_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
            // Graph Vertex
            // GraphVertex: <None>
        
            // Graph Pixel
            struct SurfaceDescription
        {
            float3 BaseColor;
            float3 Emission;
            float Alpha;
            float AlphaClipThreshold;
            float3 BentNormal;
            float Smoothness;
            float Occlusion;
            float3 NormalTS;
            float TransmissionMask;
            float Thickness;
            float DiffusionProfileHash;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float4 _Property_35c125abbbcb46e1a2351d8febeb5da1_Out_0_Vector4 = _Albedo;
            UnityTexture2D _Property_bb313b600ca3404fb88a2820878a8482_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Texture2D);
            float4 _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_bb313b600ca3404fb88a2820878a8482_Out_0_Texture2D.tex, _Property_bb313b600ca3404fb88a2820878a8482_Out_0_Texture2D.samplerstate, _Property_bb313b600ca3404fb88a2820878a8482_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_R_4_Float = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4.r;
            float _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_G_5_Float = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4.g;
            float _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_B_6_Float = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4.b;
            float _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_A_7_Float = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4.a;
            float4 _Multiply_c09cca22f04c4a9a996a5ccf8f61afe1_Out_2_Vector4;
            Unity_Multiply_float4_float4(_Property_35c125abbbcb46e1a2351d8febeb5da1_Out_0_Vector4, _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4, _Multiply_c09cca22f04c4a9a996a5ccf8f61afe1_Out_2_Vector4);
            float _Property_925f8cb589d94edda2dcd6b588187f26_Out_0_Float = _Smoothness;
            float _Multiply_a061075fe3794cc5abff5f173997f7f8_Out_2_Float;
            Unity_Multiply_float_float(_Property_925f8cb589d94edda2dcd6b588187f26_Out_0_Float, _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_G_5_Float, _Multiply_a061075fe3794cc5abff5f173997f7f8_Out_2_Float);
            UnityTexture2D _Property_ff2eff189fa74f1f965ec8aca53205ba_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Normal);
            float4 _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_ff2eff189fa74f1f965ec8aca53205ba_Out_0_Texture2D.tex, _Property_ff2eff189fa74f1f965ec8aca53205ba_Out_0_Texture2D.samplerstate, _Property_ff2eff189fa74f1f965ec8aca53205ba_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.rgb = UnpackNormal(_SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4);
            float _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_R_4_Float = _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.r;
            float _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_G_5_Float = _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.g;
            float _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_B_6_Float = _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.b;
            float _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_A_7_Float = _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.a;
            float _Property_915c3b0b5fc04c668c646f2f67b5ab2b_Out_0_Float = _NormalStrength;
            float4 _Multiply_e38eea28614c4b61bfd135ec8591a746_Out_2_Vector4;
            Unity_Multiply_float4_float4(_SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4, (_Property_915c3b0b5fc04c668c646f2f67b5ab2b_Out_0_Float.xxxx), _Multiply_e38eea28614c4b61bfd135ec8591a746_Out_2_Vector4);
            surface.BaseColor = (_Multiply_c09cca22f04c4a9a996a5ccf8f61afe1_Out_2_Vector4.xyz);
            surface.Emission = float3(0, 0, 0);
            surface.Alpha = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_A_7_Float;
            surface.AlphaClipThreshold = 0.5;
            surface.BentNormal = IN.TangentSpaceNormal;
            surface.Smoothness = _Multiply_a061075fe3794cc5abff5f173997f7f8_Out_2_Float;
            surface.Occlusion = 1;
            surface.NormalTS = (_Multiply_e38eea28614c4b61bfd135ec8591a746_Out_2_Vector4.xyz);
            surface.TransmissionMask = 1;
            surface.Thickness = 1;
            surface.DiffusionProfileHash = _DiffusionProfileHash;
            return surface;
        }
        
            // --------------------------------------------------
            // Build Graph Inputs
            #ifdef HAVE_VFX_MODIFICATION
            #define VFX_SRP_ATTRIBUTES AttributesMesh
            #define VaryingsMeshType VaryingsMeshToPS
            #define VFX_SRP_VARYINGS VaryingsMeshType
            #define VFX_SRP_SURFACE_INPUTS FragInputs
            #endif
            SurfaceDescriptionInputs FragInputsToSurfaceDescriptionInputs(FragInputs input, float3 viewWS)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
            #if defined(SHADER_STAGE_RAY_TRACING)
            #else
            #endif
            output.TangentSpaceNormal =                         float3(0.0f, 0.0f, 1.0f);
        
        #if UNITY_UV_STARTS_AT_TOP
        #else
        #endif
        
        
            output.uv0 =                                        input.texCoord0;
        
            // splice point to copy frag inputs custom interpolator pack into the SDI
            /* WARNING: $splice Could not find named fragment 'CustomInterpolatorCopyToSDI' */
        
            return output;
        }
        
            // --------------------------------------------------
            // Build Surface Data (Specific Material)
        
        void ApplyDecalToSurfaceDataNoNormal(DecalSurfaceData decalSurfaceData, inout SurfaceData surfaceData);
        
        void ApplyDecalAndGetNormal(FragInputs fragInputs, PositionInputs posInput, SurfaceDescription surfaceDescription,
            inout SurfaceData surfaceData)
        {
            float3 doubleSidedConstants = GetDoubleSidedConstants();
        
        #ifdef DECAL_NORMAL_BLENDING
            // SG nodes don't ouptut surface gradients, so if decals require surf grad blending, we have to convert
            // the normal to gradient before applying the decal. We then have to resolve the gradient back to world space
            float3 normalTS;
        
            normalTS = SurfaceGradientFromTangentSpaceNormalAndFromTBN(surfaceDescription.NormalTS,
            fragInputs.tangentToWorld[0], fragInputs.tangentToWorld[1]);
        
        
            #if HAVE_DECALS
            if (_EnableDecals)
            {
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                ApplyDecalToSurfaceNormal(decalSurfaceData, fragInputs.tangentToWorld[2], normalTS);
                ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
            }
            #endif
        
            GetNormalWS_SG(fragInputs, normalTS, surfaceData.normalWS, doubleSidedConstants);
        #else
            // normal delivered to master node
            GetNormalWS(fragInputs, surfaceDescription.NormalTS, surfaceData.normalWS, doubleSidedConstants);
        
            #if HAVE_DECALS
            if (_EnableDecals)
            {
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                // Both uses and modifies 'surfaceData.normalWS'.
                DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                ApplyDecalToSurfaceNormal(decalSurfaceData, surfaceData.normalWS.xyz);
                ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
            }
            #endif
        #endif
        }
        void BuildSurfaceData(FragInputs fragInputs, inout SurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
        {
            ZERO_INITIALIZE(SurfaceData, surfaceData);
        
            // specularOcclusion need to be init ahead of decal to quiet the compiler that modify the SurfaceData struct
            // however specularOcclusion can come from the graph, so need to be init here so it can be override.
            surfaceData.specularOcclusion = 1.0;
            surfaceData.thickness = 0.0;
        
            surfaceData.baseColor =                 surfaceDescription.BaseColor;
            surfaceData.perceptualSmoothness =      surfaceDescription.Smoothness;
            surfaceData.ambientOcclusion =          surfaceDescription.Occlusion;
            surfaceData.transmissionMask =          surfaceDescription.TransmissionMask.xxx;
            surfaceData.thickness =                 surfaceDescription.Thickness;
            surfaceData.diffusionProfileHash =      asuint(surfaceDescription.DiffusionProfileHash);
        
            #if defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE) || defined(_REFRACTION_THIN)
                if (_EnableSSRefraction)
                {
        
                    surfaceData.transmittanceMask = (1.0 - surfaceDescription.Alpha);
                    surfaceDescription.Alpha = 1.0;
                }
                else
                {
                    surfaceData.ior = 1.0;
                    surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                    surfaceData.atDistance = 1.0;
                    surfaceData.transmittanceMask = 0.0;
                    surfaceDescription.Alpha = 1.0;
                }
            #else
                surfaceData.ior = 1.0;
                surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                surfaceData.atDistance = 1.0;
                surfaceData.transmittanceMask = 0.0;
            #endif
        
            // These static material feature allow compile time optimization
            surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;
            #ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
            #endif
        
            #ifdef _MATERIAL_FEATURE_TRANSMISSION
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
            #endif
        
            #ifdef _MATERIAL_FEATURE_COLORED_TRANSMISSION
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_COLORED_TRANSMISSION;
        
            #endif
        
            #ifdef _MATERIAL_FEATURE_ANISOTROPY
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
        
                // Initialize the normal to something non-zero to avoid a div-zero warning for anisotropy.
                surfaceData.normalWS = float3(0, 1, 0);
            #endif
        
            #ifdef _MATERIAL_FEATURE_IRIDESCENCE
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
            #endif
        
            #ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
            #endif
        
            #ifdef _MATERIAL_FEATURE_CLEAR_COAT
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
            #endif
        
            #if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
                // Require to have setup baseColor
                // Reproduce the energy conservation done in legacy Unity. Not ideal but better for compatibility and users can unchek it
                surfaceData.baseColor *= (1.0 - Max3(surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b));
            #endif
        
            float3 doubleSidedConstants = GetDoubleSidedConstants();
        
            ApplyDecalAndGetNormal(fragInputs, posInput, surfaceDescription, surfaceData);
        
            surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];
        
            surfaceData.tangentWS = normalize(fragInputs.tangentToWorld[0].xyz);    // The tangent is not normalize in tangentToWorld for mikkt. TODO: Check if it expected that we normalize with Morten. Tag: SURFACE_GRADIENT
        
        
            bentNormalWS = surfaceData.normalWS;
        
            surfaceData.tangentWS = Orthonormalize(surfaceData.tangentWS, surfaceData.normalWS);
        
            #ifdef DEBUG_DISPLAY
                if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
                {
                    // TODO: need to update mip info
                    surfaceData.metallic = 0;
                }
        
                // We need to call ApplyDebugToSurfaceData after filling the surfarcedata and before filling builtinData
                // as it can modify attribute use for static lighting
                ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData);
            #endif
        
            // By default we use the ambient occlusion with Tri-ace trick (apply outside) for specular occlusion.
            // If user provide bent normal then we process a better term
            #if defined(_SPECULAR_OCCLUSION_CUSTOM)
                // Just use the value passed through via the slot (not active otherwise)
            #elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
                // If we have bent normal and ambient occlusion, process a specular occlusion
                surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO(V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness(surfaceData.perceptualSmoothness));
            #elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
                surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion(ClampNdotV(dot(surfaceData.normalWS, V)), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness(surfaceData.perceptualSmoothness));
            #endif
        
            #if defined(_ENABLE_GEOMETRIC_SPECULAR_AA) && !defined(SHADER_STAGE_RAY_TRACING)
                surfaceData.perceptualSmoothness = GeometricNormalFiltering(surfaceData.perceptualSmoothness, fragInputs.tangentToWorld[2], surfaceDescription.SpecularAAScreenSpaceVariance, surfaceDescription.SpecularAAThreshold);
            #endif
        }
        
            // --------------------------------------------------
            // Get Surface And BuiltinData
        
            void GetSurfaceAndBuiltinData(FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData RAY_TRACING_OPTIONAL_PARAMETERS)
            {
                // Don't dither if displaced tessellation (we're fading out the displacement instead to match the next LOD)
                #if !defined(SHADER_STAGE_RAY_TRACING) && !defined(_TESSELLATION_DISPLACEMENT)
                #ifdef LOD_FADE_CROSSFADE // enable dithering LOD transition if user select CrossFade transition in LOD group
                LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
                #endif
                #endif
        
                #ifndef SHADER_UNLIT
                #ifdef _DOUBLESIDED_ON
                    float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
                #else
                    float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
                #endif
        
                ApplyDoubleSidedFlipOrMirror(fragInputs, doubleSidedConstants); // Apply double sided flip on the vertex normal
                #endif // SHADER_UNLIT
        
                SurfaceDescriptionInputs surfaceDescriptionInputs = FragInputsToSurfaceDescriptionInputs(fragInputs, V);
        
                #if defined(HAVE_VFX_MODIFICATION)
                GraphProperties properties;
                ZERO_INITIALIZE(GraphProperties, properties);
        
                GetElementPixelProperties(fragInputs, properties);
        
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs, properties);
                #else
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs);
                #endif
        
                // Perform alpha test very early to save performance (a killed pixel will not sample textures)
                // TODO: split graph evaluation to grab just alpha dependencies first? tricky..
                #ifdef _ALPHATEST_ON
                    float alphaCutoff = surfaceDescription.AlphaClipThreshold;
                    #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
                    // The TransparentDepthPrepass is also used with SSR transparent.
                    // If an artists enable transaprent SSR but not the TransparentDepthPrepass itself, then we use AlphaClipThreshold
                    // otherwise if TransparentDepthPrepass is enabled we use AlphaClipThresholdDepthPrepass
                    #elif SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_POSTPASS
                    // DepthPostpass always use its own alpha threshold
                    alphaCutoff = surfaceDescription.AlphaClipThresholdDepthPostpass;
                    #elif (SHADERPASS == SHADERPASS_SHADOWS) || (SHADERPASS == SHADERPASS_RAYTRACING_VISIBILITY)
                    // If use shadow threshold isn't enable we don't allow any test
                    #endif
        
                    GENERIC_ALPHA_TEST(surfaceDescription.Alpha, alphaCutoff);
                #endif
        
                #if !defined(SHADER_STAGE_RAY_TRACING) && _DEPTHOFFSET_ON
                ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
                #endif
        
                #ifndef SHADER_UNLIT
                float3 bentNormalWS;
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS);
        
                #ifdef FRAG_INPUTS_USE_TEXCOORD1
                    float4 lightmapTexCoord1 = fragInputs.texCoord1;
                #else
                    float4 lightmapTexCoord1 = float4(0,0,0,0);
                #endif
        
                #ifdef FRAG_INPUTS_USE_TEXCOORD2
                    float4 lightmapTexCoord2 = fragInputs.texCoord2;
                #else
                    float4 lightmapTexCoord2 = float4(0,0,0,0);
                #endif
        
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                // Builtin Data
                // For back lighting we use the oposite vertex normal
                InitBuiltinData(posInput, alpha, bentNormalWS, -fragInputs.tangentToWorld[2], lightmapTexCoord1, lightmapTexCoord2, builtinData);
        
                #else
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData);
        
                ZERO_BUILTIN_INITIALIZE(builtinData); // No call to InitBuiltinData as we don't have any lighting
                builtinData.opacity = surfaceDescription.Alpha;
        
                #if defined(DEBUG_DISPLAY)
                    // Light Layers are currently not used for the Unlit shader (because it is not lit)
                    // But Unlit objects do cast shadows according to their rendering layer mask, which is what we want to
                    // display in the light layers visualization mode, therefore we need the renderingLayers
                    builtinData.renderingLayers = GetMeshRenderingLayerMask();
                #endif
        
                #endif // SHADER_UNLIT
        
                #ifdef _ALPHATEST_ON
                    // Used for sharpening by alpha to mask - Alpha to covertage is only used with depth only and forward pass (no shadow pass, no transparent pass)
                    builtinData.alphaClipTreshold = alphaCutoff;
                #endif
        
                // override sampleBakedGI - not used by Unlit
        		// When overriding GI, we need to force the isLightmap flag to make sure we don't add APV (sampled in the lightloop) on top of the overridden value (set at GBuffer stage)
        
                builtinData.emissiveColor = surfaceDescription.Emission;
        
                // Note this will not fully work on transparent surfaces (can check with _SURFACE_TYPE_TRANSPARENT define)
                // We will always overwrite vt feeback with the nearest. So behind transparent surfaces vt will not be resolved
                // This is a limitation of the current MRT approach.
                #ifdef UNITY_VIRTUAL_TEXTURING
                #endif
        
                #if _DEPTHOFFSET_ON
                builtinData.depthOffset = surfaceDescription.DepthOffset;
                #endif
        
                // TODO: We should generate distortion / distortionBlur for non distortion pass
                #if (SHADERPASS == SHADERPASS_DISTORTION)
                builtinData.distortion = surfaceDescription.Distortion;
                builtinData.distortionBlur = surfaceDescription.DistortionBlur;
                #endif
        
                #ifndef SHADER_UNLIT
                // PostInitBuiltinData call ApplyDebugToBuiltinData
                PostInitBuiltinData(V, posInput, surfaceData, builtinData);
                #else
                ApplyDebugToBuiltinData(builtinData);
                #endif
        
                RAY_TRACING_OPTIONAL_ALPHA_TEST_PASS
            }
        
            // --------------------------------------------------
            // Main
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPassRaytracingForward.hlsl"
        
            // --------------------------------------------------
            // Visual Effect Vertex Invocations
        
        	#ifdef HAVE_VFX_MODIFICATION
                #if !defined(SHADER_STAGE_RAY_TRACING)
        	    #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/VisualEffectVertex.hlsl"
                #else
                #endif
        	#endif
        
            #include "Assets/VegetationInstancer/Shaders/Include/GPUInstancedIndirectInclude.cginc"
#pragma instancing_options procedural:setupGPUInstancedIndirect
#pragma multi_compile_instancing
ENDHLSL
        }
        Pass
        {
            Name "GBufferDXR"
            Tags
            {
                "LightMode" = "GBufferDXR"
            }
        
            // Render State
            // RenderState: <None>
        
            // Debug
            // <None>
        
            // --------------------------------------------------
            // Pass
        
            HLSLPROGRAM
        
            // Pragmas
            #pragma target 5.0
        #pragma raytracing surface_shader
        #pragma only_renderers d3d11 xboxseries ps5
        
            // Keywords
            #pragma multi_compile _ MINIMAL_GBUFFER
        #pragma shader_feature_local _ _ALPHATEST_ON
        #pragma shader_feature _ _SURFACE_TYPE_TRANSPARENT
        #pragma shader_feature_local _ _DOUBLESIDED_ON
        #pragma shader_feature_local _ _ADD_PRECOMPUTED_VELOCITY
        #pragma shader_feature_local _ _TRANSPARENT_WRITES_MOTION_VEC _TRANSPARENT_REFRACTIVE_SORT
        #pragma shader_feature_local_fragment _ _ENABLE_FOG_ON_TRANSPARENT
        #pragma multi_compile _ DEBUG_DISPLAY
        #pragma shader_feature_local_fragment _ _DISABLE_DECALS
        #pragma shader_feature_local_raytracing _ _DISABLE_DECALS
        #pragma shader_feature_local_fragment _ _DISABLE_SSR
        #pragma shader_feature_local_raytracing _ _DISABLE_SSR
        #pragma shader_feature_local_fragment _ _DISABLE_SSR_TRANSPARENT
        #pragma shader_feature_local_raytracing _ _DISABLE_SSR_TRANSPARENT
        #pragma multi_compile _ LIGHTMAP_ON
        #pragma multi_compile _ DIRLIGHTMAP_COMBINED
        #pragma multi_compile_fragment _ PROBE_VOLUMES_L1 PROBE_VOLUMES_L2
        #pragma multi_compile_raytracing _ PROBE_VOLUMES_L1 PROBE_VOLUMES_L2
        #pragma multi_compile _ DYNAMICLIGHTMAP_ON
        #pragma shader_feature_local _ _REFRACTION_PLANE _REFRACTION_SPHERE _REFRACTION_THIN
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_TRANSMISSION
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_TRANSMISSION
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_ANISOTROPY
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_ANISOTROPY
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_IRIDESCENCE
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_IRIDESCENCE
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_SPECULAR_COLOR
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_SPECULAR_COLOR
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_COLORED_TRANSMISSION
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_COLORED_TRANSMISSION
            // GraphKeywords: <None>
        
            // Defines
            #define SHADERPASS SHADERPASS_RAYTRACING_GBUFFER
        #define PUNCTUAL_SHADOW_LOW
        #define DIRECTIONAL_SHADOW_LOW
        #define RAYTRACING_SHADER_GRAPH_RAYTRACED
        
            // For custom interpolators to inject a substruct definition before FragInputs definition,
            // allowing for FragInputs to capture CI's intended for ShaderGraph's SDI.
            /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreInclude' */
        
        
            // TODO: Merge FragInputsVFX substruct with CustomInterpolators.
        	#ifdef HAVE_VFX_MODIFICATION
        	struct FragInputsVFX
            {
                /* WARNING: $splice Could not find named fragment 'FragInputsVFX' */
            };
            #endif
        
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl" // Required by Tessellation.hlsl
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Tessellation.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl" // Required to be include before we include properties as it define DECLARE_STACK_CB
            // Always include Shader Graph version
            // Always include last to avoid double macros
            #include "Packages/com.unity.shadergraph/ShaderGraphLibrary/Functions.hlsl" // Need to be here for Gradient struct definition
        
            // --------------------------------------------------
            // Defines
        
            // Attribute
            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define ATTRIBUTES_NEED_TEXCOORD0
            #define ATTRIBUTES_NEED_TEXCOORD1
            #define ATTRIBUTES_NEED_TEXCOORD2
            #define VARYINGS_NEED_POSITION_WS
            #define VARYINGS_NEED_TANGENT_TO_WORLD
            #define VARYINGS_NEED_TEXCOORD0
            #define VARYINGS_NEED_TEXCOORD1
            #define VARYINGS_NEED_TEXCOORD2
        
        
            //Strip down the FragInputs.hlsl (on graphics), so we can only optimize the interpolators we use.
            //if by accident something requests contents of FragInputs.hlsl, it will be caught as a compiler error
            //Frag inputs stripping is only enabled when FRAG_INPUTS_ENABLE_STRIPPING is set
            #if !defined(SHADER_STAGE_RAY_TRACING) && SHADERPASS != SHADERPASS_RAYTRACING_GBUFFER && SHADERPASS != SHADERPASS_FULL_SCREEN_DEBUG
            #define FRAG_INPUTS_ENABLE_STRIPPING
            #endif
            #define FRAG_INPUTS_USE_TEXCOORD0
            #define FRAG_INPUTS_USE_TEXCOORD1
            #define FRAG_INPUTS_USE_TEXCOORD2
        
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
        
        
        
        
            // Following two define are a workaround introduce in 10.1.x for RaytracingQualityNode
            // The ShaderGraph don't support correctly migration of this node as it serialize all the node data
            // in the json file making it impossible to uprgrade. Until we get a fix, we do a workaround here
            // to still allow us to rename the field and keyword of this node without breaking existing code.
            #ifdef RAYTRACING_SHADER_GRAPH_DEFAULT
            #define RAYTRACING_SHADER_GRAPH_HIGH
            #endif
        
            #ifdef RAYTRACING_SHADER_GRAPH_RAYTRACED
            #define RAYTRACING_SHADER_GRAPH_LOW
            #endif
            // end
        
            #ifndef SHADER_UNLIT
            // We need isFrontFace when using double sided - it is not required for unlit as in case of unlit double sided only drive the cullmode
            // VARYINGS_NEED_CULLFACE can be define by VaryingsMeshToPS.FaceSign input if a IsFrontFace Node is included in the shader graph.
            #if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
                #define VARYINGS_NEED_CULLFACE
            #endif
            #endif
        
            // Specific Material Define
        #define _SPECULAR_OCCLUSION_FROM_AO 1
        #define _ENERGY_CONSERVING_SPECULAR 1
        
        #if _MATERIAL_FEATURE_COLORED_TRANSMISSION
            // Colored Transmission doesn't support clear coat
            #undef _MATERIAL_FEATURE_CLEAR_COAT
        #endif
        
        // If we use subsurface scattering, enable output split lighting (for forward pass)
        #if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
            #define OUTPUT_SPLIT_LIGHTING
        #endif
        
        // This shader support recursive rendering for raytracing
        #define HAVE_RECURSIVE_RENDERING
        
        // In Path Tracing, For all single-sided, refractive materials, we want to force a thin refraction model
        #if (SHADERPASS == SHADERPASS_PATH_TRACING) && !defined(_DOUBLESIDED_ON) && (defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE))
            #undef  _REFRACTION_PLANE
            #undef  _REFRACTION_SPHERE
            #define _REFRACTION_THIN
        #endif
            // Caution: we can use the define SHADER_UNLIT onlit after the above Material include as it is the Unlit template who define it
        
            // To handle SSR on transparent correctly with a possibility to enable/disable it per framesettings
            // we should have a code like this:
            // if !defined(_DISABLE_SSR_TRANSPARENT)
            // pragma multi_compile _ WRITE_NORMAL_BUFFER
            // endif
            // i.e we enable the multicompile only if we can receive SSR or not, and then C# code drive
            // it based on if SSR transparent in frame settings and not (and stripper can strip it).
            // this is currently not possible with our current preprocessor as _DISABLE_SSR_TRANSPARENT is a keyword not a define
            // so instead we used this and chose to pay the extra cost of normal write even if SSR transaprent is disabled.
            // Ideally the shader graph generator should handle it but condition below can't be handle correctly for now.
            #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
            #if !defined(_DISABLE_SSR_TRANSPARENT) && !defined(SHADER_UNLIT)
                #define WRITE_NORMAL_BUFFER
            #endif
            #endif
        
            // See Lit.shader
            #if SHADERPASS == SHADERPASS_MOTION_VECTORS && defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)
                #define WRITE_DECAL_BUFFER
            #endif
        
            #ifndef DEBUG_DISPLAY
                // In case of opaque we don't want to perform the alpha test, it is done in depth prepass and we use depth equal for ztest (setup from UI)
                // Don't do it with debug display mode as it is possible there is no depth prepass in this case
                #if !defined(_SURFACE_TYPE_TRANSPARENT)
                    #if SHADERPASS == SHADERPASS_FORWARD
                    #define SHADERPASS_FORWARD_BYPASS_ALPHA_TEST
                    #elif SHADERPASS == SHADERPASS_GBUFFER
                    #define SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST
                    #endif
                #endif
            #endif
        
            // Define _DEFERRED_CAPABLE_MATERIAL for shader capable to run in deferred pass
            #if defined(SHADER_LIT) && !defined(_SURFACE_TYPE_TRANSPARENT)
                #define _DEFERRED_CAPABLE_MATERIAL
            #endif
        
            // Translate transparent motion vector define
            #if (defined(_TRANSPARENT_WRITES_MOTION_VEC) || defined(_TRANSPARENT_REFRACTIVE_SORT)) && defined(_SURFACE_TYPE_TRANSPARENT)
                #define _WRITE_TRANSPARENT_MOTION_VECTOR
            #endif
        
            // -- Graph Properties
            CBUFFER_START(UnityPerMaterial)
        float4 _DiffusionProfileAsset;
        float _DiffusionProfileHash;
        float4 _Texture2D_TexelSize;
        float4 _Albedo;
        float _Smoothness;
        float _WindSpeed;
        float _WindStrength;
        float4 _Normal_TexelSize;
        float _NormalStrength;
        float4 _EmissionColor;
        float _UseShadowThreshold;
        float4 _DoubleSidedConstants;
        float _BlendMode;
        float _EnableBlendModePreserveSpecularLighting;
        float _RayTracing;
        float _RefractionModel;
        float _MaterialID;
        float _MaterialTypeMask;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_Texture2D);
        SAMPLER(sampler_Texture2D);
        TEXTURE2D(_Normal);
        SAMPLER(sampler_Normal);
        
            // -- Property used by ScenePickingPass
            #ifdef SCENEPICKINGPASS
            float4 _SelectionID;
            #endif
        
            // -- Properties used by SceneSelectionPass
            #ifdef SCENESELECTIONPASS
            int _ObjectId;
            int _PassValue;
            #endif
        
            // Includes
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingMacros.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/ShaderVariablesRaytracing.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/ShaderVariablesRaytracingLightLoop.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/Deferred/RaytracingIntersectonGBuffer.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/StandardLit/StandardLit.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitRayTracing.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RayTracingCommon.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"
        	// GraphIncludes: <None>
        
            // --------------------------------------------------
            // Structs and Packing
        
            struct SurfaceDescriptionInputs
        {
             float3 TangentSpaceNormal;
             float4 uv0;
        };
        
            //Interpolator Packs: <None>
        
            // --------------------------------------------------
            // Graph
        
        
            // Graph Functions
            
        void Unity_Multiply_float4_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
            // Graph Vertex
            // GraphVertex: <None>
        
            // Graph Pixel
            struct SurfaceDescription
        {
            float3 BaseColor;
            float3 Emission;
            float Alpha;
            float AlphaClipThreshold;
            float3 BentNormal;
            float Smoothness;
            float Occlusion;
            float3 NormalTS;
            float TransmissionMask;
            float Thickness;
            float DiffusionProfileHash;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float4 _Property_35c125abbbcb46e1a2351d8febeb5da1_Out_0_Vector4 = _Albedo;
            UnityTexture2D _Property_bb313b600ca3404fb88a2820878a8482_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Texture2D);
            float4 _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_bb313b600ca3404fb88a2820878a8482_Out_0_Texture2D.tex, _Property_bb313b600ca3404fb88a2820878a8482_Out_0_Texture2D.samplerstate, _Property_bb313b600ca3404fb88a2820878a8482_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_R_4_Float = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4.r;
            float _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_G_5_Float = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4.g;
            float _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_B_6_Float = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4.b;
            float _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_A_7_Float = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4.a;
            float4 _Multiply_c09cca22f04c4a9a996a5ccf8f61afe1_Out_2_Vector4;
            Unity_Multiply_float4_float4(_Property_35c125abbbcb46e1a2351d8febeb5da1_Out_0_Vector4, _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4, _Multiply_c09cca22f04c4a9a996a5ccf8f61afe1_Out_2_Vector4);
            float _Property_925f8cb589d94edda2dcd6b588187f26_Out_0_Float = _Smoothness;
            float _Multiply_a061075fe3794cc5abff5f173997f7f8_Out_2_Float;
            Unity_Multiply_float_float(_Property_925f8cb589d94edda2dcd6b588187f26_Out_0_Float, _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_G_5_Float, _Multiply_a061075fe3794cc5abff5f173997f7f8_Out_2_Float);
            UnityTexture2D _Property_ff2eff189fa74f1f965ec8aca53205ba_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Normal);
            float4 _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_ff2eff189fa74f1f965ec8aca53205ba_Out_0_Texture2D.tex, _Property_ff2eff189fa74f1f965ec8aca53205ba_Out_0_Texture2D.samplerstate, _Property_ff2eff189fa74f1f965ec8aca53205ba_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.rgb = UnpackNormal(_SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4);
            float _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_R_4_Float = _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.r;
            float _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_G_5_Float = _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.g;
            float _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_B_6_Float = _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.b;
            float _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_A_7_Float = _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.a;
            float _Property_915c3b0b5fc04c668c646f2f67b5ab2b_Out_0_Float = _NormalStrength;
            float4 _Multiply_e38eea28614c4b61bfd135ec8591a746_Out_2_Vector4;
            Unity_Multiply_float4_float4(_SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4, (_Property_915c3b0b5fc04c668c646f2f67b5ab2b_Out_0_Float.xxxx), _Multiply_e38eea28614c4b61bfd135ec8591a746_Out_2_Vector4);
            surface.BaseColor = (_Multiply_c09cca22f04c4a9a996a5ccf8f61afe1_Out_2_Vector4.xyz);
            surface.Emission = float3(0, 0, 0);
            surface.Alpha = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_A_7_Float;
            surface.AlphaClipThreshold = 0.5;
            surface.BentNormal = IN.TangentSpaceNormal;
            surface.Smoothness = _Multiply_a061075fe3794cc5abff5f173997f7f8_Out_2_Float;
            surface.Occlusion = 1;
            surface.NormalTS = (_Multiply_e38eea28614c4b61bfd135ec8591a746_Out_2_Vector4.xyz);
            surface.TransmissionMask = 1;
            surface.Thickness = 1;
            surface.DiffusionProfileHash = _DiffusionProfileHash;
            return surface;
        }
        
            // --------------------------------------------------
            // Build Graph Inputs
            #ifdef HAVE_VFX_MODIFICATION
            #define VFX_SRP_ATTRIBUTES AttributesMesh
            #define VaryingsMeshType VaryingsMeshToPS
            #define VFX_SRP_VARYINGS VaryingsMeshType
            #define VFX_SRP_SURFACE_INPUTS FragInputs
            #endif
            SurfaceDescriptionInputs FragInputsToSurfaceDescriptionInputs(FragInputs input, float3 viewWS)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
            #if defined(SHADER_STAGE_RAY_TRACING)
            #else
            #endif
            output.TangentSpaceNormal =                         float3(0.0f, 0.0f, 1.0f);
        
        #if UNITY_UV_STARTS_AT_TOP
        #else
        #endif
        
        
            output.uv0 =                                        input.texCoord0;
        
            // splice point to copy frag inputs custom interpolator pack into the SDI
            /* WARNING: $splice Could not find named fragment 'CustomInterpolatorCopyToSDI' */
        
            return output;
        }
        
            // --------------------------------------------------
            // Build Surface Data (Specific Material)
        
        void ApplyDecalToSurfaceDataNoNormal(DecalSurfaceData decalSurfaceData, inout SurfaceData surfaceData);
        
        void ApplyDecalAndGetNormal(FragInputs fragInputs, PositionInputs posInput, SurfaceDescription surfaceDescription,
            inout SurfaceData surfaceData)
        {
            float3 doubleSidedConstants = GetDoubleSidedConstants();
        
        #ifdef DECAL_NORMAL_BLENDING
            // SG nodes don't ouptut surface gradients, so if decals require surf grad blending, we have to convert
            // the normal to gradient before applying the decal. We then have to resolve the gradient back to world space
            float3 normalTS;
        
            normalTS = SurfaceGradientFromTangentSpaceNormalAndFromTBN(surfaceDescription.NormalTS,
            fragInputs.tangentToWorld[0], fragInputs.tangentToWorld[1]);
        
        
            #if HAVE_DECALS
            if (_EnableDecals)
            {
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                ApplyDecalToSurfaceNormal(decalSurfaceData, fragInputs.tangentToWorld[2], normalTS);
                ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
            }
            #endif
        
            GetNormalWS_SG(fragInputs, normalTS, surfaceData.normalWS, doubleSidedConstants);
        #else
            // normal delivered to master node
            GetNormalWS(fragInputs, surfaceDescription.NormalTS, surfaceData.normalWS, doubleSidedConstants);
        
            #if HAVE_DECALS
            if (_EnableDecals)
            {
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                // Both uses and modifies 'surfaceData.normalWS'.
                DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                ApplyDecalToSurfaceNormal(decalSurfaceData, surfaceData.normalWS.xyz);
                ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
            }
            #endif
        #endif
        }
        void BuildSurfaceData(FragInputs fragInputs, inout SurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
        {
            ZERO_INITIALIZE(SurfaceData, surfaceData);
        
            // specularOcclusion need to be init ahead of decal to quiet the compiler that modify the SurfaceData struct
            // however specularOcclusion can come from the graph, so need to be init here so it can be override.
            surfaceData.specularOcclusion = 1.0;
            surfaceData.thickness = 0.0;
        
            surfaceData.baseColor =                 surfaceDescription.BaseColor;
            surfaceData.perceptualSmoothness =      surfaceDescription.Smoothness;
            surfaceData.ambientOcclusion =          surfaceDescription.Occlusion;
            surfaceData.transmissionMask =          surfaceDescription.TransmissionMask.xxx;
            surfaceData.thickness =                 surfaceDescription.Thickness;
            surfaceData.diffusionProfileHash =      asuint(surfaceDescription.DiffusionProfileHash);
        
            #if defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE) || defined(_REFRACTION_THIN)
                if (_EnableSSRefraction)
                {
        
                    surfaceData.transmittanceMask = (1.0 - surfaceDescription.Alpha);
                    surfaceDescription.Alpha = 1.0;
                }
                else
                {
                    surfaceData.ior = 1.0;
                    surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                    surfaceData.atDistance = 1.0;
                    surfaceData.transmittanceMask = 0.0;
                    surfaceDescription.Alpha = 1.0;
                }
            #else
                surfaceData.ior = 1.0;
                surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                surfaceData.atDistance = 1.0;
                surfaceData.transmittanceMask = 0.0;
            #endif
        
            // These static material feature allow compile time optimization
            surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;
            #ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
            #endif
        
            #ifdef _MATERIAL_FEATURE_TRANSMISSION
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
            #endif
        
            #ifdef _MATERIAL_FEATURE_COLORED_TRANSMISSION
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_COLORED_TRANSMISSION;
        
            #endif
        
            #ifdef _MATERIAL_FEATURE_ANISOTROPY
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
        
                // Initialize the normal to something non-zero to avoid a div-zero warning for anisotropy.
                surfaceData.normalWS = float3(0, 1, 0);
            #endif
        
            #ifdef _MATERIAL_FEATURE_IRIDESCENCE
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
            #endif
        
            #ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
            #endif
        
            #ifdef _MATERIAL_FEATURE_CLEAR_COAT
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
            #endif
        
            #if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
                // Require to have setup baseColor
                // Reproduce the energy conservation done in legacy Unity. Not ideal but better for compatibility and users can unchek it
                surfaceData.baseColor *= (1.0 - Max3(surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b));
            #endif
        
            float3 doubleSidedConstants = GetDoubleSidedConstants();
        
            ApplyDecalAndGetNormal(fragInputs, posInput, surfaceDescription, surfaceData);
        
            surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];
        
            surfaceData.tangentWS = normalize(fragInputs.tangentToWorld[0].xyz);    // The tangent is not normalize in tangentToWorld for mikkt. TODO: Check if it expected that we normalize with Morten. Tag: SURFACE_GRADIENT
        
        
            bentNormalWS = surfaceData.normalWS;
        
            surfaceData.tangentWS = Orthonormalize(surfaceData.tangentWS, surfaceData.normalWS);
        
            #ifdef DEBUG_DISPLAY
                if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
                {
                    // TODO: need to update mip info
                    surfaceData.metallic = 0;
                }
        
                // We need to call ApplyDebugToSurfaceData after filling the surfarcedata and before filling builtinData
                // as it can modify attribute use for static lighting
                ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData);
            #endif
        
            // By default we use the ambient occlusion with Tri-ace trick (apply outside) for specular occlusion.
            // If user provide bent normal then we process a better term
            #if defined(_SPECULAR_OCCLUSION_CUSTOM)
                // Just use the value passed through via the slot (not active otherwise)
            #elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
                // If we have bent normal and ambient occlusion, process a specular occlusion
                surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO(V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness(surfaceData.perceptualSmoothness));
            #elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
                surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion(ClampNdotV(dot(surfaceData.normalWS, V)), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness(surfaceData.perceptualSmoothness));
            #endif
        
            #if defined(_ENABLE_GEOMETRIC_SPECULAR_AA) && !defined(SHADER_STAGE_RAY_TRACING)
                surfaceData.perceptualSmoothness = GeometricNormalFiltering(surfaceData.perceptualSmoothness, fragInputs.tangentToWorld[2], surfaceDescription.SpecularAAScreenSpaceVariance, surfaceDescription.SpecularAAThreshold);
            #endif
        }
        
            // --------------------------------------------------
            // Get Surface And BuiltinData
        
            void GetSurfaceAndBuiltinData(FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData RAY_TRACING_OPTIONAL_PARAMETERS)
            {
                // Don't dither if displaced tessellation (we're fading out the displacement instead to match the next LOD)
                #if !defined(SHADER_STAGE_RAY_TRACING) && !defined(_TESSELLATION_DISPLACEMENT)
                #ifdef LOD_FADE_CROSSFADE // enable dithering LOD transition if user select CrossFade transition in LOD group
                LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
                #endif
                #endif
        
                #ifndef SHADER_UNLIT
                #ifdef _DOUBLESIDED_ON
                    float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
                #else
                    float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
                #endif
        
                ApplyDoubleSidedFlipOrMirror(fragInputs, doubleSidedConstants); // Apply double sided flip on the vertex normal
                #endif // SHADER_UNLIT
        
                SurfaceDescriptionInputs surfaceDescriptionInputs = FragInputsToSurfaceDescriptionInputs(fragInputs, V);
        
                #if defined(HAVE_VFX_MODIFICATION)
                GraphProperties properties;
                ZERO_INITIALIZE(GraphProperties, properties);
        
                GetElementPixelProperties(fragInputs, properties);
        
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs, properties);
                #else
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs);
                #endif
        
                // Perform alpha test very early to save performance (a killed pixel will not sample textures)
                // TODO: split graph evaluation to grab just alpha dependencies first? tricky..
                #ifdef _ALPHATEST_ON
                    float alphaCutoff = surfaceDescription.AlphaClipThreshold;
                    #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
                    // The TransparentDepthPrepass is also used with SSR transparent.
                    // If an artists enable transaprent SSR but not the TransparentDepthPrepass itself, then we use AlphaClipThreshold
                    // otherwise if TransparentDepthPrepass is enabled we use AlphaClipThresholdDepthPrepass
                    #elif SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_POSTPASS
                    // DepthPostpass always use its own alpha threshold
                    alphaCutoff = surfaceDescription.AlphaClipThresholdDepthPostpass;
                    #elif (SHADERPASS == SHADERPASS_SHADOWS) || (SHADERPASS == SHADERPASS_RAYTRACING_VISIBILITY)
                    // If use shadow threshold isn't enable we don't allow any test
                    #endif
        
                    GENERIC_ALPHA_TEST(surfaceDescription.Alpha, alphaCutoff);
                #endif
        
                #if !defined(SHADER_STAGE_RAY_TRACING) && _DEPTHOFFSET_ON
                ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
                #endif
        
                #ifndef SHADER_UNLIT
                float3 bentNormalWS;
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS);
        
                #ifdef FRAG_INPUTS_USE_TEXCOORD1
                    float4 lightmapTexCoord1 = fragInputs.texCoord1;
                #else
                    float4 lightmapTexCoord1 = float4(0,0,0,0);
                #endif
        
                #ifdef FRAG_INPUTS_USE_TEXCOORD2
                    float4 lightmapTexCoord2 = fragInputs.texCoord2;
                #else
                    float4 lightmapTexCoord2 = float4(0,0,0,0);
                #endif
        
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                // Builtin Data
                // For back lighting we use the oposite vertex normal
                InitBuiltinData(posInput, alpha, bentNormalWS, -fragInputs.tangentToWorld[2], lightmapTexCoord1, lightmapTexCoord2, builtinData);
        
                #else
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData);
        
                ZERO_BUILTIN_INITIALIZE(builtinData); // No call to InitBuiltinData as we don't have any lighting
                builtinData.opacity = surfaceDescription.Alpha;
        
                #if defined(DEBUG_DISPLAY)
                    // Light Layers are currently not used for the Unlit shader (because it is not lit)
                    // But Unlit objects do cast shadows according to their rendering layer mask, which is what we want to
                    // display in the light layers visualization mode, therefore we need the renderingLayers
                    builtinData.renderingLayers = GetMeshRenderingLayerMask();
                #endif
        
                #endif // SHADER_UNLIT
        
                #ifdef _ALPHATEST_ON
                    // Used for sharpening by alpha to mask - Alpha to covertage is only used with depth only and forward pass (no shadow pass, no transparent pass)
                    builtinData.alphaClipTreshold = alphaCutoff;
                #endif
        
                // override sampleBakedGI - not used by Unlit
        		// When overriding GI, we need to force the isLightmap flag to make sure we don't add APV (sampled in the lightloop) on top of the overridden value (set at GBuffer stage)
        
                builtinData.emissiveColor = surfaceDescription.Emission;
        
                // Note this will not fully work on transparent surfaces (can check with _SURFACE_TYPE_TRANSPARENT define)
                // We will always overwrite vt feeback with the nearest. So behind transparent surfaces vt will not be resolved
                // This is a limitation of the current MRT approach.
                #ifdef UNITY_VIRTUAL_TEXTURING
                #endif
        
                #if _DEPTHOFFSET_ON
                builtinData.depthOffset = surfaceDescription.DepthOffset;
                #endif
        
                // TODO: We should generate distortion / distortionBlur for non distortion pass
                #if (SHADERPASS == SHADERPASS_DISTORTION)
                builtinData.distortion = surfaceDescription.Distortion;
                builtinData.distortionBlur = surfaceDescription.DistortionBlur;
                #endif
        
                #ifndef SHADER_UNLIT
                // PostInitBuiltinData call ApplyDebugToBuiltinData
                PostInitBuiltinData(V, posInput, surfaceData, builtinData);
                #else
                ApplyDebugToBuiltinData(builtinData);
                #endif
        
                RAY_TRACING_OPTIONAL_ALPHA_TEST_PASS
            }
        
            // --------------------------------------------------
            // Main
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPassRaytracingGBuffer.hlsl"
        
            // --------------------------------------------------
            // Visual Effect Vertex Invocations
        
        	#ifdef HAVE_VFX_MODIFICATION
                #if !defined(SHADER_STAGE_RAY_TRACING)
        	    #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/VisualEffectVertex.hlsl"
                #else
                #endif
        	#endif
        
            #include "Assets/VegetationInstancer/Shaders/Include/GPUInstancedIndirectInclude.cginc"
#pragma instancing_options procedural:setupGPUInstancedIndirect
#pragma multi_compile_instancing
ENDHLSL
        }
        Pass
        {
            Name "DebugDXR"
            Tags
            {
                "LightMode" = "DebugDXR"
            }
        
            // Debug
            // <None>
        
            // --------------------------------------------------
            // Pass
        
            HLSLPROGRAM
        
            // Pragmas
            #pragma target 5.0
        #pragma raytracing surface_shader
        #pragma only_renderers d3d11 xboxseries ps5
        
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
        
            // Includes
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingMacros.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/ShaderVariablesRaytracing.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingIntersection.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RayTracingCommon.hlsl"
        	// GraphIncludes: <None>
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPassRayTracingDebug.hlsl"
        
            #include "Assets/VegetationInstancer/Shaders/Include/GPUInstancedIndirectInclude.cginc"
#pragma instancing_options procedural:setupGPUInstancedIndirect
#pragma multi_compile_instancing
ENDHLSL
        }
        Pass
        {
            Name "PathTracingDXR"
            Tags
            {
                "LightMode" = "PathTracingDXR"
            }
        
            // Render State
            // RenderState: <None>
        
            // Debug
            // <None>
        
            // --------------------------------------------------
            // Pass
        
            HLSLPROGRAM
        
            // Pragmas
            #pragma target 5.0
        #pragma raytracing surface_shader
        #pragma only_renderers d3d11 xboxseries ps5
        
            // Keywords
            #pragma shader_feature_local _ _ALPHATEST_ON
        #pragma shader_feature _ _SURFACE_TYPE_TRANSPARENT
        #pragma shader_feature_local _ _DOUBLESIDED_ON
        #pragma shader_feature_local _ _ADD_PRECOMPUTED_VELOCITY
        #pragma shader_feature_local _ _TRANSPARENT_WRITES_MOTION_VEC _TRANSPARENT_REFRACTIVE_SORT
        #pragma shader_feature_local_fragment _ _ENABLE_FOG_ON_TRANSPARENT
        #pragma shader_feature_local_fragment _ _DISABLE_DECALS
        #pragma shader_feature_local_raytracing _ _DISABLE_DECALS
        #pragma shader_feature_local_fragment _ _DISABLE_SSR
        #pragma shader_feature_local_raytracing _ _DISABLE_SSR
        #pragma shader_feature_local_fragment _ _DISABLE_SSR_TRANSPARENT
        #pragma shader_feature_local_raytracing _ _DISABLE_SSR_TRANSPARENT
        #pragma multi_compile_raytracing DECALS_OFF DECALS_3RT DECALS_4RT
        #pragma multi_compile_raytracing _ DECAL_SURFACE_GRADIENT
        #pragma shader_feature_local _ _REFRACTION_PLANE _REFRACTION_SPHERE _REFRACTION_THIN
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_TRANSMISSION
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_TRANSMISSION
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_ANISOTROPY
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_ANISOTROPY
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_IRIDESCENCE
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_IRIDESCENCE
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_SPECULAR_COLOR
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_SPECULAR_COLOR
        #pragma shader_feature_local_fragment _MATERIAL_FEATURE_COLORED_TRANSMISSION
        #pragma shader_feature_local_raytracing _MATERIAL_FEATURE_COLORED_TRANSMISSION
            // GraphKeywords: <None>
        
            // Defines
            #define SHADERPASS SHADERPASS_PATH_TRACING
        #define PUNCTUAL_SHADOW_LOW
        #define DIRECTIONAL_SHADOW_LOW
        #define RAYTRACING_SHADER_GRAPH_DEFAULT
        #define LIGHTLOOP_DISABLE_TILE_AND_CLUSTER 1
        #define PATH_TRACING_CLUSTERED_DECALS 1
        #define HAS_LIGHTLOOP 1
        
            // For custom interpolators to inject a substruct definition before FragInputs definition,
            // allowing for FragInputs to capture CI's intended for ShaderGraph's SDI.
            /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreInclude' */
        
        
            // TODO: Merge FragInputsVFX substruct with CustomInterpolators.
        	#ifdef HAVE_VFX_MODIFICATION
        	struct FragInputsVFX
            {
                /* WARNING: $splice Could not find named fragment 'FragInputsVFX' */
            };
            #endif
        
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl" // Required by Tessellation.hlsl
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Tessellation.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl" // Required to be include before we include properties as it define DECLARE_STACK_CB
            // Always include Shader Graph version
            // Always include last to avoid double macros
            #include "Packages/com.unity.shadergraph/ShaderGraphLibrary/Functions.hlsl" // Need to be here for Gradient struct definition
        
            // --------------------------------------------------
            // Defines
        
            // Attribute
            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define ATTRIBUTES_NEED_TEXCOORD0
            #define ATTRIBUTES_NEED_TEXCOORD1
            #define ATTRIBUTES_NEED_TEXCOORD2
            #define VARYINGS_NEED_POSITION_WS
            #define VARYINGS_NEED_TANGENT_TO_WORLD
            #define VARYINGS_NEED_TEXCOORD0
            #define VARYINGS_NEED_TEXCOORD1
            #define VARYINGS_NEED_TEXCOORD2
        
        
            //Strip down the FragInputs.hlsl (on graphics), so we can only optimize the interpolators we use.
            //if by accident something requests contents of FragInputs.hlsl, it will be caught as a compiler error
            //Frag inputs stripping is only enabled when FRAG_INPUTS_ENABLE_STRIPPING is set
            #if !defined(SHADER_STAGE_RAY_TRACING) && SHADERPASS != SHADERPASS_RAYTRACING_GBUFFER && SHADERPASS != SHADERPASS_FULL_SCREEN_DEBUG
            #define FRAG_INPUTS_ENABLE_STRIPPING
            #endif
            #define FRAG_INPUTS_USE_TEXCOORD0
            #define FRAG_INPUTS_USE_TEXCOORD1
            #define FRAG_INPUTS_USE_TEXCOORD2
        
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
        
        
        
        
            // Following two define are a workaround introduce in 10.1.x for RaytracingQualityNode
            // The ShaderGraph don't support correctly migration of this node as it serialize all the node data
            // in the json file making it impossible to uprgrade. Until we get a fix, we do a workaround here
            // to still allow us to rename the field and keyword of this node without breaking existing code.
            #ifdef RAYTRACING_SHADER_GRAPH_DEFAULT
            #define RAYTRACING_SHADER_GRAPH_HIGH
            #endif
        
            #ifdef RAYTRACING_SHADER_GRAPH_RAYTRACED
            #define RAYTRACING_SHADER_GRAPH_LOW
            #endif
            // end
        
            #ifndef SHADER_UNLIT
            // We need isFrontFace when using double sided - it is not required for unlit as in case of unlit double sided only drive the cullmode
            // VARYINGS_NEED_CULLFACE can be define by VaryingsMeshToPS.FaceSign input if a IsFrontFace Node is included in the shader graph.
            #if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
                #define VARYINGS_NEED_CULLFACE
            #endif
            #endif
        
            // Specific Material Define
        #define _SPECULAR_OCCLUSION_FROM_AO 1
        #define _ENERGY_CONSERVING_SPECULAR 1
        
        #if _MATERIAL_FEATURE_COLORED_TRANSMISSION
            // Colored Transmission doesn't support clear coat
            #undef _MATERIAL_FEATURE_CLEAR_COAT
        #endif
        
        // If we use subsurface scattering, enable output split lighting (for forward pass)
        #if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
            #define OUTPUT_SPLIT_LIGHTING
        #endif
        
        // This shader support recursive rendering for raytracing
        #define HAVE_RECURSIVE_RENDERING
        
        // In Path Tracing, For all single-sided, refractive materials, we want to force a thin refraction model
        #if (SHADERPASS == SHADERPASS_PATH_TRACING) && !defined(_DOUBLESIDED_ON) && (defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE))
            #undef  _REFRACTION_PLANE
            #undef  _REFRACTION_SPHERE
            #define _REFRACTION_THIN
        #endif
            // Caution: we can use the define SHADER_UNLIT onlit after the above Material include as it is the Unlit template who define it
        
            // To handle SSR on transparent correctly with a possibility to enable/disable it per framesettings
            // we should have a code like this:
            // if !defined(_DISABLE_SSR_TRANSPARENT)
            // pragma multi_compile _ WRITE_NORMAL_BUFFER
            // endif
            // i.e we enable the multicompile only if we can receive SSR or not, and then C# code drive
            // it based on if SSR transparent in frame settings and not (and stripper can strip it).
            // this is currently not possible with our current preprocessor as _DISABLE_SSR_TRANSPARENT is a keyword not a define
            // so instead we used this and chose to pay the extra cost of normal write even if SSR transaprent is disabled.
            // Ideally the shader graph generator should handle it but condition below can't be handle correctly for now.
            #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
            #if !defined(_DISABLE_SSR_TRANSPARENT) && !defined(SHADER_UNLIT)
                #define WRITE_NORMAL_BUFFER
            #endif
            #endif
        
            // See Lit.shader
            #if SHADERPASS == SHADERPASS_MOTION_VECTORS && defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)
                #define WRITE_DECAL_BUFFER
            #endif
        
            #ifndef DEBUG_DISPLAY
                // In case of opaque we don't want to perform the alpha test, it is done in depth prepass and we use depth equal for ztest (setup from UI)
                // Don't do it with debug display mode as it is possible there is no depth prepass in this case
                #if !defined(_SURFACE_TYPE_TRANSPARENT)
                    #if SHADERPASS == SHADERPASS_FORWARD
                    #define SHADERPASS_FORWARD_BYPASS_ALPHA_TEST
                    #elif SHADERPASS == SHADERPASS_GBUFFER
                    #define SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST
                    #endif
                #endif
            #endif
        
            // Define _DEFERRED_CAPABLE_MATERIAL for shader capable to run in deferred pass
            #if defined(SHADER_LIT) && !defined(_SURFACE_TYPE_TRANSPARENT)
                #define _DEFERRED_CAPABLE_MATERIAL
            #endif
        
            // Translate transparent motion vector define
            #if (defined(_TRANSPARENT_WRITES_MOTION_VEC) || defined(_TRANSPARENT_REFRACTIVE_SORT)) && defined(_SURFACE_TYPE_TRANSPARENT)
                #define _WRITE_TRANSPARENT_MOTION_VECTOR
            #endif
        
            // -- Graph Properties
            CBUFFER_START(UnityPerMaterial)
        float4 _DiffusionProfileAsset;
        float _DiffusionProfileHash;
        float4 _Texture2D_TexelSize;
        float4 _Albedo;
        float _Smoothness;
        float _WindSpeed;
        float _WindStrength;
        float4 _Normal_TexelSize;
        float _NormalStrength;
        float4 _EmissionColor;
        float _UseShadowThreshold;
        float4 _DoubleSidedConstants;
        float _BlendMode;
        float _EnableBlendModePreserveSpecularLighting;
        float _RayTracing;
        float _RefractionModel;
        float _MaterialID;
        float _MaterialTypeMask;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_Texture2D);
        SAMPLER(sampler_Texture2D);
        TEXTURE2D(_Normal);
        SAMPLER(sampler_Normal);
        
            // -- Property used by ScenePickingPass
            #ifdef SCENEPICKINGPASS
            float4 _SelectionID;
            #endif
        
            // -- Properties used by SceneSelectionPass
            #ifdef SCENESELECTIONPASS
            int _ObjectId;
            int _PassValue;
            #endif
        
            // Includes
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingMacros.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/ShaderVariablesRaytracing.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/ShaderVariablesRaytracingLightLoop.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingIntersection.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/LightLoop/LightLoopDef.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RayTracingLightCluster.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitPathTracing.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RayTracingCommon.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitDecalData.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"
        	// GraphIncludes: <None>
        
            // --------------------------------------------------
            // Structs and Packing
        
            struct SurfaceDescriptionInputs
        {
             float3 TangentSpaceNormal;
             float4 uv0;
        };
        
            //Interpolator Packs: <None>
        
            // --------------------------------------------------
            // Graph
        
        
            // Graph Functions
            
        void Unity_Multiply_float4_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
            // Graph Vertex
            // GraphVertex: <None>
        
            // Graph Pixel
            struct SurfaceDescription
        {
            float3 BaseColor;
            float3 Emission;
            float Alpha;
            float AlphaClipThreshold;
            float3 BentNormal;
            float Smoothness;
            float Occlusion;
            float3 NormalTS;
            float TransmissionMask;
            float Thickness;
            float DiffusionProfileHash;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float4 _Property_35c125abbbcb46e1a2351d8febeb5da1_Out_0_Vector4 = _Albedo;
            UnityTexture2D _Property_bb313b600ca3404fb88a2820878a8482_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Texture2D);
            float4 _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_bb313b600ca3404fb88a2820878a8482_Out_0_Texture2D.tex, _Property_bb313b600ca3404fb88a2820878a8482_Out_0_Texture2D.samplerstate, _Property_bb313b600ca3404fb88a2820878a8482_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            float _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_R_4_Float = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4.r;
            float _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_G_5_Float = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4.g;
            float _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_B_6_Float = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4.b;
            float _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_A_7_Float = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4.a;
            float4 _Multiply_c09cca22f04c4a9a996a5ccf8f61afe1_Out_2_Vector4;
            Unity_Multiply_float4_float4(_Property_35c125abbbcb46e1a2351d8febeb5da1_Out_0_Vector4, _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_RGBA_0_Vector4, _Multiply_c09cca22f04c4a9a996a5ccf8f61afe1_Out_2_Vector4);
            float _Property_925f8cb589d94edda2dcd6b588187f26_Out_0_Float = _Smoothness;
            float _Multiply_a061075fe3794cc5abff5f173997f7f8_Out_2_Float;
            Unity_Multiply_float_float(_Property_925f8cb589d94edda2dcd6b588187f26_Out_0_Float, _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_G_5_Float, _Multiply_a061075fe3794cc5abff5f173997f7f8_Out_2_Float);
            UnityTexture2D _Property_ff2eff189fa74f1f965ec8aca53205ba_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Normal);
            float4 _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_ff2eff189fa74f1f965ec8aca53205ba_Out_0_Texture2D.tex, _Property_ff2eff189fa74f1f965ec8aca53205ba_Out_0_Texture2D.samplerstate, _Property_ff2eff189fa74f1f965ec8aca53205ba_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy) );
            _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.rgb = UnpackNormal(_SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4);
            float _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_R_4_Float = _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.r;
            float _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_G_5_Float = _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.g;
            float _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_B_6_Float = _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.b;
            float _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_A_7_Float = _SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4.a;
            float _Property_915c3b0b5fc04c668c646f2f67b5ab2b_Out_0_Float = _NormalStrength;
            float4 _Multiply_e38eea28614c4b61bfd135ec8591a746_Out_2_Vector4;
            Unity_Multiply_float4_float4(_SampleTexture2D_320a1076567a411e885f760d9a88b4dd_RGBA_0_Vector4, (_Property_915c3b0b5fc04c668c646f2f67b5ab2b_Out_0_Float.xxxx), _Multiply_e38eea28614c4b61bfd135ec8591a746_Out_2_Vector4);
            surface.BaseColor = (_Multiply_c09cca22f04c4a9a996a5ccf8f61afe1_Out_2_Vector4.xyz);
            surface.Emission = float3(0, 0, 0);
            surface.Alpha = _SampleTexture2D_5e9bcefb0f5d498c8910190924d29487_A_7_Float;
            surface.AlphaClipThreshold = 0.5;
            surface.BentNormal = IN.TangentSpaceNormal;
            surface.Smoothness = _Multiply_a061075fe3794cc5abff5f173997f7f8_Out_2_Float;
            surface.Occlusion = 1;
            surface.NormalTS = (_Multiply_e38eea28614c4b61bfd135ec8591a746_Out_2_Vector4.xyz);
            surface.TransmissionMask = 1;
            surface.Thickness = 1;
            surface.DiffusionProfileHash = _DiffusionProfileHash;
            return surface;
        }
        
            // --------------------------------------------------
            // Build Graph Inputs
            #ifdef HAVE_VFX_MODIFICATION
            #define VFX_SRP_ATTRIBUTES AttributesMesh
            #define VaryingsMeshType VaryingsMeshToPS
            #define VFX_SRP_VARYINGS VaryingsMeshType
            #define VFX_SRP_SURFACE_INPUTS FragInputs
            #endif
            SurfaceDescriptionInputs FragInputsToSurfaceDescriptionInputs(FragInputs input, float3 viewWS)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
            #if defined(SHADER_STAGE_RAY_TRACING)
            #else
            #endif
            output.TangentSpaceNormal =                         float3(0.0f, 0.0f, 1.0f);
        
        #if UNITY_UV_STARTS_AT_TOP
        #else
        #endif
        
        
            output.uv0 =                                        input.texCoord0;
        
            // splice point to copy frag inputs custom interpolator pack into the SDI
            /* WARNING: $splice Could not find named fragment 'CustomInterpolatorCopyToSDI' */
        
            return output;
        }
        
            // --------------------------------------------------
            // Build Surface Data (Specific Material)
        
        void ApplyDecalToSurfaceDataNoNormal(DecalSurfaceData decalSurfaceData, inout SurfaceData surfaceData);
        
        void ApplyDecalAndGetNormal(FragInputs fragInputs, PositionInputs posInput, SurfaceDescription surfaceDescription,
            inout SurfaceData surfaceData)
        {
            float3 doubleSidedConstants = GetDoubleSidedConstants();
        
        #ifdef DECAL_NORMAL_BLENDING
            // SG nodes don't ouptut surface gradients, so if decals require surf grad blending, we have to convert
            // the normal to gradient before applying the decal. We then have to resolve the gradient back to world space
            float3 normalTS;
        
            normalTS = SurfaceGradientFromTangentSpaceNormalAndFromTBN(surfaceDescription.NormalTS,
            fragInputs.tangentToWorld[0], fragInputs.tangentToWorld[1]);
        
        
            #if HAVE_DECALS
            if (_EnableDecals)
            {
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                ApplyDecalToSurfaceNormal(decalSurfaceData, fragInputs.tangentToWorld[2], normalTS);
                ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
            }
            #endif
        
            GetNormalWS_SG(fragInputs, normalTS, surfaceData.normalWS, doubleSidedConstants);
        #else
            // normal delivered to master node
            GetNormalWS(fragInputs, surfaceDescription.NormalTS, surfaceData.normalWS, doubleSidedConstants);
        
            #if HAVE_DECALS
            if (_EnableDecals)
            {
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                // Both uses and modifies 'surfaceData.normalWS'.
                DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                ApplyDecalToSurfaceNormal(decalSurfaceData, surfaceData.normalWS.xyz);
                ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
            }
            #endif
        #endif
        }
        void BuildSurfaceData(FragInputs fragInputs, inout SurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
        {
            ZERO_INITIALIZE(SurfaceData, surfaceData);
        
            // specularOcclusion need to be init ahead of decal to quiet the compiler that modify the SurfaceData struct
            // however specularOcclusion can come from the graph, so need to be init here so it can be override.
            surfaceData.specularOcclusion = 1.0;
            surfaceData.thickness = 0.0;
        
            surfaceData.baseColor =                 surfaceDescription.BaseColor;
            surfaceData.perceptualSmoothness =      surfaceDescription.Smoothness;
            surfaceData.ambientOcclusion =          surfaceDescription.Occlusion;
            surfaceData.transmissionMask =          surfaceDescription.TransmissionMask.xxx;
            surfaceData.thickness =                 surfaceDescription.Thickness;
            surfaceData.diffusionProfileHash =      asuint(surfaceDescription.DiffusionProfileHash);
        
            #if defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE) || defined(_REFRACTION_THIN)
                if (_EnableSSRefraction)
                {
        
                    surfaceData.transmittanceMask = (1.0 - surfaceDescription.Alpha);
                    surfaceDescription.Alpha = 1.0;
                }
                else
                {
                    surfaceData.ior = 1.0;
                    surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                    surfaceData.atDistance = 1.0;
                    surfaceData.transmittanceMask = 0.0;
                    surfaceDescription.Alpha = 1.0;
                }
            #else
                surfaceData.ior = 1.0;
                surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                surfaceData.atDistance = 1.0;
                surfaceData.transmittanceMask = 0.0;
            #endif
        
            // These static material feature allow compile time optimization
            surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;
            #ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
            #endif
        
            #ifdef _MATERIAL_FEATURE_TRANSMISSION
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
            #endif
        
            #ifdef _MATERIAL_FEATURE_COLORED_TRANSMISSION
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_COLORED_TRANSMISSION;
        
            #endif
        
            #ifdef _MATERIAL_FEATURE_ANISOTROPY
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
        
                // Initialize the normal to something non-zero to avoid a div-zero warning for anisotropy.
                surfaceData.normalWS = float3(0, 1, 0);
            #endif
        
            #ifdef _MATERIAL_FEATURE_IRIDESCENCE
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
            #endif
        
            #ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
            #endif
        
            #ifdef _MATERIAL_FEATURE_CLEAR_COAT
                surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
            #endif
        
            #if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
                // Require to have setup baseColor
                // Reproduce the energy conservation done in legacy Unity. Not ideal but better for compatibility and users can unchek it
                surfaceData.baseColor *= (1.0 - Max3(surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b));
            #endif
        
            float3 doubleSidedConstants = GetDoubleSidedConstants();
        
            ApplyDecalAndGetNormal(fragInputs, posInput, surfaceDescription, surfaceData);
        
            surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];
        
            surfaceData.tangentWS = normalize(fragInputs.tangentToWorld[0].xyz);    // The tangent is not normalize in tangentToWorld for mikkt. TODO: Check if it expected that we normalize with Morten. Tag: SURFACE_GRADIENT
        
        
            bentNormalWS = surfaceData.normalWS;
        
            surfaceData.tangentWS = Orthonormalize(surfaceData.tangentWS, surfaceData.normalWS);
        
            #ifdef DEBUG_DISPLAY
                if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
                {
                    // TODO: need to update mip info
                    surfaceData.metallic = 0;
                }
        
                // We need to call ApplyDebugToSurfaceData after filling the surfarcedata and before filling builtinData
                // as it can modify attribute use for static lighting
                ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData);
            #endif
        
            // By default we use the ambient occlusion with Tri-ace trick (apply outside) for specular occlusion.
            // If user provide bent normal then we process a better term
            #if defined(_SPECULAR_OCCLUSION_CUSTOM)
                // Just use the value passed through via the slot (not active otherwise)
            #elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
                // If we have bent normal and ambient occlusion, process a specular occlusion
                surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO(V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness(surfaceData.perceptualSmoothness));
            #elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
                surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion(ClampNdotV(dot(surfaceData.normalWS, V)), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness(surfaceData.perceptualSmoothness));
            #endif
        
            #if defined(_ENABLE_GEOMETRIC_SPECULAR_AA) && !defined(SHADER_STAGE_RAY_TRACING)
                surfaceData.perceptualSmoothness = GeometricNormalFiltering(surfaceData.perceptualSmoothness, fragInputs.tangentToWorld[2], surfaceDescription.SpecularAAScreenSpaceVariance, surfaceDescription.SpecularAAThreshold);
            #endif
        }
        
            // --------------------------------------------------
            // Get Surface And BuiltinData
        
            void GetSurfaceAndBuiltinData(FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData RAY_TRACING_OPTIONAL_PARAMETERS)
            {
                // Don't dither if displaced tessellation (we're fading out the displacement instead to match the next LOD)
                #if !defined(SHADER_STAGE_RAY_TRACING) && !defined(_TESSELLATION_DISPLACEMENT)
                #ifdef LOD_FADE_CROSSFADE // enable dithering LOD transition if user select CrossFade transition in LOD group
                LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
                #endif
                #endif
        
                #ifndef SHADER_UNLIT
                #ifdef _DOUBLESIDED_ON
                    float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
                #else
                    float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
                #endif
        
                ApplyDoubleSidedFlipOrMirror(fragInputs, doubleSidedConstants); // Apply double sided flip on the vertex normal
                #endif // SHADER_UNLIT
        
                SurfaceDescriptionInputs surfaceDescriptionInputs = FragInputsToSurfaceDescriptionInputs(fragInputs, V);
        
                #if defined(HAVE_VFX_MODIFICATION)
                GraphProperties properties;
                ZERO_INITIALIZE(GraphProperties, properties);
        
                GetElementPixelProperties(fragInputs, properties);
        
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs, properties);
                #else
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs);
                #endif
        
                // Perform alpha test very early to save performance (a killed pixel will not sample textures)
                // TODO: split graph evaluation to grab just alpha dependencies first? tricky..
                #ifdef _ALPHATEST_ON
                    float alphaCutoff = surfaceDescription.AlphaClipThreshold;
                    #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
                    // The TransparentDepthPrepass is also used with SSR transparent.
                    // If an artists enable transaprent SSR but not the TransparentDepthPrepass itself, then we use AlphaClipThreshold
                    // otherwise if TransparentDepthPrepass is enabled we use AlphaClipThresholdDepthPrepass
                    #elif SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_POSTPASS
                    // DepthPostpass always use its own alpha threshold
                    alphaCutoff = surfaceDescription.AlphaClipThresholdDepthPostpass;
                    #elif (SHADERPASS == SHADERPASS_SHADOWS) || (SHADERPASS == SHADERPASS_RAYTRACING_VISIBILITY)
                    // If use shadow threshold isn't enable we don't allow any test
                    #endif
        
                    GENERIC_ALPHA_TEST(surfaceDescription.Alpha, alphaCutoff);
                #endif
        
                #if !defined(SHADER_STAGE_RAY_TRACING) && _DEPTHOFFSET_ON
                ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
                #endif
        
                #ifndef SHADER_UNLIT
                float3 bentNormalWS;
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS);
        
                #ifdef FRAG_INPUTS_USE_TEXCOORD1
                    float4 lightmapTexCoord1 = fragInputs.texCoord1;
                #else
                    float4 lightmapTexCoord1 = float4(0,0,0,0);
                #endif
        
                #ifdef FRAG_INPUTS_USE_TEXCOORD2
                    float4 lightmapTexCoord2 = fragInputs.texCoord2;
                #else
                    float4 lightmapTexCoord2 = float4(0,0,0,0);
                #endif
        
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                // Builtin Data
                // For back lighting we use the oposite vertex normal
                InitBuiltinData(posInput, alpha, bentNormalWS, -fragInputs.tangentToWorld[2], lightmapTexCoord1, lightmapTexCoord2, builtinData);
        
                #else
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData);
        
                ZERO_BUILTIN_INITIALIZE(builtinData); // No call to InitBuiltinData as we don't have any lighting
                builtinData.opacity = surfaceDescription.Alpha;
        
                #if defined(DEBUG_DISPLAY)
                    // Light Layers are currently not used for the Unlit shader (because it is not lit)
                    // But Unlit objects do cast shadows according to their rendering layer mask, which is what we want to
                    // display in the light layers visualization mode, therefore we need the renderingLayers
                    builtinData.renderingLayers = GetMeshRenderingLayerMask();
                #endif
        
                #endif // SHADER_UNLIT
        
                #ifdef _ALPHATEST_ON
                    // Used for sharpening by alpha to mask - Alpha to covertage is only used with depth only and forward pass (no shadow pass, no transparent pass)
                    builtinData.alphaClipTreshold = alphaCutoff;
                #endif
        
                // override sampleBakedGI - not used by Unlit
        		// When overriding GI, we need to force the isLightmap flag to make sure we don't add APV (sampled in the lightloop) on top of the overridden value (set at GBuffer stage)
        
                builtinData.emissiveColor = surfaceDescription.Emission;
        
                // Note this will not fully work on transparent surfaces (can check with _SURFACE_TYPE_TRANSPARENT define)
                // We will always overwrite vt feeback with the nearest. So behind transparent surfaces vt will not be resolved
                // This is a limitation of the current MRT approach.
                #ifdef UNITY_VIRTUAL_TEXTURING
                #endif
        
                #if _DEPTHOFFSET_ON
                builtinData.depthOffset = surfaceDescription.DepthOffset;
                #endif
        
                // TODO: We should generate distortion / distortionBlur for non distortion pass
                #if (SHADERPASS == SHADERPASS_DISTORTION)
                builtinData.distortion = surfaceDescription.Distortion;
                builtinData.distortionBlur = surfaceDescription.DistortionBlur;
                #endif
        
                #ifndef SHADER_UNLIT
                // PostInitBuiltinData call ApplyDebugToBuiltinData
                PostInitBuiltinData(V, posInput, surfaceData, builtinData);
                #else
                ApplyDebugToBuiltinData(builtinData);
                #endif
        
                RAY_TRACING_OPTIONAL_ALPHA_TEST_PASS
            }
        
            // --------------------------------------------------
            // Main
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPassPathTracing.hlsl"
        
            // --------------------------------------------------
            // Visual Effect Vertex Invocations
        
        	#ifdef HAVE_VFX_MODIFICATION
                #if !defined(SHADER_STAGE_RAY_TRACING)
        	    #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/VisualEffectVertex.hlsl"
                #else
                #endif
        	#endif
        
            #include "Assets/VegetationInstancer/Shaders/Include/GPUInstancedIndirectInclude.cginc"
#pragma instancing_options procedural:setupGPUInstancedIndirect
#pragma multi_compile_instancing
ENDHLSL
        }
    }
    CustomEditor "UnityEditor.ShaderGraph.GenericShaderGraphMaterialGUI"
    CustomEditorForRenderPipeline "Rendering.HighDefinition.LitShaderGraphGUI" "UnityEngine.Rendering.HighDefinition.HDRenderPipelineAsset"
    FallBack "Hidden/Shader Graph/FallbackError"
}