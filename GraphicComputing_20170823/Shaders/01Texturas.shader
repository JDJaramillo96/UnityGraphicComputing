// Directorio /Nombre del shader
Shader "Custom/BaseTexturas/01TexturaBase" {

	// Variables disponibles en el inspector (Propiedades)
	Properties{
		//Se crea una propiedad tipo textura
		_Textura("Textura (RGB)", 2D) = "white" {}
	}

	SubShader{
	Tags{ "RenderType" = "Opaque" }
	LOD 200

	CGPROGRAM
	// Método para el cálculo de la luz
	#pragma surface surf Standard fullforwardshadows
	#pragma target 3.0
		
	// Declaración de variables
	sampler2D _Textura;

	// Información adicional provista por el juego
	struct Input {
		//Siempre: uv_ + nombre de la textura
		float2 uv_Textura;
	};

	// Nucleo del programa
	void surf(Input IN, inout SurfaceOutputStandard o) {
		float4 c = tex2D(_Textura, IN.uv_Textura);
		o.Albedo = c.rgb;
	}
	ENDCG
	}

	FallBack "Diffuse"
}

