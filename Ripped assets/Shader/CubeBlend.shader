//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/CubeBlend" {
Properties {
[NoScaleOffset]  _TexA ("Cubemap", CUBE) = "grey" { }
[NoScaleOffset]  _TexB ("Cubemap", CUBE) = "grey" { }
 _value ("Value", Range(0,1)) = 0.5
}
SubShader { 
 Tags { "QUEUE"="Background" "RenderType"="Background" }
 Pass {
  Tags { "QUEUE"="Background" "RenderType"="Background" }
  ZTest Always
  ZWrite Off
  GpuProgramID 17682
Program "vp" {
SubProgram "opengl " {
"#version 120

#ifdef VERTEX

varying vec3 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = gl_MultiTexCoord0.xyz;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
uniform vec4 _TexA_HDR;
uniform vec4 _TexB_HDR;
uniform samplerCube _TexA;
uniform samplerCube _TexB;
uniform float _Level;
uniform float _value;
varying vec3 xlv_TEXCOORD0;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = textureCubeLod (_TexA, xlv_TEXCOORD0, _Level);
  vec4 tmpvar_2;
  tmpvar_2 = textureCubeLod (_TexB, xlv_TEXCOORD0, _Level);
  vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = mix (((_TexA_HDR.x * 
    pow (tmpvar_1.w, _TexA_HDR.y)
  ) * tmpvar_1.xyz), ((_TexB_HDR.x * 
    pow (tmpvar_2.w, _TexB_HDR.y)
  ) * tmpvar_2.xyz), vec3(_value));
  gl_FragData[0] = tmpvar_3;
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
 Tags { "QUEUE"="Background" "RenderType"="Background" }
 Pass {
  Tags { "QUEUE"="Background" "RenderType"="Background" }
  ZTest Always
  ZWrite Off
  GpuProgramID 113859
Program "vp" {
SubProgram "opengl " {
"#version 120

#ifdef VERTEX

varying vec3 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = gl_MultiTexCoord0.xyz;
}


#endif
#ifdef FRAGMENT
uniform vec4 _TexA_HDR;
uniform vec4 _TexB_HDR;
uniform samplerCube _TexA;
uniform samplerCube _TexB;
uniform float _Level;
uniform float _value;
varying vec3 xlv_TEXCOORD0;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = textureCube (_TexA, xlv_TEXCOORD0, _Level);
  vec4 tmpvar_2;
  tmpvar_2 = textureCube (_TexB, xlv_TEXCOORD0, _Level);
  vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = mix (((_TexA_HDR.x * 
    pow (tmpvar_1.w, _TexA_HDR.y)
  ) * tmpvar_1.xyz), ((_TexB_HDR.x * 
    pow (tmpvar_2.w, _TexB_HDR.y)
  ) * tmpvar_2.xyz), vec3(_value));
  gl_FragData[0] = tmpvar_3;
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
Fallback Off
}