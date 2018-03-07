Shader "hidden/preview"
{
    Properties
    {
        [NonModifiableTextureData] [NoScaleOffset] _SampleTexture2D_A3C9A2CE_Texture("Texture", 2D) = "white" {}
    }
    HLSLINCLUDE
    #define USE_LEGACY_UNITY_MATRIX_VARIABLES
    #include "CoreRP/ShaderLibrary/Common.hlsl"
    #include "CoreRP/ShaderLibrary/Packing.hlsl"
    #include "CoreRP/ShaderLibrary/Color.hlsl"
    #include "CoreRP/ShaderLibrary/UnityInstancing.hlsl"
    #include "CoreRP/ShaderLibrary/EntityLighting.hlsl"
    #include "ShaderGraphLibrary/ShaderVariables.hlsl"
    #include "ShaderGraphLibrary/ShaderVariablesFunctions.hlsl"
    #include "ShaderGraphLibrary/Functions.hlsl"
    float Vector1_27D8F244;
    SAMPLER(SamplerState_Linear_Clamp_sampler);
    TEXTURE2D(_SampleTexture2D_A3C9A2CE_Texture); SAMPLER(sampler_SampleTexture2D_A3C9A2CE_Texture);
    float4 _SampleTexture2D_A3C9A2CE_UV;
    struct SurfaceInputs{
    	half4 uv0;
    };
    struct GraphVertexInput
    {
    	float4 vertex : POSITION;
    	float3 normal : NORMAL;
    	float4 tangent : TANGENT;
    	float4 texcoord0 : TEXCOORD0;
    	UNITY_VERTEX_INPUT_INSTANCE_ID
    };
    struct SurfaceDescription{
    	float4 PreviewOutput;
    };
    GraphVertexInput PopulateVertexData(GraphVertexInput v){
    	return v;
    }
    SurfaceDescription PopulateSurfaceData(SurfaceInputs IN) {
    	SurfaceDescription surface = (SurfaceDescription)0;
    	float4 _SampleTexture2D_A3C9A2CE_RGBA = SAMPLE_TEXTURE2D(_SampleTexture2D_A3C9A2CE_Texture, SamplerState_Linear_Clamp_sampler, IN.uv0.xy);
    	float _SampleTexture2D_A3C9A2CE_R = _SampleTexture2D_A3C9A2CE_RGBA.r;
    	float _SampleTexture2D_A3C9A2CE_G = _SampleTexture2D_A3C9A2CE_RGBA.g;
    	float _SampleTexture2D_A3C9A2CE_B = _SampleTexture2D_A3C9A2CE_RGBA.b;
    	float _SampleTexture2D_A3C9A2CE_A = _SampleTexture2D_A3C9A2CE_RGBA.a;
    	if (Vector1_27D8F244 == 1) { surface.PreviewOutput = half4(_SampleTexture2D_A3C9A2CE_RGBA.x, _SampleTexture2D_A3C9A2CE_RGBA.y, _SampleTexture2D_A3C9A2CE_RGBA.z, 1.0); return surface; }
    	return surface;
    }
    ENDHLSL

    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            struct GraphVertexOutput
            {
                float4 position : POSITION;
                half4 uv0 : TEXCOORD;

            };

            GraphVertexOutput vert (GraphVertexInput v)
            {
                v = PopulateVertexData(v);

                GraphVertexOutput o;
                float3 positionWS = TransformObjectToWorld(v.vertex);
                o.position = TransformWorldToHClip(positionWS);
                o.uv0 = v.texcoord0;

                return o;
            }

            float4 frag (GraphVertexOutput IN) : SV_Target
            {
                float4 uv0 = IN.uv0;


                SurfaceInputs surfaceInput = (SurfaceInputs)0;;
                surfaceInput.uv0 = uv0;


                SurfaceDescription surf = PopulateSurfaceData(surfaceInput);
                return surf.PreviewOutput;

            }
            ENDHLSL
        }
    }
}
