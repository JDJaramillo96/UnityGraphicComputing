Shader "Custom/Ex01-Strength" {

	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Normal ("Normal Map", 2D) = "bump" {}
		_NormalStrength ("Normal Strength", Range(-10, 10)) = 1
		_Color ("Color", Color) = (1,1,1,1)
	}

	SubShader {
		Tags { "RenderType"="Opaque" }
		
		LOD 200
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows
		#pragma target 3.0

		sampler2D _MainTex;
		sampler2D _Normal;
		float _NormalStrength;
		float4 _Color;

		struct Input {
			float2 uv_MainTex;
		};

		UNITY_INSTANCING_CBUFFER_START(Props)
			// put more per-instance properties here
		UNITY_INSTANCING_CBUFFER_END

		void surf (Input IN, inout SurfaceOutputStandard output) {
			// Textures info
			float4 color = tex2D (_MainTex, IN.uv_MainTex);
			float4 normal = tex2D (_Normal, IN.uv_MainTex); 
			float3 normalInfo = UnpackNormal(normal).rgb;
			normalInfo.rg *= _NormalStrength;
			// Output setup
			output.Albedo = color.rgb * _Color;
			output.Normal = normalize(normalInfo);
		}
		ENDCG
	}
	FallBack "Diffuse"
}
