using UnityEngine;

[ExecuteInEditMode]
public class ImageEffect : MonoBehaviour {

    #region Properties

    public Shader shader;
    public float texelSize = 1f;

    //Hidden
    private float lastTexelSize;

    private Material material;
    private Material Material
    {
        get
        {
            if (material != null)
            {
                return material;
            }
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
        }

        if(!shader || !shader.isSupported)
        {
            enabled = false;
        }
    }

    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        if (lastTexelSize != texelSize)
            Material.SetFloat("_TexelSize", texelSize);

        Graphics.Blit(source, destination, Material);

        lastTexelSize = texelSize;
    }

    private void OnDisable()
    {
        if (material != null)
            DestroyImmediate(material);
    }

    #endregion
}
