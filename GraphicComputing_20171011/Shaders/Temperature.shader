Shader "Hidden/Temperature"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_TemperatureColor("Color", Color) = (1,1,1,1)
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
			float4 _TemperatureColor;

			float4 frag (v2f_img i) : SV_Target
			{
				float4 color = tex2D(_MainTex, i.uv);
				//Final color
				return color * _TemperatureColor;
			}
			ENDCG
		}
	}
}
