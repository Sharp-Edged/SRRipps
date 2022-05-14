//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/Internal-PrePassLighting" {
Properties {
 _LightTexture0 ("", any) = "" { }
 _LightTextureB0 ("", 2D) = "" { }
 _ShadowMapTexture ("", any) = "" { }
}
SubShader { 
 Pass {
  Tags { "SHADOWSUPPORT"="true" }
  ZWrite Off
  Blend DstColor Zero
  GpuProgramID 57115
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
uniform vec4 unity_ShadowFadeCenterAndType;
uniform vec4 unity_ColorSpaceLuminance;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _LightPos;
uniform vec4 _LightColor;
uniform vec4 unity_LightmapFade;
uniform mat4 _CameraToWorld;
uniform sampler2D _LightTextureB0;
uniform sampler2D _CameraNormalsTexture;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec4 res_1;
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
  tmpvar_5 = (tmpvar_4 - unity_ShadowFadeCenterAndType.xyz);
  vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_4 - _LightPos.xyz);
  vec3 tmpvar_7;
  tmpvar_7 = -(normalize(tmpvar_6));
  vec4 tmpvar_8;
  tmpvar_8 = texture2D (_LightTextureB0, vec2((dot (tmpvar_6, tmpvar_6) * _LightPos.w)));
  vec4 tmpvar_9;
  tmpvar_9 = texture2D (_CameraNormalsTexture, tmpvar_2);
  vec3 tmpvar_10;
  tmpvar_10 = normalize(((tmpvar_9.xyz * 2.0) - 1.0));
  res_1.xyz = (_LightColor.xyz * (max (0.0, 
    dot (tmpvar_7, tmpvar_10)
  ) * tmpvar_8.w));
  vec3 c_11;
  c_11 = (_LightColor.xyz * unity_ColorSpaceLuminance.xyz);
  res_1.w = ((pow (
    max (0.0, dot (normalize((tmpvar_7 - 
      normalize((tmpvar_4 - _WorldSpaceCameraPos))
    )), tmpvar_10))
  , 
    (tmpvar_9.w * 128.0)
  ) * clamp (tmpvar_8.w, 0.0, 1.0)) * ((
    (c_11.x + c_11.y)
   + c_11.z) + (
    (2.0 * sqrt((c_11.y * (c_11.x + c_11.z))))
   * unity_ColorSpaceLuminance.w)));
  res_1 = (res_1 * clamp ((1.0 - 
    ((mix (tmpvar_3.z, sqrt(
      dot (tmpvar_5, tmpvar_5)
    ), unity_ShadowFadeCenterAndType.w) * unity_LightmapFade.z) + unity_LightmapFade.w)
  ), 0.0, 1.0));
  gl_FragData[0] = exp2(-(res_1));
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
uniform vec4 unity_ShadowFadeCenterAndType;
uniform vec4 unity_ColorSpaceLuminance;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _LightDir;
uniform vec4 _LightColor;
uniform vec4 unity_LightmapFade;
uniform mat4 _CameraToWorld;
uniform sampler2D _CameraNormalsTexture;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec4 res_1;
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
  tmpvar_5 = (tmpvar_4 - unity_ShadowFadeCenterAndType.xyz);
  vec3 tmpvar_6;
  tmpvar_6 = -(_LightDir.xyz);
  vec4 tmpvar_7;
  tmpvar_7 = texture2D (_CameraNormalsTexture, tmpvar_2);
  vec3 tmpvar_8;
  tmpvar_8 = normalize(((tmpvar_7.xyz * 2.0) - 1.0));
  res_1.xyz = (_LightColor.xyz * max (0.0, dot (tmpvar_6, tmpvar_8)));
  vec3 c_9;
  c_9 = (_LightColor.xyz * unity_ColorSpaceLuminance.xyz);
  res_1.w = ((pow (
    max (0.0, dot (normalize((tmpvar_6 - 
      normalize((tmpvar_4 - _WorldSpaceCameraPos))
    )), tmpvar_8))
  , 
    (tmpvar_7.w * 128.0)
  ) * clamp (1.0, 0.0, 1.0)) * ((
    (c_9.x + c_9.y)
   + c_9.z) + (
    (2.0 * sqrt((c_9.y * (c_9.x + c_9.z))))
   * unity_ColorSpaceLuminance.w)));
  res_1 = (res_1 * clamp ((1.0 - 
    ((mix (tmpvar_3.z, sqrt(
      dot (tmpvar_5, tmpvar_5)
    ), unity_ShadowFadeCenterAndType.w) * unity_LightmapFade.z) + unity_LightmapFade.w)
  ), 0.0, 1.0));
  gl_FragData[0] = exp2(-(res_1));
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
uniform vec4 unity_ShadowFadeCenterAndType;
uniform vec4 unity_ColorSpaceLuminance;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _LightPos;
uniform vec4 _LightColor;
uniform vec4 unity_LightmapFade;
uniform mat4 _CameraToWorld;
uniform mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform sampler2D _CameraNormalsTexture;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec4 res_1;
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
  tmpvar_6 = (tmpvar_5 - unity_ShadowFadeCenterAndType.xyz);
  vec3 tmpvar_7;
  tmpvar_7 = (_LightPos.xyz - tmpvar_5);
  vec3 tmpvar_8;
  tmpvar_8 = normalize(tmpvar_7);
  vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_5;
  vec4 tmpvar_10;
  tmpvar_10 = (_LightMatrix0 * tmpvar_9);
  vec4 tmpvar_11;
  tmpvar_11.zw = vec2(0.0, -8.0);
  tmpvar_11.xy = (tmpvar_10.xy / tmpvar_10.w);
  atten_2 = (texture2D (_LightTexture0, tmpvar_11.xy, -8.0).w * float((tmpvar_10.w < 0.0)));
  atten_2 = (atten_2 * texture2D (_LightTextureB0, vec2((dot (tmpvar_7, tmpvar_7) * _LightPos.w))).w);
  vec4 tmpvar_12;
  tmpvar_12 = texture2D (_CameraNormalsTexture, tmpvar_3);
  vec3 tmpvar_13;
  tmpvar_13 = normalize(((tmpvar_12.xyz * 2.0) - 1.0));
  res_1.xyz = (_LightColor.xyz * (max (0.0, 
    dot (tmpvar_8, tmpvar_13)
  ) * atten_2));
  vec3 c_14;
  c_14 = (_LightColor.xyz * unity_ColorSpaceLuminance.xyz);
  res_1.w = ((pow (
    max (0.0, dot (normalize((tmpvar_8 - 
      normalize((tmpvar_5 - _WorldSpaceCameraPos))
    )), tmpvar_13))
  , 
    (tmpvar_12.w * 128.0)
  ) * clamp (atten_2, 0.0, 1.0)) * ((
    (c_14.x + c_14.y)
   + c_14.z) + (
    (2.0 * sqrt((c_14.y * (c_14.x + c_14.z))))
   * unity_ColorSpaceLuminance.w)));
  res_1 = (res_1 * clamp ((1.0 - 
    ((mix (tmpvar_4.z, sqrt(
      dot (tmpvar_6, tmpvar_6)
    ), unity_ShadowFadeCenterAndType.w) * unity_LightmapFade.z) + unity_LightmapFade.w)
  ), 0.0, 1.0));
  gl_FragData[0] = exp2(-(res_1));
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
uniform vec4 unity_ShadowFadeCenterAndType;
uniform vec4 unity_ColorSpaceLuminance;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _LightPos;
uniform vec4 _LightColor;
uniform vec4 unity_LightmapFade;
uniform mat4 _CameraToWorld;
uniform mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
uniform sampler2D _CameraNormalsTexture;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec4 res_1;
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
  tmpvar_6 = (tmpvar_5 - unity_ShadowFadeCenterAndType.xyz);
  vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_5 - _LightPos.xyz);
  vec3 tmpvar_8;
  tmpvar_8 = -(normalize(tmpvar_7));
  vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_5;
  vec4 tmpvar_10;
  tmpvar_10.w = -8.0;
  tmpvar_10.xyz = (_LightMatrix0 * tmpvar_9).xyz;
  atten_2 = (texture2D (_LightTextureB0, vec2((dot (tmpvar_7, tmpvar_7) * _LightPos.w))).w * textureCube (_LightTexture0, tmpvar_10.xyz, -8.0).w);
  vec4 tmpvar_11;
  tmpvar_11 = texture2D (_CameraNormalsTexture, tmpvar_3);
  vec3 tmpvar_12;
  tmpvar_12 = normalize(((tmpvar_11.xyz * 2.0) - 1.0));
  res_1.xyz = (_LightColor.xyz * (max (0.0, 
    dot (tmpvar_8, tmpvar_12)
  ) * atten_2));
  vec3 c_13;
  c_13 = (_LightColor.xyz * unity_ColorSpaceLuminance.xyz);
  res_1.w = ((pow (
    max (0.0, dot (normalize((tmpvar_8 - 
      normalize((tmpvar_5 - _WorldSpaceCameraPos))
    )), tmpvar_12))
  , 
    (tmpvar_11.w * 128.0)
  ) * clamp (atten_2, 0.0, 1.0)) * ((
    (c_13.x + c_13.y)
   + c_13.z) + (
    (2.0 * sqrt((c_13.y * (c_13.x + c_13.z))))
   * unity_ColorSpaceLuminance.w)));
  res_1 = (res_1 * clamp ((1.0 - 
    ((mix (tmpvar_4.z, sqrt(
      dot (tmpvar_6, tmpvar_6)
    ), unity_ShadowFadeCenterAndType.w) * unity_LightmapFade.z) + unity_LightmapFade.w)
  ), 0.0, 1.0));
  gl_FragData[0] = exp2(-(res_1));
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
uniform vec4 unity_ShadowFadeCenterAndType;
uniform vec4 unity_ColorSpaceLuminance;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _LightDir;
uniform vec4 _LightColor;
uniform vec4 unity_LightmapFade;
uniform mat4 _CameraToWorld;
uniform mat4 _LightMatrix0;
uniform sampler2D _LightTexture0;
uniform sampler2D _CameraNormalsTexture;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec4 res_1;
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
  tmpvar_6 = (tmpvar_5 - unity_ShadowFadeCenterAndType.xyz);
  vec3 tmpvar_7;
  tmpvar_7 = -(_LightDir.xyz);
  vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_5;
  vec4 tmpvar_9;
  tmpvar_9.zw = vec2(0.0, -8.0);
  tmpvar_9.xy = (_LightMatrix0 * tmpvar_8).xy;
  atten_2 = texture2D (_LightTexture0, tmpvar_9.xy, -8.0).w;
  vec4 tmpvar_10;
  tmpvar_10 = texture2D (_CameraNormalsTexture, tmpvar_3);
  vec3 tmpvar_11;
  tmpvar_11 = normalize(((tmpvar_10.xyz * 2.0) - 1.0));
  res_1.xyz = (_LightColor.xyz * (max (0.0, 
    dot (tmpvar_7, tmpvar_11)
  ) * atten_2));
  vec3 c_12;
  c_12 = (_LightColor.xyz * unity_ColorSpaceLuminance.xyz);
  res_1.w = ((pow (
    max (0.0, dot (normalize((tmpvar_7 - 
      normalize((tmpvar_5 - _WorldSpaceCameraPos))
    )), tmpvar_11))
  , 
    (tmpvar_10.w * 128.0)
  ) * clamp (atten_2, 0.0, 1.0)) * ((
    (c_12.x + c_12.y)
   + c_12.z) + (
    (2.0 * sqrt((c_12.y * (c_12.x + c_12.z))))
   * unity_ColorSpaceLuminance.w)));
  res_1 = (res_1 * clamp ((1.0 - 
    ((mix (tmpvar_4.z, sqrt(
      dot (tmpvar_6, tmpvar_6)
    ), unity_ShadowFadeCenterAndType.w) * unity_LightmapFade.z) + unity_LightmapFade.w)
  ), 0.0, 1.0));
  gl_FragData[0] = exp2(-(res_1));
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
uniform vec4 unity_LightmapFade;
uniform mat4 _CameraToWorld;
uniform mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform sampler2DShadow _ShadowMapTexture;
uniform sampler2D _CameraNormalsTexture;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec4 res_1;
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
  float tmpvar_8;
  tmpvar_8 = mix (tmpvar_5.z, sqrt(dot (tmpvar_7, tmpvar_7)), unity_ShadowFadeCenterAndType.w);
  vec3 tmpvar_9;
  tmpvar_9 = (_LightPos.xyz - tmpvar_6);
  lightDir_3 = normalize(tmpvar_9);
  vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_6;
  vec4 tmpvar_11;
  tmpvar_11 = (_LightMatrix0 * tmpvar_10);
  vec4 tmpvar_12;
  tmpvar_12.zw = vec2(0.0, -8.0);
  tmpvar_12.xy = (tmpvar_11.xy / tmpvar_11.w);
  atten_2 = (texture2D (_LightTexture0, tmpvar_12.xy, -8.0).w * float((tmpvar_11.w < 0.0)));
  atten_2 = (atten_2 * texture2D (_LightTextureB0, vec2((dot (tmpvar_9, tmpvar_9) * _LightPos.w))).w);
  vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_6;
  atten_2 = (atten_2 * clamp ((
    (_LightShadowData.x + (shadow2DProj (_ShadowMapTexture, (unity_World2Shadow[0] * tmpvar_13)).x * (1.0 - _LightShadowData.x)))
   + 
    clamp (((tmpvar_8 * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0)
  ), 0.0, 1.0));
  vec4 tmpvar_14;
  tmpvar_14 = texture2D (_CameraNormalsTexture, tmpvar_4);
  vec3 tmpvar_15;
  tmpvar_15 = normalize(((tmpvar_14.xyz * 2.0) - 1.0));
  res_1.xyz = (_LightColor.xyz * (max (0.0, 
    dot (lightDir_3, tmpvar_15)
  ) * atten_2));
  vec3 c_16;
  c_16 = (_LightColor.xyz * unity_ColorSpaceLuminance.xyz);
  res_1.w = ((pow (
    max (0.0, dot (normalize((lightDir_3 - 
      normalize((tmpvar_6 - _WorldSpaceCameraPos))
    )), tmpvar_15))
  , 
    (tmpvar_14.w * 128.0)
  ) * clamp (atten_2, 0.0, 1.0)) * ((
    (c_16.x + c_16.y)
   + c_16.z) + (
    (2.0 * sqrt((c_16.y * (c_16.x + c_16.z))))
   * unity_ColorSpaceLuminance.w)));
  res_1 = (res_1 * clamp ((1.0 - 
    ((tmpvar_8 * unity_LightmapFade.z) + unity_LightmapFade.w)
  ), 0.0, 1.0));
  gl_FragData[0] = exp2(-(res_1));
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
uniform vec4 unity_LightmapFade;
uniform mat4 _CameraToWorld;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _CameraNormalsTexture;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec4 res_1;
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
  float tmpvar_8;
  tmpvar_8 = mix (tmpvar_5.z, sqrt(dot (tmpvar_7, tmpvar_7)), unity_ShadowFadeCenterAndType.w);
  lightDir_3 = -(_LightDir.xyz);
  atten_2 = clamp ((texture2D (_ShadowMapTexture, tmpvar_4).x + clamp (
    ((tmpvar_8 * _LightShadowData.z) + _LightShadowData.w)
  , 0.0, 1.0)), 0.0, 1.0);
  vec4 tmpvar_9;
  tmpvar_9 = texture2D (_CameraNormalsTexture, tmpvar_4);
  vec3 tmpvar_10;
  tmpvar_10 = normalize(((tmpvar_9.xyz * 2.0) - 1.0));
  res_1.xyz = (_LightColor.xyz * (max (0.0, 
    dot (lightDir_3, tmpvar_10)
  ) * atten_2));
  vec3 c_11;
  c_11 = (_LightColor.xyz * unity_ColorSpaceLuminance.xyz);
  res_1.w = ((pow (
    max (0.0, dot (normalize((lightDir_3 - 
      normalize((tmpvar_6 - _WorldSpaceCameraPos))
    )), tmpvar_10))
  , 
    (tmpvar_9.w * 128.0)
  ) * clamp (atten_2, 0.0, 1.0)) * ((
    (c_11.x + c_11.y)
   + c_11.z) + (
    (2.0 * sqrt((c_11.y * (c_11.x + c_11.z))))
   * unity_ColorSpaceLuminance.w)));
  res_1 = (res_1 * clamp ((1.0 - 
    ((tmpvar_8 * unity_LightmapFade.z) + unity_LightmapFade.w)
  ), 0.0, 1.0));
  gl_FragData[0] = exp2(-(res_1));
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
uniform vec4 unity_LightmapFade;
uniform mat4 _CameraToWorld;
uniform mat4 _LightMatrix0;
uniform sampler2D _LightTexture0;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _CameraNormalsTexture;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec4 res_1;
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
  float tmpvar_8;
  tmpvar_8 = mix (tmpvar_5.z, sqrt(dot (tmpvar_7, tmpvar_7)), unity_ShadowFadeCenterAndType.w);
  lightDir_3 = -(_LightDir.xyz);
  atten_2 = clamp ((texture2D (_ShadowMapTexture, tmpvar_4).x + clamp (
    ((tmpvar_8 * _LightShadowData.z) + _LightShadowData.w)
  , 0.0, 1.0)), 0.0, 1.0);
  vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_6;
  vec4 tmpvar_10;
  tmpvar_10.zw = vec2(0.0, -8.0);
  tmpvar_10.xy = (_LightMatrix0 * tmpvar_9).xy;
  atten_2 = (atten_2 * texture2D (_LightTexture0, tmpvar_10.xy, -8.0).w);
  vec4 tmpvar_11;
  tmpvar_11 = texture2D (_CameraNormalsTexture, tmpvar_4);
  vec3 tmpvar_12;
  tmpvar_12 = normalize(((tmpvar_11.xyz * 2.0) - 1.0));
  res_1.xyz = (_LightColor.xyz * (max (0.0, 
    dot (lightDir_3, tmpvar_12)
  ) * atten_2));
  vec3 c_13;
  c_13 = (_LightColor.xyz * unity_ColorSpaceLuminance.xyz);
  res_1.w = ((pow (
    max (0.0, dot (normalize((lightDir_3 - 
      normalize((tmpvar_6 - _WorldSpaceCameraPos))
    )), tmpvar_12))
  , 
    (tmpvar_11.w * 128.0)
  ) * clamp (atten_2, 0.0, 1.0)) * ((
    (c_13.x + c_13.y)
   + c_13.z) + (
    (2.0 * sqrt((c_13.y * (c_13.x + c_13.z))))
   * unity_ColorSpaceLuminance.w)));
  res_1 = (res_1 * clamp ((1.0 - 
    ((tmpvar_8 * unity_LightmapFade.z) + unity_LightmapFade.w)
  ), 0.0, 1.0));
  gl_FragData[0] = exp2(-(res_1));
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
uniform vec4 unity_ShadowFadeCenterAndType;
uniform vec4 unity_ColorSpaceLuminance;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _LightPos;
uniform vec4 _LightColor;
uniform vec4 unity_LightmapFade;
uniform mat4 _CameraToWorld;
uniform sampler2D _LightTextureB0;
uniform samplerCube _ShadowMapTexture;
uniform sampler2D _CameraNormalsTexture;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec4 res_1;
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
  float tmpvar_8;
  tmpvar_8 = mix (tmpvar_5.z, sqrt(dot (tmpvar_7, tmpvar_7)), unity_ShadowFadeCenterAndType.w);
  vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_6 - _LightPos.xyz);
  lightDir_3 = -(normalize(tmpvar_9));
  atten_2 = texture2D (_LightTextureB0, vec2((dot (tmpvar_9, tmpvar_9) * _LightPos.w))).w;
  float mydist_10;
  mydist_10 = ((sqrt(
    dot (tmpvar_9, tmpvar_9)
  ) * _LightPositionRange.w) * 0.97);
  vec4 tmpvar_11;
  tmpvar_11 = textureCube (_ShadowMapTexture, tmpvar_9);
  float tmpvar_12;
  if ((tmpvar_11.x < mydist_10)) {
    tmpvar_12 = _LightShadowData.x;
  } else {
    tmpvar_12 = 1.0;
  };
  atten_2 = (atten_2 * tmpvar_12);
  vec4 tmpvar_13;
  tmpvar_13 = texture2D (_CameraNormalsTexture, tmpvar_4);
  vec3 tmpvar_14;
  tmpvar_14 = normalize(((tmpvar_13.xyz * 2.0) - 1.0));
  res_1.xyz = (_LightColor.xyz * (max (0.0, 
    dot (lightDir_3, tmpvar_14)
  ) * atten_2));
  vec3 c_15;
  c_15 = (_LightColor.xyz * unity_ColorSpaceLuminance.xyz);
  res_1.w = ((pow (
    max (0.0, dot (normalize((lightDir_3 - 
      normalize((tmpvar_6 - _WorldSpaceCameraPos))
    )), tmpvar_14))
  , 
    (tmpvar_13.w * 128.0)
  ) * clamp (atten_2, 0.0, 1.0)) * ((
    (c_15.x + c_15.y)
   + c_15.z) + (
    (2.0 * sqrt((c_15.y * (c_15.x + c_15.z))))
   * unity_ColorSpaceLuminance.w)));
  res_1 = (res_1 * clamp ((1.0 - 
    ((tmpvar_8 * unity_LightmapFade.z) + unity_LightmapFade.w)
  ), 0.0, 1.0));
  gl_FragData[0] = exp2(-(res_1));
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
uniform vec4 unity_ShadowFadeCenterAndType;
uniform vec4 unity_ColorSpaceLuminance;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _LightPos;
uniform vec4 _LightColor;
uniform vec4 unity_LightmapFade;
uniform mat4 _CameraToWorld;
uniform mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
uniform samplerCube _ShadowMapTexture;
uniform sampler2D _CameraNormalsTexture;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec4 res_1;
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
  float tmpvar_8;
  tmpvar_8 = mix (tmpvar_5.z, sqrt(dot (tmpvar_7, tmpvar_7)), unity_ShadowFadeCenterAndType.w);
  vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_6 - _LightPos.xyz);
  lightDir_3 = -(normalize(tmpvar_9));
  atten_2 = texture2D (_LightTextureB0, vec2((dot (tmpvar_9, tmpvar_9) * _LightPos.w))).w;
  float mydist_10;
  mydist_10 = ((sqrt(
    dot (tmpvar_9, tmpvar_9)
  ) * _LightPositionRange.w) * 0.97);
  vec4 tmpvar_11;
  tmpvar_11 = textureCube (_ShadowMapTexture, tmpvar_9);
  float tmpvar_12;
  if ((tmpvar_11.x < mydist_10)) {
    tmpvar_12 = _LightShadowData.x;
  } else {
    tmpvar_12 = 1.0;
  };
  atten_2 = (atten_2 * tmpvar_12);
  vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_6;
  vec4 tmpvar_14;
  tmpvar_14.w = -8.0;
  tmpvar_14.xyz = (_LightMatrix0 * tmpvar_13).xyz;
  atten_2 = (atten_2 * textureCube (_LightTexture0, tmpvar_14.xyz, -8.0).w);
  vec4 tmpvar_15;
  tmpvar_15 = texture2D (_CameraNormalsTexture, tmpvar_4);
  vec3 tmpvar_16;
  tmpvar_16 = normalize(((tmpvar_15.xyz * 2.0) - 1.0));
  res_1.xyz = (_LightColor.xyz * (max (0.0, 
    dot (lightDir_3, tmpvar_16)
  ) * atten_2));
  vec3 c_17;
  c_17 = (_LightColor.xyz * unity_ColorSpaceLuminance.xyz);
  res_1.w = ((pow (
    max (0.0, dot (normalize((lightDir_3 - 
      normalize((tmpvar_6 - _WorldSpaceCameraPos))
    )), tmpvar_16))
  , 
    (tmpvar_15.w * 128.0)
  ) * clamp (atten_2, 0.0, 1.0)) * ((
    (c_17.x + c_17.y)
   + c_17.z) + (
    (2.0 * sqrt((c_17.y * (c_17.x + c_17.z))))
   * unity_ColorSpaceLuminance.w)));
  res_1 = (res_1 * clamp ((1.0 - 
    ((tmpvar_8 * unity_LightmapFade.z) + unity_LightmapFade.w)
  ), 0.0, 1.0));
  gl_FragData[0] = exp2(-(res_1));
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
uniform vec4 unity_LightmapFade;
uniform mat4 _CameraToWorld;
uniform mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform sampler2DShadow _ShadowMapTexture;
uniform vec4 _ShadowOffsets[4];
uniform sampler2D _CameraNormalsTexture;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec4 res_1;
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
  float tmpvar_8;
  tmpvar_8 = mix (tmpvar_5.z, sqrt(dot (tmpvar_7, tmpvar_7)), unity_ShadowFadeCenterAndType.w);
  vec3 tmpvar_9;
  tmpvar_9 = (_LightPos.xyz - tmpvar_6);
  lightDir_3 = normalize(tmpvar_9);
  vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_6;
  vec4 tmpvar_11;
  tmpvar_11 = (_LightMatrix0 * tmpvar_10);
  vec4 tmpvar_12;
  tmpvar_12.zw = vec2(0.0, -8.0);
  tmpvar_12.xy = (tmpvar_11.xy / tmpvar_11.w);
  atten_2 = (texture2D (_LightTexture0, tmpvar_12.xy, -8.0).w * float((tmpvar_11.w < 0.0)));
  atten_2 = (atten_2 * texture2D (_LightTextureB0, vec2((dot (tmpvar_9, tmpvar_9) * _LightPos.w))).w);
  vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_6;
  vec4 tmpvar_14;
  tmpvar_14 = (unity_World2Shadow[0] * tmpvar_13);
  vec4 shadows_15;
  vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_14.xyz / tmpvar_14.w);
  shadows_15.x = shadow2D (_ShadowMapTexture, (tmpvar_16 + _ShadowOffsets[0].xyz)).x;
  shadows_15.y = shadow2D (_ShadowMapTexture, (tmpvar_16 + _ShadowOffsets[1].xyz)).x;
  shadows_15.z = shadow2D (_ShadowMapTexture, (tmpvar_16 + _ShadowOffsets[2].xyz)).x;
  shadows_15.w = shadow2D (_ShadowMapTexture, (tmpvar_16 + _ShadowOffsets[3].xyz)).x;
  shadows_15 = (_LightShadowData.xxxx + (shadows_15 * (1.0 - _LightShadowData.xxxx)));
  atten_2 = (atten_2 * clamp ((
    dot (shadows_15, vec4(0.25, 0.25, 0.25, 0.25))
   + 
    clamp (((tmpvar_8 * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0)
  ), 0.0, 1.0));
  vec4 tmpvar_17;
  tmpvar_17 = texture2D (_CameraNormalsTexture, tmpvar_4);
  vec3 tmpvar_18;
  tmpvar_18 = normalize(((tmpvar_17.xyz * 2.0) - 1.0));
  res_1.xyz = (_LightColor.xyz * (max (0.0, 
    dot (lightDir_3, tmpvar_18)
  ) * atten_2));
  vec3 c_19;
  c_19 = (_LightColor.xyz * unity_ColorSpaceLuminance.xyz);
  res_1.w = ((pow (
    max (0.0, dot (normalize((lightDir_3 - 
      normalize((tmpvar_6 - _WorldSpaceCameraPos))
    )), tmpvar_18))
  , 
    (tmpvar_17.w * 128.0)
  ) * clamp (atten_2, 0.0, 1.0)) * ((
    (c_19.x + c_19.y)
   + c_19.z) + (
    (2.0 * sqrt((c_19.y * (c_19.x + c_19.z))))
   * unity_ColorSpaceLuminance.w)));
  res_1 = (res_1 * clamp ((1.0 - 
    ((tmpvar_8 * unity_LightmapFade.z) + unity_LightmapFade.w)
  ), 0.0, 1.0));
  gl_FragData[0] = exp2(-(res_1));
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
uniform vec4 unity_ShadowFadeCenterAndType;
uniform vec4 unity_ColorSpaceLuminance;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _LightPos;
uniform vec4 _LightColor;
uniform vec4 unity_LightmapFade;
uniform mat4 _CameraToWorld;
uniform sampler2D _LightTextureB0;
uniform samplerCube _ShadowMapTexture;
uniform sampler2D _CameraNormalsTexture;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec4 res_1;
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
  float tmpvar_8;
  tmpvar_8 = mix (tmpvar_5.z, sqrt(dot (tmpvar_7, tmpvar_7)), unity_ShadowFadeCenterAndType.w);
  vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_6 - _LightPos.xyz);
  lightDir_3 = -(normalize(tmpvar_9));
  atten_2 = texture2D (_LightTextureB0, vec2((dot (tmpvar_9, tmpvar_9) * _LightPos.w))).w;
  vec4 shadowVals_10;
  shadowVals_10.x = textureCube (_ShadowMapTexture, (tmpvar_9 + vec3(0.0078125, 0.0078125, 0.0078125))).x;
  shadowVals_10.y = textureCube (_ShadowMapTexture, (tmpvar_9 + vec3(-0.0078125, -0.0078125, 0.0078125))).x;
  shadowVals_10.z = textureCube (_ShadowMapTexture, (tmpvar_9 + vec3(-0.0078125, 0.0078125, -0.0078125))).x;
  shadowVals_10.w = textureCube (_ShadowMapTexture, (tmpvar_9 + vec3(0.0078125, -0.0078125, -0.0078125))).x;
  bvec4 tmpvar_11;
  tmpvar_11 = lessThan (shadowVals_10, vec4(((
    sqrt(dot (tmpvar_9, tmpvar_9))
   * _LightPositionRange.w) * 0.97)));
  vec4 tmpvar_12;
  tmpvar_12 = _LightShadowData.xxxx;
  float tmpvar_13;
  if (tmpvar_11.x) {
    tmpvar_13 = tmpvar_12.x;
  } else {
    tmpvar_13 = 1.0;
  };
  float tmpvar_14;
  if (tmpvar_11.y) {
    tmpvar_14 = tmpvar_12.y;
  } else {
    tmpvar_14 = 1.0;
  };
  float tmpvar_15;
  if (tmpvar_11.z) {
    tmpvar_15 = tmpvar_12.z;
  } else {
    tmpvar_15 = 1.0;
  };
  float tmpvar_16;
  if (tmpvar_11.w) {
    tmpvar_16 = tmpvar_12.w;
  } else {
    tmpvar_16 = 1.0;
  };
  vec4 tmpvar_17;
  tmpvar_17.x = tmpvar_13;
  tmpvar_17.y = tmpvar_14;
  tmpvar_17.z = tmpvar_15;
  tmpvar_17.w = tmpvar_16;
  atten_2 = (atten_2 * dot (tmpvar_17, vec4(0.25, 0.25, 0.25, 0.25)));
  vec4 tmpvar_18;
  tmpvar_18 = texture2D (_CameraNormalsTexture, tmpvar_4);
  vec3 tmpvar_19;
  tmpvar_19 = normalize(((tmpvar_18.xyz * 2.0) - 1.0));
  res_1.xyz = (_LightColor.xyz * (max (0.0, 
    dot (lightDir_3, tmpvar_19)
  ) * atten_2));
  vec3 c_20;
  c_20 = (_LightColor.xyz * unity_ColorSpaceLuminance.xyz);
  res_1.w = ((pow (
    max (0.0, dot (normalize((lightDir_3 - 
      normalize((tmpvar_6 - _WorldSpaceCameraPos))
    )), tmpvar_19))
  , 
    (tmpvar_18.w * 128.0)
  ) * clamp (atten_2, 0.0, 1.0)) * ((
    (c_20.x + c_20.y)
   + c_20.z) + (
    (2.0 * sqrt((c_20.y * (c_20.x + c_20.z))))
   * unity_ColorSpaceLuminance.w)));
  res_1 = (res_1 * clamp ((1.0 - 
    ((tmpvar_8 * unity_LightmapFade.z) + unity_LightmapFade.w)
  ), 0.0, 1.0));
  gl_FragData[0] = exp2(-(res_1));
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
uniform vec4 unity_ShadowFadeCenterAndType;
uniform vec4 unity_ColorSpaceLuminance;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _LightPos;
uniform vec4 _LightColor;
uniform vec4 unity_LightmapFade;
uniform mat4 _CameraToWorld;
uniform mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
uniform samplerCube _ShadowMapTexture;
uniform sampler2D _CameraNormalsTexture;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec4 res_1;
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
  float tmpvar_8;
  tmpvar_8 = mix (tmpvar_5.z, sqrt(dot (tmpvar_7, tmpvar_7)), unity_ShadowFadeCenterAndType.w);
  vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_6 - _LightPos.xyz);
  lightDir_3 = -(normalize(tmpvar_9));
  atten_2 = texture2D (_LightTextureB0, vec2((dot (tmpvar_9, tmpvar_9) * _LightPos.w))).w;
  vec4 shadowVals_10;
  shadowVals_10.x = textureCube (_ShadowMapTexture, (tmpvar_9 + vec3(0.0078125, 0.0078125, 0.0078125))).x;
  shadowVals_10.y = textureCube (_ShadowMapTexture, (tmpvar_9 + vec3(-0.0078125, -0.0078125, 0.0078125))).x;
  shadowVals_10.z = textureCube (_ShadowMapTexture, (tmpvar_9 + vec3(-0.0078125, 0.0078125, -0.0078125))).x;
  shadowVals_10.w = textureCube (_ShadowMapTexture, (tmpvar_9 + vec3(0.0078125, -0.0078125, -0.0078125))).x;
  bvec4 tmpvar_11;
  tmpvar_11 = lessThan (shadowVals_10, vec4(((
    sqrt(dot (tmpvar_9, tmpvar_9))
   * _LightPositionRange.w) * 0.97)));
  vec4 tmpvar_12;
  tmpvar_12 = _LightShadowData.xxxx;
  float tmpvar_13;
  if (tmpvar_11.x) {
    tmpvar_13 = tmpvar_12.x;
  } else {
    tmpvar_13 = 1.0;
  };
  float tmpvar_14;
  if (tmpvar_11.y) {
    tmpvar_14 = tmpvar_12.y;
  } else {
    tmpvar_14 = 1.0;
  };
  float tmpvar_15;
  if (tmpvar_11.z) {
    tmpvar_15 = tmpvar_12.z;
  } else {
    tmpvar_15 = 1.0;
  };
  float tmpvar_16;
  if (tmpvar_11.w) {
    tmpvar_16 = tmpvar_12.w;
  } else {
    tmpvar_16 = 1.0;
  };
  vec4 tmpvar_17;
  tmpvar_17.x = tmpvar_13;
  tmpvar_17.y = tmpvar_14;
  tmpvar_17.z = tmpvar_15;
  tmpvar_17.w = tmpvar_16;
  atten_2 = (atten_2 * dot (tmpvar_17, vec4(0.25, 0.25, 0.25, 0.25)));
  vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = tmpvar_6;
  vec4 tmpvar_19;
  tmpvar_19.w = -8.0;
  tmpvar_19.xyz = (_LightMatrix0 * tmpvar_18).xyz;
  atten_2 = (atten_2 * textureCube (_LightTexture0, tmpvar_19.xyz, -8.0).w);
  vec4 tmpvar_20;
  tmpvar_20 = texture2D (_CameraNormalsTexture, tmpvar_4);
  vec3 tmpvar_21;
  tmpvar_21 = normalize(((tmpvar_20.xyz * 2.0) - 1.0));
  res_1.xyz = (_LightColor.xyz * (max (0.0, 
    dot (lightDir_3, tmpvar_21)
  ) * atten_2));
  vec3 c_22;
  c_22 = (_LightColor.xyz * unity_ColorSpaceLuminance.xyz);
  res_1.w = ((pow (
    max (0.0, dot (normalize((lightDir_3 - 
      normalize((tmpvar_6 - _WorldSpaceCameraPos))
    )), tmpvar_21))
  , 
    (tmpvar_20.w * 128.0)
  ) * clamp (atten_2, 0.0, 1.0)) * ((
    (c_22.x + c_22.y)
   + c_22.z) + (
    (2.0 * sqrt((c_22.y * (c_22.x + c_22.z))))
   * unity_ColorSpaceLuminance.w)));
  res_1 = (res_1 * clamp ((1.0 - 
    ((tmpvar_8 * unity_LightmapFade.z) + unity_LightmapFade.w)
  ), 0.0, 1.0));
  gl_FragData[0] = exp2(-(res_1));
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
}
 }
 Pass {
  Tags { "SHADOWSUPPORT"="true" }
  ZWrite Off
  Blend One One
  GpuProgramID 113408
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
uniform vec4 unity_ShadowFadeCenterAndType;
uniform vec4 unity_ColorSpaceLuminance;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _LightPos;
uniform vec4 _LightColor;
uniform vec4 unity_LightmapFade;
uniform mat4 _CameraToWorld;
uniform sampler2D _LightTextureB0;
uniform sampler2D _CameraNormalsTexture;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec4 res_1;
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
  tmpvar_5 = (tmpvar_4 - unity_ShadowFadeCenterAndType.xyz);
  vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_4 - _LightPos.xyz);
  vec3 tmpvar_7;
  tmpvar_7 = -(normalize(tmpvar_6));
  vec4 tmpvar_8;
  tmpvar_8 = texture2D (_LightTextureB0, vec2((dot (tmpvar_6, tmpvar_6) * _LightPos.w)));
  vec4 tmpvar_9;
  tmpvar_9 = texture2D (_CameraNormalsTexture, tmpvar_2);
  vec3 tmpvar_10;
  tmpvar_10 = normalize(((tmpvar_9.xyz * 2.0) - 1.0));
  res_1.xyz = (_LightColor.xyz * (max (0.0, 
    dot (tmpvar_7, tmpvar_10)
  ) * tmpvar_8.w));
  vec3 c_11;
  c_11 = (_LightColor.xyz * unity_ColorSpaceLuminance.xyz);
  res_1.w = ((pow (
    max (0.0, dot (normalize((tmpvar_7 - 
      normalize((tmpvar_4 - _WorldSpaceCameraPos))
    )), tmpvar_10))
  , 
    (tmpvar_9.w * 128.0)
  ) * clamp (tmpvar_8.w, 0.0, 1.0)) * ((
    (c_11.x + c_11.y)
   + c_11.z) + (
    (2.0 * sqrt((c_11.y * (c_11.x + c_11.z))))
   * unity_ColorSpaceLuminance.w)));
  res_1 = (res_1 * clamp ((1.0 - 
    ((mix (tmpvar_3.z, sqrt(
      dot (tmpvar_5, tmpvar_5)
    ), unity_ShadowFadeCenterAndType.w) * unity_LightmapFade.z) + unity_LightmapFade.w)
  ), 0.0, 1.0));
  gl_FragData[0] = res_1;
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
uniform vec4 unity_ShadowFadeCenterAndType;
uniform vec4 unity_ColorSpaceLuminance;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _LightDir;
uniform vec4 _LightColor;
uniform vec4 unity_LightmapFade;
uniform mat4 _CameraToWorld;
uniform sampler2D _CameraNormalsTexture;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec4 res_1;
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
  tmpvar_5 = (tmpvar_4 - unity_ShadowFadeCenterAndType.xyz);
  vec3 tmpvar_6;
  tmpvar_6 = -(_LightDir.xyz);
  vec4 tmpvar_7;
  tmpvar_7 = texture2D (_CameraNormalsTexture, tmpvar_2);
  vec3 tmpvar_8;
  tmpvar_8 = normalize(((tmpvar_7.xyz * 2.0) - 1.0));
  res_1.xyz = (_LightColor.xyz * max (0.0, dot (tmpvar_6, tmpvar_8)));
  vec3 c_9;
  c_9 = (_LightColor.xyz * unity_ColorSpaceLuminance.xyz);
  res_1.w = ((pow (
    max (0.0, dot (normalize((tmpvar_6 - 
      normalize((tmpvar_4 - _WorldSpaceCameraPos))
    )), tmpvar_8))
  , 
    (tmpvar_7.w * 128.0)
  ) * clamp (1.0, 0.0, 1.0)) * ((
    (c_9.x + c_9.y)
   + c_9.z) + (
    (2.0 * sqrt((c_9.y * (c_9.x + c_9.z))))
   * unity_ColorSpaceLuminance.w)));
  res_1 = (res_1 * clamp ((1.0 - 
    ((mix (tmpvar_3.z, sqrt(
      dot (tmpvar_5, tmpvar_5)
    ), unity_ShadowFadeCenterAndType.w) * unity_LightmapFade.z) + unity_LightmapFade.w)
  ), 0.0, 1.0));
  gl_FragData[0] = res_1;
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
uniform vec4 unity_ShadowFadeCenterAndType;
uniform vec4 unity_ColorSpaceLuminance;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _LightPos;
uniform vec4 _LightColor;
uniform vec4 unity_LightmapFade;
uniform mat4 _CameraToWorld;
uniform mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform sampler2D _CameraNormalsTexture;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec4 res_1;
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
  tmpvar_6 = (tmpvar_5 - unity_ShadowFadeCenterAndType.xyz);
  vec3 tmpvar_7;
  tmpvar_7 = (_LightPos.xyz - tmpvar_5);
  vec3 tmpvar_8;
  tmpvar_8 = normalize(tmpvar_7);
  vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_5;
  vec4 tmpvar_10;
  tmpvar_10 = (_LightMatrix0 * tmpvar_9);
  vec4 tmpvar_11;
  tmpvar_11.zw = vec2(0.0, -8.0);
  tmpvar_11.xy = (tmpvar_10.xy / tmpvar_10.w);
  atten_2 = (texture2D (_LightTexture0, tmpvar_11.xy, -8.0).w * float((tmpvar_10.w < 0.0)));
  atten_2 = (atten_2 * texture2D (_LightTextureB0, vec2((dot (tmpvar_7, tmpvar_7) * _LightPos.w))).w);
  vec4 tmpvar_12;
  tmpvar_12 = texture2D (_CameraNormalsTexture, tmpvar_3);
  vec3 tmpvar_13;
  tmpvar_13 = normalize(((tmpvar_12.xyz * 2.0) - 1.0));
  res_1.xyz = (_LightColor.xyz * (max (0.0, 
    dot (tmpvar_8, tmpvar_13)
  ) * atten_2));
  vec3 c_14;
  c_14 = (_LightColor.xyz * unity_ColorSpaceLuminance.xyz);
  res_1.w = ((pow (
    max (0.0, dot (normalize((tmpvar_8 - 
      normalize((tmpvar_5 - _WorldSpaceCameraPos))
    )), tmpvar_13))
  , 
    (tmpvar_12.w * 128.0)
  ) * clamp (atten_2, 0.0, 1.0)) * ((
    (c_14.x + c_14.y)
   + c_14.z) + (
    (2.0 * sqrt((c_14.y * (c_14.x + c_14.z))))
   * unity_ColorSpaceLuminance.w)));
  res_1 = (res_1 * clamp ((1.0 - 
    ((mix (tmpvar_4.z, sqrt(
      dot (tmpvar_6, tmpvar_6)
    ), unity_ShadowFadeCenterAndType.w) * unity_LightmapFade.z) + unity_LightmapFade.w)
  ), 0.0, 1.0));
  gl_FragData[0] = res_1;
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
uniform vec4 unity_ShadowFadeCenterAndType;
uniform vec4 unity_ColorSpaceLuminance;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _LightPos;
uniform vec4 _LightColor;
uniform vec4 unity_LightmapFade;
uniform mat4 _CameraToWorld;
uniform mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
uniform sampler2D _CameraNormalsTexture;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec4 res_1;
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
  tmpvar_6 = (tmpvar_5 - unity_ShadowFadeCenterAndType.xyz);
  vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_5 - _LightPos.xyz);
  vec3 tmpvar_8;
  tmpvar_8 = -(normalize(tmpvar_7));
  vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_5;
  vec4 tmpvar_10;
  tmpvar_10.w = -8.0;
  tmpvar_10.xyz = (_LightMatrix0 * tmpvar_9).xyz;
  atten_2 = (texture2D (_LightTextureB0, vec2((dot (tmpvar_7, tmpvar_7) * _LightPos.w))).w * textureCube (_LightTexture0, tmpvar_10.xyz, -8.0).w);
  vec4 tmpvar_11;
  tmpvar_11 = texture2D (_CameraNormalsTexture, tmpvar_3);
  vec3 tmpvar_12;
  tmpvar_12 = normalize(((tmpvar_11.xyz * 2.0) - 1.0));
  res_1.xyz = (_LightColor.xyz * (max (0.0, 
    dot (tmpvar_8, tmpvar_12)
  ) * atten_2));
  vec3 c_13;
  c_13 = (_LightColor.xyz * unity_ColorSpaceLuminance.xyz);
  res_1.w = ((pow (
    max (0.0, dot (normalize((tmpvar_8 - 
      normalize((tmpvar_5 - _WorldSpaceCameraPos))
    )), tmpvar_12))
  , 
    (tmpvar_11.w * 128.0)
  ) * clamp (atten_2, 0.0, 1.0)) * ((
    (c_13.x + c_13.y)
   + c_13.z) + (
    (2.0 * sqrt((c_13.y * (c_13.x + c_13.z))))
   * unity_ColorSpaceLuminance.w)));
  res_1 = (res_1 * clamp ((1.0 - 
    ((mix (tmpvar_4.z, sqrt(
      dot (tmpvar_6, tmpvar_6)
    ), unity_ShadowFadeCenterAndType.w) * unity_LightmapFade.z) + unity_LightmapFade.w)
  ), 0.0, 1.0));
  gl_FragData[0] = res_1;
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
uniform vec4 unity_ShadowFadeCenterAndType;
uniform vec4 unity_ColorSpaceLuminance;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _LightDir;
uniform vec4 _LightColor;
uniform vec4 unity_LightmapFade;
uniform mat4 _CameraToWorld;
uniform mat4 _LightMatrix0;
uniform sampler2D _LightTexture0;
uniform sampler2D _CameraNormalsTexture;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec4 res_1;
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
  tmpvar_6 = (tmpvar_5 - unity_ShadowFadeCenterAndType.xyz);
  vec3 tmpvar_7;
  tmpvar_7 = -(_LightDir.xyz);
  vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_5;
  vec4 tmpvar_9;
  tmpvar_9.zw = vec2(0.0, -8.0);
  tmpvar_9.xy = (_LightMatrix0 * tmpvar_8).xy;
  atten_2 = texture2D (_LightTexture0, tmpvar_9.xy, -8.0).w;
  vec4 tmpvar_10;
  tmpvar_10 = texture2D (_CameraNormalsTexture, tmpvar_3);
  vec3 tmpvar_11;
  tmpvar_11 = normalize(((tmpvar_10.xyz * 2.0) - 1.0));
  res_1.xyz = (_LightColor.xyz * (max (0.0, 
    dot (tmpvar_7, tmpvar_11)
  ) * atten_2));
  vec3 c_12;
  c_12 = (_LightColor.xyz * unity_ColorSpaceLuminance.xyz);
  res_1.w = ((pow (
    max (0.0, dot (normalize((tmpvar_7 - 
      normalize((tmpvar_5 - _WorldSpaceCameraPos))
    )), tmpvar_11))
  , 
    (tmpvar_10.w * 128.0)
  ) * clamp (atten_2, 0.0, 1.0)) * ((
    (c_12.x + c_12.y)
   + c_12.z) + (
    (2.0 * sqrt((c_12.y * (c_12.x + c_12.z))))
   * unity_ColorSpaceLuminance.w)));
  res_1 = (res_1 * clamp ((1.0 - 
    ((mix (tmpvar_4.z, sqrt(
      dot (tmpvar_6, tmpvar_6)
    ), unity_ShadowFadeCenterAndType.w) * unity_LightmapFade.z) + unity_LightmapFade.w)
  ), 0.0, 1.0));
  gl_FragData[0] = res_1;
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
uniform vec4 unity_LightmapFade;
uniform mat4 _CameraToWorld;
uniform mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform sampler2DShadow _ShadowMapTexture;
uniform sampler2D _CameraNormalsTexture;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec4 res_1;
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
  float tmpvar_8;
  tmpvar_8 = mix (tmpvar_5.z, sqrt(dot (tmpvar_7, tmpvar_7)), unity_ShadowFadeCenterAndType.w);
  vec3 tmpvar_9;
  tmpvar_9 = (_LightPos.xyz - tmpvar_6);
  lightDir_3 = normalize(tmpvar_9);
  vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_6;
  vec4 tmpvar_11;
  tmpvar_11 = (_LightMatrix0 * tmpvar_10);
  vec4 tmpvar_12;
  tmpvar_12.zw = vec2(0.0, -8.0);
  tmpvar_12.xy = (tmpvar_11.xy / tmpvar_11.w);
  atten_2 = (texture2D (_LightTexture0, tmpvar_12.xy, -8.0).w * float((tmpvar_11.w < 0.0)));
  atten_2 = (atten_2 * texture2D (_LightTextureB0, vec2((dot (tmpvar_9, tmpvar_9) * _LightPos.w))).w);
  vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_6;
  atten_2 = (atten_2 * clamp ((
    (_LightShadowData.x + (shadow2DProj (_ShadowMapTexture, (unity_World2Shadow[0] * tmpvar_13)).x * (1.0 - _LightShadowData.x)))
   + 
    clamp (((tmpvar_8 * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0)
  ), 0.0, 1.0));
  vec4 tmpvar_14;
  tmpvar_14 = texture2D (_CameraNormalsTexture, tmpvar_4);
  vec3 tmpvar_15;
  tmpvar_15 = normalize(((tmpvar_14.xyz * 2.0) - 1.0));
  res_1.xyz = (_LightColor.xyz * (max (0.0, 
    dot (lightDir_3, tmpvar_15)
  ) * atten_2));
  vec3 c_16;
  c_16 = (_LightColor.xyz * unity_ColorSpaceLuminance.xyz);
  res_1.w = ((pow (
    max (0.0, dot (normalize((lightDir_3 - 
      normalize((tmpvar_6 - _WorldSpaceCameraPos))
    )), tmpvar_15))
  , 
    (tmpvar_14.w * 128.0)
  ) * clamp (atten_2, 0.0, 1.0)) * ((
    (c_16.x + c_16.y)
   + c_16.z) + (
    (2.0 * sqrt((c_16.y * (c_16.x + c_16.z))))
   * unity_ColorSpaceLuminance.w)));
  res_1 = (res_1 * clamp ((1.0 - 
    ((tmpvar_8 * unity_LightmapFade.z) + unity_LightmapFade.w)
  ), 0.0, 1.0));
  gl_FragData[0] = res_1;
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
uniform vec4 unity_LightmapFade;
uniform mat4 _CameraToWorld;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _CameraNormalsTexture;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec4 res_1;
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
  float tmpvar_8;
  tmpvar_8 = mix (tmpvar_5.z, sqrt(dot (tmpvar_7, tmpvar_7)), unity_ShadowFadeCenterAndType.w);
  lightDir_3 = -(_LightDir.xyz);
  atten_2 = clamp ((texture2D (_ShadowMapTexture, tmpvar_4).x + clamp (
    ((tmpvar_8 * _LightShadowData.z) + _LightShadowData.w)
  , 0.0, 1.0)), 0.0, 1.0);
  vec4 tmpvar_9;
  tmpvar_9 = texture2D (_CameraNormalsTexture, tmpvar_4);
  vec3 tmpvar_10;
  tmpvar_10 = normalize(((tmpvar_9.xyz * 2.0) - 1.0));
  res_1.xyz = (_LightColor.xyz * (max (0.0, 
    dot (lightDir_3, tmpvar_10)
  ) * atten_2));
  vec3 c_11;
  c_11 = (_LightColor.xyz * unity_ColorSpaceLuminance.xyz);
  res_1.w = ((pow (
    max (0.0, dot (normalize((lightDir_3 - 
      normalize((tmpvar_6 - _WorldSpaceCameraPos))
    )), tmpvar_10))
  , 
    (tmpvar_9.w * 128.0)
  ) * clamp (atten_2, 0.0, 1.0)) * ((
    (c_11.x + c_11.y)
   + c_11.z) + (
    (2.0 * sqrt((c_11.y * (c_11.x + c_11.z))))
   * unity_ColorSpaceLuminance.w)));
  res_1 = (res_1 * clamp ((1.0 - 
    ((tmpvar_8 * unity_LightmapFade.z) + unity_LightmapFade.w)
  ), 0.0, 1.0));
  gl_FragData[0] = res_1;
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
uniform vec4 unity_LightmapFade;
uniform mat4 _CameraToWorld;
uniform mat4 _LightMatrix0;
uniform sampler2D _LightTexture0;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _CameraNormalsTexture;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec4 res_1;
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
  float tmpvar_8;
  tmpvar_8 = mix (tmpvar_5.z, sqrt(dot (tmpvar_7, tmpvar_7)), unity_ShadowFadeCenterAndType.w);
  lightDir_3 = -(_LightDir.xyz);
  atten_2 = clamp ((texture2D (_ShadowMapTexture, tmpvar_4).x + clamp (
    ((tmpvar_8 * _LightShadowData.z) + _LightShadowData.w)
  , 0.0, 1.0)), 0.0, 1.0);
  vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_6;
  vec4 tmpvar_10;
  tmpvar_10.zw = vec2(0.0, -8.0);
  tmpvar_10.xy = (_LightMatrix0 * tmpvar_9).xy;
  atten_2 = (atten_2 * texture2D (_LightTexture0, tmpvar_10.xy, -8.0).w);
  vec4 tmpvar_11;
  tmpvar_11 = texture2D (_CameraNormalsTexture, tmpvar_4);
  vec3 tmpvar_12;
  tmpvar_12 = normalize(((tmpvar_11.xyz * 2.0) - 1.0));
  res_1.xyz = (_LightColor.xyz * (max (0.0, 
    dot (lightDir_3, tmpvar_12)
  ) * atten_2));
  vec3 c_13;
  c_13 = (_LightColor.xyz * unity_ColorSpaceLuminance.xyz);
  res_1.w = ((pow (
    max (0.0, dot (normalize((lightDir_3 - 
      normalize((tmpvar_6 - _WorldSpaceCameraPos))
    )), tmpvar_12))
  , 
    (tmpvar_11.w * 128.0)
  ) * clamp (atten_2, 0.0, 1.0)) * ((
    (c_13.x + c_13.y)
   + c_13.z) + (
    (2.0 * sqrt((c_13.y * (c_13.x + c_13.z))))
   * unity_ColorSpaceLuminance.w)));
  res_1 = (res_1 * clamp ((1.0 - 
    ((tmpvar_8 * unity_LightmapFade.z) + unity_LightmapFade.w)
  ), 0.0, 1.0));
  gl_FragData[0] = res_1;
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
uniform vec4 unity_ShadowFadeCenterAndType;
uniform vec4 unity_ColorSpaceLuminance;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _LightPos;
uniform vec4 _LightColor;
uniform vec4 unity_LightmapFade;
uniform mat4 _CameraToWorld;
uniform sampler2D _LightTextureB0;
uniform samplerCube _ShadowMapTexture;
uniform sampler2D _CameraNormalsTexture;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec4 res_1;
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
  float tmpvar_8;
  tmpvar_8 = mix (tmpvar_5.z, sqrt(dot (tmpvar_7, tmpvar_7)), unity_ShadowFadeCenterAndType.w);
  vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_6 - _LightPos.xyz);
  lightDir_3 = -(normalize(tmpvar_9));
  atten_2 = texture2D (_LightTextureB0, vec2((dot (tmpvar_9, tmpvar_9) * _LightPos.w))).w;
  float mydist_10;
  mydist_10 = ((sqrt(
    dot (tmpvar_9, tmpvar_9)
  ) * _LightPositionRange.w) * 0.97);
  vec4 tmpvar_11;
  tmpvar_11 = textureCube (_ShadowMapTexture, tmpvar_9);
  float tmpvar_12;
  if ((tmpvar_11.x < mydist_10)) {
    tmpvar_12 = _LightShadowData.x;
  } else {
    tmpvar_12 = 1.0;
  };
  atten_2 = (atten_2 * tmpvar_12);
  vec4 tmpvar_13;
  tmpvar_13 = texture2D (_CameraNormalsTexture, tmpvar_4);
  vec3 tmpvar_14;
  tmpvar_14 = normalize(((tmpvar_13.xyz * 2.0) - 1.0));
  res_1.xyz = (_LightColor.xyz * (max (0.0, 
    dot (lightDir_3, tmpvar_14)
  ) * atten_2));
  vec3 c_15;
  c_15 = (_LightColor.xyz * unity_ColorSpaceLuminance.xyz);
  res_1.w = ((pow (
    max (0.0, dot (normalize((lightDir_3 - 
      normalize((tmpvar_6 - _WorldSpaceCameraPos))
    )), tmpvar_14))
  , 
    (tmpvar_13.w * 128.0)
  ) * clamp (atten_2, 0.0, 1.0)) * ((
    (c_15.x + c_15.y)
   + c_15.z) + (
    (2.0 * sqrt((c_15.y * (c_15.x + c_15.z))))
   * unity_ColorSpaceLuminance.w)));
  res_1 = (res_1 * clamp ((1.0 - 
    ((tmpvar_8 * unity_LightmapFade.z) + unity_LightmapFade.w)
  ), 0.0, 1.0));
  gl_FragData[0] = res_1;
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
uniform vec4 unity_ShadowFadeCenterAndType;
uniform vec4 unity_ColorSpaceLuminance;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _LightPos;
uniform vec4 _LightColor;
uniform vec4 unity_LightmapFade;
uniform mat4 _CameraToWorld;
uniform mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
uniform samplerCube _ShadowMapTexture;
uniform sampler2D _CameraNormalsTexture;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec4 res_1;
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
  float tmpvar_8;
  tmpvar_8 = mix (tmpvar_5.z, sqrt(dot (tmpvar_7, tmpvar_7)), unity_ShadowFadeCenterAndType.w);
  vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_6 - _LightPos.xyz);
  lightDir_3 = -(normalize(tmpvar_9));
  atten_2 = texture2D (_LightTextureB0, vec2((dot (tmpvar_9, tmpvar_9) * _LightPos.w))).w;
  float mydist_10;
  mydist_10 = ((sqrt(
    dot (tmpvar_9, tmpvar_9)
  ) * _LightPositionRange.w) * 0.97);
  vec4 tmpvar_11;
  tmpvar_11 = textureCube (_ShadowMapTexture, tmpvar_9);
  float tmpvar_12;
  if ((tmpvar_11.x < mydist_10)) {
    tmpvar_12 = _LightShadowData.x;
  } else {
    tmpvar_12 = 1.0;
  };
  atten_2 = (atten_2 * tmpvar_12);
  vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_6;
  vec4 tmpvar_14;
  tmpvar_14.w = -8.0;
  tmpvar_14.xyz = (_LightMatrix0 * tmpvar_13).xyz;
  atten_2 = (atten_2 * textureCube (_LightTexture0, tmpvar_14.xyz, -8.0).w);
  vec4 tmpvar_15;
  tmpvar_15 = texture2D (_CameraNormalsTexture, tmpvar_4);
  vec3 tmpvar_16;
  tmpvar_16 = normalize(((tmpvar_15.xyz * 2.0) - 1.0));
  res_1.xyz = (_LightColor.xyz * (max (0.0, 
    dot (lightDir_3, tmpvar_16)
  ) * atten_2));
  vec3 c_17;
  c_17 = (_LightColor.xyz * unity_ColorSpaceLuminance.xyz);
  res_1.w = ((pow (
    max (0.0, dot (normalize((lightDir_3 - 
      normalize((tmpvar_6 - _WorldSpaceCameraPos))
    )), tmpvar_16))
  , 
    (tmpvar_15.w * 128.0)
  ) * clamp (atten_2, 0.0, 1.0)) * ((
    (c_17.x + c_17.y)
   + c_17.z) + (
    (2.0 * sqrt((c_17.y * (c_17.x + c_17.z))))
   * unity_ColorSpaceLuminance.w)));
  res_1 = (res_1 * clamp ((1.0 - 
    ((tmpvar_8 * unity_LightmapFade.z) + unity_LightmapFade.w)
  ), 0.0, 1.0));
  gl_FragData[0] = res_1;
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
uniform vec4 unity_LightmapFade;
uniform mat4 _CameraToWorld;
uniform mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform sampler2DShadow _ShadowMapTexture;
uniform vec4 _ShadowOffsets[4];
uniform sampler2D _CameraNormalsTexture;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec4 res_1;
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
  float tmpvar_8;
  tmpvar_8 = mix (tmpvar_5.z, sqrt(dot (tmpvar_7, tmpvar_7)), unity_ShadowFadeCenterAndType.w);
  vec3 tmpvar_9;
  tmpvar_9 = (_LightPos.xyz - tmpvar_6);
  lightDir_3 = normalize(tmpvar_9);
  vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_6;
  vec4 tmpvar_11;
  tmpvar_11 = (_LightMatrix0 * tmpvar_10);
  vec4 tmpvar_12;
  tmpvar_12.zw = vec2(0.0, -8.0);
  tmpvar_12.xy = (tmpvar_11.xy / tmpvar_11.w);
  atten_2 = (texture2D (_LightTexture0, tmpvar_12.xy, -8.0).w * float((tmpvar_11.w < 0.0)));
  atten_2 = (atten_2 * texture2D (_LightTextureB0, vec2((dot (tmpvar_9, tmpvar_9) * _LightPos.w))).w);
  vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_6;
  vec4 tmpvar_14;
  tmpvar_14 = (unity_World2Shadow[0] * tmpvar_13);
  vec4 shadows_15;
  vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_14.xyz / tmpvar_14.w);
  shadows_15.x = shadow2D (_ShadowMapTexture, (tmpvar_16 + _ShadowOffsets[0].xyz)).x;
  shadows_15.y = shadow2D (_ShadowMapTexture, (tmpvar_16 + _ShadowOffsets[1].xyz)).x;
  shadows_15.z = shadow2D (_ShadowMapTexture, (tmpvar_16 + _ShadowOffsets[2].xyz)).x;
  shadows_15.w = shadow2D (_ShadowMapTexture, (tmpvar_16 + _ShadowOffsets[3].xyz)).x;
  shadows_15 = (_LightShadowData.xxxx + (shadows_15 * (1.0 - _LightShadowData.xxxx)));
  atten_2 = (atten_2 * clamp ((
    dot (shadows_15, vec4(0.25, 0.25, 0.25, 0.25))
   + 
    clamp (((tmpvar_8 * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0)
  ), 0.0, 1.0));
  vec4 tmpvar_17;
  tmpvar_17 = texture2D (_CameraNormalsTexture, tmpvar_4);
  vec3 tmpvar_18;
  tmpvar_18 = normalize(((tmpvar_17.xyz * 2.0) - 1.0));
  res_1.xyz = (_LightColor.xyz * (max (0.0, 
    dot (lightDir_3, tmpvar_18)
  ) * atten_2));
  vec3 c_19;
  c_19 = (_LightColor.xyz * unity_ColorSpaceLuminance.xyz);
  res_1.w = ((pow (
    max (0.0, dot (normalize((lightDir_3 - 
      normalize((tmpvar_6 - _WorldSpaceCameraPos))
    )), tmpvar_18))
  , 
    (tmpvar_17.w * 128.0)
  ) * clamp (atten_2, 0.0, 1.0)) * ((
    (c_19.x + c_19.y)
   + c_19.z) + (
    (2.0 * sqrt((c_19.y * (c_19.x + c_19.z))))
   * unity_ColorSpaceLuminance.w)));
  res_1 = (res_1 * clamp ((1.0 - 
    ((tmpvar_8 * unity_LightmapFade.z) + unity_LightmapFade.w)
  ), 0.0, 1.0));
  gl_FragData[0] = res_1;
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
uniform vec4 unity_ShadowFadeCenterAndType;
uniform vec4 unity_ColorSpaceLuminance;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _LightPos;
uniform vec4 _LightColor;
uniform vec4 unity_LightmapFade;
uniform mat4 _CameraToWorld;
uniform sampler2D _LightTextureB0;
uniform samplerCube _ShadowMapTexture;
uniform sampler2D _CameraNormalsTexture;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec4 res_1;
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
  float tmpvar_8;
  tmpvar_8 = mix (tmpvar_5.z, sqrt(dot (tmpvar_7, tmpvar_7)), unity_ShadowFadeCenterAndType.w);
  vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_6 - _LightPos.xyz);
  lightDir_3 = -(normalize(tmpvar_9));
  atten_2 = texture2D (_LightTextureB0, vec2((dot (tmpvar_9, tmpvar_9) * _LightPos.w))).w;
  vec4 shadowVals_10;
  shadowVals_10.x = textureCube (_ShadowMapTexture, (tmpvar_9 + vec3(0.0078125, 0.0078125, 0.0078125))).x;
  shadowVals_10.y = textureCube (_ShadowMapTexture, (tmpvar_9 + vec3(-0.0078125, -0.0078125, 0.0078125))).x;
  shadowVals_10.z = textureCube (_ShadowMapTexture, (tmpvar_9 + vec3(-0.0078125, 0.0078125, -0.0078125))).x;
  shadowVals_10.w = textureCube (_ShadowMapTexture, (tmpvar_9 + vec3(0.0078125, -0.0078125, -0.0078125))).x;
  bvec4 tmpvar_11;
  tmpvar_11 = lessThan (shadowVals_10, vec4(((
    sqrt(dot (tmpvar_9, tmpvar_9))
   * _LightPositionRange.w) * 0.97)));
  vec4 tmpvar_12;
  tmpvar_12 = _LightShadowData.xxxx;
  float tmpvar_13;
  if (tmpvar_11.x) {
    tmpvar_13 = tmpvar_12.x;
  } else {
    tmpvar_13 = 1.0;
  };
  float tmpvar_14;
  if (tmpvar_11.y) {
    tmpvar_14 = tmpvar_12.y;
  } else {
    tmpvar_14 = 1.0;
  };
  float tmpvar_15;
  if (tmpvar_11.z) {
    tmpvar_15 = tmpvar_12.z;
  } else {
    tmpvar_15 = 1.0;
  };
  float tmpvar_16;
  if (tmpvar_11.w) {
    tmpvar_16 = tmpvar_12.w;
  } else {
    tmpvar_16 = 1.0;
  };
  vec4 tmpvar_17;
  tmpvar_17.x = tmpvar_13;
  tmpvar_17.y = tmpvar_14;
  tmpvar_17.z = tmpvar_15;
  tmpvar_17.w = tmpvar_16;
  atten_2 = (atten_2 * dot (tmpvar_17, vec4(0.25, 0.25, 0.25, 0.25)));
  vec4 tmpvar_18;
  tmpvar_18 = texture2D (_CameraNormalsTexture, tmpvar_4);
  vec3 tmpvar_19;
  tmpvar_19 = normalize(((tmpvar_18.xyz * 2.0) - 1.0));
  res_1.xyz = (_LightColor.xyz * (max (0.0, 
    dot (lightDir_3, tmpvar_19)
  ) * atten_2));
  vec3 c_20;
  c_20 = (_LightColor.xyz * unity_ColorSpaceLuminance.xyz);
  res_1.w = ((pow (
    max (0.0, dot (normalize((lightDir_3 - 
      normalize((tmpvar_6 - _WorldSpaceCameraPos))
    )), tmpvar_19))
  , 
    (tmpvar_18.w * 128.0)
  ) * clamp (atten_2, 0.0, 1.0)) * ((
    (c_20.x + c_20.y)
   + c_20.z) + (
    (2.0 * sqrt((c_20.y * (c_20.x + c_20.z))))
   * unity_ColorSpaceLuminance.w)));
  res_1 = (res_1 * clamp ((1.0 - 
    ((tmpvar_8 * unity_LightmapFade.z) + unity_LightmapFade.w)
  ), 0.0, 1.0));
  gl_FragData[0] = res_1;
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
uniform vec4 unity_ShadowFadeCenterAndType;
uniform vec4 unity_ColorSpaceLuminance;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _LightPos;
uniform vec4 _LightColor;
uniform vec4 unity_LightmapFade;
uniform mat4 _CameraToWorld;
uniform mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
uniform samplerCube _ShadowMapTexture;
uniform sampler2D _CameraNormalsTexture;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec4 res_1;
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
  float tmpvar_8;
  tmpvar_8 = mix (tmpvar_5.z, sqrt(dot (tmpvar_7, tmpvar_7)), unity_ShadowFadeCenterAndType.w);
  vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_6 - _LightPos.xyz);
  lightDir_3 = -(normalize(tmpvar_9));
  atten_2 = texture2D (_LightTextureB0, vec2((dot (tmpvar_9, tmpvar_9) * _LightPos.w))).w;
  vec4 shadowVals_10;
  shadowVals_10.x = textureCube (_ShadowMapTexture, (tmpvar_9 + vec3(0.0078125, 0.0078125, 0.0078125))).x;
  shadowVals_10.y = textureCube (_ShadowMapTexture, (tmpvar_9 + vec3(-0.0078125, -0.0078125, 0.0078125))).x;
  shadowVals_10.z = textureCube (_ShadowMapTexture, (tmpvar_9 + vec3(-0.0078125, 0.0078125, -0.0078125))).x;
  shadowVals_10.w = textureCube (_ShadowMapTexture, (tmpvar_9 + vec3(0.0078125, -0.0078125, -0.0078125))).x;
  bvec4 tmpvar_11;
  tmpvar_11 = lessThan (shadowVals_10, vec4(((
    sqrt(dot (tmpvar_9, tmpvar_9))
   * _LightPositionRange.w) * 0.97)));
  vec4 tmpvar_12;
  tmpvar_12 = _LightShadowData.xxxx;
  float tmpvar_13;
  if (tmpvar_11.x) {
    tmpvar_13 = tmpvar_12.x;
  } else {
    tmpvar_13 = 1.0;
  };
  float tmpvar_14;
  if (tmpvar_11.y) {
    tmpvar_14 = tmpvar_12.y;
  } else {
    tmpvar_14 = 1.0;
  };
  float tmpvar_15;
  if (tmpvar_11.z) {
    tmpvar_15 = tmpvar_12.z;
  } else {
    tmpvar_15 = 1.0;
  };
  float tmpvar_16;
  if (tmpvar_11.w) {
    tmpvar_16 = tmpvar_12.w;
  } else {
    tmpvar_16 = 1.0;
  };
  vec4 tmpvar_17;
  tmpvar_17.x = tmpvar_13;
  tmpvar_17.y = tmpvar_14;
  tmpvar_17.z = tmpvar_15;
  tmpvar_17.w = tmpvar_16;
  atten_2 = (atten_2 * dot (tmpvar_17, vec4(0.25, 0.25, 0.25, 0.25)));
  vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = tmpvar_6;
  vec4 tmpvar_19;
  tmpvar_19.w = -8.0;
  tmpvar_19.xyz = (_LightMatrix0 * tmpvar_18).xyz;
  atten_2 = (atten_2 * textureCube (_LightTexture0, tmpvar_19.xyz, -8.0).w);
  vec4 tmpvar_20;
  tmpvar_20 = texture2D (_CameraNormalsTexture, tmpvar_4);
  vec3 tmpvar_21;
  tmpvar_21 = normalize(((tmpvar_20.xyz * 2.0) - 1.0));
  res_1.xyz = (_LightColor.xyz * (max (0.0, 
    dot (lightDir_3, tmpvar_21)
  ) * atten_2));
  vec3 c_22;
  c_22 = (_LightColor.xyz * unity_ColorSpaceLuminance.xyz);
  res_1.w = ((pow (
    max (0.0, dot (normalize((lightDir_3 - 
      normalize((tmpvar_6 - _WorldSpaceCameraPos))
    )), tmpvar_21))
  , 
    (tmpvar_20.w * 128.0)
  ) * clamp (atten_2, 0.0, 1.0)) * ((
    (c_22.x + c_22.y)
   + c_22.z) + (
    (2.0 * sqrt((c_22.y * (c_22.x + c_22.z))))
   * unity_ColorSpaceLuminance.w)));
  res_1 = (res_1 * clamp ((1.0 - 
    ((tmpvar_8 * unity_LightmapFade.z) + unity_LightmapFade.w)
  ), 0.0, 1.0));
  gl_FragData[0] = res_1;
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
}
 }
 Pass {
  Tags { "SHADOWSUPPORT"="true" }
  ZWrite Off
  Blend One One
  GpuProgramID 155461
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
uniform vec4 unity_ShadowFadeCenterAndType;
uniform vec4 unity_ColorSpaceLuminance;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _LightPos;
uniform vec4 _LightColor;
uniform vec4 unity_LightmapFade;
uniform mat4 _CameraToWorld;
uniform sampler2D _LightTextureB0;
uniform sampler2D _CameraNormalsTexture;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec4 res_1;
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
  tmpvar_5 = (tmpvar_4 - unity_ShadowFadeCenterAndType.xyz);
  vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_4 - _LightPos.xyz);
  vec3 tmpvar_7;
  tmpvar_7 = -(normalize(tmpvar_6));
  vec4 tmpvar_8;
  tmpvar_8 = texture2D (_LightTextureB0, vec2((dot (tmpvar_6, tmpvar_6) * _LightPos.w)));
  vec4 tmpvar_9;
  tmpvar_9 = texture2D (_CameraNormalsTexture, tmpvar_2);
  vec3 tmpvar_10;
  tmpvar_10 = normalize(((tmpvar_9.xyz * 2.0) - 1.0));
  res_1.xyz = (_LightColor.xyz * (max (0.0, 
    dot (tmpvar_7, tmpvar_10)
  ) * tmpvar_8.w));
  vec3 c_11;
  c_11 = (_LightColor.xyz * unity_ColorSpaceLuminance.xyz);
  res_1.w = ((pow (
    max (0.0, dot (normalize((tmpvar_7 - 
      normalize((tmpvar_4 - _WorldSpaceCameraPos))
    )), tmpvar_10))
  , 
    (tmpvar_9.w * 128.0)
  ) * clamp (tmpvar_8.w, 0.0, 1.0)) * ((
    (c_11.x + c_11.y)
   + c_11.z) + (
    (2.0 * sqrt((c_11.y * (c_11.x + c_11.z))))
   * unity_ColorSpaceLuminance.w)));
  res_1 = (res_1 * clamp ((1.0 - 
    ((mix (tmpvar_3.z, sqrt(
      dot (tmpvar_5, tmpvar_5)
    ), unity_ShadowFadeCenterAndType.w) * unity_LightmapFade.z) + unity_LightmapFade.w)
  ), 0.0, 1.0));
  gl_FragData[0] = res_1.wxyz;
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
uniform vec4 unity_ShadowFadeCenterAndType;
uniform vec4 unity_ColorSpaceLuminance;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _LightDir;
uniform vec4 _LightColor;
uniform vec4 unity_LightmapFade;
uniform mat4 _CameraToWorld;
uniform sampler2D _CameraNormalsTexture;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec4 res_1;
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
  tmpvar_5 = (tmpvar_4 - unity_ShadowFadeCenterAndType.xyz);
  vec3 tmpvar_6;
  tmpvar_6 = -(_LightDir.xyz);
  vec4 tmpvar_7;
  tmpvar_7 = texture2D (_CameraNormalsTexture, tmpvar_2);
  vec3 tmpvar_8;
  tmpvar_8 = normalize(((tmpvar_7.xyz * 2.0) - 1.0));
  res_1.xyz = (_LightColor.xyz * max (0.0, dot (tmpvar_6, tmpvar_8)));
  vec3 c_9;
  c_9 = (_LightColor.xyz * unity_ColorSpaceLuminance.xyz);
  res_1.w = ((pow (
    max (0.0, dot (normalize((tmpvar_6 - 
      normalize((tmpvar_4 - _WorldSpaceCameraPos))
    )), tmpvar_8))
  , 
    (tmpvar_7.w * 128.0)
  ) * clamp (1.0, 0.0, 1.0)) * ((
    (c_9.x + c_9.y)
   + c_9.z) + (
    (2.0 * sqrt((c_9.y * (c_9.x + c_9.z))))
   * unity_ColorSpaceLuminance.w)));
  res_1 = (res_1 * clamp ((1.0 - 
    ((mix (tmpvar_3.z, sqrt(
      dot (tmpvar_5, tmpvar_5)
    ), unity_ShadowFadeCenterAndType.w) * unity_LightmapFade.z) + unity_LightmapFade.w)
  ), 0.0, 1.0));
  gl_FragData[0] = res_1.wxyz;
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
uniform vec4 unity_ShadowFadeCenterAndType;
uniform vec4 unity_ColorSpaceLuminance;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _LightPos;
uniform vec4 _LightColor;
uniform vec4 unity_LightmapFade;
uniform mat4 _CameraToWorld;
uniform mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform sampler2D _CameraNormalsTexture;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec4 res_1;
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
  tmpvar_6 = (tmpvar_5 - unity_ShadowFadeCenterAndType.xyz);
  vec3 tmpvar_7;
  tmpvar_7 = (_LightPos.xyz - tmpvar_5);
  vec3 tmpvar_8;
  tmpvar_8 = normalize(tmpvar_7);
  vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_5;
  vec4 tmpvar_10;
  tmpvar_10 = (_LightMatrix0 * tmpvar_9);
  vec4 tmpvar_11;
  tmpvar_11.zw = vec2(0.0, -8.0);
  tmpvar_11.xy = (tmpvar_10.xy / tmpvar_10.w);
  atten_2 = (texture2D (_LightTexture0, tmpvar_11.xy, -8.0).w * float((tmpvar_10.w < 0.0)));
  atten_2 = (atten_2 * texture2D (_LightTextureB0, vec2((dot (tmpvar_7, tmpvar_7) * _LightPos.w))).w);
  vec4 tmpvar_12;
  tmpvar_12 = texture2D (_CameraNormalsTexture, tmpvar_3);
  vec3 tmpvar_13;
  tmpvar_13 = normalize(((tmpvar_12.xyz * 2.0) - 1.0));
  res_1.xyz = (_LightColor.xyz * (max (0.0, 
    dot (tmpvar_8, tmpvar_13)
  ) * atten_2));
  vec3 c_14;
  c_14 = (_LightColor.xyz * unity_ColorSpaceLuminance.xyz);
  res_1.w = ((pow (
    max (0.0, dot (normalize((tmpvar_8 - 
      normalize((tmpvar_5 - _WorldSpaceCameraPos))
    )), tmpvar_13))
  , 
    (tmpvar_12.w * 128.0)
  ) * clamp (atten_2, 0.0, 1.0)) * ((
    (c_14.x + c_14.y)
   + c_14.z) + (
    (2.0 * sqrt((c_14.y * (c_14.x + c_14.z))))
   * unity_ColorSpaceLuminance.w)));
  res_1 = (res_1 * clamp ((1.0 - 
    ((mix (tmpvar_4.z, sqrt(
      dot (tmpvar_6, tmpvar_6)
    ), unity_ShadowFadeCenterAndType.w) * unity_LightmapFade.z) + unity_LightmapFade.w)
  ), 0.0, 1.0));
  gl_FragData[0] = res_1.wxyz;
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
uniform vec4 unity_ShadowFadeCenterAndType;
uniform vec4 unity_ColorSpaceLuminance;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _LightPos;
uniform vec4 _LightColor;
uniform vec4 unity_LightmapFade;
uniform mat4 _CameraToWorld;
uniform mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
uniform sampler2D _CameraNormalsTexture;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec4 res_1;
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
  tmpvar_6 = (tmpvar_5 - unity_ShadowFadeCenterAndType.xyz);
  vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_5 - _LightPos.xyz);
  vec3 tmpvar_8;
  tmpvar_8 = -(normalize(tmpvar_7));
  vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_5;
  vec4 tmpvar_10;
  tmpvar_10.w = -8.0;
  tmpvar_10.xyz = (_LightMatrix0 * tmpvar_9).xyz;
  atten_2 = (texture2D (_LightTextureB0, vec2((dot (tmpvar_7, tmpvar_7) * _LightPos.w))).w * textureCube (_LightTexture0, tmpvar_10.xyz, -8.0).w);
  vec4 tmpvar_11;
  tmpvar_11 = texture2D (_CameraNormalsTexture, tmpvar_3);
  vec3 tmpvar_12;
  tmpvar_12 = normalize(((tmpvar_11.xyz * 2.0) - 1.0));
  res_1.xyz = (_LightColor.xyz * (max (0.0, 
    dot (tmpvar_8, tmpvar_12)
  ) * atten_2));
  vec3 c_13;
  c_13 = (_LightColor.xyz * unity_ColorSpaceLuminance.xyz);
  res_1.w = ((pow (
    max (0.0, dot (normalize((tmpvar_8 - 
      normalize((tmpvar_5 - _WorldSpaceCameraPos))
    )), tmpvar_12))
  , 
    (tmpvar_11.w * 128.0)
  ) * clamp (atten_2, 0.0, 1.0)) * ((
    (c_13.x + c_13.y)
   + c_13.z) + (
    (2.0 * sqrt((c_13.y * (c_13.x + c_13.z))))
   * unity_ColorSpaceLuminance.w)));
  res_1 = (res_1 * clamp ((1.0 - 
    ((mix (tmpvar_4.z, sqrt(
      dot (tmpvar_6, tmpvar_6)
    ), unity_ShadowFadeCenterAndType.w) * unity_LightmapFade.z) + unity_LightmapFade.w)
  ), 0.0, 1.0));
  gl_FragData[0] = res_1.wxyz;
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
uniform vec4 unity_ShadowFadeCenterAndType;
uniform vec4 unity_ColorSpaceLuminance;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _LightDir;
uniform vec4 _LightColor;
uniform vec4 unity_LightmapFade;
uniform mat4 _CameraToWorld;
uniform mat4 _LightMatrix0;
uniform sampler2D _LightTexture0;
uniform sampler2D _CameraNormalsTexture;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec4 res_1;
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
  tmpvar_6 = (tmpvar_5 - unity_ShadowFadeCenterAndType.xyz);
  vec3 tmpvar_7;
  tmpvar_7 = -(_LightDir.xyz);
  vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_5;
  vec4 tmpvar_9;
  tmpvar_9.zw = vec2(0.0, -8.0);
  tmpvar_9.xy = (_LightMatrix0 * tmpvar_8).xy;
  atten_2 = texture2D (_LightTexture0, tmpvar_9.xy, -8.0).w;
  vec4 tmpvar_10;
  tmpvar_10 = texture2D (_CameraNormalsTexture, tmpvar_3);
  vec3 tmpvar_11;
  tmpvar_11 = normalize(((tmpvar_10.xyz * 2.0) - 1.0));
  res_1.xyz = (_LightColor.xyz * (max (0.0, 
    dot (tmpvar_7, tmpvar_11)
  ) * atten_2));
  vec3 c_12;
  c_12 = (_LightColor.xyz * unity_ColorSpaceLuminance.xyz);
  res_1.w = ((pow (
    max (0.0, dot (normalize((tmpvar_7 - 
      normalize((tmpvar_5 - _WorldSpaceCameraPos))
    )), tmpvar_11))
  , 
    (tmpvar_10.w * 128.0)
  ) * clamp (atten_2, 0.0, 1.0)) * ((
    (c_12.x + c_12.y)
   + c_12.z) + (
    (2.0 * sqrt((c_12.y * (c_12.x + c_12.z))))
   * unity_ColorSpaceLuminance.w)));
  res_1 = (res_1 * clamp ((1.0 - 
    ((mix (tmpvar_4.z, sqrt(
      dot (tmpvar_6, tmpvar_6)
    ), unity_ShadowFadeCenterAndType.w) * unity_LightmapFade.z) + unity_LightmapFade.w)
  ), 0.0, 1.0));
  gl_FragData[0] = res_1.wxyz;
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
uniform vec4 unity_LightmapFade;
uniform mat4 _CameraToWorld;
uniform mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform sampler2DShadow _ShadowMapTexture;
uniform sampler2D _CameraNormalsTexture;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec4 res_1;
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
  float tmpvar_8;
  tmpvar_8 = mix (tmpvar_5.z, sqrt(dot (tmpvar_7, tmpvar_7)), unity_ShadowFadeCenterAndType.w);
  vec3 tmpvar_9;
  tmpvar_9 = (_LightPos.xyz - tmpvar_6);
  lightDir_3 = normalize(tmpvar_9);
  vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_6;
  vec4 tmpvar_11;
  tmpvar_11 = (_LightMatrix0 * tmpvar_10);
  vec4 tmpvar_12;
  tmpvar_12.zw = vec2(0.0, -8.0);
  tmpvar_12.xy = (tmpvar_11.xy / tmpvar_11.w);
  atten_2 = (texture2D (_LightTexture0, tmpvar_12.xy, -8.0).w * float((tmpvar_11.w < 0.0)));
  atten_2 = (atten_2 * texture2D (_LightTextureB0, vec2((dot (tmpvar_9, tmpvar_9) * _LightPos.w))).w);
  vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_6;
  atten_2 = (atten_2 * clamp ((
    (_LightShadowData.x + (shadow2DProj (_ShadowMapTexture, (unity_World2Shadow[0] * tmpvar_13)).x * (1.0 - _LightShadowData.x)))
   + 
    clamp (((tmpvar_8 * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0)
  ), 0.0, 1.0));
  vec4 tmpvar_14;
  tmpvar_14 = texture2D (_CameraNormalsTexture, tmpvar_4);
  vec3 tmpvar_15;
  tmpvar_15 = normalize(((tmpvar_14.xyz * 2.0) - 1.0));
  res_1.xyz = (_LightColor.xyz * (max (0.0, 
    dot (lightDir_3, tmpvar_15)
  ) * atten_2));
  vec3 c_16;
  c_16 = (_LightColor.xyz * unity_ColorSpaceLuminance.xyz);
  res_1.w = ((pow (
    max (0.0, dot (normalize((lightDir_3 - 
      normalize((tmpvar_6 - _WorldSpaceCameraPos))
    )), tmpvar_15))
  , 
    (tmpvar_14.w * 128.0)
  ) * clamp (atten_2, 0.0, 1.0)) * ((
    (c_16.x + c_16.y)
   + c_16.z) + (
    (2.0 * sqrt((c_16.y * (c_16.x + c_16.z))))
   * unity_ColorSpaceLuminance.w)));
  res_1 = (res_1 * clamp ((1.0 - 
    ((tmpvar_8 * unity_LightmapFade.z) + unity_LightmapFade.w)
  ), 0.0, 1.0));
  gl_FragData[0] = res_1.wxyz;
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
uniform vec4 unity_LightmapFade;
uniform mat4 _CameraToWorld;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _CameraNormalsTexture;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec4 res_1;
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
  float tmpvar_8;
  tmpvar_8 = mix (tmpvar_5.z, sqrt(dot (tmpvar_7, tmpvar_7)), unity_ShadowFadeCenterAndType.w);
  lightDir_3 = -(_LightDir.xyz);
  atten_2 = clamp ((texture2D (_ShadowMapTexture, tmpvar_4).x + clamp (
    ((tmpvar_8 * _LightShadowData.z) + _LightShadowData.w)
  , 0.0, 1.0)), 0.0, 1.0);
  vec4 tmpvar_9;
  tmpvar_9 = texture2D (_CameraNormalsTexture, tmpvar_4);
  vec3 tmpvar_10;
  tmpvar_10 = normalize(((tmpvar_9.xyz * 2.0) - 1.0));
  res_1.xyz = (_LightColor.xyz * (max (0.0, 
    dot (lightDir_3, tmpvar_10)
  ) * atten_2));
  vec3 c_11;
  c_11 = (_LightColor.xyz * unity_ColorSpaceLuminance.xyz);
  res_1.w = ((pow (
    max (0.0, dot (normalize((lightDir_3 - 
      normalize((tmpvar_6 - _WorldSpaceCameraPos))
    )), tmpvar_10))
  , 
    (tmpvar_9.w * 128.0)
  ) * clamp (atten_2, 0.0, 1.0)) * ((
    (c_11.x + c_11.y)
   + c_11.z) + (
    (2.0 * sqrt((c_11.y * (c_11.x + c_11.z))))
   * unity_ColorSpaceLuminance.w)));
  res_1 = (res_1 * clamp ((1.0 - 
    ((tmpvar_8 * unity_LightmapFade.z) + unity_LightmapFade.w)
  ), 0.0, 1.0));
  gl_FragData[0] = res_1.wxyz;
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
uniform vec4 unity_LightmapFade;
uniform mat4 _CameraToWorld;
uniform mat4 _LightMatrix0;
uniform sampler2D _LightTexture0;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _CameraNormalsTexture;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec4 res_1;
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
  float tmpvar_8;
  tmpvar_8 = mix (tmpvar_5.z, sqrt(dot (tmpvar_7, tmpvar_7)), unity_ShadowFadeCenterAndType.w);
  lightDir_3 = -(_LightDir.xyz);
  atten_2 = clamp ((texture2D (_ShadowMapTexture, tmpvar_4).x + clamp (
    ((tmpvar_8 * _LightShadowData.z) + _LightShadowData.w)
  , 0.0, 1.0)), 0.0, 1.0);
  vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_6;
  vec4 tmpvar_10;
  tmpvar_10.zw = vec2(0.0, -8.0);
  tmpvar_10.xy = (_LightMatrix0 * tmpvar_9).xy;
  atten_2 = (atten_2 * texture2D (_LightTexture0, tmpvar_10.xy, -8.0).w);
  vec4 tmpvar_11;
  tmpvar_11 = texture2D (_CameraNormalsTexture, tmpvar_4);
  vec3 tmpvar_12;
  tmpvar_12 = normalize(((tmpvar_11.xyz * 2.0) - 1.0));
  res_1.xyz = (_LightColor.xyz * (max (0.0, 
    dot (lightDir_3, tmpvar_12)
  ) * atten_2));
  vec3 c_13;
  c_13 = (_LightColor.xyz * unity_ColorSpaceLuminance.xyz);
  res_1.w = ((pow (
    max (0.0, dot (normalize((lightDir_3 - 
      normalize((tmpvar_6 - _WorldSpaceCameraPos))
    )), tmpvar_12))
  , 
    (tmpvar_11.w * 128.0)
  ) * clamp (atten_2, 0.0, 1.0)) * ((
    (c_13.x + c_13.y)
   + c_13.z) + (
    (2.0 * sqrt((c_13.y * (c_13.x + c_13.z))))
   * unity_ColorSpaceLuminance.w)));
  res_1 = (res_1 * clamp ((1.0 - 
    ((tmpvar_8 * unity_LightmapFade.z) + unity_LightmapFade.w)
  ), 0.0, 1.0));
  gl_FragData[0] = res_1.wxyz;
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
uniform vec4 unity_ShadowFadeCenterAndType;
uniform vec4 unity_ColorSpaceLuminance;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _LightPos;
uniform vec4 _LightColor;
uniform vec4 unity_LightmapFade;
uniform mat4 _CameraToWorld;
uniform sampler2D _LightTextureB0;
uniform samplerCube _ShadowMapTexture;
uniform sampler2D _CameraNormalsTexture;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec4 res_1;
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
  float tmpvar_8;
  tmpvar_8 = mix (tmpvar_5.z, sqrt(dot (tmpvar_7, tmpvar_7)), unity_ShadowFadeCenterAndType.w);
  vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_6 - _LightPos.xyz);
  lightDir_3 = -(normalize(tmpvar_9));
  atten_2 = texture2D (_LightTextureB0, vec2((dot (tmpvar_9, tmpvar_9) * _LightPos.w))).w;
  float mydist_10;
  mydist_10 = ((sqrt(
    dot (tmpvar_9, tmpvar_9)
  ) * _LightPositionRange.w) * 0.97);
  vec4 tmpvar_11;
  tmpvar_11 = textureCube (_ShadowMapTexture, tmpvar_9);
  float tmpvar_12;
  if ((tmpvar_11.x < mydist_10)) {
    tmpvar_12 = _LightShadowData.x;
  } else {
    tmpvar_12 = 1.0;
  };
  atten_2 = (atten_2 * tmpvar_12);
  vec4 tmpvar_13;
  tmpvar_13 = texture2D (_CameraNormalsTexture, tmpvar_4);
  vec3 tmpvar_14;
  tmpvar_14 = normalize(((tmpvar_13.xyz * 2.0) - 1.0));
  res_1.xyz = (_LightColor.xyz * (max (0.0, 
    dot (lightDir_3, tmpvar_14)
  ) * atten_2));
  vec3 c_15;
  c_15 = (_LightColor.xyz * unity_ColorSpaceLuminance.xyz);
  res_1.w = ((pow (
    max (0.0, dot (normalize((lightDir_3 - 
      normalize((tmpvar_6 - _WorldSpaceCameraPos))
    )), tmpvar_14))
  , 
    (tmpvar_13.w * 128.0)
  ) * clamp (atten_2, 0.0, 1.0)) * ((
    (c_15.x + c_15.y)
   + c_15.z) + (
    (2.0 * sqrt((c_15.y * (c_15.x + c_15.z))))
   * unity_ColorSpaceLuminance.w)));
  res_1 = (res_1 * clamp ((1.0 - 
    ((tmpvar_8 * unity_LightmapFade.z) + unity_LightmapFade.w)
  ), 0.0, 1.0));
  gl_FragData[0] = res_1.wxyz;
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
uniform vec4 unity_ShadowFadeCenterAndType;
uniform vec4 unity_ColorSpaceLuminance;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _LightPos;
uniform vec4 _LightColor;
uniform vec4 unity_LightmapFade;
uniform mat4 _CameraToWorld;
uniform mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
uniform samplerCube _ShadowMapTexture;
uniform sampler2D _CameraNormalsTexture;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec4 res_1;
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
  float tmpvar_8;
  tmpvar_8 = mix (tmpvar_5.z, sqrt(dot (tmpvar_7, tmpvar_7)), unity_ShadowFadeCenterAndType.w);
  vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_6 - _LightPos.xyz);
  lightDir_3 = -(normalize(tmpvar_9));
  atten_2 = texture2D (_LightTextureB0, vec2((dot (tmpvar_9, tmpvar_9) * _LightPos.w))).w;
  float mydist_10;
  mydist_10 = ((sqrt(
    dot (tmpvar_9, tmpvar_9)
  ) * _LightPositionRange.w) * 0.97);
  vec4 tmpvar_11;
  tmpvar_11 = textureCube (_ShadowMapTexture, tmpvar_9);
  float tmpvar_12;
  if ((tmpvar_11.x < mydist_10)) {
    tmpvar_12 = _LightShadowData.x;
  } else {
    tmpvar_12 = 1.0;
  };
  atten_2 = (atten_2 * tmpvar_12);
  vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_6;
  vec4 tmpvar_14;
  tmpvar_14.w = -8.0;
  tmpvar_14.xyz = (_LightMatrix0 * tmpvar_13).xyz;
  atten_2 = (atten_2 * textureCube (_LightTexture0, tmpvar_14.xyz, -8.0).w);
  vec4 tmpvar_15;
  tmpvar_15 = texture2D (_CameraNormalsTexture, tmpvar_4);
  vec3 tmpvar_16;
  tmpvar_16 = normalize(((tmpvar_15.xyz * 2.0) - 1.0));
  res_1.xyz = (_LightColor.xyz * (max (0.0, 
    dot (lightDir_3, tmpvar_16)
  ) * atten_2));
  vec3 c_17;
  c_17 = (_LightColor.xyz * unity_ColorSpaceLuminance.xyz);
  res_1.w = ((pow (
    max (0.0, dot (normalize((lightDir_3 - 
      normalize((tmpvar_6 - _WorldSpaceCameraPos))
    )), tmpvar_16))
  , 
    (tmpvar_15.w * 128.0)
  ) * clamp (atten_2, 0.0, 1.0)) * ((
    (c_17.x + c_17.y)
   + c_17.z) + (
    (2.0 * sqrt((c_17.y * (c_17.x + c_17.z))))
   * unity_ColorSpaceLuminance.w)));
  res_1 = (res_1 * clamp ((1.0 - 
    ((tmpvar_8 * unity_LightmapFade.z) + unity_LightmapFade.w)
  ), 0.0, 1.0));
  gl_FragData[0] = res_1.wxyz;
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
uniform vec4 unity_LightmapFade;
uniform mat4 _CameraToWorld;
uniform mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform sampler2DShadow _ShadowMapTexture;
uniform vec4 _ShadowOffsets[4];
uniform sampler2D _CameraNormalsTexture;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec4 res_1;
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
  float tmpvar_8;
  tmpvar_8 = mix (tmpvar_5.z, sqrt(dot (tmpvar_7, tmpvar_7)), unity_ShadowFadeCenterAndType.w);
  vec3 tmpvar_9;
  tmpvar_9 = (_LightPos.xyz - tmpvar_6);
  lightDir_3 = normalize(tmpvar_9);
  vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_6;
  vec4 tmpvar_11;
  tmpvar_11 = (_LightMatrix0 * tmpvar_10);
  vec4 tmpvar_12;
  tmpvar_12.zw = vec2(0.0, -8.0);
  tmpvar_12.xy = (tmpvar_11.xy / tmpvar_11.w);
  atten_2 = (texture2D (_LightTexture0, tmpvar_12.xy, -8.0).w * float((tmpvar_11.w < 0.0)));
  atten_2 = (atten_2 * texture2D (_LightTextureB0, vec2((dot (tmpvar_9, tmpvar_9) * _LightPos.w))).w);
  vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_6;
  vec4 tmpvar_14;
  tmpvar_14 = (unity_World2Shadow[0] * tmpvar_13);
  vec4 shadows_15;
  vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_14.xyz / tmpvar_14.w);
  shadows_15.x = shadow2D (_ShadowMapTexture, (tmpvar_16 + _ShadowOffsets[0].xyz)).x;
  shadows_15.y = shadow2D (_ShadowMapTexture, (tmpvar_16 + _ShadowOffsets[1].xyz)).x;
  shadows_15.z = shadow2D (_ShadowMapTexture, (tmpvar_16 + _ShadowOffsets[2].xyz)).x;
  shadows_15.w = shadow2D (_ShadowMapTexture, (tmpvar_16 + _ShadowOffsets[3].xyz)).x;
  shadows_15 = (_LightShadowData.xxxx + (shadows_15 * (1.0 - _LightShadowData.xxxx)));
  atten_2 = (atten_2 * clamp ((
    dot (shadows_15, vec4(0.25, 0.25, 0.25, 0.25))
   + 
    clamp (((tmpvar_8 * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0)
  ), 0.0, 1.0));
  vec4 tmpvar_17;
  tmpvar_17 = texture2D (_CameraNormalsTexture, tmpvar_4);
  vec3 tmpvar_18;
  tmpvar_18 = normalize(((tmpvar_17.xyz * 2.0) - 1.0));
  res_1.xyz = (_LightColor.xyz * (max (0.0, 
    dot (lightDir_3, tmpvar_18)
  ) * atten_2));
  vec3 c_19;
  c_19 = (_LightColor.xyz * unity_ColorSpaceLuminance.xyz);
  res_1.w = ((pow (
    max (0.0, dot (normalize((lightDir_3 - 
      normalize((tmpvar_6 - _WorldSpaceCameraPos))
    )), tmpvar_18))
  , 
    (tmpvar_17.w * 128.0)
  ) * clamp (atten_2, 0.0, 1.0)) * ((
    (c_19.x + c_19.y)
   + c_19.z) + (
    (2.0 * sqrt((c_19.y * (c_19.x + c_19.z))))
   * unity_ColorSpaceLuminance.w)));
  res_1 = (res_1 * clamp ((1.0 - 
    ((tmpvar_8 * unity_LightmapFade.z) + unity_LightmapFade.w)
  ), 0.0, 1.0));
  gl_FragData[0] = res_1.wxyz;
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
uniform vec4 unity_ShadowFadeCenterAndType;
uniform vec4 unity_ColorSpaceLuminance;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _LightPos;
uniform vec4 _LightColor;
uniform vec4 unity_LightmapFade;
uniform mat4 _CameraToWorld;
uniform sampler2D _LightTextureB0;
uniform samplerCube _ShadowMapTexture;
uniform sampler2D _CameraNormalsTexture;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec4 res_1;
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
  float tmpvar_8;
  tmpvar_8 = mix (tmpvar_5.z, sqrt(dot (tmpvar_7, tmpvar_7)), unity_ShadowFadeCenterAndType.w);
  vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_6 - _LightPos.xyz);
  lightDir_3 = -(normalize(tmpvar_9));
  atten_2 = texture2D (_LightTextureB0, vec2((dot (tmpvar_9, tmpvar_9) * _LightPos.w))).w;
  vec4 shadowVals_10;
  shadowVals_10.x = textureCube (_ShadowMapTexture, (tmpvar_9 + vec3(0.0078125, 0.0078125, 0.0078125))).x;
  shadowVals_10.y = textureCube (_ShadowMapTexture, (tmpvar_9 + vec3(-0.0078125, -0.0078125, 0.0078125))).x;
  shadowVals_10.z = textureCube (_ShadowMapTexture, (tmpvar_9 + vec3(-0.0078125, 0.0078125, -0.0078125))).x;
  shadowVals_10.w = textureCube (_ShadowMapTexture, (tmpvar_9 + vec3(0.0078125, -0.0078125, -0.0078125))).x;
  bvec4 tmpvar_11;
  tmpvar_11 = lessThan (shadowVals_10, vec4(((
    sqrt(dot (tmpvar_9, tmpvar_9))
   * _LightPositionRange.w) * 0.97)));
  vec4 tmpvar_12;
  tmpvar_12 = _LightShadowData.xxxx;
  float tmpvar_13;
  if (tmpvar_11.x) {
    tmpvar_13 = tmpvar_12.x;
  } else {
    tmpvar_13 = 1.0;
  };
  float tmpvar_14;
  if (tmpvar_11.y) {
    tmpvar_14 = tmpvar_12.y;
  } else {
    tmpvar_14 = 1.0;
  };
  float tmpvar_15;
  if (tmpvar_11.z) {
    tmpvar_15 = tmpvar_12.z;
  } else {
    tmpvar_15 = 1.0;
  };
  float tmpvar_16;
  if (tmpvar_11.w) {
    tmpvar_16 = tmpvar_12.w;
  } else {
    tmpvar_16 = 1.0;
  };
  vec4 tmpvar_17;
  tmpvar_17.x = tmpvar_13;
  tmpvar_17.y = tmpvar_14;
  tmpvar_17.z = tmpvar_15;
  tmpvar_17.w = tmpvar_16;
  atten_2 = (atten_2 * dot (tmpvar_17, vec4(0.25, 0.25, 0.25, 0.25)));
  vec4 tmpvar_18;
  tmpvar_18 = texture2D (_CameraNormalsTexture, tmpvar_4);
  vec3 tmpvar_19;
  tmpvar_19 = normalize(((tmpvar_18.xyz * 2.0) - 1.0));
  res_1.xyz = (_LightColor.xyz * (max (0.0, 
    dot (lightDir_3, tmpvar_19)
  ) * atten_2));
  vec3 c_20;
  c_20 = (_LightColor.xyz * unity_ColorSpaceLuminance.xyz);
  res_1.w = ((pow (
    max (0.0, dot (normalize((lightDir_3 - 
      normalize((tmpvar_6 - _WorldSpaceCameraPos))
    )), tmpvar_19))
  , 
    (tmpvar_18.w * 128.0)
  ) * clamp (atten_2, 0.0, 1.0)) * ((
    (c_20.x + c_20.y)
   + c_20.z) + (
    (2.0 * sqrt((c_20.y * (c_20.x + c_20.z))))
   * unity_ColorSpaceLuminance.w)));
  res_1 = (res_1 * clamp ((1.0 - 
    ((tmpvar_8 * unity_LightmapFade.z) + unity_LightmapFade.w)
  ), 0.0, 1.0));
  gl_FragData[0] = res_1.wxyz;
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
uniform vec4 unity_ShadowFadeCenterAndType;
uniform vec4 unity_ColorSpaceLuminance;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _LightPos;
uniform vec4 _LightColor;
uniform vec4 unity_LightmapFade;
uniform mat4 _CameraToWorld;
uniform mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
uniform samplerCube _ShadowMapTexture;
uniform sampler2D _CameraNormalsTexture;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec4 res_1;
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
  float tmpvar_8;
  tmpvar_8 = mix (tmpvar_5.z, sqrt(dot (tmpvar_7, tmpvar_7)), unity_ShadowFadeCenterAndType.w);
  vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_6 - _LightPos.xyz);
  lightDir_3 = -(normalize(tmpvar_9));
  atten_2 = texture2D (_LightTextureB0, vec2((dot (tmpvar_9, tmpvar_9) * _LightPos.w))).w;
  vec4 shadowVals_10;
  shadowVals_10.x = textureCube (_ShadowMapTexture, (tmpvar_9 + vec3(0.0078125, 0.0078125, 0.0078125))).x;
  shadowVals_10.y = textureCube (_ShadowMapTexture, (tmpvar_9 + vec3(-0.0078125, -0.0078125, 0.0078125))).x;
  shadowVals_10.z = textureCube (_ShadowMapTexture, (tmpvar_9 + vec3(-0.0078125, 0.0078125, -0.0078125))).x;
  shadowVals_10.w = textureCube (_ShadowMapTexture, (tmpvar_9 + vec3(0.0078125, -0.0078125, -0.0078125))).x;
  bvec4 tmpvar_11;
  tmpvar_11 = lessThan (shadowVals_10, vec4(((
    sqrt(dot (tmpvar_9, tmpvar_9))
   * _LightPositionRange.w) * 0.97)));
  vec4 tmpvar_12;
  tmpvar_12 = _LightShadowData.xxxx;
  float tmpvar_13;
  if (tmpvar_11.x) {
    tmpvar_13 = tmpvar_12.x;
  } else {
    tmpvar_13 = 1.0;
  };
  float tmpvar_14;
  if (tmpvar_11.y) {
    tmpvar_14 = tmpvar_12.y;
  } else {
    tmpvar_14 = 1.0;
  };
  float tmpvar_15;
  if (tmpvar_11.z) {
    tmpvar_15 = tmpvar_12.z;
  } else {
    tmpvar_15 = 1.0;
  };
  float tmpvar_16;
  if (tmpvar_11.w) {
    tmpvar_16 = tmpvar_12.w;
  } else {
    tmpvar_16 = 1.0;
  };
  vec4 tmpvar_17;
  tmpvar_17.x = tmpvar_13;
  tmpvar_17.y = tmpvar_14;
  tmpvar_17.z = tmpvar_15;
  tmpvar_17.w = tmpvar_16;
  atten_2 = (atten_2 * dot (tmpvar_17, vec4(0.25, 0.25, 0.25, 0.25)));
  vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = tmpvar_6;
  vec4 tmpvar_19;
  tmpvar_19.w = -8.0;
  tmpvar_19.xyz = (_LightMatrix0 * tmpvar_18).xyz;
  atten_2 = (atten_2 * textureCube (_LightTexture0, tmpvar_19.xyz, -8.0).w);
  vec4 tmpvar_20;
  tmpvar_20 = texture2D (_CameraNormalsTexture, tmpvar_4);
  vec3 tmpvar_21;
  tmpvar_21 = normalize(((tmpvar_20.xyz * 2.0) - 1.0));
  res_1.xyz = (_LightColor.xyz * (max (0.0, 
    dot (lightDir_3, tmpvar_21)
  ) * atten_2));
  vec3 c_22;
  c_22 = (_LightColor.xyz * unity_ColorSpaceLuminance.xyz);
  res_1.w = ((pow (
    max (0.0, dot (normalize((lightDir_3 - 
      normalize((tmpvar_6 - _WorldSpaceCameraPos))
    )), tmpvar_21))
  , 
    (tmpvar_20.w * 128.0)
  ) * clamp (atten_2, 0.0, 1.0)) * ((
    (c_22.x + c_22.y)
   + c_22.z) + (
    (2.0 * sqrt((c_22.y * (c_22.x + c_22.z))))
   * unity_ColorSpaceLuminance.w)));
  res_1 = (res_1 * clamp ((1.0 - 
    ((tmpvar_8 * unity_LightmapFade.z) + unity_LightmapFade.w)
  ), 0.0, 1.0));
  gl_FragData[0] = res_1.wxyz;
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
}
 }
}
Fallback Off
}