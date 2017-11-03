Shader "Hidden/GrayscaleBorderDetection01"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_TexelSize("Texel Size", Float) = 1
	}
	
	SubShader
	{
		Cull Off ZWrite Off ZTest Always

		Pass
		{
			CGPROGRAM

			#pragma vertex vert_img
			#pragma fragment frag
			#pragma fragmentoption ARB_precision_hint_fastest
			
			#include "UnityCG.cginc"

			//PROPERTIES!
			sampler2D _MainTex;
			float4 _MainTex_TexelSize;
			float _TexelSize;

			//FRAG FUNCTION!
			float4 frag (v2f_img i) : SV_Target
			{
				float4 originalImage = tex2D(_MainTex, i.uv);
				
				float2 texelSize = _MainTex_TexelSize * _TexelSize;

				//BORDER DETECTION! ***
				float3x3 kernel = float3x3(
					0, 1, 0, //First row
					1, -4, 1, //Second row
					0, 1, 0 //Third row
					);

				float4 borderColor;

				//Convultion!
				for (int row = 0; row < 3; row++) //The same operation with for cycles
				{
					for (int column = 0; column < 3; column++)
					{
						//new UV
						float2 newUV = float2(
							(i.uv.x - texelSize.x) + column * texelSize.x,
							(i.uv.y - texelSize.y) + row * texelSize.y
							);

						//New color
						float newColor = tex2D(_MainTex, newUV);

						//Returned color
						borderColor += newColor * kernel[row][column];
					}
				}

				float3 finalColor = originalImage - borderColor;

				//GRAYSCALE! ***
				float4 imageCorrection = float4(
					finalColor.r * 0.2126,
					finalColor.g * 0.7152,
					finalColor.b * 0.0722,
					1);

				//Grayscale calculation
				float grayscale = (imageCorrection.x + imageCorrection.y + imageCorrection.z) / 3;

				return float4(grayscale, grayscale, grayscale, originalImage.a);
			}

			ENDCG
		}
	}
}

