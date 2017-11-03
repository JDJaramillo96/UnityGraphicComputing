Shader "Hidden/A3"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_Min("Min color value", Range(0.0, 255.0)) = 0.0
		_Max("Max color value", Range(0.0, 255.0)) = 255.0
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
			float _Min;
			float _Max;

			float4 frag (v2f_img i) : COLOR
			{
				float4 c1 = tex2D(_MainTex, i.uv) * 255.0;
				//Image calculation
				float b = -_Min;
				float a = 255.0 / (_Max + b);
				//Color calculation
				float4 c2 = (c1 + b) * a;
				//Final color
				return c2 / 255.0;
			}

			ENDCG
		}
	}
}
