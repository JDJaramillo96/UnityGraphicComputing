Shader "Hidden/ToneChange"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_ToneAdd("Tone Add", Float) = 0.0
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
			float _ToneAdd;
			//Const
			float Epsilon = 1e-10;

			/**/
			//Taked from: http://www.chilliant.com/rgb2hsv.html
			/**/

			//Other color transformation
			float3 RGBtoHCV(float3 RGB)
			{
				// Based on work by Sam Hocevar and Emil Persson
				float4 P = (RGB.g < RGB.b) ? float4(RGB.bg, -1.0, 2.0 / 3.0) : float4(RGB.gb, 0.0, -1.0 / 3.0);
				float4 Q = (RGB.r < P.x) ? float4(P.xyw, RGB.r) : float4(RGB.r, P.yzx);
				float C = Q.x - min(Q.w, Q.y);
				float H = abs((Q.w - Q.y) / (6 * C + Epsilon) + Q.z);
				return float3(H, C, Q.x);
			}

			float3 HUEtoRGB(float H)
			{
				float R = abs(H * 6 - 3) - 1;
				float G = 2 - abs(H * 6 - 2);
				float B = 2 - abs(H * 6 - 4);
				return saturate(float3(R, G, B));
			}

			//Color transformations
			float3 RGBtoHSV(float3 RGB)
			{
				float3 HCV = RGBtoHCV(RGB);
				float S = HCV.y / (HCV.z + Epsilon);
				return float3(HCV.x, S, HCV.z);
			}

			float3 HSVtoRGB(float3 HSV)
			{
				float3 RGB = HUEtoRGB(HSV.x);
				return ((RGB - 1) * HSV.y + 1) * HSV.z;
			}

			//Frag function
			float4 frag (v2f_img i) : SV_Target
			{
				float4 color = tex2D(_MainTex, i.uv);
				
				//RGB to HSV
				float3 hsvColor = RGBtoHSV(color.xyz);
				//Hue correction
				hsvColor.x += _ToneAdd;
				//HSV to RGB
				float3 rgbColor = HSVtoRGB(hsvColor.xyz);

				//Final color
				return float4(rgbColor.xyz, color.a);
			}
			ENDCG
		}
	}
}
