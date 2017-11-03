Shader "Hidden/DepthTexture"
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
			sampler2D _CameraDepthTexture;
			float4 _MainTex_TexelSize;
			float _TexelSize;

			//FRAG FUNCTION!
			float4 frag(v2f_img i) : SV_Target
			{
				float4 originalImage = tex2D(_MainTex, i.uv);

				float2 texelSize = _MainTex_TexelSize * _TexelSize;
				
				//GAUSSIAN BLUR 3X3! ***
				float3x3 kernel = float3x3(
					0.06, 0.13, 0.06, //First row
					0.13, 0.25, 0.13, //Second row
					0.06, 0.13, 0.06 //Third row
					);

				float4 gaussianBlurImage;

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
						float4 newColor = tex2D(_MainTex, newUV);

						//Returned color
						gaussianBlurImage += newColor * kernel[row][column];
					}
				}

				//CAMERA DEPTH TEXTURE! ***
				float cameraDepthTexture = tex2D(_CameraDepthTexture, i.uv);

				float4 finalImage = (gaussianBlurImage * cameraDepthTexture * originalImage) * 0.95 + 0.025;
				
				return finalImage;
			}

			ENDCG
		}
	}
}
