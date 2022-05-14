//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/Internal-DeferredReflections" {
Properties {
 _SrcBlend ("", Float) = 1
 _DstBlend ("", Float) = 1
}
SubShader { 
 Pass {
  ZWrite Off
  Blend [_SrcBlend] [_DstBlend]
  GpuProgramID 34194
Program "vp" {
SubProgram "opengl " {
"#version 120

#ifdef VERTEX
uniform vec4 _ProjectionParams;


uniform float _LightAsQuad;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec4 tmpvar_1;
  vec3 tmpvar_2;
  tmpvar_1 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 o_3;
  vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_1 * 0.5);
  vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_1.zw;
  tmpvar_2 = ((gl_ModelViewMatrix * gl_Vertex).xyz * vec3(-1.0, -1.0, 1.0));
  vec3 tmpvar_6;
  tmpvar_6 = mix (tmpvar_2, gl_Normal, vec3(_LightAsQuad));
  tmpvar_2 = tmpvar_6;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = o_3;
  xlv_TEXCOORD1 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;
uniform vec4 _ZBufferParams;
uniform samplerCube unity_SpecCube0;
uniform vec4 unity_SpecCube0_BoxMax;
uniform vec4 unity_SpecCube0_BoxMin;
uniform vec4 unity_SpecCube0_ProbePosition;
uniform vec4 unity_SpecCube0_HDR;
uniform vec4 unity_SpecCube1_ProbePosition;
uniform sampler2D _CameraDepthTexture;
uniform mat4 _CameraToWorld;
uniform sampler2D _CameraGBufferTexture0;
uniform sampler2D _CameraGBufferTexture1;
uniform sampler2D _CameraGBufferTexture2;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  float tmpvar_1;
  vec2 tmpvar_2;
  tmpvar_2 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * (1.0/((
    (_ZBufferParams.x * texture2D (_CameraDepthTexture, tmpvar_2).x)
   + _ZBufferParams.y))));
  vec3 tmpvar_4;
  tmpvar_4 = (_CameraToWorld * tmpvar_3).xyz;
  vec4 tmpvar_5;
  tmpvar_5 = texture2D (_CameraGBufferTexture0, tmpvar_2);
  vec4 tmpvar_6;
  tmpvar_6 = texture2D (_CameraGBufferTexture1, tmpvar_2);
  vec3 tmpvar_7;
  tmpvar_7 = normalize(((texture2D (_CameraGBufferTexture2, tmpvar_2).xyz * 2.0) - 1.0));
  vec3 tmpvar_8;
  tmpvar_8 = normalize((tmpvar_4 - _WorldSpaceCameraPos));
  float tmpvar_9;
  tmpvar_9 = (1.0 - max (max (tmpvar_6.x, tmpvar_6.y), tmpvar_6.z));
  vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_8 - (2.0 * (
    dot (tmpvar_7, tmpvar_8)
   * tmpvar_7)));
  float tmpvar_11;
  tmpvar_11 = unity_SpecCube1_ProbePosition.w;
  vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.x = tmpvar_11;
  tmpvar_12.y = tmpvar_11;
  tmpvar_12.z = tmpvar_11;
  vec4 tmpvar_13;
  tmpvar_13 = (unity_SpecCube0_BoxMin - tmpvar_12);
  vec4 tmpvar_14;
  tmpvar_14.w = 0.0;
  tmpvar_14.x = tmpvar_11;
  tmpvar_14.y = tmpvar_11;
  tmpvar_14.z = tmpvar_11;
  vec4 tmpvar_15;
  tmpvar_15 = (unity_SpecCube0_BoxMax + tmpvar_14);
  vec3 worldRefl_16;
  worldRefl_16 = tmpvar_10;
  vec3 worldPos_17;
  worldPos_17 = tmpvar_4;
  if ((unity_SpecCube0_ProbePosition.w > 0.0)) {
    vec3 tmpvar_18;
    tmpvar_18 = normalize(tmpvar_10);
    vec3 tmpvar_19;
    tmpvar_19 = ((tmpvar_15.xyz - tmpvar_4) / tmpvar_18);
    vec3 tmpvar_20;
    tmpvar_20 = ((tmpvar_13.xyz - tmpvar_4) / tmpvar_18);
    bvec3 tmpvar_21;
    tmpvar_21 = greaterThan (tmpvar_18, vec3(0.0, 0.0, 0.0));
    float tmpvar_22;
    if (tmpvar_21.x) {
      tmpvar_22 = tmpvar_19.x;
    } else {
      tmpvar_22 = tmpvar_20.x;
    };
    float tmpvar_23;
    if (tmpvar_21.y) {
      tmpvar_23 = tmpvar_19.y;
    } else {
      tmpvar_23 = tmpvar_20.y;
    };
    float tmpvar_24;
    if (tmpvar_21.z) {
      tmpvar_24 = tmpvar_19.z;
    } else {
      tmpvar_24 = tmpvar_20.z;
    };
    worldPos_17 = (tmpvar_4 - unity_SpecCube0_ProbePosition.xyz);
    worldRefl_16 = (worldPos_17 + (tmpvar_18 * min (
      min (tmpvar_22, tmpvar_23)
    , tmpvar_24)));
  };
  tmpvar_1 = (1.0 - tmpvar_6.w);
  vec4 tmpvar_25;
  tmpvar_25.xyz = worldRefl_16;
  tmpvar_25.w = ((tmpvar_1 * (1.7 - 
    (0.7 * tmpvar_1)
  )) * 6.0);
  vec4 tmpvar_26;
  tmpvar_26 = textureCubeLod (unity_SpecCube0, worldRefl_16, tmpvar_25.w);
  float x_27;
  x_27 = (1.0 - max (0.0, dot (tmpvar_7, 
    -(tmpvar_8)
  )));
  vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xyz = (((
    (unity_SpecCube0_HDR.x * pow (tmpvar_26.w, unity_SpecCube0_HDR.y))
   * tmpvar_26.xyz) * tmpvar_5.w) * mix (tmpvar_6.xyz, vec3(clamp (
    (tmpvar_6.w + (1.0 - tmpvar_9))
  , 0.0, 1.0)), vec3((
    (x_27 * x_27)
   * 
    ((x_27 * x_27) * x_27)
  ))));
  vec3 tmpvar_29;
  tmpvar_29 = max (max ((tmpvar_4 - unity_SpecCube0_BoxMax.xyz), (unity_SpecCube0_BoxMin.xyz - tmpvar_4)), vec3(0.0, 0.0, 0.0));
  vec4 tmpvar_30;
  tmpvar_30.xyz = tmpvar_28.xyz;
  tmpvar_30.w = clamp ((1.0 - (
    sqrt(dot (tmpvar_29, tmpvar_29))
   / unity_SpecCube1_ProbePosition.w)), 0.0, 1.0);
  gl_FragData[0] = tmpvar_30;
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
}
 }
 Pass {
  ZTest Always
  ZWrite Off
  Blend [_SrcBlend] [_DstBlend]
  GpuProgramID 127983
Program "vp" {
SubProgram "opengl " {
"#version 120

#ifdef VERTEX
uniform vec4 _ProjectionParams;

varying vec2 xlv_TEXCOORD0;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 o_2;
  vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  xlv_TEXCOORD0 = o_2.xy;
  gl_Position = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _CameraReflectionsTexture;
varying vec2 xlv_TEXCOORD0;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.w = 0.0;
  tmpvar_1.xyz = exp2(-(texture2D (_CameraReflectionsTexture, xlv_TEXCOORD0).xyz));
  gl_FragData[0] = tmpvar_1;
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
SubProgram "opengl " {
Keywords { "UNITY_HDR_ON" }
"#version 120

#ifdef VERTEX
uniform vec4 _ProjectionParams;

varying vec2 xlv_TEXCOORD0;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 o_2;
  vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  xlv_TEXCOORD0 = o_2.xy;
  gl_Position = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _CameraReflectionsTexture;
varying vec2 xlv_TEXCOORD0;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.w = 0.0;
  tmpvar_1.xyz = texture2D (_CameraReflectionsTexture, xlv_TEXCOORD0).xyz;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "UNITY_HDR_ON" }
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
SubProgram "opengl " {
Keywords { "UNITY_HDR_ON" }
""
}
SubProgram "d3d9 " {
Keywords { "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
}
 }
}
Fallback Off
}