Shader "Custom/Ex01-NormalLightDir"
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
			float3 lightDir;
			float lightAtten;
		};

		// --- FUNCTIONS!

		void surf (Input IN, inout SurfaceOutputStandard output)
		{
			float dotProduct = dot(IN.worldNormal, IN.lightDir);
			output.Albedo = _Color.rgb * dotProduct  *IN.lightAtten;
		}

		ENDCG
	}

	FallBack "Diffuse"
}
