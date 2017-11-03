Shader "Hidden/HighlightColor-Blue"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_HighlightColor ("Highlight Color", Color) = (1,1,1,1)
		_ColorCorrection("Color Correction", Float) = 1.5
	}

	SubShader
	{
		// No culling or depth
		Cull Off ZWrite Off ZTest Always

		Pass
		{
			CGPROGRAM
			#pragma vertex vert_img
			#pragma fragment frag
			#pragma fragmentoption ARB_precision_hint_fastest
			
			#include "UnityCG.cginc"

			sampler2D _MainTex;
			float4 _HighlightColor;
			float _ColorCorrection;

			float4 frag (v2f_img i) : SV_Target
			{
				float4 color = tex2D(_MainTex, i.uv);

				//Color checker
				float redFactor = color.r * _ColorCorrection;
				float greenFactor = color.g * _ColorCorrection;

				//Final color
				if (color.b >= redFactor && color.b >= greenFactor)
				{
					return color * _HighlightColor;
				}
				else
				{
					//Image color correction
					float4 imageCorrection = float4(color.r * 0.2126, color.b * 0.7152, color.g * 0.0722, color.a);
					//Grayscale calculation
					float grayscale = (imageCorrection.x + imageCorrection.y + imageCorrection.z) / 3;

					return float4(grayscale, grayscale, grayscale, imageCorrection.a);
				}
			}
			ENDCG
		}
	}
}
