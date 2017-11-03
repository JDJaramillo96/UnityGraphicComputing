using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ImageEffectA3 : MonoBehaviour {

	#region Properties

	[SerializeField]
    private Shader shader;

    [Space(10f)]

    [SerializeField] [Range(0.0f, 255.0f)]
    private float min;
    [SerializeField] [Range(0.0f, 255.0f)]
    private float max;

    //Hidden
    private Material material;
    Material Material
    {
        get
        {
            if (material != null)
                return material;

            else
            {
                material = new Material(shader);
                material.hideFlags = HideFlags.HideAndDontSave;
            }

            return material;
        }
    }

	#endregion

	#region Unity Functions

	private void Start()
	{
        if (!SystemInfo.supportsImageEffects)
        {
            enabled = false;
            Debug.LogWarning("Not Supported!");
            return;
        }

        if (!shader || !shader.isSupported)
        {
            enabled = false;
            Debug.LogWarning("Not Supported!");
        }
	}

    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        Material.SetFloat("_Min", min);
        Material.SetFloat("_Max", max);

        Graphics.Blit(source, destination, Material);
    }

    private void OnDisable()
    {
        if (material)
            DestroyImmediate(material);
    }

    #endregion
}
