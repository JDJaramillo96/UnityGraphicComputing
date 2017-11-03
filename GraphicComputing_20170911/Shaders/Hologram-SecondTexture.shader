Shader "Custom/Hologram-SecondTexture" {
	
	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Mask ("Mask", 2D) = "white" {}
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0
		_Alpha ("Alpha", Range(0,1)) = 1.0
		_xMovement ("X Displacement Velocity", Range(-1,1)) = 0
		_yMovement ("Y Displacement Velocity", Range(-1,1)) = 0
		_Color ("Color", Color) = (1,1,1,1)
	}

	SubShader {
		Tags 
		{
			"Queue" = "Transparent"
			"IgnoreProjector" = "True"
			"RenderType" = "TransparentCutout"
		}

		LOD 200
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows alpha:fade
		#pragma target 3.0

		sampler2D _MainTex;
		sampler2D _Mask;
		half _Glossiness;
		half _Metallic;
		half _Alpha;
		half _xMovement;
		half _yMovement;
		float4 _Color;

		struct Input {
			float2 uv_MainTex;
			float3 worldNormal;
			float3 viewDir;
		};

		UNITY_INSTANCING_CBUFFER_START(Props)
			// put more per-instance properties here
		UNITY_INSTANCING_CBUFFER_END

		void surf (Input IN, inout SurfaceOutputStandard output) {
			// Texture info
			float4 texInfo = tex2D (_MainTex, IN.uv_MainTex);			
			// UV movement
			float2 newUV = IN.uv_MainTex;
			newUV.x += _Time.y * _xMovement;
			newUV.y += _Time.y * _yMovement;
			// Mask info
			float4 maskInfo = tex2D (_Mask, newUV);
			// Dot product
			float dotProduct = abs(dot(IN.worldNormal, IN.viewDir));
			// Output setup
			output.Albedo = texInfo.rgb * _Color;
			output.Metallic = _Metallic;
			output.Smoothness = _Glossiness;
			output.Alpha = (1 - dotProduct) * maskInfo * _Alpha;
		}
		ENDCG
	}

	FallBack "Diffuse"
}
