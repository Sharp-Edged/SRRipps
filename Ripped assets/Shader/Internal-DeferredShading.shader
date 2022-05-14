//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/Internal-DeferredShading" {
Properties {
 _LightTexture0 ("", any) = "" { }
 _LightTextureB0 ("", 2D) = "" { }
 _ShadowMapTexture ("", any) = "" { }
 _SrcBlend ("", Float) = 1
 _DstBlend ("", Float) = 1
}
SubShader { 
 Pass {
  Tags { "SHADOWSUPPORT"="true" }
  ZWrite Off
  Blend [_SrcBlend] [_DstBlend]
  GpuProgramID 36028
Program "vp" {
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_OFF" }
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
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;
uniform vec4 _ZBufferParams;
uniform vec4 unity_ColorSpaceLuminance;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _LightPos;
uniform vec4 _LightColor;
uniform mat4 _CameraToWorld;
uniform sampler2D _LightTextureB0;
uniform sampler2D _CameraGBufferTexture0;
uniform sampler2D _CameraGBufferTexture1;
uniform sampler2D _CameraGBufferTexture2;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec3 tmpvar_1;
  vec2 tmpvar_2;
  tmpvar_2 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * (1.0/((
    (_ZBufferParams.x * texture2D (_CameraDepthTexture, tmpvar_2).x)
   + _ZBufferParams.y))));
  vec3 tmpvar_4;
  tmpvar_4 = (_CameraToWorld * tmpvar_3).xyz;
  vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 - _LightPos.xyz);
  vec3 tmpvar_6;
  tmpvar_6 = -(normalize(tmpvar_5));
  vec4 tmpvar_7;
  tmpvar_7 = texture2D (_CameraGBufferTexture0, tmpvar_2);
  vec4 tmpvar_8;
  tmpvar_8 = texture2D (_CameraGBufferTexture1, tmpvar_2);
  tmpvar_1 = (_LightColor.xyz * texture2D (_LightTextureB0, vec2((dot (tmpvar_5, tmpvar_5) * _LightPos.w))).w);
  vec3 tmpvar_9;
  tmpvar_9 = normalize(((texture2D (_CameraGBufferTexture2, tmpvar_2).xyz * 2.0) - 1.0));
  float tmpvar_10;
  tmpvar_10 = max (0.0, dot (tmpvar_9, tmpvar_6));
  vec3 viewDir_11;
  viewDir_11 = -(normalize((tmpvar_4 - _WorldSpaceCameraPos)));
  float specularTerm_12;
  float tmpvar_13;
  tmpvar_13 = (1.0 - tmpvar_8.w);
  vec3 tmpvar_14;
  vec3 inVec_15;
  inVec_15 = (tmpvar_6 + viewDir_11);
  tmpvar_14 = (inVec_15 * inversesqrt(max (0.001, 
    dot (inVec_15, inVec_15)
  )));
  float tmpvar_16;
  tmpvar_16 = max (0.0, dot (tmpvar_9, tmpvar_14));
  float tmpvar_17;
  tmpvar_17 = max (0.0, dot (tmpvar_9, viewDir_11));
  float tmpvar_18;
  tmpvar_18 = max (0.0, dot (tmpvar_6, tmpvar_14));
  float tmpvar_19;
  tmpvar_19 = (tmpvar_13 * tmpvar_13);
  float tmpvar_20;
  tmpvar_20 = (tmpvar_13 * tmpvar_13);
  float tmpvar_21;
  tmpvar_21 = (tmpvar_20 * tmpvar_20);
  float tmpvar_22;
  tmpvar_22 = (((tmpvar_16 * tmpvar_16) * (tmpvar_21 - 1.0)) + 1.0);
  float x_23;
  x_23 = (1.0 - tmpvar_10);
  float x_24;
  x_24 = (1.0 - tmpvar_17);
  float tmpvar_25;
  tmpvar_25 = (0.5 + ((2.0 * tmpvar_18) * (tmpvar_18 * tmpvar_13)));
  float tmpvar_26;
  tmpvar_26 = ((1.0 + (
    (tmpvar_25 - 1.0)
   * 
    ((x_23 * x_23) * ((x_23 * x_23) * x_23))
  )) * (1.0 + (
    (tmpvar_25 - 1.0)
   * 
    ((x_24 * x_24) * ((x_24 * x_24) * x_24))
  )));
  float tmpvar_27;
  tmpvar_27 = (((
    (2.0 * tmpvar_10)
   / 
    (((tmpvar_10 * (
      (tmpvar_17 * (1.0 - tmpvar_19))
     + tmpvar_19)) + (tmpvar_17 * (
      (tmpvar_10 * (1.0 - tmpvar_19))
     + tmpvar_19))) + 1e-05)
  ) * (tmpvar_21 / 
    ((3.141593 * tmpvar_22) * tmpvar_22)
  )) * 0.7853982);
  specularTerm_12 = tmpvar_27;
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    specularTerm_12 = sqrt(max (0.0001, tmpvar_27));
  };
  float tmpvar_28;
  tmpvar_28 = max (0.0, (specularTerm_12 * tmpvar_10));
  specularTerm_12 = tmpvar_28;
  float x_29;
  x_29 = (1.0 - tmpvar_18);
  vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = ((tmpvar_7.xyz * (tmpvar_1 * 
    (tmpvar_26 * tmpvar_10)
  )) + ((tmpvar_28 * tmpvar_1) * (tmpvar_8.xyz + 
    ((1.0 - tmpvar_8.xyz) * ((x_29 * x_29) * ((x_29 * x_29) * x_29)))
  )));
  gl_FragData[0] = exp2(-(tmpvar_30));
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_OFF" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "POINT" "SHADOWS_OFF" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
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
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;
uniform vec4 _ZBufferParams;
uniform vec4 unity_ColorSpaceLuminance;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _LightDir;
uniform vec4 _LightColor;
uniform mat4 _CameraToWorld;
uniform sampler2D _CameraGBufferTexture0;
uniform sampler2D _CameraGBufferTexture1;
uniform sampler2D _CameraGBufferTexture2;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * (1.0/((
    (_ZBufferParams.x * texture2D (_CameraDepthTexture, tmpvar_1).x)
   + _ZBufferParams.y))));
  vec3 tmpvar_3;
  tmpvar_3 = -(_LightDir.xyz);
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (_CameraGBufferTexture0, tmpvar_1);
  vec4 tmpvar_5;
  tmpvar_5 = texture2D (_CameraGBufferTexture1, tmpvar_1);
  vec3 tmpvar_6;
  tmpvar_6 = normalize(((texture2D (_CameraGBufferTexture2, tmpvar_1).xyz * 2.0) - 1.0));
  float tmpvar_7;
  tmpvar_7 = max (0.0, dot (tmpvar_6, tmpvar_3));
  vec3 viewDir_8;
  viewDir_8 = -(normalize((
    (_CameraToWorld * tmpvar_2)
  .xyz - _WorldSpaceCameraPos)));
  float specularTerm_9;
  float tmpvar_10;
  tmpvar_10 = (1.0 - tmpvar_5.w);
  vec3 tmpvar_11;
  vec3 inVec_12;
  inVec_12 = (tmpvar_3 + viewDir_8);
  tmpvar_11 = (inVec_12 * inversesqrt(max (0.001, 
    dot (inVec_12, inVec_12)
  )));
  float tmpvar_13;
  tmpvar_13 = max (0.0, dot (tmpvar_6, tmpvar_11));
  float tmpvar_14;
  tmpvar_14 = max (0.0, dot (tmpvar_6, viewDir_8));
  float tmpvar_15;
  tmpvar_15 = max (0.0, dot (tmpvar_3, tmpvar_11));
  float tmpvar_16;
  tmpvar_16 = (tmpvar_10 * tmpvar_10);
  float tmpvar_17;
  tmpvar_17 = (tmpvar_10 * tmpvar_10);
  float tmpvar_18;
  tmpvar_18 = (tmpvar_17 * tmpvar_17);
  float tmpvar_19;
  tmpvar_19 = (((tmpvar_13 * tmpvar_13) * (tmpvar_18 - 1.0)) + 1.0);
  float x_20;
  x_20 = (1.0 - tmpvar_7);
  float x_21;
  x_21 = (1.0 - tmpvar_14);
  float tmpvar_22;
  tmpvar_22 = (0.5 + ((2.0 * tmpvar_15) * (tmpvar_15 * tmpvar_10)));
  float tmpvar_23;
  tmpvar_23 = ((1.0 + (
    (tmpvar_22 - 1.0)
   * 
    ((x_20 * x_20) * ((x_20 * x_20) * x_20))
  )) * (1.0 + (
    (tmpvar_22 - 1.0)
   * 
    ((x_21 * x_21) * ((x_21 * x_21) * x_21))
  )));
  float tmpvar_24;
  tmpvar_24 = (((
    (2.0 * tmpvar_7)
   / 
    (((tmpvar_7 * (
      (tmpvar_14 * (1.0 - tmpvar_16))
     + tmpvar_16)) + (tmpvar_14 * (
      (tmpvar_7 * (1.0 - tmpvar_16))
     + tmpvar_16))) + 1e-05)
  ) * (tmpvar_18 / 
    ((3.141593 * tmpvar_19) * tmpvar_19)
  )) * 0.7853982);
  specularTerm_9 = tmpvar_24;
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    specularTerm_9 = sqrt(max (0.0001, tmpvar_24));
  };
  float tmpvar_25;
  tmpvar_25 = max (0.0, (specularTerm_9 * tmpvar_7));
  specularTerm_9 = tmpvar_25;
  float x_26;
  x_26 = (1.0 - tmpvar_15);
  vec4 tmpvar_27;
  tmpvar_27.w = 1.0;
  tmpvar_27.xyz = ((tmpvar_4.xyz * (_LightColor.xyz * 
    (tmpvar_23 * tmpvar_7)
  )) + ((tmpvar_25 * _LightColor.xyz) * (tmpvar_5.xyz + 
    ((1.0 - tmpvar_5.xyz) * ((x_26 * x_26) * ((x_26 * x_26) * x_26)))
  )));
  gl_FragData[0] = exp2(-(tmpvar_27));
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_OFF" }
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
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;
uniform vec4 _ZBufferParams;
uniform vec4 unity_ColorSpaceLuminance;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _LightPos;
uniform vec4 _LightColor;
uniform mat4 _CameraToWorld;
uniform mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform sampler2D _CameraGBufferTexture0;
uniform sampler2D _CameraGBufferTexture1;
uniform sampler2D _CameraGBufferTexture2;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec3 tmpvar_1;
  float atten_2;
  vec2 tmpvar_3;
  tmpvar_3 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * (1.0/((
    (_ZBufferParams.x * texture2D (_CameraDepthTexture, tmpvar_3).x)
   + _ZBufferParams.y))));
  vec3 tmpvar_5;
  tmpvar_5 = (_CameraToWorld * tmpvar_4).xyz;
  vec3 tmpvar_6;
  tmpvar_6 = (_LightPos.xyz - tmpvar_5);
  vec3 tmpvar_7;
  tmpvar_7 = normalize(tmpvar_6);
  vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_5;
  vec4 tmpvar_9;
  tmpvar_9 = (_LightMatrix0 * tmpvar_8);
  vec4 tmpvar_10;
  tmpvar_10.zw = vec2(0.0, -8.0);
  tmpvar_10.xy = (tmpvar_9.xy / tmpvar_9.w);
  atten_2 = (texture2D (_LightTexture0, tmpvar_10.xy, -8.0).w * float((tmpvar_9.w < 0.0)));
  atten_2 = (atten_2 * texture2D (_LightTextureB0, vec2((dot (tmpvar_6, tmpvar_6) * _LightPos.w))).w);
  vec4 tmpvar_11;
  tmpvar_11 = texture2D (_CameraGBufferTexture0, tmpvar_3);
  vec4 tmpvar_12;
  tmpvar_12 = texture2D (_CameraGBufferTexture1, tmpvar_3);
  tmpvar_1 = (_LightColor.xyz * atten_2);
  vec3 tmpvar_13;
  tmpvar_13 = normalize(((texture2D (_CameraGBufferTexture2, tmpvar_3).xyz * 2.0) - 1.0));
  float tmpvar_14;
  tmpvar_14 = max (0.0, dot (tmpvar_13, tmpvar_7));
  vec3 viewDir_15;
  viewDir_15 = -(normalize((tmpvar_5 - _WorldSpaceCameraPos)));
  float specularTerm_16;
  float tmpvar_17;
  tmpvar_17 = (1.0 - tmpvar_12.w);
  vec3 tmpvar_18;
  vec3 inVec_19;
  inVec_19 = (tmpvar_7 + viewDir_15);
  tmpvar_18 = (inVec_19 * inversesqrt(max (0.001, 
    dot (inVec_19, inVec_19)
  )));
  float tmpvar_20;
  tmpvar_20 = max (0.0, dot (tmpvar_13, tmpvar_18));
  float tmpvar_21;
  tmpvar_21 = max (0.0, dot (tmpvar_13, viewDir_15));
  float tmpvar_22;
  tmpvar_22 = max (0.0, dot (tmpvar_7, tmpvar_18));
  float tmpvar_23;
  tmpvar_23 = (tmpvar_17 * tmpvar_17);
  float tmpvar_24;
  tmpvar_24 = (tmpvar_17 * tmpvar_17);
  float tmpvar_25;
  tmpvar_25 = (tmpvar_24 * tmpvar_24);
  float tmpvar_26;
  tmpvar_26 = (((tmpvar_20 * tmpvar_20) * (tmpvar_25 - 1.0)) + 1.0);
  float x_27;
  x_27 = (1.0 - tmpvar_14);
  float x_28;
  x_28 = (1.0 - tmpvar_21);
  float tmpvar_29;
  tmpvar_29 = (0.5 + ((2.0 * tmpvar_22) * (tmpvar_22 * tmpvar_17)));
  float tmpvar_30;
  tmpvar_30 = ((1.0 + (
    (tmpvar_29 - 1.0)
   * 
    ((x_27 * x_27) * ((x_27 * x_27) * x_27))
  )) * (1.0 + (
    (tmpvar_29 - 1.0)
   * 
    ((x_28 * x_28) * ((x_28 * x_28) * x_28))
  )));
  float tmpvar_31;
  tmpvar_31 = (((
    (2.0 * tmpvar_14)
   / 
    (((tmpvar_14 * (
      (tmpvar_21 * (1.0 - tmpvar_23))
     + tmpvar_23)) + (tmpvar_21 * (
      (tmpvar_14 * (1.0 - tmpvar_23))
     + tmpvar_23))) + 1e-05)
  ) * (tmpvar_25 / 
    ((3.141593 * tmpvar_26) * tmpvar_26)
  )) * 0.7853982);
  specularTerm_16 = tmpvar_31;
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    specularTerm_16 = sqrt(max (0.0001, tmpvar_31));
  };
  float tmpvar_32;
  tmpvar_32 = max (0.0, (specularTerm_16 * tmpvar_14));
  specularTerm_16 = tmpvar_32;
  float x_33;
  x_33 = (1.0 - tmpvar_22);
  vec4 tmpvar_34;
  tmpvar_34.w = 1.0;
  tmpvar_34.xyz = ((tmpvar_11.xyz * (tmpvar_1 * 
    (tmpvar_30 * tmpvar_14)
  )) + ((tmpvar_32 * tmpvar_1) * (tmpvar_12.xyz + 
    ((1.0 - tmpvar_12.xyz) * ((x_33 * x_33) * ((x_33 * x_33) * x_33)))
  )));
  gl_FragData[0] = exp2(-(tmpvar_34));
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_OFF" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_OFF" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
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
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;
uniform vec4 _ZBufferParams;
uniform vec4 unity_ColorSpaceLuminance;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _LightPos;
uniform vec4 _LightColor;
uniform mat4 _CameraToWorld;
uniform mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
uniform sampler2D _CameraGBufferTexture0;
uniform sampler2D _CameraGBufferTexture1;
uniform sampler2D _CameraGBufferTexture2;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec3 tmpvar_1;
  vec2 tmpvar_2;
  tmpvar_2 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * (1.0/((
    (_ZBufferParams.x * texture2D (_CameraDepthTexture, tmpvar_2).x)
   + _ZBufferParams.y))));
  vec3 tmpvar_4;
  tmpvar_4 = (_CameraToWorld * tmpvar_3).xyz;
  vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 - _LightPos.xyz);
  vec3 tmpvar_6;
  tmpvar_6 = -(normalize(tmpvar_5));
  vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_4;
  vec4 tmpvar_8;
  tmpvar_8.w = -8.0;
  tmpvar_8.xyz = (_LightMatrix0 * tmpvar_7).xyz;
  vec4 tmpvar_9;
  tmpvar_9 = texture2D (_CameraGBufferTexture0, tmpvar_2);
  vec4 tmpvar_10;
  tmpvar_10 = texture2D (_CameraGBufferTexture1, tmpvar_2);
  tmpvar_1 = (_LightColor.xyz * (texture2D (_LightTextureB0, vec2((
    dot (tmpvar_5, tmpvar_5)
   * _LightPos.w))).w * textureCube (_LightTexture0, tmpvar_8.xyz, -8.0).w));
  vec3 tmpvar_11;
  tmpvar_11 = normalize(((texture2D (_CameraGBufferTexture2, tmpvar_2).xyz * 2.0) - 1.0));
  float tmpvar_12;
  tmpvar_12 = max (0.0, dot (tmpvar_11, tmpvar_6));
  vec3 viewDir_13;
  viewDir_13 = -(normalize((tmpvar_4 - _WorldSpaceCameraPos)));
  float specularTerm_14;
  float tmpvar_15;
  tmpvar_15 = (1.0 - tmpvar_10.w);
  vec3 tmpvar_16;
  vec3 inVec_17;
  inVec_17 = (tmpvar_6 + viewDir_13);
  tmpvar_16 = (inVec_17 * inversesqrt(max (0.001, 
    dot (inVec_17, inVec_17)
  )));
  float tmpvar_18;
  tmpvar_18 = max (0.0, dot (tmpvar_11, tmpvar_16));
  float tmpvar_19;
  tmpvar_19 = max (0.0, dot (tmpvar_11, viewDir_13));
  float tmpvar_20;
  tmpvar_20 = max (0.0, dot (tmpvar_6, tmpvar_16));
  float tmpvar_21;
  tmpvar_21 = (tmpvar_15 * tmpvar_15);
  float tmpvar_22;
  tmpvar_22 = (tmpvar_15 * tmpvar_15);
  float tmpvar_23;
  tmpvar_23 = (tmpvar_22 * tmpvar_22);
  float tmpvar_24;
  tmpvar_24 = (((tmpvar_18 * tmpvar_18) * (tmpvar_23 - 1.0)) + 1.0);
  float x_25;
  x_25 = (1.0 - tmpvar_12);
  float x_26;
  x_26 = (1.0 - tmpvar_19);
  float tmpvar_27;
  tmpvar_27 = (0.5 + ((2.0 * tmpvar_20) * (tmpvar_20 * tmpvar_15)));
  float tmpvar_28;
  tmpvar_28 = ((1.0 + (
    (tmpvar_27 - 1.0)
   * 
    ((x_25 * x_25) * ((x_25 * x_25) * x_25))
  )) * (1.0 + (
    (tmpvar_27 - 1.0)
   * 
    ((x_26 * x_26) * ((x_26 * x_26) * x_26))
  )));
  float tmpvar_29;
  tmpvar_29 = (((
    (2.0 * tmpvar_12)
   / 
    (((tmpvar_12 * (
      (tmpvar_19 * (1.0 - tmpvar_21))
     + tmpvar_21)) + (tmpvar_19 * (
      (tmpvar_12 * (1.0 - tmpvar_21))
     + tmpvar_21))) + 1e-05)
  ) * (tmpvar_23 / 
    ((3.141593 * tmpvar_24) * tmpvar_24)
  )) * 0.7853982);
  specularTerm_14 = tmpvar_29;
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    specularTerm_14 = sqrt(max (0.0001, tmpvar_29));
  };
  float tmpvar_30;
  tmpvar_30 = max (0.0, (specularTerm_14 * tmpvar_12));
  specularTerm_14 = tmpvar_30;
  float x_31;
  x_31 = (1.0 - tmpvar_20);
  vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = ((tmpvar_9.xyz * (tmpvar_1 * 
    (tmpvar_28 * tmpvar_12)
  )) + ((tmpvar_30 * tmpvar_1) * (tmpvar_10.xyz + 
    ((1.0 - tmpvar_10.xyz) * ((x_31 * x_31) * ((x_31 * x_31) * x_31)))
  )));
  gl_FragData[0] = exp2(-(tmpvar_32));
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
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
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;
uniform vec4 _ZBufferParams;
uniform vec4 unity_ColorSpaceLuminance;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _LightDir;
uniform vec4 _LightColor;
uniform mat4 _CameraToWorld;
uniform mat4 _LightMatrix0;
uniform sampler2D _LightTexture0;
uniform sampler2D _CameraGBufferTexture0;
uniform sampler2D _CameraGBufferTexture1;
uniform sampler2D _CameraGBufferTexture2;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec3 tmpvar_1;
  vec2 tmpvar_2;
  tmpvar_2 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * (1.0/((
    (_ZBufferParams.x * texture2D (_CameraDepthTexture, tmpvar_2).x)
   + _ZBufferParams.y))));
  vec3 tmpvar_4;
  tmpvar_4 = (_CameraToWorld * tmpvar_3).xyz;
  vec3 tmpvar_5;
  tmpvar_5 = -(_LightDir.xyz);
  vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_4;
  vec4 tmpvar_7;
  tmpvar_7.zw = vec2(0.0, -8.0);
  tmpvar_7.xy = (_LightMatrix0 * tmpvar_6).xy;
  vec4 tmpvar_8;
  tmpvar_8 = texture2D (_CameraGBufferTexture0, tmpvar_2);
  vec4 tmpvar_9;
  tmpvar_9 = texture2D (_CameraGBufferTexture1, tmpvar_2);
  tmpvar_1 = (_LightColor.xyz * texture2D (_LightTexture0, tmpvar_7.xy, -8.0).w);
  vec3 tmpvar_10;
  tmpvar_10 = normalize(((texture2D (_CameraGBufferTexture2, tmpvar_2).xyz * 2.0) - 1.0));
  float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_10, tmpvar_5));
  vec3 viewDir_12;
  viewDir_12 = -(normalize((tmpvar_4 - _WorldSpaceCameraPos)));
  float specularTerm_13;
  float tmpvar_14;
  tmpvar_14 = (1.0 - tmpvar_9.w);
  vec3 tmpvar_15;
  vec3 inVec_16;
  inVec_16 = (tmpvar_5 + viewDir_12);
  tmpvar_15 = (inVec_16 * inversesqrt(max (0.001, 
    dot (inVec_16, inVec_16)
  )));
  float tmpvar_17;
  tmpvar_17 = max (0.0, dot (tmpvar_10, tmpvar_15));
  float tmpvar_18;
  tmpvar_18 = max (0.0, dot (tmpvar_10, viewDir_12));
  float tmpvar_19;
  tmpvar_19 = max (0.0, dot (tmpvar_5, tmpvar_15));
  float tmpvar_20;
  tmpvar_20 = (tmpvar_14 * tmpvar_14);
  float tmpvar_21;
  tmpvar_21 = (tmpvar_14 * tmpvar_14);
  float tmpvar_22;
  tmpvar_22 = (tmpvar_21 * tmpvar_21);
  float tmpvar_23;
  tmpvar_23 = (((tmpvar_17 * tmpvar_17) * (tmpvar_22 - 1.0)) + 1.0);
  float x_24;
  x_24 = (1.0 - tmpvar_11);
  float x_25;
  x_25 = (1.0 - tmpvar_18);
  float tmpvar_26;
  tmpvar_26 = (0.5 + ((2.0 * tmpvar_19) * (tmpvar_19 * tmpvar_14)));
  float tmpvar_27;
  tmpvar_27 = ((1.0 + (
    (tmpvar_26 - 1.0)
   * 
    ((x_24 * x_24) * ((x_24 * x_24) * x_24))
  )) * (1.0 + (
    (tmpvar_26 - 1.0)
   * 
    ((x_25 * x_25) * ((x_25 * x_25) * x_25))
  )));
  float tmpvar_28;
  tmpvar_28 = (((
    (2.0 * tmpvar_11)
   / 
    (((tmpvar_11 * (
      (tmpvar_18 * (1.0 - tmpvar_20))
     + tmpvar_20)) + (tmpvar_18 * (
      (tmpvar_11 * (1.0 - tmpvar_20))
     + tmpvar_20))) + 1e-05)
  ) * (tmpvar_22 / 
    ((3.141593 * tmpvar_23) * tmpvar_23)
  )) * 0.7853982);
  specularTerm_13 = tmpvar_28;
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    specularTerm_13 = sqrt(max (0.0001, tmpvar_28));
  };
  float tmpvar_29;
  tmpvar_29 = max (0.0, (specularTerm_13 * tmpvar_11));
  specularTerm_13 = tmpvar_29;
  float x_30;
  x_30 = (1.0 - tmpvar_19);
  vec4 tmpvar_31;
  tmpvar_31.w = 1.0;
  tmpvar_31.xyz = ((tmpvar_8.xyz * (tmpvar_1 * 
    (tmpvar_27 * tmpvar_11)
  )) + ((tmpvar_29 * tmpvar_1) * (tmpvar_9.xyz + 
    ((1.0 - tmpvar_9.xyz) * ((x_30 * x_30) * ((x_30 * x_30) * x_30)))
  )));
  gl_FragData[0] = exp2(-(tmpvar_31));
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
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
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;
uniform vec4 _ZBufferParams;
uniform mat4 unity_World2Shadow[4];
uniform vec4 _LightShadowData;
uniform vec4 unity_ShadowFadeCenterAndType;
uniform vec4 unity_ColorSpaceLuminance;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _LightPos;
uniform vec4 _LightColor;
uniform mat4 _CameraToWorld;
uniform mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform sampler2DShadow _ShadowMapTexture;
uniform sampler2D _CameraGBufferTexture0;
uniform sampler2D _CameraGBufferTexture1;
uniform sampler2D _CameraGBufferTexture2;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec3 tmpvar_1;
  float atten_2;
  vec3 lightDir_3;
  vec2 tmpvar_4;
  tmpvar_4 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * (1.0/((
    (_ZBufferParams.x * texture2D (_CameraDepthTexture, tmpvar_4).x)
   + _ZBufferParams.y))));
  vec3 tmpvar_6;
  tmpvar_6 = (_CameraToWorld * tmpvar_5).xyz;
  vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 - unity_ShadowFadeCenterAndType.xyz);
  vec3 tmpvar_8;
  tmpvar_8 = (_LightPos.xyz - tmpvar_6);
  lightDir_3 = normalize(tmpvar_8);
  vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_6;
  vec4 tmpvar_10;
  tmpvar_10 = (_LightMatrix0 * tmpvar_9);
  vec4 tmpvar_11;
  tmpvar_11.zw = vec2(0.0, -8.0);
  tmpvar_11.xy = (tmpvar_10.xy / tmpvar_10.w);
  atten_2 = (texture2D (_LightTexture0, tmpvar_11.xy, -8.0).w * float((tmpvar_10.w < 0.0)));
  atten_2 = (atten_2 * texture2D (_LightTextureB0, vec2((dot (tmpvar_8, tmpvar_8) * _LightPos.w))).w);
  vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = tmpvar_6;
  atten_2 = (atten_2 * clamp ((
    (_LightShadowData.x + (shadow2DProj (_ShadowMapTexture, (unity_World2Shadow[0] * tmpvar_12)).x * (1.0 - _LightShadowData.x)))
   + 
    clamp (((mix (tmpvar_5.z, 
      sqrt(dot (tmpvar_7, tmpvar_7))
    , unity_ShadowFadeCenterAndType.w) * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0)
  ), 0.0, 1.0));
  vec4 tmpvar_13;
  tmpvar_13 = texture2D (_CameraGBufferTexture0, tmpvar_4);
  vec4 tmpvar_14;
  tmpvar_14 = texture2D (_CameraGBufferTexture1, tmpvar_4);
  tmpvar_1 = (_LightColor.xyz * atten_2);
  vec3 tmpvar_15;
  tmpvar_15 = normalize(((texture2D (_CameraGBufferTexture2, tmpvar_4).xyz * 2.0) - 1.0));
  float tmpvar_16;
  tmpvar_16 = max (0.0, dot (tmpvar_15, lightDir_3));
  vec3 viewDir_17;
  viewDir_17 = -(normalize((tmpvar_6 - _WorldSpaceCameraPos)));
  float specularTerm_18;
  float tmpvar_19;
  tmpvar_19 = (1.0 - tmpvar_14.w);
  vec3 tmpvar_20;
  vec3 inVec_21;
  inVec_21 = (lightDir_3 + viewDir_17);
  tmpvar_20 = (inVec_21 * inversesqrt(max (0.001, 
    dot (inVec_21, inVec_21)
  )));
  float tmpvar_22;
  tmpvar_22 = max (0.0, dot (tmpvar_15, tmpvar_20));
  float tmpvar_23;
  tmpvar_23 = max (0.0, dot (tmpvar_15, viewDir_17));
  float tmpvar_24;
  tmpvar_24 = max (0.0, dot (lightDir_3, tmpvar_20));
  float tmpvar_25;
  tmpvar_25 = (tmpvar_19 * tmpvar_19);
  float tmpvar_26;
  tmpvar_26 = (tmpvar_19 * tmpvar_19);
  float tmpvar_27;
  tmpvar_27 = (tmpvar_26 * tmpvar_26);
  float tmpvar_28;
  tmpvar_28 = (((tmpvar_22 * tmpvar_22) * (tmpvar_27 - 1.0)) + 1.0);
  float x_29;
  x_29 = (1.0 - tmpvar_16);
  float x_30;
  x_30 = (1.0 - tmpvar_23);
  float tmpvar_31;
  tmpvar_31 = (0.5 + ((2.0 * tmpvar_24) * (tmpvar_24 * tmpvar_19)));
  float tmpvar_32;
  tmpvar_32 = ((1.0 + (
    (tmpvar_31 - 1.0)
   * 
    ((x_29 * x_29) * ((x_29 * x_29) * x_29))
  )) * (1.0 + (
    (tmpvar_31 - 1.0)
   * 
    ((x_30 * x_30) * ((x_30 * x_30) * x_30))
  )));
  float tmpvar_33;
  tmpvar_33 = (((
    (2.0 * tmpvar_16)
   / 
    (((tmpvar_16 * (
      (tmpvar_23 * (1.0 - tmpvar_25))
     + tmpvar_25)) + (tmpvar_23 * (
      (tmpvar_16 * (1.0 - tmpvar_25))
     + tmpvar_25))) + 1e-05)
  ) * (tmpvar_27 / 
    ((3.141593 * tmpvar_28) * tmpvar_28)
  )) * 0.7853982);
  specularTerm_18 = tmpvar_33;
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    specularTerm_18 = sqrt(max (0.0001, tmpvar_33));
  };
  float tmpvar_34;
  tmpvar_34 = max (0.0, (specularTerm_18 * tmpvar_16));
  specularTerm_18 = tmpvar_34;
  float x_35;
  x_35 = (1.0 - tmpvar_24);
  vec4 tmpvar_36;
  tmpvar_36.w = 1.0;
  tmpvar_36.xyz = ((tmpvar_13.xyz * (tmpvar_1 * 
    (tmpvar_32 * tmpvar_16)
  )) + ((tmpvar_34 * tmpvar_1) * (tmpvar_14.xyz + 
    ((1.0 - tmpvar_14.xyz) * ((x_35 * x_35) * ((x_35 * x_35) * x_35)))
  )));
  gl_FragData[0] = exp2(-(tmpvar_36));
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
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
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;
uniform vec4 _ZBufferParams;
uniform vec4 _LightShadowData;
uniform vec4 unity_ShadowFadeCenterAndType;
uniform vec4 unity_ColorSpaceLuminance;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _LightDir;
uniform vec4 _LightColor;
uniform mat4 _CameraToWorld;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _CameraGBufferTexture0;
uniform sampler2D _CameraGBufferTexture1;
uniform sampler2D _CameraGBufferTexture2;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec3 tmpvar_1;
  vec3 lightDir_2;
  vec2 tmpvar_3;
  tmpvar_3 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * (1.0/((
    (_ZBufferParams.x * texture2D (_CameraDepthTexture, tmpvar_3).x)
   + _ZBufferParams.y))));
  vec3 tmpvar_5;
  tmpvar_5 = (_CameraToWorld * tmpvar_4).xyz;
  vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_5 - unity_ShadowFadeCenterAndType.xyz);
  lightDir_2 = -(_LightDir.xyz);
  vec4 tmpvar_7;
  tmpvar_7 = texture2D (_CameraGBufferTexture0, tmpvar_3);
  vec4 tmpvar_8;
  tmpvar_8 = texture2D (_CameraGBufferTexture1, tmpvar_3);
  tmpvar_1 = (_LightColor.xyz * clamp ((texture2D (_ShadowMapTexture, tmpvar_3).x + 
    clamp (((mix (tmpvar_4.z, 
      sqrt(dot (tmpvar_6, tmpvar_6))
    , unity_ShadowFadeCenterAndType.w) * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0)
  ), 0.0, 1.0));
  vec3 tmpvar_9;
  tmpvar_9 = normalize(((texture2D (_CameraGBufferTexture2, tmpvar_3).xyz * 2.0) - 1.0));
  float tmpvar_10;
  tmpvar_10 = max (0.0, dot (tmpvar_9, lightDir_2));
  vec3 viewDir_11;
  viewDir_11 = -(normalize((tmpvar_5 - _WorldSpaceCameraPos)));
  float specularTerm_12;
  float tmpvar_13;
  tmpvar_13 = (1.0 - tmpvar_8.w);
  vec3 tmpvar_14;
  vec3 inVec_15;
  inVec_15 = (lightDir_2 + viewDir_11);
  tmpvar_14 = (inVec_15 * inversesqrt(max (0.001, 
    dot (inVec_15, inVec_15)
  )));
  float tmpvar_16;
  tmpvar_16 = max (0.0, dot (tmpvar_9, tmpvar_14));
  float tmpvar_17;
  tmpvar_17 = max (0.0, dot (tmpvar_9, viewDir_11));
  float tmpvar_18;
  tmpvar_18 = max (0.0, dot (lightDir_2, tmpvar_14));
  float tmpvar_19;
  tmpvar_19 = (tmpvar_13 * tmpvar_13);
  float tmpvar_20;
  tmpvar_20 = (tmpvar_13 * tmpvar_13);
  float tmpvar_21;
  tmpvar_21 = (tmpvar_20 * tmpvar_20);
  float tmpvar_22;
  tmpvar_22 = (((tmpvar_16 * tmpvar_16) * (tmpvar_21 - 1.0)) + 1.0);
  float x_23;
  x_23 = (1.0 - tmpvar_10);
  float x_24;
  x_24 = (1.0 - tmpvar_17);
  float tmpvar_25;
  tmpvar_25 = (0.5 + ((2.0 * tmpvar_18) * (tmpvar_18 * tmpvar_13)));
  float tmpvar_26;
  tmpvar_26 = ((1.0 + (
    (tmpvar_25 - 1.0)
   * 
    ((x_23 * x_23) * ((x_23 * x_23) * x_23))
  )) * (1.0 + (
    (tmpvar_25 - 1.0)
   * 
    ((x_24 * x_24) * ((x_24 * x_24) * x_24))
  )));
  float tmpvar_27;
  tmpvar_27 = (((
    (2.0 * tmpvar_10)
   / 
    (((tmpvar_10 * (
      (tmpvar_17 * (1.0 - tmpvar_19))
     + tmpvar_19)) + (tmpvar_17 * (
      (tmpvar_10 * (1.0 - tmpvar_19))
     + tmpvar_19))) + 1e-05)
  ) * (tmpvar_21 / 
    ((3.141593 * tmpvar_22) * tmpvar_22)
  )) * 0.7853982);
  specularTerm_12 = tmpvar_27;
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    specularTerm_12 = sqrt(max (0.0001, tmpvar_27));
  };
  float tmpvar_28;
  tmpvar_28 = max (0.0, (specularTerm_12 * tmpvar_10));
  specularTerm_12 = tmpvar_28;
  float x_29;
  x_29 = (1.0 - tmpvar_18);
  vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = ((tmpvar_7.xyz * (tmpvar_1 * 
    (tmpvar_26 * tmpvar_10)
  )) + ((tmpvar_28 * tmpvar_1) * (tmpvar_8.xyz + 
    ((1.0 - tmpvar_8.xyz) * ((x_29 * x_29) * ((x_29 * x_29) * x_29)))
  )));
  gl_FragData[0] = exp2(-(tmpvar_30));
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
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
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;
uniform vec4 _ZBufferParams;
uniform vec4 _LightShadowData;
uniform vec4 unity_ShadowFadeCenterAndType;
uniform vec4 unity_ColorSpaceLuminance;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _LightDir;
uniform vec4 _LightColor;
uniform mat4 _CameraToWorld;
uniform mat4 _LightMatrix0;
uniform sampler2D _LightTexture0;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _CameraGBufferTexture0;
uniform sampler2D _CameraGBufferTexture1;
uniform sampler2D _CameraGBufferTexture2;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec3 tmpvar_1;
  float atten_2;
  vec3 lightDir_3;
  vec2 tmpvar_4;
  tmpvar_4 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * (1.0/((
    (_ZBufferParams.x * texture2D (_CameraDepthTexture, tmpvar_4).x)
   + _ZBufferParams.y))));
  vec3 tmpvar_6;
  tmpvar_6 = (_CameraToWorld * tmpvar_5).xyz;
  vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 - unity_ShadowFadeCenterAndType.xyz);
  lightDir_3 = -(_LightDir.xyz);
  atten_2 = clamp ((texture2D (_ShadowMapTexture, tmpvar_4).x + clamp (
    ((mix (tmpvar_5.z, sqrt(
      dot (tmpvar_7, tmpvar_7)
    ), unity_ShadowFadeCenterAndType.w) * _LightShadowData.z) + _LightShadowData.w)
  , 0.0, 1.0)), 0.0, 1.0);
  vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_6;
  vec4 tmpvar_9;
  tmpvar_9.zw = vec2(0.0, -8.0);
  tmpvar_9.xy = (_LightMatrix0 * tmpvar_8).xy;
  atten_2 = (atten_2 * texture2D (_LightTexture0, tmpvar_9.xy, -8.0).w);
  vec4 tmpvar_10;
  tmpvar_10 = texture2D (_CameraGBufferTexture0, tmpvar_4);
  vec4 tmpvar_11;
  tmpvar_11 = texture2D (_CameraGBufferTexture1, tmpvar_4);
  tmpvar_1 = (_LightColor.xyz * atten_2);
  vec3 tmpvar_12;
  tmpvar_12 = normalize(((texture2D (_CameraGBufferTexture2, tmpvar_4).xyz * 2.0) - 1.0));
  float tmpvar_13;
  tmpvar_13 = max (0.0, dot (tmpvar_12, lightDir_3));
  vec3 viewDir_14;
  viewDir_14 = -(normalize((tmpvar_6 - _WorldSpaceCameraPos)));
  float specularTerm_15;
  float tmpvar_16;
  tmpvar_16 = (1.0 - tmpvar_11.w);
  vec3 tmpvar_17;
  vec3 inVec_18;
  inVec_18 = (lightDir_3 + viewDir_14);
  tmpvar_17 = (inVec_18 * inversesqrt(max (0.001, 
    dot (inVec_18, inVec_18)
  )));
  float tmpvar_19;
  tmpvar_19 = max (0.0, dot (tmpvar_12, tmpvar_17));
  float tmpvar_20;
  tmpvar_20 = max (0.0, dot (tmpvar_12, viewDir_14));
  float tmpvar_21;
  tmpvar_21 = max (0.0, dot (lightDir_3, tmpvar_17));
  float tmpvar_22;
  tmpvar_22 = (tmpvar_16 * tmpvar_16);
  float tmpvar_23;
  tmpvar_23 = (tmpvar_16 * tmpvar_16);
  float tmpvar_24;
  tmpvar_24 = (tmpvar_23 * tmpvar_23);
  float tmpvar_25;
  tmpvar_25 = (((tmpvar_19 * tmpvar_19) * (tmpvar_24 - 1.0)) + 1.0);
  float x_26;
  x_26 = (1.0 - tmpvar_13);
  float x_27;
  x_27 = (1.0 - tmpvar_20);
  float tmpvar_28;
  tmpvar_28 = (0.5 + ((2.0 * tmpvar_21) * (tmpvar_21 * tmpvar_16)));
  float tmpvar_29;
  tmpvar_29 = ((1.0 + (
    (tmpvar_28 - 1.0)
   * 
    ((x_26 * x_26) * ((x_26 * x_26) * x_26))
  )) * (1.0 + (
    (tmpvar_28 - 1.0)
   * 
    ((x_27 * x_27) * ((x_27 * x_27) * x_27))
  )));
  float tmpvar_30;
  tmpvar_30 = (((
    (2.0 * tmpvar_13)
   / 
    (((tmpvar_13 * (
      (tmpvar_20 * (1.0 - tmpvar_22))
     + tmpvar_22)) + (tmpvar_20 * (
      (tmpvar_13 * (1.0 - tmpvar_22))
     + tmpvar_22))) + 1e-05)
  ) * (tmpvar_24 / 
    ((3.141593 * tmpvar_25) * tmpvar_25)
  )) * 0.7853982);
  specularTerm_15 = tmpvar_30;
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    specularTerm_15 = sqrt(max (0.0001, tmpvar_30));
  };
  float tmpvar_31;
  tmpvar_31 = max (0.0, (specularTerm_15 * tmpvar_13));
  specularTerm_15 = tmpvar_31;
  float x_32;
  x_32 = (1.0 - tmpvar_21);
  vec4 tmpvar_33;
  tmpvar_33.w = 1.0;
  tmpvar_33.xyz = ((tmpvar_10.xyz * (tmpvar_1 * 
    (tmpvar_29 * tmpvar_13)
  )) + ((tmpvar_31 * tmpvar_1) * (tmpvar_11.xyz + 
    ((1.0 - tmpvar_11.xyz) * ((x_32 * x_32) * ((x_32 * x_32) * x_32)))
  )));
  gl_FragData[0] = exp2(-(tmpvar_33));
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_CUBE" }
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
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;
uniform vec4 _ZBufferParams;
uniform vec4 _LightPositionRange;
uniform vec4 _LightShadowData;
uniform vec4 unity_ColorSpaceLuminance;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _LightPos;
uniform vec4 _LightColor;
uniform mat4 _CameraToWorld;
uniform sampler2D _LightTextureB0;
uniform samplerCube _ShadowMapTexture;
uniform sampler2D _CameraGBufferTexture0;
uniform sampler2D _CameraGBufferTexture1;
uniform sampler2D _CameraGBufferTexture2;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec3 tmpvar_1;
  float atten_2;
  vec3 lightDir_3;
  vec2 tmpvar_4;
  tmpvar_4 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * (1.0/((
    (_ZBufferParams.x * texture2D (_CameraDepthTexture, tmpvar_4).x)
   + _ZBufferParams.y))));
  vec3 tmpvar_6;
  tmpvar_6 = (_CameraToWorld * tmpvar_5).xyz;
  vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 - _LightPos.xyz);
  lightDir_3 = -(normalize(tmpvar_7));
  atten_2 = texture2D (_LightTextureB0, vec2((dot (tmpvar_7, tmpvar_7) * _LightPos.w))).w;
  float mydist_8;
  mydist_8 = ((sqrt(
    dot (tmpvar_7, tmpvar_7)
  ) * _LightPositionRange.w) * 0.97);
  vec4 tmpvar_9;
  tmpvar_9 = textureCube (_ShadowMapTexture, tmpvar_7);
  float tmpvar_10;
  if ((tmpvar_9.x < mydist_8)) {
    tmpvar_10 = _LightShadowData.x;
  } else {
    tmpvar_10 = 1.0;
  };
  atten_2 = (atten_2 * tmpvar_10);
  vec4 tmpvar_11;
  tmpvar_11 = texture2D (_CameraGBufferTexture0, tmpvar_4);
  vec4 tmpvar_12;
  tmpvar_12 = texture2D (_CameraGBufferTexture1, tmpvar_4);
  tmpvar_1 = (_LightColor.xyz * atten_2);
  vec3 tmpvar_13;
  tmpvar_13 = normalize(((texture2D (_CameraGBufferTexture2, tmpvar_4).xyz * 2.0) - 1.0));
  float tmpvar_14;
  tmpvar_14 = max (0.0, dot (tmpvar_13, lightDir_3));
  vec3 viewDir_15;
  viewDir_15 = -(normalize((tmpvar_6 - _WorldSpaceCameraPos)));
  float specularTerm_16;
  float tmpvar_17;
  tmpvar_17 = (1.0 - tmpvar_12.w);
  vec3 tmpvar_18;
  vec3 inVec_19;
  inVec_19 = (lightDir_3 + viewDir_15);
  tmpvar_18 = (inVec_19 * inversesqrt(max (0.001, 
    dot (inVec_19, inVec_19)
  )));
  float tmpvar_20;
  tmpvar_20 = max (0.0, dot (tmpvar_13, tmpvar_18));
  float tmpvar_21;
  tmpvar_21 = max (0.0, dot (tmpvar_13, viewDir_15));
  float tmpvar_22;
  tmpvar_22 = max (0.0, dot (lightDir_3, tmpvar_18));
  float tmpvar_23;
  tmpvar_23 = (tmpvar_17 * tmpvar_17);
  float tmpvar_24;
  tmpvar_24 = (tmpvar_17 * tmpvar_17);
  float tmpvar_25;
  tmpvar_25 = (tmpvar_24 * tmpvar_24);
  float tmpvar_26;
  tmpvar_26 = (((tmpvar_20 * tmpvar_20) * (tmpvar_25 - 1.0)) + 1.0);
  float x_27;
  x_27 = (1.0 - tmpvar_14);
  float x_28;
  x_28 = (1.0 - tmpvar_21);
  float tmpvar_29;
  tmpvar_29 = (0.5 + ((2.0 * tmpvar_22) * (tmpvar_22 * tmpvar_17)));
  float tmpvar_30;
  tmpvar_30 = ((1.0 + (
    (tmpvar_29 - 1.0)
   * 
    ((x_27 * x_27) * ((x_27 * x_27) * x_27))
  )) * (1.0 + (
    (tmpvar_29 - 1.0)
   * 
    ((x_28 * x_28) * ((x_28 * x_28) * x_28))
  )));
  float tmpvar_31;
  tmpvar_31 = (((
    (2.0 * tmpvar_14)
   / 
    (((tmpvar_14 * (
      (tmpvar_21 * (1.0 - tmpvar_23))
     + tmpvar_23)) + (tmpvar_21 * (
      (tmpvar_14 * (1.0 - tmpvar_23))
     + tmpvar_23))) + 1e-05)
  ) * (tmpvar_25 / 
    ((3.141593 * tmpvar_26) * tmpvar_26)
  )) * 0.7853982);
  specularTerm_16 = tmpvar_31;
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    specularTerm_16 = sqrt(max (0.0001, tmpvar_31));
  };
  float tmpvar_32;
  tmpvar_32 = max (0.0, (specularTerm_16 * tmpvar_14));
  specularTerm_16 = tmpvar_32;
  float x_33;
  x_33 = (1.0 - tmpvar_22);
  vec4 tmpvar_34;
  tmpvar_34.w = 1.0;
  tmpvar_34.xyz = ((tmpvar_11.xyz * (tmpvar_1 * 
    (tmpvar_30 * tmpvar_14)
  )) + ((tmpvar_32 * tmpvar_1) * (tmpvar_12.xyz + 
    ((1.0 - tmpvar_12.xyz) * ((x_33 * x_33) * ((x_33 * x_33) * x_33)))
  )));
  gl_FragData[0] = exp2(-(tmpvar_34));
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_CUBE" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "POINT" "SHADOWS_CUBE" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
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
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;
uniform vec4 _ZBufferParams;
uniform vec4 _LightPositionRange;
uniform vec4 _LightShadowData;
uniform vec4 unity_ColorSpaceLuminance;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _LightPos;
uniform vec4 _LightColor;
uniform mat4 _CameraToWorld;
uniform mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
uniform samplerCube _ShadowMapTexture;
uniform sampler2D _CameraGBufferTexture0;
uniform sampler2D _CameraGBufferTexture1;
uniform sampler2D _CameraGBufferTexture2;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec3 tmpvar_1;
  float atten_2;
  vec3 lightDir_3;
  vec2 tmpvar_4;
  tmpvar_4 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * (1.0/((
    (_ZBufferParams.x * texture2D (_CameraDepthTexture, tmpvar_4).x)
   + _ZBufferParams.y))));
  vec3 tmpvar_6;
  tmpvar_6 = (_CameraToWorld * tmpvar_5).xyz;
  vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 - _LightPos.xyz);
  lightDir_3 = -(normalize(tmpvar_7));
  atten_2 = texture2D (_LightTextureB0, vec2((dot (tmpvar_7, tmpvar_7) * _LightPos.w))).w;
  float mydist_8;
  mydist_8 = ((sqrt(
    dot (tmpvar_7, tmpvar_7)
  ) * _LightPositionRange.w) * 0.97);
  vec4 tmpvar_9;
  tmpvar_9 = textureCube (_ShadowMapTexture, tmpvar_7);
  float tmpvar_10;
  if ((tmpvar_9.x < mydist_8)) {
    tmpvar_10 = _LightShadowData.x;
  } else {
    tmpvar_10 = 1.0;
  };
  atten_2 = (atten_2 * tmpvar_10);
  vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_6;
  vec4 tmpvar_12;
  tmpvar_12.w = -8.0;
  tmpvar_12.xyz = (_LightMatrix0 * tmpvar_11).xyz;
  atten_2 = (atten_2 * textureCube (_LightTexture0, tmpvar_12.xyz, -8.0).w);
  vec4 tmpvar_13;
  tmpvar_13 = texture2D (_CameraGBufferTexture0, tmpvar_4);
  vec4 tmpvar_14;
  tmpvar_14 = texture2D (_CameraGBufferTexture1, tmpvar_4);
  tmpvar_1 = (_LightColor.xyz * atten_2);
  vec3 tmpvar_15;
  tmpvar_15 = normalize(((texture2D (_CameraGBufferTexture2, tmpvar_4).xyz * 2.0) - 1.0));
  float tmpvar_16;
  tmpvar_16 = max (0.0, dot (tmpvar_15, lightDir_3));
  vec3 viewDir_17;
  viewDir_17 = -(normalize((tmpvar_6 - _WorldSpaceCameraPos)));
  float specularTerm_18;
  float tmpvar_19;
  tmpvar_19 = (1.0 - tmpvar_14.w);
  vec3 tmpvar_20;
  vec3 inVec_21;
  inVec_21 = (lightDir_3 + viewDir_17);
  tmpvar_20 = (inVec_21 * inversesqrt(max (0.001, 
    dot (inVec_21, inVec_21)
  )));
  float tmpvar_22;
  tmpvar_22 = max (0.0, dot (tmpvar_15, tmpvar_20));
  float tmpvar_23;
  tmpvar_23 = max (0.0, dot (tmpvar_15, viewDir_17));
  float tmpvar_24;
  tmpvar_24 = max (0.0, dot (lightDir_3, tmpvar_20));
  float tmpvar_25;
  tmpvar_25 = (tmpvar_19 * tmpvar_19);
  float tmpvar_26;
  tmpvar_26 = (tmpvar_19 * tmpvar_19);
  float tmpvar_27;
  tmpvar_27 = (tmpvar_26 * tmpvar_26);
  float tmpvar_28;
  tmpvar_28 = (((tmpvar_22 * tmpvar_22) * (tmpvar_27 - 1.0)) + 1.0);
  float x_29;
  x_29 = (1.0 - tmpvar_16);
  float x_30;
  x_30 = (1.0 - tmpvar_23);
  float tmpvar_31;
  tmpvar_31 = (0.5 + ((2.0 * tmpvar_24) * (tmpvar_24 * tmpvar_19)));
  float tmpvar_32;
  tmpvar_32 = ((1.0 + (
    (tmpvar_31 - 1.0)
   * 
    ((x_29 * x_29) * ((x_29 * x_29) * x_29))
  )) * (1.0 + (
    (tmpvar_31 - 1.0)
   * 
    ((x_30 * x_30) * ((x_30 * x_30) * x_30))
  )));
  float tmpvar_33;
  tmpvar_33 = (((
    (2.0 * tmpvar_16)
   / 
    (((tmpvar_16 * (
      (tmpvar_23 * (1.0 - tmpvar_25))
     + tmpvar_25)) + (tmpvar_23 * (
      (tmpvar_16 * (1.0 - tmpvar_25))
     + tmpvar_25))) + 1e-05)
  ) * (tmpvar_27 / 
    ((3.141593 * tmpvar_28) * tmpvar_28)
  )) * 0.7853982);
  specularTerm_18 = tmpvar_33;
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    specularTerm_18 = sqrt(max (0.0001, tmpvar_33));
  };
  float tmpvar_34;
  tmpvar_34 = max (0.0, (specularTerm_18 * tmpvar_16));
  specularTerm_18 = tmpvar_34;
  float x_35;
  x_35 = (1.0 - tmpvar_24);
  vec4 tmpvar_36;
  tmpvar_36.w = 1.0;
  tmpvar_36.xyz = ((tmpvar_13.xyz * (tmpvar_1 * 
    (tmpvar_32 * tmpvar_16)
  )) + ((tmpvar_34 * tmpvar_1) * (tmpvar_14.xyz + 
    ((1.0 - tmpvar_14.xyz) * ((x_35 * x_35) * ((x_35 * x_35) * x_35)))
  )));
  gl_FragData[0] = exp2(-(tmpvar_36));
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
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
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;
uniform vec4 _ZBufferParams;
uniform mat4 unity_World2Shadow[4];
uniform vec4 _LightShadowData;
uniform vec4 unity_ShadowFadeCenterAndType;
uniform vec4 unity_ColorSpaceLuminance;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _LightPos;
uniform vec4 _LightColor;
uniform mat4 _CameraToWorld;
uniform mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform sampler2DShadow _ShadowMapTexture;
uniform vec4 _ShadowOffsets[4];
uniform sampler2D _CameraGBufferTexture0;
uniform sampler2D _CameraGBufferTexture1;
uniform sampler2D _CameraGBufferTexture2;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec3 tmpvar_1;
  float atten_2;
  vec3 lightDir_3;
  vec2 tmpvar_4;
  tmpvar_4 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * (1.0/((
    (_ZBufferParams.x * texture2D (_CameraDepthTexture, tmpvar_4).x)
   + _ZBufferParams.y))));
  vec3 tmpvar_6;
  tmpvar_6 = (_CameraToWorld * tmpvar_5).xyz;
  vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 - unity_ShadowFadeCenterAndType.xyz);
  vec3 tmpvar_8;
  tmpvar_8 = (_LightPos.xyz - tmpvar_6);
  lightDir_3 = normalize(tmpvar_8);
  vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_6;
  vec4 tmpvar_10;
  tmpvar_10 = (_LightMatrix0 * tmpvar_9);
  vec4 tmpvar_11;
  tmpvar_11.zw = vec2(0.0, -8.0);
  tmpvar_11.xy = (tmpvar_10.xy / tmpvar_10.w);
  atten_2 = (texture2D (_LightTexture0, tmpvar_11.xy, -8.0).w * float((tmpvar_10.w < 0.0)));
  atten_2 = (atten_2 * texture2D (_LightTextureB0, vec2((dot (tmpvar_8, tmpvar_8) * _LightPos.w))).w);
  vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = tmpvar_6;
  vec4 tmpvar_13;
  tmpvar_13 = (unity_World2Shadow[0] * tmpvar_12);
  vec4 shadows_14;
  vec3 tmpvar_15;
  tmpvar_15 = (tmpvar_13.xyz / tmpvar_13.w);
  shadows_14.x = shadow2D (_ShadowMapTexture, (tmpvar_15 + _ShadowOffsets[0].xyz)).x;
  shadows_14.y = shadow2D (_ShadowMapTexture, (tmpvar_15 + _ShadowOffsets[1].xyz)).x;
  shadows_14.z = shadow2D (_ShadowMapTexture, (tmpvar_15 + _ShadowOffsets[2].xyz)).x;
  shadows_14.w = shadow2D (_ShadowMapTexture, (tmpvar_15 + _ShadowOffsets[3].xyz)).x;
  shadows_14 = (_LightShadowData.xxxx + (shadows_14 * (1.0 - _LightShadowData.xxxx)));
  atten_2 = (atten_2 * clamp ((
    dot (shadows_14, vec4(0.25, 0.25, 0.25, 0.25))
   + 
    clamp (((mix (tmpvar_5.z, 
      sqrt(dot (tmpvar_7, tmpvar_7))
    , unity_ShadowFadeCenterAndType.w) * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0)
  ), 0.0, 1.0));
  vec4 tmpvar_16;
  tmpvar_16 = texture2D (_CameraGBufferTexture0, tmpvar_4);
  vec4 tmpvar_17;
  tmpvar_17 = texture2D (_CameraGBufferTexture1, tmpvar_4);
  tmpvar_1 = (_LightColor.xyz * atten_2);
  vec3 tmpvar_18;
  tmpvar_18 = normalize(((texture2D (_CameraGBufferTexture2, tmpvar_4).xyz * 2.0) - 1.0));
  float tmpvar_19;
  tmpvar_19 = max (0.0, dot (tmpvar_18, lightDir_3));
  vec3 viewDir_20;
  viewDir_20 = -(normalize((tmpvar_6 - _WorldSpaceCameraPos)));
  float specularTerm_21;
  float tmpvar_22;
  tmpvar_22 = (1.0 - tmpvar_17.w);
  vec3 tmpvar_23;
  vec3 inVec_24;
  inVec_24 = (lightDir_3 + viewDir_20);
  tmpvar_23 = (inVec_24 * inversesqrt(max (0.001, 
    dot (inVec_24, inVec_24)
  )));
  float tmpvar_25;
  tmpvar_25 = max (0.0, dot (tmpvar_18, tmpvar_23));
  float tmpvar_26;
  tmpvar_26 = max (0.0, dot (tmpvar_18, viewDir_20));
  float tmpvar_27;
  tmpvar_27 = max (0.0, dot (lightDir_3, tmpvar_23));
  float tmpvar_28;
  tmpvar_28 = (tmpvar_22 * tmpvar_22);
  float tmpvar_29;
  tmpvar_29 = (tmpvar_22 * tmpvar_22);
  float tmpvar_30;
  tmpvar_30 = (tmpvar_29 * tmpvar_29);
  float tmpvar_31;
  tmpvar_31 = (((tmpvar_25 * tmpvar_25) * (tmpvar_30 - 1.0)) + 1.0);
  float x_32;
  x_32 = (1.0 - tmpvar_19);
  float x_33;
  x_33 = (1.0 - tmpvar_26);
  float tmpvar_34;
  tmpvar_34 = (0.5 + ((2.0 * tmpvar_27) * (tmpvar_27 * tmpvar_22)));
  float tmpvar_35;
  tmpvar_35 = ((1.0 + (
    (tmpvar_34 - 1.0)
   * 
    ((x_32 * x_32) * ((x_32 * x_32) * x_32))
  )) * (1.0 + (
    (tmpvar_34 - 1.0)
   * 
    ((x_33 * x_33) * ((x_33 * x_33) * x_33))
  )));
  float tmpvar_36;
  tmpvar_36 = (((
    (2.0 * tmpvar_19)
   / 
    (((tmpvar_19 * (
      (tmpvar_26 * (1.0 - tmpvar_28))
     + tmpvar_28)) + (tmpvar_26 * (
      (tmpvar_19 * (1.0 - tmpvar_28))
     + tmpvar_28))) + 1e-05)
  ) * (tmpvar_30 / 
    ((3.141593 * tmpvar_31) * tmpvar_31)
  )) * 0.7853982);
  specularTerm_21 = tmpvar_36;
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    specularTerm_21 = sqrt(max (0.0001, tmpvar_36));
  };
  float tmpvar_37;
  tmpvar_37 = max (0.0, (specularTerm_21 * tmpvar_19));
  specularTerm_21 = tmpvar_37;
  float x_38;
  x_38 = (1.0 - tmpvar_27);
  vec4 tmpvar_39;
  tmpvar_39.w = 1.0;
  tmpvar_39.xyz = ((tmpvar_16.xyz * (tmpvar_1 * 
    (tmpvar_35 * tmpvar_19)
  )) + ((tmpvar_37 * tmpvar_1) * (tmpvar_17.xyz + 
    ((1.0 - tmpvar_17.xyz) * ((x_38 * x_38) * ((x_38 * x_38) * x_38)))
  )));
  gl_FragData[0] = exp2(-(tmpvar_39));
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
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
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;
uniform vec4 _ZBufferParams;
uniform vec4 _LightPositionRange;
uniform vec4 _LightShadowData;
uniform vec4 unity_ColorSpaceLuminance;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _LightPos;
uniform vec4 _LightColor;
uniform mat4 _CameraToWorld;
uniform sampler2D _LightTextureB0;
uniform samplerCube _ShadowMapTexture;
uniform sampler2D _CameraGBufferTexture0;
uniform sampler2D _CameraGBufferTexture1;
uniform sampler2D _CameraGBufferTexture2;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec3 tmpvar_1;
  float atten_2;
  vec3 lightDir_3;
  vec2 tmpvar_4;
  tmpvar_4 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * (1.0/((
    (_ZBufferParams.x * texture2D (_CameraDepthTexture, tmpvar_4).x)
   + _ZBufferParams.y))));
  vec3 tmpvar_6;
  tmpvar_6 = (_CameraToWorld * tmpvar_5).xyz;
  vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 - _LightPos.xyz);
  lightDir_3 = -(normalize(tmpvar_7));
  atten_2 = texture2D (_LightTextureB0, vec2((dot (tmpvar_7, tmpvar_7) * _LightPos.w))).w;
  vec4 shadowVals_8;
  shadowVals_8.x = textureCube (_ShadowMapTexture, (tmpvar_7 + vec3(0.0078125, 0.0078125, 0.0078125))).x;
  shadowVals_8.y = textureCube (_ShadowMapTexture, (tmpvar_7 + vec3(-0.0078125, -0.0078125, 0.0078125))).x;
  shadowVals_8.z = textureCube (_ShadowMapTexture, (tmpvar_7 + vec3(-0.0078125, 0.0078125, -0.0078125))).x;
  shadowVals_8.w = textureCube (_ShadowMapTexture, (tmpvar_7 + vec3(0.0078125, -0.0078125, -0.0078125))).x;
  bvec4 tmpvar_9;
  tmpvar_9 = lessThan (shadowVals_8, vec4(((
    sqrt(dot (tmpvar_7, tmpvar_7))
   * _LightPositionRange.w) * 0.97)));
  vec4 tmpvar_10;
  tmpvar_10 = _LightShadowData.xxxx;
  float tmpvar_11;
  if (tmpvar_9.x) {
    tmpvar_11 = tmpvar_10.x;
  } else {
    tmpvar_11 = 1.0;
  };
  float tmpvar_12;
  if (tmpvar_9.y) {
    tmpvar_12 = tmpvar_10.y;
  } else {
    tmpvar_12 = 1.0;
  };
  float tmpvar_13;
  if (tmpvar_9.z) {
    tmpvar_13 = tmpvar_10.z;
  } else {
    tmpvar_13 = 1.0;
  };
  float tmpvar_14;
  if (tmpvar_9.w) {
    tmpvar_14 = tmpvar_10.w;
  } else {
    tmpvar_14 = 1.0;
  };
  vec4 tmpvar_15;
  tmpvar_15.x = tmpvar_11;
  tmpvar_15.y = tmpvar_12;
  tmpvar_15.z = tmpvar_13;
  tmpvar_15.w = tmpvar_14;
  atten_2 = (atten_2 * dot (tmpvar_15, vec4(0.25, 0.25, 0.25, 0.25)));
  vec4 tmpvar_16;
  tmpvar_16 = texture2D (_CameraGBufferTexture0, tmpvar_4);
  vec4 tmpvar_17;
  tmpvar_17 = texture2D (_CameraGBufferTexture1, tmpvar_4);
  tmpvar_1 = (_LightColor.xyz * atten_2);
  vec3 tmpvar_18;
  tmpvar_18 = normalize(((texture2D (_CameraGBufferTexture2, tmpvar_4).xyz * 2.0) - 1.0));
  float tmpvar_19;
  tmpvar_19 = max (0.0, dot (tmpvar_18, lightDir_3));
  vec3 viewDir_20;
  viewDir_20 = -(normalize((tmpvar_6 - _WorldSpaceCameraPos)));
  float specularTerm_21;
  float tmpvar_22;
  tmpvar_22 = (1.0 - tmpvar_17.w);
  vec3 tmpvar_23;
  vec3 inVec_24;
  inVec_24 = (lightDir_3 + viewDir_20);
  tmpvar_23 = (inVec_24 * inversesqrt(max (0.001, 
    dot (inVec_24, inVec_24)
  )));
  float tmpvar_25;
  tmpvar_25 = max (0.0, dot (tmpvar_18, tmpvar_23));
  float tmpvar_26;
  tmpvar_26 = max (0.0, dot (tmpvar_18, viewDir_20));
  float tmpvar_27;
  tmpvar_27 = max (0.0, dot (lightDir_3, tmpvar_23));
  float tmpvar_28;
  tmpvar_28 = (tmpvar_22 * tmpvar_22);
  float tmpvar_29;
  tmpvar_29 = (tmpvar_22 * tmpvar_22);
  float tmpvar_30;
  tmpvar_30 = (tmpvar_29 * tmpvar_29);
  float tmpvar_31;
  tmpvar_31 = (((tmpvar_25 * tmpvar_25) * (tmpvar_30 - 1.0)) + 1.0);
  float x_32;
  x_32 = (1.0 - tmpvar_19);
  float x_33;
  x_33 = (1.0 - tmpvar_26);
  float tmpvar_34;
  tmpvar_34 = (0.5 + ((2.0 * tmpvar_27) * (tmpvar_27 * tmpvar_22)));
  float tmpvar_35;
  tmpvar_35 = ((1.0 + (
    (tmpvar_34 - 1.0)
   * 
    ((x_32 * x_32) * ((x_32 * x_32) * x_32))
  )) * (1.0 + (
    (tmpvar_34 - 1.0)
   * 
    ((x_33 * x_33) * ((x_33 * x_33) * x_33))
  )));
  float tmpvar_36;
  tmpvar_36 = (((
    (2.0 * tmpvar_19)
   / 
    (((tmpvar_19 * (
      (tmpvar_26 * (1.0 - tmpvar_28))
     + tmpvar_28)) + (tmpvar_26 * (
      (tmpvar_19 * (1.0 - tmpvar_28))
     + tmpvar_28))) + 1e-05)
  ) * (tmpvar_30 / 
    ((3.141593 * tmpvar_31) * tmpvar_31)
  )) * 0.7853982);
  specularTerm_21 = tmpvar_36;
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    specularTerm_21 = sqrt(max (0.0001, tmpvar_36));
  };
  float tmpvar_37;
  tmpvar_37 = max (0.0, (specularTerm_21 * tmpvar_19));
  specularTerm_21 = tmpvar_37;
  float x_38;
  x_38 = (1.0 - tmpvar_27);
  vec4 tmpvar_39;
  tmpvar_39.w = 1.0;
  tmpvar_39.xyz = ((tmpvar_16.xyz * (tmpvar_1 * 
    (tmpvar_35 * tmpvar_19)
  )) + ((tmpvar_37 * tmpvar_1) * (tmpvar_17.xyz + 
    ((1.0 - tmpvar_17.xyz) * ((x_38 * x_38) * ((x_38 * x_38) * x_38)))
  )));
  gl_FragData[0] = exp2(-(tmpvar_39));
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
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
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;
uniform vec4 _ZBufferParams;
uniform vec4 _LightPositionRange;
uniform vec4 _LightShadowData;
uniform vec4 unity_ColorSpaceLuminance;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _LightPos;
uniform vec4 _LightColor;
uniform mat4 _CameraToWorld;
uniform mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
uniform samplerCube _ShadowMapTexture;
uniform sampler2D _CameraGBufferTexture0;
uniform sampler2D _CameraGBufferTexture1;
uniform sampler2D _CameraGBufferTexture2;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec3 tmpvar_1;
  float atten_2;
  vec3 lightDir_3;
  vec2 tmpvar_4;
  tmpvar_4 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * (1.0/((
    (_ZBufferParams.x * texture2D (_CameraDepthTexture, tmpvar_4).x)
   + _ZBufferParams.y))));
  vec3 tmpvar_6;
  tmpvar_6 = (_CameraToWorld * tmpvar_5).xyz;
  vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 - _LightPos.xyz);
  lightDir_3 = -(normalize(tmpvar_7));
  atten_2 = texture2D (_LightTextureB0, vec2((dot (tmpvar_7, tmpvar_7) * _LightPos.w))).w;
  vec4 shadowVals_8;
  shadowVals_8.x = textureCube (_ShadowMapTexture, (tmpvar_7 + vec3(0.0078125, 0.0078125, 0.0078125))).x;
  shadowVals_8.y = textureCube (_ShadowMapTexture, (tmpvar_7 + vec3(-0.0078125, -0.0078125, 0.0078125))).x;
  shadowVals_8.z = textureCube (_ShadowMapTexture, (tmpvar_7 + vec3(-0.0078125, 0.0078125, -0.0078125))).x;
  shadowVals_8.w = textureCube (_ShadowMapTexture, (tmpvar_7 + vec3(0.0078125, -0.0078125, -0.0078125))).x;
  bvec4 tmpvar_9;
  tmpvar_9 = lessThan (shadowVals_8, vec4(((
    sqrt(dot (tmpvar_7, tmpvar_7))
   * _LightPositionRange.w) * 0.97)));
  vec4 tmpvar_10;
  tmpvar_10 = _LightShadowData.xxxx;
  float tmpvar_11;
  if (tmpvar_9.x) {
    tmpvar_11 = tmpvar_10.x;
  } else {
    tmpvar_11 = 1.0;
  };
  float tmpvar_12;
  if (tmpvar_9.y) {
    tmpvar_12 = tmpvar_10.y;
  } else {
    tmpvar_12 = 1.0;
  };
  float tmpvar_13;
  if (tmpvar_9.z) {
    tmpvar_13 = tmpvar_10.z;
  } else {
    tmpvar_13 = 1.0;
  };
  float tmpvar_14;
  if (tmpvar_9.w) {
    tmpvar_14 = tmpvar_10.w;
  } else {
    tmpvar_14 = 1.0;
  };
  vec4 tmpvar_15;
  tmpvar_15.x = tmpvar_11;
  tmpvar_15.y = tmpvar_12;
  tmpvar_15.z = tmpvar_13;
  tmpvar_15.w = tmpvar_14;
  atten_2 = (atten_2 * dot (tmpvar_15, vec4(0.25, 0.25, 0.25, 0.25)));
  vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_6;
  vec4 tmpvar_17;
  tmpvar_17.w = -8.0;
  tmpvar_17.xyz = (_LightMatrix0 * tmpvar_16).xyz;
  atten_2 = (atten_2 * textureCube (_LightTexture0, tmpvar_17.xyz, -8.0).w);
  vec4 tmpvar_18;
  tmpvar_18 = texture2D (_CameraGBufferTexture0, tmpvar_4);
  vec4 tmpvar_19;
  tmpvar_19 = texture2D (_CameraGBufferTexture1, tmpvar_4);
  tmpvar_1 = (_LightColor.xyz * atten_2);
  vec3 tmpvar_20;
  tmpvar_20 = normalize(((texture2D (_CameraGBufferTexture2, tmpvar_4).xyz * 2.0) - 1.0));
  float tmpvar_21;
  tmpvar_21 = max (0.0, dot (tmpvar_20, lightDir_3));
  vec3 viewDir_22;
  viewDir_22 = -(normalize((tmpvar_6 - _WorldSpaceCameraPos)));
  float specularTerm_23;
  float tmpvar_24;
  tmpvar_24 = (1.0 - tmpvar_19.w);
  vec3 tmpvar_25;
  vec3 inVec_26;
  inVec_26 = (lightDir_3 + viewDir_22);
  tmpvar_25 = (inVec_26 * inversesqrt(max (0.001, 
    dot (inVec_26, inVec_26)
  )));
  float tmpvar_27;
  tmpvar_27 = max (0.0, dot (tmpvar_20, tmpvar_25));
  float tmpvar_28;
  tmpvar_28 = max (0.0, dot (tmpvar_20, viewDir_22));
  float tmpvar_29;
  tmpvar_29 = max (0.0, dot (lightDir_3, tmpvar_25));
  float tmpvar_30;
  tmpvar_30 = (tmpvar_24 * tmpvar_24);
  float tmpvar_31;
  tmpvar_31 = (tmpvar_24 * tmpvar_24);
  float tmpvar_32;
  tmpvar_32 = (tmpvar_31 * tmpvar_31);
  float tmpvar_33;
  tmpvar_33 = (((tmpvar_27 * tmpvar_27) * (tmpvar_32 - 1.0)) + 1.0);
  float x_34;
  x_34 = (1.0 - tmpvar_21);
  float x_35;
  x_35 = (1.0 - tmpvar_28);
  float tmpvar_36;
  tmpvar_36 = (0.5 + ((2.0 * tmpvar_29) * (tmpvar_29 * tmpvar_24)));
  float tmpvar_37;
  tmpvar_37 = ((1.0 + (
    (tmpvar_36 - 1.0)
   * 
    ((x_34 * x_34) * ((x_34 * x_34) * x_34))
  )) * (1.0 + (
    (tmpvar_36 - 1.0)
   * 
    ((x_35 * x_35) * ((x_35 * x_35) * x_35))
  )));
  float tmpvar_38;
  tmpvar_38 = (((
    (2.0 * tmpvar_21)
   / 
    (((tmpvar_21 * (
      (tmpvar_28 * (1.0 - tmpvar_30))
     + tmpvar_30)) + (tmpvar_28 * (
      (tmpvar_21 * (1.0 - tmpvar_30))
     + tmpvar_30))) + 1e-05)
  ) * (tmpvar_32 / 
    ((3.141593 * tmpvar_33) * tmpvar_33)
  )) * 0.7853982);
  specularTerm_23 = tmpvar_38;
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    specularTerm_23 = sqrt(max (0.0001, tmpvar_38));
  };
  float tmpvar_39;
  tmpvar_39 = max (0.0, (specularTerm_23 * tmpvar_21));
  specularTerm_23 = tmpvar_39;
  float x_40;
  x_40 = (1.0 - tmpvar_29);
  vec4 tmpvar_41;
  tmpvar_41.w = 1.0;
  tmpvar_41.xyz = ((tmpvar_18.xyz * (tmpvar_1 * 
    (tmpvar_37 * tmpvar_21)
  )) + ((tmpvar_39 * tmpvar_1) * (tmpvar_19.xyz + 
    ((1.0 - tmpvar_19.xyz) * ((x_40 * x_40) * ((x_40 * x_40) * x_40)))
  )));
  gl_FragData[0] = exp2(-(tmpvar_41));
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_OFF" "UNITY_HDR_ON" }
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
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;
uniform vec4 _ZBufferParams;
uniform vec4 unity_ColorSpaceLuminance;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _LightPos;
uniform vec4 _LightColor;
uniform mat4 _CameraToWorld;
uniform sampler2D _LightTextureB0;
uniform sampler2D _CameraGBufferTexture0;
uniform sampler2D _CameraGBufferTexture1;
uniform sampler2D _CameraGBufferTexture2;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec3 tmpvar_1;
  vec2 tmpvar_2;
  tmpvar_2 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * (1.0/((
    (_ZBufferParams.x * texture2D (_CameraDepthTexture, tmpvar_2).x)
   + _ZBufferParams.y))));
  vec3 tmpvar_4;
  tmpvar_4 = (_CameraToWorld * tmpvar_3).xyz;
  vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 - _LightPos.xyz);
  vec3 tmpvar_6;
  tmpvar_6 = -(normalize(tmpvar_5));
  vec4 tmpvar_7;
  tmpvar_7 = texture2D (_CameraGBufferTexture0, tmpvar_2);
  vec4 tmpvar_8;
  tmpvar_8 = texture2D (_CameraGBufferTexture1, tmpvar_2);
  tmpvar_1 = (_LightColor.xyz * texture2D (_LightTextureB0, vec2((dot (tmpvar_5, tmpvar_5) * _LightPos.w))).w);
  vec3 tmpvar_9;
  tmpvar_9 = normalize(((texture2D (_CameraGBufferTexture2, tmpvar_2).xyz * 2.0) - 1.0));
  float tmpvar_10;
  tmpvar_10 = max (0.0, dot (tmpvar_9, tmpvar_6));
  vec3 viewDir_11;
  viewDir_11 = -(normalize((tmpvar_4 - _WorldSpaceCameraPos)));
  float specularTerm_12;
  float tmpvar_13;
  tmpvar_13 = (1.0 - tmpvar_8.w);
  vec3 tmpvar_14;
  vec3 inVec_15;
  inVec_15 = (tmpvar_6 + viewDir_11);
  tmpvar_14 = (inVec_15 * inversesqrt(max (0.001, 
    dot (inVec_15, inVec_15)
  )));
  float tmpvar_16;
  tmpvar_16 = max (0.0, dot (tmpvar_9, tmpvar_14));
  float tmpvar_17;
  tmpvar_17 = max (0.0, dot (tmpvar_9, viewDir_11));
  float tmpvar_18;
  tmpvar_18 = max (0.0, dot (tmpvar_6, tmpvar_14));
  float tmpvar_19;
  tmpvar_19 = (tmpvar_13 * tmpvar_13);
  float tmpvar_20;
  tmpvar_20 = (tmpvar_13 * tmpvar_13);
  float tmpvar_21;
  tmpvar_21 = (tmpvar_20 * tmpvar_20);
  float tmpvar_22;
  tmpvar_22 = (((tmpvar_16 * tmpvar_16) * (tmpvar_21 - 1.0)) + 1.0);
  float x_23;
  x_23 = (1.0 - tmpvar_10);
  float x_24;
  x_24 = (1.0 - tmpvar_17);
  float tmpvar_25;
  tmpvar_25 = (0.5 + ((2.0 * tmpvar_18) * (tmpvar_18 * tmpvar_13)));
  float tmpvar_26;
  tmpvar_26 = ((1.0 + (
    (tmpvar_25 - 1.0)
   * 
    ((x_23 * x_23) * ((x_23 * x_23) * x_23))
  )) * (1.0 + (
    (tmpvar_25 - 1.0)
   * 
    ((x_24 * x_24) * ((x_24 * x_24) * x_24))
  )));
  float tmpvar_27;
  tmpvar_27 = (((
    (2.0 * tmpvar_10)
   / 
    (((tmpvar_10 * (
      (tmpvar_17 * (1.0 - tmpvar_19))
     + tmpvar_19)) + (tmpvar_17 * (
      (tmpvar_10 * (1.0 - tmpvar_19))
     + tmpvar_19))) + 1e-05)
  ) * (tmpvar_21 / 
    ((3.141593 * tmpvar_22) * tmpvar_22)
  )) * 0.7853982);
  specularTerm_12 = tmpvar_27;
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    specularTerm_12 = sqrt(max (0.0001, tmpvar_27));
  };
  float tmpvar_28;
  tmpvar_28 = max (0.0, (specularTerm_12 * tmpvar_10));
  specularTerm_12 = tmpvar_28;
  float x_29;
  x_29 = (1.0 - tmpvar_18);
  vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = ((tmpvar_7.xyz * (tmpvar_1 * 
    (tmpvar_26 * tmpvar_10)
  )) + ((tmpvar_28 * tmpvar_1) * (tmpvar_8.xyz + 
    ((1.0 - tmpvar_8.xyz) * ((x_29 * x_29) * ((x_29 * x_29) * x_29)))
  )));
  gl_FragData[0] = tmpvar_30;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_OFF" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "POINT" "SHADOWS_OFF" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "UNITY_HDR_ON" }
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
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;
uniform vec4 _ZBufferParams;
uniform vec4 unity_ColorSpaceLuminance;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _LightDir;
uniform vec4 _LightColor;
uniform mat4 _CameraToWorld;
uniform sampler2D _CameraGBufferTexture0;
uniform sampler2D _CameraGBufferTexture1;
uniform sampler2D _CameraGBufferTexture2;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * (1.0/((
    (_ZBufferParams.x * texture2D (_CameraDepthTexture, tmpvar_1).x)
   + _ZBufferParams.y))));
  vec3 tmpvar_3;
  tmpvar_3 = -(_LightDir.xyz);
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (_CameraGBufferTexture0, tmpvar_1);
  vec4 tmpvar_5;
  tmpvar_5 = texture2D (_CameraGBufferTexture1, tmpvar_1);
  vec3 tmpvar_6;
  tmpvar_6 = normalize(((texture2D (_CameraGBufferTexture2, tmpvar_1).xyz * 2.0) - 1.0));
  float tmpvar_7;
  tmpvar_7 = max (0.0, dot (tmpvar_6, tmpvar_3));
  vec3 viewDir_8;
  viewDir_8 = -(normalize((
    (_CameraToWorld * tmpvar_2)
  .xyz - _WorldSpaceCameraPos)));
  float specularTerm_9;
  float tmpvar_10;
  tmpvar_10 = (1.0 - tmpvar_5.w);
  vec3 tmpvar_11;
  vec3 inVec_12;
  inVec_12 = (tmpvar_3 + viewDir_8);
  tmpvar_11 = (inVec_12 * inversesqrt(max (0.001, 
    dot (inVec_12, inVec_12)
  )));
  float tmpvar_13;
  tmpvar_13 = max (0.0, dot (tmpvar_6, tmpvar_11));
  float tmpvar_14;
  tmpvar_14 = max (0.0, dot (tmpvar_6, viewDir_8));
  float tmpvar_15;
  tmpvar_15 = max (0.0, dot (tmpvar_3, tmpvar_11));
  float tmpvar_16;
  tmpvar_16 = (tmpvar_10 * tmpvar_10);
  float tmpvar_17;
  tmpvar_17 = (tmpvar_10 * tmpvar_10);
  float tmpvar_18;
  tmpvar_18 = (tmpvar_17 * tmpvar_17);
  float tmpvar_19;
  tmpvar_19 = (((tmpvar_13 * tmpvar_13) * (tmpvar_18 - 1.0)) + 1.0);
  float x_20;
  x_20 = (1.0 - tmpvar_7);
  float x_21;
  x_21 = (1.0 - tmpvar_14);
  float tmpvar_22;
  tmpvar_22 = (0.5 + ((2.0 * tmpvar_15) * (tmpvar_15 * tmpvar_10)));
  float tmpvar_23;
  tmpvar_23 = ((1.0 + (
    (tmpvar_22 - 1.0)
   * 
    ((x_20 * x_20) * ((x_20 * x_20) * x_20))
  )) * (1.0 + (
    (tmpvar_22 - 1.0)
   * 
    ((x_21 * x_21) * ((x_21 * x_21) * x_21))
  )));
  float tmpvar_24;
  tmpvar_24 = (((
    (2.0 * tmpvar_7)
   / 
    (((tmpvar_7 * (
      (tmpvar_14 * (1.0 - tmpvar_16))
     + tmpvar_16)) + (tmpvar_14 * (
      (tmpvar_7 * (1.0 - tmpvar_16))
     + tmpvar_16))) + 1e-05)
  ) * (tmpvar_18 / 
    ((3.141593 * tmpvar_19) * tmpvar_19)
  )) * 0.7853982);
  specularTerm_9 = tmpvar_24;
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    specularTerm_9 = sqrt(max (0.0001, tmpvar_24));
  };
  float tmpvar_25;
  tmpvar_25 = max (0.0, (specularTerm_9 * tmpvar_7));
  specularTerm_9 = tmpvar_25;
  float x_26;
  x_26 = (1.0 - tmpvar_15);
  vec4 tmpvar_27;
  tmpvar_27.w = 1.0;
  tmpvar_27.xyz = ((tmpvar_4.xyz * (_LightColor.xyz * 
    (tmpvar_23 * tmpvar_7)
  )) + ((tmpvar_25 * _LightColor.xyz) * (tmpvar_5.xyz + 
    ((1.0 - tmpvar_5.xyz) * ((x_26 * x_26) * ((x_26 * x_26) * x_26)))
  )));
  gl_FragData[0] = tmpvar_27;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_OFF" "UNITY_HDR_ON" }
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
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;
uniform vec4 _ZBufferParams;
uniform vec4 unity_ColorSpaceLuminance;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _LightPos;
uniform vec4 _LightColor;
uniform mat4 _CameraToWorld;
uniform mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform sampler2D _CameraGBufferTexture0;
uniform sampler2D _CameraGBufferTexture1;
uniform sampler2D _CameraGBufferTexture2;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec3 tmpvar_1;
  float atten_2;
  vec2 tmpvar_3;
  tmpvar_3 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * (1.0/((
    (_ZBufferParams.x * texture2D (_CameraDepthTexture, tmpvar_3).x)
   + _ZBufferParams.y))));
  vec3 tmpvar_5;
  tmpvar_5 = (_CameraToWorld * tmpvar_4).xyz;
  vec3 tmpvar_6;
  tmpvar_6 = (_LightPos.xyz - tmpvar_5);
  vec3 tmpvar_7;
  tmpvar_7 = normalize(tmpvar_6);
  vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_5;
  vec4 tmpvar_9;
  tmpvar_9 = (_LightMatrix0 * tmpvar_8);
  vec4 tmpvar_10;
  tmpvar_10.zw = vec2(0.0, -8.0);
  tmpvar_10.xy = (tmpvar_9.xy / tmpvar_9.w);
  atten_2 = (texture2D (_LightTexture0, tmpvar_10.xy, -8.0).w * float((tmpvar_9.w < 0.0)));
  atten_2 = (atten_2 * texture2D (_LightTextureB0, vec2((dot (tmpvar_6, tmpvar_6) * _LightPos.w))).w);
  vec4 tmpvar_11;
  tmpvar_11 = texture2D (_CameraGBufferTexture0, tmpvar_3);
  vec4 tmpvar_12;
  tmpvar_12 = texture2D (_CameraGBufferTexture1, tmpvar_3);
  tmpvar_1 = (_LightColor.xyz * atten_2);
  vec3 tmpvar_13;
  tmpvar_13 = normalize(((texture2D (_CameraGBufferTexture2, tmpvar_3).xyz * 2.0) - 1.0));
  float tmpvar_14;
  tmpvar_14 = max (0.0, dot (tmpvar_13, tmpvar_7));
  vec3 viewDir_15;
  viewDir_15 = -(normalize((tmpvar_5 - _WorldSpaceCameraPos)));
  float specularTerm_16;
  float tmpvar_17;
  tmpvar_17 = (1.0 - tmpvar_12.w);
  vec3 tmpvar_18;
  vec3 inVec_19;
  inVec_19 = (tmpvar_7 + viewDir_15);
  tmpvar_18 = (inVec_19 * inversesqrt(max (0.001, 
    dot (inVec_19, inVec_19)
  )));
  float tmpvar_20;
  tmpvar_20 = max (0.0, dot (tmpvar_13, tmpvar_18));
  float tmpvar_21;
  tmpvar_21 = max (0.0, dot (tmpvar_13, viewDir_15));
  float tmpvar_22;
  tmpvar_22 = max (0.0, dot (tmpvar_7, tmpvar_18));
  float tmpvar_23;
  tmpvar_23 = (tmpvar_17 * tmpvar_17);
  float tmpvar_24;
  tmpvar_24 = (tmpvar_17 * tmpvar_17);
  float tmpvar_25;
  tmpvar_25 = (tmpvar_24 * tmpvar_24);
  float tmpvar_26;
  tmpvar_26 = (((tmpvar_20 * tmpvar_20) * (tmpvar_25 - 1.0)) + 1.0);
  float x_27;
  x_27 = (1.0 - tmpvar_14);
  float x_28;
  x_28 = (1.0 - tmpvar_21);
  float tmpvar_29;
  tmpvar_29 = (0.5 + ((2.0 * tmpvar_22) * (tmpvar_22 * tmpvar_17)));
  float tmpvar_30;
  tmpvar_30 = ((1.0 + (
    (tmpvar_29 - 1.0)
   * 
    ((x_27 * x_27) * ((x_27 * x_27) * x_27))
  )) * (1.0 + (
    (tmpvar_29 - 1.0)
   * 
    ((x_28 * x_28) * ((x_28 * x_28) * x_28))
  )));
  float tmpvar_31;
  tmpvar_31 = (((
    (2.0 * tmpvar_14)
   / 
    (((tmpvar_14 * (
      (tmpvar_21 * (1.0 - tmpvar_23))
     + tmpvar_23)) + (tmpvar_21 * (
      (tmpvar_14 * (1.0 - tmpvar_23))
     + tmpvar_23))) + 1e-05)
  ) * (tmpvar_25 / 
    ((3.141593 * tmpvar_26) * tmpvar_26)
  )) * 0.7853982);
  specularTerm_16 = tmpvar_31;
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    specularTerm_16 = sqrt(max (0.0001, tmpvar_31));
  };
  float tmpvar_32;
  tmpvar_32 = max (0.0, (specularTerm_16 * tmpvar_14));
  specularTerm_16 = tmpvar_32;
  float x_33;
  x_33 = (1.0 - tmpvar_22);
  vec4 tmpvar_34;
  tmpvar_34.w = 1.0;
  tmpvar_34.xyz = ((tmpvar_11.xyz * (tmpvar_1 * 
    (tmpvar_30 * tmpvar_14)
  )) + ((tmpvar_32 * tmpvar_1) * (tmpvar_12.xyz + 
    ((1.0 - tmpvar_12.xyz) * ((x_33 * x_33) * ((x_33 * x_33) * x_33)))
  )));
  gl_FragData[0] = tmpvar_34;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_OFF" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_OFF" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" "UNITY_HDR_ON" }
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
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;
uniform vec4 _ZBufferParams;
uniform vec4 unity_ColorSpaceLuminance;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _LightPos;
uniform vec4 _LightColor;
uniform mat4 _CameraToWorld;
uniform mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
uniform sampler2D _CameraGBufferTexture0;
uniform sampler2D _CameraGBufferTexture1;
uniform sampler2D _CameraGBufferTexture2;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec3 tmpvar_1;
  vec2 tmpvar_2;
  tmpvar_2 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * (1.0/((
    (_ZBufferParams.x * texture2D (_CameraDepthTexture, tmpvar_2).x)
   + _ZBufferParams.y))));
  vec3 tmpvar_4;
  tmpvar_4 = (_CameraToWorld * tmpvar_3).xyz;
  vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 - _LightPos.xyz);
  vec3 tmpvar_6;
  tmpvar_6 = -(normalize(tmpvar_5));
  vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_4;
  vec4 tmpvar_8;
  tmpvar_8.w = -8.0;
  tmpvar_8.xyz = (_LightMatrix0 * tmpvar_7).xyz;
  vec4 tmpvar_9;
  tmpvar_9 = texture2D (_CameraGBufferTexture0, tmpvar_2);
  vec4 tmpvar_10;
  tmpvar_10 = texture2D (_CameraGBufferTexture1, tmpvar_2);
  tmpvar_1 = (_LightColor.xyz * (texture2D (_LightTextureB0, vec2((
    dot (tmpvar_5, tmpvar_5)
   * _LightPos.w))).w * textureCube (_LightTexture0, tmpvar_8.xyz, -8.0).w));
  vec3 tmpvar_11;
  tmpvar_11 = normalize(((texture2D (_CameraGBufferTexture2, tmpvar_2).xyz * 2.0) - 1.0));
  float tmpvar_12;
  tmpvar_12 = max (0.0, dot (tmpvar_11, tmpvar_6));
  vec3 viewDir_13;
  viewDir_13 = -(normalize((tmpvar_4 - _WorldSpaceCameraPos)));
  float specularTerm_14;
  float tmpvar_15;
  tmpvar_15 = (1.0 - tmpvar_10.w);
  vec3 tmpvar_16;
  vec3 inVec_17;
  inVec_17 = (tmpvar_6 + viewDir_13);
  tmpvar_16 = (inVec_17 * inversesqrt(max (0.001, 
    dot (inVec_17, inVec_17)
  )));
  float tmpvar_18;
  tmpvar_18 = max (0.0, dot (tmpvar_11, tmpvar_16));
  float tmpvar_19;
  tmpvar_19 = max (0.0, dot (tmpvar_11, viewDir_13));
  float tmpvar_20;
  tmpvar_20 = max (0.0, dot (tmpvar_6, tmpvar_16));
  float tmpvar_21;
  tmpvar_21 = (tmpvar_15 * tmpvar_15);
  float tmpvar_22;
  tmpvar_22 = (tmpvar_15 * tmpvar_15);
  float tmpvar_23;
  tmpvar_23 = (tmpvar_22 * tmpvar_22);
  float tmpvar_24;
  tmpvar_24 = (((tmpvar_18 * tmpvar_18) * (tmpvar_23 - 1.0)) + 1.0);
  float x_25;
  x_25 = (1.0 - tmpvar_12);
  float x_26;
  x_26 = (1.0 - tmpvar_19);
  float tmpvar_27;
  tmpvar_27 = (0.5 + ((2.0 * tmpvar_20) * (tmpvar_20 * tmpvar_15)));
  float tmpvar_28;
  tmpvar_28 = ((1.0 + (
    (tmpvar_27 - 1.0)
   * 
    ((x_25 * x_25) * ((x_25 * x_25) * x_25))
  )) * (1.0 + (
    (tmpvar_27 - 1.0)
   * 
    ((x_26 * x_26) * ((x_26 * x_26) * x_26))
  )));
  float tmpvar_29;
  tmpvar_29 = (((
    (2.0 * tmpvar_12)
   / 
    (((tmpvar_12 * (
      (tmpvar_19 * (1.0 - tmpvar_21))
     + tmpvar_21)) + (tmpvar_19 * (
      (tmpvar_12 * (1.0 - tmpvar_21))
     + tmpvar_21))) + 1e-05)
  ) * (tmpvar_23 / 
    ((3.141593 * tmpvar_24) * tmpvar_24)
  )) * 0.7853982);
  specularTerm_14 = tmpvar_29;
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    specularTerm_14 = sqrt(max (0.0001, tmpvar_29));
  };
  float tmpvar_30;
  tmpvar_30 = max (0.0, (specularTerm_14 * tmpvar_12));
  specularTerm_14 = tmpvar_30;
  float x_31;
  x_31 = (1.0 - tmpvar_20);
  vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = ((tmpvar_9.xyz * (tmpvar_1 * 
    (tmpvar_28 * tmpvar_12)
  )) + ((tmpvar_30 * tmpvar_1) * (tmpvar_10.xyz + 
    ((1.0 - tmpvar_10.xyz) * ((x_31 * x_31) * ((x_31 * x_31) * x_31)))
  )));
  gl_FragData[0] = tmpvar_32;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" "UNITY_HDR_ON" }
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
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;
uniform vec4 _ZBufferParams;
uniform vec4 unity_ColorSpaceLuminance;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _LightDir;
uniform vec4 _LightColor;
uniform mat4 _CameraToWorld;
uniform mat4 _LightMatrix0;
uniform sampler2D _LightTexture0;
uniform sampler2D _CameraGBufferTexture0;
uniform sampler2D _CameraGBufferTexture1;
uniform sampler2D _CameraGBufferTexture2;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec3 tmpvar_1;
  vec2 tmpvar_2;
  tmpvar_2 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * (1.0/((
    (_ZBufferParams.x * texture2D (_CameraDepthTexture, tmpvar_2).x)
   + _ZBufferParams.y))));
  vec3 tmpvar_4;
  tmpvar_4 = (_CameraToWorld * tmpvar_3).xyz;
  vec3 tmpvar_5;
  tmpvar_5 = -(_LightDir.xyz);
  vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_4;
  vec4 tmpvar_7;
  tmpvar_7.zw = vec2(0.0, -8.0);
  tmpvar_7.xy = (_LightMatrix0 * tmpvar_6).xy;
  vec4 tmpvar_8;
  tmpvar_8 = texture2D (_CameraGBufferTexture0, tmpvar_2);
  vec4 tmpvar_9;
  tmpvar_9 = texture2D (_CameraGBufferTexture1, tmpvar_2);
  tmpvar_1 = (_LightColor.xyz * texture2D (_LightTexture0, tmpvar_7.xy, -8.0).w);
  vec3 tmpvar_10;
  tmpvar_10 = normalize(((texture2D (_CameraGBufferTexture2, tmpvar_2).xyz * 2.0) - 1.0));
  float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_10, tmpvar_5));
  vec3 viewDir_12;
  viewDir_12 = -(normalize((tmpvar_4 - _WorldSpaceCameraPos)));
  float specularTerm_13;
  float tmpvar_14;
  tmpvar_14 = (1.0 - tmpvar_9.w);
  vec3 tmpvar_15;
  vec3 inVec_16;
  inVec_16 = (tmpvar_5 + viewDir_12);
  tmpvar_15 = (inVec_16 * inversesqrt(max (0.001, 
    dot (inVec_16, inVec_16)
  )));
  float tmpvar_17;
  tmpvar_17 = max (0.0, dot (tmpvar_10, tmpvar_15));
  float tmpvar_18;
  tmpvar_18 = max (0.0, dot (tmpvar_10, viewDir_12));
  float tmpvar_19;
  tmpvar_19 = max (0.0, dot (tmpvar_5, tmpvar_15));
  float tmpvar_20;
  tmpvar_20 = (tmpvar_14 * tmpvar_14);
  float tmpvar_21;
  tmpvar_21 = (tmpvar_14 * tmpvar_14);
  float tmpvar_22;
  tmpvar_22 = (tmpvar_21 * tmpvar_21);
  float tmpvar_23;
  tmpvar_23 = (((tmpvar_17 * tmpvar_17) * (tmpvar_22 - 1.0)) + 1.0);
  float x_24;
  x_24 = (1.0 - tmpvar_11);
  float x_25;
  x_25 = (1.0 - tmpvar_18);
  float tmpvar_26;
  tmpvar_26 = (0.5 + ((2.0 * tmpvar_19) * (tmpvar_19 * tmpvar_14)));
  float tmpvar_27;
  tmpvar_27 = ((1.0 + (
    (tmpvar_26 - 1.0)
   * 
    ((x_24 * x_24) * ((x_24 * x_24) * x_24))
  )) * (1.0 + (
    (tmpvar_26 - 1.0)
   * 
    ((x_25 * x_25) * ((x_25 * x_25) * x_25))
  )));
  float tmpvar_28;
  tmpvar_28 = (((
    (2.0 * tmpvar_11)
   / 
    (((tmpvar_11 * (
      (tmpvar_18 * (1.0 - tmpvar_20))
     + tmpvar_20)) + (tmpvar_18 * (
      (tmpvar_11 * (1.0 - tmpvar_20))
     + tmpvar_20))) + 1e-05)
  ) * (tmpvar_22 / 
    ((3.141593 * tmpvar_23) * tmpvar_23)
  )) * 0.7853982);
  specularTerm_13 = tmpvar_28;
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    specularTerm_13 = sqrt(max (0.0001, tmpvar_28));
  };
  float tmpvar_29;
  tmpvar_29 = max (0.0, (specularTerm_13 * tmpvar_11));
  specularTerm_13 = tmpvar_29;
  float x_30;
  x_30 = (1.0 - tmpvar_19);
  vec4 tmpvar_31;
  tmpvar_31.w = 1.0;
  tmpvar_31.xyz = ((tmpvar_8.xyz * (tmpvar_1 * 
    (tmpvar_27 * tmpvar_11)
  )) + ((tmpvar_29 * tmpvar_1) * (tmpvar_9.xyz + 
    ((1.0 - tmpvar_9.xyz) * ((x_30 * x_30) * ((x_30 * x_30) * x_30)))
  )));
  gl_FragData[0] = tmpvar_31;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" "UNITY_HDR_ON" }
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
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;
uniform vec4 _ZBufferParams;
uniform mat4 unity_World2Shadow[4];
uniform vec4 _LightShadowData;
uniform vec4 unity_ShadowFadeCenterAndType;
uniform vec4 unity_ColorSpaceLuminance;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _LightPos;
uniform vec4 _LightColor;
uniform mat4 _CameraToWorld;
uniform mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform sampler2DShadow _ShadowMapTexture;
uniform sampler2D _CameraGBufferTexture0;
uniform sampler2D _CameraGBufferTexture1;
uniform sampler2D _CameraGBufferTexture2;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec3 tmpvar_1;
  float atten_2;
  vec3 lightDir_3;
  vec2 tmpvar_4;
  tmpvar_4 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * (1.0/((
    (_ZBufferParams.x * texture2D (_CameraDepthTexture, tmpvar_4).x)
   + _ZBufferParams.y))));
  vec3 tmpvar_6;
  tmpvar_6 = (_CameraToWorld * tmpvar_5).xyz;
  vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 - unity_ShadowFadeCenterAndType.xyz);
  vec3 tmpvar_8;
  tmpvar_8 = (_LightPos.xyz - tmpvar_6);
  lightDir_3 = normalize(tmpvar_8);
  vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_6;
  vec4 tmpvar_10;
  tmpvar_10 = (_LightMatrix0 * tmpvar_9);
  vec4 tmpvar_11;
  tmpvar_11.zw = vec2(0.0, -8.0);
  tmpvar_11.xy = (tmpvar_10.xy / tmpvar_10.w);
  atten_2 = (texture2D (_LightTexture0, tmpvar_11.xy, -8.0).w * float((tmpvar_10.w < 0.0)));
  atten_2 = (atten_2 * texture2D (_LightTextureB0, vec2((dot (tmpvar_8, tmpvar_8) * _LightPos.w))).w);
  vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = tmpvar_6;
  atten_2 = (atten_2 * clamp ((
    (_LightShadowData.x + (shadow2DProj (_ShadowMapTexture, (unity_World2Shadow[0] * tmpvar_12)).x * (1.0 - _LightShadowData.x)))
   + 
    clamp (((mix (tmpvar_5.z, 
      sqrt(dot (tmpvar_7, tmpvar_7))
    , unity_ShadowFadeCenterAndType.w) * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0)
  ), 0.0, 1.0));
  vec4 tmpvar_13;
  tmpvar_13 = texture2D (_CameraGBufferTexture0, tmpvar_4);
  vec4 tmpvar_14;
  tmpvar_14 = texture2D (_CameraGBufferTexture1, tmpvar_4);
  tmpvar_1 = (_LightColor.xyz * atten_2);
  vec3 tmpvar_15;
  tmpvar_15 = normalize(((texture2D (_CameraGBufferTexture2, tmpvar_4).xyz * 2.0) - 1.0));
  float tmpvar_16;
  tmpvar_16 = max (0.0, dot (tmpvar_15, lightDir_3));
  vec3 viewDir_17;
  viewDir_17 = -(normalize((tmpvar_6 - _WorldSpaceCameraPos)));
  float specularTerm_18;
  float tmpvar_19;
  tmpvar_19 = (1.0 - tmpvar_14.w);
  vec3 tmpvar_20;
  vec3 inVec_21;
  inVec_21 = (lightDir_3 + viewDir_17);
  tmpvar_20 = (inVec_21 * inversesqrt(max (0.001, 
    dot (inVec_21, inVec_21)
  )));
  float tmpvar_22;
  tmpvar_22 = max (0.0, dot (tmpvar_15, tmpvar_20));
  float tmpvar_23;
  tmpvar_23 = max (0.0, dot (tmpvar_15, viewDir_17));
  float tmpvar_24;
  tmpvar_24 = max (0.0, dot (lightDir_3, tmpvar_20));
  float tmpvar_25;
  tmpvar_25 = (tmpvar_19 * tmpvar_19);
  float tmpvar_26;
  tmpvar_26 = (tmpvar_19 * tmpvar_19);
  float tmpvar_27;
  tmpvar_27 = (tmpvar_26 * tmpvar_26);
  float tmpvar_28;
  tmpvar_28 = (((tmpvar_22 * tmpvar_22) * (tmpvar_27 - 1.0)) + 1.0);
  float x_29;
  x_29 = (1.0 - tmpvar_16);
  float x_30;
  x_30 = (1.0 - tmpvar_23);
  float tmpvar_31;
  tmpvar_31 = (0.5 + ((2.0 * tmpvar_24) * (tmpvar_24 * tmpvar_19)));
  float tmpvar_32;
  tmpvar_32 = ((1.0 + (
    (tmpvar_31 - 1.0)
   * 
    ((x_29 * x_29) * ((x_29 * x_29) * x_29))
  )) * (1.0 + (
    (tmpvar_31 - 1.0)
   * 
    ((x_30 * x_30) * ((x_30 * x_30) * x_30))
  )));
  float tmpvar_33;
  tmpvar_33 = (((
    (2.0 * tmpvar_16)
   / 
    (((tmpvar_16 * (
      (tmpvar_23 * (1.0 - tmpvar_25))
     + tmpvar_25)) + (tmpvar_23 * (
      (tmpvar_16 * (1.0 - tmpvar_25))
     + tmpvar_25))) + 1e-05)
  ) * (tmpvar_27 / 
    ((3.141593 * tmpvar_28) * tmpvar_28)
  )) * 0.7853982);
  specularTerm_18 = tmpvar_33;
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    specularTerm_18 = sqrt(max (0.0001, tmpvar_33));
  };
  float tmpvar_34;
  tmpvar_34 = max (0.0, (specularTerm_18 * tmpvar_16));
  specularTerm_18 = tmpvar_34;
  float x_35;
  x_35 = (1.0 - tmpvar_24);
  vec4 tmpvar_36;
  tmpvar_36.w = 1.0;
  tmpvar_36.xyz = ((tmpvar_13.xyz * (tmpvar_1 * 
    (tmpvar_32 * tmpvar_16)
  )) + ((tmpvar_34 * tmpvar_1) * (tmpvar_14.xyz + 
    ((1.0 - tmpvar_14.xyz) * ((x_35 * x_35) * ((x_35 * x_35) * x_35)))
  )));
  gl_FragData[0] = tmpvar_36;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "UNITY_HDR_ON" }
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
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;
uniform vec4 _ZBufferParams;
uniform vec4 _LightShadowData;
uniform vec4 unity_ShadowFadeCenterAndType;
uniform vec4 unity_ColorSpaceLuminance;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _LightDir;
uniform vec4 _LightColor;
uniform mat4 _CameraToWorld;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _CameraGBufferTexture0;
uniform sampler2D _CameraGBufferTexture1;
uniform sampler2D _CameraGBufferTexture2;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec3 tmpvar_1;
  vec3 lightDir_2;
  vec2 tmpvar_3;
  tmpvar_3 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * (1.0/((
    (_ZBufferParams.x * texture2D (_CameraDepthTexture, tmpvar_3).x)
   + _ZBufferParams.y))));
  vec3 tmpvar_5;
  tmpvar_5 = (_CameraToWorld * tmpvar_4).xyz;
  vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_5 - unity_ShadowFadeCenterAndType.xyz);
  lightDir_2 = -(_LightDir.xyz);
  vec4 tmpvar_7;
  tmpvar_7 = texture2D (_CameraGBufferTexture0, tmpvar_3);
  vec4 tmpvar_8;
  tmpvar_8 = texture2D (_CameraGBufferTexture1, tmpvar_3);
  tmpvar_1 = (_LightColor.xyz * clamp ((texture2D (_ShadowMapTexture, tmpvar_3).x + 
    clamp (((mix (tmpvar_4.z, 
      sqrt(dot (tmpvar_6, tmpvar_6))
    , unity_ShadowFadeCenterAndType.w) * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0)
  ), 0.0, 1.0));
  vec3 tmpvar_9;
  tmpvar_9 = normalize(((texture2D (_CameraGBufferTexture2, tmpvar_3).xyz * 2.0) - 1.0));
  float tmpvar_10;
  tmpvar_10 = max (0.0, dot (tmpvar_9, lightDir_2));
  vec3 viewDir_11;
  viewDir_11 = -(normalize((tmpvar_5 - _WorldSpaceCameraPos)));
  float specularTerm_12;
  float tmpvar_13;
  tmpvar_13 = (1.0 - tmpvar_8.w);
  vec3 tmpvar_14;
  vec3 inVec_15;
  inVec_15 = (lightDir_2 + viewDir_11);
  tmpvar_14 = (inVec_15 * inversesqrt(max (0.001, 
    dot (inVec_15, inVec_15)
  )));
  float tmpvar_16;
  tmpvar_16 = max (0.0, dot (tmpvar_9, tmpvar_14));
  float tmpvar_17;
  tmpvar_17 = max (0.0, dot (tmpvar_9, viewDir_11));
  float tmpvar_18;
  tmpvar_18 = max (0.0, dot (lightDir_2, tmpvar_14));
  float tmpvar_19;
  tmpvar_19 = (tmpvar_13 * tmpvar_13);
  float tmpvar_20;
  tmpvar_20 = (tmpvar_13 * tmpvar_13);
  float tmpvar_21;
  tmpvar_21 = (tmpvar_20 * tmpvar_20);
  float tmpvar_22;
  tmpvar_22 = (((tmpvar_16 * tmpvar_16) * (tmpvar_21 - 1.0)) + 1.0);
  float x_23;
  x_23 = (1.0 - tmpvar_10);
  float x_24;
  x_24 = (1.0 - tmpvar_17);
  float tmpvar_25;
  tmpvar_25 = (0.5 + ((2.0 * tmpvar_18) * (tmpvar_18 * tmpvar_13)));
  float tmpvar_26;
  tmpvar_26 = ((1.0 + (
    (tmpvar_25 - 1.0)
   * 
    ((x_23 * x_23) * ((x_23 * x_23) * x_23))
  )) * (1.0 + (
    (tmpvar_25 - 1.0)
   * 
    ((x_24 * x_24) * ((x_24 * x_24) * x_24))
  )));
  float tmpvar_27;
  tmpvar_27 = (((
    (2.0 * tmpvar_10)
   / 
    (((tmpvar_10 * (
      (tmpvar_17 * (1.0 - tmpvar_19))
     + tmpvar_19)) + (tmpvar_17 * (
      (tmpvar_10 * (1.0 - tmpvar_19))
     + tmpvar_19))) + 1e-05)
  ) * (tmpvar_21 / 
    ((3.141593 * tmpvar_22) * tmpvar_22)
  )) * 0.7853982);
  specularTerm_12 = tmpvar_27;
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    specularTerm_12 = sqrt(max (0.0001, tmpvar_27));
  };
  float tmpvar_28;
  tmpvar_28 = max (0.0, (specularTerm_12 * tmpvar_10));
  specularTerm_12 = tmpvar_28;
  float x_29;
  x_29 = (1.0 - tmpvar_18);
  vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = ((tmpvar_7.xyz * (tmpvar_1 * 
    (tmpvar_26 * tmpvar_10)
  )) + ((tmpvar_28 * tmpvar_1) * (tmpvar_8.xyz + 
    ((1.0 - tmpvar_8.xyz) * ((x_29 * x_29) * ((x_29 * x_29) * x_29)))
  )));
  gl_FragData[0] = tmpvar_30;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" "UNITY_HDR_ON" }
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
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;
uniform vec4 _ZBufferParams;
uniform vec4 _LightShadowData;
uniform vec4 unity_ShadowFadeCenterAndType;
uniform vec4 unity_ColorSpaceLuminance;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _LightDir;
uniform vec4 _LightColor;
uniform mat4 _CameraToWorld;
uniform mat4 _LightMatrix0;
uniform sampler2D _LightTexture0;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _CameraGBufferTexture0;
uniform sampler2D _CameraGBufferTexture1;
uniform sampler2D _CameraGBufferTexture2;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec3 tmpvar_1;
  float atten_2;
  vec3 lightDir_3;
  vec2 tmpvar_4;
  tmpvar_4 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * (1.0/((
    (_ZBufferParams.x * texture2D (_CameraDepthTexture, tmpvar_4).x)
   + _ZBufferParams.y))));
  vec3 tmpvar_6;
  tmpvar_6 = (_CameraToWorld * tmpvar_5).xyz;
  vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 - unity_ShadowFadeCenterAndType.xyz);
  lightDir_3 = -(_LightDir.xyz);
  atten_2 = clamp ((texture2D (_ShadowMapTexture, tmpvar_4).x + clamp (
    ((mix (tmpvar_5.z, sqrt(
      dot (tmpvar_7, tmpvar_7)
    ), unity_ShadowFadeCenterAndType.w) * _LightShadowData.z) + _LightShadowData.w)
  , 0.0, 1.0)), 0.0, 1.0);
  vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_6;
  vec4 tmpvar_9;
  tmpvar_9.zw = vec2(0.0, -8.0);
  tmpvar_9.xy = (_LightMatrix0 * tmpvar_8).xy;
  atten_2 = (atten_2 * texture2D (_LightTexture0, tmpvar_9.xy, -8.0).w);
  vec4 tmpvar_10;
  tmpvar_10 = texture2D (_CameraGBufferTexture0, tmpvar_4);
  vec4 tmpvar_11;
  tmpvar_11 = texture2D (_CameraGBufferTexture1, tmpvar_4);
  tmpvar_1 = (_LightColor.xyz * atten_2);
  vec3 tmpvar_12;
  tmpvar_12 = normalize(((texture2D (_CameraGBufferTexture2, tmpvar_4).xyz * 2.0) - 1.0));
  float tmpvar_13;
  tmpvar_13 = max (0.0, dot (tmpvar_12, lightDir_3));
  vec3 viewDir_14;
  viewDir_14 = -(normalize((tmpvar_6 - _WorldSpaceCameraPos)));
  float specularTerm_15;
  float tmpvar_16;
  tmpvar_16 = (1.0 - tmpvar_11.w);
  vec3 tmpvar_17;
  vec3 inVec_18;
  inVec_18 = (lightDir_3 + viewDir_14);
  tmpvar_17 = (inVec_18 * inversesqrt(max (0.001, 
    dot (inVec_18, inVec_18)
  )));
  float tmpvar_19;
  tmpvar_19 = max (0.0, dot (tmpvar_12, tmpvar_17));
  float tmpvar_20;
  tmpvar_20 = max (0.0, dot (tmpvar_12, viewDir_14));
  float tmpvar_21;
  tmpvar_21 = max (0.0, dot (lightDir_3, tmpvar_17));
  float tmpvar_22;
  tmpvar_22 = (tmpvar_16 * tmpvar_16);
  float tmpvar_23;
  tmpvar_23 = (tmpvar_16 * tmpvar_16);
  float tmpvar_24;
  tmpvar_24 = (tmpvar_23 * tmpvar_23);
  float tmpvar_25;
  tmpvar_25 = (((tmpvar_19 * tmpvar_19) * (tmpvar_24 - 1.0)) + 1.0);
  float x_26;
  x_26 = (1.0 - tmpvar_13);
  float x_27;
  x_27 = (1.0 - tmpvar_20);
  float tmpvar_28;
  tmpvar_28 = (0.5 + ((2.0 * tmpvar_21) * (tmpvar_21 * tmpvar_16)));
  float tmpvar_29;
  tmpvar_29 = ((1.0 + (
    (tmpvar_28 - 1.0)
   * 
    ((x_26 * x_26) * ((x_26 * x_26) * x_26))
  )) * (1.0 + (
    (tmpvar_28 - 1.0)
   * 
    ((x_27 * x_27) * ((x_27 * x_27) * x_27))
  )));
  float tmpvar_30;
  tmpvar_30 = (((
    (2.0 * tmpvar_13)
   / 
    (((tmpvar_13 * (
      (tmpvar_20 * (1.0 - tmpvar_22))
     + tmpvar_22)) + (tmpvar_20 * (
      (tmpvar_13 * (1.0 - tmpvar_22))
     + tmpvar_22))) + 1e-05)
  ) * (tmpvar_24 / 
    ((3.141593 * tmpvar_25) * tmpvar_25)
  )) * 0.7853982);
  specularTerm_15 = tmpvar_30;
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    specularTerm_15 = sqrt(max (0.0001, tmpvar_30));
  };
  float tmpvar_31;
  tmpvar_31 = max (0.0, (specularTerm_15 * tmpvar_13));
  specularTerm_15 = tmpvar_31;
  float x_32;
  x_32 = (1.0 - tmpvar_21);
  vec4 tmpvar_33;
  tmpvar_33.w = 1.0;
  tmpvar_33.xyz = ((tmpvar_10.xyz * (tmpvar_1 * 
    (tmpvar_29 * tmpvar_13)
  )) + ((tmpvar_31 * tmpvar_1) * (tmpvar_11.xyz + 
    ((1.0 - tmpvar_11.xyz) * ((x_32 * x_32) * ((x_32 * x_32) * x_32)))
  )));
  gl_FragData[0] = tmpvar_33;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_CUBE" "UNITY_HDR_ON" }
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
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;
uniform vec4 _ZBufferParams;
uniform vec4 _LightPositionRange;
uniform vec4 _LightShadowData;
uniform vec4 unity_ColorSpaceLuminance;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _LightPos;
uniform vec4 _LightColor;
uniform mat4 _CameraToWorld;
uniform sampler2D _LightTextureB0;
uniform samplerCube _ShadowMapTexture;
uniform sampler2D _CameraGBufferTexture0;
uniform sampler2D _CameraGBufferTexture1;
uniform sampler2D _CameraGBufferTexture2;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec3 tmpvar_1;
  float atten_2;
  vec3 lightDir_3;
  vec2 tmpvar_4;
  tmpvar_4 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * (1.0/((
    (_ZBufferParams.x * texture2D (_CameraDepthTexture, tmpvar_4).x)
   + _ZBufferParams.y))));
  vec3 tmpvar_6;
  tmpvar_6 = (_CameraToWorld * tmpvar_5).xyz;
  vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 - _LightPos.xyz);
  lightDir_3 = -(normalize(tmpvar_7));
  atten_2 = texture2D (_LightTextureB0, vec2((dot (tmpvar_7, tmpvar_7) * _LightPos.w))).w;
  float mydist_8;
  mydist_8 = ((sqrt(
    dot (tmpvar_7, tmpvar_7)
  ) * _LightPositionRange.w) * 0.97);
  vec4 tmpvar_9;
  tmpvar_9 = textureCube (_ShadowMapTexture, tmpvar_7);
  float tmpvar_10;
  if ((tmpvar_9.x < mydist_8)) {
    tmpvar_10 = _LightShadowData.x;
  } else {
    tmpvar_10 = 1.0;
  };
  atten_2 = (atten_2 * tmpvar_10);
  vec4 tmpvar_11;
  tmpvar_11 = texture2D (_CameraGBufferTexture0, tmpvar_4);
  vec4 tmpvar_12;
  tmpvar_12 = texture2D (_CameraGBufferTexture1, tmpvar_4);
  tmpvar_1 = (_LightColor.xyz * atten_2);
  vec3 tmpvar_13;
  tmpvar_13 = normalize(((texture2D (_CameraGBufferTexture2, tmpvar_4).xyz * 2.0) - 1.0));
  float tmpvar_14;
  tmpvar_14 = max (0.0, dot (tmpvar_13, lightDir_3));
  vec3 viewDir_15;
  viewDir_15 = -(normalize((tmpvar_6 - _WorldSpaceCameraPos)));
  float specularTerm_16;
  float tmpvar_17;
  tmpvar_17 = (1.0 - tmpvar_12.w);
  vec3 tmpvar_18;
  vec3 inVec_19;
  inVec_19 = (lightDir_3 + viewDir_15);
  tmpvar_18 = (inVec_19 * inversesqrt(max (0.001, 
    dot (inVec_19, inVec_19)
  )));
  float tmpvar_20;
  tmpvar_20 = max (0.0, dot (tmpvar_13, tmpvar_18));
  float tmpvar_21;
  tmpvar_21 = max (0.0, dot (tmpvar_13, viewDir_15));
  float tmpvar_22;
  tmpvar_22 = max (0.0, dot (lightDir_3, tmpvar_18));
  float tmpvar_23;
  tmpvar_23 = (tmpvar_17 * tmpvar_17);
  float tmpvar_24;
  tmpvar_24 = (tmpvar_17 * tmpvar_17);
  float tmpvar_25;
  tmpvar_25 = (tmpvar_24 * tmpvar_24);
  float tmpvar_26;
  tmpvar_26 = (((tmpvar_20 * tmpvar_20) * (tmpvar_25 - 1.0)) + 1.0);
  float x_27;
  x_27 = (1.0 - tmpvar_14);
  float x_28;
  x_28 = (1.0 - tmpvar_21);
  float tmpvar_29;
  tmpvar_29 = (0.5 + ((2.0 * tmpvar_22) * (tmpvar_22 * tmpvar_17)));
  float tmpvar_30;
  tmpvar_30 = ((1.0 + (
    (tmpvar_29 - 1.0)
   * 
    ((x_27 * x_27) * ((x_27 * x_27) * x_27))
  )) * (1.0 + (
    (tmpvar_29 - 1.0)
   * 
    ((x_28 * x_28) * ((x_28 * x_28) * x_28))
  )));
  float tmpvar_31;
  tmpvar_31 = (((
    (2.0 * tmpvar_14)
   / 
    (((tmpvar_14 * (
      (tmpvar_21 * (1.0 - tmpvar_23))
     + tmpvar_23)) + (tmpvar_21 * (
      (tmpvar_14 * (1.0 - tmpvar_23))
     + tmpvar_23))) + 1e-05)
  ) * (tmpvar_25 / 
    ((3.141593 * tmpvar_26) * tmpvar_26)
  )) * 0.7853982);
  specularTerm_16 = tmpvar_31;
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    specularTerm_16 = sqrt(max (0.0001, tmpvar_31));
  };
  float tmpvar_32;
  tmpvar_32 = max (0.0, (specularTerm_16 * tmpvar_14));
  specularTerm_16 = tmpvar_32;
  float x_33;
  x_33 = (1.0 - tmpvar_22);
  vec4 tmpvar_34;
  tmpvar_34.w = 1.0;
  tmpvar_34.xyz = ((tmpvar_11.xyz * (tmpvar_1 * 
    (tmpvar_30 * tmpvar_14)
  )) + ((tmpvar_32 * tmpvar_1) * (tmpvar_12.xyz + 
    ((1.0 - tmpvar_12.xyz) * ((x_33 * x_33) * ((x_33 * x_33) * x_33)))
  )));
  gl_FragData[0] = tmpvar_34;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_CUBE" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "POINT" "SHADOWS_CUBE" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "UNITY_HDR_ON" }
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
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;
uniform vec4 _ZBufferParams;
uniform vec4 _LightPositionRange;
uniform vec4 _LightShadowData;
uniform vec4 unity_ColorSpaceLuminance;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _LightPos;
uniform vec4 _LightColor;
uniform mat4 _CameraToWorld;
uniform mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
uniform samplerCube _ShadowMapTexture;
uniform sampler2D _CameraGBufferTexture0;
uniform sampler2D _CameraGBufferTexture1;
uniform sampler2D _CameraGBufferTexture2;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec3 tmpvar_1;
  float atten_2;
  vec3 lightDir_3;
  vec2 tmpvar_4;
  tmpvar_4 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * (1.0/((
    (_ZBufferParams.x * texture2D (_CameraDepthTexture, tmpvar_4).x)
   + _ZBufferParams.y))));
  vec3 tmpvar_6;
  tmpvar_6 = (_CameraToWorld * tmpvar_5).xyz;
  vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 - _LightPos.xyz);
  lightDir_3 = -(normalize(tmpvar_7));
  atten_2 = texture2D (_LightTextureB0, vec2((dot (tmpvar_7, tmpvar_7) * _LightPos.w))).w;
  float mydist_8;
  mydist_8 = ((sqrt(
    dot (tmpvar_7, tmpvar_7)
  ) * _LightPositionRange.w) * 0.97);
  vec4 tmpvar_9;
  tmpvar_9 = textureCube (_ShadowMapTexture, tmpvar_7);
  float tmpvar_10;
  if ((tmpvar_9.x < mydist_8)) {
    tmpvar_10 = _LightShadowData.x;
  } else {
    tmpvar_10 = 1.0;
  };
  atten_2 = (atten_2 * tmpvar_10);
  vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_6;
  vec4 tmpvar_12;
  tmpvar_12.w = -8.0;
  tmpvar_12.xyz = (_LightMatrix0 * tmpvar_11).xyz;
  atten_2 = (atten_2 * textureCube (_LightTexture0, tmpvar_12.xyz, -8.0).w);
  vec4 tmpvar_13;
  tmpvar_13 = texture2D (_CameraGBufferTexture0, tmpvar_4);
  vec4 tmpvar_14;
  tmpvar_14 = texture2D (_CameraGBufferTexture1, tmpvar_4);
  tmpvar_1 = (_LightColor.xyz * atten_2);
  vec3 tmpvar_15;
  tmpvar_15 = normalize(((texture2D (_CameraGBufferTexture2, tmpvar_4).xyz * 2.0) - 1.0));
  float tmpvar_16;
  tmpvar_16 = max (0.0, dot (tmpvar_15, lightDir_3));
  vec3 viewDir_17;
  viewDir_17 = -(normalize((tmpvar_6 - _WorldSpaceCameraPos)));
  float specularTerm_18;
  float tmpvar_19;
  tmpvar_19 = (1.0 - tmpvar_14.w);
  vec3 tmpvar_20;
  vec3 inVec_21;
  inVec_21 = (lightDir_3 + viewDir_17);
  tmpvar_20 = (inVec_21 * inversesqrt(max (0.001, 
    dot (inVec_21, inVec_21)
  )));
  float tmpvar_22;
  tmpvar_22 = max (0.0, dot (tmpvar_15, tmpvar_20));
  float tmpvar_23;
  tmpvar_23 = max (0.0, dot (tmpvar_15, viewDir_17));
  float tmpvar_24;
  tmpvar_24 = max (0.0, dot (lightDir_3, tmpvar_20));
  float tmpvar_25;
  tmpvar_25 = (tmpvar_19 * tmpvar_19);
  float tmpvar_26;
  tmpvar_26 = (tmpvar_19 * tmpvar_19);
  float tmpvar_27;
  tmpvar_27 = (tmpvar_26 * tmpvar_26);
  float tmpvar_28;
  tmpvar_28 = (((tmpvar_22 * tmpvar_22) * (tmpvar_27 - 1.0)) + 1.0);
  float x_29;
  x_29 = (1.0 - tmpvar_16);
  float x_30;
  x_30 = (1.0 - tmpvar_23);
  float tmpvar_31;
  tmpvar_31 = (0.5 + ((2.0 * tmpvar_24) * (tmpvar_24 * tmpvar_19)));
  float tmpvar_32;
  tmpvar_32 = ((1.0 + (
    (tmpvar_31 - 1.0)
   * 
    ((x_29 * x_29) * ((x_29 * x_29) * x_29))
  )) * (1.0 + (
    (tmpvar_31 - 1.0)
   * 
    ((x_30 * x_30) * ((x_30 * x_30) * x_30))
  )));
  float tmpvar_33;
  tmpvar_33 = (((
    (2.0 * tmpvar_16)
   / 
    (((tmpvar_16 * (
      (tmpvar_23 * (1.0 - tmpvar_25))
     + tmpvar_25)) + (tmpvar_23 * (
      (tmpvar_16 * (1.0 - tmpvar_25))
     + tmpvar_25))) + 1e-05)
  ) * (tmpvar_27 / 
    ((3.141593 * tmpvar_28) * tmpvar_28)
  )) * 0.7853982);
  specularTerm_18 = tmpvar_33;
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    specularTerm_18 = sqrt(max (0.0001, tmpvar_33));
  };
  float tmpvar_34;
  tmpvar_34 = max (0.0, (specularTerm_18 * tmpvar_16));
  specularTerm_18 = tmpvar_34;
  float x_35;
  x_35 = (1.0 - tmpvar_24);
  vec4 tmpvar_36;
  tmpvar_36.w = 1.0;
  tmpvar_36.xyz = ((tmpvar_13.xyz * (tmpvar_1 * 
    (tmpvar_32 * tmpvar_16)
  )) + ((tmpvar_34 * tmpvar_1) * (tmpvar_14.xyz + 
    ((1.0 - tmpvar_14.xyz) * ((x_35 * x_35) * ((x_35 * x_35) * x_35)))
  )));
  gl_FragData[0] = tmpvar_36;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" "UNITY_HDR_ON" }
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
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;
uniform vec4 _ZBufferParams;
uniform mat4 unity_World2Shadow[4];
uniform vec4 _LightShadowData;
uniform vec4 unity_ShadowFadeCenterAndType;
uniform vec4 unity_ColorSpaceLuminance;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _LightPos;
uniform vec4 _LightColor;
uniform mat4 _CameraToWorld;
uniform mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform sampler2DShadow _ShadowMapTexture;
uniform vec4 _ShadowOffsets[4];
uniform sampler2D _CameraGBufferTexture0;
uniform sampler2D _CameraGBufferTexture1;
uniform sampler2D _CameraGBufferTexture2;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec3 tmpvar_1;
  float atten_2;
  vec3 lightDir_3;
  vec2 tmpvar_4;
  tmpvar_4 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * (1.0/((
    (_ZBufferParams.x * texture2D (_CameraDepthTexture, tmpvar_4).x)
   + _ZBufferParams.y))));
  vec3 tmpvar_6;
  tmpvar_6 = (_CameraToWorld * tmpvar_5).xyz;
  vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 - unity_ShadowFadeCenterAndType.xyz);
  vec3 tmpvar_8;
  tmpvar_8 = (_LightPos.xyz - tmpvar_6);
  lightDir_3 = normalize(tmpvar_8);
  vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_6;
  vec4 tmpvar_10;
  tmpvar_10 = (_LightMatrix0 * tmpvar_9);
  vec4 tmpvar_11;
  tmpvar_11.zw = vec2(0.0, -8.0);
  tmpvar_11.xy = (tmpvar_10.xy / tmpvar_10.w);
  atten_2 = (texture2D (_LightTexture0, tmpvar_11.xy, -8.0).w * float((tmpvar_10.w < 0.0)));
  atten_2 = (atten_2 * texture2D (_LightTextureB0, vec2((dot (tmpvar_8, tmpvar_8) * _LightPos.w))).w);
  vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = tmpvar_6;
  vec4 tmpvar_13;
  tmpvar_13 = (unity_World2Shadow[0] * tmpvar_12);
  vec4 shadows_14;
  vec3 tmpvar_15;
  tmpvar_15 = (tmpvar_13.xyz / tmpvar_13.w);
  shadows_14.x = shadow2D (_ShadowMapTexture, (tmpvar_15 + _ShadowOffsets[0].xyz)).x;
  shadows_14.y = shadow2D (_ShadowMapTexture, (tmpvar_15 + _ShadowOffsets[1].xyz)).x;
  shadows_14.z = shadow2D (_ShadowMapTexture, (tmpvar_15 + _ShadowOffsets[2].xyz)).x;
  shadows_14.w = shadow2D (_ShadowMapTexture, (tmpvar_15 + _ShadowOffsets[3].xyz)).x;
  shadows_14 = (_LightShadowData.xxxx + (shadows_14 * (1.0 - _LightShadowData.xxxx)));
  atten_2 = (atten_2 * clamp ((
    dot (shadows_14, vec4(0.25, 0.25, 0.25, 0.25))
   + 
    clamp (((mix (tmpvar_5.z, 
      sqrt(dot (tmpvar_7, tmpvar_7))
    , unity_ShadowFadeCenterAndType.w) * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0)
  ), 0.0, 1.0));
  vec4 tmpvar_16;
  tmpvar_16 = texture2D (_CameraGBufferTexture0, tmpvar_4);
  vec4 tmpvar_17;
  tmpvar_17 = texture2D (_CameraGBufferTexture1, tmpvar_4);
  tmpvar_1 = (_LightColor.xyz * atten_2);
  vec3 tmpvar_18;
  tmpvar_18 = normalize(((texture2D (_CameraGBufferTexture2, tmpvar_4).xyz * 2.0) - 1.0));
  float tmpvar_19;
  tmpvar_19 = max (0.0, dot (tmpvar_18, lightDir_3));
  vec3 viewDir_20;
  viewDir_20 = -(normalize((tmpvar_6 - _WorldSpaceCameraPos)));
  float specularTerm_21;
  float tmpvar_22;
  tmpvar_22 = (1.0 - tmpvar_17.w);
  vec3 tmpvar_23;
  vec3 inVec_24;
  inVec_24 = (lightDir_3 + viewDir_20);
  tmpvar_23 = (inVec_24 * inversesqrt(max (0.001, 
    dot (inVec_24, inVec_24)
  )));
  float tmpvar_25;
  tmpvar_25 = max (0.0, dot (tmpvar_18, tmpvar_23));
  float tmpvar_26;
  tmpvar_26 = max (0.0, dot (tmpvar_18, viewDir_20));
  float tmpvar_27;
  tmpvar_27 = max (0.0, dot (lightDir_3, tmpvar_23));
  float tmpvar_28;
  tmpvar_28 = (tmpvar_22 * tmpvar_22);
  float tmpvar_29;
  tmpvar_29 = (tmpvar_22 * tmpvar_22);
  float tmpvar_30;
  tmpvar_30 = (tmpvar_29 * tmpvar_29);
  float tmpvar_31;
  tmpvar_31 = (((tmpvar_25 * tmpvar_25) * (tmpvar_30 - 1.0)) + 1.0);
  float x_32;
  x_32 = (1.0 - tmpvar_19);
  float x_33;
  x_33 = (1.0 - tmpvar_26);
  float tmpvar_34;
  tmpvar_34 = (0.5 + ((2.0 * tmpvar_27) * (tmpvar_27 * tmpvar_22)));
  float tmpvar_35;
  tmpvar_35 = ((1.0 + (
    (tmpvar_34 - 1.0)
   * 
    ((x_32 * x_32) * ((x_32 * x_32) * x_32))
  )) * (1.0 + (
    (tmpvar_34 - 1.0)
   * 
    ((x_33 * x_33) * ((x_33 * x_33) * x_33))
  )));
  float tmpvar_36;
  tmpvar_36 = (((
    (2.0 * tmpvar_19)
   / 
    (((tmpvar_19 * (
      (tmpvar_26 * (1.0 - tmpvar_28))
     + tmpvar_28)) + (tmpvar_26 * (
      (tmpvar_19 * (1.0 - tmpvar_28))
     + tmpvar_28))) + 1e-05)
  ) * (tmpvar_30 / 
    ((3.141593 * tmpvar_31) * tmpvar_31)
  )) * 0.7853982);
  specularTerm_21 = tmpvar_36;
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    specularTerm_21 = sqrt(max (0.0001, tmpvar_36));
  };
  float tmpvar_37;
  tmpvar_37 = max (0.0, (specularTerm_21 * tmpvar_19));
  specularTerm_21 = tmpvar_37;
  float x_38;
  x_38 = (1.0 - tmpvar_27);
  vec4 tmpvar_39;
  tmpvar_39.w = 1.0;
  tmpvar_39.xyz = ((tmpvar_16.xyz * (tmpvar_1 * 
    (tmpvar_35 * tmpvar_19)
  )) + ((tmpvar_37 * tmpvar_1) * (tmpvar_17.xyz + 
    ((1.0 - tmpvar_17.xyz) * ((x_38 * x_38) * ((x_38 * x_38) * x_38)))
  )));
  gl_FragData[0] = tmpvar_39;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" "UNITY_HDR_ON" }
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
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;
uniform vec4 _ZBufferParams;
uniform vec4 _LightPositionRange;
uniform vec4 _LightShadowData;
uniform vec4 unity_ColorSpaceLuminance;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _LightPos;
uniform vec4 _LightColor;
uniform mat4 _CameraToWorld;
uniform sampler2D _LightTextureB0;
uniform samplerCube _ShadowMapTexture;
uniform sampler2D _CameraGBufferTexture0;
uniform sampler2D _CameraGBufferTexture1;
uniform sampler2D _CameraGBufferTexture2;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec3 tmpvar_1;
  float atten_2;
  vec3 lightDir_3;
  vec2 tmpvar_4;
  tmpvar_4 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * (1.0/((
    (_ZBufferParams.x * texture2D (_CameraDepthTexture, tmpvar_4).x)
   + _ZBufferParams.y))));
  vec3 tmpvar_6;
  tmpvar_6 = (_CameraToWorld * tmpvar_5).xyz;
  vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 - _LightPos.xyz);
  lightDir_3 = -(normalize(tmpvar_7));
  atten_2 = texture2D (_LightTextureB0, vec2((dot (tmpvar_7, tmpvar_7) * _LightPos.w))).w;
  vec4 shadowVals_8;
  shadowVals_8.x = textureCube (_ShadowMapTexture, (tmpvar_7 + vec3(0.0078125, 0.0078125, 0.0078125))).x;
  shadowVals_8.y = textureCube (_ShadowMapTexture, (tmpvar_7 + vec3(-0.0078125, -0.0078125, 0.0078125))).x;
  shadowVals_8.z = textureCube (_ShadowMapTexture, (tmpvar_7 + vec3(-0.0078125, 0.0078125, -0.0078125))).x;
  shadowVals_8.w = textureCube (_ShadowMapTexture, (tmpvar_7 + vec3(0.0078125, -0.0078125, -0.0078125))).x;
  bvec4 tmpvar_9;
  tmpvar_9 = lessThan (shadowVals_8, vec4(((
    sqrt(dot (tmpvar_7, tmpvar_7))
   * _LightPositionRange.w) * 0.97)));
  vec4 tmpvar_10;
  tmpvar_10 = _LightShadowData.xxxx;
  float tmpvar_11;
  if (tmpvar_9.x) {
    tmpvar_11 = tmpvar_10.x;
  } else {
    tmpvar_11 = 1.0;
  };
  float tmpvar_12;
  if (tmpvar_9.y) {
    tmpvar_12 = tmpvar_10.y;
  } else {
    tmpvar_12 = 1.0;
  };
  float tmpvar_13;
  if (tmpvar_9.z) {
    tmpvar_13 = tmpvar_10.z;
  } else {
    tmpvar_13 = 1.0;
  };
  float tmpvar_14;
  if (tmpvar_9.w) {
    tmpvar_14 = tmpvar_10.w;
  } else {
    tmpvar_14 = 1.0;
  };
  vec4 tmpvar_15;
  tmpvar_15.x = tmpvar_11;
  tmpvar_15.y = tmpvar_12;
  tmpvar_15.z = tmpvar_13;
  tmpvar_15.w = tmpvar_14;
  atten_2 = (atten_2 * dot (tmpvar_15, vec4(0.25, 0.25, 0.25, 0.25)));
  vec4 tmpvar_16;
  tmpvar_16 = texture2D (_CameraGBufferTexture0, tmpvar_4);
  vec4 tmpvar_17;
  tmpvar_17 = texture2D (_CameraGBufferTexture1, tmpvar_4);
  tmpvar_1 = (_LightColor.xyz * atten_2);
  vec3 tmpvar_18;
  tmpvar_18 = normalize(((texture2D (_CameraGBufferTexture2, tmpvar_4).xyz * 2.0) - 1.0));
  float tmpvar_19;
  tmpvar_19 = max (0.0, dot (tmpvar_18, lightDir_3));
  vec3 viewDir_20;
  viewDir_20 = -(normalize((tmpvar_6 - _WorldSpaceCameraPos)));
  float specularTerm_21;
  float tmpvar_22;
  tmpvar_22 = (1.0 - tmpvar_17.w);
  vec3 tmpvar_23;
  vec3 inVec_24;
  inVec_24 = (lightDir_3 + viewDir_20);
  tmpvar_23 = (inVec_24 * inversesqrt(max (0.001, 
    dot (inVec_24, inVec_24)
  )));
  float tmpvar_25;
  tmpvar_25 = max (0.0, dot (tmpvar_18, tmpvar_23));
  float tmpvar_26;
  tmpvar_26 = max (0.0, dot (tmpvar_18, viewDir_20));
  float tmpvar_27;
  tmpvar_27 = max (0.0, dot (lightDir_3, tmpvar_23));
  float tmpvar_28;
  tmpvar_28 = (tmpvar_22 * tmpvar_22);
  float tmpvar_29;
  tmpvar_29 = (tmpvar_22 * tmpvar_22);
  float tmpvar_30;
  tmpvar_30 = (tmpvar_29 * tmpvar_29);
  float tmpvar_31;
  tmpvar_31 = (((tmpvar_25 * tmpvar_25) * (tmpvar_30 - 1.0)) + 1.0);
  float x_32;
  x_32 = (1.0 - tmpvar_19);
  float x_33;
  x_33 = (1.0 - tmpvar_26);
  float tmpvar_34;
  tmpvar_34 = (0.5 + ((2.0 * tmpvar_27) * (tmpvar_27 * tmpvar_22)));
  float tmpvar_35;
  tmpvar_35 = ((1.0 + (
    (tmpvar_34 - 1.0)
   * 
    ((x_32 * x_32) * ((x_32 * x_32) * x_32))
  )) * (1.0 + (
    (tmpvar_34 - 1.0)
   * 
    ((x_33 * x_33) * ((x_33 * x_33) * x_33))
  )));
  float tmpvar_36;
  tmpvar_36 = (((
    (2.0 * tmpvar_19)
   / 
    (((tmpvar_19 * (
      (tmpvar_26 * (1.0 - tmpvar_28))
     + tmpvar_28)) + (tmpvar_26 * (
      (tmpvar_19 * (1.0 - tmpvar_28))
     + tmpvar_28))) + 1e-05)
  ) * (tmpvar_30 / 
    ((3.141593 * tmpvar_31) * tmpvar_31)
  )) * 0.7853982);
  specularTerm_21 = tmpvar_36;
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    specularTerm_21 = sqrt(max (0.0001, tmpvar_36));
  };
  float tmpvar_37;
  tmpvar_37 = max (0.0, (specularTerm_21 * tmpvar_19));
  specularTerm_21 = tmpvar_37;
  float x_38;
  x_38 = (1.0 - tmpvar_27);
  vec4 tmpvar_39;
  tmpvar_39.w = 1.0;
  tmpvar_39.xyz = ((tmpvar_16.xyz * (tmpvar_1 * 
    (tmpvar_35 * tmpvar_19)
  )) + ((tmpvar_37 * tmpvar_1) * (tmpvar_17.xyz + 
    ((1.0 - tmpvar_17.xyz) * ((x_38 * x_38) * ((x_38 * x_38) * x_38)))
  )));
  gl_FragData[0] = tmpvar_39;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" "UNITY_HDR_ON" }
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
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;
uniform vec4 _ZBufferParams;
uniform vec4 _LightPositionRange;
uniform vec4 _LightShadowData;
uniform vec4 unity_ColorSpaceLuminance;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _LightPos;
uniform vec4 _LightColor;
uniform mat4 _CameraToWorld;
uniform mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
uniform samplerCube _ShadowMapTexture;
uniform sampler2D _CameraGBufferTexture0;
uniform sampler2D _CameraGBufferTexture1;
uniform sampler2D _CameraGBufferTexture2;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec3 tmpvar_1;
  float atten_2;
  vec3 lightDir_3;
  vec2 tmpvar_4;
  tmpvar_4 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * (1.0/((
    (_ZBufferParams.x * texture2D (_CameraDepthTexture, tmpvar_4).x)
   + _ZBufferParams.y))));
  vec3 tmpvar_6;
  tmpvar_6 = (_CameraToWorld * tmpvar_5).xyz;
  vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 - _LightPos.xyz);
  lightDir_3 = -(normalize(tmpvar_7));
  atten_2 = texture2D (_LightTextureB0, vec2((dot (tmpvar_7, tmpvar_7) * _LightPos.w))).w;
  vec4 shadowVals_8;
  shadowVals_8.x = textureCube (_ShadowMapTexture, (tmpvar_7 + vec3(0.0078125, 0.0078125, 0.0078125))).x;
  shadowVals_8.y = textureCube (_ShadowMapTexture, (tmpvar_7 + vec3(-0.0078125, -0.0078125, 0.0078125))).x;
  shadowVals_8.z = textureCube (_ShadowMapTexture, (tmpvar_7 + vec3(-0.0078125, 0.0078125, -0.0078125))).x;
  shadowVals_8.w = textureCube (_ShadowMapTexture, (tmpvar_7 + vec3(0.0078125, -0.0078125, -0.0078125))).x;
  bvec4 tmpvar_9;
  tmpvar_9 = lessThan (shadowVals_8, vec4(((
    sqrt(dot (tmpvar_7, tmpvar_7))
   * _LightPositionRange.w) * 0.97)));
  vec4 tmpvar_10;
  tmpvar_10 = _LightShadowData.xxxx;
  float tmpvar_11;
  if (tmpvar_9.x) {
    tmpvar_11 = tmpvar_10.x;
  } else {
    tmpvar_11 = 1.0;
  };
  float tmpvar_12;
  if (tmpvar_9.y) {
    tmpvar_12 = tmpvar_10.y;
  } else {
    tmpvar_12 = 1.0;
  };
  float tmpvar_13;
  if (tmpvar_9.z) {
    tmpvar_13 = tmpvar_10.z;
  } else {
    tmpvar_13 = 1.0;
  };
  float tmpvar_14;
  if (tmpvar_9.w) {
    tmpvar_14 = tmpvar_10.w;
  } else {
    tmpvar_14 = 1.0;
  };
  vec4 tmpvar_15;
  tmpvar_15.x = tmpvar_11;
  tmpvar_15.y = tmpvar_12;
  tmpvar_15.z = tmpvar_13;
  tmpvar_15.w = tmpvar_14;
  atten_2 = (atten_2 * dot (tmpvar_15, vec4(0.25, 0.25, 0.25, 0.25)));
  vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_6;
  vec4 tmpvar_17;
  tmpvar_17.w = -8.0;
  tmpvar_17.xyz = (_LightMatrix0 * tmpvar_16).xyz;
  atten_2 = (atten_2 * textureCube (_LightTexture0, tmpvar_17.xyz, -8.0).w);
  vec4 tmpvar_18;
  tmpvar_18 = texture2D (_CameraGBufferTexture0, tmpvar_4);
  vec4 tmpvar_19;
  tmpvar_19 = texture2D (_CameraGBufferTexture1, tmpvar_4);
  tmpvar_1 = (_LightColor.xyz * atten_2);
  vec3 tmpvar_20;
  tmpvar_20 = normalize(((texture2D (_CameraGBufferTexture2, tmpvar_4).xyz * 2.0) - 1.0));
  float tmpvar_21;
  tmpvar_21 = max (0.0, dot (tmpvar_20, lightDir_3));
  vec3 viewDir_22;
  viewDir_22 = -(normalize((tmpvar_6 - _WorldSpaceCameraPos)));
  float specularTerm_23;
  float tmpvar_24;
  tmpvar_24 = (1.0 - tmpvar_19.w);
  vec3 tmpvar_25;
  vec3 inVec_26;
  inVec_26 = (lightDir_3 + viewDir_22);
  tmpvar_25 = (inVec_26 * inversesqrt(max (0.001, 
    dot (inVec_26, inVec_26)
  )));
  float tmpvar_27;
  tmpvar_27 = max (0.0, dot (tmpvar_20, tmpvar_25));
  float tmpvar_28;
  tmpvar_28 = max (0.0, dot (tmpvar_20, viewDir_22));
  float tmpvar_29;
  tmpvar_29 = max (0.0, dot (lightDir_3, tmpvar_25));
  float tmpvar_30;
  tmpvar_30 = (tmpvar_24 * tmpvar_24);
  float tmpvar_31;
  tmpvar_31 = (tmpvar_24 * tmpvar_24);
  float tmpvar_32;
  tmpvar_32 = (tmpvar_31 * tmpvar_31);
  float tmpvar_33;
  tmpvar_33 = (((tmpvar_27 * tmpvar_27) * (tmpvar_32 - 1.0)) + 1.0);
  float x_34;
  x_34 = (1.0 - tmpvar_21);
  float x_35;
  x_35 = (1.0 - tmpvar_28);
  float tmpvar_36;
  tmpvar_36 = (0.5 + ((2.0 * tmpvar_29) * (tmpvar_29 * tmpvar_24)));
  float tmpvar_37;
  tmpvar_37 = ((1.0 + (
    (tmpvar_36 - 1.0)
   * 
    ((x_34 * x_34) * ((x_34 * x_34) * x_34))
  )) * (1.0 + (
    (tmpvar_36 - 1.0)
   * 
    ((x_35 * x_35) * ((x_35 * x_35) * x_35))
  )));
  float tmpvar_38;
  tmpvar_38 = (((
    (2.0 * tmpvar_21)
   / 
    (((tmpvar_21 * (
      (tmpvar_28 * (1.0 - tmpvar_30))
     + tmpvar_30)) + (tmpvar_28 * (
      (tmpvar_21 * (1.0 - tmpvar_30))
     + tmpvar_30))) + 1e-05)
  ) * (tmpvar_32 / 
    ((3.141593 * tmpvar_33) * tmpvar_33)
  )) * 0.7853982);
  specularTerm_23 = tmpvar_38;
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    specularTerm_23 = sqrt(max (0.0001, tmpvar_38));
  };
  float tmpvar_39;
  tmpvar_39 = max (0.0, (specularTerm_23 * tmpvar_21));
  specularTerm_23 = tmpvar_39;
  float x_40;
  x_40 = (1.0 - tmpvar_29);
  vec4 tmpvar_41;
  tmpvar_41.w = 1.0;
  tmpvar_41.xyz = ((tmpvar_18.xyz * (tmpvar_1 * 
    (tmpvar_37 * tmpvar_21)
  )) + ((tmpvar_39 * tmpvar_1) * (tmpvar_19.xyz + 
    ((1.0 - tmpvar_19.xyz) * ((x_40 * x_40) * ((x_40 * x_40) * x_40)))
  )));
  gl_FragData[0] = tmpvar_41;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_OFF" }
