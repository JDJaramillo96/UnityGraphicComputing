Shader "Custom/Surface/MultiBorder"
{	
	Properties
	{
		_MainTex ("Main Texture", 2D) = "white" {}
		_Umbral1 ("Umbral 1", Range(0,1)) = 0.5
		_Umbral2 ("Umbral 2", Range(0,1)) = 0.25
		_UmbralColor1 ("Umbral Color 1", Color) = (1,1,1,1)
		_UmbralColor2 ("Umbral Color 2", Color) = (1,1,1,1)
		_Color ("Color", Color) = (1,1,1,1)
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
		float _Umbral1;
		float _Umbral2;
		float4 _UmbralColor1;
		float4 _UmbralColor2;
		float4 _Color;

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
			float3 col = tex2D(_MainTex, IN.uv_MainTex);
			// Dot product between face normal and view direction
			float dotProduct = abs(dot(IN.worldNormal, IN.viewDir));

			// Output setting
			if (dotProduct > _Umbral2 && dotProduct < _Umbral1)
				output.Albedo = _UmbralColor1 * _Color;
			else if (dotProduct < _Umbral2)
				output.Albedo = _UmbralColor2 * _Color;
			else
				output.Albedo = col * _Color;
		}

		ENDCG
	}

	FallBack "Diffuse"
}
