using UnityEngine;

[ExecuteInEditMode]
public class ImageEffectMaskTexture : MonoBehaviour {

    #region Properties

    public Shader shader;
    public float texelSize = 1f;

    [Space(10f)]

    [SerializeField]
    private Texture mask;
    [SerializeField]
    private Texture texture;

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

    private void Awake()
    {
        if (!SystemInfo.supportsImageEffects)
            enabled = false;

        if(!shader || !shader.isSupported)
            enabled = false;
    }

    private void Start()
    {
        Material.SetTexture("_Mask", mask);
        Material.SetTexture("_Texture", texture);
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
