Shader "Hidden/SobelToonShading"
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

			//HUE to RGB 
			inline float3 SobelFunction(float x, float y)
			{
				return sqrt((x*x) + (y*y));
			}

			//FRAG FUNCTION!
			float4 frag (v2f_img i) : SV_Target
			{
				float2 texelSize = _MainTex_TexelSize * _TexelSize;
				
				//SOBEL! ***
				float3x3 sobelKernel_X = float3x3(
					1.0, 2.0, 1.0,
					0.0, 0.0, 0.0,
					-1.0, -2.0, -1.0
					);

				float3x3 sobelKernel_Y = float3x3(
					1.0, 0.0, -1.0,
					2.0, 0.0, -2.0,
					1.0, 0.0, -1.0
					);

				//Original image info
				float4 originalImage = tex2D(_MainTex, i.uv);

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
						float4 newColor = tex2D(_MainTex, newUV);

						//Returned color
						xSobel += newColor * sobelKernel_X[row][column];
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
						float4 newColor = tex2D(_MainTex, newUV);

						//Returned color
						ySobel += newColor * sobelKernel_Y[row][column];
					}
				}

				float3 finalSobelColor = SobelFunction(xSobel, ySobel);

				return float4((originalImage - finalSobelColor).rgb, 1);
			}

			ENDCG
		}
	}
}
