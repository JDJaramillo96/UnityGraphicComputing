Shader "Hidden/Distortion"
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

				//DISTORTION! ***
				float Ax = 25;
				float Ay = 25;

				float overTime = sin(_Time.w);

				overTime + 1;
				overTime *= 0.5;
				
				Ax *= overTime;
				Ay *= overTime;

				float distortion = sin(i.uv.x + i.uv.y);

				distortion + 1;
				distortion *= 0.5;

				float2 distortedUV = float2(i.uv.x + distortion * texelSize.x * Ax, i.uv.y + distortion * texelSize.y * Ay);
				
				float4 distortedImage = tex2D(_MainTex, distortedUV);

				return distortedImage;
			}

			ENDCG
		}
	}
}
