Shader "Custom/Dilatation" {
	Properties {
		_MainTex("Albedo (RGB)", 2D) = "white" {}
		_ExtrusionFactor("Extrusion Factor", Float) = 1
		_Distance("Distance", Float) = 0
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
		float _Distance;
		float4 _Color;

		struct Input {
			float2 uv_MainTex;
		};

		UNITY_INSTANCING_CBUFFER_START(Props)
			// put more per-instance properties here
		UNITY_INSTANCING_CBUFFER_END

		void surf (Input IN, inout SurfaceOutputStandard output) {
			//Albedo comes from a texture tinted by color
			float4 texInfo = tex2D(_MainTex, IN.uv_MainTex);
			output.Albedo = texInfo.rgb * _Color.rgb;
		}

		void vert(inout appdata_full verInfo, out Input IN) {
			UNITY_INITIALIZE_OUTPUT(Input, IN);
			
			// VerInfo setup
			float m = -0.014;
			float b = 0.05;
			float extrusion = (m * _Distance) + b;
			
			//Final output
			if (_Distance >= 0 && _Distance <= 5)
			{
				verInfo.vertex.xyz += verInfo.normal * extrusion * _ExtrusionFactor;
			}

			verInfo.normal = normalize(verInfo.vertex.xyz);
		}

		ENDCG
	}

	FallBack "Diffuse"
}
