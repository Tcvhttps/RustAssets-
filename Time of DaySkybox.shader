Shader "Time of Day/Skybox" {
	Properties {
	}
	SubShader {
		Tags { "PreviewType" = "Skybox" "QUEUE" = "Background" "RenderType" = "Background" }
		Pass {
			Tags { "PreviewType" = "Skybox" "QUEUE" = "Background" "RenderType" = "Background" }
			ZWrite Off
			Cull Off
			GpuProgramID 24849
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						mat4x4 TOD_World2Sky;
						vec4 unused_0_2[6];
						vec3 TOD_SunSkyColor;
						vec3 TOD_MoonSkyColor;
						vec4 unused_0_5[4];
						vec3 TOD_FogColor;
						vec3 TOD_GroundColor;
						vec4 unused_0_8[4];
						vec3 TOD_LocalSunDirection;
						vec4 unused_0_10;
						float TOD_Contrast;
						float TOD_Brightness;
						float TOD_Fogginess;
						vec4 unused_0_14[11];
						vec4 TOD_kSun;
						vec4 TOD_k4PI;
						vec4 TOD_kRadius;
						vec4 TOD_kScale;
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
					out vec3 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec4 u_xlat7;
					float u_xlat8;
					vec3 u_xlat9;
					vec3 u_xlat10;
					vec3 u_xlat13;
					float u_xlat16;
					float u_xlat18;
					float u_xlat25;
					float u_xlat27;
					float u_xlat29;
					float u_xlat30;
					int u_xlati32;
					float u_xlat33;
					bool u_xlatb33;
					float u_xlat34;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat1.xyz = u_xlat0.yyy * TOD_World2Sky[1].xyz;
					    u_xlat0.xyw = TOD_World2Sky[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = TOD_World2Sky[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.yxz;
					    u_xlatb1 = u_xlat0.x<0.0;
					    u_xlat10.xyz = log2(TOD_GroundColor.xyz);
					    u_xlat10.xyz = u_xlat10.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat10.xyz = exp2(u_xlat10.xyz);
					    u_xlat0.w = max(u_xlat0.x, 0.0);
					    u_xlat2.x = dot(u_xlat0.yzw, u_xlat0.yzw);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat2.xyz = u_xlat0.ywz * u_xlat2.xxx;
					    u_xlat3.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat29 = u_xlat2.y * u_xlat2.y;
					    u_xlat29 = u_xlat29 * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat29 = u_xlat29 + (-TOD_kRadius.y);
					    u_xlat29 = sqrt(u_xlat29);
					    u_xlat29 = (-TOD_kRadius.x) * u_xlat2.y + u_xlat29;
					    u_xlat30 = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat30 = u_xlat30 * 1.44269502;
					    u_xlat30 = exp2(u_xlat30);
					    u_xlat4 = u_xlat2.y * u_xlat3.y;
					    u_xlat4 = u_xlat4 / u_xlat3.y;
					    u_xlat4 = (-u_xlat4) + 1.0;
					    u_xlat13.x = u_xlat4 * 5.25 + -6.80000019;
					    u_xlat13.x = u_xlat4 * u_xlat13.x + 3.82999992;
					    u_xlat13.x = u_xlat4 * u_xlat13.x + 0.458999991;
					    u_xlat4 = u_xlat4 * u_xlat13.x + -0.00286999997;
					    u_xlat4 = u_xlat4 * 1.44269502;
					    u_xlat4 = exp2(u_xlat4);
					    u_xlat30 = u_xlat30 * u_xlat4;
					    u_xlat29 = u_xlat29 * 0.5;
					    u_xlat4 = u_xlat29 * TOD_kScale.x;
					    u_xlat13.xyz = vec3(u_xlat29) * u_xlat2.xyz;
					    u_xlat3.x = float(0.0);
					    u_xlat3.z = float(0.0);
					    u_xlat3.xyz = u_xlat13.xyz * vec3(0.5, 0.5, 0.5) + u_xlat3.xyz;
					    u_xlat13.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat5.xyz = u_xlat3.xyz;
					    u_xlat6.x = float(0.0);
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
					    {
					        u_xlat33 = dot(u_xlat5.xyz, u_xlat5.xyz);
					        u_xlat33 = sqrt(u_xlat33);
					        u_xlat33 = max(u_xlat33, 1.0);
					        u_xlat7.x = float(1.0) / u_xlat33;
					        u_xlat33 = (-u_xlat33) + TOD_kRadius.x;
					        u_xlat33 = u_xlat33 * TOD_kScale.z;
					        u_xlat33 = u_xlat33 * 1.44269502;
					        u_xlat33 = exp2(u_xlat33);
					        u_xlat16 = u_xlat4 * u_xlat33;
					        u_xlat25 = dot(u_xlat2.xyz, u_xlat5.xyz);
					        u_xlat34 = dot(TOD_LocalSunDirection.xyz, u_xlat5.xyz);
					        u_xlat34 = (-u_xlat34) * u_xlat7.x + 1.0;
					        u_xlat8 = u_xlat34 * 5.25 + -6.80000019;
					        u_xlat8 = u_xlat34 * u_xlat8 + 3.82999992;
					        u_xlat8 = u_xlat34 * u_xlat8 + 0.458999991;
					        u_xlat34 = u_xlat34 * u_xlat8 + -0.00286999997;
					        u_xlat34 = u_xlat34 * 1.44269502;
					        u_xlat34 = exp2(u_xlat34);
					        u_xlat7.x = (-u_xlat25) * u_xlat7.x + 1.0;
					        u_xlat25 = u_xlat7.x * 5.25 + -6.80000019;
					        u_xlat25 = u_xlat7.x * u_xlat25 + 3.82999992;
					        u_xlat25 = u_xlat7.x * u_xlat25 + 0.458999991;
					        u_xlat7.x = u_xlat7.x * u_xlat25 + -0.00286999997;
					        u_xlat7.x = u_xlat7.x * 1.44269502;
					        u_xlat7.x = exp2(u_xlat7.x);
					        u_xlat7.x = u_xlat7.x * 0.25;
					        u_xlat7.x = u_xlat34 * 0.25 + (-u_xlat7.x);
					        u_xlat33 = u_xlat33 * u_xlat7.x;
					        u_xlat33 = u_xlat30 * 0.25 + u_xlat33;
					        u_xlat7.xzw = u_xlat13.xyz * (-vec3(u_xlat33));
					        u_xlat7.xzw = u_xlat7.xzw * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat7.xzw = exp2(u_xlat7.xzw);
					        u_xlat6.xyz = u_xlat7.xzw * vec3(u_xlat16) + u_xlat6.xyz;
					        u_xlat5.xyz = u_xlat2.xyz * vec3(u_xlat29) + u_xlat5.xyz;
					    }
					    u_xlat2.xyz = u_xlat6.xyz * TOD_SunSkyColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * TOD_kSun.xyz;
					    u_xlat9.x = dot(TOD_LocalSunDirection.yxz, u_xlat0.xyz);
					    u_xlat9.x = u_xlat9.x * u_xlat9.x;
					    u_xlat18 = (-u_xlat0.w) * 0.75 + 1.0;
					    u_xlat9.x = u_xlat9.x * 0.75 + 0.75;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat9.xxx;
					    u_xlat9.xyz = TOD_MoonSkyColor.xyz * vec3(u_xlat18) + u_xlat2.xyz;
					    u_xlat0.x = (-u_xlat0.x);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat2.xyz = (-u_xlat9.xyz) + TOD_GroundColor.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + u_xlat9.xyz;
					    u_xlat2.xyz = (-u_xlat0.xyz) + TOD_FogColor.xyz;
					    u_xlat0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(TOD_Brightness);
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = (bool(u_xlatb1)) ? u_xlat10.xyz : u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * (-vec3(TOD_Brightness));
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    vs_TEXCOORD0.xyz = sqrt(u_xlat0.xyz);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "TOD_OUTPUT_LINEAR" }
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						mat4x4 TOD_World2Sky;
						vec4 unused_0_2[6];
						vec3 TOD_SunSkyColor;
						vec3 TOD_MoonSkyColor;
						vec4 unused_0_5[4];
						vec3 TOD_FogColor;
						vec3 TOD_GroundColor;
						vec4 unused_0_8[4];
						vec3 TOD_LocalSunDirection;
						vec4 unused_0_10;
						float TOD_Contrast;
						float TOD_Brightness;
						float TOD_Fogginess;
						vec4 unused_0_14[11];
						vec4 TOD_kSun;
						vec4 TOD_k4PI;
						vec4 TOD_kRadius;
						vec4 TOD_kScale;
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
					out vec3 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec4 u_xlat7;
					float u_xlat8;
					vec3 u_xlat9;
					vec3 u_xlat10;
					vec3 u_xlat13;
					float u_xlat16;
					float u_xlat18;
					float u_xlat25;
					float u_xlat27;
					float u_xlat29;
					float u_xlat30;
					int u_xlati32;
					float u_xlat33;
					bool u_xlatb33;
					float u_xlat34;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat1.xyz = u_xlat0.yyy * TOD_World2Sky[1].xyz;
					    u_xlat0.xyw = TOD_World2Sky[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = TOD_World2Sky[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.yxz;
					    u_xlatb1 = u_xlat0.x<0.0;
					    u_xlat10.xyz = log2(TOD_GroundColor.xyz);
					    u_xlat10.xyz = u_xlat10.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat10.xyz = exp2(u_xlat10.xyz);
					    u_xlat0.w = max(u_xlat0.x, 0.0);
					    u_xlat2.x = dot(u_xlat0.yzw, u_xlat0.yzw);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat2.xyz = u_xlat0.ywz * u_xlat2.xxx;
					    u_xlat3.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat29 = u_xlat2.y * u_xlat2.y;
					    u_xlat29 = u_xlat29 * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat29 = u_xlat29 + (-TOD_kRadius.y);
					    u_xlat29 = sqrt(u_xlat29);
					    u_xlat29 = (-TOD_kRadius.x) * u_xlat2.y + u_xlat29;
					    u_xlat30 = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat30 = u_xlat30 * 1.44269502;
					    u_xlat30 = exp2(u_xlat30);
					    u_xlat4 = u_xlat2.y * u_xlat3.y;
					    u_xlat4 = u_xlat4 / u_xlat3.y;
					    u_xlat4 = (-u_xlat4) + 1.0;
					    u_xlat13.x = u_xlat4 * 5.25 + -6.80000019;
					    u_xlat13.x = u_xlat4 * u_xlat13.x + 3.82999992;
					    u_xlat13.x = u_xlat4 * u_xlat13.x + 0.458999991;
					    u_xlat4 = u_xlat4 * u_xlat13.x + -0.00286999997;
					    u_xlat4 = u_xlat4 * 1.44269502;
					    u_xlat4 = exp2(u_xlat4);
					    u_xlat30 = u_xlat30 * u_xlat4;
					    u_xlat29 = u_xlat29 * 0.5;
					    u_xlat4 = u_xlat29 * TOD_kScale.x;
					    u_xlat13.xyz = vec3(u_xlat29) * u_xlat2.xyz;
					    u_xlat3.x = float(0.0);
					    u_xlat3.z = float(0.0);
					    u_xlat3.xyz = u_xlat13.xyz * vec3(0.5, 0.5, 0.5) + u_xlat3.xyz;
					    u_xlat13.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat5.xyz = u_xlat3.xyz;
					    u_xlat6.x = float(0.0);
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
					    {
					        u_xlat33 = dot(u_xlat5.xyz, u_xlat5.xyz);
					        u_xlat33 = sqrt(u_xlat33);
					        u_xlat33 = max(u_xlat33, 1.0);
					        u_xlat7.x = float(1.0) / u_xlat33;
					        u_xlat33 = (-u_xlat33) + TOD_kRadius.x;
					        u_xlat33 = u_xlat33 * TOD_kScale.z;
					        u_xlat33 = u_xlat33 * 1.44269502;
					        u_xlat33 = exp2(u_xlat33);
					        u_xlat16 = u_xlat4 * u_xlat33;
					        u_xlat25 = dot(u_xlat2.xyz, u_xlat5.xyz);
					        u_xlat34 = dot(TOD_LocalSunDirection.xyz, u_xlat5.xyz);
					        u_xlat34 = (-u_xlat34) * u_xlat7.x + 1.0;
					        u_xlat8 = u_xlat34 * 5.25 + -6.80000019;
					        u_xlat8 = u_xlat34 * u_xlat8 + 3.82999992;
					        u_xlat8 = u_xlat34 * u_xlat8 + 0.458999991;
					        u_xlat34 = u_xlat34 * u_xlat8 + -0.00286999997;
					        u_xlat34 = u_xlat34 * 1.44269502;
					        u_xlat34 = exp2(u_xlat34);
					        u_xlat7.x = (-u_xlat25) * u_xlat7.x + 1.0;
					        u_xlat25 = u_xlat7.x * 5.25 + -6.80000019;
					        u_xlat25 = u_xlat7.x * u_xlat25 + 3.82999992;
					        u_xlat25 = u_xlat7.x * u_xlat25 + 0.458999991;
					        u_xlat7.x = u_xlat7.x * u_xlat25 + -0.00286999997;
					        u_xlat7.x = u_xlat7.x * 1.44269502;
					        u_xlat7.x = exp2(u_xlat7.x);
					        u_xlat7.x = u_xlat7.x * 0.25;
					        u_xlat7.x = u_xlat34 * 0.25 + (-u_xlat7.x);
					        u_xlat33 = u_xlat33 * u_xlat7.x;
					        u_xlat33 = u_xlat30 * 0.25 + u_xlat33;
					        u_xlat7.xzw = u_xlat13.xyz * (-vec3(u_xlat33));
					        u_xlat7.xzw = u_xlat7.xzw * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat7.xzw = exp2(u_xlat7.xzw);
					        u_xlat6.xyz = u_xlat7.xzw * vec3(u_xlat16) + u_xlat6.xyz;
					        u_xlat5.xyz = u_xlat2.xyz * vec3(u_xlat29) + u_xlat5.xyz;
					    }
					    u_xlat2.xyz = u_xlat6.xyz * TOD_SunSkyColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * TOD_kSun.xyz;
					    u_xlat9.x = dot(TOD_LocalSunDirection.yxz, u_xlat0.xyz);
					    u_xlat9.x = u_xlat9.x * u_xlat9.x;
					    u_xlat18 = (-u_xlat0.w) * 0.75 + 1.0;
					    u_xlat9.x = u_xlat9.x * 0.75 + 0.75;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat9.xxx;
					    u_xlat9.xyz = TOD_MoonSkyColor.xyz * vec3(u_xlat18) + u_xlat2.xyz;
					    u_xlat0.x = (-u_xlat0.x);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat2.xyz = (-u_xlat9.xyz) + TOD_GroundColor.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + u_xlat9.xyz;
					    u_xlat2.xyz = (-u_xlat0.xyz) + TOD_FogColor.xyz;
					    u_xlat0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(TOD_Brightness);
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = (bool(u_xlatb1)) ? u_xlat10.xyz : u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * (-vec3(TOD_Brightness));
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    vs_TEXCOORD0.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "TOD_OUTPUT_HDR" }
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						mat4x4 TOD_World2Sky;
						vec4 unused_0_2[6];
						vec3 TOD_SunSkyColor;
						vec3 TOD_MoonSkyColor;
						vec4 unused_0_5[4];
						vec3 TOD_FogColor;
						vec3 TOD_GroundColor;
						vec4 unused_0_8[4];
						vec3 TOD_LocalSunDirection;
						vec4 unused_0_10;
						float TOD_Contrast;
						float TOD_Brightness;
						float TOD_Fogginess;
						vec4 unused_0_14[11];
						vec4 TOD_kSun;
						vec4 TOD_k4PI;
						vec4 TOD_kRadius;
						vec4 TOD_kScale;
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
					out vec3 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec4 u_xlat7;
					float u_xlat8;
					vec3 u_xlat9;
					vec3 u_xlat10;
					vec3 u_xlat13;
					float u_xlat16;
					float u_xlat18;
					float u_xlat25;
					float u_xlat27;
					float u_xlat29;
					float u_xlat30;
					int u_xlati32;
					float u_xlat33;
					bool u_xlatb33;
					float u_xlat34;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat1.xyz = u_xlat0.yyy * TOD_World2Sky[1].xyz;
					    u_xlat0.xyw = TOD_World2Sky[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = TOD_World2Sky[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.yxz;
					    u_xlatb1 = u_xlat0.x<0.0;
					    u_xlat10.xyz = log2(TOD_GroundColor.xyz);
					    u_xlat10.xyz = u_xlat10.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat10.xyz = exp2(u_xlat10.xyz);
					    u_xlat0.w = max(u_xlat0.x, 0.0);
					    u_xlat2.x = dot(u_xlat0.yzw, u_xlat0.yzw);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat2.xyz = u_xlat0.ywz * u_xlat2.xxx;
					    u_xlat3.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat29 = u_xlat2.y * u_xlat2.y;
					    u_xlat29 = u_xlat29 * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat29 = u_xlat29 + (-TOD_kRadius.y);
					    u_xlat29 = sqrt(u_xlat29);
					    u_xlat29 = (-TOD_kRadius.x) * u_xlat2.y + u_xlat29;
					    u_xlat30 = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat30 = u_xlat30 * 1.44269502;
					    u_xlat30 = exp2(u_xlat30);
					    u_xlat4 = u_xlat2.y * u_xlat3.y;
					    u_xlat4 = u_xlat4 / u_xlat3.y;
					    u_xlat4 = (-u_xlat4) + 1.0;
					    u_xlat13.x = u_xlat4 * 5.25 + -6.80000019;
					    u_xlat13.x = u_xlat4 * u_xlat13.x + 3.82999992;
					    u_xlat13.x = u_xlat4 * u_xlat13.x + 0.458999991;
					    u_xlat4 = u_xlat4 * u_xlat13.x + -0.00286999997;
					    u_xlat4 = u_xlat4 * 1.44269502;
					    u_xlat4 = exp2(u_xlat4);
					    u_xlat30 = u_xlat30 * u_xlat4;
					    u_xlat29 = u_xlat29 * 0.5;
					    u_xlat4 = u_xlat29 * TOD_kScale.x;
					    u_xlat13.xyz = vec3(u_xlat29) * u_xlat2.xyz;
					    u_xlat3.x = float(0.0);
					    u_xlat3.z = float(0.0);
					    u_xlat3.xyz = u_xlat13.xyz * vec3(0.5, 0.5, 0.5) + u_xlat3.xyz;
					    u_xlat13.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat5.xyz = u_xlat3.xyz;
					    u_xlat6.x = float(0.0);
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
					    {
					        u_xlat33 = dot(u_xlat5.xyz, u_xlat5.xyz);
					        u_xlat33 = sqrt(u_xlat33);
					        u_xlat33 = max(u_xlat33, 1.0);
					        u_xlat7.x = float(1.0) / u_xlat33;
					        u_xlat33 = (-u_xlat33) + TOD_kRadius.x;
					        u_xlat33 = u_xlat33 * TOD_kScale.z;
					        u_xlat33 = u_xlat33 * 1.44269502;
					        u_xlat33 = exp2(u_xlat33);
					        u_xlat16 = u_xlat4 * u_xlat33;
					        u_xlat25 = dot(u_xlat2.xyz, u_xlat5.xyz);
					        u_xlat34 = dot(TOD_LocalSunDirection.xyz, u_xlat5.xyz);
					        u_xlat34 = (-u_xlat34) * u_xlat7.x + 1.0;
					        u_xlat8 = u_xlat34 * 5.25 + -6.80000019;
					        u_xlat8 = u_xlat34 * u_xlat8 + 3.82999992;
					        u_xlat8 = u_xlat34 * u_xlat8 + 0.458999991;
					        u_xlat34 = u_xlat34 * u_xlat8 + -0.00286999997;
					        u_xlat34 = u_xlat34 * 1.44269502;
					        u_xlat34 = exp2(u_xlat34);
					        u_xlat7.x = (-u_xlat25) * u_xlat7.x + 1.0;
					        u_xlat25 = u_xlat7.x * 5.25 + -6.80000019;
					        u_xlat25 = u_xlat7.x * u_xlat25 + 3.82999992;
					        u_xlat25 = u_xlat7.x * u_xlat25 + 0.458999991;
					        u_xlat7.x = u_xlat7.x * u_xlat25 + -0.00286999997;
					        u_xlat7.x = u_xlat7.x * 1.44269502;
					        u_xlat7.x = exp2(u_xlat7.x);
					        u_xlat7.x = u_xlat7.x * 0.25;
					        u_xlat7.x = u_xlat34 * 0.25 + (-u_xlat7.x);
					        u_xlat33 = u_xlat33 * u_xlat7.x;
					        u_xlat33 = u_xlat30 * 0.25 + u_xlat33;
					        u_xlat7.xzw = u_xlat13.xyz * (-vec3(u_xlat33));
					        u_xlat7.xzw = u_xlat7.xzw * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat7.xzw = exp2(u_xlat7.xzw);
					        u_xlat6.xyz = u_xlat7.xzw * vec3(u_xlat16) + u_xlat6.xyz;
					        u_xlat5.xyz = u_xlat2.xyz * vec3(u_xlat29) + u_xlat5.xyz;
					    }
					    u_xlat2.xyz = u_xlat6.xyz * TOD_SunSkyColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * TOD_kSun.xyz;
					    u_xlat9.x = dot(TOD_LocalSunDirection.yxz, u_xlat0.xyz);
					    u_xlat9.x = u_xlat9.x * u_xlat9.x;
					    u_xlat18 = (-u_xlat0.w) * 0.75 + 1.0;
					    u_xlat9.x = u_xlat9.x * 0.75 + 0.75;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat9.xxx;
					    u_xlat9.xyz = TOD_MoonSkyColor.xyz * vec3(u_xlat18) + u_xlat2.xyz;
					    u_xlat0.x = (-u_xlat0.x);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat2.xyz = (-u_xlat9.xyz) + TOD_GroundColor.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + u_xlat9.xyz;
					    u_xlat2.xyz = (-u_xlat0.xyz) + TOD_FogColor.xyz;
					    u_xlat0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(TOD_Brightness);
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = (bool(u_xlatb1)) ? u_xlat10.xyz : u_xlat0.xyz;
					    vs_TEXCOORD0.xyz = sqrt(u_xlat0.xyz);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "TOD_OUTPUT_HDR" "TOD_OUTPUT_LINEAR" }
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						mat4x4 TOD_World2Sky;
						vec4 unused_0_2[6];
						vec3 TOD_SunSkyColor;
						vec3 TOD_MoonSkyColor;
						vec4 unused_0_5[4];
						vec3 TOD_FogColor;
						vec3 TOD_GroundColor;
						vec4 unused_0_8[4];
						vec3 TOD_LocalSunDirection;
						vec4 unused_0_10;
						float TOD_Contrast;
						float TOD_Brightness;
						float TOD_Fogginess;
						vec4 unused_0_14[11];
						vec4 TOD_kSun;
						vec4 TOD_k4PI;
						vec4 TOD_kRadius;
						vec4 TOD_kScale;
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
					out vec3 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec4 u_xlat7;
					float u_xlat8;
					vec3 u_xlat9;
					vec3 u_xlat10;
					vec3 u_xlat13;
					float u_xlat16;
					float u_xlat18;
					float u_xlat25;
					float u_xlat27;
					float u_xlat29;
					float u_xlat30;
					int u_xlati32;
					float u_xlat33;
					bool u_xlatb33;
					float u_xlat34;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat1.xyz = u_xlat0.yyy * TOD_World2Sky[1].xyz;
					    u_xlat0.xyw = TOD_World2Sky[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = TOD_World2Sky[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.yxz;
					    u_xlatb1 = u_xlat0.x<0.0;
					    u_xlat10.xyz = log2(TOD_GroundColor.xyz);
					    u_xlat10.xyz = u_xlat10.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat10.xyz = exp2(u_xlat10.xyz);
					    u_xlat0.w = max(u_xlat0.x, 0.0);
					    u_xlat2.x = dot(u_xlat0.yzw, u_xlat0.yzw);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat2.xyz = u_xlat0.ywz * u_xlat2.xxx;
					    u_xlat3.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat29 = u_xlat2.y * u_xlat2.y;
					    u_xlat29 = u_xlat29 * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat29 = u_xlat29 + (-TOD_kRadius.y);
					    u_xlat29 = sqrt(u_xlat29);
					    u_xlat29 = (-TOD_kRadius.x) * u_xlat2.y + u_xlat29;
					    u_xlat30 = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat30 = u_xlat30 * 1.44269502;
					    u_xlat30 = exp2(u_xlat30);
					    u_xlat4 = u_xlat2.y * u_xlat3.y;
					    u_xlat4 = u_xlat4 / u_xlat3.y;
					    u_xlat4 = (-u_xlat4) + 1.0;
					    u_xlat13.x = u_xlat4 * 5.25 + -6.80000019;
					    u_xlat13.x = u_xlat4 * u_xlat13.x + 3.82999992;
					    u_xlat13.x = u_xlat4 * u_xlat13.x + 0.458999991;
					    u_xlat4 = u_xlat4 * u_xlat13.x + -0.00286999997;
					    u_xlat4 = u_xlat4 * 1.44269502;
					    u_xlat4 = exp2(u_xlat4);
					    u_xlat30 = u_xlat30 * u_xlat4;
					    u_xlat29 = u_xlat29 * 0.5;
					    u_xlat4 = u_xlat29 * TOD_kScale.x;
					    u_xlat13.xyz = vec3(u_xlat29) * u_xlat2.xyz;
					    u_xlat3.x = float(0.0);
					    u_xlat3.z = float(0.0);
					    u_xlat3.xyz = u_xlat13.xyz * vec3(0.5, 0.5, 0.5) + u_xlat3.xyz;
					    u_xlat13.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat5.xyz = u_xlat3.xyz;
					    u_xlat6.x = float(0.0);
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
					    {
					        u_xlat33 = dot(u_xlat5.xyz, u_xlat5.xyz);
					        u_xlat33 = sqrt(u_xlat33);
					        u_xlat33 = max(u_xlat33, 1.0);
					        u_xlat7.x = float(1.0) / u_xlat33;
					        u_xlat33 = (-u_xlat33) + TOD_kRadius.x;
					        u_xlat33 = u_xlat33 * TOD_kScale.z;
					        u_xlat33 = u_xlat33 * 1.44269502;
					        u_xlat33 = exp2(u_xlat33);
					        u_xlat16 = u_xlat4 * u_xlat33;
					        u_xlat25 = dot(u_xlat2.xyz, u_xlat5.xyz);
					        u_xlat34 = dot(TOD_LocalSunDirection.xyz, u_xlat5.xyz);
					        u_xlat34 = (-u_xlat34) * u_xlat7.x + 1.0;
					        u_xlat8 = u_xlat34 * 5.25 + -6.80000019;
					        u_xlat8 = u_xlat34 * u_xlat8 + 3.82999992;
					        u_xlat8 = u_xlat34 * u_xlat8 + 0.458999991;
					        u_xlat34 = u_xlat34 * u_xlat8 + -0.00286999997;
					        u_xlat34 = u_xlat34 * 1.44269502;
					        u_xlat34 = exp2(u_xlat34);
					        u_xlat7.x = (-u_xlat25) * u_xlat7.x + 1.0;
					        u_xlat25 = u_xlat7.x * 5.25 + -6.80000019;
					        u_xlat25 = u_xlat7.x * u_xlat25 + 3.82999992;
					        u_xlat25 = u_xlat7.x * u_xlat25 + 0.458999991;
					        u_xlat7.x = u_xlat7.x * u_xlat25 + -0.00286999997;
					        u_xlat7.x = u_xlat7.x * 1.44269502;
					        u_xlat7.x = exp2(u_xlat7.x);
					        u_xlat7.x = u_xlat7.x * 0.25;
					        u_xlat7.x = u_xlat34 * 0.25 + (-u_xlat7.x);
					        u_xlat33 = u_xlat33 * u_xlat7.x;
					        u_xlat33 = u_xlat30 * 0.25 + u_xlat33;
					        u_xlat7.xzw = u_xlat13.xyz * (-vec3(u_xlat33));
					        u_xlat7.xzw = u_xlat7.xzw * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat7.xzw = exp2(u_xlat7.xzw);
					        u_xlat6.xyz = u_xlat7.xzw * vec3(u_xlat16) + u_xlat6.xyz;
					        u_xlat5.xyz = u_xlat2.xyz * vec3(u_xlat29) + u_xlat5.xyz;
					    }
					    u_xlat2.xyz = u_xlat6.xyz * TOD_SunSkyColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * TOD_kSun.xyz;
					    u_xlat9.x = dot(TOD_LocalSunDirection.yxz, u_xlat0.xyz);
					    u_xlat9.x = u_xlat9.x * u_xlat9.x;
					    u_xlat18 = (-u_xlat0.w) * 0.75 + 1.0;
					    u_xlat9.x = u_xlat9.x * 0.75 + 0.75;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat9.xxx;
					    u_xlat9.xyz = TOD_MoonSkyColor.xyz * vec3(u_xlat18) + u_xlat2.xyz;
					    u_xlat0.x = (-u_xlat0.x);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat2.xyz = (-u_xlat9.xyz) + TOD_GroundColor.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + u_xlat9.xyz;
					    u_xlat2.xyz = (-u_xlat0.xyz) + TOD_FogColor.xyz;
					    u_xlat0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(TOD_Brightness);
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    vs_TEXCOORD0.xyz = (bool(u_xlatb1)) ? u_xlat10.xyz : u_xlat0.xyz;
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
					
					in  vec3 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					void main()
					{
					    SV_Target0.xyz = vs_TEXCOORD0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "TOD_OUTPUT_LINEAR" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					in  vec3 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					void main()
					{
					    SV_Target0.xyz = vs_TEXCOORD0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "TOD_OUTPUT_HDR" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					in  vec3 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					void main()
					{
					    SV_Target0.xyz = vs_TEXCOORD0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "TOD_OUTPUT_HDR" "TOD_OUTPUT_LINEAR" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					in  vec3 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					void main()
					{
					    SV_Target0.xyz = vs_TEXCOORD0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
			}
		}
	}
}