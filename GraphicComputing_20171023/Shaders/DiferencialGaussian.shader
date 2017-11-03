Shader "Hidden/DiferencialGaussian" //TODO
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
				float2 texelSize = _MainTex_TexelSize * _TexelSize;

				/**/
				//Gaussian Blur 3x3 operation
				/**/
				
				//Kernel declaration
				float3x3 GB3x3_kernel = float3x3(
					0.06, 0.13, 0.06, //First row
					0.13, 0.25, 0.13, //Second row
					0.06, 0.13, 0.06 //Third row
					);

				float4 GB3x3_color;

				//Every single adyacent texel sum
				for (int row = 0; row < 3; row++)
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
						GB3x3_color += newColor * GB3x3_kernel[row][column];
					}
				}

				/**/
				//Gaussian Blur 5x5 operation
				/**/

				//Kernel declaration

				//First row
				float GB5x5_kernel_m00 = 0.00;
				float GB5x5_kernel_m01 = 0.02;
				float GB5x5_kernel_m02 = 0.02;
				float GB5x5_kernel_m03 = 0.02;
				float GB5x5_kernel_m04 = 0.00;
				//Second row
				float GB5x5_kernel_m10 = 0.02;
				float GB5x5_kernel_m11 = 0.06;
				float GB5x5_kernel_m12 = 0.09;
				float GB5x5_kernel_m13 = 0.06;
				float GB5x5_kernel_m14 = 0.02;
				//Third row
				float GB5x5_kernel_m20 = 0.02;
				float GB5x5_kernel_m21 = 0.09;
				float GB5x5_kernel_m22 = 0.14;
				float GB5x5_kernel_m23 = 0.09;
				float GB5x5_kernel_m24 = 0.02;
				//Fourth row
				float GB5x5_kernel_m30 = 0.02;
				float GB5x5_kernel_m31 = 0.06;
				float GB5x5_kernel_m32 = 0.09;
				float GB5x5_kernel_m33 = 0.06;
				float GB5x5_kernel_m34 = 0.02;
				//Fifth row
				float GB5x5_kernel_m40 = 0.00;
				float GB5x5_kernel_m41 = 0.02;
				float GB5x5_kernel_m42 = 0.02;
				float GB5x5_kernel_m43 = 0.02;
				float GB5x5_kernel_m44 = 0.00;

				float4 GB5x5_color;

				//This can't do with for cycles

				/**/
				float4 GB5x5_texel00 = tex2D(_MainTex, float2(i.uv.x - (2 * texelSize.x), i.uv.y - (2 * texelSize.y))) * GB5x5_kernel_m00;
				float4 GB5x5_texel10 = tex2D(_MainTex, float2(i.uv.x - (2 * texelSize.x), i.uv.y - texelSize.y)) * GB5x5_kernel_m10;
				float4 GB5x5_texel20 = tex2D(_MainTex, float2(i.uv.x - (2 * texelSize.x), i.uv.y)) * GB5x5_kernel_m20;
				float4 GB5x5_texel30 = tex2D(_MainTex, float2(i.uv.x - (2 * texelSize.x), i.uv.y + texelSize.y)) * GB5x5_kernel_m30;
				float4 GB5x5_texel40 = tex2D(_MainTex, float2(i.uv.x - (2 * texelSize.x), i.uv.y + (2 * texelSize.y))) * GB5x5_kernel_m40;
				/**/
				float4 GB5x5_texel01 = tex2D(_MainTex, float2(i.uv.x - texelSize.x, i.uv.y - (2 * texelSize.y))) * GB5x5_kernel_m01;
				float4 GB5x5_texel11 = tex2D(_MainTex, float2(i.uv.x - texelSize.x, i.uv.y - texelSize.y)) * GB5x5_kernel_m11;
				float4 GB5x5_texel21 = tex2D(_MainTex, float2(i.uv.x - texelSize.x, i.uv.y)) * GB5x5_kernel_m21;
				float4 GB5x5_texel31 = tex2D(_MainTex, float2(i.uv.x - texelSize.x, i.uv.y + texelSize.y)) * GB5x5_kernel_m31;
				float4 GB5x5_texel41 = tex2D(_MainTex, float2(i.uv.x - texelSize.x, i.uv.y + (2 * texelSize.y))) * GB5x5_kernel_m41;
				/**/
				float4 GB5x5_texel02 = tex2D(_MainTex, float2(i.uv.x, i.uv.y - (2 * texelSize.y))) * GB5x5_kernel_m02;
				float4 GB5x5_texel12 = tex2D(_MainTex, float2(i.uv.x, i.uv.y - texelSize.y)) * GB5x5_kernel_m12;
				float4 GB5x5_texel22 = tex2D(_MainTex, float2(i.uv.x, i.uv.y)) * GB5x5_kernel_m22;
				float4 GB5x5_texel32 = tex2D(_MainTex, float2(i.uv.x, i.uv.y + texelSize.y)) * GB5x5_kernel_m32;
				float4 GB5x5_texel42 = tex2D(_MainTex, float2(i.uv.x, i.uv.y + (2 * texelSize.y))) * GB5x5_kernel_m42;
				/**/
				float4 GB5x5_texel03 = tex2D(_MainTex, float2(i.uv.x + texelSize.x, i.uv.y - (2 * texelSize.y))) * GB5x5_kernel_m03;
				float4 GB5x5_texel13 = tex2D(_MainTex, float2(i.uv.x + texelSize.x, i.uv.y - texelSize.y)) * GB5x5_kernel_m13;
				float4 GB5x5_texel23 = tex2D(_MainTex, float2(i.uv.x + texelSize.x, i.uv.y)) * GB5x5_kernel_m23;
				float4 GB5x5_texel33 = tex2D(_MainTex, float2(i.uv.x + texelSize.x, i.uv.y + texelSize.y)) * GB5x5_kernel_m33;
				float4 GB5x5_texel43 = tex2D(_MainTex, float2(i.uv.x + texelSize.x, i.uv.y + (2 * texelSize.y))) * GB5x5_kernel_m43;
				/**/
				float4 GB5x5_texel04 = tex2D(_MainTex, float2(i.uv.x + (2 * texelSize.x), i.uv.y - (2 * texelSize.y))) * GB5x5_kernel_m04;
				float4 GB5x5_texel14 = tex2D(_MainTex, float2(i.uv.x + (2 * texelSize.x), i.uv.y - texelSize.y)) * GB5x5_kernel_m14;
				float4 GB5x5_texel24 = tex2D(_MainTex, float2(i.uv.x + (2 * texelSize.x), i.uv.y)) * GB5x5_kernel_m24;
				float4 GB5x5_texel34 = tex2D(_MainTex, float2(i.uv.x + (2 * texelSize.x), i.uv.y + texelSize.y)) * GB5x5_kernel_m34;
				float4 GB5x5_texel44 = tex2D(_MainTex, float2(i.uv.x + (2 * texelSize.x), i.uv.y + (2 * texelSize.y))) * GB5x5_kernel_m44;

				GB5x5_color =
					GB5x5_texel00 + GB5x5_texel01 + GB5x5_texel02 + GB5x5_texel03 + GB5x5_texel04 +
					GB5x5_texel10 + GB5x5_texel11 + GB5x5_texel12 + GB5x5_texel13 + GB5x5_texel14 +
					GB5x5_texel20 + GB5x5_texel21 + GB5x5_texel22 + GB5x5_texel23 + GB5x5_texel24 +
					GB5x5_texel30 + GB5x5_texel31 + GB5x5_texel32 + GB5x5_texel33 + GB5x5_texel34 +
					GB5x5_texel40 + GB5x5_texel41 + GB5x5_texel42 + GB5x5_texel43 + GB5x5_texel44;

				//Final color calculation
				float4 finalColor = GB5x5_color - GB3x3_color;
				
				return finalColor;
			}

			ENDCG
		}
	}
}

