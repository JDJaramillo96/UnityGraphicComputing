using UnityEngine;

public class NomalStrengthModifier : MonoBehaviour {

    #region Properties

    [SerializeField]
    private GameObject trackedObject;
    [SerializeField]
    private Renderer[] trackedRenderers = new Renderer[4];

    [Space(10f)]

    [SerializeField]
    private float nearDistance = 1f;
    [SerializeField]
    private float farDistance = 5f;

    [Header("Strength")]
    [Space(10f)]

    [SerializeField]
    private float minimusStrength = 0.1f;
    [SerializeField]
    private float maximusStrength = 2f;

    //Cached Component
    private Vector3 trackedPosition;
    private Vector3 cameraPosition;
    private Vector3 resultedVector;
    private float distance;
    private float strengthValue;

    #endregion

    #region Unity functions

    private void Update()
    {
        trackedPosition = trackedObject.transform.position;
        cameraPosition = transform.position;

        resultedVector = trackedPosition - cameraPosition;
        distance = resultedVector.magnitude;

        if (distance <= farDistance && distance >= nearDistance)
        {
            Debug.Log("D:");

            strengthValue = (distance * maximusStrength) / (farDistance-1);

            foreach (Renderer trackedRenderer in trackedRenderers)
            {
                trackedRenderer.material.SetFloat("_NormalStrength", strengthValue);
            }
        }
    }

    #endregion
}
