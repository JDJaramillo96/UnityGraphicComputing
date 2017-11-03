using UnityEngine;

[ExecuteInEditMode]
public class DistanceColorModifier : MonoBehaviour {

    #region Properties

    [SerializeField]
    private GameObject terrain;

    // Cached Components
    private Material terrainMaterial;

    #endregion

    #region Unity Functions

    private void Start()
    {
        terrainMaterial = terrain.GetComponent<Terrain>().materialTemplate;
    }

    private void Update()
    {
        terrainMaterial.SetVector("_Position", transform.position);
    }

    #endregion
}
