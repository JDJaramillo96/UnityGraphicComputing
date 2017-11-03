Shader "Custom/Distance-Black&White" {
	
	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Position ("Position", Vector) = (0,0,0,0)
		_DistanceColor ("Distance Color", Color) = (0,0,0,0)
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
		float3 _Position;
		float4 _DistanceColor;
		float4 _Color;

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
			// Distance calculation
			float dis = distance(IN.worldPos, _Position);
			// Output setup
			if (dis >= 3.5)
				output.Albedo = 0;
			else
				output.Albedo = texInfo.rgb * (1 - (dis/3.5));
		}

		ENDCG
	}
	FallBack "Diffuse"
}
