Shader "Custom/Ex01-NormalLightDir-LightingModel"
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
		};

		// --- FUNCTIONS!

		void surf (Input IN, inout SurfaceOutput output)
		{
			output.Albedo = _Color.rgb;
		}

		half4 LightingCustomLightingModel (SurfaceOutput output, half3 lightDir, half lightAtten)
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
