Shader "Custom/BaseShader" {
	
	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Color ("Color", Color) = (1,1,1,1)
	}
	
	SubShader {
		
		Tags { "RenderType"="Opaque" }
		
		LOD 200
		
		CGPROGRAM

		#pragma surface surf Standard fullforwardshadows
		#pragma target 3.0

		sampler2D _MainTex;
		float4 _Color;

		struct Input {
			float2 uv_MainTex;
		};

		UNITY_INSTANCING_CBUFFER_START(Props)
			// put more per-instance properties here
		UNITY_INSTANCING_CBUFFER_END

		void surf (Input IN, inout SurfaceOutputStandard output) {
			// Texture info
			float4 texInfo = tex2D (_MainTex, IN.uv_MainTex);
			// Output setup
			output.Albedo = texInfo.rgb * _Color;
		}

		ENDCG
	}
	FallBack "Diffuse"
}
