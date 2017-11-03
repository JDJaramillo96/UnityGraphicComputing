Shader "Custom/WaterMaskReflection" {

	Properties {
		_Texture ("Textura", 2D) = "white" {}
		_TextureReflection ("Textura Reflejo", 2D) = "white" {}
		_TextureFluid ("Textura Fluido", 2D) = "white" {}
		_Mask ("Mascara", 2D) = "white" {}
		_xVelocity ("Velocidad X", Range(0,10)) = 2
		_yVelocity ("Velocidad Y", Range(0,10)) = 2
		_Factor ("Factor", Range(0,1)) = 0.5
		_Color ("Color principal", Color) = (1,1,1,1)
	}

	SubShader {
		LOD 200
		
		CGPROGRAM

		#pragma surface surf Standard fullforwardshadows
		#pragma target 3.0

		// --- PROPERTIES!

		sampler2D _Texture;
		sampler2D _TextureReflection;
		sampler2D _TextureFluid;
		sampler2D _Mask;
		float _xVelocity;
		float _yVelocity;
		float _Factor;
		float4 _Color;

		// --- INPUT STRUCT!
		
		struct Input {
			float2 uv_Texture;
			float2 uv_TextureReflection;
		};

		// --- SURF FUNCTION!

		void surf (Input IN, inout SurfaceOutputStandard output) {
			// UV movement
			float2 uvFluidMovement = IN.uv_Texture; //??? IN.uv_Texture ???
			float2 uvReflectionMovement = IN.uv_TextureReflection;
			uvFluidMovement.y += _xVelocity * _Time.x;
			uvReflectionMovement.x += _yVelocity * _Time.x;
			// Texture info
			float4 mainTexture = tex2D(_Texture, IN.uv_Texture);
			float4 textureReflection = tex2D(_TextureReflection, uvReflectionMovement);
			float4 textureFluid = tex2D(_TextureFluid, uvFluidMovement); //??? IN.uv_Texture ???
			// Mask info
			float4 mask = tex2D(_Mask, IN.uv_Texture); //??? IN.uv_Texture ???
			float4 maskComplement = 1-mask;
			// Factors
			float factor = _Factor;
			float factorComplement = 1-factor;
			// Final properties assigment
			float4 mainTextureColor = mainTexture * mask;
			float4 textureFluidColor = textureFluid * maskComplement * factor;
			float4 textureReflectionColor = textureReflection * maskComplement * factorComplement;
			float4 finalColor = mainTextureColor + textureFluidColor + textureReflectionColor;
			output.Albedo = finalColor.rgb * _Color;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
