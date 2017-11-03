Shader "Custom/NormalBordesNoIf" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_Color2 ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Normal ("Normal", 2D) = "white" {}
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf Standard fullforwardshadows
		#pragma target 3.0

		sampler2D _MainTex;
		sampler2D _Normal;

		struct Input {
			float2 uv_MainTex;
			float2 uv_MainTex2;
			float3 worldNormal;
			float3 viewDir;
		};
		float4 _Color;
		float4 _Color2; 

		void surf (Input IN, inout SurfaceOutputStandard o) {
			float bordes = abs(dot(IN.viewDir, IN.worldNormal));

			float4 c1 = float4(bordes, bordes, bordes, 1);
			bordes = pow(bordes , 0.5);

			float4 c2 = (1-bordes) * _Color2;
			float4 c3 = tex2D(_MainTex, IN.uv_MainTex) * _Color;

			float4 c = c3 * (c1) + c2;

			o.Albedo = c.rgb;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
