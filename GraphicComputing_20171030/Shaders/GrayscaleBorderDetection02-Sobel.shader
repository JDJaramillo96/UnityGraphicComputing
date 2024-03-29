﻿Shader "Hidden/GrayscaleBorderDetection02-Sobel"
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

			//Sobel function 
			inline float3 SobelFunction(float x, float y)
			{
				return sqrt((x*x) + (y*y));
			}

			//FRAG FUNCTION!
			float4 frag (v2f_img i) : SV_Target
			{
				float4 originalImage = tex2D(_MainTex, i.uv);
				
				float2 texelSize = _MainTex_TexelSize * _TexelSize;

				//GRAYSCALE! ***
				float4 imageCorrection = float4(
					originalImage.r * 0.2126,
					originalImage.g * 0.7152,
					originalImage.b * 0.0722,
					1);

				float grayscale = (imageCorrection.x + imageCorrection.y + imageCorrection.z) / 3;

				//Grayscale image
				float4 grayscaleImage = float4(grayscale, grayscale, grayscale, 1);

				//SOBEL! ***
				float3x3 kernelX = float3x3(
					1.0, 2.0, 1.0,
					0.0, 0.0, 0.0,
					-1.0, -2.0, -1.0
					);

				float3x3 kernelY = float3x3(
					1.0, 0.0, -1.0,
					2.0, 0.0, -2.0,
					1.0, 0.0, -1.0
					);

				float xSobel;
				float ySobel;

				//Sobel convolution for X!
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
						xSobel += newColor * kernelX[row][column];
					}
				}

				//Sobel convolution for Y!
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
						ySobel += newColor * kernelY[row][column];
					}
				}

				float4 sobelImage;

				sobelImage.rgb = SobelFunction(xSobel, ySobel);

				float4 finalColor;
				
				finalColor.rgb = grayscaleImage.rgb - sobelImage.rgb;

				return finalColor;
			}

			ENDCG
		}
	}
}

