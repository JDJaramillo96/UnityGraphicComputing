Shader "Custom/NormalBordes" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
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

		void surf (Input IN, inout SurfaceOutputStandard o) {
			float4 c1 = tex2D (_MainTex, IN.uv_MainTex);
			float4 n = tex2D (_Normal, IN.uv_MainTex2);
			float x = abs(dot(IN.worldNormal, IN.viewDir));
			float4 c = float4 (x, x, x, 1);
			float3 normal = UnpackNormal (n).rgb;

			if (x <= .5){
				c = _Color;
			}else{
				 c = c1;
			}

			// o.Normal = normalize (normal);
			o.Albedo = c.rgb;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
