Shader "Hidden/A2"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_ImageCB("Contrast & Brightness", Range(0.9, 1.1)) = 1.0
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

			sampler2D _MainTex;
			float _ImageCB;

			float4 frag (v2f_img i) : COLOR
			{
				float4 c1 = tex2D(_MainTex, i.uv);
				float4 c2 = pow(c1 * 255.0, _ImageCB);
				c2 = c2 / 255.0;
				return c2;
			}

			ENDCG
		}
	}
}
