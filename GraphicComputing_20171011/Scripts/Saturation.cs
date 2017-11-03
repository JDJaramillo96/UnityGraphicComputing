using UnityEngine;

[ExecuteInEditMode]
public class Saturation : MonoBehaviour {

    #region Properties

    [SerializeField]
    private Shader shader;

    [Space(10f)]

    [SerializeField] [Range(0.0f, 2.0f)]
    private float saturationFactor;

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

    private float lastSaturationFactor;

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
        if (lastSaturationFactor != saturationFactor)
            Material.SetFloat("_SaturationFactor", saturationFactor);

        Graphics.Blit(source, destination, Material);

        lastSaturationFactor = saturationFactor;
    }

    #endregion
}
