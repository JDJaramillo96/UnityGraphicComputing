Shader "Custom/Surface/BorderShader-Discret"
{	
	Properties
	{
		_MainTex ("Main Texture", 2D) = "white" {}
		_Umbral ("Umbral", Range(0,1)) = 0.5
		_UmbralColor ("Umbral Color", Color) = (1,1,1,1)
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
		float _Umbral;
		float4 _UmbralColor;
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
			if (dotProduct < _Umbral)
				output.Albedo = _UmbralColor * _Color;
			else
				output.Albedo = col * _Color;
		}

		ENDCG
	}

	FallBack "Diffuse"
}
