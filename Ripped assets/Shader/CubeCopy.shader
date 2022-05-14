//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/CubeCopy" {
Properties {
 _MainTex ("Main", CUBE) = "" { }
 _Level ("Level", Float) = 0
}
SubShader { 
 LOD 200
 Tags { "RenderType"="Opaque" }
 Pass {
  Tags { "RenderType"="Opaque" }
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 16705
Program "vp" {
SubProgram "opengl " {
"#version 120

#ifdef VERTEX

varying vec4 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = gl_MultiTexCoord0;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
uniform float _Level;
uniform samplerCube _MainTex;
varying vec4 xlv_TEXCOORD0;
void main ()
{
  gl_FragData[0] = textureCubeLod (_MainTex, xlv_TEXCOORD0.xyz, _Level);
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
SubShader { 
 LOD 200
 Tags { "RenderType"="Opaque" }
 Pass {
  Tags { "RenderType"="Opaque" }
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 110530
Program "vp" {
SubProgram "opengl " {
"#version 120

#ifdef VERTEX

varying vec4 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = gl_MultiTexCoord0;
}


#endif
#ifdef FRAGMENT
uniform float _Level;
uniform samplerCube _MainTex;
varying vec4 xlv_TEXCOORD0;
void main ()
{
  gl_FragData[0] = textureCube (_MainTex, xlv_TEXCOORD0.xyz, _Level);
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
}
}