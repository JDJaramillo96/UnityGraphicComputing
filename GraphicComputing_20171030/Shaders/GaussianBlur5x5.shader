Shader "Hidden/GaussianBlur5x5"
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

				/*
				float5x5 kernel = float5x5(
					0.00, 0.02, 0.02, 0.02, 0.00, //First row
					0.02, 0.06, 0.09, 0.06, 0.02, //Second row
					0.02, 0.09, 0.14, 0.09, 0.02, //Third row
					0.02, 0.06, 0.09, 0.06, 0.02, //Fourth row
					0.00, 0.02, 0.02, 0.02, 0.00  //Fifth row
					);
				*/

				//Kernel declaration

				//First row
				float kernel_m00 = 0.00;
				float kernel_m01 = 0.02;
				float kernel_m02 = 0.02;
				float kernel_m03 = 0.02;
				float kernel_m04 = 0.00;
				//Second row
				float kernel_m10 = 0.02;
				float kernel_m11 = 0.06;
				float kernel_m12 = 0.09;
				float kernel_m13 = 0.06;
				float kernel_m14 = 0.02;
				//Third row
				float kernel_m20 = 0.02;
				float kernel_m21 = 0.09;
				float kernel_m22 = 0.14;
				float kernel_m23 = 0.09;
				float kernel_m24 = 0.02;
				//Fourth row
				float kernel_m30 = 0.02;
				float kernel_m31 = 0.06;
				float kernel_m32 = 0.09;
				float kernel_m33 = 0.06;
				float kernel_m34 = 0.02;
				//Fifth row
				float kernel_m40 = 0.00;
				float kernel_m41 = 0.02;
				float kernel_m42 = 0.02;
				float kernel_m43 = 0.02;
				float kernel_m44 = 0.00;

				float4 finalColor;

				//This can't do with for cycles
				
				/**/
				float4 texel00 = tex2D(_MainTex, float2(i.uv.x - (2 * texelSize.x), i.uv.y - (2 * texelSize.y))) * kernel_m00;
				float4 texel10 = tex2D(_MainTex, float2(i.uv.x - (2 * texelSize.x), i.uv.y - texelSize.y)) * kernel_m10;
				float4 texel20 = tex2D(_MainTex, float2(i.uv.x - (2 * texelSize.x), i.uv.y)) * kernel_m20;
				float4 texel30 = tex2D(_MainTex, float2(i.uv.x - (2 * texelSize.x), i.uv.y + texelSize.y)) * kernel_m30;
				float4 texel40 = tex2D(_MainTex, float2(i.uv.x - (2 * texelSize.x), i.uv.y + (2 * texelSize.y))) * kernel_m40;
				/**/
				float4 texel01 = tex2D(_MainTex, float2(i.uv.x - texelSize.x, i.uv.y - (2 * texelSize.y))) * kernel_m01;
				float4 texel11 = tex2D(_MainTex, float2(i.uv.x - texelSize.x, i.uv.y - texelSize.y)) * kernel_m11;
				float4 texel21 = tex2D(_MainTex, float2(i.uv.x - texelSize.x, i.uv.y)) * kernel_m21;
				float4 texel31 = tex2D(_MainTex, float2(i.uv.x - texelSize.x, i.uv.y + texelSize.y)) * kernel_m31;
				float4 texel41 = tex2D(_MainTex, float2(i.uv.x - texelSize.x, i.uv.y + (2 * texelSize.y))) * kernel_m41;
				/**/
				float4 texel02 = tex2D(_MainTex, float2(i.uv.x, i.uv.y - (2 * texelSize.y))) * kernel_m02;
				float4 texel12 = tex2D(_MainTex, float2(i.uv.x, i.uv.y - texelSize.y)) * kernel_m12;
				float4 texel22 = tex2D(_MainTex, float2(i.uv.x, i.uv.y)) * kernel_m22;
				float4 texel32 = tex2D(_MainTex, float2(i.uv.x, i.uv.y + texelSize.y)) * kernel_m32;
				float4 texel42 = tex2D(_MainTex, float2(i.uv.x, i.uv.y + (2 * texelSize.y))) * kernel_m42;
				/**/
				float4 texel03 = tex2D(_MainTex, float2(i.uv.x + texelSize.x, i.uv.y - (2 * texelSize.y))) * kernel_m03;
				float4 texel13 = tex2D(_MainTex, float2(i.uv.x + texelSize.x, i.uv.y - texelSize.y)) * kernel_m13;
				float4 texel23 = tex2D(_MainTex, float2(i.uv.x + texelSize.x, i.uv.y)) * kernel_m23;
				float4 texel33 = tex2D(_MainTex, float2(i.uv.x + texelSize.x, i.uv.y + texelSize.y)) * kernel_m33;
				float4 texel43 = tex2D(_MainTex, float2(i.uv.x + texelSize.x, i.uv.y + (2 * texelSize.y))) * kernel_m43;
				/**/
				float4 texel04 = tex2D(_MainTex, float2(i.uv.x + (2 * texelSize.x), i.uv.y - (2 * texelSize.y))) * kernel_m04;
				float4 texel14 = tex2D(_MainTex, float2(i.uv.x + (2 * texelSize.x), i.uv.y - texelSize.y)) * kernel_m14;
				float4 texel24 = tex2D(_MainTex, float2(i.uv.x + (2 * texelSize.x), i.uv.y)) * kernel_m24;
				float4 texel34 = tex2D(_MainTex, float2(i.uv.x + (2 * texelSize.x), i.uv.y + texelSize.y)) * kernel_m34;
				float4 texel44 = tex2D(_MainTex, float2(i.uv.x + (2 * texelSize.x), i.uv.y + (2 * texelSize.y))) * kernel_m44;

				finalColor =
					texel00 + texel01 + texel02 + texel03 + texel04 +
					texel10 + texel11 + texel12 + texel13 + texel14 +
					texel20 + texel21 + texel22 + texel23 + texel24 +
					texel30 + texel31 + texel32 + texel33 + texel34 +
					texel40 + texel41 + texel42 + texel43 + texel44;

				return finalColor;
			}

			ENDCG
		}
	}
}

