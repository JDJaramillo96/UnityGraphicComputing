// Directorio /Nombre del shader
Shader "Custom/Challenge01" {

	// Variables disponibles en el inspector (Propiedades)
	Properties{
		_MainColor1("Albedo 1 (RGB)", Color) = (1,1,1,1)
		_MainColor2("Albedo 2 (RGB)", Color) = (1,1,1,1)
	}

	// Primer subshader
	SubShader{
		LOD 200

		CGPROGRAM
		// Método para el cálculo de la luz
		#pragma surface surf Standard fullforwardshadows
		#pragma target 3.0

		// Declaración de variables
		half4 _MainColor1;
		half4 _MainColor2;

		// Información adicional provista por el juego
		struct Input {
			float2 uv_MainTex;
		};

		// Nucleo del programa
		void surf (Input IN, inout SurfaceOutputStandard o) {
			half4 color = (_MainColor1 + _MainColor2) / 2;
			o.Albedo = color.rgb;
		}
		ENDCG

	}// Final del primer subshader

	// Segundo subshader si existe alguno
	// Tercer subshader...

	// Si no es posible ejecutar ningún subshader ejecute Diffuse
	FallBack "Diffuse"
}
