using UnityEngine;

[ExecuteInEditMode]
public class DilatationByPosition : MonoBehaviour {

    #region Properties

    [SerializeField]
    private Renderer[] arissaRenderers;
    [SerializeField]
    private Transform referenceObject;

    //Cached Componets
    private float distance;
    private float lastDistance;

    #endregion

    #region Unity Functions

    private void Update()
    {
        distance = Vector3.Distance(referenceObject.position, transform.position);

        if (lastDistance != distance)
        {
            foreach (Renderer renderer in arissaRenderers)
            {
                renderer.material.SetFloat("_Distance", distance);
            }
        }

        lastDistance = distance;
    }

    #endregion
}
