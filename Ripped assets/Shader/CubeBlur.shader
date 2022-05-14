//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/CubeBlur" {
Properties {
 _MainTex ("Main", CUBE) = "" { }
 _Texel ("Texel", Float) = 0.0078125
 _Level ("Level", Float) = 0
 _Scale ("Scale", Float) = 1
}
SubShader { 
 LOD 200
 Tags { "RenderType"="Opaque" }
 Pass {
  Tags { "RenderType"="Opaque" }
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 13554
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
uniform samplerCube _MainTex;
uniform float _Texel;
uniform float _Level;
uniform float _Scale;
varying vec4 xlv_TEXCOORD0;
void main ()
{
  vec3 c_1;
  vec4 s3_2;
  vec4 s2_3;
  vec4 s1_4;
  float w_5;
  vec4 s_6;
  vec3 st_7;
  vec3 tmpvar_8;
  tmpvar_8 = (xlv_TEXCOORD0.xyz * vec3(equal (
    abs(xlv_TEXCOORD0.xyz)
  , vec3(1.0, 1.0, 1.0))));
  vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8.zxy * _Texel);
  vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_8.yzx * _Texel);
  vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = (xlv_TEXCOORD0.xyz * (vec3(1.0, 1.0, 1.0) - abs(tmpvar_8)));
  float tmpvar_12;
  tmpvar_12 = inversesqrt((1.0 + dot (tmpvar_11.xyz, tmpvar_11.xyz)));
  float d_13;
  d_13 = ((tmpvar_12 * tmpvar_12) * tmpvar_12);
  vec3 tmpvar_14;
  tmpvar_14.x = d_13;
  tmpvar_14.y = (3.0 * d_13);
  tmpvar_14.z = (5.0 * d_13);
  vec3 tmpvar_15;
  tmpvar_15 = (tmpvar_14 * _Scale);
  vec3 tmpvar_16;
  tmpvar_16 = exp((-(tmpvar_15) * tmpvar_15));
  vec3 tmpvar_17;
  vec3 st_18;
  st_18 = (xlv_TEXCOORD0.xyz + (1.5 * tmpvar_9));
  vec3 tmpvar_19;
  tmpvar_19 = min (max (st_18, vec3(-1.0, -1.0, -1.0)), vec3(1.0, 1.0, 1.0));
  vec3 tmpvar_20;
  tmpvar_20 = abs((st_18 - tmpvar_19));
  tmpvar_17 = (tmpvar_19 - (max (
    max (tmpvar_20.x, tmpvar_20.y)
  , tmpvar_20.z) * tmpvar_8));
  vec3 tmpvar_21;
  vec3 st_22;
  st_22 = (xlv_TEXCOORD0.xyz - (1.5 * tmpvar_9));
  vec3 tmpvar_23;
  tmpvar_23 = min (max (st_22, vec3(-1.0, -1.0, -1.0)), vec3(1.0, 1.0, 1.0));
  vec3 tmpvar_24;
  tmpvar_24 = abs((st_22 - tmpvar_23));
  tmpvar_21 = (tmpvar_23 - (max (
    max (tmpvar_24.x, tmpvar_24.y)
  , tmpvar_24.z) * tmpvar_8));
  vec3 tmpvar_25;
  vec3 st_26;
  st_26 = (xlv_TEXCOORD0.xyz + (2.5 * tmpvar_9));
  vec3 tmpvar_27;
  tmpvar_27 = min (max (st_26, vec3(-1.0, -1.0, -1.0)), vec3(1.0, 1.0, 1.0));
  vec3 tmpvar_28;
  tmpvar_28 = abs((st_26 - tmpvar_27));
  tmpvar_25 = (tmpvar_27 - (max (
    max (tmpvar_28.x, tmpvar_28.y)
  , tmpvar_28.z) * tmpvar_8));
  vec3 tmpvar_29;
  vec3 st_30;
  st_30 = (xlv_TEXCOORD0.xyz - (2.5 * tmpvar_9));
  vec3 tmpvar_31;
  tmpvar_31 = min (max (st_30, vec3(-1.0, -1.0, -1.0)), vec3(1.0, 1.0, 1.0));
  vec3 tmpvar_32;
  tmpvar_32 = abs((st_30 - tmpvar_31));
  tmpvar_29 = (tmpvar_31 - (max (
    max (tmpvar_32.x, tmpvar_32.y)
  , tmpvar_32.z) * tmpvar_8));
  vec3 tmpvar_33;
  vec3 st_34;
  st_34 = (xlv_TEXCOORD0.xyz + (1.5 * tmpvar_10));
  vec3 tmpvar_35;
  tmpvar_35 = min (max (st_34, vec3(-1.0, -1.0, -1.0)), vec3(1.0, 1.0, 1.0));
  vec3 tmpvar_36;
  tmpvar_36 = abs((st_34 - tmpvar_35));
  tmpvar_33 = (tmpvar_35 - (max (
    max (tmpvar_36.x, tmpvar_36.y)
  , tmpvar_36.z) * tmpvar_8));
  vec3 tmpvar_37;
  vec3 st_38;
  st_38 = (xlv_TEXCOORD0.xyz - (1.5 * tmpvar_10));
  vec3 tmpvar_39;
  tmpvar_39 = min (max (st_38, vec3(-1.0, -1.0, -1.0)), vec3(1.0, 1.0, 1.0));
  vec3 tmpvar_40;
  tmpvar_40 = abs((st_38 - tmpvar_39));
  tmpvar_37 = (tmpvar_39 - (max (
    max (tmpvar_40.x, tmpvar_40.y)
  , tmpvar_40.z) * tmpvar_8));
  vec3 tmpvar_41;
  vec3 st_42;
  st_42 = (xlv_TEXCOORD0.xyz + (2.5 * tmpvar_10));
  vec3 tmpvar_43;
  tmpvar_43 = min (max (st_42, vec3(-1.0, -1.0, -1.0)), vec3(1.0, 1.0, 1.0));
  vec3 tmpvar_44;
  tmpvar_44 = abs((st_42 - tmpvar_43));
  tmpvar_41 = (tmpvar_43 - (max (
    max (tmpvar_44.x, tmpvar_44.y)
  , tmpvar_44.z) * tmpvar_8));
  vec3 tmpvar_45;
  vec3 st_46;
  st_46 = (xlv_TEXCOORD0.xyz - (2.5 * tmpvar_10));
  vec3 tmpvar_47;
  tmpvar_47 = min (max (st_46, vec3(-1.0, -1.0, -1.0)), vec3(1.0, 1.0, 1.0));
  vec3 tmpvar_48;
  tmpvar_48 = abs((st_46 - tmpvar_47));
  tmpvar_45 = (tmpvar_47 - (max (
    max (tmpvar_48.x, tmpvar_48.y)
  , tmpvar_48.z) * tmpvar_8));
  c_1 = (tmpvar_16 * tmpvar_16.zzz);
  st_7 = ((xlv_TEXCOORD0.xyz - (2.5 * tmpvar_9)) - (2.5 * tmpvar_10));
  vec3 tmpvar_49;
  tmpvar_49 = min (max (st_7, vec3(-1.0, -1.0, -1.0)), vec3(1.0, 1.0, 1.0));
  vec3 tmpvar_50;
  tmpvar_50 = abs((st_7 - tmpvar_49));
  vec4 tmpvar_51;
  tmpvar_51.xyz = (tmpvar_49 - (max (
    max (tmpvar_50.x, tmpvar_50.y)
  , tmpvar_50.z) * tmpvar_8));
  tmpvar_51.w = _Level;
  st_7 = ((xlv_TEXCOORD0.xyz - (1.5 * tmpvar_9)) - (2.5 * tmpvar_10));
  vec3 tmpvar_52;
  tmpvar_52 = min (max (st_7, vec3(-1.0, -1.0, -1.0)), vec3(1.0, 1.0, 1.0));
  vec3 tmpvar_53;
  tmpvar_53 = abs((st_7 - tmpvar_52));
  vec4 tmpvar_54;
  tmpvar_54.xyz = (tmpvar_52 - (max (
    max (tmpvar_53.x, tmpvar_53.y)
  , tmpvar_53.z) * tmpvar_8));
  tmpvar_54.w = _Level;
  st_7 = (tmpvar_45 - (0.5 * tmpvar_9));
  vec4 tmpvar_55;
  tmpvar_55.xyz = st_7;
  tmpvar_55.w = _Level;
  st_7 = (tmpvar_45 + (0.5 * tmpvar_9));
  s1_4 = (max (vec4(0.0, 0.0, 0.0, 0.0), textureCubeLod (_MainTex, tmpvar_55.xyz, _Level)) + max (vec4(0.0, 0.0, 0.0, 0.0), textureCubeLod (_MainTex, st_7, _Level)));
  st_7 = ((xlv_TEXCOORD0.xyz + (1.5 * tmpvar_9)) - (2.5 * tmpvar_10));
  vec3 tmpvar_56;
  tmpvar_56 = min (max (st_7, vec3(-1.0, -1.0, -1.0)), vec3(1.0, 1.0, 1.0));
  vec3 tmpvar_57;
  tmpvar_57 = abs((st_7 - tmpvar_56));
  vec4 tmpvar_58;
  tmpvar_58.xyz = (tmpvar_56 - (max (
    max (tmpvar_57.x, tmpvar_57.y)
  , tmpvar_57.z) * tmpvar_8));
  tmpvar_58.w = _Level;
  s2_3 = (max (vec4(0.0, 0.0, 0.0, 0.0), textureCubeLod (_MainTex, tmpvar_54.xyz, _Level)) + max (vec4(0.0, 0.0, 0.0, 0.0), textureCubeLod (_MainTex, tmpvar_58.xyz, _Level)));
  st_7 = ((xlv_TEXCOORD0.xyz + (2.5 * tmpvar_9)) - (2.5 * tmpvar_10));
  vec3 tmpvar_59;
  tmpvar_59 = min (max (st_7, vec3(-1.0, -1.0, -1.0)), vec3(1.0, 1.0, 1.0));
  vec3 tmpvar_60;
  tmpvar_60 = abs((st_7 - tmpvar_59));
  vec4 tmpvar_61;
  tmpvar_61.xyz = (tmpvar_59 - (max (
    max (tmpvar_60.x, tmpvar_60.y)
  , tmpvar_60.z) * tmpvar_8));
  tmpvar_61.w = _Level;
  s3_2 = (max (vec4(0.0, 0.0, 0.0, 0.0), textureCubeLod (_MainTex, tmpvar_51.xyz, _Level)) + max (vec4(0.0, 0.0, 0.0, 0.0), textureCubeLod (_MainTex, tmpvar_61.xyz, _Level)));
  w_5 = dot (c_1, vec3(2.0, 2.0, 2.0));
  s1_4 = ((c_1.x * s1_4) + (c_1.y * s2_3));
  s_6 = (c_1.z * s3_2);
  s_6 = (s_6 + s1_4);
  c_1 = (tmpvar_16 * tmpvar_16.yyy);
  st_7 = ((xlv_TEXCOORD0.xyz + (2.5 * tmpvar_9)) - (1.5 * tmpvar_10));
  vec3 tmpvar_62;
  tmpvar_62 = min (max (st_7, vec3(-1.0, -1.0, -1.0)), vec3(1.0, 1.0, 1.0));
  vec3 tmpvar_63;
  tmpvar_63 = abs((st_7 - tmpvar_62));
  vec4 tmpvar_64;
  tmpvar_64.xyz = (tmpvar_62 - (max (
    max (tmpvar_63.x, tmpvar_63.y)
  , tmpvar_63.z) * tmpvar_8));
  tmpvar_64.w = _Level;
  st_7 = ((xlv_TEXCOORD0.xyz + (1.5 * tmpvar_9)) - (1.5 * tmpvar_10));
  vec3 tmpvar_65;
  tmpvar_65 = min (max (st_7, vec3(-1.0, -1.0, -1.0)), vec3(1.0, 1.0, 1.0));
  vec3 tmpvar_66;
  tmpvar_66 = abs((st_7 - tmpvar_65));
  vec4 tmpvar_67;
  tmpvar_67.xyz = (tmpvar_65 - (max (
    max (tmpvar_66.x, tmpvar_66.y)
  , tmpvar_66.z) * tmpvar_8));
  tmpvar_67.w = _Level;
  st_7 = (tmpvar_37 + (0.5 * tmpvar_9));
  vec4 tmpvar_68;
  tmpvar_68.xyz = st_7;
  tmpvar_68.w = _Level;
  st_7 = (tmpvar_37 - (0.5 * tmpvar_9));
  s1_4 = (max (vec4(0.0, 0.0, 0.0, 0.0), textureCubeLod (_MainTex, tmpvar_68.xyz, _Level)) + max (vec4(0.0, 0.0, 0.0, 0.0), textureCubeLod (_MainTex, st_7, _Level)));
  st_7 = ((xlv_TEXCOORD0.xyz - (1.5 * tmpvar_9)) - (1.5 * tmpvar_10));
  vec3 tmpvar_69;
  tmpvar_69 = min (max (st_7, vec3(-1.0, -1.0, -1.0)), vec3(1.0, 1.0, 1.0));
  vec3 tmpvar_70;
  tmpvar_70 = abs((st_7 - tmpvar_69));
  vec4 tmpvar_71;
  tmpvar_71.xyz = (tmpvar_69 - (max (
    max (tmpvar_70.x, tmpvar_70.y)
  , tmpvar_70.z) * tmpvar_8));
  tmpvar_71.w = _Level;
  s2_3 = (max (vec4(0.0, 0.0, 0.0, 0.0), textureCubeLod (_MainTex, tmpvar_67.xyz, _Level)) + max (vec4(0.0, 0.0, 0.0, 0.0), textureCubeLod (_MainTex, tmpvar_71.xyz, _Level)));
  st_7 = ((xlv_TEXCOORD0.xyz - (2.5 * tmpvar_9)) - (1.5 * tmpvar_10));
  vec3 tmpvar_72;
  tmpvar_72 = min (max (st_7, vec3(-1.0, -1.0, -1.0)), vec3(1.0, 1.0, 1.0));
  vec3 tmpvar_73;
  tmpvar_73 = abs((st_7 - tmpvar_72));
  vec4 tmpvar_74;
  tmpvar_74.xyz = (tmpvar_72 - (max (
    max (tmpvar_73.x, tmpvar_73.y)
  , tmpvar_73.z) * tmpvar_8));
  tmpvar_74.w = _Level;
  s3_2 = (max (vec4(0.0, 0.0, 0.0, 0.0), textureCubeLod (_MainTex, tmpvar_64.xyz, _Level)) + max (vec4(0.0, 0.0, 0.0, 0.0), textureCubeLod (_MainTex, tmpvar_74.xyz, _Level)));
  w_5 = (w_5 + dot (c_1, vec3(2.0, 2.0, 2.0)));
  s1_4 = ((c_1.x * s1_4) + (c_1.y * s2_3));
  s_6 = (s_6 + (c_1.z * s3_2));
  s_6 = (s_6 + s1_4);
  c_1 = (tmpvar_16 * tmpvar_16.xxx);
  st_7 = (tmpvar_29 - (0.5 * tmpvar_10));
  vec4 tmpvar_75;
  tmpvar_75.xyz = st_7;
  tmpvar_75.w = _Level;
  st_7 = (tmpvar_21 - (0.5 * tmpvar_10));
  vec4 tmpvar_76;
  tmpvar_76.xyz = st_7;
  tmpvar_76.w = _Level;
  st_7 = ((xlv_TEXCOORD0.xyz - (0.5 * tmpvar_9)) - (0.5 * tmpvar_10));
  vec4 tmpvar_77;
  tmpvar_77.xyz = st_7;
  tmpvar_77.w = _Level;
  st_7 = ((xlv_TEXCOORD0.xyz + (0.5 * tmpvar_9)) - (0.5 * tmpvar_10));
  s1_4 = (max (vec4(0.0, 0.0, 0.0, 0.0), textureCubeLod (_MainTex, tmpvar_77.xyz, _Level)) + max (vec4(0.0, 0.0, 0.0, 0.0), textureCubeLod (_MainTex, st_7, _Level)));
  st_7 = (tmpvar_17 - (0.5 * tmpvar_10));
  s2_3 = (max (vec4(0.0, 0.0, 0.0, 0.0), textureCubeLod (_MainTex, tmpvar_76.xyz, _Level)) + max (vec4(0.0, 0.0, 0.0, 0.0), textureCubeLod (_MainTex, st_7, _Level)));
  st_7 = (tmpvar_25 - (0.5 * tmpvar_10));
  s3_2 = (max (vec4(0.0, 0.0, 0.0, 0.0), textureCubeLod (_MainTex, tmpvar_75.xyz, _Level)) + max (vec4(0.0, 0.0, 0.0, 0.0), textureCubeLod (_MainTex, st_7, _Level)));
  w_5 = (w_5 + dot (c_1, vec3(2.0, 2.0, 2.0)));
  s1_4 = ((c_1.x * s1_4) + (c_1.y * s2_3));
  s_6 = (s_6 + (c_1.z * s3_2));
  s_6 = (s_6 + s1_4);
  c_1 = (tmpvar_16 * tmpvar_16.xxx);
  st_7 = (tmpvar_25 + (0.5 * tmpvar_10));
  vec4 tmpvar_78;
  tmpvar_78.xyz = st_7;
  tmpvar_78.w = _Level;
  st_7 = (tmpvar_17 + (0.5 * tmpvar_10));
  vec4 tmpvar_79;
  tmpvar_79.xyz = st_7;
  tmpvar_79.w = _Level;
  st_7 = ((xlv_TEXCOORD0.xyz + (0.5 * tmpvar_9)) + (0.5 * tmpvar_10));
  vec4 tmpvar_80;
  tmpvar_80.xyz = st_7;
  tmpvar_80.w = _Level;
  st_7 = ((xlv_TEXCOORD0.xyz - (0.5 * tmpvar_9)) + (0.5 * tmpvar_10));
  s1_4 = (max (vec4(0.0, 0.0, 0.0, 0.0), textureCubeLod (_MainTex, tmpvar_80.xyz, _Level)) + max (vec4(0.0, 0.0, 0.0, 0.0), textureCubeLod (_MainTex, st_7, _Level)));
  st_7 = (tmpvar_21 + (0.5 * tmpvar_10));
  s2_3 = (max (vec4(0.0, 0.0, 0.0, 0.0), textureCubeLod (_MainTex, tmpvar_79.xyz, _Level)) + max (vec4(0.0, 0.0, 0.0, 0.0), textureCubeLod (_MainTex, st_7, _Level)));
  st_7 = (tmpvar_29 + (0.5 * tmpvar_10));
  s3_2 = (max (vec4(0.0, 0.0, 0.0, 0.0), textureCubeLod (_MainTex, tmpvar_78.xyz, _Level)) + max (vec4(0.0, 0.0, 0.0, 0.0), textureCubeLod (_MainTex, st_7, _Level)));
  w_5 = (w_5 + dot (c_1, vec3(2.0, 2.0, 2.0)));
  s1_4 = ((c_1.x * s1_4) + (c_1.y * s2_3));
  s_6 = (s_6 + (c_1.z * s3_2));
  s_6 = (s_6 + s1_4);
  c_1 = (tmpvar_16 * tmpvar_16.yyy);
  st_7 = ((xlv_TEXCOORD0.xyz - (2.5 * tmpvar_9)) + (1.5 * tmpvar_10));
  vec3 tmpvar_81;
  tmpvar_81 = min (max (st_7, vec3(-1.0, -1.0, -1.0)), vec3(1.0, 1.0, 1.0));
  vec3 tmpvar_82;
  tmpvar_82 = abs((st_7 - tmpvar_81));
  vec4 tmpvar_83;
  tmpvar_83.xyz = (tmpvar_81 - (max (
    max (tmpvar_82.x, tmpvar_82.y)
  , tmpvar_82.z) * tmpvar_8));
  tmpvar_83.w = _Level;
  st_7 = ((xlv_TEXCOORD0.xyz - (1.5 * tmpvar_9)) + (1.5 * tmpvar_10));
  vec3 tmpvar_84;
  tmpvar_84 = min (max (st_7, vec3(-1.0, -1.0, -1.0)), vec3(1.0, 1.0, 1.0));
  vec3 tmpvar_85;
  tmpvar_85 = abs((st_7 - tmpvar_84));
  vec4 tmpvar_86;
  tmpvar_86.xyz = (tmpvar_84 - (max (
    max (tmpvar_85.x, tmpvar_85.y)
  , tmpvar_85.z) * tmpvar_8));
  tmpvar_86.w = _Level;
  st_7 = (tmpvar_33 - (0.5 * tmpvar_9));
  vec4 tmpvar_87;
  tmpvar_87.xyz = st_7;
  tmpvar_87.w = _Level;
  st_7 = (tmpvar_33 + (0.5 * tmpvar_9));
  s1_4 = (max (vec4(0.0, 0.0, 0.0, 0.0), textureCubeLod (_MainTex, tmpvar_87.xyz, _Level)) + max (vec4(0.0, 0.0, 0.0, 0.0), textureCubeLod (_MainTex, st_7, _Level)));
  st_7 = ((xlv_TEXCOORD0.xyz + (1.5 * tmpvar_9)) + (1.5 * tmpvar_10));
  vec3 tmpvar_88;
  tmpvar_88 = min (max (st_7, vec3(-1.0, -1.0, -1.0)), vec3(1.0, 1.0, 1.0));
  vec3 tmpvar_89;
  tmpvar_89 = abs((st_7 - tmpvar_88));
  vec4 tmpvar_90;
  tmpvar_90.xyz = (tmpvar_88 - (max (
    max (tmpvar_89.x, tmpvar_89.y)
  , tmpvar_89.z) * tmpvar_8));
  tmpvar_90.w = _Level;
  s2_3 = (max (vec4(0.0, 0.0, 0.0, 0.0), textureCubeLod (_MainTex, tmpvar_86.xyz, _Level)) + max (vec4(0.0, 0.0, 0.0, 0.0), textureCubeLod (_MainTex, tmpvar_90.xyz, _Level)));
  st_7 = ((xlv_TEXCOORD0.xyz + (2.5 * tmpvar_9)) + (1.5 * tmpvar_10));
  vec3 tmpvar_91;
  tmpvar_91 = min (max (st_7, vec3(-1.0, -1.0, -1.0)), vec3(1.0, 1.0, 1.0));
  vec3 tmpvar_92;
  tmpvar_92 = abs((st_7 - tmpvar_91));
  vec4 tmpvar_93;
  tmpvar_93.xyz = (tmpvar_91 - (max (
    max (tmpvar_92.x, tmpvar_92.y)
  , tmpvar_92.z) * tmpvar_8));
  tmpvar_93.w = _Level;
  s3_2 = (max (vec4(0.0, 0.0, 0.0, 0.0), textureCubeLod (_MainTex, tmpvar_83.xyz, _Level)) + max (vec4(0.0, 0.0, 0.0, 0.0), textureCubeLod (_MainTex, tmpvar_93.xyz, _Level)));
  w_5 = (w_5 + dot (c_1, vec3(2.0, 2.0, 2.0)));
  s1_4 = ((c_1.x * s1_4) + (c_1.y * s2_3));
  s_6 = (s_6 + (c_1.z * s3_2));
  s_6 = (s_6 + s1_4);
  c_1 = (tmpvar_16 * tmpvar_16.zzz);
  st_7 = ((xlv_TEXCOORD0.xyz + (2.5 * tmpvar_9)) + (2.5 * tmpvar_10));
  vec3 tmpvar_94;
  tmpvar_94 = min (max (st_7, vec3(-1.0, -1.0, -1.0)), vec3(1.0, 1.0, 1.0));
  vec3 tmpvar_95;
  tmpvar_95 = abs((st_7 - tmpvar_94));
  vec4 tmpvar_96;
  tmpvar_96.xyz = (tmpvar_94 - (max (
    max (tmpvar_95.x, tmpvar_95.y)
  , tmpvar_95.z) * tmpvar_8));
  tmpvar_96.w = _Level;
  st_7 = ((xlv_TEXCOORD0.xyz + (1.5 * tmpvar_9)) + (2.5 * tmpvar_10));
  vec3 tmpvar_97;
  tmpvar_97 = min (max (st_7, vec3(-1.0, -1.0, -1.0)), vec3(1.0, 1.0, 1.0));
  vec3 tmpvar_98;
  tmpvar_98 = abs((st_7 - tmpvar_97));
  vec4 tmpvar_99;
  tmpvar_99.xyz = (tmpvar_97 - (max (
    max (tmpvar_98.x, tmpvar_98.y)
  , tmpvar_98.z) * tmpvar_8));
  tmpvar_99.w = _Level;
  st_7 = (tmpvar_41 + (0.5 * tmpvar_9));
  vec4 tmpvar_100;
  tmpvar_100.xyz = st_7;
  tmpvar_100.w = _Level;
  st_7 = (tmpvar_41 - (0.5 * tmpvar_9));
  s1_4 = (max (vec4(0.0, 0.0, 0.0, 0.0), textureCubeLod (_MainTex, tmpvar_100.xyz, _Level)) + max (vec4(0.0, 0.0, 0.0, 0.0), textureCubeLod (_MainTex, st_7, _Level)));
  st_7 = ((xlv_TEXCOORD0.xyz - (1.5 * tmpvar_9)) + (2.5 * tmpvar_10));
  vec3 tmpvar_101;
  tmpvar_101 = min (max (st_7, vec3(-1.0, -1.0, -1.0)), vec3(1.0, 1.0, 1.0));
  vec3 tmpvar_102;
  tmpvar_102 = abs((st_7 - tmpvar_101));
  vec4 tmpvar_103;
  tmpvar_103.xyz = (tmpvar_101 - (max (
    max (tmpvar_102.x, tmpvar_102.y)
  , tmpvar_102.z) * tmpvar_8));
  tmpvar_103.w = _Level;
  s2_3 = (max (vec4(0.0, 0.0, 0.0, 0.0), textureCubeLod (_MainTex, tmpvar_99.xyz, _Level)) + max (vec4(0.0, 0.0, 0.0, 0.0), textureCubeLod (_MainTex, tmpvar_103.xyz, _Level)));
  st_7 = ((xlv_TEXCOORD0.xyz - (2.5 * tmpvar_9)) + (2.5 * tmpvar_10));
  vec3 tmpvar_104;
  vec3 tmpvar_105;
  tmpvar_105 = min (max (st_7, vec3(-1.0, -1.0, -1.0)), vec3(1.0, 1.0, 1.0));
  vec3 tmpvar_106;
  tmpvar_106 = abs((st_7 - tmpvar_105));
  tmpvar_104 = (tmpvar_105 - (max (
    max (tmpvar_106.x, tmpvar_106.y)
  , tmpvar_106.z) * tmpvar_8));
  st_7 = tmpvar_104;
  s3_2 = (max (vec4(0.0, 0.0, 0.0, 0.0), textureCubeLod (_MainTex, tmpvar_96.xyz, _Level)) + max (vec4(0.0, 0.0, 0.0, 0.0), textureCubeLod (_MainTex, tmpvar_104, _Level)));
  w_5 = (w_5 + dot (c_1, vec3(2.0, 2.0, 2.0)));
  s1_4 = ((c_1.x * s1_4) + (c_1.y * s2_3));
  s_6 = (s_6 + (c_1.z * s3_2));
  s_6 = (s_6 + s1_4);
  gl_FragData[0] = (s_6 / w_5);
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
  GpuProgramID 85008
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
uniform samplerCube _MainTex;
uniform float _Level;
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