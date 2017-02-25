// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

Shader "UnityShaderTutorial/Tutorial2DiffuseLight-GlobalStates" {
	SubShader
	{
		Pass
		{
			Tags{ "LightMode" = "ForwardBase" }

			CGPROGRAM
			#include "UnityCG.cginc"

			#pragma target 2.0
			#pragma vertex vertexShader
			#pragma fragment fragmentShader

			float4 _LightColor0;

			struct vsIn {
				float4 position : POSITION;
				float3 normal : NORMAL;
			};

			struct vsOut {
				float4 position : SV_POSITION;
				float3 normal : NORMAL;
			};

			vsOut vertexShader(vsIn v)
			{
				vsOut o;
				o.position = mul(UNITY_MATRIX_MVP, v.position);
				o.normal = normalize(mul(float4(v.normal, 0.0), unity_WorldToObject).xyz);

				return o;
			}

			float4 fragmentShader(vsOut psIn) : SV_Target
			{
				float4 AmbientLight = UNITY_LIGHTMODEL_AMBIENT;

				float4 LightDirection = normalize(_WorldSpaceLightPos0);

				float diffuseTerm = saturate(dot(LightDirection, psIn.normal));
				float4 DiffuseLight = diffuseTerm * _LightColor0;
				
				return AmbientLight + DiffuseLight;
			}

			ENDCG
		}
	}
}