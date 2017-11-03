Shader "Hidden/CornerDetection"
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
				
				//Kernel declaration
				float3x3 kernel = float3x3(
					1, 0, -1, //First row
					0, 0, 0, //Second row
					-1, 0, 1 //Third row
					);

				float4 finalColor;

				/*
				//Every single adyacent texel
				float4 texel00 = tex2D(_MainTex, float2(i.uv.x - texelSize.x, i.uv.y - texelSize.y)) * kernel._m00;
				float4 texel10 = tex2D(_MainTex, float2(i.uv.x - texelSize.x, i.uv.y)) * kernel._m10;
				float4 texel20 = tex2D(_MainTex, float2(i.uv.x - texelSize.x, i.uv.y + texelSize.y)) * kernel._m20;
				float4 texel01 = tex2D(_MainTex, float2(i.uv.x, i.uv.y - texelSize.y)) * kernel._m01;
				float4 texel11 = tex2D(_MainTex, float2(i.uv.x, i.uv.y)) * kernel._m11;
				float4 texel21 = tex2D(_MainTex, float2(i.uv.x, i.uv.y + texelSize.y)) * kernel._m21;
				float4 texel02 = tex2D(_MainTex, float2(i.uv.x + texelSize.x, i.uv.y - texelSize.y)) * kernel._m02;
				float4 texel12 = tex2D(_MainTex, float2(i.uv.x + texelSize.x, i.uv.y)) * kernel._m12;
				float4 texel22 = tex2D(_MainTex, float2(i.uv.x + texelSize.x, i.uv.y + texelSize.y)) * kernel._m22;

				finalColor = texel00 + texel10 + texel20 + texel01 + texel11 + texel21 + texel02 + texel12 + texel22;
				*/
				
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
						finalColor += newColor * kernel[row][column];
					}
				}

				return finalColor;
			}

			ENDCG
		}
	}
}

