// Directorio /Nombre del shader
Shader "Custom/Challenge01" {

	// Variables disponibles en el inspector (Propiedades)
	Properties {
		//Se crea una propiedad tipo textura
		_MainTexture1 ("Texture 1 (RGB)", 2D) = "white" {}
		_MainTexture2 ("Texture 2 (RGB)", 2D) = "white" {}
		_Factor ("Texture Blend", Range(0,1)) = 0.5
	}

	SubShader {
		Tags { "RenderType" = "Opaque" }
		LOD 200

		CGPROGRAM
		// Método para el cálculo de la luz
		#pragma surface surf Standard fullforwardshadows
		#pragma target 3.0

		// Declaración de variables
		sampler2D _MainTexture1;
		sampler2D _MainTexture2;
		float _Factor;

		// Información adicional provista por el juego
		struct Input {
			//Siempre: uv_ + nombre de la textura
			float2 uv_MainTexture1;
			float2 uv_MainTexture2;
		};

		// Nucleo del programa
		void surf(Input IN, inout SurfaceOutputStandard o) {
			float4 c1 = tex2D(_MainTexture1, IN.uv_MainTexture1);
			float4 c2 = tex2D(_MainTexture2, IN.uv_MainTexture2);
			float f1 = _Factor;
			float f2 = 1 - _Factor;
			float4 c = c1*f1 + c2*f2;
			o.Albedo = c.rgb;
		}
		ENDCG
	}

	FallBack "Diffuse"
}
