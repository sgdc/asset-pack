Shader "Custom/SphericalDisintegration" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0
		_DisintegrationColor("Disintegration Color", Color) = (1,0.5,0,1)
		_FinishRadius ("Finish Radius", Float) = 1
		_DisintegrationThickness ("Disintegration Thickness", Float) = 0.1
		_Expansion ("Expansion", Range(0,1)) = 0
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		Cull Off
		
		CGPROGRAM
		#include "UnityPBSLighting.cginc"
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Custom fullforwardshadows

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
			float3 worldPos;
			float3 viewDir;
		};

		half _Glossiness;
		half _Metallic;
		fixed4 _Color;
		fixed4 _DisintegrationColor;
		float _FinishRadius;
		uniform float _DisintegrationThickness;
		uniform float _Expansion;
		uniform int _OrbsLength;
		uniform float4 _Orbs[10];
		
		int disintegrating;
		void surf(Input IN, inout SurfaceOutputStandard o) 
		{
			disintegrating = 0;
			if (_Expansion > 0)
			{
				for (int i = 0; i < _OrbsLength; i++)
				{
					float dist = distance(IN.worldPos, _Orbs[i].xyz);
					float disintegrateDistance = _Expansion * _FinishRadius + sin((IN.worldPos.x+IN.worldPos.y+IN.worldPos.z)*30+_Time.y*5+o.Normal)*0.01;
					if (dist < disintegrateDistance)
					{
						discard;
					}
					if (dist < disintegrateDistance + _DisintegrationThickness)
					{
						disintegrating = 1;
					}
					if (dot(o.Normal, IN.viewDir) < 0)
					{
						disintegrating = 1;
					}
				}
			}

			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
			o.Albedo = c.rgb;
			// Metallic and smoothness come from slider variables
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;
			o.Alpha = c.a; 
		}
		half4 LightingCustom(SurfaceOutputStandard s, half3 lightDir, UnityGI gi)
		{
			if (disintegrating == 1)
			{
				return _DisintegrationColor;
			}
			return LightingStandard(s, lightDir, gi);
		}
		
		void LightingCustom_GI(SurfaceOutputStandard s, UnityGIInput data, inout UnityGI gi)
		{
			LightingStandard_GI(s, data, gi);
		}
		
		ENDCG
	}
	FallBack "Diffuse"
}
