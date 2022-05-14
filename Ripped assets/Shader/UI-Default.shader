//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "UI/Default" {
Properties {
[PerRendererData]  _MainTex ("Sprite Texture", 2D) = "white" { }
 _Color ("Tint", Color) = (1,1,1,1)
 _StencilComp ("Stencil Comparison", Float) = 8
 _Stencil ("Stencil ID", Float) = 0
 _StencilOp ("Stencil Operation", Float) = 0
 _StencilWriteMask ("Stencil Write Mask", Float) = 255
 _StencilReadMask ("Stencil Read Mask", Float) = 255
 _ColorMask ("Color Mask", Float) = 15
[Toggle(UNITY_UI_ALPHACLIP)]  _UseUIAlphaClip ("Use Alpha Clip", Float) = 0
}
SubShader { 
 Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" "PreviewType"="Plane" "CanUseSpriteAtlas"="true" }
 Pass {
  Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" "PreviewType"="Plane" "CanUseSpriteAtlas"="true" }
  ZTest [unity_GUIZTestMode]
  ZWrite Off
  Cull Off
  Stencil {
   Ref [_Stencil]
   ReadMask [_StencilReadMask]
   WriteMask [_StencilWriteMask]
   Comp [_StencilComp]
   Pass [_StencilOp]
  }
  Blend SrcAlpha OneMinusSrcAlpha
  ColorMask [_ColorMask]
  GpuProgramID 36763
Program "vp" {
SubProgram "opengl " {
"#version 120

#ifdef VERTEX

uniform vec4 _Color;
varying vec4 xlv_COLOR;
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
void main ()
{
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_COLOR = (gl_Color * _Color);
  xlv_TEXCOORD0 = gl_MultiTexCoord0.xy;
  xlv_TEXCOORD1 = gl_Vertex;
}


#endif
#ifdef FRAGMENT
uniform vec4 _TextureSampleAdd;
uniform vec4 _ClipRect;
uniform sampler2D _MainTex;
varying vec4 xlv_COLOR;
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
void main ()
{
  vec4 color_1;
  vec4 tmpvar_2;
  tmpvar_2 = ((texture2D (_MainTex, xlv_TEXCOORD0) + _TextureSampleAdd) * xlv_COLOR);
  color_1.xyz = tmpvar_2.xyz;
  vec2 tmpvar_3;
  tmpvar_3.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_3.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  vec2 tmpvar_4;
  tmpvar_4 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_3);
  color_1.w = (tmpvar_2.w * (tmpvar_4.x * tmpvar_4.y));
  gl_FragData[0] = color_1;
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
Keywords { "UNITY_UI_ALPHACLIP" }
"#version 120

#ifdef VERTEX

uniform vec4 _Color;
varying vec4 xlv_COLOR;
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
void main ()
{
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_COLOR = (gl_Color * _Color);
  xlv_TEXCOORD0 = gl_MultiTexCoord0.xy;
  xlv_TEXCOORD1 = gl_Vertex;
}


#endif
#ifdef FRAGMENT
uniform vec4 _TextureSampleAdd;
uniform vec4 _ClipRect;
uniform sampler2D _MainTex;
varying vec4 xlv_COLOR;
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
void main ()
{
  vec4 color_1;
  vec4 tmpvar_2;
  tmpvar_2 = ((texture2D (_MainTex, xlv_TEXCOORD0) + _TextureSampleAdd) * xlv_COLOR);
  color_1.xyz = tmpvar_2.xyz;
  vec2 tmpvar_3;
  tmpvar_3.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_3.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  vec2 tmpvar_4;
  tmpvar_4 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_3);
  color_1.w = (tmpvar_2.w * (tmpvar_4.x * tmpvar_4.y));
  float x_5;
  x_5 = (color_1.w - 0.001);
  if ((x_5 < 0.0)) {
    discard;
  };
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "UNITY_UI_ALPHACLIP" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "UNITY_UI_ALPHACLIP" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11_9x " {
Keywords { "UNITY_UI_ALPHACLIP" }
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
Keywords { "UNITY_UI_ALPHACLIP" }
""
}
SubProgram "d3d9 " {
Keywords { "UNITY_UI_ALPHACLIP" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "UNITY_UI_ALPHACLIP" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11_9x " {
Keywords { "UNITY_UI_ALPHACLIP" }
"// shader disassembly not supported on DXBC"
}
}
 }
}
}