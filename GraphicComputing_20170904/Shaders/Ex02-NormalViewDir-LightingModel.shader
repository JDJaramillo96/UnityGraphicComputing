Shader "Custom/Ex02-NormalViewDir-LightingModel"
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

		#pragma surface surf CustomLightingModel

		// --- PROPERTIES!

		float4 _Color;

		// --- STRUCTS!

		struct Input
		{
			float3 worldNormal;
			float3 viewDir;
		};

		// --- FUNCTIONS!

		void surf (Input IN, inout SurfaceOutput output)
		{
			float dotProduct = dot(IN.worldNormal, IN.viewDir);
			output.Albedo = float3(dotProduct, dotProduct, dotProduct) * _Color;
		}

		float4 LightingCustomLightingModel (SurfaceOutput output, half3 lightDir, half lightAtten)
		{
			float dotProduct = dot(output.Normal, lightDir);
			float4 color;
			color.rgb = output.Albedo * dotProduct * lightAtten * _LightColor0.rgb;
			color.a = output.Alpha;
			return color;
		}

		ENDCG
	}

	FallBack "Diffuse"
}
