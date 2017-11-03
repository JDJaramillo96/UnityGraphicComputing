Shader "Custom/Ex03-TextureMovement1" {
	
	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_xDispalcement ("X Displacement", Range (-1,1)) = 0
		_yDisplacement ("Y Displacement", Range (-1,1)) = 0
		_Color ("Color", Color) = (1,1,1,1)
	}
	
	SubShader {
		Tags { "RenderType"="Opaque" }
		
		LOD 200
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows
		#pragma target 3.0

		sampler2D _MainTex;
		float _Amplitude;
		float _xDispalcement;
		float _yDisplacement;
		float4 _Color;

		struct Input {
			float2 uv_MainTex;
		};

		UNITY_INSTANCING_CBUFFER_START(Props)
			// put more per-instance properties here
		UNITY_INSTANCING_CBUFFER_END

		void surf (Input IN, inout SurfaceOutputStandard output) {
			// Albedo comes from a texture tinted by color
			float2 displacement = IN.uv_MainTex;
			displacement.x += _xDispalcement * _Time.y;
			displacement.y += _yDisplacement * _Time.y;
			float4 color = tex2D (_MainTex, displacement);
			output.Albedo = color.rgb * _Color;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
