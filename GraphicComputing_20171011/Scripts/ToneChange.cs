using UnityEngine;

[ExecuteInEditMode]
public class ToneChange : MonoBehaviour {

    #region Properties

    [SerializeField]
    private Shader shader;

    [Space(10f)]

    [SerializeField] [Range(-1.0f, 1.0f)]
    private float toneAdd;

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

    private float lastToneAdd;

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
        if (lastToneAdd != toneAdd)
            Material.SetFloat("_ToneAdd", toneAdd);

        Graphics.Blit(source, destination, Material);

        lastToneAdd = toneAdd;
    }

    #endregion
}
