Shader "Custom/TwinklingLight" {
	Properties {
		_MainTex("Albedo (RGB)", 2D) = "white" {}
		_Color("Color", Color) = (1,1,1,1)
		_Amplitude("Amplitude", Float) = 1
		_Factor("Factor", Float) = 1
	}

	SubShader {
		Tags { "RenderType" = "Opaque" }
		
		LOD 200
		
		CGPROGRAM
		
		/* ??? fullforwardshadows ??? */
		#pragma surface surf CustomLightingModel
		#pragma target 3.0
				
		//PROPERTIES!	
		sampler2D _MainTex;
		float4 _Color;
		float _Amplitude;
		float _Factor;

		//INPUT!
		struct Input {
			float2 uv_MainTex;
		};

		UNITY_INSTANCING_CBUFFER_START(Props)
			//put more per-instance properties here
		UNITY_INSTANCING_CBUFFER_END

		//SURF FUNCTION!
		void surf (Input IN, inout SurfaceOutput output) {
			//Albedo comes from a texture tinted by color
			float4 texInfo = tex2D(_MainTex, IN.uv_MainTex);
			output.Albedo = texInfo.rgb * _Color.rgb;
		}

		//CUSTOM LIGHTING MODEL FUNCTIONS!
		float4 LightingCustomLightingModel(SurfaceOutput output, float3 lightDirection, float3 lightAttem) {
			//Sin by time
			float sinByTime = sin(_Time.y * _Amplitude);
			sinByTime += 1;
			sinByTime *= 0.5;
			//Light model implementation
			float3 light = dot(output.Normal, lightDirection) * lightAttem * _LightColor0.rgb * output.Albedo;
			float3 lightByTime = light * sinByTime;
			//Final light
			float3 finalLight = light + (lightByTime * _Factor);
			//Color calculation
			float4 col;
			col.rgb = float4(finalLight.rgb, 1);
			return col;
		}

		ENDCG
	}

	FallBack "Diffuse"
}
