Shader "Hidden/A1"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_Brightness("Brightness", Range(-1.0, 1.0)) = 0.0
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
			float _Brightness;

			float4 frag (v2f_img i) : COLOR
			{
				float4 c1 = tex2D(_MainTex, i.uv);
				float4 c2 = c1 + _Brightness;
				return c2;
			}

			ENDCG
		}
	}
}
