using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SphericalDisintegration : MonoBehaviour
{
    Material mat;

    void Start()
    {
        mat = GetComponent<Renderer>().material;
        mat.SetVectorArray("_Orbs", new Vector4[] { GetComponent<Transform>().position});
        mat.SetInt("_OrbsLength", 1);
    }
    
    void Update()
    {
        mat.SetFloat("_Expansion", Time.time / 2f);
    }
}
