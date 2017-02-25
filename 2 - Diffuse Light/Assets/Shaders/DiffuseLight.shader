Shader "UnityShaderTutorial/Tutorial2DiffuseLight" {
	Properties{
		_AmbientLightColor("Ambient Light Color", Color) = (1,1,1,1)
		_AmbientLighIntensity("Ambient Light Intensity", Range(0.0, 1.0)) = 1.0

		_DiffuseDirection("Diffuse Light Direction", Vector) = (0.22,0.84,0.78,1)
		_DiffuseColor("Diffuse Light Color", Color) = (1,1,1,1)
		_DiffuseIntensity("Diffuse Light Intensity", Range(0.0, 1.0)) = 1.0
	}
		SubShader
	{
		Pass
		{
			CGPROGRAM
			#pragma target 2.0
			#pragma vertex vertexShader
			#pragma fragment fragmentShader

			float4 _AmbientLightColor;
			float _AmbientLighIntensity;
			float3 _DiffuseDirection;
			float4 _DiffuseColor;
			float _DiffuseIntensity;


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
				o.normal = v.normal;
				return o;
			}

			float4 fragmentShader(vsOut psIn) : SV_Target
			{
				float diffuse = saturate(dot(_DiffuseDirection, psIn.normal));
				return (_AmbientLightColor * _AmbientLighIntensity) 
					 + (diffuse * _DiffuseColor * _DiffuseIntensity);
			}

			ENDCG
		}
	}
}
