Shader "Custom/Ex02-Ramp" {
	Properties {
		_MainTex("Albedo (RGB)", 2D) = "white" {}
		_RampTex("Ramp (RGB)", 2D) = "white" {}
		_RampFactor("Ramp Factor", Range(0,1)) = 1
		_NoiseTex("Noise (Grayscale)", 2D) = "white" {}
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
		sampler2D _RampTex;
		float _RampFactor;
		sampler2D _NoiseTex;
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
			float4 rampInfo = tex2D(_RampTex, float2(noiseInfo, 0.5));
			// Output
			output.Albedo = ((rampInfo * _RampFactor) + (texInfo * (1 - _RampFactor))) * _Color;
		}

		ENDCG
	}
	FallBack "Diffuse"
}
