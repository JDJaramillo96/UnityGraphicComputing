Shader "Custom/Ex04" {
	
	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Color("Color", Color) = (1,1,1,1)
	}

	SubShader {
		Tags { "RenderType" = "Opaque" }
		
		LOD 200
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard vertex:vert addshadow
		#pragma target 3.0

		sampler2D _MainTex;
		float4 _Color;

		struct Input {
			float2 uv_MainTex;
			float3 positionInfo;
		};

		UNITY_INSTANCING_CBUFFER_START(Props)
			// put more per-instance properties here
		UNITY_INSTANCING_CBUFFER_END

		void surf (Input IN, inout SurfaceOutputStandard output) {
			// Tex info
			float4 texInfo = tex2D (_MainTex, IN.uv_MainTex);
			// Tangent info
			float3 positionInfo = IN.positionInfo;
			// Output setup
			if (positionInfo.x == 0)
			{
				output.Albedo = texInfo * _Color.rgb;
			}
			else
			{
				output.Albedo = positionInfo * _Color.rgb;
			}
		}

		void vert (inout appdata_full v, out Input IN) {
			UNITY_INITIALIZE_OUTPUT(Input, IN);

			// Reading coordinates
			float x = v.vertex.x;
			float y = v.vertex.y;
			float z = v.vertex.z;

			if (v.vertex.x < 0)
			{
				IN.positionInfo = v.vertex.xyz;
			}

			// Vertex setup
			v.vertex.xyz = float3(x, y, z);
			v.normal = normalize(v.normal.xyz);
		}

		ENDCG
	}
	FallBack "Diffuse"
}
