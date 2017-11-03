Shader "Hidden/Grayscale01"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
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

			float4 frag (v2f_img i) : SV_Target
			{
				float4 color = tex2D(_MainTex, i.uv);
				
				//Grayscale calculation
				float grayscale = (color.r + color.g + color.b) / 3;
				
				//Final color
				return float4(grayscale, grayscale, grayscale, color.a);
			}
			ENDCG
		}
	}
}
