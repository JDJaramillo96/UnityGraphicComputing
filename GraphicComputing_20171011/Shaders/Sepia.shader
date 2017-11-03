Shader "Hidden/Sepia"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
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

			float3 RGBtoYIQ(float3 RGB)
			{
				//Trasnformation matrix
				float3x3 transformationMatrix = float3x3(
					0.299, 0.587, 0.114,
					0.595716, -0.274453, -0.321263,
					0.211456, -0.522591, 0.311135
					);

				//YIQ Color calculation
				float1x3 yiq = mul(transformationMatrix, RGB.rgb);
				
				return transpose(yiq);
			}

			float3 YIQtoRGB(float3 YIQ)
			{
				//Transformation matrix
				float3x3 transformationMatrix = float3x3(
					1, 0.9563, 0.6210,
					1, -0.2712, -0.6474,
					1, -1.1070, 1.7046
					);

				//RGB Color calculation
				float1x3 rgb = mul(transformationMatrix, YIQ.rgb);

				return transpose(rgb);
			}

			float4 frag (v2f_img i) : SV_Target
			{
				float4 color = tex2D(_MainTex, i.uv);

				//Sepia magic color
				float3 magicColor = float3(0.191, -0.054, -0.221);
				//YIQ color
				float3 yiqColor = RGBtoYIQ(color.rgb);

				//Final color
				float3 finalColor = magicColor + yiqColor.x;
				return float4(finalColor.r, finalColor.g, finalColor.b, color.a);
			}
			ENDCG
		}
	}
}
