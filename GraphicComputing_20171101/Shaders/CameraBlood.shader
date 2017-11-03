Shader "Hidden/CameraBlood"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_BloodTex("Blood Texture", 2D) = "white" {}
		_BloodMask("Mask", 2D) = "white" {}
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
			sampler2D _BloodTex;
			sampler2D _BloodMask;
			float _TexelSize;

			//FRAG FUNCTION!
			float4 frag (v2f_img i) : SV_Target
			{
				//Textures info
				float4 originalImage = tex2D(_MainTex, i.uv);
				float4 bloodImage = tex2D(_BloodTex, i.uv);

				//Mask info
				float bloodMask = tex2D(_BloodMask, i.uv);
				
				//Final color
				float4 finalColor = (originalImage * bloodMask) + (bloodImage * (1 - bloodMask));
				return finalColor;
			}

			ENDCG
		}
	}
}

