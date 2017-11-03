Shader "Custom/EX03-ViewDir" {
	
	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Color ("Color", Color) = (1,1,1,1)
	}
	
	SubShader {
		
		Tags { "RenderType"="Opaque" }
		
		LOD 200
		
		CGPROGRAM

		/* ??? fullforwardshadows ??? */
		#pragma surface surf CustomLightingModel
		#pragma target 3.0

		sampler2D _MainTex;
		float4 _Color;

		struct Input {
			float2 uv_MainTex;
		};

		UNITY_INSTANCING_CBUFFER_START(Props)
			// put more per-instance properties here
		UNITY_INSTANCING_CBUFFER_END

		void surf (Input IN, inout SurfaceOutput output) {
			// Texture info
			float4 texInfo = tex2D (_MainTex, IN.uv_MainTex);
			// Output setup
			output.Albedo = texInfo.rgb * _Color;
		}

		float4 LightingCustomLightingModel (SurfaceOutput output, float3 lightDirection, float3 viewDir, float3 lightAttem) {
			// Light model implementation
			float light = dot(output.Normal, lightDirection);
			float cam = dot(output.Normal, viewDir);
			// Color calculation
			float4 col;
			col.rgb = output.Albedo * lightAttem * _LightColor0.rgb * light * 0.5;
			float4 camCol;
			camCol.rgb = output.Albedo * lightAttem * _LightColor0.rgb * cam * 0.5;
			float4 finalCol;
			finalCol.rgb =  col.rgb + camCol.rgb;
			return finalCol;
		}

		ENDCG
	}
	FallBack "Diffuse"
}
