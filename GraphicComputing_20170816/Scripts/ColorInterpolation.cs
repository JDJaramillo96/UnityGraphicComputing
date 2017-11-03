using UnityEngine;

[ExecuteInEditMode]
public class ColorInterpolation : MonoBehaviour {

    #region Properties

    private float colorFactor;
    [SerializeField]
    private float maxSize;

    //Cached Components
    private new Renderer renderer;
    private new Transform transform;
    private Vector3 localScale;
    private Vector3 lastLocalScale;

    #endregion

    #region Unity Functions

    private void Start()
    {
        renderer = GetComponent<Renderer>();
        transform = GetComponent<Transform>();
    }

    private void Update()
    {
        localScale = transform.localScale;

        colorFactor = transform.localScale.x / maxSize;

        if (lastLocalScale != localScale)
            renderer.material.SetFloat("_Factor", colorFactor);

        lastLocalScale = localScale;
    }

    #endregion
}
