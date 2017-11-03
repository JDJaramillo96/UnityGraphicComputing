Shader "Custom/Ex01-Clip" {
	Properties {
		_MainTex("Albedo (RGB)", 2D) = "white" {}
		_NoiseTex("Noise (Grayscale)", 2D) = "white" {}
		_NoiseFactor("Noise Factor", Range(-1,1)) = 0
		_Color("Color", Color) = (1,1,1,1)
	}

	SubShader {
		
		Tags { "RenderType" = "Opaque" }
		
		LOD 200
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows
		#pragma target 3.0

		sampler2D _MainTex;
		sampler2D _NoiseTex;
		float _NoiseFactor;
		float4 _Color;

		struct Input {
			float2 uv_MainTex;
		};

		UNITY_INSTANCING_CBUFFER_START(Props)
			// put more per-instance properties here
		UNITY_INSTANCING_CBUFFER_END

		void surf (Input IN, inout SurfaceOutputStandard output) {
			// Tex info
			float4 texInfo = tex2D(_MainTex, IN.uv_MainTex);
			float noiseInfo = tex2D(_NoiseTex, IN.uv_MainTex);
			// Clip factor
			float clipFactor = noiseInfo * 2;
			clipFactor -= 1;
			clip(clamp(clipFactor + _NoiseFactor,-1,1));
			// Output
			output.Albedo = texInfo.rgb * _Color;
		}

		ENDCG
	}
	FallBack "Diffuse"
}
