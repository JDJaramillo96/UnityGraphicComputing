Shader "Hidden/GrayscaleDepthTexture"
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
				
				//CAMERA DEPTH TEXTURE! ***
				float cameraDepthTexture = tex2D(_CameraDepthTexture, i.uv);

				//GRAYSACLE! ***
				float4 imageCorrection = float4(
					originalImage.r * 0.2126,
					originalImage.g * 0.7152,
					originalImage.b * 0.0722,
					1);

				//Grayscale calculation
				float grayscale = (imageCorrection.x + imageCorrection.y + imageCorrection.z) / 3;
				
				if (cameraDepthTexture >= 0.045)
					return originalImage;
				else
					return grayscale;
			}

			ENDCG
		}
	}
}
