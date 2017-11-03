Shader "Custom/PositionShader-RestrictedZoneDiagonal" {
	
	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_RestrictedColor ("Diagonal Color", Color) = (1,1,1,1)
		_Color("Color", Color) = (1,1,1,1)
	}

	SubShader {
		Tags { "RenderType"="Opaque" }
		
		LOD 200
		
		CGPROGRAM
		
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows
		#pragma target 3.0

		sampler2D _MainTex;
		float4 _Color;
		float4 _RestrictedColor;

		struct Input {
			float2 uv_MainTex;
			float3 worldPos;
		};

		UNITY_INSTANCING_CBUFFER_START(Props)
			// put more per-instance properties here
		UNITY_INSTANCING_CBUFFER_END

		void surf (Input IN, inout SurfaceOutputStandard output) {
			// Texture info
			float4 texInfo = tex2D (_MainTex, IN.uv_MainTex);
			// Constraint calculation
			float straight = IN.worldPos.x;
			// Output setup
			if (IN.worldPos.z >= straight)
				output.Albedo = _RestrictedColor;
			else
				output.Albedo = texInfo * _Color;
		}

		ENDCG
	}
	FallBack "Diffuse"
}
