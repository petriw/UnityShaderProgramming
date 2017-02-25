﻿Shader "UnityShaderTutorial/Tutorial1AmbientLight" {
	Properties{
		_AmbientLightColor("Ambient Light Color", Color) = (1,1,1,1)
		_AmbientLighIntensity("Ambient Light Intensity", Range(0.0, 1.0)) = 1.0
	}
		SubShader
	{
		Pass
		{
			CGPROGRAM
			#pragma target 2.0
			#pragma vertex vertexShader
			#pragma fragment fragmentShader

			fixed4 _AmbientLightColor;
			float _AmbientLighIntensity;

			float4 vertexShader(float4 v:POSITION) : SV_POSITION
			{
				return mul(UNITY_MATRIX_MVP, v);
			}

			fixed4 fragmentShader() : SV_Target
			{
				return _AmbientLightColor * _AmbientLighIntensity;
			}

			ENDCG
		}
	}
}
