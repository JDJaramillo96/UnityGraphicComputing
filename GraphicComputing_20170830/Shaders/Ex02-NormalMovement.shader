Shader "Custom/Ex02-NormalMovement" {
	
	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Normal ("Normal Map", 2D)  = "bump" {}
		_xDisplacement ("X Velocity", Range(-1,1)) = 0
		_yDisplacement ("Y Velocity", Range(-1,1)) = 0
		_Velocity ("Velocity", Range(-10,10)) = 0
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
		sampler2D _Normal;
		float _xDisplacement;
		float _yDisplacement;
		float _Velocity;
		float4 _Color;

		struct Input {
			float2 uv_MainTex;
		};

		UNITY_INSTANCING_CBUFFER_START(Props)
			// put more per-instance properties here
		UNITY_INSTANCING_CBUFFER_END

		void surf (Input IN, inout SurfaceOutputStandard output) {
			// Textures info
			float4 color = tex2D (_MainTex, IN.uv_MainTex);
			float2 displacement = IN.uv_MainTex;
			// Setting displacement
			displacement.x += _xDisplacement * _Time.y;
			displacement.y += _yDisplacement * _Time.y;
			displacement *= _Velocity;
			// Setting normal map
			float4 normal = tex2D (_Normal, displacement);
			float3 normalInfo = UnpackNormal(normal).rgb;
			// Output setup
			output.Albedo = color.rgb * _Color;
			output.Normal = normalize(normalInfo);
		}
		ENDCG
	}
	FallBack "Diffuse"
}