""
}
SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_OFF" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "POINT" "SHADOWS_OFF" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
""
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_OFF" }
""
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_OFF" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_OFF" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
""
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
""
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
""
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
""
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_CUBE" }
""
}
SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_CUBE" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "POINT" "SHADOWS_CUBE" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
""
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
""
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
""
}
SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
""
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_OFF" "UNITY_HDR_ON" }
""
}
SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_OFF" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "POINT" "SHADOWS_OFF" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "UNITY_HDR_ON" }
""
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_OFF" "UNITY_HDR_ON" }
""
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_OFF" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_OFF" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" "UNITY_HDR_ON" }
""
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" "UNITY_HDR_ON" }
""
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" "UNITY_HDR_ON" }
""
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "UNITY_HDR_ON" }
""
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" "UNITY_HDR_ON" }
""
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_CUBE" "UNITY_HDR_ON" }
""
}
SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_CUBE" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "POINT" "SHADOWS_CUBE" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "UNITY_HDR_ON" }
""
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" "UNITY_HDR_ON" }
""
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" "UNITY_HDR_ON" }
""
}
SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" "UNITY_HDR_ON" }
""
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
}
 }
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  Stencil {
   Ref [_StencilNonBackground]
   ReadMask [_StencilNonBackground]
   CompFront Equal
   CompBack Equal
  }
  GpuProgramID 123303
Program "vp" {
SubProgram "opengl " {
"#version 120

#ifdef VERTEX

varying vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = gl_MultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _LightBuffer;
varying vec2 xlv_TEXCOORD0;
void main ()
{
  gl_FragData[0] = -(log2(texture2D (_LightBuffer, xlv_TEXCOORD0)));
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
}
Fallback Off
}