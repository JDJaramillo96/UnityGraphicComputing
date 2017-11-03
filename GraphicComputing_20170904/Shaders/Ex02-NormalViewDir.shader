Shader "Custom/Ex02-NormalViewDir"
{	
	Properties
	{
		_Color ("Color", Color) = (1,1,1,1)
	}

	SubShader
	{
		Tags { "RenderType" = "Opaque" }
		
		LOD 200
		
		CGPROGRAM

		#pragma surface surf Standard

		// --- PROPERTIES!

		float4 _Color;

		// --- STRUCTS!

		struct Input
		{
			float3 worldNormal;
			float3 viewDir;
		};

		// --- FUNCTIONS!

		void surf (Input IN, inout SurfaceOutputStandard output)
		{
			float dotProduct = dot(IN.worldNormal, IN.viewDir);
			output.Albedo = float3(dotProduct, dotProduct, dotProduct) * _Color;
		}

		ENDCG
	}

	FallBack "Diffuse"
}
