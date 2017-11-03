Shader "Custom/Ex01" {
	
	Properties {
		_SandTex ("Sand (RGB)", 2D) = "white" {}
		_GrassTex ("Grass (RGB)", 2D) = "white" {}
		_WaterTex ("Water (RGB)", 2D) = "white" {}
		_Mask ("Mask", 2D) = "white" {}
		_Color ("Color", Color) = (1,1,1,1)
	}

	SubShader {
		Tags { "RenderType"="Opaque" }
		
		LOD 200
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows
		#pragma target 3.0

		sampler2D _SandTex;
		sampler2D _GrassTex;
		sampler2D _WaterTex;
		sampler2D _Mask;
		float4 _Color;

		struct Input {
			float2 uv_Mask;
		};

		UNITY_INSTANCING_CBUFFER_START(Props)
			// put more per-instance properties here
		UNITY_INSTANCING_CBUFFER_END

		void surf (Input IN, inout SurfaceOutputStandard output) {
			float4 mask = tex2D (_Mask, IN.uv_Mask);
			float4 sand = tex2D (_SandTex, IN.uv_Mask);
			float4 grass = tex2D (_GrassTex, IN.uv_Mask);
			float4 water = tex2D (_WaterTex, IN.uv_Mask);

			sand *= mask.r;
			grass *= mask.g;
			water *= mask.b;
			
			float4 color = sand + grass + water;
			
			output.Albedo = color * _Color;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
