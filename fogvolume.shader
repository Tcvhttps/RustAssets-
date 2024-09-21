Shader "Hidden/FogVolume" {
	Properties {
	}
	SubShader {
		Pass {
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ZTest Always
			ZWrite Off
			Cull Front
			Fog {
				Mode Off
			}
			GpuProgramID 57445
			Program "vp" {
				SubProgram "d3d11 " {
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerCamera {
						vec4 unused_0_0[5];
						vec4 _ProjectionParams;
						vec4 unused_0_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_1_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					out vec4 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat0;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD0.zw = u_xlat0.zw;
					    vs_TEXCOORD0.xy = u_xlat1.zz + u_xlat1.xw;
					    return;
					}"
				}
			}
			Program "fp" {
				SubProgram "d3d11 " {
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _HeightParams;
						vec4 _DistanceParams;
						ivec4 _SceneFogMode;
						vec4 _SceneFogParams;
						vec4 _SceneFogColor;
						vec4 _CameraWS;
						vec4 _VolumeWorldToLocal[3];
						vec4 unused_0_8[2];
						float _VolumeAttenuationDecay;
						mat4x4 _FrustumCornersWS;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[7];
						vec4 _ZBufferParams;
						vec4 unused_1_2;
					};
					uniform  sampler2D _PostOpaqueCameraDepthTexture;
					in  vec4 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec2 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					bvec3 u_xlatb6;
					bool u_xlatb9;
					float u_xlat12;
					float u_xlat13;
					bool u_xlatb13;
					float u_xlat18;
					float u_xlat19;
					bool u_xlatb19;
					float u_xlat20;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
					    u_xlat1.x = _FrustumCornersWS[0].x;
					    u_xlat1.y = _FrustumCornersWS[1].x;
					    u_xlat1.z = _FrustumCornersWS[2].x;
					    u_xlat2.x = (-u_xlat1.x) + _FrustumCornersWS[0].y;
					    u_xlat2.y = (-u_xlat1.y) + _FrustumCornersWS[1].y;
					    u_xlat2.z = (-u_xlat1.z) + _FrustumCornersWS[2].y;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.x = _FrustumCornersWS[0].w;
					    u_xlat2.y = _FrustumCornersWS[1].w;
					    u_xlat2.z = _FrustumCornersWS[2].w;
					    u_xlat3.x = (-u_xlat2.x) + _FrustumCornersWS[0].z;
					    u_xlat3.y = (-u_xlat2.y) + _FrustumCornersWS[1].z;
					    u_xlat3.z = (-u_xlat2.z) + _FrustumCornersWS[2].z;
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat2.xyz);
					    u_xlat1.xyz = u_xlat0.yyy * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = _CameraWS.xyz;
					    u_xlat2.w = 1.0;
					    u_xlat3.x = dot(_VolumeWorldToLocal[0], u_xlat2);
					    u_xlat3.y = dot(_VolumeWorldToLocal[1], u_xlat2);
					    u_xlat3.z = dot(_VolumeWorldToLocal[2], u_xlat2);
					    u_xlat12 = dot(_VolumeWorldToLocal[0].xyz, u_xlat1.xyz);
					    u_xlat18 = dot(_VolumeWorldToLocal[1].xyz, u_xlat1.xyz);
					    u_xlat19 = dot(_VolumeWorldToLocal[2].xyz, u_xlat1.xyz);
					    u_xlat2.x = float(1.0) / u_xlat12;
					    u_xlat2.y = float(1.0) / u_xlat18;
					    u_xlat2.z = float(1.0) / u_xlat19;
					    u_xlat4.xyz = (-u_xlat3.xyz) + vec3(0.5, 0.5, 0.5);
					    u_xlat4.xyz = u_xlat2.xyz * u_xlat4.xyz;
					    u_xlat5.xyz = (-u_xlat3.xyz) + vec3(-0.5, -0.5, -0.5);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat5.xyz;
					    u_xlat5.xyz = max(u_xlat4.xyz, u_xlat2.xyz);
					    u_xlat2.xyz = min(u_xlat4.xyz, u_xlat2.xyz);
					    u_xlat12 = min(u_xlat5.y, u_xlat5.x);
					    u_xlat12 = min(u_xlat5.z, u_xlat12);
					    u_xlat18 = max(u_xlat2.y, u_xlat2.x);
					    u_xlat18 = max(u_xlat2.z, u_xlat18);
					    u_xlat19 = max(u_xlat18, 0.0);
					    u_xlatb19 = u_xlat19<u_xlat12;
					    if(u_xlatb19){
					        u_xlat2 = texture(_PostOpaqueCameraDepthTexture, u_xlat0.xy);
					        u_xlat0.x = _ZBufferParams.x * u_xlat2.x + _ZBufferParams.y;
					        u_xlat0.x = float(1.0) / u_xlat0.x;
					        u_xlat6.x = min(u_xlat18, u_xlat0.x);
					        u_xlat6.x = max(u_xlat6.x, 0.0);
					        u_xlat0.x = min(u_xlat12, u_xlat0.x);
					        u_xlat2.xyz = u_xlat0.xxx * u_xlat1.xyz;
					        u_xlat6.xyz = u_xlat1.xyz * u_xlat6.xxx + _CameraWS.xyz;
					        u_xlat4.xyz = u_xlat1.xyz * u_xlat0.xxx + _CameraWS.xyz;
					        u_xlat6.xyz = (-u_xlat6.xyz) + u_xlat4.xyz;
					        u_xlat4.w = 1.0;
					        u_xlat5.x = dot(_VolumeWorldToLocal[0], u_xlat4);
					        u_xlat5.y = dot(_VolumeWorldToLocal[1], u_xlat4);
					        u_xlat5.z = dot(_VolumeWorldToLocal[2], u_xlat4);
					        u_xlat1.xzw = (-u_xlat3.xyz) + u_xlat5.xyz;
					        u_xlat20 = dot((-u_xlat3.xyz), u_xlat1.xzw);
					        u_xlat3.x = dot((-u_xlat3.xyz), (-u_xlat3.xyz));
					        u_xlatb9 = 0.0<u_xlat20;
					        u_xlat1.x = dot(u_xlat1.xzw, u_xlat1.xzw);
					        u_xlatb13 = u_xlat20>=u_xlat1.x;
					        u_xlat19 = dot((-u_xlat5.xyz), (-u_xlat5.xyz));
					        u_xlat20 = u_xlat20 * u_xlat20;
					        u_xlat1.x = u_xlat20 / u_xlat1.x;
					        u_xlat1.x = (-u_xlat1.x) + u_xlat3.x;
					        u_xlat1.x = (u_xlatb13) ? u_xlat19 : u_xlat1.x;
					        u_xlat1.x = (u_xlatb9) ? u_xlat1.x : u_xlat3.x;
					        u_xlat1.x = u_xlat1.x * _VolumeAttenuationDecay;
					        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					        u_xlat13 = u_xlat1.x * -2.0 + 3.0;
					        u_xlat1.x = u_xlat1.x * u_xlat1.x;
					        u_xlat1.x = (-u_xlat13) * u_xlat1.x + 1.0;
					        u_xlat6.x = dot(u_xlat6.xyz, u_xlat6.xyz);
					        u_xlat6.x = sqrt(u_xlat6.x);
					        u_xlat6.x = u_xlat6.x + _DistanceParams.x;
					        u_xlat2.xyz = u_xlat2.xyz * _HeightParams.www;
					        u_xlat12 = u_xlat4.y + (-_HeightParams.x);
					        u_xlat18 = u_xlat12 + _HeightParams.y;
					        u_xlat13 = (-_HeightParams.z) * 2.0 + 1.0;
					        u_xlat12 = u_xlat12 * u_xlat13;
					        u_xlat12 = min(u_xlat12, 0.0);
					        u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					        u_xlat13 = sqrt(u_xlat13);
					        u_xlat12 = u_xlat12 * u_xlat12;
					        u_xlat0.x = u_xlat1.y * u_xlat0.x + 9.99999975e-06;
					        u_xlat0.x = u_xlat12 / abs(u_xlat0.x);
					        u_xlat0.x = _HeightParams.z * u_xlat18 + (-u_xlat0.x);
					        u_xlat0.x = (-u_xlat13) * u_xlat0.x + u_xlat6.x;
					        u_xlat0.x = u_xlat1.x * u_xlat0.x;
					        u_xlat0.x = max(u_xlat0.x, 0.0);
					        u_xlatb6.xyz = equal(_SceneFogMode.xxxx, ivec4(1, 2, 3, 3)).xyz;
					        u_xlat1.xy = u_xlat0.xx * _SceneFogParams.yx;
					        u_xlat0.x = u_xlat0.x * _SceneFogParams.z + _SceneFogParams.w;
					        u_xlat0.x = u_xlatb6.x ? u_xlat0.x : float(0.0);
					        u_xlat6.x = exp2((-u_xlat1.x));
					        u_xlat0.x = (u_xlatb6.y) ? u_xlat6.x : u_xlat0.x;
					        u_xlat6.x = u_xlat1.y * (-u_xlat1.y);
					        u_xlat6.x = exp2(u_xlat6.x);
					        u_xlat0.x = (u_xlatb6.z) ? u_xlat6.x : u_xlat0.x;
					        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					        SV_Target0.w = (-u_xlat0.x) + 1.0;
					        SV_Target0.xyz = _SceneFogColor.xyz;
					    } else {
					        SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
					    }
					    return;
					}"
				}
			}
		}
		Pass {
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ZTest Always
			ZWrite Off
			Cull Front
			Fog {
				Mode Off
			}
			GpuProgramID 82949
			Program "vp" {
				SubProgram "d3d11 " {
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerCamera {
						vec4 unused_0_0[5];
						vec4 _ProjectionParams;
						vec4 unused_0_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_1_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					out vec4 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat0;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD0.zw = u_xlat0.zw;
					    vs_TEXCOORD0.xy = u_xlat1.zz + u_xlat1.xw;
					    return;
					}"
				}
			}
			Program "fp" {
				SubProgram "d3d11 " {
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[3];
						vec4 _DistanceParams;
						ivec4 _SceneFogMode;
						vec4 _SceneFogParams;
						vec4 _SceneFogColor;
						vec4 _CameraWS;
						vec4 _VolumeWorldToLocal[3];
						vec4 unused_0_7[2];
						float _VolumeAttenuationDecay;
						mat4x4 _FrustumCornersWS;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[7];
						vec4 _ZBufferParams;
						vec4 unused_1_2;
					};
					uniform  sampler2D _PostOpaqueCameraDepthTexture;
					in  vec4 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					bvec3 u_xlatb6;
					bool u_xlatb7;
					float u_xlat12;
					float u_xlat13;
					float u_xlat18;
					float u_xlat19;
					bool u_xlatb19;
					bool u_xlatb20;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
					    u_xlat1.x = _FrustumCornersWS[0].x;
					    u_xlat1.y = _FrustumCornersWS[1].x;
					    u_xlat1.z = _FrustumCornersWS[2].x;
					    u_xlat2.x = (-u_xlat1.x) + _FrustumCornersWS[0].y;
					    u_xlat2.y = (-u_xlat1.y) + _FrustumCornersWS[1].y;
					    u_xlat2.z = (-u_xlat1.z) + _FrustumCornersWS[2].y;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.x = _FrustumCornersWS[0].w;
					    u_xlat2.y = _FrustumCornersWS[1].w;
					    u_xlat2.z = _FrustumCornersWS[2].w;
					    u_xlat3.x = (-u_xlat2.x) + _FrustumCornersWS[0].z;
					    u_xlat3.y = (-u_xlat2.y) + _FrustumCornersWS[1].z;
					    u_xlat3.z = (-u_xlat2.z) + _FrustumCornersWS[2].z;
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat2.xyz);
					    u_xlat1.xyz = u_xlat0.yyy * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = _CameraWS.xyz;
					    u_xlat2.w = 1.0;
					    u_xlat3.x = dot(_VolumeWorldToLocal[0], u_xlat2);
					    u_xlat3.y = dot(_VolumeWorldToLocal[1], u_xlat2);
					    u_xlat3.z = dot(_VolumeWorldToLocal[2], u_xlat2);
					    u_xlat12 = dot(_VolumeWorldToLocal[0].xyz, u_xlat1.xyz);
					    u_xlat18 = dot(_VolumeWorldToLocal[1].xyz, u_xlat1.xyz);
					    u_xlat19 = dot(_VolumeWorldToLocal[2].xyz, u_xlat1.xyz);
					    u_xlat2.x = float(1.0) / u_xlat12;
					    u_xlat2.y = float(1.0) / u_xlat18;
					    u_xlat2.z = float(1.0) / u_xlat19;
					    u_xlat4.xyz = (-u_xlat3.xyz) + vec3(0.5, 0.5, 0.5);
					    u_xlat4.xyz = u_xlat2.xyz * u_xlat4.xyz;
					    u_xlat5.xyz = (-u_xlat3.xyz) + vec3(-0.5, -0.5, -0.5);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat5.xyz;
					    u_xlat5.xyz = max(u_xlat4.xyz, u_xlat2.xyz);
					    u_xlat2.xyz = min(u_xlat4.xyz, u_xlat2.xyz);
					    u_xlat12 = min(u_xlat5.y, u_xlat5.x);
					    u_xlat12 = min(u_xlat5.z, u_xlat12);
					    u_xlat18 = max(u_xlat2.y, u_xlat2.x);
					    u_xlat18 = max(u_xlat2.z, u_xlat18);
					    u_xlat19 = max(u_xlat18, 0.0);
					    u_xlatb19 = u_xlat19<u_xlat12;
					    if(u_xlatb19){
					        u_xlat2 = texture(_PostOpaqueCameraDepthTexture, u_xlat0.xy);
					        u_xlat0.x = _ZBufferParams.x * u_xlat2.x + _ZBufferParams.y;
					        u_xlat0.x = float(1.0) / u_xlat0.x;
					        u_xlat6.x = min(u_xlat18, u_xlat0.x);
					        u_xlat6.x = max(u_xlat6.x, 0.0);
					        u_xlat0.x = min(u_xlat12, u_xlat0.x);
					        u_xlat6.xyz = u_xlat1.xyz * u_xlat6.xxx + _CameraWS.xyz;
					        u_xlat1.xyz = u_xlat1.xyz * u_xlat0.xxx + _CameraWS.xyz;
					        u_xlat0.xyz = (-u_xlat6.xyz) + u_xlat1.xyz;
					        u_xlat1.w = 1.0;
					        u_xlat2.x = dot(_VolumeWorldToLocal[0], u_xlat1);
					        u_xlat2.y = dot(_VolumeWorldToLocal[1], u_xlat1);
					        u_xlat2.z = dot(_VolumeWorldToLocal[2], u_xlat1);
					        u_xlat1.xyz = (-u_xlat3.xyz) + u_xlat2.xyz;
					        u_xlat18 = dot((-u_xlat3.xyz), u_xlat1.xyz);
					        u_xlat19 = dot((-u_xlat3.xyz), (-u_xlat3.xyz));
					        u_xlatb20 = 0.0<u_xlat18;
					        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					        u_xlatb7 = u_xlat18>=u_xlat1.x;
					        u_xlat13 = dot((-u_xlat2.xyz), (-u_xlat2.xyz));
					        u_xlat18 = u_xlat18 * u_xlat18;
					        u_xlat18 = u_xlat18 / u_xlat1.x;
					        u_xlat18 = (-u_xlat18) + u_xlat19;
					        u_xlat18 = (u_xlatb7) ? u_xlat13 : u_xlat18;
					        u_xlat18 = (u_xlatb20) ? u_xlat18 : u_xlat19;
					        u_xlat18 = u_xlat18 * _VolumeAttenuationDecay;
					        u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					        u_xlat1.x = u_xlat18 * -2.0 + 3.0;
					        u_xlat18 = u_xlat18 * u_xlat18;
					        u_xlat18 = (-u_xlat1.x) * u_xlat18 + 1.0;
					        u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					        u_xlat0.x = sqrt(u_xlat0.x);
					        u_xlat0.x = u_xlat0.x + _DistanceParams.x;
					        u_xlat0.x = u_xlat18 * u_xlat0.x;
					        u_xlat0.x = max(u_xlat0.x, 0.0);
					        u_xlatb6.xyz = equal(_SceneFogMode.xxxx, ivec4(1, 2, 3, 3)).xyz;
					        u_xlat1.xy = u_xlat0.xx * _SceneFogParams.yx;
					        u_xlat0.x = u_xlat0.x * _SceneFogParams.z + _SceneFogParams.w;
					        u_xlat0.x = u_xlatb6.x ? u_xlat0.x : float(0.0);
					        u_xlat6.x = exp2((-u_xlat1.x));
					        u_xlat0.x = (u_xlatb6.y) ? u_xlat6.x : u_xlat0.x;
					        u_xlat6.x = u_xlat1.y * (-u_xlat1.y);
					        u_xlat6.x = exp2(u_xlat6.x);
					        u_xlat0.x = (u_xlatb6.z) ? u_xlat6.x : u_xlat0.x;
					        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					        SV_Target0.w = (-u_xlat0.x) + 1.0;
					        SV_Target0.xyz = _SceneFogColor.xyz;
					    } else {
					        SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
					    }
					    return;
					}"
				}
			}
		}
		Pass {
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ZTest Always
			ZWrite Off
			Cull Front
			Fog {
				Mode Off
			}
			GpuProgramID 178925
			Program "vp" {
				SubProgram "d3d11 " {
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerCamera {
						vec4 unused_0_0[5];
						vec4 _ProjectionParams;
						vec4 unused_0_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_1_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					out vec4 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat0;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD0.zw = u_xlat0.zw;
					    vs_TEXCOORD0.xy = u_xlat1.zz + u_xlat1.xw;
					    return;
					}"
				}
			}
			Program "fp" {
				SubProgram "d3d11 " {
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _HeightParams;
						vec4 _DistanceParams;
						ivec4 _SceneFogMode;
						vec4 _SceneFogParams;
						vec4 _SceneFogColor;
						vec4 _CameraWS;
						vec4 _VolumeWorldToLocal[3];
						vec4 unused_0_8[2];
						float _VolumeAttenuationDecay;
						mat4x4 _FrustumCornersWS;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[7];
						vec4 _ZBufferParams;
						vec4 unused_1_2;
					};
					uniform  sampler2D _PostOpaqueCameraDepthTexture;
					in  vec4 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec2 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					bvec3 u_xlatb6;
					float u_xlat12;
					float u_xlat13;
					bool u_xlatb13;
					float u_xlat14;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat19;
					bool u_xlatb20;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
					    u_xlat1.x = _FrustumCornersWS[0].x;
					    u_xlat1.y = _FrustumCornersWS[1].x;
					    u_xlat1.z = _FrustumCornersWS[2].x;
					    u_xlat2.x = (-u_xlat1.x) + _FrustumCornersWS[0].y;
					    u_xlat2.y = (-u_xlat1.y) + _FrustumCornersWS[1].y;
					    u_xlat2.z = (-u_xlat1.z) + _FrustumCornersWS[2].y;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.x = _FrustumCornersWS[0].w;
					    u_xlat2.y = _FrustumCornersWS[1].w;
					    u_xlat2.z = _FrustumCornersWS[2].w;
					    u_xlat3.x = (-u_xlat2.x) + _FrustumCornersWS[0].z;
					    u_xlat3.y = (-u_xlat2.y) + _FrustumCornersWS[1].z;
					    u_xlat3.z = (-u_xlat2.z) + _FrustumCornersWS[2].z;
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat2.xyz);
					    u_xlat1.xyz = u_xlat0.yyy * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = _CameraWS.xyz;
					    u_xlat2.w = 1.0;
					    u_xlat3.x = dot(_VolumeWorldToLocal[0], u_xlat2);
					    u_xlat3.y = dot(_VolumeWorldToLocal[1], u_xlat2);
					    u_xlat3.z = dot(_VolumeWorldToLocal[2], u_xlat2);
					    u_xlat12 = dot(_VolumeWorldToLocal[0].xyz, u_xlat1.xyz);
					    u_xlat18 = dot(_VolumeWorldToLocal[1].xyz, u_xlat1.xyz);
					    u_xlat19 = dot(_VolumeWorldToLocal[2].xyz, u_xlat1.xyz);
					    u_xlat2.x = float(1.0) / u_xlat12;
					    u_xlat2.y = float(1.0) / u_xlat18;
					    u_xlat2.z = float(1.0) / u_xlat19;
					    u_xlat4.xyz = (-u_xlat3.xyz) + vec3(0.5, 0.5, 0.5);
					    u_xlat4.xyz = u_xlat2.xyz * u_xlat4.xyz;
					    u_xlat5.xyz = (-u_xlat3.xyz) + vec3(-0.5, -0.5, -0.5);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat5.xyz;
					    u_xlat5.xyz = max(u_xlat4.xyz, u_xlat2.xyz);
					    u_xlat2.xyz = min(u_xlat4.xyz, u_xlat2.xyz);
					    u_xlat12 = min(u_xlat5.y, u_xlat5.x);
					    u_xlat12 = min(u_xlat5.z, u_xlat12);
					    u_xlat18 = max(u_xlat2.y, u_xlat2.x);
					    u_xlat18 = max(u_xlat2.z, u_xlat18);
					    u_xlat18 = max(u_xlat18, 0.0);
					    u_xlatb18 = u_xlat18<u_xlat12;
					    if(u_xlatb18){
					        u_xlat2 = texture(_PostOpaqueCameraDepthTexture, u_xlat0.xy);
					        u_xlat0.x = _ZBufferParams.x * u_xlat2.x + _ZBufferParams.y;
					        u_xlat0.x = float(1.0) / u_xlat0.x;
					        u_xlat0.x = min(u_xlat12, u_xlat0.x);
					        u_xlat6.xyz = u_xlat0.xxx * u_xlat1.xyz;
					        u_xlat2.xyz = u_xlat1.xyz * u_xlat0.xxx + _CameraWS.xyz;
					        u_xlat2.w = 1.0;
					        u_xlat4.x = dot(_VolumeWorldToLocal[0], u_xlat2);
					        u_xlat4.y = dot(_VolumeWorldToLocal[1], u_xlat2);
					        u_xlat4.z = dot(_VolumeWorldToLocal[2], u_xlat2);
					        u_xlat1.xzw = (-u_xlat3.xyz) + u_xlat4.xyz;
					        u_xlat2.x = dot((-u_xlat3.xyz), u_xlat1.xzw);
					        u_xlat14 = dot((-u_xlat3.xyz), (-u_xlat3.xyz));
					        u_xlatb20 = 0.0<u_xlat2.x;
					        u_xlat1.x = dot(u_xlat1.xzw, u_xlat1.xzw);
					        u_xlatb13 = u_xlat2.x>=u_xlat1.x;
					        u_xlat19 = dot((-u_xlat4.xyz), (-u_xlat4.xyz));
					        u_xlat2.x = u_xlat2.x * u_xlat2.x;
					        u_xlat1.x = u_xlat2.x / u_xlat1.x;
					        u_xlat1.x = (-u_xlat1.x) + u_xlat14;
					        u_xlat1.x = (u_xlatb13) ? u_xlat19 : u_xlat1.x;
					        u_xlat1.x = (u_xlatb20) ? u_xlat1.x : u_xlat14;
					        u_xlat1.x = u_xlat1.x * _VolumeAttenuationDecay;
					        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					        u_xlat13 = u_xlat1.x * -2.0 + 3.0;
					        u_xlat1.x = u_xlat1.x * u_xlat1.x;
					        u_xlat1.x = (-u_xlat13) * u_xlat1.x + 1.0;
					        u_xlat6.xyz = u_xlat6.xyz * _HeightParams.www;
					        u_xlat13 = u_xlat2.y + (-_HeightParams.x);
					        u_xlat19 = u_xlat13 + _HeightParams.y;
					        u_xlat2.x = (-_HeightParams.z) * 2.0 + 1.0;
					        u_xlat13 = u_xlat13 * u_xlat2.x;
					        u_xlat13 = min(u_xlat13, 0.0);
					        u_xlat6.x = dot(u_xlat6.xyz, u_xlat6.xyz);
					        u_xlat6.x = sqrt(u_xlat6.x);
					        u_xlat12 = u_xlat13 * u_xlat13;
					        u_xlat0.x = u_xlat1.y * u_xlat0.x + 9.99999975e-06;
					        u_xlat0.x = u_xlat12 / abs(u_xlat0.x);
					        u_xlat0.x = _HeightParams.z * u_xlat19 + (-u_xlat0.x);
					        u_xlat0.x = (-u_xlat6.x) * u_xlat0.x + _DistanceParams.x;
					        u_xlat0.x = u_xlat1.x * u_xlat0.x;
					        u_xlat0.x = max(u_xlat0.x, 0.0);
					        u_xlatb6.xyz = equal(_SceneFogMode.xxxx, ivec4(1, 2, 3, 3)).xyz;
					        u_xlat1.xy = u_xlat0.xx * _SceneFogParams.yx;
					        u_xlat0.x = u_xlat0.x * _SceneFogParams.z + _SceneFogParams.w;
					        u_xlat0.x = u_xlatb6.x ? u_xlat0.x : float(0.0);
					        u_xlat6.x = exp2((-u_xlat1.x));
					        u_xlat0.x = (u_xlatb6.y) ? u_xlat6.x : u_xlat0.x;
					        u_xlat6.x = u_xlat1.y * (-u_xlat1.y);
					        u_xlat6.x = exp2(u_xlat6.x);
					        u_xlat0.x = (u_xlatb6.z) ? u_xlat6.x : u_xlat0.x;
					        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					        SV_Target0.w = (-u_xlat0.x) + 1.0;
					        SV_Target0.xyz = _SceneFogColor.xyz;
					    } else {
					        SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
					    }
					    return;
					}"
				}
			}
		}
	}
}