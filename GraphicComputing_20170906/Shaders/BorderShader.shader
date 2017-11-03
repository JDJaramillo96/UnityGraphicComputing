Shader "Custom/Surface/BorderShader"
{	
	Properties
	{
		_MainTex ("Main Texture", 2D) = "white" {}
		_Color ("Color", Color) = (1,1,1,1)
		_BorderColor ("Border Color", Color) = (1,1,1,1)
	}

	SubShader
	{
		Tags
		{
			"RenderType" = "Opaque"
		}
		
		LOD 200
		
		CGPROGRAM

		#pragma surface surf Standard fullforwardshadows
		#pragma target 3.0

		// --- PROPERTIES!

		sampler2D _MainTex;
		float4 _Color;
		float4 _BorderColor;

		// --- STRUCTS!

		struct Input
		{
			float2 uv_MainTex;
			float3 worldNormal;
			float3 viewDir;
		};

		// --- SUBSHADER FUNCTIONS!

		void surf (Input IN, inout SurfaceOutputStandard output)
		{
			// Texture info
			float3 texInfo = tex2D(_MainTex, IN.uv_MainTex);
			// Dot product between face normal and view direction
			float dotProduct = abs(dot(IN.worldNormal, IN.viewDir));
			float dotProductComplement = 1-dotProduct;
			// Color calculations
			float3 finalCol1 = dotProduct * _Color;
			float3 finalCol2 = dotProductComplement * _BorderColor;
			// Output setting
			output.Albedo = (finalCol1 + finalCol2) * texInfo;
		}

		ENDCG
	}

	FallBack "Diffuse"
}
