using UnityEngine;

[ExecuteInEditMode]
public class Temperature : MonoBehaviour {

    #region Properties

    [SerializeField]
    private Shader shader;

    [Space(10f)]

    [SerializeField]
    private Color temperatureColor;

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

    private Color lastTemperatureColor;

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
        if(lastTemperatureColor != temperatureColor)
            Material.SetColor("_TemperatureColor", temperatureColor);

        Graphics.Blit(source, destination, Material);

        lastTemperatureColor = temperatureColor;
    }

    #endregion
}
