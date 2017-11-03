Shader "Custom/Ex02-ArissaMask" {
	
	Properties {
		_MainTex1 ("Texture 1 (RGB)", 2D) = "white" {}
		_MainTex2 ("Texture 2 (RGB)", 2D) = "white" {}
		_MainTex3 ("Texture 3 (RGB)", 2D) = "white" {}
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

		sampler2D _MainTex1;
		sampler2D _MainTex2;
		sampler2D _MainTex3;
		sampler2D _Mask;
		float4 _Color;

		struct Input {
			float2 uv_Mask;
		};

		UNITY_INSTANCING_CBUFFER_START(Props)
			// put more per-instance properties here
		UNITY_INSTANCING_CBUFFER_END

		void surf (Input IN, inout SurfaceOutputStandard output) {
			// Albedo comes from a texture tinted by color
			float4 mask = tex2D (_Mask, IN.uv_Mask);
			float4 tex1 = tex2D (_MainTex1, IN.uv_Mask);
			float4 tex2 = tex2D (_MainTex2, IN.uv_Mask);
			float4 tex3 = tex2D (_MainTex3, IN.uv_Mask);

			tex1 *= mask.r;
			tex2 *= mask.g;
			tex3 *= mask.b;

			float4 color = tex1 + tex2 + tex3;

			output.Albedo = color * _Color;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
