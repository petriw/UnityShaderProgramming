// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

Shader "UnityShaderTutorial/Tutorial3SpecularLight-GlobalStates" {
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
			#pragma enable_d3d11_debug_symbols

			float4 _LightColor0;

			struct vsIn {
				float4 position : POSITION;
				float3 normal : NORMAL;
			};

			struct vsOut {
				float4 screenPosition : SV_POSITION;
				float4 position : COORDINATE0;
				float3 normal : NORMAL;
			};

			vsOut vertexShader(vsIn v)
			{
				vsOut o;
				o.screenPosition = mul(UNITY_MATRIX_MVP, v.position);
				o.normal = normalize(mul(v.normal, unity_WorldToObject));
				o.position = v.position;

				return o;
			}

			float4 fragmentShader(vsOut psIn) : SV_Target
			{
				float4 ambientLight = UNITY_LIGHTMODEL_AMBIENT;

				float4 lightDirection = normalize(_WorldSpaceLightPos0);

				float4 diffuseTerm = saturate( dot(lightDirection, psIn.normal));
				float4 diffuseLight = diffuseTerm * _LightColor0;
				
				float4 cameraPosition = normalize(float4( _WorldSpaceCameraPos,1) - psIn.position);
				
				// Blinn-Phong
				float4 halfVector = normalize(lightDirection+cameraPosition);
				float4 specularTerm = pow( saturate( dot( psIn.normal, halfVector)), 25);

				// Phong
				//float4 reflectionVector = reflect(-lightDirection, float4(psIn.normal,1));
				//float4 specularTerm = pow(saturate(dot(reflectionVector, cameraPosition)),15);
				
				return ambientLight + diffuseLight + specularTerm;
			}

			ENDCG
		}
	}
}