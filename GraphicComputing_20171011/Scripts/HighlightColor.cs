using UnityEngine;

[ExecuteInEditMode]
public class HighlightColor : MonoBehaviour {

    #region Properties

    [SerializeField]
    private Shader shader;

    [Space(10f)]

    [SerializeField]
    private Color highlightColor;
    [SerializeField] [Range(1.5f, 2.0f)]
    private float colorCorrection;

    //Hidden
    private Material material;
    private Material Material
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

    private Color lastHighlightColor;
    private float lastColorCorrection;

    #endregion

    #region Unity Functions

    private void Start()
	{
        if (!SystemInfo.supportsImageEffects)
        {
            enabled = false;
            Debug.Log("Not supported!");
            return;
        }

        if (!shader || !shader.isSupported)
        {
            enabled = false;
            Debug.Log("Not supported!");
            return;
        }
    }

    private void OnDisable()
    {
        if (material)
            DestroyImmediate(material);
    }

    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        if (lastHighlightColor != highlightColor)
            Material.SetColor("_HighlightColor", highlightColor);
        if (lastColorCorrection != colorCorrection)
            Material.SetFloat("_ColorCorrection", colorCorrection);

        Graphics.Blit(source, destination, Material);

        lastHighlightColor = highlightColor;
        lastColorCorrection = colorCorrection;
    }

    #endregion
}
