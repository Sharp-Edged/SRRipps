//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Legacy Shaders/VertexLit" {
Properties {
 _Color ("Main Color", Color) = (1,1,1,1)
 _SpecColor ("Spec Color", Color) = (1,1,1,1)
 _Emission ("Emissive Color", Color) = (0,0,0,0)
 _Shininess ("Shininess", Range(0.01,1)) = 0.7
 _MainTex ("Base (RGB)", 2D) = "white" { }
}
SubShader { 
 LOD 100
 Tags { "RenderType"="Opaque" }
 Pass {
  Tags { "LIGHTMODE"="Vertex" "RenderType"="Opaque" }
  GpuProgramID 85859
Program "vp" {
SubProgram "opengl " {
"#version 120

#ifdef VERTEX
uniform vec4 unity_LightColor[8];
uniform vec4 unity_LightPosition[8];



uniform vec4 glstate_lightmodel_ambient;
uniform vec4 _Color;
uniform vec4 _SpecColor;
uniform vec4 _Emission;
uniform float _Shininess;
uniform ivec4 unity_VertexLightParams;
uniform vec4 _MainTex_ST;
varying vec4 xlv_COLOR0;
varying vec3 xlv_COLOR1;
varying vec2 xlv_TEXCOORD0;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = gl_Vertex.xyz;
  float shininess_3;
  vec3 specColor_4;
  vec3 lcolor_5;
  vec3 viewDir_6;
  vec3 eyeNormal_7;
  vec4 color_8;
  color_8 = vec4(0.0, 0.0, 0.0, 1.1);
  vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1;
  mat3 tmpvar_10;
  tmpvar_10[0] = gl_ModelViewMatrixInverseTranspose[0].xyz;
  tmpvar_10[1] = gl_ModelViewMatrixInverseTranspose[1].xyz;
  tmpvar_10[2] = gl_ModelViewMatrixInverseTranspose[2].xyz;
  eyeNormal_7 = normalize((tmpvar_10 * gl_Normal));
  viewDir_6 = -(normalize((gl_ModelViewMatrix * tmpvar_9).xyz));
  lcolor_5 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_4 = vec3(0.0, 0.0, 0.0);
  shininess_3 = (_Shininess * 128.0);
  for (int il_2 = 0; il_2 < unity_VertexLightParams.x; il_2++) {
    vec3 tmpvar_11;
    tmpvar_11 = unity_LightPosition[il_2].xyz;
    vec3 specColor_12;
    specColor_12 = specColor_4;
    float tmpvar_13;
    tmpvar_13 = max (dot (eyeNormal_7, tmpvar_11), 0.0);
    vec3 tmpvar_14;
    tmpvar_14 = ((tmpvar_13 * _Color.xyz) * unity_LightColor[il_2].xyz);
    if ((tmpvar_13 > 0.0)) {
      specColor_12 = (specColor_4 + ((0.5 * 
        clamp (pow (max (dot (eyeNormal_7, 
          normalize((tmpvar_11 + viewDir_6))
        ), 0.0), shininess_3), 0.0, 1.0)
      ) * unity_LightColor[il_2].xyz));
    };
    specColor_4 = specColor_12;
    lcolor_5 = (lcolor_5 + min ((tmpvar_14 * 0.5), vec3(1.0, 1.0, 1.0)));
  };
  color_8.xyz = lcolor_5;
  color_8.w = _Color.w;
  specColor_4 = (specColor_4 * _SpecColor.xyz);
  vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_1;
  xlv_COLOR0 = clamp (color_8, 0.0, 1.0);
  xlv_COLOR1 = clamp (specColor_4, 0.0, 1.0);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (gl_ModelViewProjectionMatrix * tmpvar_15);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying vec4 xlv_COLOR0;
varying vec3 xlv_COLOR1;
varying vec2 xlv_TEXCOORD0;
void main ()
{
  vec4 col_1;
  col_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = 1.0;
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "d3d9 " {
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11_9x " {
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "POINT" }
"#version 120

#ifdef VERTEX
uniform vec4 unity_LightColor[8];
uniform vec4 unity_LightPosition[8];
uniform vec4 unity_LightAtten[8];



uniform vec4 glstate_lightmodel_ambient;
uniform vec4 _Color;
uniform vec4 _SpecColor;
uniform vec4 _Emission;
uniform float _Shininess;
uniform ivec4 unity_VertexLightParams;
uniform vec4 _MainTex_ST;
varying vec4 xlv_COLOR0;
varying vec3 xlv_COLOR1;
varying vec2 xlv_TEXCOORD0;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = gl_Vertex.xyz;
  float shininess_3;
  vec3 specColor_4;
  vec3 lcolor_5;
  vec3 viewDir_6;
  vec3 eyeNormal_7;
  vec3 eyePos_8;
  vec4 color_9;
  color_9 = vec4(0.0, 0.0, 0.0, 1.1);
  vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_1;
  vec3 tmpvar_11;
  tmpvar_11 = (gl_ModelViewMatrix * tmpvar_10).xyz;
  eyePos_8 = tmpvar_11;
  mat3 tmpvar_12;
  tmpvar_12[0] = gl_ModelViewMatrixInverseTranspose[0].xyz;
  tmpvar_12[1] = gl_ModelViewMatrixInverseTranspose[1].xyz;
  tmpvar_12[2] = gl_ModelViewMatrixInverseTranspose[2].xyz;
  eyeNormal_7 = normalize((tmpvar_12 * gl_Normal));
  viewDir_6 = -(normalize(tmpvar_11));
  lcolor_5 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_4 = vec3(0.0, 0.0, 0.0);
  shininess_3 = (_Shininess * 128.0);
  for (int il_2 = 0; il_2 < unity_VertexLightParams.x; il_2++) {
    float att_13;
    vec3 dirToLight_14;
    dirToLight_14 = (unity_LightPosition[il_2].xyz - (eyePos_8 * unity_LightPosition[il_2].w));
    float tmpvar_15;
    tmpvar_15 = dot (dirToLight_14, dirToLight_14);
    att_13 = (1.0/((1.0 + (unity_LightAtten[il_2].z * tmpvar_15))));
    if (((unity_LightPosition[il_2].w != 0.0) && (tmpvar_15 > unity_LightAtten[il_2].w))) {
      att_13 = 0.0;
    };
    dirToLight_14 = (dirToLight_14 * inversesqrt(tmpvar_15));
    att_13 = (att_13 * 0.5);
    vec3 specColor_16;
    specColor_16 = specColor_4;
    float tmpvar_17;
    tmpvar_17 = max (dot (eyeNormal_7, dirToLight_14), 0.0);
    vec3 tmpvar_18;
    tmpvar_18 = ((tmpvar_17 * _Color.xyz) * unity_LightColor[il_2].xyz);
    if ((tmpvar_17 > 0.0)) {
      specColor_16 = (specColor_4 + ((att_13 * 
        clamp (pow (max (dot (eyeNormal_7, 
          normalize((dirToLight_14 + viewDir_6))
        ), 0.0), shininess_3), 0.0, 1.0)
      ) * unity_LightColor[il_2].xyz));
    };
    specColor_4 = specColor_16;
    lcolor_5 = (lcolor_5 + min ((tmpvar_18 * att_13), vec3(1.0, 1.0, 1.0)));
  };
  color_9.xyz = lcolor_5;
  color_9.w = _Color.w;
  specColor_4 = (specColor_4 * _SpecColor.xyz);
  vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = tmpvar_1;
  xlv_COLOR0 = clamp (color_9, 0.0, 1.0);
  xlv_COLOR1 = clamp (specColor_4, 0.0, 1.0);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (gl_ModelViewProjectionMatrix * tmpvar_19);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying vec4 xlv_COLOR0;
varying vec3 xlv_COLOR1;
varying vec2 xlv_TEXCOORD0;
void main ()
{
  vec4 col_1;
  col_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = 1.0;
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "POINT" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "POINT" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11_9x " {
Keywords { "POINT" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "SPOT" }
"#version 120

#ifdef VERTEX
uniform vec4 unity_LightColor[8];
uniform vec4 unity_LightPosition[8];
uniform vec4 unity_LightAtten[8];
uniform vec4 unity_SpotDirection[8];



uniform vec4 glstate_lightmodel_ambient;
uniform vec4 _Color;
uniform vec4 _SpecColor;
uniform vec4 _Emission;
uniform float _Shininess;
uniform ivec4 unity_VertexLightParams;
uniform vec4 _MainTex_ST;
varying vec4 xlv_COLOR0;
varying vec3 xlv_COLOR1;
varying vec2 xlv_TEXCOORD0;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = gl_Vertex.xyz;
  float shininess_3;
  vec3 specColor_4;
  vec3 lcolor_5;
  vec3 viewDir_6;
  vec3 eyeNormal_7;
  vec3 eyePos_8;
  vec4 color_9;
  color_9 = vec4(0.0, 0.0, 0.0, 1.1);
  vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_1;
  vec3 tmpvar_11;
  tmpvar_11 = (gl_ModelViewMatrix * tmpvar_10).xyz;
  eyePos_8 = tmpvar_11;
  mat3 tmpvar_12;
  tmpvar_12[0] = gl_ModelViewMatrixInverseTranspose[0].xyz;
  tmpvar_12[1] = gl_ModelViewMatrixInverseTranspose[1].xyz;
  tmpvar_12[2] = gl_ModelViewMatrixInverseTranspose[2].xyz;
  eyeNormal_7 = normalize((tmpvar_12 * gl_Normal));
  viewDir_6 = -(normalize(tmpvar_11));
  lcolor_5 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_4 = vec3(0.0, 0.0, 0.0);
  shininess_3 = (_Shininess * 128.0);
  for (int il_2 = 0; il_2 < unity_VertexLightParams.x; il_2++) {
    float att_13;
    vec3 dirToLight_14;
    dirToLight_14 = (unity_LightPosition[il_2].xyz - (eyePos_8 * unity_LightPosition[il_2].w));
    float tmpvar_15;
    tmpvar_15 = dot (dirToLight_14, dirToLight_14);
    att_13 = (1.0/((1.0 + (unity_LightAtten[il_2].z * tmpvar_15))));
    if (((unity_LightPosition[il_2].w != 0.0) && (tmpvar_15 > unity_LightAtten[il_2].w))) {
      att_13 = 0.0;
    };
    dirToLight_14 = (dirToLight_14 * inversesqrt(tmpvar_15));
    att_13 = (att_13 * clamp ((
      (max (dot (dirToLight_14, unity_SpotDirection[il_2].xyz), 0.0) - unity_LightAtten[il_2].x)
     * unity_LightAtten[il_2].y), 0.0, 1.0));
    att_13 = (att_13 * 0.5);
    vec3 specColor_16;
    specColor_16 = specColor_4;
    float tmpvar_17;
    tmpvar_17 = max (dot (eyeNormal_7, dirToLight_14), 0.0);
    vec3 tmpvar_18;
    tmpvar_18 = ((tmpvar_17 * _Color.xyz) * unity_LightColor[il_2].xyz);
    if ((tmpvar_17 > 0.0)) {
      specColor_16 = (specColor_4 + ((att_13 * 
        clamp (pow (max (dot (eyeNormal_7, 
          normalize((dirToLight_14 + viewDir_6))
        ), 0.0), shininess_3), 0.0, 1.0)
      ) * unity_LightColor[il_2].xyz));
    };
    specColor_4 = specColor_16;
    lcolor_5 = (lcolor_5 + min ((tmpvar_18 * att_13), vec3(1.0, 1.0, 1.0)));
  };
  color_9.xyz = lcolor_5;
  color_9.w = _Color.w;
  specColor_4 = (specColor_4 * _SpecColor.xyz);
  vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = tmpvar_1;
  xlv_COLOR0 = clamp (color_9, 0.0, 1.0);
  xlv_COLOR1 = clamp (specColor_4, 0.0, 1.0);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (gl_ModelViewProjectionMatrix * tmpvar_19);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying vec4 xlv_COLOR0;
varying vec3 xlv_COLOR1;
varying vec2 xlv_TEXCOORD0;
void main ()
{
  vec4 col_1;
  col_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = 1.0;
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "SPOT" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11_9x " {
Keywords { "SPOT" }
"// shader disassembly not supported on DXBC"
}
}
Program "fp" {
SubProgram "opengl " {
""
}
SubProgram "d3d9 " {
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11_9x " {
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "POINT" }
""
}
SubProgram "d3d9 " {
Keywords { "POINT" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "POINT" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11_9x " {
Keywords { "POINT" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "SPOT" }
""
}
SubProgram "d3d9 " {
Keywords { "SPOT" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "SPOT" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11_9x " {
Keywords { "SPOT" }
"// shader disassembly not supported on DXBC"
}
}
 }
 Pass {
  Tags { "LIGHTMODE"="VertexLM" "RenderType"="Opaque" }
  GpuProgramID 155416
Program "vp" {
SubProgram "opengl " {
"#version 120

#ifdef VERTEX

uniform vec4 unity_LightmapST;
uniform vec4 _MainTex_ST;
varying vec4 xlv_COLOR0;
varying vec2 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = gl_Vertex.xyz;
  xlv_COLOR0 = clamp (vec4(0.0, 0.0, 0.0, 1.1), 0.0, 1.0);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD1 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (gl_ModelViewProjectionMatrix * tmpvar_1);
}


#endif
#ifdef FRAGMENT
uniform sampler2D unity_Lightmap;
uniform sampler2D _MainTex;
uniform vec4 _Color;
varying vec2 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
void main ()
{
  vec4 col_1;
  col_1 = (texture2D (unity_Lightmap, xlv_TEXCOORD0) * _Color);
  col_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD1) * col_1).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = 1.0;
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "d3d9 " {
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11_9x " {
"// shader disassembly not supported on DXBC"
}
}
Program "fp" {
SubProgram "opengl " {
""
}
SubProgram "d3d9 " {
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11_9x " {
"// shader disassembly not supported on DXBC"
}
}
 }
 Pass {
  Tags { "LIGHTMODE"="VertexLMRGBM" "RenderType"="Opaque" }
  GpuProgramID 249241
Program "vp" {
SubProgram "opengl " {
"#version 120

#ifdef VERTEX

uniform vec4 unity_LightmapST;
uniform vec4 unity_Lightmap_ST;
uniform vec4 _MainTex_ST;
varying vec4 xlv_COLOR0;
varying vec2 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD2;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = gl_Vertex.xyz;
  xlv_COLOR0 = clamp (vec4(0.0, 0.0, 0.0, 1.1), 0.0, 1.0);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD1 = ((gl_MultiTexCoord1.xy * unity_Lightmap_ST.xy) + unity_Lightmap_ST.zw);
  xlv_TEXCOORD2 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (gl_ModelViewProjectionMatrix * tmpvar_1);
}


#endif
#ifdef FRAGMENT
uniform sampler2D unity_Lightmap;
uniform sampler2D _MainTex;
uniform vec4 _Color;
varying vec2 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD2;
void main ()
{
  vec4 col_1;
  vec4 tmpvar_2;
  tmpvar_2 = texture2D (unity_Lightmap, xlv_TEXCOORD0);
  col_1 = (tmpvar_2 * tmpvar_2.w);
  col_1 = (col_1 * 2.0);
  col_1 = (col_1 * _Color);
  col_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD2) * col_1).xyz;
  col_1.xyz = (col_1 * 4.0).xyz;
  col_1.w = 1.0;
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "d3d9 " {
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11_9x " {
"// shader disassembly not supported on DXBC"
}
}
Program "fp" {
SubProgram "opengl " {
""
}
SubProgram "d3d9 " {
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11_9x " {
"// shader disassembly not supported on DXBC"
}
}
 }
 Pass {
  Name "SHADOWCASTER"
  Tags { "LIGHTMODE"="SHADOWCASTER" "SHADOWSUPPORT"="true" "RenderType"="Opaque" }
  GpuProgramID 33459
Program "vp" {
SubProgram "opengl " {
Keywords { "SHADOWS_DEPTH" }
"#version 120

#ifdef VERTEX
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 unity_LightShadowBias;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform mat4 unity_MatrixVP;
void main ()
{
  vec3 vertex_1;
  vertex_1 = gl_Vertex.xyz;
  vec4 clipPos_2;
  if ((unity_LightShadowBias.z != 0.0)) {
    vec4 tmpvar_3;
    tmpvar_3.w = 1.0;
    tmpvar_3.xyz = vertex_1;
    vec3 tmpvar_4;
    tmpvar_4 = (_Object2World * tmpvar_3).xyz;
    vec4 v_5;
    v_5.x = _World2Object[0].x;
    v_5.y = _World2Object[1].x;
    v_5.z = _World2Object[2].x;
    v_5.w = _World2Object[3].x;
    vec4 v_6;
    v_6.x = _World2Object[0].y;
    v_6.y = _World2Object[1].y;
    v_6.z = _World2Object[2].y;
    v_6.w = _World2Object[3].y;
    vec4 v_7;
    v_7.x = _World2Object[0].z;
    v_7.y = _World2Object[1].z;
    v_7.z = _World2Object[2].z;
    v_7.w = _World2Object[3].z;
    vec3 tmpvar_8;
    tmpvar_8 = normalize(((
      (v_5.xyz * gl_Normal.x)
     + 
      (v_6.xyz * gl_Normal.y)
    ) + (v_7.xyz * gl_Normal.z)));
    float tmpvar_9;
    tmpvar_9 = dot (tmpvar_8, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_4 * _WorldSpaceLightPos0.w)
    )));
    vec4 tmpvar_10;
    tmpvar_10.w = 1.0;
    tmpvar_10.xyz = (tmpvar_4 - (tmpvar_8 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_9 * tmpvar_9)))
    )));
    clipPos_2 = (unity_MatrixVP * tmpvar_10);
  } else {
    vec4 tmpvar_11;
    tmpvar_11.w = 1.0;
    tmpvar_11.xyz = vertex_1;
    clipPos_2 = (gl_ModelViewProjectionMatrix * tmpvar_11);
  };
  vec4 clipPos_12;
  clipPos_12.xyw = clipPos_2.xyw;
  clipPos_12.z = (clipPos_2.z + clamp ((unity_LightShadowBias.x / clipPos_2.w), 0.0, 1.0));
  clipPos_12.z = mix (clipPos_12.z, max (clipPos_12.z, -(clipPos_2.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_12;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "SHADOWS_DEPTH" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "SHADOWS_DEPTH" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11_9x " {
Keywords { "SHADOWS_DEPTH" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "SHADOWS_CUBE" }
"#version 120

#ifdef VERTEX
uniform vec4 _LightPositionRange;

uniform mat4 _Object2World;
varying vec3 xlv_TEXCOORD0;
void main ()
{
  xlv_TEXCOORD0 = ((_Object2World * gl_Vertex).xyz - _LightPositionRange.xyz);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
}


#endif
#ifdef FRAGMENT
uniform vec4 _LightPositionRange;
uniform vec4 unity_LightShadowBias;
varying vec3 xlv_TEXCOORD0;
void main ()
{
  gl_FragData[0] = vec4(((sqrt(
    dot (xlv_TEXCOORD0, xlv_TEXCOORD0)
  ) + unity_LightShadowBias.x) * _LightPositionRange.w));
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "SHADOWS_CUBE" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "SHADOWS_CUBE" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11_9x " {
Keywords { "SHADOWS_CUBE" }
"// shader disassembly not supported on DXBC"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "d3d9 " {
Keywords { "SHADOWS_DEPTH" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "SHADOWS_DEPTH" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11_9x " {
Keywords { "SHADOWS_DEPTH" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "SHADOWS_CUBE" }
""
}
SubProgram "d3d9 " {
Keywords { "SHADOWS_CUBE" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "SHADOWS_CUBE" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11_9x " {
Keywords { "SHADOWS_CUBE" }
"// shader disassembly not supported on DXBC"
}
}
 }
}
}