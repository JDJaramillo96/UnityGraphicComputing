// Directorio /Nombre del shader
Shader "Custom/Challenge02" {

	// Variables disponibles en el inspector (Propiedades)
	Properties {
		//Se crea una propiedad tipo textura
		_MainTexture ("Texture 1 (RGB)", 2D) = "white" {}
		_Mask ("Mask ", 2D) = "white" {}
		_Color ("Mask Color", Color) = (1,1,1,1)
	}

	SubShader {
		Tags { "RenderType" = "Opaque" }
		LOD 200

		CGPROGRAM
		// Método para el cálculo de la luz
		#pragma surface surf Standard fullforwardshadows
		#pragma target 3.0

		// Declaración de variables
		sampler2D _MainTexture;
		sampler2D _Mask;
		float4 _Color;

		// Información adicional provista por el juego
		
		struct Input {
			//Siempre: uv_ + nombre de la textura
			float2 uv_MainTexture;
		};

		// Nucleo del programa
		void surf(Input IN, inout SurfaceOutputStandard o) {
			float4 texInfo = tex2D(_MainTexture, IN.uv_MainTexture);
			float4 maskInfo = tex2D(_Mask, IN.uv_MainTexture);
			float4 c = texInfo * maskInfo;
			o.Albedo = c.rgb * _Color;
		}
		ENDCG
	}

	FallBack "Diffuse"
}
