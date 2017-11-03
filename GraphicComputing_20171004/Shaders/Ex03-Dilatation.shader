Shader "Custom/Ex03-Dilatation" {
	Properties {
		_MainTex("Albedo (RGB)", 2D) = "white" {}
		_ExtrusionFactor("Extrusion", Range(-0.1,0.1)) = 0
		_Color("Color", Color) = (1,1,1,1)
	}

	SubShader {
		
		Tags { "RenderType" = "Opaque" }
		
		LOD 200
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows vertex:vert
		#pragma target 3.0

		sampler2D _MainTex;
		float _ExtrusionFactor;
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
			// Output
			output.Albedo = texInfo * _Color;
		}

		void vert(inout appdata_full verInfo, out Input IN) {
			UNITY_INITIALIZE_OUTPUT(Input, IN);
			// VerInfo setup
			verInfo.vertex.xyz += verInfo.normal * _ExtrusionFactor;
		}

		ENDCG
	}
	FallBack "Diffuse"
}
