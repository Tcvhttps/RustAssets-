using System;
using UnityEngine;

public struct OBB
{
	public OBB(Transform transform, Bounds bounds) : this()
	{
	}

	public Quaternion rotation;
	public Vector3 position;
	public Vector3 extents;
	public Vector3 forward;
	public Vector3 right;
	public Vector3 up;
	public float reject;
}
