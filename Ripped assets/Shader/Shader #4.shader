//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Standard" {
Properties {
 _Color ("Color", Color) = (1,1,1,1)
 _MainTex ("Albedo", 2D) = "white" { }
 _Cutoff ("Alpha Cutoff", Range(0,1)) = 0.5
 _Glossiness ("Smoothness", Range(0,1)) = 0.5
[Gamma]  _Metallic ("Metallic", Range(0,1)) = 0
 _MetallicGlossMap ("Metallic", 2D) = "white" { }
 _BumpScale ("Scale", Float) = 1
 _BumpMap ("Normal Map", 2D) = "bump" { }
 _Parallax ("Height Scale", Range(0.005,0.08)) = 0.02
 _ParallaxMap ("Height Map", 2D) = "black" { }
 _OcclusionStrength ("Strength", Range(0,1)) = 1
 _OcclusionMap ("Occlusion", 2D) = "white" { }
 _EmissionColor ("Color", Color) = (0,0,0,1)
 _EmissionMap ("Emission", 2D) = "white" { }
 _DetailMask ("Detail Mask", 2D) = "white" { }
 _DetailAlbedoMap ("Detail Albedo x2", 2D) = "grey" { }
 _DetailNormalMapScale ("Scale", Float) = 1
 _DetailNormalMap ("Normal Map", 2D) = "bump" { }
[Enum(UV0,0,UV1,1)]  _UVSec ("UV Set for secondary textures", Float) = 0
[HideInInspector]  _Mode ("__mode", Float) = 0
[HideInInspector]  _SrcBlend ("__src", Float) = 1
[HideInInspector]  _DstBlend ("__dst", Float) = 0
[HideInInspector]  _ZWrite ("__zw", Float) = 1
}
SubShader { 
 LOD 300
 Tags { "RenderType"="Opaque" "PerformanceChecks"="False" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" "RenderType"="Opaque" "PerformanceChecks"="False" }
  ZWrite [_ZWrite]
  Blend [_SrcBlend] [_DstBlend]
  GpuProgramID 39223
Program "vp" {
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 120

#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD8;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec3 tmpvar_7;
  vec4 tmpvar_8;
  tmpvar_8 = (_Object2World * gl_Vertex);
  tmpvar_7 = tmpvar_8.xyz;
  tmpvar_3 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_9;
  texcoord_9.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_10;
  if ((_UVSec == 0.0)) {
    tmpvar_10 = tmpvar_1;
  } else {
    tmpvar_10 = tmpvar_2;
  };
  texcoord_9.zw = ((tmpvar_10 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec3 n_11;
  n_11 = (tmpvar_8.xyz - _WorldSpaceCameraPos);
  vec4 v_12;
  v_12.x = _World2Object[0].x;
  v_12.y = _World2Object[1].x;
  v_12.z = _World2Object[2].x;
  v_12.w = _World2Object[3].x;
  vec4 v_13;
  v_13.x = _World2Object[0].y;
  v_13.y = _World2Object[1].y;
  v_13.z = _World2Object[2].y;
  v_13.w = _World2Object[3].y;
  vec4 v_14;
  v_14.x = _World2Object[0].z;
  v_14.y = _World2Object[1].z;
  v_14.z = _World2Object[2].z;
  v_14.w = _World2Object[3].z;
  vec3 tmpvar_15;
  tmpvar_15 = normalize(((
    (v_12.xyz * gl_Normal.x)
   + 
    (v_13.xyz * gl_Normal.y)
  ) + (v_14.xyz * gl_Normal.z)));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_15;
  vec4 ambientOrLightmapUV_16;
  ambientOrLightmapUV_16 = vec4(0.0, 0.0, 0.0, 0.0);
  vec3 ambient_17;
  ambient_17 = vec3(0.0, 0.0, 0.0);
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    ambient_17 = vec3(0.0, 0.0, 0.0);
  };
  vec3 x1_18;
  vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_15.xyzz * tmpvar_15.yzzx);
  x1_18.x = dot (unity_SHBr, tmpvar_19);
  x1_18.y = dot (unity_SHBg, tmpvar_19);
  x1_18.z = dot (unity_SHBb, tmpvar_19);
  ambient_17 = (ambient_17 + (x1_18 + (unity_SHC.xyz * 
    ((tmpvar_15.x * tmpvar_15.x) - (tmpvar_15.y * tmpvar_15.y))
  )));
  ambientOrLightmapUV_16.xyz = ambient_17;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = texcoord_9;
  xlv_TEXCOORD1 = n_11;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = ambientOrLightmapUV_16;
  xlv_TEXCOORD8 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform samplerCube unity_SpecCube0;
uniform samplerCube unity_SpecCube1;
uniform vec4 unity_SpecCube0_BoxMax;
uniform vec4 unity_SpecCube0_BoxMin;
uniform vec4 unity_SpecCube0_ProbePosition;
uniform vec4 unity_SpecCube0_HDR;
uniform vec4 unity_SpecCube1_BoxMax;
uniform vec4 unity_SpecCube1_BoxMin;
uniform vec4 unity_SpecCube1_ProbePosition;
uniform vec4 unity_SpecCube1_HDR;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _LightColor0;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform float _OcclusionStrength;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD8;
void main ()
{
  vec4 c_1;
  vec3 tmpvar_2;
  tmpvar_2 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_3;
  vec3 tmpvar_4;
  tmpvar_4 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_2, vec3(_Metallic));
  float tmpvar_5;
  tmpvar_5 = (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w));
  tmpvar_3 = (tmpvar_2 * tmpvar_5);
  vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD2_2.xyz);
  vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD1);
  float tmpvar_8;
  tmpvar_8 = ((1.0 - _OcclusionStrength) + (texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y * _OcclusionStrength));
  float tmpvar_9;
  tmpvar_9 = max (0.0, dot (tmpvar_6, _WorldSpaceLightPos0.xyz));
  float tmpvar_10;
  tmpvar_10 = (1.0 - _Glossiness);
  vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_7 - (2.0 * (
    dot (tmpvar_6, tmpvar_7)
   * tmpvar_6)));
  vec3 tmpvar_12;
  vec3 tmpvar_13;
  tmpvar_13 = vec3(0.0, 0.0, 0.0);
  vec3 ambient_14;
  vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_6;
  vec3 x_16;
  x_16.x = dot (unity_SHAr, tmpvar_15);
  x_16.y = dot (unity_SHAg, tmpvar_15);
  x_16.z = dot (unity_SHAb, tmpvar_15);
  ambient_14 = (xlv_TEXCOORD5.xyz + x_16);
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    ambient_14 = max (((1.055 * 
      pow (max (ambient_14, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
    ) - 0.055), vec3(0.0, 0.0, 0.0));
  };
  tmpvar_13 = (ambient_14 * tmpvar_8);
  tmpvar_12 = vec3(0.0, 0.0, 0.0);
  vec3 specular_17;
  vec3 worldRefl_18;
  worldRefl_18 = tmpvar_11;
  vec3 worldPos_19;
  worldPos_19 = xlv_TEXCOORD8;
  if ((unity_SpecCube0_ProbePosition.w > 0.0)) {
    vec3 tmpvar_20;
    tmpvar_20 = normalize(tmpvar_11);
    vec3 tmpvar_21;
    tmpvar_21 = ((unity_SpecCube0_BoxMax.xyz - xlv_TEXCOORD8) / tmpvar_20);
    vec3 tmpvar_22;
    tmpvar_22 = ((unity_SpecCube0_BoxMin.xyz - xlv_TEXCOORD8) / tmpvar_20);
    bvec3 tmpvar_23;
    tmpvar_23 = greaterThan (tmpvar_20, vec3(0.0, 0.0, 0.0));
    float tmpvar_24;
    if (tmpvar_23.x) {
      tmpvar_24 = tmpvar_21.x;
    } else {
      tmpvar_24 = tmpvar_22.x;
    };
    float tmpvar_25;
    if (tmpvar_23.y) {
      tmpvar_25 = tmpvar_21.y;
    } else {
      tmpvar_25 = tmpvar_22.y;
    };
    float tmpvar_26;
    if (tmpvar_23.z) {
      tmpvar_26 = tmpvar_21.z;
    } else {
      tmpvar_26 = tmpvar_22.z;
    };
    worldPos_19 = (xlv_TEXCOORD8 - unity_SpecCube0_ProbePosition.xyz);
    worldRefl_18 = (worldPos_19 + (tmpvar_20 * min (
      min (tmpvar_24, tmpvar_25)
    , tmpvar_26)));
  };
  vec4 tmpvar_27;
  tmpvar_27.xyz = worldRefl_18;
  tmpvar_27.w = ((tmpvar_10 * (1.7 - 
    (0.7 * tmpvar_10)
  )) * 6.0);
  vec4 tmpvar_28;
  tmpvar_28 = textureCubeLod (unity_SpecCube0, worldRefl_18, tmpvar_27.w);
  vec3 tmpvar_29;
  tmpvar_29 = ((unity_SpecCube0_HDR.x * pow (tmpvar_28.w, unity_SpecCube0_HDR.y)) * tmpvar_28.xyz);
  if ((unity_SpecCube0_BoxMin.w < 0.99999)) {
    vec3 worldRefl_30;
    worldRefl_30 = tmpvar_11;
    vec3 worldPos_31;
    worldPos_31 = xlv_TEXCOORD8;
    if ((unity_SpecCube1_ProbePosition.w > 0.0)) {
      vec3 tmpvar_32;
      tmpvar_32 = normalize(tmpvar_11);
      vec3 tmpvar_33;
      tmpvar_33 = ((unity_SpecCube1_BoxMax.xyz - xlv_TEXCOORD8) / tmpvar_32);
      vec3 tmpvar_34;
      tmpvar_34 = ((unity_SpecCube1_BoxMin.xyz - xlv_TEXCOORD8) / tmpvar_32);
      bvec3 tmpvar_35;
      tmpvar_35 = greaterThan (tmpvar_32, vec3(0.0, 0.0, 0.0));
      float tmpvar_36;
      if (tmpvar_35.x) {
        tmpvar_36 = tmpvar_33.x;
      } else {
        tmpvar_36 = tmpvar_34.x;
      };
      float tmpvar_37;
      if (tmpvar_35.y) {
        tmpvar_37 = tmpvar_33.y;
      } else {
        tmpvar_37 = tmpvar_34.y;
      };
      float tmpvar_38;
      if (tmpvar_35.z) {
        tmpvar_38 = tmpvar_33.z;
      } else {
        tmpvar_38 = tmpvar_34.z;
      };
      worldPos_31 = (xlv_TEXCOORD8 - unity_SpecCube1_ProbePosition.xyz);
      worldRefl_30 = (worldPos_31 + (tmpvar_32 * min (
        min (tmpvar_36, tmpvar_37)
      , tmpvar_38)));
    };
    vec4 tmpvar_39;
    tmpvar_39.xyz = worldRefl_30;
    tmpvar_39.w = ((tmpvar_10 * (1.7 - 
      (0.7 * tmpvar_10)
    )) * 6.0);
    vec4 tmpvar_40;
    tmpvar_40 = textureCubeLod (unity_SpecCube1, worldRefl_30, tmpvar_39.w);
    specular_17 = mix (((unity_SpecCube1_HDR.x * 
      pow (tmpvar_40.w, unity_SpecCube1_HDR.y)
    ) * tmpvar_40.xyz), tmpvar_29, unity_SpecCube0_BoxMin.www);
  } else {
    specular_17 = tmpvar_29;
  };
  tmpvar_12 = (specular_17 * tmpvar_8);
  vec3 viewDir_41;
  viewDir_41 = -(tmpvar_7);
  float specularTerm_42;
  float tmpvar_43;
  tmpvar_43 = (1.0 - _Glossiness);
  vec3 tmpvar_44;
  vec3 inVec_45;
  inVec_45 = (_WorldSpaceLightPos0.xyz + viewDir_41);
  tmpvar_44 = (inVec_45 * inversesqrt(max (0.001, 
    dot (inVec_45, inVec_45)
  )));
  float tmpvar_46;
  tmpvar_46 = max (0.0, dot (tmpvar_6, tmpvar_44));
  float tmpvar_47;
  tmpvar_47 = max (0.0, dot (tmpvar_6, viewDir_41));
  float tmpvar_48;
  tmpvar_48 = max (0.0, dot (_WorldSpaceLightPos0.xyz, tmpvar_44));
  float tmpvar_49;
  tmpvar_49 = (tmpvar_43 * tmpvar_43);
  float tmpvar_50;
  tmpvar_50 = (tmpvar_43 * tmpvar_43);
  float tmpvar_51;
  tmpvar_51 = (tmpvar_50 * tmpvar_50);
  float tmpvar_52;
  tmpvar_52 = (((tmpvar_46 * tmpvar_46) * (tmpvar_51 - 1.0)) + 1.0);
  float x_53;
  x_53 = (1.0 - tmpvar_9);
  float x_54;
  x_54 = (1.0 - tmpvar_47);
  float tmpvar_55;
  tmpvar_55 = (0.5 + ((2.0 * tmpvar_48) * (tmpvar_48 * tmpvar_43)));
  float tmpvar_56;
  tmpvar_56 = ((1.0 + (
    (tmpvar_55 - 1.0)
   * 
    ((x_53 * x_53) * ((x_53 * x_53) * x_53))
  )) * (1.0 + (
    (tmpvar_55 - 1.0)
   * 
    ((x_54 * x_54) * ((x_54 * x_54) * x_54))
  )));
  float tmpvar_57;
  tmpvar_57 = (((
    (2.0 * tmpvar_9)
   / 
    (((tmpvar_9 * (
      (tmpvar_47 * (1.0 - tmpvar_49))
     + tmpvar_49)) + (tmpvar_47 * (
      (tmpvar_9 * (1.0 - tmpvar_49))
     + tmpvar_49))) + 1e-05)
  ) * (tmpvar_51 / 
    ((3.141593 * tmpvar_52) * tmpvar_52)
  )) * 0.7853982);
  specularTerm_42 = tmpvar_57;
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    specularTerm_42 = sqrt(max (0.0001, tmpvar_57));
  };
  float tmpvar_58;
  tmpvar_58 = max (0.0, (specularTerm_42 * tmpvar_9));
  specularTerm_42 = tmpvar_58;
  float x_59;
  x_59 = (1.0 - tmpvar_48);
  float x_60;
  x_60 = (1.0 - tmpvar_47);
  vec3 tmpvar_61;
  tmpvar_61 = (((tmpvar_3 * 
    (tmpvar_13 + (_LightColor0.xyz * (tmpvar_56 * tmpvar_9)))
  ) + (
    (tmpvar_58 * _LightColor0.xyz)
   * 
    (tmpvar_4 + ((1.0 - tmpvar_4) * ((x_59 * x_59) * (
      (x_59 * x_59)
     * x_59))))
  )) + (tmpvar_12 * mix (tmpvar_4, vec3(
    clamp ((_Glossiness + (1.0 - tmpvar_5)), 0.0, 1.0)
  ), vec3(
    ((x_60 * x_60) * ((x_60 * x_60) * x_60))
  ))));
  vec4 tmpvar_62;
  tmpvar_62.w = 1.0;
  tmpvar_62.xyz = tmpvar_61;
  c_1.w = tmpvar_62.w;
  c_1.xyz = tmpvar_61;
  c_1.xyz = c_1.xyz;
  vec4 xlat_varoutput_63;
  xlat_varoutput_63.xyz = c_1.xyz;
  xlat_varoutput_63.w = 1.0;
  gl_FragData[0] = xlat_varoutput_63;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 120

#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD8;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec3 tmpvar_7;
  vec4 tmpvar_8;
  tmpvar_8 = (_Object2World * gl_Vertex);
  tmpvar_7 = tmpvar_8.xyz;
  tmpvar_3 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_9;
  texcoord_9.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_10;
  if ((_UVSec == 0.0)) {
    tmpvar_10 = tmpvar_1;
  } else {
    tmpvar_10 = tmpvar_2;
  };
  texcoord_9.zw = ((tmpvar_10 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec3 n_11;
  n_11 = (tmpvar_8.xyz - _WorldSpaceCameraPos);
  vec4 v_12;
  v_12.x = _World2Object[0].x;
  v_12.y = _World2Object[1].x;
  v_12.z = _World2Object[2].x;
  v_12.w = _World2Object[3].x;
  vec4 v_13;
  v_13.x = _World2Object[0].y;
  v_13.y = _World2Object[1].y;
  v_13.z = _World2Object[2].y;
  v_13.w = _World2Object[3].y;
  vec4 v_14;
  v_14.x = _World2Object[0].z;
  v_14.y = _World2Object[1].z;
  v_14.z = _World2Object[2].z;
  v_14.w = _World2Object[3].z;
  vec3 tmpvar_15;
  tmpvar_15 = normalize(((
    (v_12.xyz * gl_Normal.x)
   + 
    (v_13.xyz * gl_Normal.y)
  ) + (v_14.xyz * gl_Normal.z)));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_15;
  vec4 o_16;
  vec4 tmpvar_17;
  tmpvar_17 = (tmpvar_3 * 0.5);
  vec2 tmpvar_18;
  tmpvar_18.x = tmpvar_17.x;
  tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
  o_16.xy = (tmpvar_18 + tmpvar_17.w);
  o_16.zw = tmpvar_3.zw;
  vec4 ambientOrLightmapUV_19;
  ambientOrLightmapUV_19 = vec4(0.0, 0.0, 0.0, 0.0);
  vec3 ambient_20;
  ambient_20 = vec3(0.0, 0.0, 0.0);
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    ambient_20 = vec3(0.0, 0.0, 0.0);
  };
  vec3 x1_21;
  vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_15.xyzz * tmpvar_15.yzzx);
  x1_21.x = dot (unity_SHBr, tmpvar_22);
  x1_21.y = dot (unity_SHBg, tmpvar_22);
  x1_21.z = dot (unity_SHBb, tmpvar_22);
  ambient_20 = (ambient_20 + (x1_21 + (unity_SHC.xyz * 
    ((tmpvar_15.x * tmpvar_15.x) - (tmpvar_15.y * tmpvar_15.y))
  )));
  ambientOrLightmapUV_19.xyz = ambient_20;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = texcoord_9;
  xlv_TEXCOORD1 = n_11;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = ambientOrLightmapUV_19;
  xlv_TEXCOORD6 = o_16;
  xlv_TEXCOORD8 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform samplerCube unity_SpecCube0;
uniform samplerCube unity_SpecCube1;
uniform vec4 unity_SpecCube0_BoxMax;
uniform vec4 unity_SpecCube0_BoxMin;
uniform vec4 unity_SpecCube0_ProbePosition;
uniform vec4 unity_SpecCube0_HDR;
uniform vec4 unity_SpecCube1_BoxMax;
uniform vec4 unity_SpecCube1_BoxMin;
uniform vec4 unity_SpecCube1_ProbePosition;
uniform vec4 unity_SpecCube1_HDR;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _LightColor0;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform float _OcclusionStrength;
uniform sampler2D _ShadowMapTexture;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD8;
void main ()
{
  vec4 c_1;
  vec3 tmpvar_2;
  tmpvar_2 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_3;
  vec3 tmpvar_4;
  tmpvar_4 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_2, vec3(_Metallic));
  float tmpvar_5;
  tmpvar_5 = (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w));
  tmpvar_3 = (tmpvar_2 * tmpvar_5);
  vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD2_2.xyz);
  vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD1);
  float tmpvar_8;
  tmpvar_8 = ((1.0 - _OcclusionStrength) + (texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y * _OcclusionStrength));
  float tmpvar_9;
  tmpvar_9 = max (0.0, dot (tmpvar_6, _WorldSpaceLightPos0.xyz));
  float tmpvar_10;
  tmpvar_10 = (1.0 - _Glossiness);
  vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_7 - (2.0 * (
    dot (tmpvar_6, tmpvar_7)
   * tmpvar_6)));
  vec3 tmpvar_12;
  vec3 tmpvar_13;
  vec3 tmpvar_14;
  tmpvar_14 = vec3(0.0, 0.0, 0.0);
  tmpvar_13 = (_LightColor0.xyz * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD6).x);
  vec3 ambient_15;
  vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_6;
  vec3 x_17;
  x_17.x = dot (unity_SHAr, tmpvar_16);
  x_17.y = dot (unity_SHAg, tmpvar_16);
  x_17.z = dot (unity_SHAb, tmpvar_16);
  ambient_15 = (xlv_TEXCOORD5.xyz + x_17);
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    ambient_15 = max (((1.055 * 
      pow (max (ambient_15, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
    ) - 0.055), vec3(0.0, 0.0, 0.0));
  };
  tmpvar_14 = (ambient_15 * tmpvar_8);
  tmpvar_12 = vec3(0.0, 0.0, 0.0);
  vec3 specular_18;
  vec3 worldRefl_19;
  worldRefl_19 = tmpvar_11;
  vec3 worldPos_20;
  worldPos_20 = xlv_TEXCOORD8;
  if ((unity_SpecCube0_ProbePosition.w > 0.0)) {
    vec3 tmpvar_21;
    tmpvar_21 = normalize(tmpvar_11);
    vec3 tmpvar_22;
    tmpvar_22 = ((unity_SpecCube0_BoxMax.xyz - xlv_TEXCOORD8) / tmpvar_21);
    vec3 tmpvar_23;
    tmpvar_23 = ((unity_SpecCube0_BoxMin.xyz - xlv_TEXCOORD8) / tmpvar_21);
    bvec3 tmpvar_24;
    tmpvar_24 = greaterThan (tmpvar_21, vec3(0.0, 0.0, 0.0));
    float tmpvar_25;
    if (tmpvar_24.x) {
      tmpvar_25 = tmpvar_22.x;
    } else {
      tmpvar_25 = tmpvar_23.x;
    };
    float tmpvar_26;
    if (tmpvar_24.y) {
      tmpvar_26 = tmpvar_22.y;
    } else {
      tmpvar_26 = tmpvar_23.y;
    };
    float tmpvar_27;
    if (tmpvar_24.z) {
      tmpvar_27 = tmpvar_22.z;
    } else {
      tmpvar_27 = tmpvar_23.z;
    };
    worldPos_20 = (xlv_TEXCOORD8 - unity_SpecCube0_ProbePosition.xyz);
    worldRefl_19 = (worldPos_20 + (tmpvar_21 * min (
      min (tmpvar_25, tmpvar_26)
    , tmpvar_27)));
  };
  vec4 tmpvar_28;
  tmpvar_28.xyz = worldRefl_19;
  tmpvar_28.w = ((tmpvar_10 * (1.7 - 
    (0.7 * tmpvar_10)
  )) * 6.0);
  vec4 tmpvar_29;
  tmpvar_29 = textureCubeLod (unity_SpecCube0, worldRefl_19, tmpvar_28.w);
  vec3 tmpvar_30;
  tmpvar_30 = ((unity_SpecCube0_HDR.x * pow (tmpvar_29.w, unity_SpecCube0_HDR.y)) * tmpvar_29.xyz);
  if ((unity_SpecCube0_BoxMin.w < 0.99999)) {
    vec3 worldRefl_31;
    worldRefl_31 = tmpvar_11;
    vec3 worldPos_32;
    worldPos_32 = xlv_TEXCOORD8;
    if ((unity_SpecCube1_ProbePosition.w > 0.0)) {
      vec3 tmpvar_33;
      tmpvar_33 = normalize(tmpvar_11);
      vec3 tmpvar_34;
      tmpvar_34 = ((unity_SpecCube1_BoxMax.xyz - xlv_TEXCOORD8) / tmpvar_33);
      vec3 tmpvar_35;
      tmpvar_35 = ((unity_SpecCube1_BoxMin.xyz - xlv_TEXCOORD8) / tmpvar_33);
      bvec3 tmpvar_36;
      tmpvar_36 = greaterThan (tmpvar_33, vec3(0.0, 0.0, 0.0));
      float tmpvar_37;
      if (tmpvar_36.x) {
        tmpvar_37 = tmpvar_34.x;
      } else {
        tmpvar_37 = tmpvar_35.x;
      };
      float tmpvar_38;
      if (tmpvar_36.y) {
        tmpvar_38 = tmpvar_34.y;
      } else {
        tmpvar_38 = tmpvar_35.y;
      };
      float tmpvar_39;
      if (tmpvar_36.z) {
        tmpvar_39 = tmpvar_34.z;
      } else {
        tmpvar_39 = tmpvar_35.z;
      };
      worldPos_32 = (xlv_TEXCOORD8 - unity_SpecCube1_ProbePosition.xyz);
      worldRefl_31 = (worldPos_32 + (tmpvar_33 * min (
        min (tmpvar_37, tmpvar_38)
      , tmpvar_39)));
    };
    vec4 tmpvar_40;
    tmpvar_40.xyz = worldRefl_31;
    tmpvar_40.w = ((tmpvar_10 * (1.7 - 
      (0.7 * tmpvar_10)
    )) * 6.0);
    vec4 tmpvar_41;
    tmpvar_41 = textureCubeLod (unity_SpecCube1, worldRefl_31, tmpvar_40.w);
    specular_18 = mix (((unity_SpecCube1_HDR.x * 
      pow (tmpvar_41.w, unity_SpecCube1_HDR.y)
    ) * tmpvar_41.xyz), tmpvar_30, unity_SpecCube0_BoxMin.www);
  } else {
    specular_18 = tmpvar_30;
  };
  tmpvar_12 = (specular_18 * tmpvar_8);
  vec3 viewDir_42;
  viewDir_42 = -(tmpvar_7);
  float specularTerm_43;
  float tmpvar_44;
  tmpvar_44 = (1.0 - _Glossiness);
  vec3 tmpvar_45;
  vec3 inVec_46;
  inVec_46 = (_WorldSpaceLightPos0.xyz + viewDir_42);
  tmpvar_45 = (inVec_46 * inversesqrt(max (0.001, 
    dot (inVec_46, inVec_46)
  )));
  float tmpvar_47;
  tmpvar_47 = max (0.0, dot (tmpvar_6, tmpvar_45));
  float tmpvar_48;
  tmpvar_48 = max (0.0, dot (tmpvar_6, viewDir_42));
  float tmpvar_49;
  tmpvar_49 = max (0.0, dot (_WorldSpaceLightPos0.xyz, tmpvar_45));
  float tmpvar_50;
  tmpvar_50 = (tmpvar_44 * tmpvar_44);
  float tmpvar_51;
  tmpvar_51 = (tmpvar_44 * tmpvar_44);
  float tmpvar_52;
  tmpvar_52 = (tmpvar_51 * tmpvar_51);
  float tmpvar_53;
  tmpvar_53 = (((tmpvar_47 * tmpvar_47) * (tmpvar_52 - 1.0)) + 1.0);
  float x_54;
  x_54 = (1.0 - tmpvar_9);
  float x_55;
  x_55 = (1.0 - tmpvar_48);
  float tmpvar_56;
  tmpvar_56 = (0.5 + ((2.0 * tmpvar_49) * (tmpvar_49 * tmpvar_44)));
  float tmpvar_57;
  tmpvar_57 = ((1.0 + (
    (tmpvar_56 - 1.0)
   * 
    ((x_54 * x_54) * ((x_54 * x_54) * x_54))
  )) * (1.0 + (
    (tmpvar_56 - 1.0)
   * 
    ((x_55 * x_55) * ((x_55 * x_55) * x_55))
  )));
  float tmpvar_58;
  tmpvar_58 = (((
    (2.0 * tmpvar_9)
   / 
    (((tmpvar_9 * (
      (tmpvar_48 * (1.0 - tmpvar_50))
     + tmpvar_50)) + (tmpvar_48 * (
      (tmpvar_9 * (1.0 - tmpvar_50))
     + tmpvar_50))) + 1e-05)
  ) * (tmpvar_52 / 
    ((3.141593 * tmpvar_53) * tmpvar_53)
  )) * 0.7853982);
  specularTerm_43 = tmpvar_58;
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    specularTerm_43 = sqrt(max (0.0001, tmpvar_58));
  };
  float tmpvar_59;
  tmpvar_59 = max (0.0, (specularTerm_43 * tmpvar_9));
  specularTerm_43 = tmpvar_59;
  float x_60;
  x_60 = (1.0 - tmpvar_49);
  float x_61;
  x_61 = (1.0 - tmpvar_48);
  vec3 tmpvar_62;
  tmpvar_62 = (((tmpvar_3 * 
    (tmpvar_14 + (tmpvar_13 * (tmpvar_57 * tmpvar_9)))
  ) + (
    (tmpvar_59 * tmpvar_13)
   * 
    (tmpvar_4 + ((1.0 - tmpvar_4) * ((x_60 * x_60) * (
      (x_60 * x_60)
     * x_60))))
  )) + (tmpvar_12 * mix (tmpvar_4, vec3(
    clamp ((_Glossiness + (1.0 - tmpvar_5)), 0.0, 1.0)
  ), vec3(
    ((x_61 * x_61) * ((x_61 * x_61) * x_61))
  ))));
  vec4 tmpvar_63;
  tmpvar_63.w = 1.0;
  tmpvar_63.xyz = tmpvar_62;
  c_1.w = tmpvar_63.w;
  c_1.xyz = tmpvar_62;
  c_1.xyz = c_1.xyz;
  vec4 xlat_varoutput_64;
  xlat_varoutput_64.xyz = c_1.xyz;
  xlat_varoutput_64.w = 1.0;
  gl_FragData[0] = xlat_varoutput_64;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"#version 120

#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 unity_4LightPosX0;
uniform vec4 unity_4LightPosY0;
uniform vec4 unity_4LightPosZ0;
uniform vec4 unity_4LightAtten0;
uniform vec4 unity_LightColor[8];
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD8;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec3 tmpvar_7;
  vec4 tmpvar_8;
  tmpvar_8 = (_Object2World * gl_Vertex);
  tmpvar_7 = tmpvar_8.xyz;
  tmpvar_3 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_9;
  texcoord_9.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_10;
  if ((_UVSec == 0.0)) {
    tmpvar_10 = tmpvar_1;
  } else {
    tmpvar_10 = tmpvar_2;
  };
  texcoord_9.zw = ((tmpvar_10 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec3 n_11;
  n_11 = (tmpvar_8.xyz - _WorldSpaceCameraPos);
  vec4 v_12;
  v_12.x = _World2Object[0].x;
  v_12.y = _World2Object[1].x;
  v_12.z = _World2Object[2].x;
  v_12.w = _World2Object[3].x;
  vec4 v_13;
  v_13.x = _World2Object[0].y;
  v_13.y = _World2Object[1].y;
  v_13.z = _World2Object[2].y;
  v_13.w = _World2Object[3].y;
  vec4 v_14;
  v_14.x = _World2Object[0].z;
  v_14.y = _World2Object[1].z;
  v_14.z = _World2Object[2].z;
  v_14.w = _World2Object[3].z;
  vec3 tmpvar_15;
  tmpvar_15 = normalize(((
    (v_12.xyz * gl_Normal.x)
   + 
    (v_13.xyz * gl_Normal.y)
  ) + (v_14.xyz * gl_Normal.z)));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_15;
  vec4 ambientOrLightmapUV_16;
  ambientOrLightmapUV_16.w = 0.0;
  vec3 col_17;
  vec4 ndotl_18;
  vec4 lengthSq_19;
  vec4 tmpvar_20;
  tmpvar_20 = (unity_4LightPosX0 - tmpvar_8.x);
  vec4 tmpvar_21;
  tmpvar_21 = (unity_4LightPosY0 - tmpvar_8.y);
  vec4 tmpvar_22;
  tmpvar_22 = (unity_4LightPosZ0 - tmpvar_8.z);
  lengthSq_19 = (tmpvar_20 * tmpvar_20);
  lengthSq_19 = (lengthSq_19 + (tmpvar_21 * tmpvar_21));
  lengthSq_19 = (lengthSq_19 + (tmpvar_22 * tmpvar_22));
  ndotl_18 = (tmpvar_20 * tmpvar_15.x);
  ndotl_18 = (ndotl_18 + (tmpvar_21 * tmpvar_15.y));
  ndotl_18 = (ndotl_18 + (tmpvar_22 * tmpvar_15.z));
  vec4 tmpvar_23;
  tmpvar_23 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_18 * inversesqrt(lengthSq_19)));
  ndotl_18 = tmpvar_23;
  vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_23 * (1.0/((1.0 + 
    (lengthSq_19 * unity_4LightAtten0)
  ))));
  col_17 = (unity_LightColor[0].xyz * tmpvar_24.x);
  col_17 = (col_17 + (unity_LightColor[1].xyz * tmpvar_24.y));
  col_17 = (col_17 + (unity_LightColor[2].xyz * tmpvar_24.z));
  col_17 = (col_17 + (unity_LightColor[3].xyz * tmpvar_24.w));
  ambientOrLightmapUV_16.xyz = col_17;
  vec3 ambient_25;
  ambient_25 = ambientOrLightmapUV_16.xyz;
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    ambient_25 = (col_17 * ((col_17 * 
      ((col_17 * 0.305306) + 0.6821711)
    ) + 0.01252288));
  };
  vec3 x1_26;
  vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_15.xyzz * tmpvar_15.yzzx);
  x1_26.x = dot (unity_SHBr, tmpvar_27);
  x1_26.y = dot (unity_SHBg, tmpvar_27);
  x1_26.z = dot (unity_SHBb, tmpvar_27);
  ambient_25 = (ambient_25 + (x1_26 + (unity_SHC.xyz * 
    ((tmpvar_15.x * tmpvar_15.x) - (tmpvar_15.y * tmpvar_15.y))
  )));
  ambientOrLightmapUV_16.xyz = ambient_25;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = texcoord_9;
  xlv_TEXCOORD1 = n_11;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = ambientOrLightmapUV_16;
  xlv_TEXCOORD8 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform samplerCube unity_SpecCube0;
uniform samplerCube unity_SpecCube1;
uniform vec4 unity_SpecCube0_BoxMax;
uniform vec4 unity_SpecCube0_BoxMin;
uniform vec4 unity_SpecCube0_ProbePosition;
uniform vec4 unity_SpecCube0_HDR;
uniform vec4 unity_SpecCube1_BoxMax;
uniform vec4 unity_SpecCube1_BoxMin;
uniform vec4 unity_SpecCube1_ProbePosition;
uniform vec4 unity_SpecCube1_HDR;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _LightColor0;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform float _OcclusionStrength;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD8;
void main ()
{
  vec4 c_1;
  vec3 tmpvar_2;
  tmpvar_2 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_3;
  vec3 tmpvar_4;
  tmpvar_4 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_2, vec3(_Metallic));
  float tmpvar_5;
  tmpvar_5 = (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w));
  tmpvar_3 = (tmpvar_2 * tmpvar_5);
  vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD2_2.xyz);
  vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD1);
  float tmpvar_8;
  tmpvar_8 = ((1.0 - _OcclusionStrength) + (texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y * _OcclusionStrength));
  float tmpvar_9;
  tmpvar_9 = max (0.0, dot (tmpvar_6, _WorldSpaceLightPos0.xyz));
  float tmpvar_10;
  tmpvar_10 = (1.0 - _Glossiness);
  vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_7 - (2.0 * (
    dot (tmpvar_6, tmpvar_7)
   * tmpvar_6)));
  vec3 tmpvar_12;
  vec3 tmpvar_13;
  tmpvar_13 = vec3(0.0, 0.0, 0.0);
  vec3 ambient_14;
  vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_6;
  vec3 x_16;
  x_16.x = dot (unity_SHAr, tmpvar_15);
  x_16.y = dot (unity_SHAg, tmpvar_15);
  x_16.z = dot (unity_SHAb, tmpvar_15);
  ambient_14 = (xlv_TEXCOORD5.xyz + x_16);
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    ambient_14 = max (((1.055 * 
      pow (max (ambient_14, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
    ) - 0.055), vec3(0.0, 0.0, 0.0));
  };
  tmpvar_13 = (ambient_14 * tmpvar_8);
  tmpvar_12 = vec3(0.0, 0.0, 0.0);
  vec3 specular_17;
  vec3 worldRefl_18;
  worldRefl_18 = tmpvar_11;
  vec3 worldPos_19;
  worldPos_19 = xlv_TEXCOORD8;
  if ((unity_SpecCube0_ProbePosition.w > 0.0)) {
    vec3 tmpvar_20;
    tmpvar_20 = normalize(tmpvar_11);
    vec3 tmpvar_21;
    tmpvar_21 = ((unity_SpecCube0_BoxMax.xyz - xlv_TEXCOORD8) / tmpvar_20);
    vec3 tmpvar_22;
    tmpvar_22 = ((unity_SpecCube0_BoxMin.xyz - xlv_TEXCOORD8) / tmpvar_20);
    bvec3 tmpvar_23;
    tmpvar_23 = greaterThan (tmpvar_20, vec3(0.0, 0.0, 0.0));
    float tmpvar_24;
    if (tmpvar_23.x) {
      tmpvar_24 = tmpvar_21.x;
    } else {
      tmpvar_24 = tmpvar_22.x;
    };
    float tmpvar_25;
    if (tmpvar_23.y) {
      tmpvar_25 = tmpvar_21.y;
    } else {
      tmpvar_25 = tmpvar_22.y;
    };
    float tmpvar_26;
    if (tmpvar_23.z) {
      tmpvar_26 = tmpvar_21.z;
    } else {
      tmpvar_26 = tmpvar_22.z;
    };
    worldPos_19 = (xlv_TEXCOORD8 - unity_SpecCube0_ProbePosition.xyz);
    worldRefl_18 = (worldPos_19 + (tmpvar_20 * min (
      min (tmpvar_24, tmpvar_25)
    , tmpvar_26)));
  };
  vec4 tmpvar_27;
  tmpvar_27.xyz = worldRefl_18;
  tmpvar_27.w = ((tmpvar_10 * (1.7 - 
    (0.7 * tmpvar_10)
  )) * 6.0);
  vec4 tmpvar_28;
  tmpvar_28 = textureCubeLod (unity_SpecCube0, worldRefl_18, tmpvar_27.w);
  vec3 tmpvar_29;
  tmpvar_29 = ((unity_SpecCube0_HDR.x * pow (tmpvar_28.w, unity_SpecCube0_HDR.y)) * tmpvar_28.xyz);
  if ((unity_SpecCube0_BoxMin.w < 0.99999)) {
    vec3 worldRefl_30;
    worldRefl_30 = tmpvar_11;
    vec3 worldPos_31;
    worldPos_31 = xlv_TEXCOORD8;
    if ((unity_SpecCube1_ProbePosition.w > 0.0)) {
      vec3 tmpvar_32;
      tmpvar_32 = normalize(tmpvar_11);
      vec3 tmpvar_33;
      tmpvar_33 = ((unity_SpecCube1_BoxMax.xyz - xlv_TEXCOORD8) / tmpvar_32);
      vec3 tmpvar_34;
      tmpvar_34 = ((unity_SpecCube1_BoxMin.xyz - xlv_TEXCOORD8) / tmpvar_32);
      bvec3 tmpvar_35;
      tmpvar_35 = greaterThan (tmpvar_32, vec3(0.0, 0.0, 0.0));
      float tmpvar_36;
      if (tmpvar_35.x) {
        tmpvar_36 = tmpvar_33.x;
      } else {
        tmpvar_36 = tmpvar_34.x;
      };
      float tmpvar_37;
      if (tmpvar_35.y) {
        tmpvar_37 = tmpvar_33.y;
      } else {
        tmpvar_37 = tmpvar_34.y;
      };
      float tmpvar_38;
      if (tmpvar_35.z) {
        tmpvar_38 = tmpvar_33.z;
      } else {
        tmpvar_38 = tmpvar_34.z;
      };
      worldPos_31 = (xlv_TEXCOORD8 - unity_SpecCube1_ProbePosition.xyz);
      worldRefl_30 = (worldPos_31 + (tmpvar_32 * min (
        min (tmpvar_36, tmpvar_37)
      , tmpvar_38)));
    };
    vec4 tmpvar_39;
    tmpvar_39.xyz = worldRefl_30;
    tmpvar_39.w = ((tmpvar_10 * (1.7 - 
      (0.7 * tmpvar_10)
    )) * 6.0);
    vec4 tmpvar_40;
    tmpvar_40 = textureCubeLod (unity_SpecCube1, worldRefl_30, tmpvar_39.w);
    specular_17 = mix (((unity_SpecCube1_HDR.x * 
      pow (tmpvar_40.w, unity_SpecCube1_HDR.y)
    ) * tmpvar_40.xyz), tmpvar_29, unity_SpecCube0_BoxMin.www);
  } else {
    specular_17 = tmpvar_29;
  };
  tmpvar_12 = (specular_17 * tmpvar_8);
  vec3 viewDir_41;
  viewDir_41 = -(tmpvar_7);
  float specularTerm_42;
  float tmpvar_43;
  tmpvar_43 = (1.0 - _Glossiness);
  vec3 tmpvar_44;
  vec3 inVec_45;
  inVec_45 = (_WorldSpaceLightPos0.xyz + viewDir_41);
  tmpvar_44 = (inVec_45 * inversesqrt(max (0.001, 
    dot (inVec_45, inVec_45)
  )));
  float tmpvar_46;
  tmpvar_46 = max (0.0, dot (tmpvar_6, tmpvar_44));
  float tmpvar_47;
  tmpvar_47 = max (0.0, dot (tmpvar_6, viewDir_41));
  float tmpvar_48;
  tmpvar_48 = max (0.0, dot (_WorldSpaceLightPos0.xyz, tmpvar_44));
  float tmpvar_49;
  tmpvar_49 = (tmpvar_43 * tmpvar_43);
  float tmpvar_50;
  tmpvar_50 = (tmpvar_43 * tmpvar_43);
  float tmpvar_51;
  tmpvar_51 = (tmpvar_50 * tmpvar_50);
  float tmpvar_52;
  tmpvar_52 = (((tmpvar_46 * tmpvar_46) * (tmpvar_51 - 1.0)) + 1.0);
  float x_53;
  x_53 = (1.0 - tmpvar_9);
  float x_54;
  x_54 = (1.0 - tmpvar_47);
  float tmpvar_55;
  tmpvar_55 = (0.5 + ((2.0 * tmpvar_48) * (tmpvar_48 * tmpvar_43)));
  float tmpvar_56;
  tmpvar_56 = ((1.0 + (
    (tmpvar_55 - 1.0)
   * 
    ((x_53 * x_53) * ((x_53 * x_53) * x_53))
  )) * (1.0 + (
    (tmpvar_55 - 1.0)
   * 
    ((x_54 * x_54) * ((x_54 * x_54) * x_54))
  )));
  float tmpvar_57;
  tmpvar_57 = (((
    (2.0 * tmpvar_9)
   / 
    (((tmpvar_9 * (
      (tmpvar_47 * (1.0 - tmpvar_49))
     + tmpvar_49)) + (tmpvar_47 * (
      (tmpvar_9 * (1.0 - tmpvar_49))
     + tmpvar_49))) + 1e-05)
  ) * (tmpvar_51 / 
    ((3.141593 * tmpvar_52) * tmpvar_52)
  )) * 0.7853982);
  specularTerm_42 = tmpvar_57;
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    specularTerm_42 = sqrt(max (0.0001, tmpvar_57));
  };
  float tmpvar_58;
  tmpvar_58 = max (0.0, (specularTerm_42 * tmpvar_9));
  specularTerm_42 = tmpvar_58;
  float x_59;
  x_59 = (1.0 - tmpvar_48);
  float x_60;
  x_60 = (1.0 - tmpvar_47);
  vec3 tmpvar_61;
  tmpvar_61 = (((tmpvar_3 * 
    (tmpvar_13 + (_LightColor0.xyz * (tmpvar_56 * tmpvar_9)))
  ) + (
    (tmpvar_58 * _LightColor0.xyz)
   * 
    (tmpvar_4 + ((1.0 - tmpvar_4) * ((x_59 * x_59) * (
      (x_59 * x_59)
     * x_59))))
  )) + (tmpvar_12 * mix (tmpvar_4, vec3(
    clamp ((_Glossiness + (1.0 - tmpvar_5)), 0.0, 1.0)
  ), vec3(
    ((x_60 * x_60) * ((x_60 * x_60) * x_60))
  ))));
  vec4 tmpvar_62;
  tmpvar_62.w = 1.0;
  tmpvar_62.xyz = tmpvar_61;
  c_1.w = tmpvar_62.w;
  c_1.xyz = tmpvar_61;
  c_1.xyz = c_1.xyz;
  vec4 xlat_varoutput_63;
  xlat_varoutput_63.xyz = c_1.xyz;
  xlat_varoutput_63.w = 1.0;
  gl_FragData[0] = xlat_varoutput_63;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"#version 120

#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;
uniform vec4 unity_4LightPosX0;
uniform vec4 unity_4LightPosY0;
uniform vec4 unity_4LightPosZ0;
uniform vec4 unity_4LightAtten0;
uniform vec4 unity_LightColor[8];
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD8;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec3 tmpvar_7;
  vec4 tmpvar_8;
  tmpvar_8 = (_Object2World * gl_Vertex);
  tmpvar_7 = tmpvar_8.xyz;
  tmpvar_3 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_9;
  texcoord_9.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_10;
  if ((_UVSec == 0.0)) {
    tmpvar_10 = tmpvar_1;
  } else {
    tmpvar_10 = tmpvar_2;
  };
  texcoord_9.zw = ((tmpvar_10 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec3 n_11;
  n_11 = (tmpvar_8.xyz - _WorldSpaceCameraPos);
  vec4 v_12;
  v_12.x = _World2Object[0].x;
  v_12.y = _World2Object[1].x;
  v_12.z = _World2Object[2].x;
  v_12.w = _World2Object[3].x;
  vec4 v_13;
  v_13.x = _World2Object[0].y;
  v_13.y = _World2Object[1].y;
  v_13.z = _World2Object[2].y;
  v_13.w = _World2Object[3].y;
  vec4 v_14;
  v_14.x = _World2Object[0].z;
  v_14.y = _World2Object[1].z;
  v_14.z = _World2Object[2].z;
  v_14.w = _World2Object[3].z;
  vec3 tmpvar_15;
  tmpvar_15 = normalize(((
    (v_12.xyz * gl_Normal.x)
   + 
    (v_13.xyz * gl_Normal.y)
  ) + (v_14.xyz * gl_Normal.z)));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_15;
  vec4 o_16;
  vec4 tmpvar_17;
  tmpvar_17 = (tmpvar_3 * 0.5);
  vec2 tmpvar_18;
  tmpvar_18.x = tmpvar_17.x;
  tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
  o_16.xy = (tmpvar_18 + tmpvar_17.w);
  o_16.zw = tmpvar_3.zw;
  vec4 ambientOrLightmapUV_19;
  ambientOrLightmapUV_19.w = 0.0;
  vec3 col_20;
  vec4 ndotl_21;
  vec4 lengthSq_22;
  vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosX0 - tmpvar_8.x);
  vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosY0 - tmpvar_8.y);
  vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosZ0 - tmpvar_8.z);
  lengthSq_22 = (tmpvar_23 * tmpvar_23);
  lengthSq_22 = (lengthSq_22 + (tmpvar_24 * tmpvar_24));
  lengthSq_22 = (lengthSq_22 + (tmpvar_25 * tmpvar_25));
  ndotl_21 = (tmpvar_23 * tmpvar_15.x);
  ndotl_21 = (ndotl_21 + (tmpvar_24 * tmpvar_15.y));
  ndotl_21 = (ndotl_21 + (tmpvar_25 * tmpvar_15.z));
  vec4 tmpvar_26;
  tmpvar_26 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_21 * inversesqrt(lengthSq_22)));
  ndotl_21 = tmpvar_26;
  vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_26 * (1.0/((1.0 + 
    (lengthSq_22 * unity_4LightAtten0)
  ))));
  col_20 = (unity_LightColor[0].xyz * tmpvar_27.x);
  col_20 = (col_20 + (unity_LightColor[1].xyz * tmpvar_27.y));
  col_20 = (col_20 + (unity_LightColor[2].xyz * tmpvar_27.z));
  col_20 = (col_20 + (unity_LightColor[3].xyz * tmpvar_27.w));
  ambientOrLightmapUV_19.xyz = col_20;
  vec3 ambient_28;
  ambient_28 = ambientOrLightmapUV_19.xyz;
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    ambient_28 = (col_20 * ((col_20 * 
      ((col_20 * 0.305306) + 0.6821711)
    ) + 0.01252288));
  };
  vec3 x1_29;
  vec4 tmpvar_30;
  tmpvar_30 = (tmpvar_15.xyzz * tmpvar_15.yzzx);
  x1_29.x = dot (unity_SHBr, tmpvar_30);
  x1_29.y = dot (unity_SHBg, tmpvar_30);
  x1_29.z = dot (unity_SHBb, tmpvar_30);
  ambient_28 = (ambient_28 + (x1_29 + (unity_SHC.xyz * 
    ((tmpvar_15.x * tmpvar_15.x) - (tmpvar_15.y * tmpvar_15.y))
  )));
  ambientOrLightmapUV_19.xyz = ambient_28;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = texcoord_9;
  xlv_TEXCOORD1 = n_11;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = ambientOrLightmapUV_19;
  xlv_TEXCOORD6 = o_16;
  xlv_TEXCOORD8 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform samplerCube unity_SpecCube0;
uniform samplerCube unity_SpecCube1;
uniform vec4 unity_SpecCube0_BoxMax;
uniform vec4 unity_SpecCube0_BoxMin;
uniform vec4 unity_SpecCube0_ProbePosition;
uniform vec4 unity_SpecCube0_HDR;
uniform vec4 unity_SpecCube1_BoxMax;
uniform vec4 unity_SpecCube1_BoxMin;
uniform vec4 unity_SpecCube1_ProbePosition;
uniform vec4 unity_SpecCube1_HDR;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _LightColor0;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform float _OcclusionStrength;
uniform sampler2D _ShadowMapTexture;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD8;
void main ()
{
  vec4 c_1;
  vec3 tmpvar_2;
  tmpvar_2 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_3;
  vec3 tmpvar_4;
  tmpvar_4 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_2, vec3(_Metallic));
  float tmpvar_5;
  tmpvar_5 = (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w));
  tmpvar_3 = (tmpvar_2 * tmpvar_5);
  vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD2_2.xyz);
  vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD1);
  float tmpvar_8;
  tmpvar_8 = ((1.0 - _OcclusionStrength) + (texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y * _OcclusionStrength));
  float tmpvar_9;
  tmpvar_9 = max (0.0, dot (tmpvar_6, _WorldSpaceLightPos0.xyz));
  float tmpvar_10;
  tmpvar_10 = (1.0 - _Glossiness);
  vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_7 - (2.0 * (
    dot (tmpvar_6, tmpvar_7)
   * tmpvar_6)));
  vec3 tmpvar_12;
  vec3 tmpvar_13;
  vec3 tmpvar_14;
  tmpvar_14 = vec3(0.0, 0.0, 0.0);
  tmpvar_13 = (_LightColor0.xyz * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD6).x);
  vec3 ambient_15;
  vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_6;
  vec3 x_17;
  x_17.x = dot (unity_SHAr, tmpvar_16);
  x_17.y = dot (unity_SHAg, tmpvar_16);
  x_17.z = dot (unity_SHAb, tmpvar_16);
  ambient_15 = (xlv_TEXCOORD5.xyz + x_17);
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    ambient_15 = max (((1.055 * 
      pow (max (ambient_15, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
    ) - 0.055), vec3(0.0, 0.0, 0.0));
  };
  tmpvar_14 = (ambient_15 * tmpvar_8);
  tmpvar_12 = vec3(0.0, 0.0, 0.0);
  vec3 specular_18;
  vec3 worldRefl_19;
  worldRefl_19 = tmpvar_11;
  vec3 worldPos_20;
  worldPos_20 = xlv_TEXCOORD8;
  if ((unity_SpecCube0_ProbePosition.w > 0.0)) {
    vec3 tmpvar_21;
    tmpvar_21 = normalize(tmpvar_11);
    vec3 tmpvar_22;
    tmpvar_22 = ((unity_SpecCube0_BoxMax.xyz - xlv_TEXCOORD8) / tmpvar_21);
    vec3 tmpvar_23;
    tmpvar_23 = ((unity_SpecCube0_BoxMin.xyz - xlv_TEXCOORD8) / tmpvar_21);
    bvec3 tmpvar_24;
    tmpvar_24 = greaterThan (tmpvar_21, vec3(0.0, 0.0, 0.0));
    float tmpvar_25;
    if (tmpvar_24.x) {
      tmpvar_25 = tmpvar_22.x;
    } else {
      tmpvar_25 = tmpvar_23.x;
    };
    float tmpvar_26;
    if (tmpvar_24.y) {
      tmpvar_26 = tmpvar_22.y;
    } else {
      tmpvar_26 = tmpvar_23.y;
    };
    float tmpvar_27;
    if (tmpvar_24.z) {
      tmpvar_27 = tmpvar_22.z;
    } else {
      tmpvar_27 = tmpvar_23.z;
    };
    worldPos_20 = (xlv_TEXCOORD8 - unity_SpecCube0_ProbePosition.xyz);
    worldRefl_19 = (worldPos_20 + (tmpvar_21 * min (
      min (tmpvar_25, tmpvar_26)
    , tmpvar_27)));
  };
  vec4 tmpvar_28;
  tmpvar_28.xyz = worldRefl_19;
  tmpvar_28.w = ((tmpvar_10 * (1.7 - 
    (0.7 * tmpvar_10)
  )) * 6.0);
  vec4 tmpvar_29;
  tmpvar_29 = textureCubeLod (unity_SpecCube0, worldRefl_19, tmpvar_28.w);
  vec3 tmpvar_30;
  tmpvar_30 = ((unity_SpecCube0_HDR.x * pow (tmpvar_29.w, unity_SpecCube0_HDR.y)) * tmpvar_29.xyz);
  if ((unity_SpecCube0_BoxMin.w < 0.99999)) {
    vec3 worldRefl_31;
    worldRefl_31 = tmpvar_11;
    vec3 worldPos_32;
    worldPos_32 = xlv_TEXCOORD8;
    if ((unity_SpecCube1_ProbePosition.w > 0.0)) {
      vec3 tmpvar_33;
      tmpvar_33 = normalize(tmpvar_11);
      vec3 tmpvar_34;
      tmpvar_34 = ((unity_SpecCube1_BoxMax.xyz - xlv_TEXCOORD8) / tmpvar_33);
      vec3 tmpvar_35;
      tmpvar_35 = ((unity_SpecCube1_BoxMin.xyz - xlv_TEXCOORD8) / tmpvar_33);
      bvec3 tmpvar_36;
      tmpvar_36 = greaterThan (tmpvar_33, vec3(0.0, 0.0, 0.0));
      float tmpvar_37;
      if (tmpvar_36.x) {
        tmpvar_37 = tmpvar_34.x;
      } else {
        tmpvar_37 = tmpvar_35.x;
      };
      float tmpvar_38;
      if (tmpvar_36.y) {
        tmpvar_38 = tmpvar_34.y;
      } else {
        tmpvar_38 = tmpvar_35.y;
      };
      float tmpvar_39;
      if (tmpvar_36.z) {
        tmpvar_39 = tmpvar_34.z;
      } else {
        tmpvar_39 = tmpvar_35.z;
      };
      worldPos_32 = (xlv_TEXCOORD8 - unity_SpecCube1_ProbePosition.xyz);
      worldRefl_31 = (worldPos_32 + (tmpvar_33 * min (
        min (tmpvar_37, tmpvar_38)
      , tmpvar_39)));
    };
    vec4 tmpvar_40;
    tmpvar_40.xyz = worldRefl_31;
    tmpvar_40.w = ((tmpvar_10 * (1.7 - 
      (0.7 * tmpvar_10)
    )) * 6.0);
    vec4 tmpvar_41;
    tmpvar_41 = textureCubeLod (unity_SpecCube1, worldRefl_31, tmpvar_40.w);
    specular_18 = mix (((unity_SpecCube1_HDR.x * 
      pow (tmpvar_41.w, unity_SpecCube1_HDR.y)
    ) * tmpvar_41.xyz), tmpvar_30, unity_SpecCube0_BoxMin.www);
  } else {
    specular_18 = tmpvar_30;
  };
  tmpvar_12 = (specular_18 * tmpvar_8);
  vec3 viewDir_42;
  viewDir_42 = -(tmpvar_7);
  float specularTerm_43;
  float tmpvar_44;
  tmpvar_44 = (1.0 - _Glossiness);
  vec3 tmpvar_45;
  vec3 inVec_46;
  inVec_46 = (_WorldSpaceLightPos0.xyz + viewDir_42);
  tmpvar_45 = (inVec_46 * inversesqrt(max (0.001, 
    dot (inVec_46, inVec_46)
  )));
  float tmpvar_47;
  tmpvar_47 = max (0.0, dot (tmpvar_6, tmpvar_45));
  float tmpvar_48;
  tmpvar_48 = max (0.0, dot (tmpvar_6, viewDir_42));
  float tmpvar_49;
  tmpvar_49 = max (0.0, dot (_WorldSpaceLightPos0.xyz, tmpvar_45));
  float tmpvar_50;
  tmpvar_50 = (tmpvar_44 * tmpvar_44);
  float tmpvar_51;
  tmpvar_51 = (tmpvar_44 * tmpvar_44);
  float tmpvar_52;
  tmpvar_52 = (tmpvar_51 * tmpvar_51);
  float tmpvar_53;
  tmpvar_53 = (((tmpvar_47 * tmpvar_47) * (tmpvar_52 - 1.0)) + 1.0);
  float x_54;
  x_54 = (1.0 - tmpvar_9);
  float x_55;
  x_55 = (1.0 - tmpvar_48);
  float tmpvar_56;
  tmpvar_56 = (0.5 + ((2.0 * tmpvar_49) * (tmpvar_49 * tmpvar_44)));
  float tmpvar_57;
  tmpvar_57 = ((1.0 + (
    (tmpvar_56 - 1.0)
   * 
    ((x_54 * x_54) * ((x_54 * x_54) * x_54))
  )) * (1.0 + (
    (tmpvar_56 - 1.0)
   * 
    ((x_55 * x_55) * ((x_55 * x_55) * x_55))
  )));
  float tmpvar_58;
  tmpvar_58 = (((
    (2.0 * tmpvar_9)
   / 
    (((tmpvar_9 * (
      (tmpvar_48 * (1.0 - tmpvar_50))
     + tmpvar_50)) + (tmpvar_48 * (
      (tmpvar_9 * (1.0 - tmpvar_50))
     + tmpvar_50))) + 1e-05)
  ) * (tmpvar_52 / 
    ((3.141593 * tmpvar_53) * tmpvar_53)
  )) * 0.7853982);
  specularTerm_43 = tmpvar_58;
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    specularTerm_43 = sqrt(max (0.0001, tmpvar_58));
  };
  float tmpvar_59;
  tmpvar_59 = max (0.0, (specularTerm_43 * tmpvar_9));
  specularTerm_43 = tmpvar_59;
  float x_60;
  x_60 = (1.0 - tmpvar_49);
  float x_61;
  x_61 = (1.0 - tmpvar_48);
  vec3 tmpvar_62;
  tmpvar_62 = (((tmpvar_3 * 
    (tmpvar_14 + (tmpvar_13 * (tmpvar_57 * tmpvar_9)))
  ) + (
    (tmpvar_59 * tmpvar_13)
   * 
    (tmpvar_4 + ((1.0 - tmpvar_4) * ((x_60 * x_60) * (
      (x_60 * x_60)
     * x_60))))
  )) + (tmpvar_12 * mix (tmpvar_4, vec3(
    clamp ((_Glossiness + (1.0 - tmpvar_5)), 0.0, 1.0)
  ), vec3(
    ((x_61 * x_61) * ((x_61 * x_61) * x_61))
  ))));
  vec4 tmpvar_63;
  tmpvar_63.w = 1.0;
  tmpvar_63.xyz = tmpvar_62;
  c_1.w = tmpvar_63.w;
  c_1.xyz = tmpvar_62;
  c_1.xyz = c_1.xyz;
  vec4 xlat_varoutput_64;
  xlat_varoutput_64.xyz = c_1.xyz;
  xlat_varoutput_64.w = 1.0;
  gl_FragData[0] = xlat_varoutput_64;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "_EMISSION" }
"#version 120

#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD8;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec3 tmpvar_7;
  vec4 tmpvar_8;
  tmpvar_8 = (_Object2World * gl_Vertex);
  tmpvar_7 = tmpvar_8.xyz;
  tmpvar_3 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_9;
  texcoord_9.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_10;
  if ((_UVSec == 0.0)) {
    tmpvar_10 = tmpvar_1;
  } else {
    tmpvar_10 = tmpvar_2;
  };
  texcoord_9.zw = ((tmpvar_10 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec3 n_11;
  n_11 = (tmpvar_8.xyz - _WorldSpaceCameraPos);
  vec4 v_12;
  v_12.x = _World2Object[0].x;
  v_12.y = _World2Object[1].x;
  v_12.z = _World2Object[2].x;
  v_12.w = _World2Object[3].x;
  vec4 v_13;
  v_13.x = _World2Object[0].y;
  v_13.y = _World2Object[1].y;
  v_13.z = _World2Object[2].y;
  v_13.w = _World2Object[3].y;
  vec4 v_14;
  v_14.x = _World2Object[0].z;
  v_14.y = _World2Object[1].z;
  v_14.z = _World2Object[2].z;
  v_14.w = _World2Object[3].z;
  vec3 tmpvar_15;
  tmpvar_15 = normalize(((
    (v_12.xyz * gl_Normal.x)
   + 
    (v_13.xyz * gl_Normal.y)
  ) + (v_14.xyz * gl_Normal.z)));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_15;
  vec4 ambientOrLightmapUV_16;
  ambientOrLightmapUV_16 = vec4(0.0, 0.0, 0.0, 0.0);
  vec3 ambient_17;
  ambient_17 = vec3(0.0, 0.0, 0.0);
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    ambient_17 = vec3(0.0, 0.0, 0.0);
  };
  vec3 x1_18;
  vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_15.xyzz * tmpvar_15.yzzx);
  x1_18.x = dot (unity_SHBr, tmpvar_19);
  x1_18.y = dot (unity_SHBg, tmpvar_19);
  x1_18.z = dot (unity_SHBb, tmpvar_19);
  ambient_17 = (ambient_17 + (x1_18 + (unity_SHC.xyz * 
    ((tmpvar_15.x * tmpvar_15.x) - (tmpvar_15.y * tmpvar_15.y))
  )));
  ambientOrLightmapUV_16.xyz = ambient_17;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = texcoord_9;
  xlv_TEXCOORD1 = n_11;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = ambientOrLightmapUV_16;
  xlv_TEXCOORD8 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform samplerCube unity_SpecCube0;
uniform samplerCube unity_SpecCube1;
uniform vec4 unity_SpecCube0_BoxMax;
uniform vec4 unity_SpecCube0_BoxMin;
uniform vec4 unity_SpecCube0_ProbePosition;
uniform vec4 unity_SpecCube0_HDR;
uniform vec4 unity_SpecCube1_BoxMax;
uniform vec4 unity_SpecCube1_BoxMin;
uniform vec4 unity_SpecCube1_ProbePosition;
uniform vec4 unity_SpecCube1_HDR;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _LightColor0;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform float _OcclusionStrength;
uniform vec4 _EmissionColor;
uniform sampler2D _EmissionMap;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD8;
void main ()
{
  vec4 c_1;
  vec3 tmpvar_2;
  tmpvar_2 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_3;
  vec3 tmpvar_4;
  tmpvar_4 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_2, vec3(_Metallic));
  float tmpvar_5;
  tmpvar_5 = (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w));
  tmpvar_3 = (tmpvar_2 * tmpvar_5);
  vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD2_2.xyz);
  vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD1);
  float tmpvar_8;
  tmpvar_8 = ((1.0 - _OcclusionStrength) + (texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y * _OcclusionStrength));
  float tmpvar_9;
  tmpvar_9 = max (0.0, dot (tmpvar_6, _WorldSpaceLightPos0.xyz));
  float tmpvar_10;
  tmpvar_10 = (1.0 - _Glossiness);
  vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_7 - (2.0 * (
    dot (tmpvar_6, tmpvar_7)
   * tmpvar_6)));
  vec3 tmpvar_12;
  vec3 tmpvar_13;
  tmpvar_13 = vec3(0.0, 0.0, 0.0);
  vec3 ambient_14;
  vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_6;
  vec3 x_16;
  x_16.x = dot (unity_SHAr, tmpvar_15);
  x_16.y = dot (unity_SHAg, tmpvar_15);
  x_16.z = dot (unity_SHAb, tmpvar_15);
  ambient_14 = (xlv_TEXCOORD5.xyz + x_16);
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    ambient_14 = max (((1.055 * 
      pow (max (ambient_14, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
    ) - 0.055), vec3(0.0, 0.0, 0.0));
  };
  tmpvar_13 = (ambient_14 * tmpvar_8);
  tmpvar_12 = vec3(0.0, 0.0, 0.0);
  vec3 specular_17;
  vec3 worldRefl_18;
  worldRefl_18 = tmpvar_11;
  vec3 worldPos_19;
  worldPos_19 = xlv_TEXCOORD8;
  if ((unity_SpecCube0_ProbePosition.w > 0.0)) {
    vec3 tmpvar_20;
    tmpvar_20 = normalize(tmpvar_11);
    vec3 tmpvar_21;
    tmpvar_21 = ((unity_SpecCube0_BoxMax.xyz - xlv_TEXCOORD8) / tmpvar_20);
    vec3 tmpvar_22;
    tmpvar_22 = ((unity_SpecCube0_BoxMin.xyz - xlv_TEXCOORD8) / tmpvar_20);
    bvec3 tmpvar_23;
    tmpvar_23 = greaterThan (tmpvar_20, vec3(0.0, 0.0, 0.0));
    float tmpvar_24;
    if (tmpvar_23.x) {
      tmpvar_24 = tmpvar_21.x;
    } else {
      tmpvar_24 = tmpvar_22.x;
    };
    float tmpvar_25;
    if (tmpvar_23.y) {
      tmpvar_25 = tmpvar_21.y;
    } else {
      tmpvar_25 = tmpvar_22.y;
    };
    float tmpvar_26;
    if (tmpvar_23.z) {
      tmpvar_26 = tmpvar_21.z;
    } else {
      tmpvar_26 = tmpvar_22.z;
    };
    worldPos_19 = (xlv_TEXCOORD8 - unity_SpecCube0_ProbePosition.xyz);
    worldRefl_18 = (worldPos_19 + (tmpvar_20 * min (
      min (tmpvar_24, tmpvar_25)
    , tmpvar_26)));
  };
  vec4 tmpvar_27;
  tmpvar_27.xyz = worldRefl_18;
  tmpvar_27.w = ((tmpvar_10 * (1.7 - 
    (0.7 * tmpvar_10)
  )) * 6.0);
  vec4 tmpvar_28;
  tmpvar_28 = textureCubeLod (unity_SpecCube0, worldRefl_18, tmpvar_27.w);
  vec3 tmpvar_29;
  tmpvar_29 = ((unity_SpecCube0_HDR.x * pow (tmpvar_28.w, unity_SpecCube0_HDR.y)) * tmpvar_28.xyz);
  if ((unity_SpecCube0_BoxMin.w < 0.99999)) {
    vec3 worldRefl_30;
    worldRefl_30 = tmpvar_11;
    vec3 worldPos_31;
    worldPos_31 = xlv_TEXCOORD8;
    if ((unity_SpecCube1_ProbePosition.w > 0.0)) {
      vec3 tmpvar_32;
      tmpvar_32 = normalize(tmpvar_11);
      vec3 tmpvar_33;
      tmpvar_33 = ((unity_SpecCube1_BoxMax.xyz - xlv_TEXCOORD8) / tmpvar_32);
      vec3 tmpvar_34;
      tmpvar_34 = ((unity_SpecCube1_BoxMin.xyz - xlv_TEXCOORD8) / tmpvar_32);
      bvec3 tmpvar_35;
      tmpvar_35 = greaterThan (tmpvar_32, vec3(0.0, 0.0, 0.0));
      float tmpvar_36;
      if (tmpvar_35.x) {
        tmpvar_36 = tmpvar_33.x;
      } else {
        tmpvar_36 = tmpvar_34.x;
      };
      float tmpvar_37;
      if (tmpvar_35.y) {
        tmpvar_37 = tmpvar_33.y;
      } else {
        tmpvar_37 = tmpvar_34.y;
      };
      float tmpvar_38;
      if (tmpvar_35.z) {
        tmpvar_38 = tmpvar_33.z;
      } else {
        tmpvar_38 = tmpvar_34.z;
      };
      worldPos_31 = (xlv_TEXCOORD8 - unity_SpecCube1_ProbePosition.xyz);
      worldRefl_30 = (worldPos_31 + (tmpvar_32 * min (
        min (tmpvar_36, tmpvar_37)
      , tmpvar_38)));
    };
    vec4 tmpvar_39;
    tmpvar_39.xyz = worldRefl_30;
    tmpvar_39.w = ((tmpvar_10 * (1.7 - 
      (0.7 * tmpvar_10)
    )) * 6.0);
    vec4 tmpvar_40;
    tmpvar_40 = textureCubeLod (unity_SpecCube1, worldRefl_30, tmpvar_39.w);
    specular_17 = mix (((unity_SpecCube1_HDR.x * 
      pow (tmpvar_40.w, unity_SpecCube1_HDR.y)
    ) * tmpvar_40.xyz), tmpvar_29, unity_SpecCube0_BoxMin.www);
  } else {
    specular_17 = tmpvar_29;
  };
  tmpvar_12 = (specular_17 * tmpvar_8);
  vec3 viewDir_41;
  viewDir_41 = -(tmpvar_7);
  float specularTerm_42;
  float tmpvar_43;
  tmpvar_43 = (1.0 - _Glossiness);
  vec3 tmpvar_44;
  vec3 inVec_45;
  inVec_45 = (_WorldSpaceLightPos0.xyz + viewDir_41);
  tmpvar_44 = (inVec_45 * inversesqrt(max (0.001, 
    dot (inVec_45, inVec_45)
  )));
  float tmpvar_46;
  tmpvar_46 = max (0.0, dot (tmpvar_6, tmpvar_44));
  float tmpvar_47;
  tmpvar_47 = max (0.0, dot (tmpvar_6, viewDir_41));
  float tmpvar_48;
  tmpvar_48 = max (0.0, dot (_WorldSpaceLightPos0.xyz, tmpvar_44));
  float tmpvar_49;
  tmpvar_49 = (tmpvar_43 * tmpvar_43);
  float tmpvar_50;
  tmpvar_50 = (tmpvar_43 * tmpvar_43);
  float tmpvar_51;
  tmpvar_51 = (tmpvar_50 * tmpvar_50);
  float tmpvar_52;
  tmpvar_52 = (((tmpvar_46 * tmpvar_46) * (tmpvar_51 - 1.0)) + 1.0);
  float x_53;
  x_53 = (1.0 - tmpvar_9);
  float x_54;
  x_54 = (1.0 - tmpvar_47);
  float tmpvar_55;
  tmpvar_55 = (0.5 + ((2.0 * tmpvar_48) * (tmpvar_48 * tmpvar_43)));
  float tmpvar_56;
  tmpvar_56 = ((1.0 + (
    (tmpvar_55 - 1.0)
   * 
    ((x_53 * x_53) * ((x_53 * x_53) * x_53))
  )) * (1.0 + (
    (tmpvar_55 - 1.0)
   * 
    ((x_54 * x_54) * ((x_54 * x_54) * x_54))
  )));
  float tmpvar_57;
  tmpvar_57 = (((
    (2.0 * tmpvar_9)
   / 
    (((tmpvar_9 * (
      (tmpvar_47 * (1.0 - tmpvar_49))
     + tmpvar_49)) + (tmpvar_47 * (
      (tmpvar_9 * (1.0 - tmpvar_49))
     + tmpvar_49))) + 1e-05)
  ) * (tmpvar_51 / 
    ((3.141593 * tmpvar_52) * tmpvar_52)
  )) * 0.7853982);
  specularTerm_42 = tmpvar_57;
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    specularTerm_42 = sqrt(max (0.0001, tmpvar_57));
  };
  float tmpvar_58;
  tmpvar_58 = max (0.0, (specularTerm_42 * tmpvar_9));
  specularTerm_42 = tmpvar_58;
  float x_59;
  x_59 = (1.0 - tmpvar_48);
  float x_60;
  x_60 = (1.0 - tmpvar_47);
  vec3 tmpvar_61;
  tmpvar_61 = (((tmpvar_3 * 
    (tmpvar_13 + (_LightColor0.xyz * (tmpvar_56 * tmpvar_9)))
  ) + (
    (tmpvar_58 * _LightColor0.xyz)
   * 
    (tmpvar_4 + ((1.0 - tmpvar_4) * ((x_59 * x_59) * (
      (x_59 * x_59)
     * x_59))))
  )) + (tmpvar_12 * mix (tmpvar_4, vec3(
    clamp ((_Glossiness + (1.0 - tmpvar_5)), 0.0, 1.0)
  ), vec3(
    ((x_60 * x_60) * ((x_60 * x_60) * x_60))
  ))));
  vec4 tmpvar_62;
  tmpvar_62.w = 1.0;
  tmpvar_62.xyz = tmpvar_61;
  c_1.w = tmpvar_62.w;
  c_1.xyz = (tmpvar_61 + (texture2D (_EmissionMap, xlv_TEXCOORD0.xy).xyz * _EmissionColor.xyz));
  vec4 xlat_varoutput_63;
  xlat_varoutput_63.xyz = c_1.xyz;
  xlat_varoutput_63.w = 1.0;
  gl_FragData[0] = xlat_varoutput_63;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "_EMISSION" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "_EMISSION" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "_EMISSION" }
"#version 120

#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD8;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec3 tmpvar_7;
  vec4 tmpvar_8;
  tmpvar_8 = (_Object2World * gl_Vertex);
  tmpvar_7 = tmpvar_8.xyz;
  tmpvar_3 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_9;
  texcoord_9.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_10;
  if ((_UVSec == 0.0)) {
    tmpvar_10 = tmpvar_1;
  } else {
    tmpvar_10 = tmpvar_2;
  };
  texcoord_9.zw = ((tmpvar_10 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec3 n_11;
  n_11 = (tmpvar_8.xyz - _WorldSpaceCameraPos);
  vec4 v_12;
  v_12.x = _World2Object[0].x;
  v_12.y = _World2Object[1].x;
  v_12.z = _World2Object[2].x;
  v_12.w = _World2Object[3].x;
  vec4 v_13;
  v_13.x = _World2Object[0].y;
  v_13.y = _World2Object[1].y;
  v_13.z = _World2Object[2].y;
  v_13.w = _World2Object[3].y;
  vec4 v_14;
  v_14.x = _World2Object[0].z;
  v_14.y = _World2Object[1].z;
  v_14.z = _World2Object[2].z;
  v_14.w = _World2Object[3].z;
  vec3 tmpvar_15;
  tmpvar_15 = normalize(((
    (v_12.xyz * gl_Normal.x)
   + 
    (v_13.xyz * gl_Normal.y)
  ) + (v_14.xyz * gl_Normal.z)));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_15;
  vec4 o_16;
  vec4 tmpvar_17;
  tmpvar_17 = (tmpvar_3 * 0.5);
  vec2 tmpvar_18;
  tmpvar_18.x = tmpvar_17.x;
  tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
  o_16.xy = (tmpvar_18 + tmpvar_17.w);
  o_16.zw = tmpvar_3.zw;
  vec4 ambientOrLightmapUV_19;
  ambientOrLightmapUV_19 = vec4(0.0, 0.0, 0.0, 0.0);
  vec3 ambient_20;
  ambient_20 = vec3(0.0, 0.0, 0.0);
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    ambient_20 = vec3(0.0, 0.0, 0.0);
  };
  vec3 x1_21;
  vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_15.xyzz * tmpvar_15.yzzx);
  x1_21.x = dot (unity_SHBr, tmpvar_22);
  x1_21.y = dot (unity_SHBg, tmpvar_22);
  x1_21.z = dot (unity_SHBb, tmpvar_22);
  ambient_20 = (ambient_20 + (x1_21 + (unity_SHC.xyz * 
    ((tmpvar_15.x * tmpvar_15.x) - (tmpvar_15.y * tmpvar_15.y))
  )));
  ambientOrLightmapUV_19.xyz = ambient_20;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = texcoord_9;
  xlv_TEXCOORD1 = n_11;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = ambientOrLightmapUV_19;
  xlv_TEXCOORD6 = o_16;
  xlv_TEXCOORD8 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform samplerCube unity_SpecCube0;
uniform samplerCube unity_SpecCube1;
uniform vec4 unity_SpecCube0_BoxMax;
uniform vec4 unity_SpecCube0_BoxMin;
uniform vec4 unity_SpecCube0_ProbePosition;
uniform vec4 unity_SpecCube0_HDR;
uniform vec4 unity_SpecCube1_BoxMax;
uniform vec4 unity_SpecCube1_BoxMin;
uniform vec4 unity_SpecCube1_ProbePosition;
uniform vec4 unity_SpecCube1_HDR;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _LightColor0;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform float _OcclusionStrength;
uniform vec4 _EmissionColor;
uniform sampler2D _EmissionMap;
uniform sampler2D _ShadowMapTexture;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD8;
void main ()
{
  vec4 c_1;
  vec3 tmpvar_2;
  tmpvar_2 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_3;
  vec3 tmpvar_4;
  tmpvar_4 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_2, vec3(_Metallic));
  float tmpvar_5;
  tmpvar_5 = (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w));
  tmpvar_3 = (tmpvar_2 * tmpvar_5);
  vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD2_2.xyz);
  vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD1);
  float tmpvar_8;
  tmpvar_8 = ((1.0 - _OcclusionStrength) + (texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y * _OcclusionStrength));
  float tmpvar_9;
  tmpvar_9 = max (0.0, dot (tmpvar_6, _WorldSpaceLightPos0.xyz));
  float tmpvar_10;
  tmpvar_10 = (1.0 - _Glossiness);
  vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_7 - (2.0 * (
    dot (tmpvar_6, tmpvar_7)
   * tmpvar_6)));
  vec3 tmpvar_12;
  vec3 tmpvar_13;
  vec3 tmpvar_14;
  tmpvar_14 = vec3(0.0, 0.0, 0.0);
  tmpvar_13 = (_LightColor0.xyz * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD6).x);
  vec3 ambient_15;
  vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_6;
  vec3 x_17;
  x_17.x = dot (unity_SHAr, tmpvar_16);
  x_17.y = dot (unity_SHAg, tmpvar_16);
  x_17.z = dot (unity_SHAb, tmpvar_16);
  ambient_15 = (xlv_TEXCOORD5.xyz + x_17);
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    ambient_15 = max (((1.055 * 
      pow (max (ambient_15, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
    ) - 0.055), vec3(0.0, 0.0, 0.0));
  };
  tmpvar_14 = (ambient_15 * tmpvar_8);
  tmpvar_12 = vec3(0.0, 0.0, 0.0);
  vec3 specular_18;
  vec3 worldRefl_19;
  worldRefl_19 = tmpvar_11;
  vec3 worldPos_20;
  worldPos_20 = xlv_TEXCOORD8;
  if ((unity_SpecCube0_ProbePosition.w > 0.0)) {
    vec3 tmpvar_21;
    tmpvar_21 = normalize(tmpvar_11);
    vec3 tmpvar_22;
    tmpvar_22 = ((unity_SpecCube0_BoxMax.xyz - xlv_TEXCOORD8) / tmpvar_21);
    vec3 tmpvar_23;
    tmpvar_23 = ((unity_SpecCube0_BoxMin.xyz - xlv_TEXCOORD8) / tmpvar_21);
    bvec3 tmpvar_24;
    tmpvar_24 = greaterThan (tmpvar_21, vec3(0.0, 0.0, 0.0));
    float tmpvar_25;
    if (tmpvar_24.x) {
      tmpvar_25 = tmpvar_22.x;
    } else {
      tmpvar_25 = tmpvar_23.x;
    };
    float tmpvar_26;
    if (tmpvar_24.y) {
      tmpvar_26 = tmpvar_22.y;
    } else {
      tmpvar_26 = tmpvar_23.y;
    };
    float tmpvar_27;
    if (tmpvar_24.z) {
      tmpvar_27 = tmpvar_22.z;
    } else {
      tmpvar_27 = tmpvar_23.z;
    };
    worldPos_20 = (xlv_TEXCOORD8 - unity_SpecCube0_ProbePosition.xyz);
    worldRefl_19 = (worldPos_20 + (tmpvar_21 * min (
      min (tmpvar_25, tmpvar_26)
    , tmpvar_27)));
  };
  vec4 tmpvar_28;
  tmpvar_28.xyz = worldRefl_19;
  tmpvar_28.w = ((tmpvar_10 * (1.7 - 
    (0.7 * tmpvar_10)
  )) * 6.0);
  vec4 tmpvar_29;
  tmpvar_29 = textureCubeLod (unity_SpecCube0, worldRefl_19, tmpvar_28.w);
  vec3 tmpvar_30;
  tmpvar_30 = ((unity_SpecCube0_HDR.x * pow (tmpvar_29.w, unity_SpecCube0_HDR.y)) * tmpvar_29.xyz);
  if ((unity_SpecCube0_BoxMin.w < 0.99999)) {
    vec3 worldRefl_31;
    worldRefl_31 = tmpvar_11;
    vec3 worldPos_32;
    worldPos_32 = xlv_TEXCOORD8;
    if ((unity_SpecCube1_ProbePosition.w > 0.0)) {
      vec3 tmpvar_33;
      tmpvar_33 = normalize(tmpvar_11);
      vec3 tmpvar_34;
      tmpvar_34 = ((unity_SpecCube1_BoxMax.xyz - xlv_TEXCOORD8) / tmpvar_33);
      vec3 tmpvar_35;
      tmpvar_35 = ((unity_SpecCube1_BoxMin.xyz - xlv_TEXCOORD8) / tmpvar_33);
      bvec3 tmpvar_36;
      tmpvar_36 = greaterThan (tmpvar_33, vec3(0.0, 0.0, 0.0));
      float tmpvar_37;
      if (tmpvar_36.x) {
        tmpvar_37 = tmpvar_34.x;
      } else {
        tmpvar_37 = tmpvar_35.x;
      };
      float tmpvar_38;
      if (tmpvar_36.y) {
        tmpvar_38 = tmpvar_34.y;
      } else {
        tmpvar_38 = tmpvar_35.y;
      };
      float tmpvar_39;
      if (tmpvar_36.z) {
        tmpvar_39 = tmpvar_34.z;
      } else {
        tmpvar_39 = tmpvar_35.z;
      };
      worldPos_32 = (xlv_TEXCOORD8 - unity_SpecCube1_ProbePosition.xyz);
      worldRefl_31 = (worldPos_32 + (tmpvar_33 * min (
        min (tmpvar_37, tmpvar_38)
      , tmpvar_39)));
    };
    vec4 tmpvar_40;
    tmpvar_40.xyz = worldRefl_31;
    tmpvar_40.w = ((tmpvar_10 * (1.7 - 
      (0.7 * tmpvar_10)
    )) * 6.0);
    vec4 tmpvar_41;
    tmpvar_41 = textureCubeLod (unity_SpecCube1, worldRefl_31, tmpvar_40.w);
    specular_18 = mix (((unity_SpecCube1_HDR.x * 
      pow (tmpvar_41.w, unity_SpecCube1_HDR.y)
    ) * tmpvar_41.xyz), tmpvar_30, unity_SpecCube0_BoxMin.www);
  } else {
    specular_18 = tmpvar_30;
  };
  tmpvar_12 = (specular_18 * tmpvar_8);
  vec3 viewDir_42;
  viewDir_42 = -(tmpvar_7);
  float specularTerm_43;
  float tmpvar_44;
  tmpvar_44 = (1.0 - _Glossiness);
  vec3 tmpvar_45;
  vec3 inVec_46;
  inVec_46 = (_WorldSpaceLightPos0.xyz + viewDir_42);
  tmpvar_45 = (inVec_46 * inversesqrt(max (0.001, 
    dot (inVec_46, inVec_46)
  )));
  float tmpvar_47;
  tmpvar_47 = max (0.0, dot (tmpvar_6, tmpvar_45));
  float tmpvar_48;
  tmpvar_48 = max (0.0, dot (tmpvar_6, viewDir_42));
  float tmpvar_49;
  tmpvar_49 = max (0.0, dot (_WorldSpaceLightPos0.xyz, tmpvar_45));
  float tmpvar_50;
  tmpvar_50 = (tmpvar_44 * tmpvar_44);
  float tmpvar_51;
  tmpvar_51 = (tmpvar_44 * tmpvar_44);
  float tmpvar_52;
  tmpvar_52 = (tmpvar_51 * tmpvar_51);
  float tmpvar_53;
  tmpvar_53 = (((tmpvar_47 * tmpvar_47) * (tmpvar_52 - 1.0)) + 1.0);
  float x_54;
  x_54 = (1.0 - tmpvar_9);
  float x_55;
  x_55 = (1.0 - tmpvar_48);
  float tmpvar_56;
  tmpvar_56 = (0.5 + ((2.0 * tmpvar_49) * (tmpvar_49 * tmpvar_44)));
  float tmpvar_57;
  tmpvar_57 = ((1.0 + (
    (tmpvar_56 - 1.0)
   * 
    ((x_54 * x_54) * ((x_54 * x_54) * x_54))
  )) * (1.0 + (
    (tmpvar_56 - 1.0)
   * 
    ((x_55 * x_55) * ((x_55 * x_55) * x_55))
  )));
  float tmpvar_58;
  tmpvar_58 = (((
    (2.0 * tmpvar_9)
   / 
    (((tmpvar_9 * (
      (tmpvar_48 * (1.0 - tmpvar_50))
     + tmpvar_50)) + (tmpvar_48 * (
      (tmpvar_9 * (1.0 - tmpvar_50))
     + tmpvar_50))) + 1e-05)
  ) * (tmpvar_52 / 
    ((3.141593 * tmpvar_53) * tmpvar_53)
  )) * 0.7853982);
  specularTerm_43 = tmpvar_58;
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    specularTerm_43 = sqrt(max (0.0001, tmpvar_58));
  };
  float tmpvar_59;
  tmpvar_59 = max (0.0, (specularTerm_43 * tmpvar_9));
  specularTerm_43 = tmpvar_59;
  float x_60;
  x_60 = (1.0 - tmpvar_49);
  float x_61;
  x_61 = (1.0 - tmpvar_48);
  vec3 tmpvar_62;
  tmpvar_62 = (((tmpvar_3 * 
    (tmpvar_14 + (tmpvar_13 * (tmpvar_57 * tmpvar_9)))
  ) + (
    (tmpvar_59 * tmpvar_13)
   * 
    (tmpvar_4 + ((1.0 - tmpvar_4) * ((x_60 * x_60) * (
      (x_60 * x_60)
     * x_60))))
  )) + (tmpvar_12 * mix (tmpvar_4, vec3(
    clamp ((_Glossiness + (1.0 - tmpvar_5)), 0.0, 1.0)
  ), vec3(
    ((x_61 * x_61) * ((x_61 * x_61) * x_61))
  ))));
  vec4 tmpvar_63;
  tmpvar_63.w = 1.0;
  tmpvar_63.xyz = tmpvar_62;
  c_1.w = tmpvar_63.w;
  c_1.xyz = (tmpvar_62 + (texture2D (_EmissionMap, xlv_TEXCOORD0.xy).xyz * _EmissionColor.xyz));
  vec4 xlat_varoutput_64;
  xlat_varoutput_64.xyz = c_1.xyz;
  xlat_varoutput_64.w = 1.0;
  gl_FragData[0] = xlat_varoutput_64;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "_EMISSION" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "_EMISSION" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "_EMISSION" "VERTEXLIGHT_ON" }
"#version 120

#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 unity_4LightPosX0;
uniform vec4 unity_4LightPosY0;
uniform vec4 unity_4LightPosZ0;
uniform vec4 unity_4LightAtten0;
uniform vec4 unity_LightColor[8];
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD8;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec3 tmpvar_7;
  vec4 tmpvar_8;
  tmpvar_8 = (_Object2World * gl_Vertex);
  tmpvar_7 = tmpvar_8.xyz;
  tmpvar_3 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_9;
  texcoord_9.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_10;
  if ((_UVSec == 0.0)) {
    tmpvar_10 = tmpvar_1;
  } else {
    tmpvar_10 = tmpvar_2;
  };
  texcoord_9.zw = ((tmpvar_10 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec3 n_11;
  n_11 = (tmpvar_8.xyz - _WorldSpaceCameraPos);
  vec4 v_12;
  v_12.x = _World2Object[0].x;
  v_12.y = _World2Object[1].x;
  v_12.z = _World2Object[2].x;
  v_12.w = _World2Object[3].x;
  vec4 v_13;
  v_13.x = _World2Object[0].y;
  v_13.y = _World2Object[1].y;
  v_13.z = _World2Object[2].y;
  v_13.w = _World2Object[3].y;
  vec4 v_14;
  v_14.x = _World2Object[0].z;
  v_14.y = _World2Object[1].z;
  v_14.z = _World2Object[2].z;
  v_14.w = _World2Object[3].z;
  vec3 tmpvar_15;
  tmpvar_15 = normalize(((
    (v_12.xyz * gl_Normal.x)
   + 
    (v_13.xyz * gl_Normal.y)
  ) + (v_14.xyz * gl_Normal.z)));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_15;
  vec4 ambientOrLightmapUV_16;
  ambientOrLightmapUV_16.w = 0.0;
  vec3 col_17;
  vec4 ndotl_18;
  vec4 lengthSq_19;
  vec4 tmpvar_20;
  tmpvar_20 = (unity_4LightPosX0 - tmpvar_8.x);
  vec4 tmpvar_21;
  tmpvar_21 = (unity_4LightPosY0 - tmpvar_8.y);
  vec4 tmpvar_22;
  tmpvar_22 = (unity_4LightPosZ0 - tmpvar_8.z);
  lengthSq_19 = (tmpvar_20 * tmpvar_20);
  lengthSq_19 = (lengthSq_19 + (tmpvar_21 * tmpvar_21));
  lengthSq_19 = (lengthSq_19 + (tmpvar_22 * tmpvar_22));
  ndotl_18 = (tmpvar_20 * tmpvar_15.x);
  ndotl_18 = (ndotl_18 + (tmpvar_21 * tmpvar_15.y));
  ndotl_18 = (ndotl_18 + (tmpvar_22 * tmpvar_15.z));
  vec4 tmpvar_23;
  tmpvar_23 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_18 * inversesqrt(lengthSq_19)));
  ndotl_18 = tmpvar_23;
  vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_23 * (1.0/((1.0 + 
    (lengthSq_19 * unity_4LightAtten0)
  ))));
  col_17 = (unity_LightColor[0].xyz * tmpvar_24.x);
  col_17 = (col_17 + (unity_LightColor[1].xyz * tmpvar_24.y));
  col_17 = (col_17 + (unity_LightColor[2].xyz * tmpvar_24.z));
  col_17 = (col_17 + (unity_LightColor[3].xyz * tmpvar_24.w));
  ambientOrLightmapUV_16.xyz = col_17;
  vec3 ambient_25;
  ambient_25 = ambientOrLightmapUV_16.xyz;
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    ambient_25 = (col_17 * ((col_17 * 
      ((col_17 * 0.305306) + 0.6821711)
    ) + 0.01252288));
  };
  vec3 x1_26;
  vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_15.xyzz * tmpvar_15.yzzx);
  x1_26.x = dot (unity_SHBr, tmpvar_27);
  x1_26.y = dot (unity_SHBg, tmpvar_27);
  x1_26.z = dot (unity_SHBb, tmpvar_27);
  ambient_25 = (ambient_25 + (x1_26 + (unity_SHC.xyz * 
    ((tmpvar_15.x * tmpvar_15.x) - (tmpvar_15.y * tmpvar_15.y))
  )));
  ambientOrLightmapUV_16.xyz = ambient_25;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = texcoord_9;
  xlv_TEXCOORD1 = n_11;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = ambientOrLightmapUV_16;
  xlv_TEXCOORD8 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform samplerCube unity_SpecCube0;
uniform samplerCube unity_SpecCube1;
uniform vec4 unity_SpecCube0_BoxMax;
uniform vec4 unity_SpecCube0_BoxMin;
uniform vec4 unity_SpecCube0_ProbePosition;
uniform vec4 unity_SpecCube0_HDR;
uniform vec4 unity_SpecCube1_BoxMax;
uniform vec4 unity_SpecCube1_BoxMin;
uniform vec4 unity_SpecCube1_ProbePosition;
uniform vec4 unity_SpecCube1_HDR;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _LightColor0;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform float _OcclusionStrength;
uniform vec4 _EmissionColor;
uniform sampler2D _EmissionMap;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD8;
void main ()
{
  vec4 c_1;
  vec3 tmpvar_2;
  tmpvar_2 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_3;
  vec3 tmpvar_4;
  tmpvar_4 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_2, vec3(_Metallic));
  float tmpvar_5;
  tmpvar_5 = (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w));
  tmpvar_3 = (tmpvar_2 * tmpvar_5);
  vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD2_2.xyz);
  vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD1);
  float tmpvar_8;
  tmpvar_8 = ((1.0 - _OcclusionStrength) + (texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y * _OcclusionStrength));
  float tmpvar_9;
  tmpvar_9 = max (0.0, dot (tmpvar_6, _WorldSpaceLightPos0.xyz));
  float tmpvar_10;
  tmpvar_10 = (1.0 - _Glossiness);
  vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_7 - (2.0 * (
    dot (tmpvar_6, tmpvar_7)
   * tmpvar_6)));
  vec3 tmpvar_12;
  vec3 tmpvar_13;
  tmpvar_13 = vec3(0.0, 0.0, 0.0);
  vec3 ambient_14;
  vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_6;
  vec3 x_16;
  x_16.x = dot (unity_SHAr, tmpvar_15);
  x_16.y = dot (unity_SHAg, tmpvar_15);
  x_16.z = dot (unity_SHAb, tmpvar_15);
  ambient_14 = (xlv_TEXCOORD5.xyz + x_16);
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    ambient_14 = max (((1.055 * 
      pow (max (ambient_14, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
    ) - 0.055), vec3(0.0, 0.0, 0.0));
  };
  tmpvar_13 = (ambient_14 * tmpvar_8);
  tmpvar_12 = vec3(0.0, 0.0, 0.0);
  vec3 specular_17;
  vec3 worldRefl_18;
  worldRefl_18 = tmpvar_11;
  vec3 worldPos_19;
  worldPos_19 = xlv_TEXCOORD8;
  if ((unity_SpecCube0_ProbePosition.w > 0.0)) {
    vec3 tmpvar_20;
    tmpvar_20 = normalize(tmpvar_11);
    vec3 tmpvar_21;
    tmpvar_21 = ((unity_SpecCube0_BoxMax.xyz - xlv_TEXCOORD8) / tmpvar_20);
    vec3 tmpvar_22;
    tmpvar_22 = ((unity_SpecCube0_BoxMin.xyz - xlv_TEXCOORD8) / tmpvar_20);
    bvec3 tmpvar_23;
    tmpvar_23 = greaterThan (tmpvar_20, vec3(0.0, 0.0, 0.0));
    float tmpvar_24;
    if (tmpvar_23.x) {
      tmpvar_24 = tmpvar_21.x;
    } else {
      tmpvar_24 = tmpvar_22.x;
    };
    float tmpvar_25;
    if (tmpvar_23.y) {
      tmpvar_25 = tmpvar_21.y;
    } else {
      tmpvar_25 = tmpvar_22.y;
    };
    float tmpvar_26;
    if (tmpvar_23.z) {
      tmpvar_26 = tmpvar_21.z;
    } else {
      tmpvar_26 = tmpvar_22.z;
    };
    worldPos_19 = (xlv_TEXCOORD8 - unity_SpecCube0_ProbePosition.xyz);
    worldRefl_18 = (worldPos_19 + (tmpvar_20 * min (
      min (tmpvar_24, tmpvar_25)
    , tmpvar_26)));
  };
  vec4 tmpvar_27;
  tmpvar_27.xyz = worldRefl_18;
  tmpvar_27.w = ((tmpvar_10 * (1.7 - 
    (0.7 * tmpvar_10)
  )) * 6.0);
  vec4 tmpvar_28;
  tmpvar_28 = textureCubeLod (unity_SpecCube0, worldRefl_18, tmpvar_27.w);
  vec3 tmpvar_29;
  tmpvar_29 = ((unity_SpecCube0_HDR.x * pow (tmpvar_28.w, unity_SpecCube0_HDR.y)) * tmpvar_28.xyz);
  if ((unity_SpecCube0_BoxMin.w < 0.99999)) {
    vec3 worldRefl_30;
    worldRefl_30 = tmpvar_11;
    vec3 worldPos_31;
    worldPos_31 = xlv_TEXCOORD8;
    if ((unity_SpecCube1_ProbePosition.w > 0.0)) {
      vec3 tmpvar_32;
      tmpvar_32 = normalize(tmpvar_11);
      vec3 tmpvar_33;
      tmpvar_33 = ((unity_SpecCube1_BoxMax.xyz - xlv_TEXCOORD8) / tmpvar_32);
      vec3 tmpvar_34;
      tmpvar_34 = ((unity_SpecCube1_BoxMin.xyz - xlv_TEXCOORD8) / tmpvar_32);
      bvec3 tmpvar_35;
      tmpvar_35 = greaterThan (tmpvar_32, vec3(0.0, 0.0, 0.0));
      float tmpvar_36;
      if (tmpvar_35.x) {
        tmpvar_36 = tmpvar_33.x;
      } else {
        tmpvar_36 = tmpvar_34.x;
      };
      float tmpvar_37;
      if (tmpvar_35.y) {
        tmpvar_37 = tmpvar_33.y;
      } else {
        tmpvar_37 = tmpvar_34.y;
      };
      float tmpvar_38;
      if (tmpvar_35.z) {
        tmpvar_38 = tmpvar_33.z;
      } else {
        tmpvar_38 = tmpvar_34.z;
      };
      worldPos_31 = (xlv_TEXCOORD8 - unity_SpecCube1_ProbePosition.xyz);
      worldRefl_30 = (worldPos_31 + (tmpvar_32 * min (
        min (tmpvar_36, tmpvar_37)
      , tmpvar_38)));
    };
    vec4 tmpvar_39;
    tmpvar_39.xyz = worldRefl_30;
    tmpvar_39.w = ((tmpvar_10 * (1.7 - 
      (0.7 * tmpvar_10)
    )) * 6.0);
    vec4 tmpvar_40;
    tmpvar_40 = textureCubeLod (unity_SpecCube1, worldRefl_30, tmpvar_39.w);
    specular_17 = mix (((unity_SpecCube1_HDR.x * 
      pow (tmpvar_40.w, unity_SpecCube1_HDR.y)
    ) * tmpvar_40.xyz), tmpvar_29, unity_SpecCube0_BoxMin.www);
  } else {
    specular_17 = tmpvar_29;
  };
  tmpvar_12 = (specular_17 * tmpvar_8);
  vec3 viewDir_41;
  viewDir_41 = -(tmpvar_7);
  float specularTerm_42;
  float tmpvar_43;
  tmpvar_43 = (1.0 - _Glossiness);
  vec3 tmpvar_44;
  vec3 inVec_45;
  inVec_45 = (_WorldSpaceLightPos0.xyz + viewDir_41);
  tmpvar_44 = (inVec_45 * inversesqrt(max (0.001, 
    dot (inVec_45, inVec_45)
  )));
  float tmpvar_46;
  tmpvar_46 = max (0.0, dot (tmpvar_6, tmpvar_44));
  float tmpvar_47;
  tmpvar_47 = max (0.0, dot (tmpvar_6, viewDir_41));
  float tmpvar_48;
  tmpvar_48 = max (0.0, dot (_WorldSpaceLightPos0.xyz, tmpvar_44));
  float tmpvar_49;
  tmpvar_49 = (tmpvar_43 * tmpvar_43);
  float tmpvar_50;
  tmpvar_50 = (tmpvar_43 * tmpvar_43);
  float tmpvar_51;
  tmpvar_51 = (tmpvar_50 * tmpvar_50);
  float tmpvar_52;
  tmpvar_52 = (((tmpvar_46 * tmpvar_46) * (tmpvar_51 - 1.0)) + 1.0);
  float x_53;
  x_53 = (1.0 - tmpvar_9);
  float x_54;
  x_54 = (1.0 - tmpvar_47);
  float tmpvar_55;
  tmpvar_55 = (0.5 + ((2.0 * tmpvar_48) * (tmpvar_48 * tmpvar_43)));
  float tmpvar_56;
  tmpvar_56 = ((1.0 + (
    (tmpvar_55 - 1.0)
   * 
    ((x_53 * x_53) * ((x_53 * x_53) * x_53))
  )) * (1.0 + (
    (tmpvar_55 - 1.0)
   * 
    ((x_54 * x_54) * ((x_54 * x_54) * x_54))
  )));
  float tmpvar_57;
  tmpvar_57 = (((
    (2.0 * tmpvar_9)
   / 
    (((tmpvar_9 * (
      (tmpvar_47 * (1.0 - tmpvar_49))
     + tmpvar_49)) + (tmpvar_47 * (
      (tmpvar_9 * (1.0 - tmpvar_49))
     + tmpvar_49))) + 1e-05)
  ) * (tmpvar_51 / 
    ((3.141593 * tmpvar_52) * tmpvar_52)
  )) * 0.7853982);
  specularTerm_42 = tmpvar_57;
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    specularTerm_42 = sqrt(max (0.0001, tmpvar_57));
  };
  float tmpvar_58;
  tmpvar_58 = max (0.0, (specularTerm_42 * tmpvar_9));
  specularTerm_42 = tmpvar_58;
  float x_59;
  x_59 = (1.0 - tmpvar_48);
  float x_60;
  x_60 = (1.0 - tmpvar_47);
  vec3 tmpvar_61;
  tmpvar_61 = (((tmpvar_3 * 
    (tmpvar_13 + (_LightColor0.xyz * (tmpvar_56 * tmpvar_9)))
  ) + (
    (tmpvar_58 * _LightColor0.xyz)
   * 
    (tmpvar_4 + ((1.0 - tmpvar_4) * ((x_59 * x_59) * (
      (x_59 * x_59)
     * x_59))))
  )) + (tmpvar_12 * mix (tmpvar_4, vec3(
    clamp ((_Glossiness + (1.0 - tmpvar_5)), 0.0, 1.0)
  ), vec3(
    ((x_60 * x_60) * ((x_60 * x_60) * x_60))
  ))));
  vec4 tmpvar_62;
  tmpvar_62.w = 1.0;
  tmpvar_62.xyz = tmpvar_61;
  c_1.w = tmpvar_62.w;
  c_1.xyz = (tmpvar_61 + (texture2D (_EmissionMap, xlv_TEXCOORD0.xy).xyz * _EmissionColor.xyz));
  vec4 xlat_varoutput_63;
  xlat_varoutput_63.xyz = c_1.xyz;
  xlat_varoutput_63.w = 1.0;
  gl_FragData[0] = xlat_varoutput_63;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "_EMISSION" "VERTEXLIGHT_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "_EMISSION" "VERTEXLIGHT_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "_EMISSION" "VERTEXLIGHT_ON" }
"#version 120

#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;
uniform vec4 unity_4LightPosX0;
uniform vec4 unity_4LightPosY0;
uniform vec4 unity_4LightPosZ0;
uniform vec4 unity_4LightAtten0;
uniform vec4 unity_LightColor[8];
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD8;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec3 tmpvar_7;
  vec4 tmpvar_8;
  tmpvar_8 = (_Object2World * gl_Vertex);
  tmpvar_7 = tmpvar_8.xyz;
  tmpvar_3 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_9;
  texcoord_9.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_10;
  if ((_UVSec == 0.0)) {
    tmpvar_10 = tmpvar_1;
  } else {
    tmpvar_10 = tmpvar_2;
  };
  texcoord_9.zw = ((tmpvar_10 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec3 n_11;
  n_11 = (tmpvar_8.xyz - _WorldSpaceCameraPos);
  vec4 v_12;
  v_12.x = _World2Object[0].x;
  v_12.y = _World2Object[1].x;
  v_12.z = _World2Object[2].x;
  v_12.w = _World2Object[3].x;
  vec4 v_13;
  v_13.x = _World2Object[0].y;
  v_13.y = _World2Object[1].y;
  v_13.z = _World2Object[2].y;
  v_13.w = _World2Object[3].y;
  vec4 v_14;
  v_14.x = _World2Object[0].z;
  v_14.y = _World2Object[1].z;
  v_14.z = _World2Object[2].z;
  v_14.w = _World2Object[3].z;
  vec3 tmpvar_15;
  tmpvar_15 = normalize(((
    (v_12.xyz * gl_Normal.x)
   + 
    (v_13.xyz * gl_Normal.y)
  ) + (v_14.xyz * gl_Normal.z)));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_15;
  vec4 o_16;
  vec4 tmpvar_17;
  tmpvar_17 = (tmpvar_3 * 0.5);
  vec2 tmpvar_18;
  tmpvar_18.x = tmpvar_17.x;
  tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
  o_16.xy = (tmpvar_18 + tmpvar_17.w);
  o_16.zw = tmpvar_3.zw;
  vec4 ambientOrLightmapUV_19;
  ambientOrLightmapUV_19.w = 0.0;
  vec3 col_20;
  vec4 ndotl_21;
  vec4 lengthSq_22;
  vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosX0 - tmpvar_8.x);
  vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosY0 - tmpvar_8.y);
  vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosZ0 - tmpvar_8.z);
  lengthSq_22 = (tmpvar_23 * tmpvar_23);
  lengthSq_22 = (lengthSq_22 + (tmpvar_24 * tmpvar_24));
  lengthSq_22 = (lengthSq_22 + (tmpvar_25 * tmpvar_25));
  ndotl_21 = (tmpvar_23 * tmpvar_15.x);
  ndotl_21 = (ndotl_21 + (tmpvar_24 * tmpvar_15.y));
  ndotl_21 = (ndotl_21 + (tmpvar_25 * tmpvar_15.z));
  vec4 tmpvar_26;
  tmpvar_26 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_21 * inversesqrt(lengthSq_22)));
  ndotl_21 = tmpvar_26;
  vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_26 * (1.0/((1.0 + 
    (lengthSq_22 * unity_4LightAtten0)
  ))));
  col_20 = (unity_LightColor[0].xyz * tmpvar_27.x);
  col_20 = (col_20 + (unity_LightColor[1].xyz * tmpvar_27.y));
  col_20 = (col_20 + (unity_LightColor[2].xyz * tmpvar_27.z));
  col_20 = (col_20 + (unity_LightColor[3].xyz * tmpvar_27.w));
  ambientOrLightmapUV_19.xyz = col_20;
  vec3 ambient_28;
  ambient_28 = ambientOrLightmapUV_19.xyz;
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    ambient_28 = (col_20 * ((col_20 * 
      ((col_20 * 0.305306) + 0.6821711)
    ) + 0.01252288));
  };
  vec3 x1_29;
  vec4 tmpvar_30;
  tmpvar_30 = (tmpvar_15.xyzz * tmpvar_15.yzzx);
  x1_29.x = dot (unity_SHBr, tmpvar_30);
  x1_29.y = dot (unity_SHBg, tmpvar_30);
  x1_29.z = dot (unity_SHBb, tmpvar_30);
  ambient_28 = (ambient_28 + (x1_29 + (unity_SHC.xyz * 
    ((tmpvar_15.x * tmpvar_15.x) - (tmpvar_15.y * tmpvar_15.y))
  )));
  ambientOrLightmapUV_19.xyz = ambient_28;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = texcoord_9;
  xlv_TEXCOORD1 = n_11;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = ambientOrLightmapUV_19;
  xlv_TEXCOORD6 = o_16;
  xlv_TEXCOORD8 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform samplerCube unity_SpecCube0;
uniform samplerCube unity_SpecCube1;
uniform vec4 unity_SpecCube0_BoxMax;
uniform vec4 unity_SpecCube0_BoxMin;
uniform vec4 unity_SpecCube0_ProbePosition;
uniform vec4 unity_SpecCube0_HDR;
uniform vec4 unity_SpecCube1_BoxMax;
uniform vec4 unity_SpecCube1_BoxMin;
uniform vec4 unity_SpecCube1_ProbePosition;
uniform vec4 unity_SpecCube1_HDR;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _LightColor0;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform float _OcclusionStrength;
uniform vec4 _EmissionColor;
uniform sampler2D _EmissionMap;
uniform sampler2D _ShadowMapTexture;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD8;
void main ()
{
  vec4 c_1;
  vec3 tmpvar_2;
  tmpvar_2 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_3;
  vec3 tmpvar_4;
  tmpvar_4 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_2, vec3(_Metallic));
  float tmpvar_5;
  tmpvar_5 = (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w));
  tmpvar_3 = (tmpvar_2 * tmpvar_5);
  vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD2_2.xyz);
  vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD1);
  float tmpvar_8;
  tmpvar_8 = ((1.0 - _OcclusionStrength) + (texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y * _OcclusionStrength));
  float tmpvar_9;
  tmpvar_9 = max (0.0, dot (tmpvar_6, _WorldSpaceLightPos0.xyz));
  float tmpvar_10;
  tmpvar_10 = (1.0 - _Glossiness);
  vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_7 - (2.0 * (
    dot (tmpvar_6, tmpvar_7)
   * tmpvar_6)));
  vec3 tmpvar_12;
  vec3 tmpvar_13;
  vec3 tmpvar_14;
  tmpvar_14 = vec3(0.0, 0.0, 0.0);
  tmpvar_13 = (_LightColor0.xyz * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD6).x);
  vec3 ambient_15;
  vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_6;
  vec3 x_17;
  x_17.x = dot (unity_SHAr, tmpvar_16);
  x_17.y = dot (unity_SHAg, tmpvar_16);
  x_17.z = dot (unity_SHAb, tmpvar_16);
  ambient_15 = (xlv_TEXCOORD5.xyz + x_17);
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    ambient_15 = max (((1.055 * 
      pow (max (ambient_15, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
    ) - 0.055), vec3(0.0, 0.0, 0.0));
  };
  tmpvar_14 = (ambient_15 * tmpvar_8);
  tmpvar_12 = vec3(0.0, 0.0, 0.0);
  vec3 specular_18;
  vec3 worldRefl_19;
  worldRefl_19 = tmpvar_11;
  vec3 worldPos_20;
  worldPos_20 = xlv_TEXCOORD8;
  if ((unity_SpecCube0_ProbePosition.w > 0.0)) {
    vec3 tmpvar_21;
    tmpvar_21 = normalize(tmpvar_11);
    vec3 tmpvar_22;
    tmpvar_22 = ((unity_SpecCube0_BoxMax.xyz - xlv_TEXCOORD8) / tmpvar_21);
    vec3 tmpvar_23;
    tmpvar_23 = ((unity_SpecCube0_BoxMin.xyz - xlv_TEXCOORD8) / tmpvar_21);
    bvec3 tmpvar_24;
    tmpvar_24 = greaterThan (tmpvar_21, vec3(0.0, 0.0, 0.0));
    float tmpvar_25;
    if (tmpvar_24.x) {
      tmpvar_25 = tmpvar_22.x;
    } else {
      tmpvar_25 = tmpvar_23.x;
    };
    float tmpvar_26;
    if (tmpvar_24.y) {
      tmpvar_26 = tmpvar_22.y;
    } else {
      tmpvar_26 = tmpvar_23.y;
    };
    float tmpvar_27;
    if (tmpvar_24.z) {
      tmpvar_27 = tmpvar_22.z;
    } else {
      tmpvar_27 = tmpvar_23.z;
    };
    worldPos_20 = (xlv_TEXCOORD8 - unity_SpecCube0_ProbePosition.xyz);
    worldRefl_19 = (worldPos_20 + (tmpvar_21 * min (
      min (tmpvar_25, tmpvar_26)
    , tmpvar_27)));
  };
  vec4 tmpvar_28;
  tmpvar_28.xyz = worldRefl_19;
  tmpvar_28.w = ((tmpvar_10 * (1.7 - 
    (0.7 * tmpvar_10)
  )) * 6.0);
  vec4 tmpvar_29;
  tmpvar_29 = textureCubeLod (unity_SpecCube0, worldRefl_19, tmpvar_28.w);
  vec3 tmpvar_30;
  tmpvar_30 = ((unity_SpecCube0_HDR.x * pow (tmpvar_29.w, unity_SpecCube0_HDR.y)) * tmpvar_29.xyz);
  if ((unity_SpecCube0_BoxMin.w < 0.99999)) {
    vec3 worldRefl_31;
    worldRefl_31 = tmpvar_11;
    vec3 worldPos_32;
    worldPos_32 = xlv_TEXCOORD8;
    if ((unity_SpecCube1_ProbePosition.w > 0.0)) {
      vec3 tmpvar_33;
      tmpvar_33 = normalize(tmpvar_11);
      vec3 tmpvar_34;
      tmpvar_34 = ((unity_SpecCube1_BoxMax.xyz - xlv_TEXCOORD8) / tmpvar_33);
      vec3 tmpvar_35;
      tmpvar_35 = ((unity_SpecCube1_BoxMin.xyz - xlv_TEXCOORD8) / tmpvar_33);
      bvec3 tmpvar_36;
      tmpvar_36 = greaterThan (tmpvar_33, vec3(0.0, 0.0, 0.0));
      float tmpvar_37;
      if (tmpvar_36.x) {
        tmpvar_37 = tmpvar_34.x;
      } else {
        tmpvar_37 = tmpvar_35.x;
      };
      float tmpvar_38;
      if (tmpvar_36.y) {
        tmpvar_38 = tmpvar_34.y;
      } else {
        tmpvar_38 = tmpvar_35.y;
      };
      float tmpvar_39;
      if (tmpvar_36.z) {
        tmpvar_39 = tmpvar_34.z;
      } else {
        tmpvar_39 = tmpvar_35.z;
      };
      worldPos_32 = (xlv_TEXCOORD8 - unity_SpecCube1_ProbePosition.xyz);
      worldRefl_31 = (worldPos_32 + (tmpvar_33 * min (
        min (tmpvar_37, tmpvar_38)
      , tmpvar_39)));
    };
    vec4 tmpvar_40;
    tmpvar_40.xyz = worldRefl_31;
    tmpvar_40.w = ((tmpvar_10 * (1.7 - 
      (0.7 * tmpvar_10)
    )) * 6.0);
    vec4 tmpvar_41;
    tmpvar_41 = textureCubeLod (unity_SpecCube1, worldRefl_31, tmpvar_40.w);
    specular_18 = mix (((unity_SpecCube1_HDR.x * 
      pow (tmpvar_41.w, unity_SpecCube1_HDR.y)
    ) * tmpvar_41.xyz), tmpvar_30, unity_SpecCube0_BoxMin.www);
  } else {
    specular_18 = tmpvar_30;
  };
  tmpvar_12 = (specular_18 * tmpvar_8);
  vec3 viewDir_42;
  viewDir_42 = -(tmpvar_7);
  float specularTerm_43;
  float tmpvar_44;
  tmpvar_44 = (1.0 - _Glossiness);
  vec3 tmpvar_45;
  vec3 inVec_46;
  inVec_46 = (_WorldSpaceLightPos0.xyz + viewDir_42);
  tmpvar_45 = (inVec_46 * inversesqrt(max (0.001, 
    dot (inVec_46, inVec_46)
  )));
  float tmpvar_47;
  tmpvar_47 = max (0.0, dot (tmpvar_6, tmpvar_45));
  float tmpvar_48;
  tmpvar_48 = max (0.0, dot (tmpvar_6, viewDir_42));
  float tmpvar_49;
  tmpvar_49 = max (0.0, dot (_WorldSpaceLightPos0.xyz, tmpvar_45));
  float tmpvar_50;
  tmpvar_50 = (tmpvar_44 * tmpvar_44);
  float tmpvar_51;
  tmpvar_51 = (tmpvar_44 * tmpvar_44);
  float tmpvar_52;
  tmpvar_52 = (tmpvar_51 * tmpvar_51);
  float tmpvar_53;
  tmpvar_53 = (((tmpvar_47 * tmpvar_47) * (tmpvar_52 - 1.0)) + 1.0);
  float x_54;
  x_54 = (1.0 - tmpvar_9);
  float x_55;
  x_55 = (1.0 - tmpvar_48);
  float tmpvar_56;
  tmpvar_56 = (0.5 + ((2.0 * tmpvar_49) * (tmpvar_49 * tmpvar_44)));
  float tmpvar_57;
  tmpvar_57 = ((1.0 + (
    (tmpvar_56 - 1.0)
   * 
    ((x_54 * x_54) * ((x_54 * x_54) * x_54))
  )) * (1.0 + (
    (tmpvar_56 - 1.0)
   * 
    ((x_55 * x_55) * ((x_55 * x_55) * x_55))
  )));
  float tmpvar_58;
  tmpvar_58 = (((
    (2.0 * tmpvar_9)
   / 
    (((tmpvar_9 * (
      (tmpvar_48 * (1.0 - tmpvar_50))
     + tmpvar_50)) + (tmpvar_48 * (
      (tmpvar_9 * (1.0 - tmpvar_50))
     + tmpvar_50))) + 1e-05)
  ) * (tmpvar_52 / 
    ((3.141593 * tmpvar_53) * tmpvar_53)
  )) * 0.7853982);
  specularTerm_43 = tmpvar_58;
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    specularTerm_43 = sqrt(max (0.0001, tmpvar_58));
  };
  float tmpvar_59;
  tmpvar_59 = max (0.0, (specularTerm_43 * tmpvar_9));
  specularTerm_43 = tmpvar_59;
  float x_60;
  x_60 = (1.0 - tmpvar_49);
  float x_61;
  x_61 = (1.0 - tmpvar_48);
  vec3 tmpvar_62;
  tmpvar_62 = (((tmpvar_3 * 
    (tmpvar_14 + (tmpvar_13 * (tmpvar_57 * tmpvar_9)))
  ) + (
    (tmpvar_59 * tmpvar_13)
   * 
    (tmpvar_4 + ((1.0 - tmpvar_4) * ((x_60 * x_60) * (
      (x_60 * x_60)
     * x_60))))
  )) + (tmpvar_12 * mix (tmpvar_4, vec3(
    clamp ((_Glossiness + (1.0 - tmpvar_5)), 0.0, 1.0)
  ), vec3(
    ((x_61 * x_61) * ((x_61 * x_61) * x_61))
  ))));
  vec4 tmpvar_63;
  tmpvar_63.w = 1.0;
  tmpvar_63.xyz = tmpvar_62;
  c_1.w = tmpvar_63.w;
  c_1.xyz = (tmpvar_62 + (texture2D (_EmissionMap, xlv_TEXCOORD0.xy).xyz * _EmissionColor.xyz));
  vec4 xlat_varoutput_64;
  xlat_varoutput_64.xyz = c_1.xyz;
  xlat_varoutput_64.w = 1.0;
  gl_FragData[0] = xlat_varoutput_64;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "_EMISSION" "VERTEXLIGHT_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "_EMISSION" "VERTEXLIGHT_ON" }
"// shader disassembly not supported on DXBC"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "_EMISSION" }
""
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "_EMISSION" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "_EMISSION" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "_EMISSION" }
""
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "_EMISSION" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "_EMISSION" }
"// shader disassembly not supported on DXBC"
}
}
 }
 Pass {
  Name "FORWARD_DELTA"
  Tags { "LIGHTMODE"="ForwardAdd" "SHADOWSUPPORT"="true" "RenderType"="Opaque" "PerformanceChecks"="False" }
  ZWrite Off
  Blend [_SrcBlend] One
  GpuProgramID 129312
Program "vp" {
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_OFF" }
"#version 120

#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_WorldTransformParams;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
uniform mat4 _LightMatrix0;
attribute vec4 TANGENT;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec4 tmpvar_7;
  tmpvar_7 = (_Object2World * gl_Vertex);
  tmpvar_3 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_8;
  texcoord_8.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_9;
  if ((_UVSec == 0.0)) {
    tmpvar_9 = tmpvar_1;
  } else {
    tmpvar_9 = tmpvar_2;
  };
  texcoord_8.zw = ((tmpvar_9 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec4 v_10;
  v_10.x = _World2Object[0].x;
  v_10.y = _World2Object[1].x;
  v_10.z = _World2Object[2].x;
  v_10.w = _World2Object[3].x;
  vec4 v_11;
  v_11.x = _World2Object[0].y;
  v_11.y = _World2Object[1].y;
  v_11.z = _World2Object[2].y;
  v_11.w = _World2Object[3].y;
  vec4 v_12;
  v_12.x = _World2Object[0].z;
  v_12.y = _World2Object[1].z;
  v_12.z = _World2Object[2].z;
  v_12.w = _World2Object[3].z;
  vec3 tmpvar_13;
  tmpvar_13 = normalize(((
    (v_10.xyz * gl_Normal.x)
   + 
    (v_11.xyz * gl_Normal.y)
  ) + (v_12.xyz * gl_Normal.z)));
  mat3 tmpvar_14;
  tmpvar_14[0] = _Object2World[0].xyz;
  tmpvar_14[1] = _Object2World[1].xyz;
  tmpvar_14[2] = _Object2World[2].xyz;
  vec4 tmpvar_15;
  tmpvar_15.xyz = normalize((tmpvar_14 * TANGENT.xyz));
  tmpvar_15.w = TANGENT.w;
  vec3 tmpvar_16;
  vec3 tmpvar_17;
  tmpvar_16 = tmpvar_15.xyz;
  tmpvar_17 = (((tmpvar_13.yzx * tmpvar_15.zxy) - (tmpvar_13.zxy * tmpvar_15.yzx)) * (TANGENT.w * unity_WorldTransformParams.w));
  vec3 tmpvar_18;
  vec3 tmpvar_19;
  vec3 tmpvar_20;
  tmpvar_18.x = tmpvar_16.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = tmpvar_13.x;
  tmpvar_19.x = tmpvar_16.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = tmpvar_13.y;
  tmpvar_20.x = tmpvar_16.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = tmpvar_13.z;
  vec3 v_21;
  v_21.x = tmpvar_18.x;
  v_21.y = tmpvar_19.x;
  v_21.z = tmpvar_20.x;
  tmpvar_4.xyz = v_21;
  vec3 v_22;
  v_22.x = tmpvar_18.y;
  v_22.y = tmpvar_19.y;
  v_22.z = tmpvar_20.y;
  tmpvar_5.xyz = v_22;
  vec3 v_23;
  v_23.x = tmpvar_18.z;
  v_23.y = tmpvar_19.z;
  v_23.z = tmpvar_20.z;
  tmpvar_6.xyz = v_23;
  vec3 tmpvar_24;
  tmpvar_24 = (_WorldSpaceLightPos0.xyz - (tmpvar_7.xyz * _WorldSpaceLightPos0.w));
  tmpvar_4.w = tmpvar_24.x;
  tmpvar_5.w = tmpvar_24.y;
  tmpvar_6.w = tmpvar_24.z;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = texcoord_8;
  xlv_TEXCOORD1 = (tmpvar_7.xyz - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xyz;
}


#endif
#ifdef FRAGMENT
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _LightColor0;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform sampler2D _LightTexture0;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_2;
  vec3 tmpvar_3;
  tmpvar_3 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_1, vec3(_Metallic));
  tmpvar_2 = (tmpvar_1 * (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w)));
  vec3 tmpvar_4;
  tmpvar_4 = normalize(xlv_TEXCOORD2_2.xyz);
  vec3 tmpvar_5;
  tmpvar_5.x = xlv_TEXCOORD2.w;
  tmpvar_5.y = xlv_TEXCOORD2_1.w;
  tmpvar_5.z = xlv_TEXCOORD2_2.w;
  vec3 tmpvar_6;
  vec3 tmpvar_7;
  tmpvar_7 = normalize(tmpvar_5);
  float tmpvar_8;
  tmpvar_8 = max (0.0, dot (tmpvar_4, tmpvar_7));
  tmpvar_6 = (_LightColor0.xyz * texture2D (_LightTexture0, vec2(dot (xlv_TEXCOORD5, xlv_TEXCOORD5))).w);
  vec3 viewDir_9;
  viewDir_9 = -(normalize(xlv_TEXCOORD1));
  float specularTerm_10;
  float tmpvar_11;
  tmpvar_11 = (1.0 - _Glossiness);
  vec3 tmpvar_12;
  vec3 inVec_13;
  inVec_13 = (tmpvar_7 + viewDir_9);
  tmpvar_12 = (inVec_13 * inversesqrt(max (0.001, 
    dot (inVec_13, inVec_13)
  )));
  float tmpvar_14;
  tmpvar_14 = max (0.0, dot (tmpvar_4, tmpvar_12));
  float tmpvar_15;
  tmpvar_15 = max (0.0, dot (tmpvar_4, viewDir_9));
  float tmpvar_16;
  tmpvar_16 = max (0.0, dot (tmpvar_7, tmpvar_12));
  float tmpvar_17;
  tmpvar_17 = (tmpvar_11 * tmpvar_11);
  float tmpvar_18;
  tmpvar_18 = (tmpvar_11 * tmpvar_11);
  float tmpvar_19;
  tmpvar_19 = (tmpvar_18 * tmpvar_18);
  float tmpvar_20;
  tmpvar_20 = (((tmpvar_14 * tmpvar_14) * (tmpvar_19 - 1.0)) + 1.0);
  float x_21;
  x_21 = (1.0 - tmpvar_8);
  float x_22;
  x_22 = (1.0 - tmpvar_15);
  float tmpvar_23;
  tmpvar_23 = (0.5 + ((2.0 * tmpvar_16) * (tmpvar_16 * tmpvar_11)));
  float tmpvar_24;
  tmpvar_24 = ((1.0 + (
    (tmpvar_23 - 1.0)
   * 
    ((x_21 * x_21) * ((x_21 * x_21) * x_21))
  )) * (1.0 + (
    (tmpvar_23 - 1.0)
   * 
    ((x_22 * x_22) * ((x_22 * x_22) * x_22))
  )));
  float tmpvar_25;
  tmpvar_25 = (((
    (2.0 * tmpvar_8)
   / 
    (((tmpvar_8 * (
      (tmpvar_15 * (1.0 - tmpvar_17))
     + tmpvar_17)) + (tmpvar_15 * (
      (tmpvar_8 * (1.0 - tmpvar_17))
     + tmpvar_17))) + 1e-05)
  ) * (tmpvar_19 / 
    ((3.141593 * tmpvar_20) * tmpvar_20)
  )) * 0.7853982);
  specularTerm_10 = tmpvar_25;
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    specularTerm_10 = sqrt(max (0.0001, tmpvar_25));
  };
  float tmpvar_26;
  tmpvar_26 = max (0.0, (specularTerm_10 * tmpvar_8));
  specularTerm_10 = tmpvar_26;
  float x_27;
  x_27 = (1.0 - tmpvar_16);
  vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xyz = ((tmpvar_2 * (tmpvar_6 * 
    (tmpvar_24 * tmpvar_8)
  )) + ((tmpvar_26 * tmpvar_6) * (tmpvar_3 + 
    ((1.0 - tmpvar_3) * ((x_27 * x_27) * ((x_27 * x_27) * x_27)))
  )));
  vec4 xlat_varoutput_29;
  xlat_varoutput_29.xyz = tmpvar_28.xyz;
  xlat_varoutput_29.w = 1.0;
  gl_FragData[0] = xlat_varoutput_29;
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
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_WorldTransformParams;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
attribute vec4 TANGENT;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec4 tmpvar_7;
  tmpvar_7 = (_Object2World * gl_Vertex);
  tmpvar_3 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_8;
  texcoord_8.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_9;
  if ((_UVSec == 0.0)) {
    tmpvar_9 = tmpvar_1;
  } else {
    tmpvar_9 = tmpvar_2;
  };
  texcoord_8.zw = ((tmpvar_9 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec4 v_10;
  v_10.x = _World2Object[0].x;
  v_10.y = _World2Object[1].x;
  v_10.z = _World2Object[2].x;
  v_10.w = _World2Object[3].x;
  vec4 v_11;
  v_11.x = _World2Object[0].y;
  v_11.y = _World2Object[1].y;
  v_11.z = _World2Object[2].y;
  v_11.w = _World2Object[3].y;
  vec4 v_12;
  v_12.x = _World2Object[0].z;
  v_12.y = _World2Object[1].z;
  v_12.z = _World2Object[2].z;
  v_12.w = _World2Object[3].z;
  vec3 tmpvar_13;
  tmpvar_13 = normalize(((
    (v_10.xyz * gl_Normal.x)
   + 
    (v_11.xyz * gl_Normal.y)
  ) + (v_12.xyz * gl_Normal.z)));
  mat3 tmpvar_14;
  tmpvar_14[0] = _Object2World[0].xyz;
  tmpvar_14[1] = _Object2World[1].xyz;
  tmpvar_14[2] = _Object2World[2].xyz;
  vec4 tmpvar_15;
  tmpvar_15.xyz = normalize((tmpvar_14 * TANGENT.xyz));
  tmpvar_15.w = TANGENT.w;
  vec3 tmpvar_16;
  vec3 tmpvar_17;
  tmpvar_16 = tmpvar_15.xyz;
  tmpvar_17 = (((tmpvar_13.yzx * tmpvar_15.zxy) - (tmpvar_13.zxy * tmpvar_15.yzx)) * (TANGENT.w * unity_WorldTransformParams.w));
  vec3 tmpvar_18;
  vec3 tmpvar_19;
  vec3 tmpvar_20;
  tmpvar_18.x = tmpvar_16.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = tmpvar_13.x;
  tmpvar_19.x = tmpvar_16.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = tmpvar_13.y;
  tmpvar_20.x = tmpvar_16.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = tmpvar_13.z;
  vec3 v_21;
  v_21.x = tmpvar_18.x;
  v_21.y = tmpvar_19.x;
  v_21.z = tmpvar_20.x;
  tmpvar_4.xyz = v_21;
  vec3 v_22;
  v_22.x = tmpvar_18.y;
  v_22.y = tmpvar_19.y;
  v_22.z = tmpvar_20.y;
  tmpvar_5.xyz = v_22;
  vec3 v_23;
  v_23.x = tmpvar_18.z;
  v_23.y = tmpvar_19.z;
  v_23.z = tmpvar_20.z;
  tmpvar_6.xyz = v_23;
  vec3 tmpvar_24;
  tmpvar_24 = (_WorldSpaceLightPos0.xyz - (tmpvar_7.xyz * _WorldSpaceLightPos0.w));
  tmpvar_4.w = tmpvar_24.x;
  tmpvar_5.w = tmpvar_24.y;
  tmpvar_6.w = tmpvar_24.z;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = texcoord_8;
  xlv_TEXCOORD1 = (tmpvar_7.xyz - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _LightColor0;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_2;
  vec3 tmpvar_3;
  tmpvar_3 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_1, vec3(_Metallic));
  tmpvar_2 = (tmpvar_1 * (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w)));
  vec3 tmpvar_4;
  tmpvar_4 = normalize(xlv_TEXCOORD2_2.xyz);
  vec3 tmpvar_5;
  tmpvar_5.x = xlv_TEXCOORD2.w;
  tmpvar_5.y = xlv_TEXCOORD2_1.w;
  tmpvar_5.z = xlv_TEXCOORD2_2.w;
  float tmpvar_6;
  tmpvar_6 = max (0.0, dot (tmpvar_4, tmpvar_5));
  vec3 viewDir_7;
  viewDir_7 = -(normalize(xlv_TEXCOORD1));
  float specularTerm_8;
  float tmpvar_9;
  tmpvar_9 = (1.0 - _Glossiness);
  vec3 tmpvar_10;
  vec3 inVec_11;
  inVec_11 = (tmpvar_5 + viewDir_7);
  tmpvar_10 = (inVec_11 * inversesqrt(max (0.001, 
    dot (inVec_11, inVec_11)
  )));
  float tmpvar_12;
  tmpvar_12 = max (0.0, dot (tmpvar_4, tmpvar_10));
  float tmpvar_13;
  tmpvar_13 = max (0.0, dot (tmpvar_4, viewDir_7));
  float tmpvar_14;
  tmpvar_14 = max (0.0, dot (tmpvar_5, tmpvar_10));
  float tmpvar_15;
  tmpvar_15 = (tmpvar_9 * tmpvar_9);
  float tmpvar_16;
  tmpvar_16 = (tmpvar_9 * tmpvar_9);
  float tmpvar_17;
  tmpvar_17 = (tmpvar_16 * tmpvar_16);
  float tmpvar_18;
  tmpvar_18 = (((tmpvar_12 * tmpvar_12) * (tmpvar_17 - 1.0)) + 1.0);
  float x_19;
  x_19 = (1.0 - tmpvar_6);
  float x_20;
  x_20 = (1.0 - tmpvar_13);
  float tmpvar_21;
  tmpvar_21 = (0.5 + ((2.0 * tmpvar_14) * (tmpvar_14 * tmpvar_9)));
  float tmpvar_22;
  tmpvar_22 = ((1.0 + (
    (tmpvar_21 - 1.0)
   * 
    ((x_19 * x_19) * ((x_19 * x_19) * x_19))
  )) * (1.0 + (
    (tmpvar_21 - 1.0)
   * 
    ((x_20 * x_20) * ((x_20 * x_20) * x_20))
  )));
  float tmpvar_23;
  tmpvar_23 = (((
    (2.0 * tmpvar_6)
   / 
    (((tmpvar_6 * (
      (tmpvar_13 * (1.0 - tmpvar_15))
     + tmpvar_15)) + (tmpvar_13 * (
      (tmpvar_6 * (1.0 - tmpvar_15))
     + tmpvar_15))) + 1e-05)
  ) * (tmpvar_17 / 
    ((3.141593 * tmpvar_18) * tmpvar_18)
  )) * 0.7853982);
  specularTerm_8 = tmpvar_23;
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    specularTerm_8 = sqrt(max (0.0001, tmpvar_23));
  };
  float tmpvar_24;
  tmpvar_24 = max (0.0, (specularTerm_8 * tmpvar_6));
  specularTerm_8 = tmpvar_24;
  float x_25;
  x_25 = (1.0 - tmpvar_14);
  vec4 tmpvar_26;
  tmpvar_26.w = 1.0;
  tmpvar_26.xyz = ((tmpvar_2 * (_LightColor0.xyz * 
    (tmpvar_22 * tmpvar_6)
  )) + ((tmpvar_24 * _LightColor0.xyz) * (tmpvar_3 + 
    ((1.0 - tmpvar_3) * ((x_25 * x_25) * ((x_25 * x_25) * x_25)))
  )));
  vec4 xlat_varoutput_27;
  xlat_varoutput_27.xyz = tmpvar_26.xyz;
  xlat_varoutput_27.w = 1.0;
  gl_FragData[0] = xlat_varoutput_27;
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
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_WorldTransformParams;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
uniform mat4 _LightMatrix0;
attribute vec4 TANGENT;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec4 tmpvar_7;
  tmpvar_7 = (_Object2World * gl_Vertex);
  tmpvar_3 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_8;
  texcoord_8.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_9;
  if ((_UVSec == 0.0)) {
    tmpvar_9 = tmpvar_1;
  } else {
    tmpvar_9 = tmpvar_2;
  };
  texcoord_8.zw = ((tmpvar_9 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec4 v_10;
  v_10.x = _World2Object[0].x;
  v_10.y = _World2Object[1].x;
  v_10.z = _World2Object[2].x;
  v_10.w = _World2Object[3].x;
  vec4 v_11;
  v_11.x = _World2Object[0].y;
  v_11.y = _World2Object[1].y;
  v_11.z = _World2Object[2].y;
  v_11.w = _World2Object[3].y;
  vec4 v_12;
  v_12.x = _World2Object[0].z;
  v_12.y = _World2Object[1].z;
  v_12.z = _World2Object[2].z;
  v_12.w = _World2Object[3].z;
  vec3 tmpvar_13;
  tmpvar_13 = normalize(((
    (v_10.xyz * gl_Normal.x)
   + 
    (v_11.xyz * gl_Normal.y)
  ) + (v_12.xyz * gl_Normal.z)));
  mat3 tmpvar_14;
  tmpvar_14[0] = _Object2World[0].xyz;
  tmpvar_14[1] = _Object2World[1].xyz;
  tmpvar_14[2] = _Object2World[2].xyz;
  vec4 tmpvar_15;
  tmpvar_15.xyz = normalize((tmpvar_14 * TANGENT.xyz));
  tmpvar_15.w = TANGENT.w;
  vec3 tmpvar_16;
  vec3 tmpvar_17;
  tmpvar_16 = tmpvar_15.xyz;
  tmpvar_17 = (((tmpvar_13.yzx * tmpvar_15.zxy) - (tmpvar_13.zxy * tmpvar_15.yzx)) * (TANGENT.w * unity_WorldTransformParams.w));
  vec3 tmpvar_18;
  vec3 tmpvar_19;
  vec3 tmpvar_20;
  tmpvar_18.x = tmpvar_16.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = tmpvar_13.x;
  tmpvar_19.x = tmpvar_16.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = tmpvar_13.y;
  tmpvar_20.x = tmpvar_16.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = tmpvar_13.z;
  vec3 v_21;
  v_21.x = tmpvar_18.x;
  v_21.y = tmpvar_19.x;
  v_21.z = tmpvar_20.x;
  tmpvar_4.xyz = v_21;
  vec3 v_22;
  v_22.x = tmpvar_18.y;
  v_22.y = tmpvar_19.y;
  v_22.z = tmpvar_20.y;
  tmpvar_5.xyz = v_22;
  vec3 v_23;
  v_23.x = tmpvar_18.z;
  v_23.y = tmpvar_19.z;
  v_23.z = tmpvar_20.z;
  tmpvar_6.xyz = v_23;
  vec3 tmpvar_24;
  tmpvar_24 = (_WorldSpaceLightPos0.xyz - (tmpvar_7.xyz * _WorldSpaceLightPos0.w));
  tmpvar_4.w = tmpvar_24.x;
  tmpvar_5.w = tmpvar_24.y;
  tmpvar_6.w = tmpvar_24.z;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = texcoord_8;
  xlv_TEXCOORD1 = (tmpvar_7.xyz - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = (_LightMatrix0 * (_Object2World * gl_Vertex));
}


#endif
#ifdef FRAGMENT
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _LightColor0;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_2;
  vec3 tmpvar_3;
  tmpvar_3 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_1, vec3(_Metallic));
  tmpvar_2 = (tmpvar_1 * (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w)));
  vec3 tmpvar_4;
  tmpvar_4 = normalize(xlv_TEXCOORD2_2.xyz);
  vec3 tmpvar_5;
  tmpvar_5.x = xlv_TEXCOORD2.w;
  tmpvar_5.y = xlv_TEXCOORD2_1.w;
  tmpvar_5.z = xlv_TEXCOORD2_2.w;
  vec3 tmpvar_6;
  vec3 tmpvar_7;
  tmpvar_7 = normalize(tmpvar_5);
  float tmpvar_8;
  tmpvar_8 = max (0.0, dot (tmpvar_4, tmpvar_7));
  tmpvar_6 = (_LightColor0.xyz * ((
    float((xlv_TEXCOORD5.z > 0.0))
   * texture2D (_LightTexture0, 
    ((xlv_TEXCOORD5.xy / xlv_TEXCOORD5.w) + 0.5)
  ).w) * texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD5.xyz, xlv_TEXCOORD5.xyz))).w));
  vec3 viewDir_9;
  viewDir_9 = -(normalize(xlv_TEXCOORD1));
  float specularTerm_10;
  float tmpvar_11;
  tmpvar_11 = (1.0 - _Glossiness);
  vec3 tmpvar_12;
  vec3 inVec_13;
  inVec_13 = (tmpvar_7 + viewDir_9);
  tmpvar_12 = (inVec_13 * inversesqrt(max (0.001, 
    dot (inVec_13, inVec_13)
  )));
  float tmpvar_14;
  tmpvar_14 = max (0.0, dot (tmpvar_4, tmpvar_12));
  float tmpvar_15;
  tmpvar_15 = max (0.0, dot (tmpvar_4, viewDir_9));
  float tmpvar_16;
  tmpvar_16 = max (0.0, dot (tmpvar_7, tmpvar_12));
  float tmpvar_17;
  tmpvar_17 = (tmpvar_11 * tmpvar_11);
  float tmpvar_18;
  tmpvar_18 = (tmpvar_11 * tmpvar_11);
  float tmpvar_19;
  tmpvar_19 = (tmpvar_18 * tmpvar_18);
  float tmpvar_20;
  tmpvar_20 = (((tmpvar_14 * tmpvar_14) * (tmpvar_19 - 1.0)) + 1.0);
  float x_21;
  x_21 = (1.0 - tmpvar_8);
  float x_22;
  x_22 = (1.0 - tmpvar_15);
  float tmpvar_23;
  tmpvar_23 = (0.5 + ((2.0 * tmpvar_16) * (tmpvar_16 * tmpvar_11)));
  float tmpvar_24;
  tmpvar_24 = ((1.0 + (
    (tmpvar_23 - 1.0)
   * 
    ((x_21 * x_21) * ((x_21 * x_21) * x_21))
  )) * (1.0 + (
    (tmpvar_23 - 1.0)
   * 
    ((x_22 * x_22) * ((x_22 * x_22) * x_22))
  )));
  float tmpvar_25;
  tmpvar_25 = (((
    (2.0 * tmpvar_8)
   / 
    (((tmpvar_8 * (
      (tmpvar_15 * (1.0 - tmpvar_17))
     + tmpvar_17)) + (tmpvar_15 * (
      (tmpvar_8 * (1.0 - tmpvar_17))
     + tmpvar_17))) + 1e-05)
  ) * (tmpvar_19 / 
    ((3.141593 * tmpvar_20) * tmpvar_20)
  )) * 0.7853982);
  specularTerm_10 = tmpvar_25;
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    specularTerm_10 = sqrt(max (0.0001, tmpvar_25));
  };
  float tmpvar_26;
  tmpvar_26 = max (0.0, (specularTerm_10 * tmpvar_8));
  specularTerm_10 = tmpvar_26;
  float x_27;
  x_27 = (1.0 - tmpvar_16);
  vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xyz = ((tmpvar_2 * (tmpvar_6 * 
    (tmpvar_24 * tmpvar_8)
  )) + ((tmpvar_26 * tmpvar_6) * (tmpvar_3 + 
    ((1.0 - tmpvar_3) * ((x_27 * x_27) * ((x_27 * x_27) * x_27)))
  )));
  vec4 xlat_varoutput_29;
  xlat_varoutput_29.xyz = tmpvar_28.xyz;
  xlat_varoutput_29.w = 1.0;
  gl_FragData[0] = xlat_varoutput_29;
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
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_WorldTransformParams;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
uniform mat4 _LightMatrix0;
attribute vec4 TANGENT;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec4 tmpvar_7;
  tmpvar_7 = (_Object2World * gl_Vertex);
  tmpvar_3 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_8;
  texcoord_8.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_9;
  if ((_UVSec == 0.0)) {
    tmpvar_9 = tmpvar_1;
  } else {
    tmpvar_9 = tmpvar_2;
  };
  texcoord_8.zw = ((tmpvar_9 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec4 v_10;
  v_10.x = _World2Object[0].x;
  v_10.y = _World2Object[1].x;
  v_10.z = _World2Object[2].x;
  v_10.w = _World2Object[3].x;
  vec4 v_11;
  v_11.x = _World2Object[0].y;
  v_11.y = _World2Object[1].y;
  v_11.z = _World2Object[2].y;
  v_11.w = _World2Object[3].y;
  vec4 v_12;
  v_12.x = _World2Object[0].z;
  v_12.y = _World2Object[1].z;
  v_12.z = _World2Object[2].z;
  v_12.w = _World2Object[3].z;
  vec3 tmpvar_13;
  tmpvar_13 = normalize(((
    (v_10.xyz * gl_Normal.x)
   + 
    (v_11.xyz * gl_Normal.y)
  ) + (v_12.xyz * gl_Normal.z)));
  mat3 tmpvar_14;
  tmpvar_14[0] = _Object2World[0].xyz;
  tmpvar_14[1] = _Object2World[1].xyz;
  tmpvar_14[2] = _Object2World[2].xyz;
  vec4 tmpvar_15;
  tmpvar_15.xyz = normalize((tmpvar_14 * TANGENT.xyz));
  tmpvar_15.w = TANGENT.w;
  vec3 tmpvar_16;
  vec3 tmpvar_17;
  tmpvar_16 = tmpvar_15.xyz;
  tmpvar_17 = (((tmpvar_13.yzx * tmpvar_15.zxy) - (tmpvar_13.zxy * tmpvar_15.yzx)) * (TANGENT.w * unity_WorldTransformParams.w));
  vec3 tmpvar_18;
  vec3 tmpvar_19;
  vec3 tmpvar_20;
  tmpvar_18.x = tmpvar_16.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = tmpvar_13.x;
  tmpvar_19.x = tmpvar_16.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = tmpvar_13.y;
  tmpvar_20.x = tmpvar_16.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = tmpvar_13.z;
  vec3 v_21;
  v_21.x = tmpvar_18.x;
  v_21.y = tmpvar_19.x;
  v_21.z = tmpvar_20.x;
  tmpvar_4.xyz = v_21;
  vec3 v_22;
  v_22.x = tmpvar_18.y;
  v_22.y = tmpvar_19.y;
  v_22.z = tmpvar_20.y;
  tmpvar_5.xyz = v_22;
  vec3 v_23;
  v_23.x = tmpvar_18.z;
  v_23.y = tmpvar_19.z;
  v_23.z = tmpvar_20.z;
  tmpvar_6.xyz = v_23;
  vec3 tmpvar_24;
  tmpvar_24 = (_WorldSpaceLightPos0.xyz - (tmpvar_7.xyz * _WorldSpaceLightPos0.w));
  tmpvar_4.w = tmpvar_24.x;
  tmpvar_5.w = tmpvar_24.y;
  tmpvar_6.w = tmpvar_24.z;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = texcoord_8;
  xlv_TEXCOORD1 = (tmpvar_7.xyz - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xyz;
}


#endif
#ifdef FRAGMENT
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _LightColor0;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform samplerCube _LightTexture0;
uniform sampler2D _LightTextureB0;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_2;
  vec3 tmpvar_3;
  tmpvar_3 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_1, vec3(_Metallic));
  tmpvar_2 = (tmpvar_1 * (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w)));
  vec3 tmpvar_4;
  tmpvar_4 = normalize(xlv_TEXCOORD2_2.xyz);
  vec3 tmpvar_5;
  tmpvar_5.x = xlv_TEXCOORD2.w;
  tmpvar_5.y = xlv_TEXCOORD2_1.w;
  tmpvar_5.z = xlv_TEXCOORD2_2.w;
  vec3 tmpvar_6;
  vec3 tmpvar_7;
  tmpvar_7 = normalize(tmpvar_5);
  float tmpvar_8;
  tmpvar_8 = max (0.0, dot (tmpvar_4, tmpvar_7));
  tmpvar_6 = (_LightColor0.xyz * (texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD5, xlv_TEXCOORD5))).w * textureCube (_LightTexture0, xlv_TEXCOORD5).w));
  vec3 viewDir_9;
  viewDir_9 = -(normalize(xlv_TEXCOORD1));
  float specularTerm_10;
  float tmpvar_11;
  tmpvar_11 = (1.0 - _Glossiness);
  vec3 tmpvar_12;
  vec3 inVec_13;
  inVec_13 = (tmpvar_7 + viewDir_9);
  tmpvar_12 = (inVec_13 * inversesqrt(max (0.001, 
    dot (inVec_13, inVec_13)
  )));
  float tmpvar_14;
  tmpvar_14 = max (0.0, dot (tmpvar_4, tmpvar_12));
  float tmpvar_15;
  tmpvar_15 = max (0.0, dot (tmpvar_4, viewDir_9));
  float tmpvar_16;
  tmpvar_16 = max (0.0, dot (tmpvar_7, tmpvar_12));
  float tmpvar_17;
  tmpvar_17 = (tmpvar_11 * tmpvar_11);
  float tmpvar_18;
  tmpvar_18 = (tmpvar_11 * tmpvar_11);
  float tmpvar_19;
  tmpvar_19 = (tmpvar_18 * tmpvar_18);
  float tmpvar_20;
  tmpvar_20 = (((tmpvar_14 * tmpvar_14) * (tmpvar_19 - 1.0)) + 1.0);
  float x_21;
  x_21 = (1.0 - tmpvar_8);
  float x_22;
  x_22 = (1.0 - tmpvar_15);
  float tmpvar_23;
  tmpvar_23 = (0.5 + ((2.0 * tmpvar_16) * (tmpvar_16 * tmpvar_11)));
  float tmpvar_24;
  tmpvar_24 = ((1.0 + (
    (tmpvar_23 - 1.0)
   * 
    ((x_21 * x_21) * ((x_21 * x_21) * x_21))
  )) * (1.0 + (
    (tmpvar_23 - 1.0)
   * 
    ((x_22 * x_22) * ((x_22 * x_22) * x_22))
  )));
  float tmpvar_25;
  tmpvar_25 = (((
    (2.0 * tmpvar_8)
   / 
    (((tmpvar_8 * (
      (tmpvar_15 * (1.0 - tmpvar_17))
     + tmpvar_17)) + (tmpvar_15 * (
      (tmpvar_8 * (1.0 - tmpvar_17))
     + tmpvar_17))) + 1e-05)
  ) * (tmpvar_19 / 
    ((3.141593 * tmpvar_20) * tmpvar_20)
  )) * 0.7853982);
  specularTerm_10 = tmpvar_25;
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    specularTerm_10 = sqrt(max (0.0001, tmpvar_25));
  };
  float tmpvar_26;
  tmpvar_26 = max (0.0, (specularTerm_10 * tmpvar_8));
  specularTerm_10 = tmpvar_26;
  float x_27;
  x_27 = (1.0 - tmpvar_16);
  vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xyz = ((tmpvar_2 * (tmpvar_6 * 
    (tmpvar_24 * tmpvar_8)
  )) + ((tmpvar_26 * tmpvar_6) * (tmpvar_3 + 
    ((1.0 - tmpvar_3) * ((x_27 * x_27) * ((x_27 * x_27) * x_27)))
  )));
  vec4 xlat_varoutput_29;
  xlat_varoutput_29.xyz = tmpvar_28.xyz;
  xlat_varoutput_29.w = 1.0;
  gl_FragData[0] = xlat_varoutput_29;
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
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_WorldTransformParams;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
uniform mat4 _LightMatrix0;
attribute vec4 TANGENT;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec2 xlv_TEXCOORD5;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec4 tmpvar_7;
  tmpvar_7 = (_Object2World * gl_Vertex);
  tmpvar_3 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_8;
  texcoord_8.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_9;
  if ((_UVSec == 0.0)) {
    tmpvar_9 = tmpvar_1;
  } else {
    tmpvar_9 = tmpvar_2;
  };
  texcoord_8.zw = ((tmpvar_9 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec4 v_10;
  v_10.x = _World2Object[0].x;
  v_10.y = _World2Object[1].x;
  v_10.z = _World2Object[2].x;
  v_10.w = _World2Object[3].x;
  vec4 v_11;
  v_11.x = _World2Object[0].y;
  v_11.y = _World2Object[1].y;
  v_11.z = _World2Object[2].y;
  v_11.w = _World2Object[3].y;
  vec4 v_12;
  v_12.x = _World2Object[0].z;
  v_12.y = _World2Object[1].z;
  v_12.z = _World2Object[2].z;
  v_12.w = _World2Object[3].z;
  vec3 tmpvar_13;
  tmpvar_13 = normalize(((
    (v_10.xyz * gl_Normal.x)
   + 
    (v_11.xyz * gl_Normal.y)
  ) + (v_12.xyz * gl_Normal.z)));
  mat3 tmpvar_14;
  tmpvar_14[0] = _Object2World[0].xyz;
  tmpvar_14[1] = _Object2World[1].xyz;
  tmpvar_14[2] = _Object2World[2].xyz;
  vec4 tmpvar_15;
  tmpvar_15.xyz = normalize((tmpvar_14 * TANGENT.xyz));
  tmpvar_15.w = TANGENT.w;
  vec3 tmpvar_16;
  vec3 tmpvar_17;
  tmpvar_16 = tmpvar_15.xyz;
  tmpvar_17 = (((tmpvar_13.yzx * tmpvar_15.zxy) - (tmpvar_13.zxy * tmpvar_15.yzx)) * (TANGENT.w * unity_WorldTransformParams.w));
  vec3 tmpvar_18;
  vec3 tmpvar_19;
  vec3 tmpvar_20;
  tmpvar_18.x = tmpvar_16.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = tmpvar_13.x;
  tmpvar_19.x = tmpvar_16.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = tmpvar_13.y;
  tmpvar_20.x = tmpvar_16.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = tmpvar_13.z;
  vec3 v_21;
  v_21.x = tmpvar_18.x;
  v_21.y = tmpvar_19.x;
  v_21.z = tmpvar_20.x;
  tmpvar_4.xyz = v_21;
  vec3 v_22;
  v_22.x = tmpvar_18.y;
  v_22.y = tmpvar_19.y;
  v_22.z = tmpvar_20.y;
  tmpvar_5.xyz = v_22;
  vec3 v_23;
  v_23.x = tmpvar_18.z;
  v_23.y = tmpvar_19.z;
  v_23.z = tmpvar_20.z;
  tmpvar_6.xyz = v_23;
  vec3 tmpvar_24;
  tmpvar_24 = (_WorldSpaceLightPos0.xyz - (tmpvar_7.xyz * _WorldSpaceLightPos0.w));
  tmpvar_4.w = tmpvar_24.x;
  tmpvar_5.w = tmpvar_24.y;
  tmpvar_6.w = tmpvar_24.z;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = texcoord_8;
  xlv_TEXCOORD1 = (tmpvar_7.xyz - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xy;
}


#endif
#ifdef FRAGMENT
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _LightColor0;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform sampler2D _LightTexture0;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec2 xlv_TEXCOORD5;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_2;
  vec3 tmpvar_3;
  tmpvar_3 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_1, vec3(_Metallic));
  tmpvar_2 = (tmpvar_1 * (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w)));
  vec3 tmpvar_4;
  tmpvar_4 = normalize(xlv_TEXCOORD2_2.xyz);
  vec3 tmpvar_5;
  tmpvar_5.x = xlv_TEXCOORD2.w;
  tmpvar_5.y = xlv_TEXCOORD2_1.w;
  tmpvar_5.z = xlv_TEXCOORD2_2.w;
  vec3 tmpvar_6;
  float tmpvar_7;
  tmpvar_7 = max (0.0, dot (tmpvar_4, tmpvar_5));
  tmpvar_6 = (_LightColor0.xyz * texture2D (_LightTexture0, xlv_TEXCOORD5).w);
  vec3 viewDir_8;
  viewDir_8 = -(normalize(xlv_TEXCOORD1));
  float specularTerm_9;
  float tmpvar_10;
  tmpvar_10 = (1.0 - _Glossiness);
  vec3 tmpvar_11;
  vec3 inVec_12;
  inVec_12 = (tmpvar_5 + viewDir_8);
  tmpvar_11 = (inVec_12 * inversesqrt(max (0.001, 
    dot (inVec_12, inVec_12)
  )));
  float tmpvar_13;
  tmpvar_13 = max (0.0, dot (tmpvar_4, tmpvar_11));
  float tmpvar_14;
  tmpvar_14 = max (0.0, dot (tmpvar_4, viewDir_8));
  float tmpvar_15;
  tmpvar_15 = max (0.0, dot (tmpvar_5, tmpvar_11));
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
  tmpvar_27.xyz = ((tmpvar_2 * (tmpvar_6 * 
    (tmpvar_23 * tmpvar_7)
  )) + ((tmpvar_25 * tmpvar_6) * (tmpvar_3 + 
    ((1.0 - tmpvar_3) * ((x_26 * x_26) * ((x_26 * x_26) * x_26)))
  )));
  vec4 xlat_varoutput_28;
  xlat_varoutput_28.xyz = tmpvar_27.xyz;
  xlat_varoutput_28.w = 1.0;
  gl_FragData[0] = xlat_varoutput_28;
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
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform mat4 unity_World2Shadow[4];

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_WorldTransformParams;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
uniform mat4 _LightMatrix0;
attribute vec4 TANGENT;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD6;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec4 tmpvar_7;
  tmpvar_7 = (_Object2World * gl_Vertex);
  tmpvar_3 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_8;
  texcoord_8.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_9;
  if ((_UVSec == 0.0)) {
    tmpvar_9 = tmpvar_1;
  } else {
    tmpvar_9 = tmpvar_2;
  };
  texcoord_8.zw = ((tmpvar_9 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec4 v_10;
  v_10.x = _World2Object[0].x;
  v_10.y = _World2Object[1].x;
  v_10.z = _World2Object[2].x;
  v_10.w = _World2Object[3].x;
  vec4 v_11;
  v_11.x = _World2Object[0].y;
  v_11.y = _World2Object[1].y;
  v_11.z = _World2Object[2].y;
  v_11.w = _World2Object[3].y;
  vec4 v_12;
  v_12.x = _World2Object[0].z;
  v_12.y = _World2Object[1].z;
  v_12.z = _World2Object[2].z;
  v_12.w = _World2Object[3].z;
  vec3 tmpvar_13;
  tmpvar_13 = normalize(((
    (v_10.xyz * gl_Normal.x)
   + 
    (v_11.xyz * gl_Normal.y)
  ) + (v_12.xyz * gl_Normal.z)));
  mat3 tmpvar_14;
  tmpvar_14[0] = _Object2World[0].xyz;
  tmpvar_14[1] = _Object2World[1].xyz;
  tmpvar_14[2] = _Object2World[2].xyz;
  vec4 tmpvar_15;
  tmpvar_15.xyz = normalize((tmpvar_14 * TANGENT.xyz));
  tmpvar_15.w = TANGENT.w;
  vec3 tmpvar_16;
  vec3 tmpvar_17;
  tmpvar_16 = tmpvar_15.xyz;
  tmpvar_17 = (((tmpvar_13.yzx * tmpvar_15.zxy) - (tmpvar_13.zxy * tmpvar_15.yzx)) * (TANGENT.w * unity_WorldTransformParams.w));
  vec3 tmpvar_18;
  vec3 tmpvar_19;
  vec3 tmpvar_20;
  tmpvar_18.x = tmpvar_16.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = tmpvar_13.x;
  tmpvar_19.x = tmpvar_16.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = tmpvar_13.y;
  tmpvar_20.x = tmpvar_16.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = tmpvar_13.z;
  vec3 v_21;
  v_21.x = tmpvar_18.x;
  v_21.y = tmpvar_19.x;
  v_21.z = tmpvar_20.x;
  tmpvar_4.xyz = v_21;
  vec3 v_22;
  v_22.x = tmpvar_18.y;
  v_22.y = tmpvar_19.y;
  v_22.z = tmpvar_20.y;
  tmpvar_5.xyz = v_22;
  vec3 v_23;
  v_23.x = tmpvar_18.z;
  v_23.y = tmpvar_19.z;
  v_23.z = tmpvar_20.z;
  tmpvar_6.xyz = v_23;
  vec3 tmpvar_24;
  tmpvar_24 = (_WorldSpaceLightPos0.xyz - (tmpvar_7.xyz * _WorldSpaceLightPos0.w));
  tmpvar_4.w = tmpvar_24.x;
  tmpvar_5.w = tmpvar_24.y;
  tmpvar_6.w = tmpvar_24.z;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = texcoord_8;
  xlv_TEXCOORD1 = (tmpvar_7.xyz - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  vec4 tmpvar_25;
  tmpvar_25 = (_Object2World * gl_Vertex);
  xlv_TEXCOORD5 = (_LightMatrix0 * tmpvar_25);
  xlv_TEXCOORD6 = (unity_World2Shadow[0] * tmpvar_25);
}


#endif
#ifdef FRAGMENT
uniform vec4 _LightShadowData;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _LightColor0;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform sampler2DShadow _ShadowMapTexture;
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD6;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_2;
  vec3 tmpvar_3;
  tmpvar_3 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_1, vec3(_Metallic));
  tmpvar_2 = (tmpvar_1 * (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w)));
  vec3 tmpvar_4;
  tmpvar_4 = normalize(xlv_TEXCOORD2_2.xyz);
  vec3 tmpvar_5;
  tmpvar_5.x = xlv_TEXCOORD2.w;
  tmpvar_5.y = xlv_TEXCOORD2_1.w;
  tmpvar_5.z = xlv_TEXCOORD2_2.w;
  vec3 tmpvar_6;
  vec3 tmpvar_7;
  tmpvar_7 = normalize(tmpvar_5);
  float tmpvar_8;
  tmpvar_8 = max (0.0, dot (tmpvar_4, tmpvar_7));
  tmpvar_6 = (_LightColor0.xyz * ((
    (float((xlv_TEXCOORD5.z > 0.0)) * texture2D (_LightTexture0, ((xlv_TEXCOORD5.xy / xlv_TEXCOORD5.w) + 0.5)).w)
   * texture2D (_LightTextureB0, vec2(
    dot (xlv_TEXCOORD5.xyz, xlv_TEXCOORD5.xyz)
  )).w) * (_LightShadowData.x + 
    (shadow2DProj (_ShadowMapTexture, xlv_TEXCOORD6).x * (1.0 - _LightShadowData.x))
  )));
  vec3 viewDir_9;
  viewDir_9 = -(normalize(xlv_TEXCOORD1));
  float specularTerm_10;
  float tmpvar_11;
  tmpvar_11 = (1.0 - _Glossiness);
  vec3 tmpvar_12;
  vec3 inVec_13;
  inVec_13 = (tmpvar_7 + viewDir_9);
  tmpvar_12 = (inVec_13 * inversesqrt(max (0.001, 
    dot (inVec_13, inVec_13)
  )));
  float tmpvar_14;
  tmpvar_14 = max (0.0, dot (tmpvar_4, tmpvar_12));
  float tmpvar_15;
  tmpvar_15 = max (0.0, dot (tmpvar_4, viewDir_9));
  float tmpvar_16;
  tmpvar_16 = max (0.0, dot (tmpvar_7, tmpvar_12));
  float tmpvar_17;
  tmpvar_17 = (tmpvar_11 * tmpvar_11);
  float tmpvar_18;
  tmpvar_18 = (tmpvar_11 * tmpvar_11);
  float tmpvar_19;
  tmpvar_19 = (tmpvar_18 * tmpvar_18);
  float tmpvar_20;
  tmpvar_20 = (((tmpvar_14 * tmpvar_14) * (tmpvar_19 - 1.0)) + 1.0);
  float x_21;
  x_21 = (1.0 - tmpvar_8);
  float x_22;
  x_22 = (1.0 - tmpvar_15);
  float tmpvar_23;
  tmpvar_23 = (0.5 + ((2.0 * tmpvar_16) * (tmpvar_16 * tmpvar_11)));
  float tmpvar_24;
  tmpvar_24 = ((1.0 + (
    (tmpvar_23 - 1.0)
   * 
    ((x_21 * x_21) * ((x_21 * x_21) * x_21))
  )) * (1.0 + (
    (tmpvar_23 - 1.0)
   * 
    ((x_22 * x_22) * ((x_22 * x_22) * x_22))
  )));
  float tmpvar_25;
  tmpvar_25 = (((
    (2.0 * tmpvar_8)
   / 
    (((tmpvar_8 * (
      (tmpvar_15 * (1.0 - tmpvar_17))
     + tmpvar_17)) + (tmpvar_15 * (
      (tmpvar_8 * (1.0 - tmpvar_17))
     + tmpvar_17))) + 1e-05)
  ) * (tmpvar_19 / 
    ((3.141593 * tmpvar_20) * tmpvar_20)
  )) * 0.7853982);
  specularTerm_10 = tmpvar_25;
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    specularTerm_10 = sqrt(max (0.0001, tmpvar_25));
  };
  float tmpvar_26;
  tmpvar_26 = max (0.0, (specularTerm_10 * tmpvar_8));
  specularTerm_10 = tmpvar_26;
  float x_27;
  x_27 = (1.0 - tmpvar_16);
  vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xyz = ((tmpvar_2 * (tmpvar_6 * 
    (tmpvar_24 * tmpvar_8)
  )) + ((tmpvar_26 * tmpvar_6) * (tmpvar_3 + 
    ((1.0 - tmpvar_3) * ((x_27 * x_27) * ((x_27 * x_27) * x_27)))
  )));
  vec4 xlat_varoutput_29;
  xlat_varoutput_29.xyz = tmpvar_28.xyz;
  xlat_varoutput_29.w = 1.0;
  gl_FragData[0] = xlat_varoutput_29;
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
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;
uniform vec4 _WorldSpaceLightPos0;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_WorldTransformParams;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
attribute vec4 TANGENT;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec4 tmpvar_7;
  tmpvar_7 = (_Object2World * gl_Vertex);
  tmpvar_3 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_8;
  texcoord_8.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_9;
  if ((_UVSec == 0.0)) {
    tmpvar_9 = tmpvar_1;
  } else {
    tmpvar_9 = tmpvar_2;
  };
  texcoord_8.zw = ((tmpvar_9 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec4 v_10;
  v_10.x = _World2Object[0].x;
  v_10.y = _World2Object[1].x;
  v_10.z = _World2Object[2].x;
  v_10.w = _World2Object[3].x;
  vec4 v_11;
  v_11.x = _World2Object[0].y;
  v_11.y = _World2Object[1].y;
  v_11.z = _World2Object[2].y;
  v_11.w = _World2Object[3].y;
  vec4 v_12;
  v_12.x = _World2Object[0].z;
  v_12.y = _World2Object[1].z;
  v_12.z = _World2Object[2].z;
  v_12.w = _World2Object[3].z;
  vec3 tmpvar_13;
  tmpvar_13 = normalize(((
    (v_10.xyz * gl_Normal.x)
   + 
    (v_11.xyz * gl_Normal.y)
  ) + (v_12.xyz * gl_Normal.z)));
  mat3 tmpvar_14;
  tmpvar_14[0] = _Object2World[0].xyz;
  tmpvar_14[1] = _Object2World[1].xyz;
  tmpvar_14[2] = _Object2World[2].xyz;
  vec4 tmpvar_15;
  tmpvar_15.xyz = normalize((tmpvar_14 * TANGENT.xyz));
  tmpvar_15.w = TANGENT.w;
  vec3 tmpvar_16;
  vec3 tmpvar_17;
  tmpvar_16 = tmpvar_15.xyz;
  tmpvar_17 = (((tmpvar_13.yzx * tmpvar_15.zxy) - (tmpvar_13.zxy * tmpvar_15.yzx)) * (TANGENT.w * unity_WorldTransformParams.w));
  vec3 tmpvar_18;
  vec3 tmpvar_19;
  vec3 tmpvar_20;
  tmpvar_18.x = tmpvar_16.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = tmpvar_13.x;
  tmpvar_19.x = tmpvar_16.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = tmpvar_13.y;
  tmpvar_20.x = tmpvar_16.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = tmpvar_13.z;
  vec3 v_21;
  v_21.x = tmpvar_18.x;
  v_21.y = tmpvar_19.x;
  v_21.z = tmpvar_20.x;
  tmpvar_4.xyz = v_21;
  vec3 v_22;
  v_22.x = tmpvar_18.y;
  v_22.y = tmpvar_19.y;
  v_22.z = tmpvar_20.y;
  tmpvar_5.xyz = v_22;
  vec3 v_23;
  v_23.x = tmpvar_18.z;
  v_23.y = tmpvar_19.z;
  v_23.z = tmpvar_20.z;
  tmpvar_6.xyz = v_23;
  vec4 o_24;
  vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_3 * 0.5);
  vec2 tmpvar_26;
  tmpvar_26.x = tmpvar_25.x;
  tmpvar_26.y = (tmpvar_25.y * _ProjectionParams.x);
  o_24.xy = (tmpvar_26 + tmpvar_25.w);
  o_24.zw = tmpvar_3.zw;
  vec3 tmpvar_27;
  tmpvar_27 = (_WorldSpaceLightPos0.xyz - (tmpvar_7.xyz * _WorldSpaceLightPos0.w));
  tmpvar_4.w = tmpvar_27.x;
  tmpvar_5.w = tmpvar_27.y;
  tmpvar_6.w = tmpvar_27.z;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = texcoord_8;
  xlv_TEXCOORD1 = (tmpvar_7.xyz - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = o_24;
}


#endif
#ifdef FRAGMENT
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _LightColor0;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform sampler2D _ShadowMapTexture;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_2;
  vec3 tmpvar_3;
  tmpvar_3 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_1, vec3(_Metallic));
  tmpvar_2 = (tmpvar_1 * (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w)));
  vec3 tmpvar_4;
  tmpvar_4 = normalize(xlv_TEXCOORD2_2.xyz);
  vec3 tmpvar_5;
  tmpvar_5.x = xlv_TEXCOORD2.w;
  tmpvar_5.y = xlv_TEXCOORD2_1.w;
  tmpvar_5.z = xlv_TEXCOORD2_2.w;
  vec3 tmpvar_6;
  float tmpvar_7;
  tmpvar_7 = max (0.0, dot (tmpvar_4, tmpvar_5));
  tmpvar_6 = (_LightColor0.xyz * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD5).x);
  vec3 viewDir_8;
  viewDir_8 = -(normalize(xlv_TEXCOORD1));
  float specularTerm_9;
  float tmpvar_10;
  tmpvar_10 = (1.0 - _Glossiness);
  vec3 tmpvar_11;
  vec3 inVec_12;
  inVec_12 = (tmpvar_5 + viewDir_8);
  tmpvar_11 = (inVec_12 * inversesqrt(max (0.001, 
    dot (inVec_12, inVec_12)
  )));
  float tmpvar_13;
  tmpvar_13 = max (0.0, dot (tmpvar_4, tmpvar_11));
  float tmpvar_14;
  tmpvar_14 = max (0.0, dot (tmpvar_4, viewDir_8));
  float tmpvar_15;
  tmpvar_15 = max (0.0, dot (tmpvar_5, tmpvar_11));
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
  tmpvar_27.xyz = ((tmpvar_2 * (tmpvar_6 * 
    (tmpvar_23 * tmpvar_7)
  )) + ((tmpvar_25 * tmpvar_6) * (tmpvar_3 + 
    ((1.0 - tmpvar_3) * ((x_26 * x_26) * ((x_26 * x_26) * x_26)))
  )));
  vec4 xlat_varoutput_28;
  xlat_varoutput_28.xyz = tmpvar_27.xyz;
  xlat_varoutput_28.w = 1.0;
  gl_FragData[0] = xlat_varoutput_28;
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
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;
uniform vec4 _WorldSpaceLightPos0;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_WorldTransformParams;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
uniform mat4 _LightMatrix0;
attribute vec4 TANGENT;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec2 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD6;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec4 tmpvar_7;
  tmpvar_7 = (_Object2World * gl_Vertex);
  tmpvar_3 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_8;
  texcoord_8.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_9;
  if ((_UVSec == 0.0)) {
    tmpvar_9 = tmpvar_1;
  } else {
    tmpvar_9 = tmpvar_2;
  };
  texcoord_8.zw = ((tmpvar_9 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec4 v_10;
  v_10.x = _World2Object[0].x;
  v_10.y = _World2Object[1].x;
  v_10.z = _World2Object[2].x;
  v_10.w = _World2Object[3].x;
  vec4 v_11;
  v_11.x = _World2Object[0].y;
  v_11.y = _World2Object[1].y;
  v_11.z = _World2Object[2].y;
  v_11.w = _World2Object[3].y;
  vec4 v_12;
  v_12.x = _World2Object[0].z;
  v_12.y = _World2Object[1].z;
  v_12.z = _World2Object[2].z;
  v_12.w = _World2Object[3].z;
  vec3 tmpvar_13;
  tmpvar_13 = normalize(((
    (v_10.xyz * gl_Normal.x)
   + 
    (v_11.xyz * gl_Normal.y)
  ) + (v_12.xyz * gl_Normal.z)));
  mat3 tmpvar_14;
  tmpvar_14[0] = _Object2World[0].xyz;
  tmpvar_14[1] = _Object2World[1].xyz;
  tmpvar_14[2] = _Object2World[2].xyz;
  vec4 tmpvar_15;
  tmpvar_15.xyz = normalize((tmpvar_14 * TANGENT.xyz));
  tmpvar_15.w = TANGENT.w;
  vec3 tmpvar_16;
  vec3 tmpvar_17;
  tmpvar_16 = tmpvar_15.xyz;
  tmpvar_17 = (((tmpvar_13.yzx * tmpvar_15.zxy) - (tmpvar_13.zxy * tmpvar_15.yzx)) * (TANGENT.w * unity_WorldTransformParams.w));
  vec3 tmpvar_18;
  vec3 tmpvar_19;
  vec3 tmpvar_20;
  tmpvar_18.x = tmpvar_16.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = tmpvar_13.x;
  tmpvar_19.x = tmpvar_16.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = tmpvar_13.y;
  tmpvar_20.x = tmpvar_16.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = tmpvar_13.z;
  vec3 v_21;
  v_21.x = tmpvar_18.x;
  v_21.y = tmpvar_19.x;
  v_21.z = tmpvar_20.x;
  tmpvar_4.xyz = v_21;
  vec3 v_22;
  v_22.x = tmpvar_18.y;
  v_22.y = tmpvar_19.y;
  v_22.z = tmpvar_20.y;
  tmpvar_5.xyz = v_22;
  vec3 v_23;
  v_23.x = tmpvar_18.z;
  v_23.y = tmpvar_19.z;
  v_23.z = tmpvar_20.z;
  tmpvar_6.xyz = v_23;
  vec4 o_24;
  vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_3 * 0.5);
  vec2 tmpvar_26;
  tmpvar_26.x = tmpvar_25.x;
  tmpvar_26.y = (tmpvar_25.y * _ProjectionParams.x);
  o_24.xy = (tmpvar_26 + tmpvar_25.w);
  o_24.zw = tmpvar_3.zw;
  vec3 tmpvar_27;
  tmpvar_27 = (_WorldSpaceLightPos0.xyz - (tmpvar_7.xyz * _WorldSpaceLightPos0.w));
  tmpvar_4.w = tmpvar_27.x;
  tmpvar_5.w = tmpvar_27.y;
  tmpvar_6.w = tmpvar_27.z;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = texcoord_8;
  xlv_TEXCOORD1 = (tmpvar_7.xyz - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xy;
  xlv_TEXCOORD6 = o_24;
}


#endif
#ifdef FRAGMENT
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _LightColor0;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _LightTexture0;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec2 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD6;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_2;
  vec3 tmpvar_3;
  tmpvar_3 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_1, vec3(_Metallic));
  tmpvar_2 = (tmpvar_1 * (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w)));
  vec3 tmpvar_4;
  tmpvar_4 = normalize(xlv_TEXCOORD2_2.xyz);
  vec3 tmpvar_5;
  tmpvar_5.x = xlv_TEXCOORD2.w;
  tmpvar_5.y = xlv_TEXCOORD2_1.w;
  tmpvar_5.z = xlv_TEXCOORD2_2.w;
  vec3 tmpvar_6;
  float tmpvar_7;
  tmpvar_7 = max (0.0, dot (tmpvar_4, tmpvar_5));
  tmpvar_6 = (_LightColor0.xyz * (texture2D (_LightTexture0, xlv_TEXCOORD5).w * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD6).x));
  vec3 viewDir_8;
  viewDir_8 = -(normalize(xlv_TEXCOORD1));
  float specularTerm_9;
  float tmpvar_10;
  tmpvar_10 = (1.0 - _Glossiness);
  vec3 tmpvar_11;
  vec3 inVec_12;
  inVec_12 = (tmpvar_5 + viewDir_8);
  tmpvar_11 = (inVec_12 * inversesqrt(max (0.001, 
    dot (inVec_12, inVec_12)
  )));
  float tmpvar_13;
  tmpvar_13 = max (0.0, dot (tmpvar_4, tmpvar_11));
  float tmpvar_14;
  tmpvar_14 = max (0.0, dot (tmpvar_4, viewDir_8));
  float tmpvar_15;
  tmpvar_15 = max (0.0, dot (tmpvar_5, tmpvar_11));
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
  tmpvar_27.xyz = ((tmpvar_2 * (tmpvar_6 * 
    (tmpvar_23 * tmpvar_7)
  )) + ((tmpvar_25 * tmpvar_6) * (tmpvar_3 + 
    ((1.0 - tmpvar_3) * ((x_26 * x_26) * ((x_26 * x_26) * x_26)))
  )));
  vec4 xlat_varoutput_28;
  xlat_varoutput_28.xyz = tmpvar_27.xyz;
  xlat_varoutput_28.w = 1.0;
  gl_FragData[0] = xlat_varoutput_28;
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
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightPositionRange;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_WorldTransformParams;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
uniform mat4 _LightMatrix0;
attribute vec4 TANGENT;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD6;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec4 tmpvar_7;
  tmpvar_7 = (_Object2World * gl_Vertex);
  tmpvar_3 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_8;
  texcoord_8.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_9;
  if ((_UVSec == 0.0)) {
    tmpvar_9 = tmpvar_1;
  } else {
    tmpvar_9 = tmpvar_2;
  };
  texcoord_8.zw = ((tmpvar_9 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec4 v_10;
  v_10.x = _World2Object[0].x;
  v_10.y = _World2Object[1].x;
  v_10.z = _World2Object[2].x;
  v_10.w = _World2Object[3].x;
  vec4 v_11;
  v_11.x = _World2Object[0].y;
  v_11.y = _World2Object[1].y;
  v_11.z = _World2Object[2].y;
  v_11.w = _World2Object[3].y;
  vec4 v_12;
  v_12.x = _World2Object[0].z;
  v_12.y = _World2Object[1].z;
  v_12.z = _World2Object[2].z;
  v_12.w = _World2Object[3].z;
  vec3 tmpvar_13;
  tmpvar_13 = normalize(((
    (v_10.xyz * gl_Normal.x)
   + 
    (v_11.xyz * gl_Normal.y)
  ) + (v_12.xyz * gl_Normal.z)));
  mat3 tmpvar_14;
  tmpvar_14[0] = _Object2World[0].xyz;
  tmpvar_14[1] = _Object2World[1].xyz;
  tmpvar_14[2] = _Object2World[2].xyz;
  vec4 tmpvar_15;
  tmpvar_15.xyz = normalize((tmpvar_14 * TANGENT.xyz));
  tmpvar_15.w = TANGENT.w;
  vec3 tmpvar_16;
  vec3 tmpvar_17;
  tmpvar_16 = tmpvar_15.xyz;
  tmpvar_17 = (((tmpvar_13.yzx * tmpvar_15.zxy) - (tmpvar_13.zxy * tmpvar_15.yzx)) * (TANGENT.w * unity_WorldTransformParams.w));
  vec3 tmpvar_18;
  vec3 tmpvar_19;
  vec3 tmpvar_20;
  tmpvar_18.x = tmpvar_16.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = tmpvar_13.x;
  tmpvar_19.x = tmpvar_16.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = tmpvar_13.y;
  tmpvar_20.x = tmpvar_16.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = tmpvar_13.z;
  vec3 v_21;
  v_21.x = tmpvar_18.x;
  v_21.y = tmpvar_19.x;
  v_21.z = tmpvar_20.x;
  tmpvar_4.xyz = v_21;
  vec3 v_22;
  v_22.x = tmpvar_18.y;
  v_22.y = tmpvar_19.y;
  v_22.z = tmpvar_20.y;
  tmpvar_5.xyz = v_22;
  vec3 v_23;
  v_23.x = tmpvar_18.z;
  v_23.y = tmpvar_19.z;
  v_23.z = tmpvar_20.z;
  tmpvar_6.xyz = v_23;
  vec3 tmpvar_24;
  tmpvar_24 = (_WorldSpaceLightPos0.xyz - (tmpvar_7.xyz * _WorldSpaceLightPos0.w));
  tmpvar_4.w = tmpvar_24.x;
  tmpvar_5.w = tmpvar_24.y;
  tmpvar_6.w = tmpvar_24.z;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = texcoord_8;
  xlv_TEXCOORD1 = (tmpvar_7.xyz - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  vec4 tmpvar_25;
  tmpvar_25 = (_Object2World * gl_Vertex);
  xlv_TEXCOORD5 = (_LightMatrix0 * tmpvar_25).xyz;
  xlv_TEXCOORD6 = (tmpvar_25.xyz - _LightPositionRange.xyz);
}


#endif
#ifdef FRAGMENT
uniform vec4 _LightPositionRange;
uniform vec4 _LightShadowData;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _LightColor0;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform samplerCube _ShadowMapTexture;
uniform sampler2D _LightTexture0;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD6;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_2;
  vec3 tmpvar_3;
  tmpvar_3 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_1, vec3(_Metallic));
  tmpvar_2 = (tmpvar_1 * (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w)));
  vec3 tmpvar_4;
  tmpvar_4 = normalize(xlv_TEXCOORD2_2.xyz);
  vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD1);
  vec3 tmpvar_6;
  tmpvar_6.x = xlv_TEXCOORD2.w;
  tmpvar_6.y = xlv_TEXCOORD2_1.w;
  tmpvar_6.z = xlv_TEXCOORD2_2.w;
  vec4 tmpvar_7;
  tmpvar_7 = texture2D (_LightTexture0, vec2(dot (xlv_TEXCOORD5, xlv_TEXCOORD5)));
  float mydist_8;
  mydist_8 = ((sqrt(
    dot (xlv_TEXCOORD6, xlv_TEXCOORD6)
  ) * _LightPositionRange.w) * 0.97);
  vec4 tmpvar_9;
  tmpvar_9 = textureCube (_ShadowMapTexture, xlv_TEXCOORD6);
  float tmpvar_10;
  if ((tmpvar_9.x < mydist_8)) {
    tmpvar_10 = _LightShadowData.x;
  } else {
    tmpvar_10 = 1.0;
  };
  vec3 tmpvar_11;
  vec3 tmpvar_12;
  tmpvar_12 = normalize(tmpvar_6);
  float tmpvar_13;
  tmpvar_13 = max (0.0, dot (tmpvar_4, tmpvar_12));
  tmpvar_11 = (_LightColor0.xyz * (tmpvar_7.w * tmpvar_10));
  vec3 viewDir_14;
  viewDir_14 = -(tmpvar_5);
  float specularTerm_15;
  float tmpvar_16;
  tmpvar_16 = (1.0 - _Glossiness);
  vec3 tmpvar_17;
  vec3 inVec_18;
  inVec_18 = (tmpvar_12 + viewDir_14);
  tmpvar_17 = (inVec_18 * inversesqrt(max (0.001, 
    dot (inVec_18, inVec_18)
  )));
  float tmpvar_19;
  tmpvar_19 = max (0.0, dot (tmpvar_4, tmpvar_17));
  float tmpvar_20;
  tmpvar_20 = max (0.0, dot (tmpvar_4, viewDir_14));
  float tmpvar_21;
  tmpvar_21 = max (0.0, dot (tmpvar_12, tmpvar_17));
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
  tmpvar_33.xyz = ((tmpvar_2 * (tmpvar_11 * 
    (tmpvar_29 * tmpvar_13)
  )) + ((tmpvar_31 * tmpvar_11) * (tmpvar_3 + 
    ((1.0 - tmpvar_3) * ((x_32 * x_32) * ((x_32 * x_32) * x_32)))
  )));
  vec4 xlat_varoutput_34;
  xlat_varoutput_34.xyz = tmpvar_33.xyz;
  xlat_varoutput_34.w = 1.0;
  gl_FragData[0] = xlat_varoutput_34;
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
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightPositionRange;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_WorldTransformParams;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
uniform mat4 _LightMatrix0;
attribute vec4 TANGENT;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD6;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec4 tmpvar_7;
  tmpvar_7 = (_Object2World * gl_Vertex);
  tmpvar_3 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_8;
  texcoord_8.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_9;
  if ((_UVSec == 0.0)) {
    tmpvar_9 = tmpvar_1;
  } else {
    tmpvar_9 = tmpvar_2;
  };
  texcoord_8.zw = ((tmpvar_9 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec4 v_10;
  v_10.x = _World2Object[0].x;
  v_10.y = _World2Object[1].x;
  v_10.z = _World2Object[2].x;
  v_10.w = _World2Object[3].x;
  vec4 v_11;
  v_11.x = _World2Object[0].y;
  v_11.y = _World2Object[1].y;
  v_11.z = _World2Object[2].y;
  v_11.w = _World2Object[3].y;
  vec4 v_12;
  v_12.x = _World2Object[0].z;
  v_12.y = _World2Object[1].z;
  v_12.z = _World2Object[2].z;
  v_12.w = _World2Object[3].z;
  vec3 tmpvar_13;
  tmpvar_13 = normalize(((
    (v_10.xyz * gl_Normal.x)
   + 
    (v_11.xyz * gl_Normal.y)
  ) + (v_12.xyz * gl_Normal.z)));
  mat3 tmpvar_14;
  tmpvar_14[0] = _Object2World[0].xyz;
  tmpvar_14[1] = _Object2World[1].xyz;
  tmpvar_14[2] = _Object2World[2].xyz;
  vec4 tmpvar_15;
  tmpvar_15.xyz = normalize((tmpvar_14 * TANGENT.xyz));
  tmpvar_15.w = TANGENT.w;
  vec3 tmpvar_16;
  vec3 tmpvar_17;
  tmpvar_16 = tmpvar_15.xyz;
  tmpvar_17 = (((tmpvar_13.yzx * tmpvar_15.zxy) - (tmpvar_13.zxy * tmpvar_15.yzx)) * (TANGENT.w * unity_WorldTransformParams.w));
  vec3 tmpvar_18;
  vec3 tmpvar_19;
  vec3 tmpvar_20;
  tmpvar_18.x = tmpvar_16.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = tmpvar_13.x;
  tmpvar_19.x = tmpvar_16.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = tmpvar_13.y;
  tmpvar_20.x = tmpvar_16.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = tmpvar_13.z;
  vec3 v_21;
  v_21.x = tmpvar_18.x;
  v_21.y = tmpvar_19.x;
  v_21.z = tmpvar_20.x;
  tmpvar_4.xyz = v_21;
  vec3 v_22;
  v_22.x = tmpvar_18.y;
  v_22.y = tmpvar_19.y;
  v_22.z = tmpvar_20.y;
  tmpvar_5.xyz = v_22;
  vec3 v_23;
  v_23.x = tmpvar_18.z;
  v_23.y = tmpvar_19.z;
  v_23.z = tmpvar_20.z;
  tmpvar_6.xyz = v_23;
  vec3 tmpvar_24;
  tmpvar_24 = (_WorldSpaceLightPos0.xyz - (tmpvar_7.xyz * _WorldSpaceLightPos0.w));
  tmpvar_4.w = tmpvar_24.x;
  tmpvar_5.w = tmpvar_24.y;
  tmpvar_6.w = tmpvar_24.z;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = texcoord_8;
  xlv_TEXCOORD1 = (tmpvar_7.xyz - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  vec4 tmpvar_25;
  tmpvar_25 = (_Object2World * gl_Vertex);
  xlv_TEXCOORD5 = (_LightMatrix0 * tmpvar_25).xyz;
  xlv_TEXCOORD6 = (tmpvar_25.xyz - _LightPositionRange.xyz);
}


#endif
#ifdef FRAGMENT
uniform vec4 _LightPositionRange;
uniform vec4 _LightShadowData;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _LightColor0;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform samplerCube _ShadowMapTexture;
uniform samplerCube _LightTexture0;
uniform sampler2D _LightTextureB0;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD6;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_2;
  vec3 tmpvar_3;
  tmpvar_3 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_1, vec3(_Metallic));
  tmpvar_2 = (tmpvar_1 * (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w)));
  vec3 tmpvar_4;
  tmpvar_4 = normalize(xlv_TEXCOORD2_2.xyz);
  vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD1);
  vec3 tmpvar_6;
  tmpvar_6.x = xlv_TEXCOORD2.w;
  tmpvar_6.y = xlv_TEXCOORD2_1.w;
  tmpvar_6.z = xlv_TEXCOORD2_2.w;
  vec4 tmpvar_7;
  tmpvar_7 = texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD5, xlv_TEXCOORD5)));
  vec4 tmpvar_8;
  tmpvar_8 = textureCube (_LightTexture0, xlv_TEXCOORD5);
  float mydist_9;
  mydist_9 = ((sqrt(
    dot (xlv_TEXCOORD6, xlv_TEXCOORD6)
  ) * _LightPositionRange.w) * 0.97);
  vec4 tmpvar_10;
  tmpvar_10 = textureCube (_ShadowMapTexture, xlv_TEXCOORD6);
  float tmpvar_11;
  if ((tmpvar_10.x < mydist_9)) {
    tmpvar_11 = _LightShadowData.x;
  } else {
    tmpvar_11 = 1.0;
  };
  vec3 tmpvar_12;
  vec3 tmpvar_13;
  tmpvar_13 = normalize(tmpvar_6);
  float tmpvar_14;
  tmpvar_14 = max (0.0, dot (tmpvar_4, tmpvar_13));
  tmpvar_12 = (_LightColor0.xyz * ((tmpvar_7.w * tmpvar_8.w) * tmpvar_11));
  vec3 viewDir_15;
  viewDir_15 = -(tmpvar_5);
  float specularTerm_16;
  float tmpvar_17;
  tmpvar_17 = (1.0 - _Glossiness);
  vec3 tmpvar_18;
  vec3 inVec_19;
  inVec_19 = (tmpvar_13 + viewDir_15);
  tmpvar_18 = (inVec_19 * inversesqrt(max (0.001, 
    dot (inVec_19, inVec_19)
  )));
  float tmpvar_20;
  tmpvar_20 = max (0.0, dot (tmpvar_4, tmpvar_18));
  float tmpvar_21;
  tmpvar_21 = max (0.0, dot (tmpvar_4, viewDir_15));
  float tmpvar_22;
  tmpvar_22 = max (0.0, dot (tmpvar_13, tmpvar_18));
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
  tmpvar_34.xyz = ((tmpvar_2 * (tmpvar_12 * 
    (tmpvar_30 * tmpvar_14)
  )) + ((tmpvar_32 * tmpvar_12) * (tmpvar_3 + 
    ((1.0 - tmpvar_3) * ((x_33 * x_33) * ((x_33 * x_33) * x_33)))
  )));
  vec4 xlat_varoutput_35;
  xlat_varoutput_35.xyz = tmpvar_34.xyz;
  xlat_varoutput_35.w = 1.0;
  gl_FragData[0] = xlat_varoutput_35;
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
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform mat4 unity_World2Shadow[4];

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_WorldTransformParams;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
uniform mat4 _LightMatrix0;
attribute vec4 TANGENT;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD6;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec4 tmpvar_7;
  tmpvar_7 = (_Object2World * gl_Vertex);
  tmpvar_3 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_8;
  texcoord_8.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_9;
  if ((_UVSec == 0.0)) {
    tmpvar_9 = tmpvar_1;
  } else {
    tmpvar_9 = tmpvar_2;
  };
  texcoord_8.zw = ((tmpvar_9 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec4 v_10;
  v_10.x = _World2Object[0].x;
  v_10.y = _World2Object[1].x;
  v_10.z = _World2Object[2].x;
  v_10.w = _World2Object[3].x;
  vec4 v_11;
  v_11.x = _World2Object[0].y;
  v_11.y = _World2Object[1].y;
  v_11.z = _World2Object[2].y;
  v_11.w = _World2Object[3].y;
  vec4 v_12;
  v_12.x = _World2Object[0].z;
  v_12.y = _World2Object[1].z;
  v_12.z = _World2Object[2].z;
  v_12.w = _World2Object[3].z;
  vec3 tmpvar_13;
  tmpvar_13 = normalize(((
    (v_10.xyz * gl_Normal.x)
   + 
    (v_11.xyz * gl_Normal.y)
  ) + (v_12.xyz * gl_Normal.z)));
  mat3 tmpvar_14;
  tmpvar_14[0] = _Object2World[0].xyz;
  tmpvar_14[1] = _Object2World[1].xyz;
  tmpvar_14[2] = _Object2World[2].xyz;
  vec4 tmpvar_15;
  tmpvar_15.xyz = normalize((tmpvar_14 * TANGENT.xyz));
  tmpvar_15.w = TANGENT.w;
  vec3 tmpvar_16;
  vec3 tmpvar_17;
  tmpvar_16 = tmpvar_15.xyz;
  tmpvar_17 = (((tmpvar_13.yzx * tmpvar_15.zxy) - (tmpvar_13.zxy * tmpvar_15.yzx)) * (TANGENT.w * unity_WorldTransformParams.w));
  vec3 tmpvar_18;
  vec3 tmpvar_19;
  vec3 tmpvar_20;
  tmpvar_18.x = tmpvar_16.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = tmpvar_13.x;
  tmpvar_19.x = tmpvar_16.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = tmpvar_13.y;
  tmpvar_20.x = tmpvar_16.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = tmpvar_13.z;
  vec3 v_21;
  v_21.x = tmpvar_18.x;
  v_21.y = tmpvar_19.x;
  v_21.z = tmpvar_20.x;
  tmpvar_4.xyz = v_21;
  vec3 v_22;
  v_22.x = tmpvar_18.y;
  v_22.y = tmpvar_19.y;
  v_22.z = tmpvar_20.y;
  tmpvar_5.xyz = v_22;
  vec3 v_23;
  v_23.x = tmpvar_18.z;
  v_23.y = tmpvar_19.z;
  v_23.z = tmpvar_20.z;
  tmpvar_6.xyz = v_23;
  vec3 tmpvar_24;
  tmpvar_24 = (_WorldSpaceLightPos0.xyz - (tmpvar_7.xyz * _WorldSpaceLightPos0.w));
  tmpvar_4.w = tmpvar_24.x;
  tmpvar_5.w = tmpvar_24.y;
  tmpvar_6.w = tmpvar_24.z;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = texcoord_8;
  xlv_TEXCOORD1 = (tmpvar_7.xyz - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  vec4 tmpvar_25;
  tmpvar_25 = (_Object2World * gl_Vertex);
  xlv_TEXCOORD5 = (_LightMatrix0 * tmpvar_25);
  xlv_TEXCOORD6 = (unity_World2Shadow[0] * tmpvar_25);
}


#endif
#ifdef FRAGMENT
uniform vec4 _LightShadowData;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _LightColor0;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform sampler2DShadow _ShadowMapTexture;
uniform vec4 _ShadowOffsets[4];
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD6;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_2;
  vec3 tmpvar_3;
  tmpvar_3 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_1, vec3(_Metallic));
  tmpvar_2 = (tmpvar_1 * (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w)));
  vec3 tmpvar_4;
  tmpvar_4 = normalize(xlv_TEXCOORD2_2.xyz);
  vec3 tmpvar_5;
  tmpvar_5.x = xlv_TEXCOORD2.w;
  tmpvar_5.y = xlv_TEXCOORD2_1.w;
  tmpvar_5.z = xlv_TEXCOORD2_2.w;
  vec4 shadows_6;
  vec3 tmpvar_7;
  tmpvar_7 = (xlv_TEXCOORD6.xyz / xlv_TEXCOORD6.w);
  shadows_6.x = shadow2D (_ShadowMapTexture, (tmpvar_7 + _ShadowOffsets[0].xyz)).x;
  shadows_6.y = shadow2D (_ShadowMapTexture, (tmpvar_7 + _ShadowOffsets[1].xyz)).x;
  shadows_6.z = shadow2D (_ShadowMapTexture, (tmpvar_7 + _ShadowOffsets[2].xyz)).x;
  shadows_6.w = shadow2D (_ShadowMapTexture, (tmpvar_7 + _ShadowOffsets[3].xyz)).x;
  shadows_6 = (_LightShadowData.xxxx + (shadows_6 * (1.0 - _LightShadowData.xxxx)));
  vec3 tmpvar_8;
  vec3 tmpvar_9;
  tmpvar_9 = normalize(tmpvar_5);
  float tmpvar_10;
  tmpvar_10 = max (0.0, dot (tmpvar_4, tmpvar_9));
  tmpvar_8 = (_LightColor0.xyz * ((
    (float((xlv_TEXCOORD5.z > 0.0)) * texture2D (_LightTexture0, ((xlv_TEXCOORD5.xy / xlv_TEXCOORD5.w) + 0.5)).w)
   * texture2D (_LightTextureB0, vec2(
    dot (xlv_TEXCOORD5.xyz, xlv_TEXCOORD5.xyz)
  )).w) * dot (shadows_6, vec4(0.25, 0.25, 0.25, 0.25))));
  vec3 viewDir_11;
  viewDir_11 = -(normalize(xlv_TEXCOORD1));
  float specularTerm_12;
  float tmpvar_13;
  tmpvar_13 = (1.0 - _Glossiness);
  vec3 tmpvar_14;
  vec3 inVec_15;
  inVec_15 = (tmpvar_9 + viewDir_11);
  tmpvar_14 = (inVec_15 * inversesqrt(max (0.001, 
    dot (inVec_15, inVec_15)
  )));
  float tmpvar_16;
  tmpvar_16 = max (0.0, dot (tmpvar_4, tmpvar_14));
  float tmpvar_17;
  tmpvar_17 = max (0.0, dot (tmpvar_4, viewDir_11));
  float tmpvar_18;
  tmpvar_18 = max (0.0, dot (tmpvar_9, tmpvar_14));
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
  tmpvar_30.xyz = ((tmpvar_2 * (tmpvar_8 * 
    (tmpvar_26 * tmpvar_10)
  )) + ((tmpvar_28 * tmpvar_8) * (tmpvar_3 + 
    ((1.0 - tmpvar_3) * ((x_29 * x_29) * ((x_29 * x_29) * x_29)))
  )));
  vec4 xlat_varoutput_31;
  xlat_varoutput_31.xyz = tmpvar_30.xyz;
  xlat_varoutput_31.w = 1.0;
  gl_FragData[0] = xlat_varoutput_31;
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
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightPositionRange;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_WorldTransformParams;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
uniform mat4 _LightMatrix0;
attribute vec4 TANGENT;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD6;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec4 tmpvar_7;
  tmpvar_7 = (_Object2World * gl_Vertex);
  tmpvar_3 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_8;
  texcoord_8.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_9;
  if ((_UVSec == 0.0)) {
    tmpvar_9 = tmpvar_1;
  } else {
    tmpvar_9 = tmpvar_2;
  };
  texcoord_8.zw = ((tmpvar_9 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec4 v_10;
  v_10.x = _World2Object[0].x;
  v_10.y = _World2Object[1].x;
  v_10.z = _World2Object[2].x;
  v_10.w = _World2Object[3].x;
  vec4 v_11;
  v_11.x = _World2Object[0].y;
  v_11.y = _World2Object[1].y;
  v_11.z = _World2Object[2].y;
  v_11.w = _World2Object[3].y;
  vec4 v_12;
  v_12.x = _World2Object[0].z;
  v_12.y = _World2Object[1].z;
  v_12.z = _World2Object[2].z;
  v_12.w = _World2Object[3].z;
  vec3 tmpvar_13;
  tmpvar_13 = normalize(((
    (v_10.xyz * gl_Normal.x)
   + 
    (v_11.xyz * gl_Normal.y)
  ) + (v_12.xyz * gl_Normal.z)));
  mat3 tmpvar_14;
  tmpvar_14[0] = _Object2World[0].xyz;
  tmpvar_14[1] = _Object2World[1].xyz;
  tmpvar_14[2] = _Object2World[2].xyz;
  vec4 tmpvar_15;
  tmpvar_15.xyz = normalize((tmpvar_14 * TANGENT.xyz));
  tmpvar_15.w = TANGENT.w;
  vec3 tmpvar_16;
  vec3 tmpvar_17;
  tmpvar_16 = tmpvar_15.xyz;
  tmpvar_17 = (((tmpvar_13.yzx * tmpvar_15.zxy) - (tmpvar_13.zxy * tmpvar_15.yzx)) * (TANGENT.w * unity_WorldTransformParams.w));
  vec3 tmpvar_18;
  vec3 tmpvar_19;
  vec3 tmpvar_20;
  tmpvar_18.x = tmpvar_16.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = tmpvar_13.x;
  tmpvar_19.x = tmpvar_16.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = tmpvar_13.y;
  tmpvar_20.x = tmpvar_16.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = tmpvar_13.z;
  vec3 v_21;
  v_21.x = tmpvar_18.x;
  v_21.y = tmpvar_19.x;
  v_21.z = tmpvar_20.x;
  tmpvar_4.xyz = v_21;
  vec3 v_22;
  v_22.x = tmpvar_18.y;
  v_22.y = tmpvar_19.y;
  v_22.z = tmpvar_20.y;
  tmpvar_5.xyz = v_22;
  vec3 v_23;
  v_23.x = tmpvar_18.z;
  v_23.y = tmpvar_19.z;
  v_23.z = tmpvar_20.z;
  tmpvar_6.xyz = v_23;
  vec3 tmpvar_24;
  tmpvar_24 = (_WorldSpaceLightPos0.xyz - (tmpvar_7.xyz * _WorldSpaceLightPos0.w));
  tmpvar_4.w = tmpvar_24.x;
  tmpvar_5.w = tmpvar_24.y;
  tmpvar_6.w = tmpvar_24.z;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = texcoord_8;
  xlv_TEXCOORD1 = (tmpvar_7.xyz - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  vec4 tmpvar_25;
  tmpvar_25 = (_Object2World * gl_Vertex);
  xlv_TEXCOORD5 = (_LightMatrix0 * tmpvar_25).xyz;
  xlv_TEXCOORD6 = (tmpvar_25.xyz - _LightPositionRange.xyz);
}


#endif
#ifdef FRAGMENT
uniform vec4 _LightPositionRange;
uniform vec4 _LightShadowData;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _LightColor0;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform samplerCube _ShadowMapTexture;
uniform sampler2D _LightTexture0;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD6;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_2;
  vec3 tmpvar_3;
  tmpvar_3 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_1, vec3(_Metallic));
  tmpvar_2 = (tmpvar_1 * (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w)));
  vec3 tmpvar_4;
  tmpvar_4 = normalize(xlv_TEXCOORD2_2.xyz);
  vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD1);
  vec3 tmpvar_6;
  tmpvar_6.x = xlv_TEXCOORD2.w;
  tmpvar_6.y = xlv_TEXCOORD2_1.w;
  tmpvar_6.z = xlv_TEXCOORD2_2.w;
  vec4 tmpvar_7;
  tmpvar_7 = texture2D (_LightTexture0, vec2(dot (xlv_TEXCOORD5, xlv_TEXCOORD5)));
  vec4 shadowVals_8;
  shadowVals_8.x = textureCube (_ShadowMapTexture, (xlv_TEXCOORD6 + vec3(0.0078125, 0.0078125, 0.0078125))).x;
  shadowVals_8.y = textureCube (_ShadowMapTexture, (xlv_TEXCOORD6 + vec3(-0.0078125, -0.0078125, 0.0078125))).x;
  shadowVals_8.z = textureCube (_ShadowMapTexture, (xlv_TEXCOORD6 + vec3(-0.0078125, 0.0078125, -0.0078125))).x;
  shadowVals_8.w = textureCube (_ShadowMapTexture, (xlv_TEXCOORD6 + vec3(0.0078125, -0.0078125, -0.0078125))).x;
  bvec4 tmpvar_9;
  tmpvar_9 = lessThan (shadowVals_8, vec4(((
    sqrt(dot (xlv_TEXCOORD6, xlv_TEXCOORD6))
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
  vec3 tmpvar_16;
  vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_6);
  float tmpvar_18;
  tmpvar_18 = max (0.0, dot (tmpvar_4, tmpvar_17));
  tmpvar_16 = (_LightColor0.xyz * (tmpvar_7.w * dot (tmpvar_15, vec4(0.25, 0.25, 0.25, 0.25))));
  vec3 viewDir_19;
  viewDir_19 = -(tmpvar_5);
  float specularTerm_20;
  float tmpvar_21;
  tmpvar_21 = (1.0 - _Glossiness);
  vec3 tmpvar_22;
  vec3 inVec_23;
  inVec_23 = (tmpvar_17 + viewDir_19);
  tmpvar_22 = (inVec_23 * inversesqrt(max (0.001, 
    dot (inVec_23, inVec_23)
  )));
  float tmpvar_24;
  tmpvar_24 = max (0.0, dot (tmpvar_4, tmpvar_22));
  float tmpvar_25;
  tmpvar_25 = max (0.0, dot (tmpvar_4, viewDir_19));
  float tmpvar_26;
  tmpvar_26 = max (0.0, dot (tmpvar_17, tmpvar_22));
  float tmpvar_27;
  tmpvar_27 = (tmpvar_21 * tmpvar_21);
  float tmpvar_28;
  tmpvar_28 = (tmpvar_21 * tmpvar_21);
  float tmpvar_29;
  tmpvar_29 = (tmpvar_28 * tmpvar_28);
  float tmpvar_30;
  tmpvar_30 = (((tmpvar_24 * tmpvar_24) * (tmpvar_29 - 1.0)) + 1.0);
  float x_31;
  x_31 = (1.0 - tmpvar_18);
  float x_32;
  x_32 = (1.0 - tmpvar_25);
  float tmpvar_33;
  tmpvar_33 = (0.5 + ((2.0 * tmpvar_26) * (tmpvar_26 * tmpvar_21)));
  float tmpvar_34;
  tmpvar_34 = ((1.0 + (
    (tmpvar_33 - 1.0)
   * 
    ((x_31 * x_31) * ((x_31 * x_31) * x_31))
  )) * (1.0 + (
    (tmpvar_33 - 1.0)
   * 
    ((x_32 * x_32) * ((x_32 * x_32) * x_32))
  )));
  float tmpvar_35;
  tmpvar_35 = (((
    (2.0 * tmpvar_18)
   / 
    (((tmpvar_18 * (
      (tmpvar_25 * (1.0 - tmpvar_27))
     + tmpvar_27)) + (tmpvar_25 * (
      (tmpvar_18 * (1.0 - tmpvar_27))
     + tmpvar_27))) + 1e-05)
  ) * (tmpvar_29 / 
    ((3.141593 * tmpvar_30) * tmpvar_30)
  )) * 0.7853982);
  specularTerm_20 = tmpvar_35;
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    specularTerm_20 = sqrt(max (0.0001, tmpvar_35));
  };
  float tmpvar_36;
  tmpvar_36 = max (0.0, (specularTerm_20 * tmpvar_18));
  specularTerm_20 = tmpvar_36;
  float x_37;
  x_37 = (1.0 - tmpvar_26);
  vec4 tmpvar_38;
  tmpvar_38.w = 1.0;
  tmpvar_38.xyz = ((tmpvar_2 * (tmpvar_16 * 
    (tmpvar_34 * tmpvar_18)
  )) + ((tmpvar_36 * tmpvar_16) * (tmpvar_3 + 
    ((1.0 - tmpvar_3) * ((x_37 * x_37) * ((x_37 * x_37) * x_37)))
  )));
  vec4 xlat_varoutput_39;
  xlat_varoutput_39.xyz = tmpvar_38.xyz;
  xlat_varoutput_39.w = 1.0;
  gl_FragData[0] = xlat_varoutput_39;
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
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightPositionRange;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_WorldTransformParams;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
uniform mat4 _LightMatrix0;
attribute vec4 TANGENT;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD6;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec4 tmpvar_7;
  tmpvar_7 = (_Object2World * gl_Vertex);
  tmpvar_3 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_8;
  texcoord_8.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_9;
  if ((_UVSec == 0.0)) {
    tmpvar_9 = tmpvar_1;
  } else {
    tmpvar_9 = tmpvar_2;
  };
  texcoord_8.zw = ((tmpvar_9 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec4 v_10;
  v_10.x = _World2Object[0].x;
  v_10.y = _World2Object[1].x;
  v_10.z = _World2Object[2].x;
  v_10.w = _World2Object[3].x;
  vec4 v_11;
  v_11.x = _World2Object[0].y;
  v_11.y = _World2Object[1].y;
  v_11.z = _World2Object[2].y;
  v_11.w = _World2Object[3].y;
  vec4 v_12;
  v_12.x = _World2Object[0].z;
  v_12.y = _World2Object[1].z;
  v_12.z = _World2Object[2].z;
  v_12.w = _World2Object[3].z;
  vec3 tmpvar_13;
  tmpvar_13 = normalize(((
    (v_10.xyz * gl_Normal.x)
   + 
    (v_11.xyz * gl_Normal.y)
  ) + (v_12.xyz * gl_Normal.z)));
  mat3 tmpvar_14;
  tmpvar_14[0] = _Object2World[0].xyz;
  tmpvar_14[1] = _Object2World[1].xyz;
  tmpvar_14[2] = _Object2World[2].xyz;
  vec4 tmpvar_15;
  tmpvar_15.xyz = normalize((tmpvar_14 * TANGENT.xyz));
  tmpvar_15.w = TANGENT.w;
  vec3 tmpvar_16;
  vec3 tmpvar_17;
  tmpvar_16 = tmpvar_15.xyz;
  tmpvar_17 = (((tmpvar_13.yzx * tmpvar_15.zxy) - (tmpvar_13.zxy * tmpvar_15.yzx)) * (TANGENT.w * unity_WorldTransformParams.w));
  vec3 tmpvar_18;
  vec3 tmpvar_19;
  vec3 tmpvar_20;
  tmpvar_18.x = tmpvar_16.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = tmpvar_13.x;
  tmpvar_19.x = tmpvar_16.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = tmpvar_13.y;
  tmpvar_20.x = tmpvar_16.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = tmpvar_13.z;
  vec3 v_21;
  v_21.x = tmpvar_18.x;
  v_21.y = tmpvar_19.x;
  v_21.z = tmpvar_20.x;
  tmpvar_4.xyz = v_21;
  vec3 v_22;
  v_22.x = tmpvar_18.y;
  v_22.y = tmpvar_19.y;
  v_22.z = tmpvar_20.y;
  tmpvar_5.xyz = v_22;
  vec3 v_23;
  v_23.x = tmpvar_18.z;
  v_23.y = tmpvar_19.z;
  v_23.z = tmpvar_20.z;
  tmpvar_6.xyz = v_23;
  vec3 tmpvar_24;
  tmpvar_24 = (_WorldSpaceLightPos0.xyz - (tmpvar_7.xyz * _WorldSpaceLightPos0.w));
  tmpvar_4.w = tmpvar_24.x;
  tmpvar_5.w = tmpvar_24.y;
  tmpvar_6.w = tmpvar_24.z;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = texcoord_8;
  xlv_TEXCOORD1 = (tmpvar_7.xyz - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  vec4 tmpvar_25;
  tmpvar_25 = (_Object2World * gl_Vertex);
  xlv_TEXCOORD5 = (_LightMatrix0 * tmpvar_25).xyz;
  xlv_TEXCOORD6 = (tmpvar_25.xyz - _LightPositionRange.xyz);
}


#endif
#ifdef FRAGMENT
uniform vec4 _LightPositionRange;
uniform vec4 _LightShadowData;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _LightColor0;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform samplerCube _ShadowMapTexture;
uniform samplerCube _LightTexture0;
uniform sampler2D _LightTextureB0;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD6;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_2;
  vec3 tmpvar_3;
  tmpvar_3 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_1, vec3(_Metallic));
  tmpvar_2 = (tmpvar_1 * (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w)));
  vec3 tmpvar_4;
  tmpvar_4 = normalize(xlv_TEXCOORD2_2.xyz);
  vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD1);
  vec3 tmpvar_6;
  tmpvar_6.x = xlv_TEXCOORD2.w;
  tmpvar_6.y = xlv_TEXCOORD2_1.w;
  tmpvar_6.z = xlv_TEXCOORD2_2.w;
  vec4 tmpvar_7;
  tmpvar_7 = texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD5, xlv_TEXCOORD5)));
  vec4 tmpvar_8;
  tmpvar_8 = textureCube (_LightTexture0, xlv_TEXCOORD5);
  vec4 shadowVals_9;
  shadowVals_9.x = textureCube (_ShadowMapTexture, (xlv_TEXCOORD6 + vec3(0.0078125, 0.0078125, 0.0078125))).x;
  shadowVals_9.y = textureCube (_ShadowMapTexture, (xlv_TEXCOORD6 + vec3(-0.0078125, -0.0078125, 0.0078125))).x;
  shadowVals_9.z = textureCube (_ShadowMapTexture, (xlv_TEXCOORD6 + vec3(-0.0078125, 0.0078125, -0.0078125))).x;
  shadowVals_9.w = textureCube (_ShadowMapTexture, (xlv_TEXCOORD6 + vec3(0.0078125, -0.0078125, -0.0078125))).x;
  bvec4 tmpvar_10;
  tmpvar_10 = lessThan (shadowVals_9, vec4(((
    sqrt(dot (xlv_TEXCOORD6, xlv_TEXCOORD6))
   * _LightPositionRange.w) * 0.97)));
  vec4 tmpvar_11;
  tmpvar_11 = _LightShadowData.xxxx;
  float tmpvar_12;
  if (tmpvar_10.x) {
    tmpvar_12 = tmpvar_11.x;
  } else {
    tmpvar_12 = 1.0;
  };
  float tmpvar_13;
  if (tmpvar_10.y) {
    tmpvar_13 = tmpvar_11.y;
  } else {
    tmpvar_13 = 1.0;
  };
  float tmpvar_14;
  if (tmpvar_10.z) {
    tmpvar_14 = tmpvar_11.z;
  } else {
    tmpvar_14 = 1.0;
  };
  float tmpvar_15;
  if (tmpvar_10.w) {
    tmpvar_15 = tmpvar_11.w;
  } else {
    tmpvar_15 = 1.0;
  };
  vec4 tmpvar_16;
  tmpvar_16.x = tmpvar_12;
  tmpvar_16.y = tmpvar_13;
  tmpvar_16.z = tmpvar_14;
  tmpvar_16.w = tmpvar_15;
  vec3 tmpvar_17;
  vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_6);
  float tmpvar_19;
  tmpvar_19 = max (0.0, dot (tmpvar_4, tmpvar_18));
  tmpvar_17 = (_LightColor0.xyz * ((tmpvar_7.w * tmpvar_8.w) * dot (tmpvar_16, vec4(0.25, 0.25, 0.25, 0.25))));
  vec3 viewDir_20;
  viewDir_20 = -(tmpvar_5);
  float specularTerm_21;
  float tmpvar_22;
  tmpvar_22 = (1.0 - _Glossiness);
  vec3 tmpvar_23;
  vec3 inVec_24;
  inVec_24 = (tmpvar_18 + viewDir_20);
  tmpvar_23 = (inVec_24 * inversesqrt(max (0.001, 
    dot (inVec_24, inVec_24)
  )));
  float tmpvar_25;
  tmpvar_25 = max (0.0, dot (tmpvar_4, tmpvar_23));
  float tmpvar_26;
  tmpvar_26 = max (0.0, dot (tmpvar_4, viewDir_20));
  float tmpvar_27;
  tmpvar_27 = max (0.0, dot (tmpvar_18, tmpvar_23));
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
  tmpvar_39.xyz = ((tmpvar_2 * (tmpvar_17 * 
    (tmpvar_35 * tmpvar_19)
  )) + ((tmpvar_37 * tmpvar_17) * (tmpvar_3 + 
    ((1.0 - tmpvar_3) * ((x_38 * x_38) * ((x_38 * x_38) * x_38)))
  )));
  vec4 xlat_varoutput_40;
  xlat_varoutput_40.xyz = tmpvar_39.xyz;
  xlat_varoutput_40.w = 1.0;
  gl_FragData[0] = xlat_varoutput_40;
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
  Name "SHADOWCASTER"
  Tags { "LIGHTMODE"="SHADOWCASTER" "SHADOWSUPPORT"="true" "RenderType"="Opaque" "PerformanceChecks"="False" }
  GpuProgramID 147192
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
}
 }
 Pass {
  Name "DEFERRED"
  Tags { "LIGHTMODE"="Deferred" "RenderType"="Opaque" "PerformanceChecks"="False" }
  GpuProgramID 219902
Program "vp" {
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 120

#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD6;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec4 tmpvar_7;
  vec4 tmpvar_8;
  tmpvar_8 = (_Object2World * gl_Vertex);
  vec3 tmpvar_9;
  tmpvar_9 = tmpvar_8.xyz;
  tmpvar_3 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_10;
  texcoord_10.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_11;
  if ((_UVSec == 0.0)) {
    tmpvar_11 = tmpvar_1;
  } else {
    tmpvar_11 = tmpvar_2;
  };
  texcoord_10.zw = ((tmpvar_11 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec3 n_12;
  n_12 = (tmpvar_8.xyz - _WorldSpaceCameraPos);
  vec4 v_13;
  v_13.x = _World2Object[0].x;
  v_13.y = _World2Object[1].x;
  v_13.z = _World2Object[2].x;
  v_13.w = _World2Object[3].x;
  vec4 v_14;
  v_14.x = _World2Object[0].y;
  v_14.y = _World2Object[1].y;
  v_14.z = _World2Object[2].y;
  v_14.w = _World2Object[3].y;
  vec4 v_15;
  v_15.x = _World2Object[0].z;
  v_15.y = _World2Object[1].z;
  v_15.z = _World2Object[2].z;
  v_15.w = _World2Object[3].z;
  vec3 tmpvar_16;
  tmpvar_16 = normalize(((
    (v_13.xyz * gl_Normal.x)
   + 
    (v_14.xyz * gl_Normal.y)
  ) + (v_15.xyz * gl_Normal.z)));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_16;
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  vec3 ambient_17;
  ambient_17 = vec3(0.0, 0.0, 0.0);
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    ambient_17 = vec3(0.0, 0.0, 0.0);
  };
  vec3 x1_18;
  vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_16.xyzz * tmpvar_16.yzzx);
  x1_18.x = dot (unity_SHBr, tmpvar_19);
  x1_18.y = dot (unity_SHBg, tmpvar_19);
  x1_18.z = dot (unity_SHBb, tmpvar_19);
  ambient_17 = (ambient_17 + (x1_18 + (unity_SHC.xyz * 
    ((tmpvar_16.x * tmpvar_16.x) - (tmpvar_16.y * tmpvar_16.y))
  )));
  tmpvar_7.xyz = ambient_17;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = texcoord_10;
  xlv_TEXCOORD1 = n_12;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform float _OcclusionStrength;
varying vec4 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1.x = _Metallic;
  tmpvar_1.y = _Glossiness;
  float tmpvar_2;
  tmpvar_2 = tmpvar_1.y;
  vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_4;
  vec3 tmpvar_5;
  tmpvar_5 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_3, vec3(_Metallic));
  tmpvar_4 = (tmpvar_3 * (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w)));
  vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD2_2.xyz);
  float tmpvar_7;
  tmpvar_7 = ((1.0 - _OcclusionStrength) + (texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y * _OcclusionStrength));
  vec3 tmpvar_8;
  tmpvar_8 = vec3(0.0, 0.0, 0.0);
  vec3 ambient_9;
  vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_6;
  vec3 x_11;
  x_11.x = dot (unity_SHAr, tmpvar_10);
  x_11.y = dot (unity_SHAg, tmpvar_10);
  x_11.z = dot (unity_SHAb, tmpvar_10);
  ambient_9 = (xlv_TEXCOORD5.xyz + x_11);
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    ambient_9 = max (((1.055 * 
      pow (max (ambient_9, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
    ) - 0.055), vec3(0.0, 0.0, 0.0));
  };
  tmpvar_8 = (ambient_9 * tmpvar_7);
  vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = (tmpvar_4 * tmpvar_8);
  vec4 tmpvar_13;
  tmpvar_13.xyz = tmpvar_4;
  tmpvar_13.w = tmpvar_7;
  vec4 tmpvar_14;
  tmpvar_14.xyz = tmpvar_5;
  tmpvar_14.w = tmpvar_2;
  vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = ((tmpvar_6 * 0.5) + 0.5);
  vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = exp2(-(tmpvar_12.xyz));
  gl_FragData[0] = tmpvar_13;
  gl_FragData[1] = tmpvar_14;
  gl_FragData[2] = tmpvar_15;
  gl_FragData[3] = tmpvar_16;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "_EMISSION" }
"#version 120

#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD6;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec4 tmpvar_7;
  vec4 tmpvar_8;
  tmpvar_8 = (_Object2World * gl_Vertex);
  vec3 tmpvar_9;
  tmpvar_9 = tmpvar_8.xyz;
  tmpvar_3 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_10;
  texcoord_10.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_11;
  if ((_UVSec == 0.0)) {
    tmpvar_11 = tmpvar_1;
  } else {
    tmpvar_11 = tmpvar_2;
  };
  texcoord_10.zw = ((tmpvar_11 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec3 n_12;
  n_12 = (tmpvar_8.xyz - _WorldSpaceCameraPos);
  vec4 v_13;
  v_13.x = _World2Object[0].x;
  v_13.y = _World2Object[1].x;
  v_13.z = _World2Object[2].x;
  v_13.w = _World2Object[3].x;
  vec4 v_14;
  v_14.x = _World2Object[0].y;
  v_14.y = _World2Object[1].y;
  v_14.z = _World2Object[2].y;
  v_14.w = _World2Object[3].y;
  vec4 v_15;
  v_15.x = _World2Object[0].z;
  v_15.y = _World2Object[1].z;
  v_15.z = _World2Object[2].z;
  v_15.w = _World2Object[3].z;
  vec3 tmpvar_16;
  tmpvar_16 = normalize(((
    (v_13.xyz * gl_Normal.x)
   + 
    (v_14.xyz * gl_Normal.y)
  ) + (v_15.xyz * gl_Normal.z)));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_16;
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  vec3 ambient_17;
  ambient_17 = vec3(0.0, 0.0, 0.0);
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    ambient_17 = vec3(0.0, 0.0, 0.0);
  };
  vec3 x1_18;
  vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_16.xyzz * tmpvar_16.yzzx);
  x1_18.x = dot (unity_SHBr, tmpvar_19);
  x1_18.y = dot (unity_SHBg, tmpvar_19);
  x1_18.z = dot (unity_SHBb, tmpvar_19);
  ambient_17 = (ambient_17 + (x1_18 + (unity_SHC.xyz * 
    ((tmpvar_16.x * tmpvar_16.x) - (tmpvar_16.y * tmpvar_16.y))
  )));
  tmpvar_7.xyz = ambient_17;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = texcoord_10;
  xlv_TEXCOORD1 = n_12;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform float _OcclusionStrength;
uniform vec4 _EmissionColor;
uniform sampler2D _EmissionMap;
varying vec4 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
void main ()
{
  vec3 color_1;
  vec2 tmpvar_2;
  tmpvar_2.x = _Metallic;
  tmpvar_2.y = _Glossiness;
  float tmpvar_3;
  tmpvar_3 = tmpvar_2.y;
  vec3 tmpvar_4;
  tmpvar_4 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_5;
  vec3 tmpvar_6;
  tmpvar_6 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_4, vec3(_Metallic));
  tmpvar_5 = (tmpvar_4 * (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w)));
  vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD2_2.xyz);
  float tmpvar_8;
  tmpvar_8 = ((1.0 - _OcclusionStrength) + (texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y * _OcclusionStrength));
  vec3 tmpvar_9;
  tmpvar_9 = vec3(0.0, 0.0, 0.0);
  vec3 ambient_10;
  vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_7;
  vec3 x_12;
  x_12.x = dot (unity_SHAr, tmpvar_11);
  x_12.y = dot (unity_SHAg, tmpvar_11);
  x_12.z = dot (unity_SHAb, tmpvar_11);
  ambient_10 = (xlv_TEXCOORD5.xyz + x_12);
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    ambient_10 = max (((1.055 * 
      pow (max (ambient_10, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
    ) - 0.055), vec3(0.0, 0.0, 0.0));
  };
  tmpvar_9 = (ambient_10 * tmpvar_8);
  vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = (tmpvar_5 * tmpvar_9);
  color_1 = (tmpvar_13.xyz + (texture2D (_EmissionMap, xlv_TEXCOORD0.xy).xyz * _EmissionColor.xyz));
  color_1 = exp2(-(color_1));
  vec4 tmpvar_14;
  tmpvar_14.xyz = tmpvar_5;
  tmpvar_14.w = tmpvar_8;
  vec4 tmpvar_15;
  tmpvar_15.xyz = tmpvar_6;
  tmpvar_15.w = tmpvar_3;
  vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = ((tmpvar_7 * 0.5) + 0.5);
  vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = color_1;
  gl_FragData[0] = tmpvar_14;
  gl_FragData[1] = tmpvar_15;
  gl_FragData[2] = tmpvar_16;
  gl_FragData[3] = tmpvar_17;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "_EMISSION" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "_EMISSION" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_OFF" }
"#version 120

#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_WorldTransformParams;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
attribute vec4 TANGENT;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD6;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec4 tmpvar_7;
  vec4 tmpvar_8;
  tmpvar_8 = (_Object2World * gl_Vertex);
  vec3 tmpvar_9;
  tmpvar_9 = tmpvar_8.xyz;
  tmpvar_3 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_10;
  texcoord_10.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_11;
  if ((_UVSec == 0.0)) {
    tmpvar_11 = tmpvar_1;
  } else {
    tmpvar_11 = tmpvar_2;
  };
  texcoord_10.zw = ((tmpvar_11 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec3 n_12;
  n_12 = (tmpvar_8.xyz - _WorldSpaceCameraPos);
  vec4 v_13;
  v_13.x = _World2Object[0].x;
  v_13.y = _World2Object[1].x;
  v_13.z = _World2Object[2].x;
  v_13.w = _World2Object[3].x;
  vec4 v_14;
  v_14.x = _World2Object[0].y;
  v_14.y = _World2Object[1].y;
  v_14.z = _World2Object[2].y;
  v_14.w = _World2Object[3].y;
  vec4 v_15;
  v_15.x = _World2Object[0].z;
  v_15.y = _World2Object[1].z;
  v_15.z = _World2Object[2].z;
  v_15.w = _World2Object[3].z;
  vec3 tmpvar_16;
  tmpvar_16 = normalize(((
    (v_13.xyz * gl_Normal.x)
   + 
    (v_14.xyz * gl_Normal.y)
  ) + (v_15.xyz * gl_Normal.z)));
  mat3 tmpvar_17;
  tmpvar_17[0] = _Object2World[0].xyz;
  tmpvar_17[1] = _Object2World[1].xyz;
  tmpvar_17[2] = _Object2World[2].xyz;
  vec4 tmpvar_18;
  tmpvar_18.xyz = normalize((tmpvar_17 * TANGENT.xyz));
  tmpvar_18.w = TANGENT.w;
  vec3 tmpvar_19;
  vec3 tmpvar_20;
  tmpvar_19 = tmpvar_18.xyz;
  tmpvar_20 = (((tmpvar_16.yzx * tmpvar_18.zxy) - (tmpvar_16.zxy * tmpvar_18.yzx)) * (TANGENT.w * unity_WorldTransformParams.w));
  vec3 tmpvar_21;
  vec3 tmpvar_22;
  vec3 tmpvar_23;
  tmpvar_21.x = tmpvar_19.x;
  tmpvar_21.y = tmpvar_20.x;
  tmpvar_21.z = tmpvar_16.x;
  tmpvar_22.x = tmpvar_19.y;
  tmpvar_22.y = tmpvar_20.y;
  tmpvar_22.z = tmpvar_16.y;
  tmpvar_23.x = tmpvar_19.z;
  tmpvar_23.y = tmpvar_20.z;
  tmpvar_23.z = tmpvar_16.z;
  vec3 v_24;
  v_24.x = tmpvar_21.x;
  v_24.y = tmpvar_22.x;
  v_24.z = tmpvar_23.x;
  tmpvar_4.xyz = v_24;
  vec3 v_25;
  v_25.x = tmpvar_21.y;
  v_25.y = tmpvar_22.y;
  v_25.z = tmpvar_23.y;
  tmpvar_5.xyz = v_25;
  vec3 v_26;
  v_26.x = tmpvar_21.z;
  v_26.y = tmpvar_22.z;
  v_26.z = tmpvar_23.z;
  tmpvar_6.xyz = v_26;
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  vec3 ambient_27;
  ambient_27 = vec3(0.0, 0.0, 0.0);
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    ambient_27 = vec3(0.0, 0.0, 0.0);
  };
  vec3 x1_28;
  vec4 tmpvar_29;
  tmpvar_29 = (tmpvar_16.xyzz * tmpvar_16.yzzx);
  x1_28.x = dot (unity_SHBr, tmpvar_29);
  x1_28.y = dot (unity_SHBg, tmpvar_29);
  x1_28.z = dot (unity_SHBb, tmpvar_29);
  ambient_27 = (ambient_27 + (x1_28 + (unity_SHC.xyz * 
    ((tmpvar_16.x * tmpvar_16.x) - (tmpvar_16.y * tmpvar_16.y))
  )));
  tmpvar_7.xyz = ambient_27;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = texcoord_10;
  xlv_TEXCOORD1 = n_12;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform float _OcclusionStrength;
varying vec4 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1.x = _Metallic;
  tmpvar_1.y = _Glossiness;
  float tmpvar_2;
  tmpvar_2 = tmpvar_1.y;
  vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_4;
  vec3 tmpvar_5;
  tmpvar_5 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_3, vec3(_Metallic));
  tmpvar_4 = (tmpvar_3 * (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w)));
  vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD2_2.xyz);
  float tmpvar_7;
  tmpvar_7 = ((1.0 - _OcclusionStrength) + (texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y * _OcclusionStrength));
  vec3 tmpvar_8;
  tmpvar_8 = vec3(0.0, 0.0, 0.0);
  vec3 ambient_9;
  vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_6;
  vec3 x_11;
  x_11.x = dot (unity_SHAr, tmpvar_10);
  x_11.y = dot (unity_SHAg, tmpvar_10);
  x_11.z = dot (unity_SHAb, tmpvar_10);
  ambient_9 = (xlv_TEXCOORD5.xyz + x_11);
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    ambient_9 = max (((1.055 * 
      pow (max (ambient_9, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
    ) - 0.055), vec3(0.0, 0.0, 0.0));
  };
  tmpvar_8 = (ambient_9 * tmpvar_7);
  vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = (tmpvar_4 * tmpvar_8);
  vec4 tmpvar_13;
  tmpvar_13.xyz = tmpvar_4;
  tmpvar_13.w = tmpvar_7;
  vec4 tmpvar_14;
  tmpvar_14.xyz = tmpvar_5;
  tmpvar_14.w = tmpvar_2;
  vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = ((tmpvar_6 * 0.5) + 0.5);
  vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = exp2(-(tmpvar_12.xyz));
  gl_FragData[0] = tmpvar_13;
  gl_FragData[1] = tmpvar_14;
  gl_FragData[2] = tmpvar_15;
  gl_FragData[3] = tmpvar_16;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_OFF" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_OFF" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_OFF" "_EMISSION" }
"#version 120

#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_WorldTransformParams;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
attribute vec4 TANGENT;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD6;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec4 tmpvar_7;
  vec4 tmpvar_8;
  tmpvar_8 = (_Object2World * gl_Vertex);
  vec3 tmpvar_9;
  tmpvar_9 = tmpvar_8.xyz;
  tmpvar_3 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_10;
  texcoord_10.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_11;
  if ((_UVSec == 0.0)) {
    tmpvar_11 = tmpvar_1;
  } else {
    tmpvar_11 = tmpvar_2;
  };
  texcoord_10.zw = ((tmpvar_11 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec3 n_12;
  n_12 = (tmpvar_8.xyz - _WorldSpaceCameraPos);
  vec4 v_13;
  v_13.x = _World2Object[0].x;
  v_13.y = _World2Object[1].x;
  v_13.z = _World2Object[2].x;
  v_13.w = _World2Object[3].x;
  vec4 v_14;
  v_14.x = _World2Object[0].y;
  v_14.y = _World2Object[1].y;
  v_14.z = _World2Object[2].y;
  v_14.w = _World2Object[3].y;
  vec4 v_15;
  v_15.x = _World2Object[0].z;
  v_15.y = _World2Object[1].z;
  v_15.z = _World2Object[2].z;
  v_15.w = _World2Object[3].z;
  vec3 tmpvar_16;
  tmpvar_16 = normalize(((
    (v_13.xyz * gl_Normal.x)
   + 
    (v_14.xyz * gl_Normal.y)
  ) + (v_15.xyz * gl_Normal.z)));
  mat3 tmpvar_17;
  tmpvar_17[0] = _Object2World[0].xyz;
  tmpvar_17[1] = _Object2World[1].xyz;
  tmpvar_17[2] = _Object2World[2].xyz;
  vec4 tmpvar_18;
  tmpvar_18.xyz = normalize((tmpvar_17 * TANGENT.xyz));
  tmpvar_18.w = TANGENT.w;
  vec3 tmpvar_19;
  vec3 tmpvar_20;
  tmpvar_19 = tmpvar_18.xyz;
  tmpvar_20 = (((tmpvar_16.yzx * tmpvar_18.zxy) - (tmpvar_16.zxy * tmpvar_18.yzx)) * (TANGENT.w * unity_WorldTransformParams.w));
  vec3 tmpvar_21;
  vec3 tmpvar_22;
  vec3 tmpvar_23;
  tmpvar_21.x = tmpvar_19.x;
  tmpvar_21.y = tmpvar_20.x;
  tmpvar_21.z = tmpvar_16.x;
  tmpvar_22.x = tmpvar_19.y;
  tmpvar_22.y = tmpvar_20.y;
  tmpvar_22.z = tmpvar_16.y;
  tmpvar_23.x = tmpvar_19.z;
  tmpvar_23.y = tmpvar_20.z;
  tmpvar_23.z = tmpvar_16.z;
  vec3 v_24;
  v_24.x = tmpvar_21.x;
  v_24.y = tmpvar_22.x;
  v_24.z = tmpvar_23.x;
  tmpvar_4.xyz = v_24;
  vec3 v_25;
  v_25.x = tmpvar_21.y;
  v_25.y = tmpvar_22.y;
  v_25.z = tmpvar_23.y;
  tmpvar_5.xyz = v_25;
  vec3 v_26;
  v_26.x = tmpvar_21.z;
  v_26.y = tmpvar_22.z;
  v_26.z = tmpvar_23.z;
  tmpvar_6.xyz = v_26;
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  vec3 ambient_27;
  ambient_27 = vec3(0.0, 0.0, 0.0);
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    ambient_27 = vec3(0.0, 0.0, 0.0);
  };
  vec3 x1_28;
  vec4 tmpvar_29;
  tmpvar_29 = (tmpvar_16.xyzz * tmpvar_16.yzzx);
  x1_28.x = dot (unity_SHBr, tmpvar_29);
  x1_28.y = dot (unity_SHBg, tmpvar_29);
  x1_28.z = dot (unity_SHBb, tmpvar_29);
  ambient_27 = (ambient_27 + (x1_28 + (unity_SHC.xyz * 
    ((tmpvar_16.x * tmpvar_16.x) - (tmpvar_16.y * tmpvar_16.y))
  )));
  tmpvar_7.xyz = ambient_27;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = texcoord_10;
  xlv_TEXCOORD1 = n_12;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform float _OcclusionStrength;
uniform vec4 _EmissionColor;
uniform sampler2D _EmissionMap;
varying vec4 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
void main ()
{
  vec3 color_1;
  vec2 tmpvar_2;
  tmpvar_2.x = _Metallic;
  tmpvar_2.y = _Glossiness;
  float tmpvar_3;
  tmpvar_3 = tmpvar_2.y;
  vec3 tmpvar_4;
  tmpvar_4 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_5;
  vec3 tmpvar_6;
  tmpvar_6 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_4, vec3(_Metallic));
  tmpvar_5 = (tmpvar_4 * (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w)));
  vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD2_2.xyz);
  float tmpvar_8;
  tmpvar_8 = ((1.0 - _OcclusionStrength) + (texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y * _OcclusionStrength));
  vec3 tmpvar_9;
  tmpvar_9 = vec3(0.0, 0.0, 0.0);
  vec3 ambient_10;
  vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_7;
  vec3 x_12;
  x_12.x = dot (unity_SHAr, tmpvar_11);
  x_12.y = dot (unity_SHAg, tmpvar_11);
  x_12.z = dot (unity_SHAb, tmpvar_11);
  ambient_10 = (xlv_TEXCOORD5.xyz + x_12);
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    ambient_10 = max (((1.055 * 
      pow (max (ambient_10, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
    ) - 0.055), vec3(0.0, 0.0, 0.0));
  };
  tmpvar_9 = (ambient_10 * tmpvar_8);
  vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = (tmpvar_5 * tmpvar_9);
  color_1 = (tmpvar_13.xyz + (texture2D (_EmissionMap, xlv_TEXCOORD0.xy).xyz * _EmissionColor.xyz));
  color_1 = exp2(-(color_1));
  vec4 tmpvar_14;
  tmpvar_14.xyz = tmpvar_5;
  tmpvar_14.w = tmpvar_8;
  vec4 tmpvar_15;
  tmpvar_15.xyz = tmpvar_6;
  tmpvar_15.w = tmpvar_3;
  vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = ((tmpvar_7 * 0.5) + 0.5);
  vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = color_1;
  gl_FragData[0] = tmpvar_14;
  gl_FragData[1] = tmpvar_15;
  gl_FragData[2] = tmpvar_16;
  gl_FragData[3] = tmpvar_17;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_OFF" "_EMISSION" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_OFF" "_EMISSION" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_SEPARATE" "DYNAMICLIGHTMAP_OFF" }
"#version 120

#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_WorldTransformParams;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
attribute vec4 TANGENT;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD6;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec4 tmpvar_7;
  vec4 tmpvar_8;
  tmpvar_8 = (_Object2World * gl_Vertex);
  vec3 tmpvar_9;
  tmpvar_9 = tmpvar_8.xyz;
  tmpvar_3 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_10;
  texcoord_10.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_11;
  if ((_UVSec == 0.0)) {
    tmpvar_11 = tmpvar_1;
  } else {
    tmpvar_11 = tmpvar_2;
  };
  texcoord_10.zw = ((tmpvar_11 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec3 n_12;
  n_12 = (tmpvar_8.xyz - _WorldSpaceCameraPos);
  vec4 v_13;
  v_13.x = _World2Object[0].x;
  v_13.y = _World2Object[1].x;
  v_13.z = _World2Object[2].x;
  v_13.w = _World2Object[3].x;
  vec4 v_14;
  v_14.x = _World2Object[0].y;
  v_14.y = _World2Object[1].y;
  v_14.z = _World2Object[2].y;
  v_14.w = _World2Object[3].y;
  vec4 v_15;
  v_15.x = _World2Object[0].z;
  v_15.y = _World2Object[1].z;
  v_15.z = _World2Object[2].z;
  v_15.w = _World2Object[3].z;
  vec3 tmpvar_16;
  tmpvar_16 = normalize(((
    (v_13.xyz * gl_Normal.x)
   + 
    (v_14.xyz * gl_Normal.y)
  ) + (v_15.xyz * gl_Normal.z)));
  mat3 tmpvar_17;
  tmpvar_17[0] = _Object2World[0].xyz;
  tmpvar_17[1] = _Object2World[1].xyz;
  tmpvar_17[2] = _Object2World[2].xyz;
  vec4 tmpvar_18;
  tmpvar_18.xyz = normalize((tmpvar_17 * TANGENT.xyz));
  tmpvar_18.w = TANGENT.w;
  vec3 tmpvar_19;
  vec3 tmpvar_20;
  tmpvar_19 = tmpvar_18.xyz;
  tmpvar_20 = (((tmpvar_16.yzx * tmpvar_18.zxy) - (tmpvar_16.zxy * tmpvar_18.yzx)) * (TANGENT.w * unity_WorldTransformParams.w));
  vec3 tmpvar_21;
  vec3 tmpvar_22;
  vec3 tmpvar_23;
  tmpvar_21.x = tmpvar_19.x;
  tmpvar_21.y = tmpvar_20.x;
  tmpvar_21.z = tmpvar_16.x;
  tmpvar_22.x = tmpvar_19.y;
  tmpvar_22.y = tmpvar_20.y;
  tmpvar_22.z = tmpvar_16.y;
  tmpvar_23.x = tmpvar_19.z;
  tmpvar_23.y = tmpvar_20.z;
  tmpvar_23.z = tmpvar_16.z;
  vec3 v_24;
  v_24.x = tmpvar_21.x;
  v_24.y = tmpvar_22.x;
  v_24.z = tmpvar_23.x;
  tmpvar_4.xyz = v_24;
  vec3 v_25;
  v_25.x = tmpvar_21.y;
  v_25.y = tmpvar_22.y;
  v_25.z = tmpvar_23.y;
  tmpvar_5.xyz = v_25;
  vec3 v_26;
  v_26.x = tmpvar_21.z;
  v_26.y = tmpvar_22.z;
  v_26.z = tmpvar_23.z;
  tmpvar_6.xyz = v_26;
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  vec3 ambient_27;
  ambient_27 = vec3(0.0, 0.0, 0.0);
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    ambient_27 = vec3(0.0, 0.0, 0.0);
  };
  vec3 x1_28;
  vec4 tmpvar_29;
  tmpvar_29 = (tmpvar_16.xyzz * tmpvar_16.yzzx);
  x1_28.x = dot (unity_SHBr, tmpvar_29);
  x1_28.y = dot (unity_SHBg, tmpvar_29);
  x1_28.z = dot (unity_SHBb, tmpvar_29);
  ambient_27 = (ambient_27 + (x1_28 + (unity_SHC.xyz * 
    ((tmpvar_16.x * tmpvar_16.x) - (tmpvar_16.y * tmpvar_16.y))
  )));
  tmpvar_7.xyz = ambient_27;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = texcoord_10;
  xlv_TEXCOORD1 = n_12;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform float _OcclusionStrength;
varying vec4 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1.x = _Metallic;
  tmpvar_1.y = _Glossiness;
  float tmpvar_2;
  tmpvar_2 = tmpvar_1.y;
  vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_4;
  vec3 tmpvar_5;
  tmpvar_5 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_3, vec3(_Metallic));
  tmpvar_4 = (tmpvar_3 * (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w)));
  vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD2_2.xyz);
  float tmpvar_7;
  tmpvar_7 = ((1.0 - _OcclusionStrength) + (texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y * _OcclusionStrength));
  vec3 tmpvar_8;
  tmpvar_8 = vec3(0.0, 0.0, 0.0);
  vec3 ambient_9;
  vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_6;
  vec3 x_11;
  x_11.x = dot (unity_SHAr, tmpvar_10);
  x_11.y = dot (unity_SHAg, tmpvar_10);
  x_11.z = dot (unity_SHAb, tmpvar_10);
  ambient_9 = (xlv_TEXCOORD5.xyz + x_11);
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    ambient_9 = max (((1.055 * 
      pow (max (ambient_9, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
    ) - 0.055), vec3(0.0, 0.0, 0.0));
  };
  tmpvar_8 = (ambient_9 * tmpvar_7);
  vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = (tmpvar_4 * tmpvar_8);
  vec4 tmpvar_13;
  tmpvar_13.xyz = tmpvar_4;
  tmpvar_13.w = tmpvar_7;
  vec4 tmpvar_14;
  tmpvar_14.xyz = tmpvar_5;
  tmpvar_14.w = tmpvar_2;
  vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = ((tmpvar_6 * 0.5) + 0.5);
  vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = exp2(-(tmpvar_12.xyz));
  gl_FragData[0] = tmpvar_13;
  gl_FragData[1] = tmpvar_14;
  gl_FragData[2] = tmpvar_15;
  gl_FragData[3] = tmpvar_16;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_SEPARATE" "DYNAMICLIGHTMAP_OFF" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_SEPARATE" "DYNAMICLIGHTMAP_OFF" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_SEPARATE" "DYNAMICLIGHTMAP_OFF" "_EMISSION" }
"#version 120

#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_WorldTransformParams;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
attribute vec4 TANGENT;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD6;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec4 tmpvar_7;
  vec4 tmpvar_8;
  tmpvar_8 = (_Object2World * gl_Vertex);
  vec3 tmpvar_9;
  tmpvar_9 = tmpvar_8.xyz;
  tmpvar_3 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_10;
  texcoord_10.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_11;
  if ((_UVSec == 0.0)) {
    tmpvar_11 = tmpvar_1;
  } else {
    tmpvar_11 = tmpvar_2;
  };
  texcoord_10.zw = ((tmpvar_11 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec3 n_12;
  n_12 = (tmpvar_8.xyz - _WorldSpaceCameraPos);
  vec4 v_13;
  v_13.x = _World2Object[0].x;
  v_13.y = _World2Object[1].x;
  v_13.z = _World2Object[2].x;
  v_13.w = _World2Object[3].x;
  vec4 v_14;
  v_14.x = _World2Object[0].y;
  v_14.y = _World2Object[1].y;
  v_14.z = _World2Object[2].y;
  v_14.w = _World2Object[3].y;
  vec4 v_15;
  v_15.x = _World2Object[0].z;
  v_15.y = _World2Object[1].z;
  v_15.z = _World2Object[2].z;
  v_15.w = _World2Object[3].z;
  vec3 tmpvar_16;
  tmpvar_16 = normalize(((
    (v_13.xyz * gl_Normal.x)
   + 
    (v_14.xyz * gl_Normal.y)
  ) + (v_15.xyz * gl_Normal.z)));
  mat3 tmpvar_17;
  tmpvar_17[0] = _Object2World[0].xyz;
  tmpvar_17[1] = _Object2World[1].xyz;
  tmpvar_17[2] = _Object2World[2].xyz;
  vec4 tmpvar_18;
  tmpvar_18.xyz = normalize((tmpvar_17 * TANGENT.xyz));
  tmpvar_18.w = TANGENT.w;
  vec3 tmpvar_19;
  vec3 tmpvar_20;
  tmpvar_19 = tmpvar_18.xyz;
  tmpvar_20 = (((tmpvar_16.yzx * tmpvar_18.zxy) - (tmpvar_16.zxy * tmpvar_18.yzx)) * (TANGENT.w * unity_WorldTransformParams.w));
  vec3 tmpvar_21;
  vec3 tmpvar_22;
  vec3 tmpvar_23;
  tmpvar_21.x = tmpvar_19.x;
  tmpvar_21.y = tmpvar_20.x;
  tmpvar_21.z = tmpvar_16.x;
  tmpvar_22.x = tmpvar_19.y;
  tmpvar_22.y = tmpvar_20.y;
  tmpvar_22.z = tmpvar_16.y;
  tmpvar_23.x = tmpvar_19.z;
  tmpvar_23.y = tmpvar_20.z;
  tmpvar_23.z = tmpvar_16.z;
  vec3 v_24;
  v_24.x = tmpvar_21.x;
  v_24.y = tmpvar_22.x;
  v_24.z = tmpvar_23.x;
  tmpvar_4.xyz = v_24;
  vec3 v_25;
  v_25.x = tmpvar_21.y;
  v_25.y = tmpvar_22.y;
  v_25.z = tmpvar_23.y;
  tmpvar_5.xyz = v_25;
  vec3 v_26;
  v_26.x = tmpvar_21.z;
  v_26.y = tmpvar_22.z;
  v_26.z = tmpvar_23.z;
  tmpvar_6.xyz = v_26;
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  vec3 ambient_27;
  ambient_27 = vec3(0.0, 0.0, 0.0);
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    ambient_27 = vec3(0.0, 0.0, 0.0);
  };
  vec3 x1_28;
  vec4 tmpvar_29;
  tmpvar_29 = (tmpvar_16.xyzz * tmpvar_16.yzzx);
  x1_28.x = dot (unity_SHBr, tmpvar_29);
  x1_28.y = dot (unity_SHBg, tmpvar_29);
  x1_28.z = dot (unity_SHBb, tmpvar_29);
  ambient_27 = (ambient_27 + (x1_28 + (unity_SHC.xyz * 
    ((tmpvar_16.x * tmpvar_16.x) - (tmpvar_16.y * tmpvar_16.y))
  )));
  tmpvar_7.xyz = ambient_27;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = texcoord_10;
  xlv_TEXCOORD1 = n_12;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform float _OcclusionStrength;
uniform vec4 _EmissionColor;
uniform sampler2D _EmissionMap;
varying vec4 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
void main ()
{
  vec3 color_1;
  vec2 tmpvar_2;
  tmpvar_2.x = _Metallic;
  tmpvar_2.y = _Glossiness;
  float tmpvar_3;
  tmpvar_3 = tmpvar_2.y;
  vec3 tmpvar_4;
  tmpvar_4 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_5;
  vec3 tmpvar_6;
  tmpvar_6 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_4, vec3(_Metallic));
  tmpvar_5 = (tmpvar_4 * (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w)));
  vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD2_2.xyz);
  float tmpvar_8;
  tmpvar_8 = ((1.0 - _OcclusionStrength) + (texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y * _OcclusionStrength));
  vec3 tmpvar_9;
  tmpvar_9 = vec3(0.0, 0.0, 0.0);
  vec3 ambient_10;
  vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_7;
  vec3 x_12;
  x_12.x = dot (unity_SHAr, tmpvar_11);
  x_12.y = dot (unity_SHAg, tmpvar_11);
  x_12.z = dot (unity_SHAb, tmpvar_11);
  ambient_10 = (xlv_TEXCOORD5.xyz + x_12);
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    ambient_10 = max (((1.055 * 
      pow (max (ambient_10, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
    ) - 0.055), vec3(0.0, 0.0, 0.0));
  };
  tmpvar_9 = (ambient_10 * tmpvar_8);
  vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = (tmpvar_5 * tmpvar_9);
  color_1 = (tmpvar_13.xyz + (texture2D (_EmissionMap, xlv_TEXCOORD0.xy).xyz * _EmissionColor.xyz));
  color_1 = exp2(-(color_1));
  vec4 tmpvar_14;
  tmpvar_14.xyz = tmpvar_5;
  tmpvar_14.w = tmpvar_8;
  vec4 tmpvar_15;
  tmpvar_15.xyz = tmpvar_6;
  tmpvar_15.w = tmpvar_3;
  vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = ((tmpvar_7 * 0.5) + 0.5);
  vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = color_1;
  gl_FragData[0] = tmpvar_14;
  gl_FragData[1] = tmpvar_15;
  gl_FragData[2] = tmpvar_16;
  gl_FragData[3] = tmpvar_17;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_SEPARATE" "DYNAMICLIGHTMAP_OFF" "_EMISSION" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_SEPARATE" "DYNAMICLIGHTMAP_OFF" "_EMISSION" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
"#version 120

#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD6;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec4 tmpvar_7;
  vec4 tmpvar_8;
  tmpvar_8 = (_Object2World * gl_Vertex);
  vec3 tmpvar_9;
  tmpvar_9 = tmpvar_8.xyz;
  tmpvar_3 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_10;
  texcoord_10.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_11;
  if ((_UVSec == 0.0)) {
    tmpvar_11 = tmpvar_1;
  } else {
    tmpvar_11 = tmpvar_2;
  };
  texcoord_10.zw = ((tmpvar_11 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec3 n_12;
  n_12 = (tmpvar_8.xyz - _WorldSpaceCameraPos);
  vec4 v_13;
  v_13.x = _World2Object[0].x;
  v_13.y = _World2Object[1].x;
  v_13.z = _World2Object[2].x;
  v_13.w = _World2Object[3].x;
  vec4 v_14;
  v_14.x = _World2Object[0].y;
  v_14.y = _World2Object[1].y;
  v_14.z = _World2Object[2].y;
  v_14.w = _World2Object[3].y;
  vec4 v_15;
  v_15.x = _World2Object[0].z;
  v_15.y = _World2Object[1].z;
  v_15.z = _World2Object[2].z;
  v_15.w = _World2Object[3].z;
  vec3 tmpvar_16;
  tmpvar_16 = normalize(((
    (v_13.xyz * gl_Normal.x)
   + 
    (v_14.xyz * gl_Normal.y)
  ) + (v_15.xyz * gl_Normal.z)));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_16;
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  vec3 ambient_17;
  ambient_17 = vec3(0.0, 0.0, 0.0);
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    ambient_17 = vec3(0.0, 0.0, 0.0);
  };
  vec3 x1_18;
  vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_16.xyzz * tmpvar_16.yzzx);
  x1_18.x = dot (unity_SHBr, tmpvar_19);
  x1_18.y = dot (unity_SHBg, tmpvar_19);
  x1_18.z = dot (unity_SHBb, tmpvar_19);
  ambient_17 = (ambient_17 + (x1_18 + (unity_SHC.xyz * 
    ((tmpvar_16.x * tmpvar_16.x) - (tmpvar_16.y * tmpvar_16.y))
  )));
  tmpvar_7.xyz = ambient_17;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = texcoord_10;
  xlv_TEXCOORD1 = n_12;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform float _OcclusionStrength;
varying vec4 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1.x = _Metallic;
  tmpvar_1.y = _Glossiness;
  float tmpvar_2;
  tmpvar_2 = tmpvar_1.y;
  vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_4;
  vec3 tmpvar_5;
  tmpvar_5 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_3, vec3(_Metallic));
  tmpvar_4 = (tmpvar_3 * (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w)));
  vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD2_2.xyz);
  float tmpvar_7;
  tmpvar_7 = ((1.0 - _OcclusionStrength) + (texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y * _OcclusionStrength));
  vec3 tmpvar_8;
  tmpvar_8 = vec3(0.0, 0.0, 0.0);
  vec3 ambient_9;
  vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_6;
  vec3 x_11;
  x_11.x = dot (unity_SHAr, tmpvar_10);
  x_11.y = dot (unity_SHAg, tmpvar_10);
  x_11.z = dot (unity_SHAb, tmpvar_10);
  ambient_9 = (xlv_TEXCOORD5.xyz + x_11);
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    ambient_9 = max (((1.055 * 
      pow (max (ambient_9, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
    ) - 0.055), vec3(0.0, 0.0, 0.0));
  };
  tmpvar_8 = (ambient_9 * tmpvar_7);
  vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = (tmpvar_4 * tmpvar_8);
  vec4 tmpvar_13;
  tmpvar_13.xyz = tmpvar_4;
  tmpvar_13.w = tmpvar_7;
  vec4 tmpvar_14;
  tmpvar_14.xyz = tmpvar_5;
  tmpvar_14.w = tmpvar_2;
  vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = ((tmpvar_6 * 0.5) + 0.5);
  vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_12.xyz;
  gl_FragData[0] = tmpvar_13;
  gl_FragData[1] = tmpvar_14;
  gl_FragData[2] = tmpvar_15;
  gl_FragData[3] = tmpvar_16;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "_EMISSION" "UNITY_HDR_ON" }
"#version 120

#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD6;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec4 tmpvar_7;
  vec4 tmpvar_8;
  tmpvar_8 = (_Object2World * gl_Vertex);
  vec3 tmpvar_9;
  tmpvar_9 = tmpvar_8.xyz;
  tmpvar_3 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_10;
  texcoord_10.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_11;
  if ((_UVSec == 0.0)) {
    tmpvar_11 = tmpvar_1;
  } else {
    tmpvar_11 = tmpvar_2;
  };
  texcoord_10.zw = ((tmpvar_11 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec3 n_12;
  n_12 = (tmpvar_8.xyz - _WorldSpaceCameraPos);
  vec4 v_13;
  v_13.x = _World2Object[0].x;
  v_13.y = _World2Object[1].x;
  v_13.z = _World2Object[2].x;
  v_13.w = _World2Object[3].x;
  vec4 v_14;
  v_14.x = _World2Object[0].y;
  v_14.y = _World2Object[1].y;
  v_14.z = _World2Object[2].y;
  v_14.w = _World2Object[3].y;
  vec4 v_15;
  v_15.x = _World2Object[0].z;
  v_15.y = _World2Object[1].z;
  v_15.z = _World2Object[2].z;
  v_15.w = _World2Object[3].z;
  vec3 tmpvar_16;
  tmpvar_16 = normalize(((
    (v_13.xyz * gl_Normal.x)
   + 
    (v_14.xyz * gl_Normal.y)
  ) + (v_15.xyz * gl_Normal.z)));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_16;
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  vec3 ambient_17;
  ambient_17 = vec3(0.0, 0.0, 0.0);
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    ambient_17 = vec3(0.0, 0.0, 0.0);
  };
  vec3 x1_18;
  vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_16.xyzz * tmpvar_16.yzzx);
  x1_18.x = dot (unity_SHBr, tmpvar_19);
  x1_18.y = dot (unity_SHBg, tmpvar_19);
  x1_18.z = dot (unity_SHBb, tmpvar_19);
  ambient_17 = (ambient_17 + (x1_18 + (unity_SHC.xyz * 
    ((tmpvar_16.x * tmpvar_16.x) - (tmpvar_16.y * tmpvar_16.y))
  )));
  tmpvar_7.xyz = ambient_17;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = texcoord_10;
  xlv_TEXCOORD1 = n_12;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform float _OcclusionStrength;
uniform vec4 _EmissionColor;
uniform sampler2D _EmissionMap;
varying vec4 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1.x = _Metallic;
  tmpvar_1.y = _Glossiness;
  float tmpvar_2;
  tmpvar_2 = tmpvar_1.y;
  vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_4;
  vec3 tmpvar_5;
  tmpvar_5 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_3, vec3(_Metallic));
  tmpvar_4 = (tmpvar_3 * (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w)));
  vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD2_2.xyz);
  float tmpvar_7;
  tmpvar_7 = ((1.0 - _OcclusionStrength) + (texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y * _OcclusionStrength));
  vec3 tmpvar_8;
  tmpvar_8 = vec3(0.0, 0.0, 0.0);
  vec3 ambient_9;
  vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_6;
  vec3 x_11;
  x_11.x = dot (unity_SHAr, tmpvar_10);
  x_11.y = dot (unity_SHAg, tmpvar_10);
  x_11.z = dot (unity_SHAb, tmpvar_10);
  ambient_9 = (xlv_TEXCOORD5.xyz + x_11);
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    ambient_9 = max (((1.055 * 
      pow (max (ambient_9, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
    ) - 0.055), vec3(0.0, 0.0, 0.0));
  };
  tmpvar_8 = (ambient_9 * tmpvar_7);
  vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = (tmpvar_4 * tmpvar_8);
  vec4 tmpvar_13;
  tmpvar_13.xyz = tmpvar_4;
  tmpvar_13.w = tmpvar_7;
  vec4 tmpvar_14;
  tmpvar_14.xyz = tmpvar_5;
  tmpvar_14.w = tmpvar_2;
  vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = ((tmpvar_6 * 0.5) + 0.5);
  vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = (tmpvar_12.xyz + (texture2D (_EmissionMap, xlv_TEXCOORD0.xy).xyz * _EmissionColor.xyz));
  gl_FragData[0] = tmpvar_13;
  gl_FragData[1] = tmpvar_14;
  gl_FragData[2] = tmpvar_15;
  gl_FragData[3] = tmpvar_16;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "_EMISSION" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "_EMISSION" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
"#version 120

#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_WorldTransformParams;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
attribute vec4 TANGENT;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD6;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec4 tmpvar_7;
  vec4 tmpvar_8;
  tmpvar_8 = (_Object2World * gl_Vertex);
  vec3 tmpvar_9;
  tmpvar_9 = tmpvar_8.xyz;
  tmpvar_3 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_10;
  texcoord_10.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_11;
  if ((_UVSec == 0.0)) {
    tmpvar_11 = tmpvar_1;
  } else {
    tmpvar_11 = tmpvar_2;
  };
  texcoord_10.zw = ((tmpvar_11 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec3 n_12;
  n_12 = (tmpvar_8.xyz - _WorldSpaceCameraPos);
  vec4 v_13;
  v_13.x = _World2Object[0].x;
  v_13.y = _World2Object[1].x;
  v_13.z = _World2Object[2].x;
  v_13.w = _World2Object[3].x;
  vec4 v_14;
  v_14.x = _World2Object[0].y;
  v_14.y = _World2Object[1].y;
  v_14.z = _World2Object[2].y;
  v_14.w = _World2Object[3].y;
  vec4 v_15;
  v_15.x = _World2Object[0].z;
  v_15.y = _World2Object[1].z;
  v_15.z = _World2Object[2].z;
  v_15.w = _World2Object[3].z;
  vec3 tmpvar_16;
  tmpvar_16 = normalize(((
    (v_13.xyz * gl_Normal.x)
   + 
    (v_14.xyz * gl_Normal.y)
  ) + (v_15.xyz * gl_Normal.z)));
  mat3 tmpvar_17;
  tmpvar_17[0] = _Object2World[0].xyz;
  tmpvar_17[1] = _Object2World[1].xyz;
  tmpvar_17[2] = _Object2World[2].xyz;
  vec4 tmpvar_18;
  tmpvar_18.xyz = normalize((tmpvar_17 * TANGENT.xyz));
  tmpvar_18.w = TANGENT.w;
  vec3 tmpvar_19;
  vec3 tmpvar_20;
  tmpvar_19 = tmpvar_18.xyz;
  tmpvar_20 = (((tmpvar_16.yzx * tmpvar_18.zxy) - (tmpvar_16.zxy * tmpvar_18.yzx)) * (TANGENT.w * unity_WorldTransformParams.w));
  vec3 tmpvar_21;
  vec3 tmpvar_22;
  vec3 tmpvar_23;
  tmpvar_21.x = tmpvar_19.x;
  tmpvar_21.y = tmpvar_20.x;
  tmpvar_21.z = tmpvar_16.x;
  tmpvar_22.x = tmpvar_19.y;
  tmpvar_22.y = tmpvar_20.y;
  tmpvar_22.z = tmpvar_16.y;
  tmpvar_23.x = tmpvar_19.z;
  tmpvar_23.y = tmpvar_20.z;
  tmpvar_23.z = tmpvar_16.z;
  vec3 v_24;
  v_24.x = tmpvar_21.x;
  v_24.y = tmpvar_22.x;
  v_24.z = tmpvar_23.x;
  tmpvar_4.xyz = v_24;
  vec3 v_25;
  v_25.x = tmpvar_21.y;
  v_25.y = tmpvar_22.y;
  v_25.z = tmpvar_23.y;
  tmpvar_5.xyz = v_25;
  vec3 v_26;
  v_26.x = tmpvar_21.z;
  v_26.y = tmpvar_22.z;
  v_26.z = tmpvar_23.z;
  tmpvar_6.xyz = v_26;
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  vec3 ambient_27;
  ambient_27 = vec3(0.0, 0.0, 0.0);
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    ambient_27 = vec3(0.0, 0.0, 0.0);
  };
  vec3 x1_28;
  vec4 tmpvar_29;
  tmpvar_29 = (tmpvar_16.xyzz * tmpvar_16.yzzx);
  x1_28.x = dot (unity_SHBr, tmpvar_29);
  x1_28.y = dot (unity_SHBg, tmpvar_29);
  x1_28.z = dot (unity_SHBb, tmpvar_29);
  ambient_27 = (ambient_27 + (x1_28 + (unity_SHC.xyz * 
    ((tmpvar_16.x * tmpvar_16.x) - (tmpvar_16.y * tmpvar_16.y))
  )));
  tmpvar_7.xyz = ambient_27;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = texcoord_10;
  xlv_TEXCOORD1 = n_12;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform float _OcclusionStrength;
varying vec4 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1.x = _Metallic;
  tmpvar_1.y = _Glossiness;
  float tmpvar_2;
  tmpvar_2 = tmpvar_1.y;
  vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_4;
  vec3 tmpvar_5;
  tmpvar_5 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_3, vec3(_Metallic));
  tmpvar_4 = (tmpvar_3 * (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w)));
  vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD2_2.xyz);
  float tmpvar_7;
  tmpvar_7 = ((1.0 - _OcclusionStrength) + (texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y * _OcclusionStrength));
  vec3 tmpvar_8;
  tmpvar_8 = vec3(0.0, 0.0, 0.0);
  vec3 ambient_9;
  vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_6;
  vec3 x_11;
  x_11.x = dot (unity_SHAr, tmpvar_10);
  x_11.y = dot (unity_SHAg, tmpvar_10);
  x_11.z = dot (unity_SHAb, tmpvar_10);
  ambient_9 = (xlv_TEXCOORD5.xyz + x_11);
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    ambient_9 = max (((1.055 * 
      pow (max (ambient_9, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
    ) - 0.055), vec3(0.0, 0.0, 0.0));
  };
  tmpvar_8 = (ambient_9 * tmpvar_7);
  vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = (tmpvar_4 * tmpvar_8);
  vec4 tmpvar_13;
  tmpvar_13.xyz = tmpvar_4;
  tmpvar_13.w = tmpvar_7;
  vec4 tmpvar_14;
  tmpvar_14.xyz = tmpvar_5;
  tmpvar_14.w = tmpvar_2;
  vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = ((tmpvar_6 * 0.5) + 0.5);
  vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_12.xyz;
  gl_FragData[0] = tmpvar_13;
  gl_FragData[1] = tmpvar_14;
  gl_FragData[2] = tmpvar_15;
  gl_FragData[3] = tmpvar_16;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_OFF" "_EMISSION" "UNITY_HDR_ON" }
"#version 120

#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_WorldTransformParams;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
attribute vec4 TANGENT;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD6;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec4 tmpvar_7;
  vec4 tmpvar_8;
  tmpvar_8 = (_Object2World * gl_Vertex);
  vec3 tmpvar_9;
  tmpvar_9 = tmpvar_8.xyz;
  tmpvar_3 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_10;
  texcoord_10.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_11;
  if ((_UVSec == 0.0)) {
    tmpvar_11 = tmpvar_1;
  } else {
    tmpvar_11 = tmpvar_2;
  };
  texcoord_10.zw = ((tmpvar_11 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec3 n_12;
  n_12 = (tmpvar_8.xyz - _WorldSpaceCameraPos);
  vec4 v_13;
  v_13.x = _World2Object[0].x;
  v_13.y = _World2Object[1].x;
  v_13.z = _World2Object[2].x;
  v_13.w = _World2Object[3].x;
  vec4 v_14;
  v_14.x = _World2Object[0].y;
  v_14.y = _World2Object[1].y;
  v_14.z = _World2Object[2].y;
  v_14.w = _World2Object[3].y;
  vec4 v_15;
  v_15.x = _World2Object[0].z;
  v_15.y = _World2Object[1].z;
  v_15.z = _World2Object[2].z;
  v_15.w = _World2Object[3].z;
  vec3 tmpvar_16;
  tmpvar_16 = normalize(((
    (v_13.xyz * gl_Normal.x)
   + 
    (v_14.xyz * gl_Normal.y)
  ) + (v_15.xyz * gl_Normal.z)));
  mat3 tmpvar_17;
  tmpvar_17[0] = _Object2World[0].xyz;
  tmpvar_17[1] = _Object2World[1].xyz;
  tmpvar_17[2] = _Object2World[2].xyz;
  vec4 tmpvar_18;
  tmpvar_18.xyz = normalize((tmpvar_17 * TANGENT.xyz));
  tmpvar_18.w = TANGENT.w;
  vec3 tmpvar_19;
  vec3 tmpvar_20;
  tmpvar_19 = tmpvar_18.xyz;
  tmpvar_20 = (((tmpvar_16.yzx * tmpvar_18.zxy) - (tmpvar_16.zxy * tmpvar_18.yzx)) * (TANGENT.w * unity_WorldTransformParams.w));
  vec3 tmpvar_21;
  vec3 tmpvar_22;
  vec3 tmpvar_23;
  tmpvar_21.x = tmpvar_19.x;
  tmpvar_21.y = tmpvar_20.x;
  tmpvar_21.z = tmpvar_16.x;
  tmpvar_22.x = tmpvar_19.y;
  tmpvar_22.y = tmpvar_20.y;
  tmpvar_22.z = tmpvar_16.y;
  tmpvar_23.x = tmpvar_19.z;
  tmpvar_23.y = tmpvar_20.z;
  tmpvar_23.z = tmpvar_16.z;
  vec3 v_24;
  v_24.x = tmpvar_21.x;
  v_24.y = tmpvar_22.x;
  v_24.z = tmpvar_23.x;
  tmpvar_4.xyz = v_24;
  vec3 v_25;
  v_25.x = tmpvar_21.y;
  v_25.y = tmpvar_22.y;
  v_25.z = tmpvar_23.y;
  tmpvar_5.xyz = v_25;
  vec3 v_26;
  v_26.x = tmpvar_21.z;
  v_26.y = tmpvar_22.z;
  v_26.z = tmpvar_23.z;
  tmpvar_6.xyz = v_26;
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  vec3 ambient_27;
  ambient_27 = vec3(0.0, 0.0, 0.0);
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    ambient_27 = vec3(0.0, 0.0, 0.0);
  };
  vec3 x1_28;
  vec4 tmpvar_29;
  tmpvar_29 = (tmpvar_16.xyzz * tmpvar_16.yzzx);
  x1_28.x = dot (unity_SHBr, tmpvar_29);
  x1_28.y = dot (unity_SHBg, tmpvar_29);
  x1_28.z = dot (unity_SHBb, tmpvar_29);
  ambient_27 = (ambient_27 + (x1_28 + (unity_SHC.xyz * 
    ((tmpvar_16.x * tmpvar_16.x) - (tmpvar_16.y * tmpvar_16.y))
  )));
  tmpvar_7.xyz = ambient_27;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = texcoord_10;
  xlv_TEXCOORD1 = n_12;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform float _OcclusionStrength;
uniform vec4 _EmissionColor;
uniform sampler2D _EmissionMap;
varying vec4 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1.x = _Metallic;
  tmpvar_1.y = _Glossiness;
  float tmpvar_2;
  tmpvar_2 = tmpvar_1.y;
  vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_4;
  vec3 tmpvar_5;
  tmpvar_5 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_3, vec3(_Metallic));
  tmpvar_4 = (tmpvar_3 * (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w)));
  vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD2_2.xyz);
  float tmpvar_7;
  tmpvar_7 = ((1.0 - _OcclusionStrength) + (texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y * _OcclusionStrength));
  vec3 tmpvar_8;
  tmpvar_8 = vec3(0.0, 0.0, 0.0);
  vec3 ambient_9;
  vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_6;
  vec3 x_11;
  x_11.x = dot (unity_SHAr, tmpvar_10);
  x_11.y = dot (unity_SHAg, tmpvar_10);
  x_11.z = dot (unity_SHAb, tmpvar_10);
  ambient_9 = (xlv_TEXCOORD5.xyz + x_11);
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    ambient_9 = max (((1.055 * 
      pow (max (ambient_9, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
    ) - 0.055), vec3(0.0, 0.0, 0.0));
  };
  tmpvar_8 = (ambient_9 * tmpvar_7);
  vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = (tmpvar_4 * tmpvar_8);
  vec4 tmpvar_13;
  tmpvar_13.xyz = tmpvar_4;
  tmpvar_13.w = tmpvar_7;
  vec4 tmpvar_14;
  tmpvar_14.xyz = tmpvar_5;
  tmpvar_14.w = tmpvar_2;
  vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = ((tmpvar_6 * 0.5) + 0.5);
  vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = (tmpvar_12.xyz + (texture2D (_EmissionMap, xlv_TEXCOORD0.xy).xyz * _EmissionColor.xyz));
  gl_FragData[0] = tmpvar_13;
  gl_FragData[1] = tmpvar_14;
  gl_FragData[2] = tmpvar_15;
  gl_FragData[3] = tmpvar_16;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_OFF" "_EMISSION" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_OFF" "_EMISSION" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_SEPARATE" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
"#version 120

#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_WorldTransformParams;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
attribute vec4 TANGENT;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD6;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec4 tmpvar_7;
  vec4 tmpvar_8;
  tmpvar_8 = (_Object2World * gl_Vertex);
  vec3 tmpvar_9;
  tmpvar_9 = tmpvar_8.xyz;
  tmpvar_3 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_10;
  texcoord_10.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_11;
  if ((_UVSec == 0.0)) {
    tmpvar_11 = tmpvar_1;
  } else {
    tmpvar_11 = tmpvar_2;
  };
  texcoord_10.zw = ((tmpvar_11 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec3 n_12;
  n_12 = (tmpvar_8.xyz - _WorldSpaceCameraPos);
  vec4 v_13;
  v_13.x = _World2Object[0].x;
  v_13.y = _World2Object[1].x;
  v_13.z = _World2Object[2].x;
  v_13.w = _World2Object[3].x;
  vec4 v_14;
  v_14.x = _World2Object[0].y;
  v_14.y = _World2Object[1].y;
  v_14.z = _World2Object[2].y;
  v_14.w = _World2Object[3].y;
  vec4 v_15;
  v_15.x = _World2Object[0].z;
  v_15.y = _World2Object[1].z;
  v_15.z = _World2Object[2].z;
  v_15.w = _World2Object[3].z;
  vec3 tmpvar_16;
  tmpvar_16 = normalize(((
    (v_13.xyz * gl_Normal.x)
   + 
    (v_14.xyz * gl_Normal.y)
  ) + (v_15.xyz * gl_Normal.z)));
  mat3 tmpvar_17;
  tmpvar_17[0] = _Object2World[0].xyz;
  tmpvar_17[1] = _Object2World[1].xyz;
  tmpvar_17[2] = _Object2World[2].xyz;
  vec4 tmpvar_18;
  tmpvar_18.xyz = normalize((tmpvar_17 * TANGENT.xyz));
  tmpvar_18.w = TANGENT.w;
  vec3 tmpvar_19;
  vec3 tmpvar_20;
  tmpvar_19 = tmpvar_18.xyz;
  tmpvar_20 = (((tmpvar_16.yzx * tmpvar_18.zxy) - (tmpvar_16.zxy * tmpvar_18.yzx)) * (TANGENT.w * unity_WorldTransformParams.w));
  vec3 tmpvar_21;
  vec3 tmpvar_22;
  vec3 tmpvar_23;
  tmpvar_21.x = tmpvar_19.x;
  tmpvar_21.y = tmpvar_20.x;
  tmpvar_21.z = tmpvar_16.x;
  tmpvar_22.x = tmpvar_19.y;
  tmpvar_22.y = tmpvar_20.y;
  tmpvar_22.z = tmpvar_16.y;
  tmpvar_23.x = tmpvar_19.z;
  tmpvar_23.y = tmpvar_20.z;
  tmpvar_23.z = tmpvar_16.z;
  vec3 v_24;
  v_24.x = tmpvar_21.x;
  v_24.y = tmpvar_22.x;
  v_24.z = tmpvar_23.x;
  tmpvar_4.xyz = v_24;
  vec3 v_25;
  v_25.x = tmpvar_21.y;
  v_25.y = tmpvar_22.y;
  v_25.z = tmpvar_23.y;
  tmpvar_5.xyz = v_25;
  vec3 v_26;
  v_26.x = tmpvar_21.z;
  v_26.y = tmpvar_22.z;
  v_26.z = tmpvar_23.z;
  tmpvar_6.xyz = v_26;
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  vec3 ambient_27;
  ambient_27 = vec3(0.0, 0.0, 0.0);
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    ambient_27 = vec3(0.0, 0.0, 0.0);
  };
  vec3 x1_28;
  vec4 tmpvar_29;
  tmpvar_29 = (tmpvar_16.xyzz * tmpvar_16.yzzx);
  x1_28.x = dot (unity_SHBr, tmpvar_29);
  x1_28.y = dot (unity_SHBg, tmpvar_29);
  x1_28.z = dot (unity_SHBb, tmpvar_29);
  ambient_27 = (ambient_27 + (x1_28 + (unity_SHC.xyz * 
    ((tmpvar_16.x * tmpvar_16.x) - (tmpvar_16.y * tmpvar_16.y))
  )));
  tmpvar_7.xyz = ambient_27;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = texcoord_10;
  xlv_TEXCOORD1 = n_12;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform float _OcclusionStrength;
varying vec4 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1.x = _Metallic;
  tmpvar_1.y = _Glossiness;
  float tmpvar_2;
  tmpvar_2 = tmpvar_1.y;
  vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_4;
  vec3 tmpvar_5;
  tmpvar_5 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_3, vec3(_Metallic));
  tmpvar_4 = (tmpvar_3 * (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w)));
  vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD2_2.xyz);
  float tmpvar_7;
  tmpvar_7 = ((1.0 - _OcclusionStrength) + (texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y * _OcclusionStrength));
  vec3 tmpvar_8;
  tmpvar_8 = vec3(0.0, 0.0, 0.0);
  vec3 ambient_9;
  vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_6;
  vec3 x_11;
  x_11.x = dot (unity_SHAr, tmpvar_10);
  x_11.y = dot (unity_SHAg, tmpvar_10);
  x_11.z = dot (unity_SHAb, tmpvar_10);
  ambient_9 = (xlv_TEXCOORD5.xyz + x_11);
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    ambient_9 = max (((1.055 * 
      pow (max (ambient_9, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
    ) - 0.055), vec3(0.0, 0.0, 0.0));
  };
  tmpvar_8 = (ambient_9 * tmpvar_7);
  vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = (tmpvar_4 * tmpvar_8);
  vec4 tmpvar_13;
  tmpvar_13.xyz = tmpvar_4;
  tmpvar_13.w = tmpvar_7;
  vec4 tmpvar_14;
  tmpvar_14.xyz = tmpvar_5;
  tmpvar_14.w = tmpvar_2;
  vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = ((tmpvar_6 * 0.5) + 0.5);
  vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_12.xyz;
  gl_FragData[0] = tmpvar_13;
  gl_FragData[1] = tmpvar_14;
  gl_FragData[2] = tmpvar_15;
  gl_FragData[3] = tmpvar_16;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_SEPARATE" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_SEPARATE" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_SEPARATE" "DYNAMICLIGHTMAP_OFF" "_EMISSION" "UNITY_HDR_ON" }
"#version 120

#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_WorldTransformParams;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
attribute vec4 TANGENT;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD6;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec4 tmpvar_7;
  vec4 tmpvar_8;
  tmpvar_8 = (_Object2World * gl_Vertex);
  vec3 tmpvar_9;
  tmpvar_9 = tmpvar_8.xyz;
  tmpvar_3 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_10;
  texcoord_10.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_11;
  if ((_UVSec == 0.0)) {
    tmpvar_11 = tmpvar_1;
  } else {
    tmpvar_11 = tmpvar_2;
  };
  texcoord_10.zw = ((tmpvar_11 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec3 n_12;
  n_12 = (tmpvar_8.xyz - _WorldSpaceCameraPos);
  vec4 v_13;
  v_13.x = _World2Object[0].x;
  v_13.y = _World2Object[1].x;
  v_13.z = _World2Object[2].x;
  v_13.w = _World2Object[3].x;
  vec4 v_14;
  v_14.x = _World2Object[0].y;
  v_14.y = _World2Object[1].y;
  v_14.z = _World2Object[2].y;
  v_14.w = _World2Object[3].y;
  vec4 v_15;
  v_15.x = _World2Object[0].z;
  v_15.y = _World2Object[1].z;
  v_15.z = _World2Object[2].z;
  v_15.w = _World2Object[3].z;
  vec3 tmpvar_16;
  tmpvar_16 = normalize(((
    (v_13.xyz * gl_Normal.x)
   + 
    (v_14.xyz * gl_Normal.y)
  ) + (v_15.xyz * gl_Normal.z)));
  mat3 tmpvar_17;
  tmpvar_17[0] = _Object2World[0].xyz;
  tmpvar_17[1] = _Object2World[1].xyz;
  tmpvar_17[2] = _Object2World[2].xyz;
  vec4 tmpvar_18;
  tmpvar_18.xyz = normalize((tmpvar_17 * TANGENT.xyz));
  tmpvar_18.w = TANGENT.w;
  vec3 tmpvar_19;
  vec3 tmpvar_20;
  tmpvar_19 = tmpvar_18.xyz;
  tmpvar_20 = (((tmpvar_16.yzx * tmpvar_18.zxy) - (tmpvar_16.zxy * tmpvar_18.yzx)) * (TANGENT.w * unity_WorldTransformParams.w));
  vec3 tmpvar_21;
  vec3 tmpvar_22;
  vec3 tmpvar_23;
  tmpvar_21.x = tmpvar_19.x;
  tmpvar_21.y = tmpvar_20.x;
  tmpvar_21.z = tmpvar_16.x;
  tmpvar_22.x = tmpvar_19.y;
  tmpvar_22.y = tmpvar_20.y;
  tmpvar_22.z = tmpvar_16.y;
  tmpvar_23.x = tmpvar_19.z;
  tmpvar_23.y = tmpvar_20.z;
  tmpvar_23.z = tmpvar_16.z;
  vec3 v_24;
  v_24.x = tmpvar_21.x;
  v_24.y = tmpvar_22.x;
  v_24.z = tmpvar_23.x;
  tmpvar_4.xyz = v_24;
  vec3 v_25;
  v_25.x = tmpvar_21.y;
  v_25.y = tmpvar_22.y;
  v_25.z = tmpvar_23.y;
  tmpvar_5.xyz = v_25;
  vec3 v_26;
  v_26.x = tmpvar_21.z;
  v_26.y = tmpvar_22.z;
  v_26.z = tmpvar_23.z;
  tmpvar_6.xyz = v_26;
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  vec3 ambient_27;
  ambient_27 = vec3(0.0, 0.0, 0.0);
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    ambient_27 = vec3(0.0, 0.0, 0.0);
  };
  vec3 x1_28;
  vec4 tmpvar_29;
  tmpvar_29 = (tmpvar_16.xyzz * tmpvar_16.yzzx);
  x1_28.x = dot (unity_SHBr, tmpvar_29);
  x1_28.y = dot (unity_SHBg, tmpvar_29);
  x1_28.z = dot (unity_SHBb, tmpvar_29);
  ambient_27 = (ambient_27 + (x1_28 + (unity_SHC.xyz * 
    ((tmpvar_16.x * tmpvar_16.x) - (tmpvar_16.y * tmpvar_16.y))
  )));
  tmpvar_7.xyz = ambient_27;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = texcoord_10;
  xlv_TEXCOORD1 = n_12;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform float _OcclusionStrength;
uniform vec4 _EmissionColor;
uniform sampler2D _EmissionMap;
varying vec4 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1.x = _Metallic;
  tmpvar_1.y = _Glossiness;
  float tmpvar_2;
  tmpvar_2 = tmpvar_1.y;
  vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_4;
  vec3 tmpvar_5;
  tmpvar_5 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_3, vec3(_Metallic));
  tmpvar_4 = (tmpvar_3 * (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w)));
  vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD2_2.xyz);
  float tmpvar_7;
  tmpvar_7 = ((1.0 - _OcclusionStrength) + (texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y * _OcclusionStrength));
  vec3 tmpvar_8;
  tmpvar_8 = vec3(0.0, 0.0, 0.0);
  vec3 ambient_9;
  vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_6;
  vec3 x_11;
  x_11.x = dot (unity_SHAr, tmpvar_10);
  x_11.y = dot (unity_SHAg, tmpvar_10);
  x_11.z = dot (unity_SHAb, tmpvar_10);
  ambient_9 = (xlv_TEXCOORD5.xyz + x_11);
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    ambient_9 = max (((1.055 * 
      pow (max (ambient_9, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
    ) - 0.055), vec3(0.0, 0.0, 0.0));
  };
  tmpvar_8 = (ambient_9 * tmpvar_7);
  vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = (tmpvar_4 * tmpvar_8);
  vec4 tmpvar_13;
  tmpvar_13.xyz = tmpvar_4;
  tmpvar_13.w = tmpvar_7;
  vec4 tmpvar_14;
  tmpvar_14.xyz = tmpvar_5;
  tmpvar_14.w = tmpvar_2;
  vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = ((tmpvar_6 * 0.5) + 0.5);
  vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = (tmpvar_12.xyz + (texture2D (_EmissionMap, xlv_TEXCOORD0.xy).xyz * _EmissionColor.xyz));
  gl_FragData[0] = tmpvar_13;
  gl_FragData[1] = tmpvar_14;
  gl_FragData[2] = tmpvar_15;
  gl_FragData[3] = tmpvar_16;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_SEPARATE" "DYNAMICLIGHTMAP_OFF" "_EMISSION" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_SEPARATE" "DYNAMICLIGHTMAP_OFF" "_EMISSION" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "_EMISSION" }
""
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "_EMISSION" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "_EMISSION" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_OFF" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_OFF" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_OFF" "_EMISSION" }
""
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_OFF" "_EMISSION" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_OFF" "_EMISSION" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_SEPARATE" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_SEPARATE" "DYNAMICLIGHTMAP_OFF" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_SEPARATE" "DYNAMICLIGHTMAP_OFF" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_SEPARATE" "DYNAMICLIGHTMAP_OFF" "_EMISSION" }
""
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_SEPARATE" "DYNAMICLIGHTMAP_OFF" "_EMISSION" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_SEPARATE" "DYNAMICLIGHTMAP_OFF" "_EMISSION" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
""
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "_EMISSION" "UNITY_HDR_ON" }
""
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "_EMISSION" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "_EMISSION" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
""
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_OFF" "_EMISSION" "UNITY_HDR_ON" }
""
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_OFF" "_EMISSION" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_OFF" "_EMISSION" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_SEPARATE" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
""
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_SEPARATE" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_SEPARATE" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_SEPARATE" "DYNAMICLIGHTMAP_OFF" "_EMISSION" "UNITY_HDR_ON" }
""
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_SEPARATE" "DYNAMICLIGHTMAP_OFF" "_EMISSION" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_SEPARATE" "DYNAMICLIGHTMAP_OFF" "_EMISSION" "UNITY_HDR_ON" }
"// shader disassembly not supported on DXBC"
}
}
 }
}
SubShader { 
 LOD 150
 Tags { "RenderType"="Opaque" "PerformanceChecks"="False" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" "RenderType"="Opaque" "PerformanceChecks"="False" }
  ZWrite [_ZWrite]
  Blend [_SrcBlend] [_DstBlend]
  GpuProgramID 358221
Program "vp" {
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 120

#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec4 tmpvar_7;
  tmpvar_7 = (_Object2World * gl_Vertex);
  tmpvar_3 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_8;
  texcoord_8.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_9;
  if ((_UVSec == 0.0)) {
    tmpvar_9 = tmpvar_1;
  } else {
    tmpvar_9 = tmpvar_2;
  };
  texcoord_8.zw = ((tmpvar_9 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec3 tmpvar_10;
  tmpvar_10 = normalize((tmpvar_7.xyz - _WorldSpaceCameraPos));
  vec4 v_11;
  v_11.x = _World2Object[0].x;
  v_11.y = _World2Object[1].x;
  v_11.z = _World2Object[2].x;
  v_11.w = _World2Object[3].x;
  vec4 v_12;
  v_12.x = _World2Object[0].y;
  v_12.y = _World2Object[1].y;
  v_12.z = _World2Object[2].y;
  v_12.w = _World2Object[3].y;
  vec4 v_13;
  v_13.x = _World2Object[0].z;
  v_13.y = _World2Object[1].z;
  v_13.z = _World2Object[2].z;
  v_13.w = _World2Object[3].z;
  vec3 tmpvar_14;
  tmpvar_14 = normalize(((
    (v_11.xyz * gl_Normal.x)
   + 
    (v_12.xyz * gl_Normal.y)
  ) + (v_13.xyz * gl_Normal.z)));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_14;
  vec4 ambientOrLightmapUV_15;
  ambientOrLightmapUV_15 = vec4(0.0, 0.0, 0.0, 0.0);
  vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_14;
  vec3 res_17;
  vec3 x_18;
  x_18.x = dot (unity_SHAr, tmpvar_16);
  x_18.y = dot (unity_SHAg, tmpvar_16);
  x_18.z = dot (unity_SHAb, tmpvar_16);
  vec3 x1_19;
  vec4 tmpvar_20;
  tmpvar_20 = (tmpvar_14.xyzz * tmpvar_14.yzzx);
  x1_19.x = dot (unity_SHBr, tmpvar_20);
  x1_19.y = dot (unity_SHBg, tmpvar_20);
  x1_19.z = dot (unity_SHBb, tmpvar_20);
  res_17 = (x_18 + (x1_19 + (unity_SHC.xyz * 
    ((tmpvar_14.x * tmpvar_14.x) - (tmpvar_14.y * tmpvar_14.y))
  )));
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    res_17 = max (((1.055 * 
      pow (max (res_17, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
    ) - 0.055), vec3(0.0, 0.0, 0.0));
  };
  ambientOrLightmapUV_15.xyz = res_17;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = texcoord_8;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = ambientOrLightmapUV_15;
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform samplerCube unity_SpecCube0;
uniform vec4 unity_SpecCube0_HDR;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform sampler2D _OcclusionMap;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
void main ()
{
  vec4 c_1;
  vec3 tmpvar_2;
  tmpvar_2 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_3;
  vec3 tmpvar_4;
  tmpvar_4 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_2, vec3(_Metallic));
  float tmpvar_5;
  tmpvar_5 = (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w));
  tmpvar_3 = (tmpvar_2 * tmpvar_5);
  vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD2_2.xyz);
  float tmpvar_7;
  tmpvar_7 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y;
  vec3 tmpvar_8;
  float tmpvar_9;
  tmpvar_9 = (1.0 - _Glossiness);
  tmpvar_8 = (xlv_TEXCOORD1 - (2.0 * (
    dot (tmpvar_6, xlv_TEXCOORD1)
   * tmpvar_6)));
  vec4 tmpvar_10;
  tmpvar_10.xyz = tmpvar_8;
  tmpvar_10.w = ((tmpvar_9 * (1.7 - 
    (0.7 * tmpvar_9)
  )) * 6.0);
  vec4 tmpvar_11;
  tmpvar_11 = textureCube (unity_SpecCube0, tmpvar_8, tmpvar_10.w);
  vec3 viewDir_12;
  viewDir_12 = -(xlv_TEXCOORD1);
  vec3 color_13;
  vec2 tmpvar_14;
  tmpvar_14.x = dot ((viewDir_12 - (2.0 * 
    (dot (tmpvar_6, viewDir_12) * tmpvar_6)
  )), _WorldSpaceLightPos0.xyz);
  tmpvar_14.y = (1.0 - clamp (dot (tmpvar_6, viewDir_12), 0.0, 1.0));
  vec2 tmpvar_15;
  tmpvar_15 = ((tmpvar_14 * tmpvar_14) * (tmpvar_14 * tmpvar_14));
  vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = tmpvar_9;
  color_13 = ((tmpvar_3 + (
    (texture2D (unity_NHxRoughness, tmpvar_16).w * 16.0)
   * tmpvar_4)) * (_LightColor0.xyz * clamp (
    dot (tmpvar_6, _WorldSpaceLightPos0.xyz)
  , 0.0, 1.0)));
  color_13 = (color_13 + ((
    (xlv_TEXCOORD5.xyz * tmpvar_7)
   * tmpvar_3) + (
    (((unity_SpecCube0_HDR.x * pow (tmpvar_11.w, unity_SpecCube0_HDR.y)) * tmpvar_11.xyz) * tmpvar_7)
   * 
    mix (tmpvar_4, vec3(clamp ((_Glossiness + (1.0 - tmpvar_5)), 0.0, 1.0)), tmpvar_15.yyy)
  )));
  vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = color_13;
  c_1.w = tmpvar_17.w;
  c_1.xyz = color_13;
  c_1.xyz = c_1.xyz;
  vec4 xlat_varoutput_18;
  xlat_varoutput_18.xyz = c_1.xyz;
  xlat_varoutput_18.w = 1.0;
  gl_FragData[0] = xlat_varoutput_18;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 120

#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD6;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec4 tmpvar_7;
  tmpvar_7 = (_Object2World * gl_Vertex);
  tmpvar_3 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_8;
  texcoord_8.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_9;
  if ((_UVSec == 0.0)) {
    tmpvar_9 = tmpvar_1;
  } else {
    tmpvar_9 = tmpvar_2;
  };
  texcoord_8.zw = ((tmpvar_9 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec3 tmpvar_10;
  tmpvar_10 = normalize((tmpvar_7.xyz - _WorldSpaceCameraPos));
  vec4 v_11;
  v_11.x = _World2Object[0].x;
  v_11.y = _World2Object[1].x;
  v_11.z = _World2Object[2].x;
  v_11.w = _World2Object[3].x;
  vec4 v_12;
  v_12.x = _World2Object[0].y;
  v_12.y = _World2Object[1].y;
  v_12.z = _World2Object[2].y;
  v_12.w = _World2Object[3].y;
  vec4 v_13;
  v_13.x = _World2Object[0].z;
  v_13.y = _World2Object[1].z;
  v_13.z = _World2Object[2].z;
  v_13.w = _World2Object[3].z;
  vec3 tmpvar_14;
  tmpvar_14 = normalize(((
    (v_11.xyz * gl_Normal.x)
   + 
    (v_12.xyz * gl_Normal.y)
  ) + (v_13.xyz * gl_Normal.z)));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_14;
  vec4 o_15;
  vec4 tmpvar_16;
  tmpvar_16 = (tmpvar_3 * 0.5);
  vec2 tmpvar_17;
  tmpvar_17.x = tmpvar_16.x;
  tmpvar_17.y = (tmpvar_16.y * _ProjectionParams.x);
  o_15.xy = (tmpvar_17 + tmpvar_16.w);
  o_15.zw = tmpvar_3.zw;
  vec4 ambientOrLightmapUV_18;
  ambientOrLightmapUV_18 = vec4(0.0, 0.0, 0.0, 0.0);
  vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = tmpvar_14;
  vec3 res_20;
  vec3 x_21;
  x_21.x = dot (unity_SHAr, tmpvar_19);
  x_21.y = dot (unity_SHAg, tmpvar_19);
  x_21.z = dot (unity_SHAb, tmpvar_19);
  vec3 x1_22;
  vec4 tmpvar_23;
  tmpvar_23 = (tmpvar_14.xyzz * tmpvar_14.yzzx);
  x1_22.x = dot (unity_SHBr, tmpvar_23);
  x1_22.y = dot (unity_SHBg, tmpvar_23);
  x1_22.z = dot (unity_SHBb, tmpvar_23);
  res_20 = (x_21 + (x1_22 + (unity_SHC.xyz * 
    ((tmpvar_14.x * tmpvar_14.x) - (tmpvar_14.y * tmpvar_14.y))
  )));
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    res_20 = max (((1.055 * 
      pow (max (res_20, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
    ) - 0.055), vec3(0.0, 0.0, 0.0));
  };
  ambientOrLightmapUV_18.xyz = res_20;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = texcoord_8;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = ambientOrLightmapUV_18;
  xlv_TEXCOORD6 = o_15;
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform samplerCube unity_SpecCube0;
uniform vec4 unity_SpecCube0_HDR;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform sampler2D _ShadowMapTexture;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD6;
void main ()
{
  vec4 c_1;
  vec3 tmpvar_2;
  tmpvar_2 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_3;
  vec3 tmpvar_4;
  tmpvar_4 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_2, vec3(_Metallic));
  float tmpvar_5;
  tmpvar_5 = (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w));
  tmpvar_3 = (tmpvar_2 * tmpvar_5);
  vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD2_2.xyz);
  float tmpvar_7;
  tmpvar_7 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y;
  vec3 tmpvar_8;
  float tmpvar_9;
  tmpvar_9 = (1.0 - _Glossiness);
  tmpvar_8 = (xlv_TEXCOORD1 - (2.0 * (
    dot (tmpvar_6, xlv_TEXCOORD1)
   * tmpvar_6)));
  vec4 tmpvar_10;
  tmpvar_10.xyz = tmpvar_8;
  tmpvar_10.w = ((tmpvar_9 * (1.7 - 
    (0.7 * tmpvar_9)
  )) * 6.0);
  vec4 tmpvar_11;
  tmpvar_11 = textureCube (unity_SpecCube0, tmpvar_8, tmpvar_10.w);
  vec3 viewDir_12;
  viewDir_12 = -(xlv_TEXCOORD1);
  vec3 color_13;
  vec2 tmpvar_14;
  tmpvar_14.x = dot ((viewDir_12 - (2.0 * 
    (dot (tmpvar_6, viewDir_12) * tmpvar_6)
  )), _WorldSpaceLightPos0.xyz);
  tmpvar_14.y = (1.0 - clamp (dot (tmpvar_6, viewDir_12), 0.0, 1.0));
  vec2 tmpvar_15;
  tmpvar_15 = ((tmpvar_14 * tmpvar_14) * (tmpvar_14 * tmpvar_14));
  vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = tmpvar_9;
  color_13 = ((tmpvar_3 + (
    (texture2D (unity_NHxRoughness, tmpvar_16).w * 16.0)
   * tmpvar_4)) * ((_LightColor0.xyz * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD6).x) * clamp (
    dot (tmpvar_6, _WorldSpaceLightPos0.xyz)
  , 0.0, 1.0)));
  color_13 = (color_13 + ((
    (xlv_TEXCOORD5.xyz * tmpvar_7)
   * tmpvar_3) + (
    (((unity_SpecCube0_HDR.x * pow (tmpvar_11.w, unity_SpecCube0_HDR.y)) * tmpvar_11.xyz) * tmpvar_7)
   * 
    mix (tmpvar_4, vec3(clamp ((_Glossiness + (1.0 - tmpvar_5)), 0.0, 1.0)), tmpvar_15.yyy)
  )));
  vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = color_13;
  c_1.w = tmpvar_17.w;
  c_1.xyz = color_13;
  c_1.xyz = c_1.xyz;
  vec4 xlat_varoutput_18;
  xlat_varoutput_18.xyz = c_1.xyz;
  xlat_varoutput_18.w = 1.0;
  gl_FragData[0] = xlat_varoutput_18;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"#version 120

#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 unity_4LightPosX0;
uniform vec4 unity_4LightPosY0;
uniform vec4 unity_4LightPosZ0;
uniform vec4 unity_4LightAtten0;
uniform vec4 unity_LightColor[8];
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec4 tmpvar_7;
  tmpvar_7 = (_Object2World * gl_Vertex);
  tmpvar_3 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_8;
  texcoord_8.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_9;
  if ((_UVSec == 0.0)) {
    tmpvar_9 = tmpvar_1;
  } else {
    tmpvar_9 = tmpvar_2;
  };
  texcoord_8.zw = ((tmpvar_9 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec3 tmpvar_10;
  tmpvar_10 = normalize((tmpvar_7.xyz - _WorldSpaceCameraPos));
  vec4 v_11;
  v_11.x = _World2Object[0].x;
  v_11.y = _World2Object[1].x;
  v_11.z = _World2Object[2].x;
  v_11.w = _World2Object[3].x;
  vec4 v_12;
  v_12.x = _World2Object[0].y;
  v_12.y = _World2Object[1].y;
  v_12.z = _World2Object[2].y;
  v_12.w = _World2Object[3].y;
  vec4 v_13;
  v_13.x = _World2Object[0].z;
  v_13.y = _World2Object[1].z;
  v_13.z = _World2Object[2].z;
  v_13.w = _World2Object[3].z;
  vec3 tmpvar_14;
  tmpvar_14 = normalize(((
    (v_11.xyz * gl_Normal.x)
   + 
    (v_12.xyz * gl_Normal.y)
  ) + (v_13.xyz * gl_Normal.z)));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_14;
  vec4 ambientOrLightmapUV_15;
  ambientOrLightmapUV_15.w = 0.0;
  vec3 col_16;
  vec4 ndotl_17;
  vec4 lengthSq_18;
  vec4 tmpvar_19;
  tmpvar_19 = (unity_4LightPosX0 - tmpvar_7.x);
  vec4 tmpvar_20;
  tmpvar_20 = (unity_4LightPosY0 - tmpvar_7.y);
  vec4 tmpvar_21;
  tmpvar_21 = (unity_4LightPosZ0 - tmpvar_7.z);
  lengthSq_18 = (tmpvar_19 * tmpvar_19);
  lengthSq_18 = (lengthSq_18 + (tmpvar_20 * tmpvar_20));
  lengthSq_18 = (lengthSq_18 + (tmpvar_21 * tmpvar_21));
  ndotl_17 = (tmpvar_19 * tmpvar_14.x);
  ndotl_17 = (ndotl_17 + (tmpvar_20 * tmpvar_14.y));
  ndotl_17 = (ndotl_17 + (tmpvar_21 * tmpvar_14.z));
  vec4 tmpvar_22;
  tmpvar_22 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_17 * inversesqrt(lengthSq_18)));
  ndotl_17 = tmpvar_22;
  vec4 tmpvar_23;
  tmpvar_23 = (tmpvar_22 * (1.0/((1.0 + 
    (lengthSq_18 * unity_4LightAtten0)
  ))));
  col_16 = (unity_LightColor[0].xyz * tmpvar_23.x);
  col_16 = (col_16 + (unity_LightColor[1].xyz * tmpvar_23.y));
  col_16 = (col_16 + (unity_LightColor[2].xyz * tmpvar_23.z));
  col_16 = (col_16 + (unity_LightColor[3].xyz * tmpvar_23.w));
  ambientOrLightmapUV_15.xyz = col_16;
  vec3 ambient_24;
  ambient_24 = ambientOrLightmapUV_15.xyz;
  vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = tmpvar_14;
  vec3 res_26;
  vec3 x_27;
  x_27.x = dot (unity_SHAr, tmpvar_25);
  x_27.y = dot (unity_SHAg, tmpvar_25);
  x_27.z = dot (unity_SHAb, tmpvar_25);
  vec3 x1_28;
  vec4 tmpvar_29;
  tmpvar_29 = (tmpvar_14.xyzz * tmpvar_14.yzzx);
  x1_28.x = dot (unity_SHBr, tmpvar_29);
  x1_28.y = dot (unity_SHBg, tmpvar_29);
  x1_28.z = dot (unity_SHBb, tmpvar_29);
  res_26 = (x_27 + (x1_28 + (unity_SHC.xyz * 
    ((tmpvar_14.x * tmpvar_14.x) - (tmpvar_14.y * tmpvar_14.y))
  )));
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    res_26 = max (((1.055 * 
      pow (max (res_26, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
    ) - 0.055), vec3(0.0, 0.0, 0.0));
  };
  ambient_24 = (col_16 + res_26);
  ambientOrLightmapUV_15.xyz = ambient_24;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = texcoord_8;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = ambientOrLightmapUV_15;
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform samplerCube unity_SpecCube0;
uniform vec4 unity_SpecCube0_HDR;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform sampler2D _OcclusionMap;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
void main ()
{
  vec4 c_1;
  vec3 tmpvar_2;
  tmpvar_2 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_3;
  vec3 tmpvar_4;
  tmpvar_4 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_2, vec3(_Metallic));
  float tmpvar_5;
  tmpvar_5 = (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w));
  tmpvar_3 = (tmpvar_2 * tmpvar_5);
  vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD2_2.xyz);
  float tmpvar_7;
  tmpvar_7 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y;
  vec3 tmpvar_8;
  float tmpvar_9;
  tmpvar_9 = (1.0 - _Glossiness);
  tmpvar_8 = (xlv_TEXCOORD1 - (2.0 * (
    dot (tmpvar_6, xlv_TEXCOORD1)
   * tmpvar_6)));
  vec4 tmpvar_10;
  tmpvar_10.xyz = tmpvar_8;
  tmpvar_10.w = ((tmpvar_9 * (1.7 - 
    (0.7 * tmpvar_9)
  )) * 6.0);
  vec4 tmpvar_11;
  tmpvar_11 = textureCube (unity_SpecCube0, tmpvar_8, tmpvar_10.w);
  vec3 viewDir_12;
  viewDir_12 = -(xlv_TEXCOORD1);
  vec3 color_13;
  vec2 tmpvar_14;
  tmpvar_14.x = dot ((viewDir_12 - (2.0 * 
    (dot (tmpvar_6, viewDir_12) * tmpvar_6)
  )), _WorldSpaceLightPos0.xyz);
  tmpvar_14.y = (1.0 - clamp (dot (tmpvar_6, viewDir_12), 0.0, 1.0));
  vec2 tmpvar_15;
  tmpvar_15 = ((tmpvar_14 * tmpvar_14) * (tmpvar_14 * tmpvar_14));
  vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = tmpvar_9;
  color_13 = ((tmpvar_3 + (
    (texture2D (unity_NHxRoughness, tmpvar_16).w * 16.0)
   * tmpvar_4)) * (_LightColor0.xyz * clamp (
    dot (tmpvar_6, _WorldSpaceLightPos0.xyz)
  , 0.0, 1.0)));
  color_13 = (color_13 + ((
    (xlv_TEXCOORD5.xyz * tmpvar_7)
   * tmpvar_3) + (
    (((unity_SpecCube0_HDR.x * pow (tmpvar_11.w, unity_SpecCube0_HDR.y)) * tmpvar_11.xyz) * tmpvar_7)
   * 
    mix (tmpvar_4, vec3(clamp ((_Glossiness + (1.0 - tmpvar_5)), 0.0, 1.0)), tmpvar_15.yyy)
  )));
  vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = color_13;
  c_1.w = tmpvar_17.w;
  c_1.xyz = color_13;
  c_1.xyz = c_1.xyz;
  vec4 xlat_varoutput_18;
  xlat_varoutput_18.xyz = c_1.xyz;
  xlat_varoutput_18.w = 1.0;
  gl_FragData[0] = xlat_varoutput_18;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"#version 120

#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;
uniform vec4 unity_4LightPosX0;
uniform vec4 unity_4LightPosY0;
uniform vec4 unity_4LightPosZ0;
uniform vec4 unity_4LightAtten0;
uniform vec4 unity_LightColor[8];
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD6;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec4 tmpvar_7;
  tmpvar_7 = (_Object2World * gl_Vertex);
  tmpvar_3 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_8;
  texcoord_8.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_9;
  if ((_UVSec == 0.0)) {
    tmpvar_9 = tmpvar_1;
  } else {
    tmpvar_9 = tmpvar_2;
  };
  texcoord_8.zw = ((tmpvar_9 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec3 tmpvar_10;
  tmpvar_10 = normalize((tmpvar_7.xyz - _WorldSpaceCameraPos));
  vec4 v_11;
  v_11.x = _World2Object[0].x;
  v_11.y = _World2Object[1].x;
  v_11.z = _World2Object[2].x;
  v_11.w = _World2Object[3].x;
  vec4 v_12;
  v_12.x = _World2Object[0].y;
  v_12.y = _World2Object[1].y;
  v_12.z = _World2Object[2].y;
  v_12.w = _World2Object[3].y;
  vec4 v_13;
  v_13.x = _World2Object[0].z;
  v_13.y = _World2Object[1].z;
  v_13.z = _World2Object[2].z;
  v_13.w = _World2Object[3].z;
  vec3 tmpvar_14;
  tmpvar_14 = normalize(((
    (v_11.xyz * gl_Normal.x)
   + 
    (v_12.xyz * gl_Normal.y)
  ) + (v_13.xyz * gl_Normal.z)));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_14;
  vec4 o_15;
  vec4 tmpvar_16;
  tmpvar_16 = (tmpvar_3 * 0.5);
  vec2 tmpvar_17;
  tmpvar_17.x = tmpvar_16.x;
  tmpvar_17.y = (tmpvar_16.y * _ProjectionParams.x);
  o_15.xy = (tmpvar_17 + tmpvar_16.w);
  o_15.zw = tmpvar_3.zw;
  vec4 ambientOrLightmapUV_18;
  ambientOrLightmapUV_18.w = 0.0;
  vec3 col_19;
  vec4 ndotl_20;
  vec4 lengthSq_21;
  vec4 tmpvar_22;
  tmpvar_22 = (unity_4LightPosX0 - tmpvar_7.x);
  vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosY0 - tmpvar_7.y);
  vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosZ0 - tmpvar_7.z);
  lengthSq_21 = (tmpvar_22 * tmpvar_22);
  lengthSq_21 = (lengthSq_21 + (tmpvar_23 * tmpvar_23));
  lengthSq_21 = (lengthSq_21 + (tmpvar_24 * tmpvar_24));
  ndotl_20 = (tmpvar_22 * tmpvar_14.x);
  ndotl_20 = (ndotl_20 + (tmpvar_23 * tmpvar_14.y));
  ndotl_20 = (ndotl_20 + (tmpvar_24 * tmpvar_14.z));
  vec4 tmpvar_25;
  tmpvar_25 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_20 * inversesqrt(lengthSq_21)));
  ndotl_20 = tmpvar_25;
  vec4 tmpvar_26;
  tmpvar_26 = (tmpvar_25 * (1.0/((1.0 + 
    (lengthSq_21 * unity_4LightAtten0)
  ))));
  col_19 = (unity_LightColor[0].xyz * tmpvar_26.x);
  col_19 = (col_19 + (unity_LightColor[1].xyz * tmpvar_26.y));
  col_19 = (col_19 + (unity_LightColor[2].xyz * tmpvar_26.z));
  col_19 = (col_19 + (unity_LightColor[3].xyz * tmpvar_26.w));
  ambientOrLightmapUV_18.xyz = col_19;
  vec3 ambient_27;
  ambient_27 = ambientOrLightmapUV_18.xyz;
  vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xyz = tmpvar_14;
  vec3 res_29;
  vec3 x_30;
  x_30.x = dot (unity_SHAr, tmpvar_28);
  x_30.y = dot (unity_SHAg, tmpvar_28);
  x_30.z = dot (unity_SHAb, tmpvar_28);
  vec3 x1_31;
  vec4 tmpvar_32;
  tmpvar_32 = (tmpvar_14.xyzz * tmpvar_14.yzzx);
  x1_31.x = dot (unity_SHBr, tmpvar_32);
  x1_31.y = dot (unity_SHBg, tmpvar_32);
  x1_31.z = dot (unity_SHBb, tmpvar_32);
  res_29 = (x_30 + (x1_31 + (unity_SHC.xyz * 
    ((tmpvar_14.x * tmpvar_14.x) - (tmpvar_14.y * tmpvar_14.y))
  )));
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    res_29 = max (((1.055 * 
      pow (max (res_29, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
    ) - 0.055), vec3(0.0, 0.0, 0.0));
  };
  ambient_27 = (col_19 + res_29);
  ambientOrLightmapUV_18.xyz = ambient_27;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = texcoord_8;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = ambientOrLightmapUV_18;
  xlv_TEXCOORD6 = o_15;
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform samplerCube unity_SpecCube0;
uniform vec4 unity_SpecCube0_HDR;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform sampler2D _ShadowMapTexture;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD6;
void main ()
{
  vec4 c_1;
  vec3 tmpvar_2;
  tmpvar_2 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_3;
  vec3 tmpvar_4;
  tmpvar_4 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_2, vec3(_Metallic));
  float tmpvar_5;
  tmpvar_5 = (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w));
  tmpvar_3 = (tmpvar_2 * tmpvar_5);
  vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD2_2.xyz);
  float tmpvar_7;
  tmpvar_7 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y;
  vec3 tmpvar_8;
  float tmpvar_9;
  tmpvar_9 = (1.0 - _Glossiness);
  tmpvar_8 = (xlv_TEXCOORD1 - (2.0 * (
    dot (tmpvar_6, xlv_TEXCOORD1)
   * tmpvar_6)));
  vec4 tmpvar_10;
  tmpvar_10.xyz = tmpvar_8;
  tmpvar_10.w = ((tmpvar_9 * (1.7 - 
    (0.7 * tmpvar_9)
  )) * 6.0);
  vec4 tmpvar_11;
  tmpvar_11 = textureCube (unity_SpecCube0, tmpvar_8, tmpvar_10.w);
  vec3 viewDir_12;
  viewDir_12 = -(xlv_TEXCOORD1);
  vec3 color_13;
  vec2 tmpvar_14;
  tmpvar_14.x = dot ((viewDir_12 - (2.0 * 
    (dot (tmpvar_6, viewDir_12) * tmpvar_6)
  )), _WorldSpaceLightPos0.xyz);
  tmpvar_14.y = (1.0 - clamp (dot (tmpvar_6, viewDir_12), 0.0, 1.0));
  vec2 tmpvar_15;
  tmpvar_15 = ((tmpvar_14 * tmpvar_14) * (tmpvar_14 * tmpvar_14));
  vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = tmpvar_9;
  color_13 = ((tmpvar_3 + (
    (texture2D (unity_NHxRoughness, tmpvar_16).w * 16.0)
   * tmpvar_4)) * ((_LightColor0.xyz * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD6).x) * clamp (
    dot (tmpvar_6, _WorldSpaceLightPos0.xyz)
  , 0.0, 1.0)));
  color_13 = (color_13 + ((
    (xlv_TEXCOORD5.xyz * tmpvar_7)
   * tmpvar_3) + (
    (((unity_SpecCube0_HDR.x * pow (tmpvar_11.w, unity_SpecCube0_HDR.y)) * tmpvar_11.xyz) * tmpvar_7)
   * 
    mix (tmpvar_4, vec3(clamp ((_Glossiness + (1.0 - tmpvar_5)), 0.0, 1.0)), tmpvar_15.yyy)
  )));
  vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = color_13;
  c_1.w = tmpvar_17.w;
  c_1.xyz = color_13;
  c_1.xyz = c_1.xyz;
  vec4 xlat_varoutput_18;
  xlat_varoutput_18.xyz = c_1.xyz;
  xlat_varoutput_18.w = 1.0;
  gl_FragData[0] = xlat_varoutput_18;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "_EMISSION" }
"#version 120

#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec4 tmpvar_7;
  tmpvar_7 = (_Object2World * gl_Vertex);
  tmpvar_3 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_8;
  texcoord_8.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_9;
  if ((_UVSec == 0.0)) {
    tmpvar_9 = tmpvar_1;
  } else {
    tmpvar_9 = tmpvar_2;
  };
  texcoord_8.zw = ((tmpvar_9 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec3 tmpvar_10;
  tmpvar_10 = normalize((tmpvar_7.xyz - _WorldSpaceCameraPos));
  vec4 v_11;
  v_11.x = _World2Object[0].x;
  v_11.y = _World2Object[1].x;
  v_11.z = _World2Object[2].x;
  v_11.w = _World2Object[3].x;
  vec4 v_12;
  v_12.x = _World2Object[0].y;
  v_12.y = _World2Object[1].y;
  v_12.z = _World2Object[2].y;
  v_12.w = _World2Object[3].y;
  vec4 v_13;
  v_13.x = _World2Object[0].z;
  v_13.y = _World2Object[1].z;
  v_13.z = _World2Object[2].z;
  v_13.w = _World2Object[3].z;
  vec3 tmpvar_14;
  tmpvar_14 = normalize(((
    (v_11.xyz * gl_Normal.x)
   + 
    (v_12.xyz * gl_Normal.y)
  ) + (v_13.xyz * gl_Normal.z)));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_14;
  vec4 ambientOrLightmapUV_15;
  ambientOrLightmapUV_15 = vec4(0.0, 0.0, 0.0, 0.0);
  vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_14;
  vec3 res_17;
  vec3 x_18;
  x_18.x = dot (unity_SHAr, tmpvar_16);
  x_18.y = dot (unity_SHAg, tmpvar_16);
  x_18.z = dot (unity_SHAb, tmpvar_16);
  vec3 x1_19;
  vec4 tmpvar_20;
  tmpvar_20 = (tmpvar_14.xyzz * tmpvar_14.yzzx);
  x1_19.x = dot (unity_SHBr, tmpvar_20);
  x1_19.y = dot (unity_SHBg, tmpvar_20);
  x1_19.z = dot (unity_SHBb, tmpvar_20);
  res_17 = (x_18 + (x1_19 + (unity_SHC.xyz * 
    ((tmpvar_14.x * tmpvar_14.x) - (tmpvar_14.y * tmpvar_14.y))
  )));
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    res_17 = max (((1.055 * 
      pow (max (res_17, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
    ) - 0.055), vec3(0.0, 0.0, 0.0));
  };
  ambientOrLightmapUV_15.xyz = res_17;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = texcoord_8;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = ambientOrLightmapUV_15;
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform samplerCube unity_SpecCube0;
uniform vec4 unity_SpecCube0_HDR;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform vec4 _EmissionColor;
uniform sampler2D _EmissionMap;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
void main ()
{
  vec4 c_1;
  vec3 tmpvar_2;
  tmpvar_2 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_3;
  vec3 tmpvar_4;
  tmpvar_4 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_2, vec3(_Metallic));
  float tmpvar_5;
  tmpvar_5 = (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w));
  tmpvar_3 = (tmpvar_2 * tmpvar_5);
  vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD2_2.xyz);
  float tmpvar_7;
  tmpvar_7 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y;
  vec3 tmpvar_8;
  float tmpvar_9;
  tmpvar_9 = (1.0 - _Glossiness);
  tmpvar_8 = (xlv_TEXCOORD1 - (2.0 * (
    dot (tmpvar_6, xlv_TEXCOORD1)
   * tmpvar_6)));
  vec4 tmpvar_10;
  tmpvar_10.xyz = tmpvar_8;
  tmpvar_10.w = ((tmpvar_9 * (1.7 - 
    (0.7 * tmpvar_9)
  )) * 6.0);
  vec4 tmpvar_11;
  tmpvar_11 = textureCube (unity_SpecCube0, tmpvar_8, tmpvar_10.w);
  vec3 viewDir_12;
  viewDir_12 = -(xlv_TEXCOORD1);
  vec3 color_13;
  vec2 tmpvar_14;
  tmpvar_14.x = dot ((viewDir_12 - (2.0 * 
    (dot (tmpvar_6, viewDir_12) * tmpvar_6)
  )), _WorldSpaceLightPos0.xyz);
  tmpvar_14.y = (1.0 - clamp (dot (tmpvar_6, viewDir_12), 0.0, 1.0));
  vec2 tmpvar_15;
  tmpvar_15 = ((tmpvar_14 * tmpvar_14) * (tmpvar_14 * tmpvar_14));
  vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = tmpvar_9;
  color_13 = ((tmpvar_3 + (
    (texture2D (unity_NHxRoughness, tmpvar_16).w * 16.0)
   * tmpvar_4)) * (_LightColor0.xyz * clamp (
    dot (tmpvar_6, _WorldSpaceLightPos0.xyz)
  , 0.0, 1.0)));
  color_13 = (color_13 + ((
    (xlv_TEXCOORD5.xyz * tmpvar_7)
   * tmpvar_3) + (
    (((unity_SpecCube0_HDR.x * pow (tmpvar_11.w, unity_SpecCube0_HDR.y)) * tmpvar_11.xyz) * tmpvar_7)
   * 
    mix (tmpvar_4, vec3(clamp ((_Glossiness + (1.0 - tmpvar_5)), 0.0, 1.0)), tmpvar_15.yyy)
  )));
  vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = color_13;
  c_1.w = tmpvar_17.w;
  c_1.xyz = (color_13 + (texture2D (_EmissionMap, xlv_TEXCOORD0.xy).xyz * _EmissionColor.xyz));
  vec4 xlat_varoutput_18;
  xlat_varoutput_18.xyz = c_1.xyz;
  xlat_varoutput_18.w = 1.0;
  gl_FragData[0] = xlat_varoutput_18;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "_EMISSION" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "_EMISSION" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "_EMISSION" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "_EMISSION" }
"#version 120

#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD6;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec4 tmpvar_7;
  tmpvar_7 = (_Object2World * gl_Vertex);
  tmpvar_3 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_8;
  texcoord_8.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_9;
  if ((_UVSec == 0.0)) {
    tmpvar_9 = tmpvar_1;
  } else {
    tmpvar_9 = tmpvar_2;
  };
  texcoord_8.zw = ((tmpvar_9 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec3 tmpvar_10;
  tmpvar_10 = normalize((tmpvar_7.xyz - _WorldSpaceCameraPos));
  vec4 v_11;
  v_11.x = _World2Object[0].x;
  v_11.y = _World2Object[1].x;
  v_11.z = _World2Object[2].x;
  v_11.w = _World2Object[3].x;
  vec4 v_12;
  v_12.x = _World2Object[0].y;
  v_12.y = _World2Object[1].y;
  v_12.z = _World2Object[2].y;
  v_12.w = _World2Object[3].y;
  vec4 v_13;
  v_13.x = _World2Object[0].z;
  v_13.y = _World2Object[1].z;
  v_13.z = _World2Object[2].z;
  v_13.w = _World2Object[3].z;
  vec3 tmpvar_14;
  tmpvar_14 = normalize(((
    (v_11.xyz * gl_Normal.x)
   + 
    (v_12.xyz * gl_Normal.y)
  ) + (v_13.xyz * gl_Normal.z)));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_14;
  vec4 o_15;
  vec4 tmpvar_16;
  tmpvar_16 = (tmpvar_3 * 0.5);
  vec2 tmpvar_17;
  tmpvar_17.x = tmpvar_16.x;
  tmpvar_17.y = (tmpvar_16.y * _ProjectionParams.x);
  o_15.xy = (tmpvar_17 + tmpvar_16.w);
  o_15.zw = tmpvar_3.zw;
  vec4 ambientOrLightmapUV_18;
  ambientOrLightmapUV_18 = vec4(0.0, 0.0, 0.0, 0.0);
  vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = tmpvar_14;
  vec3 res_20;
  vec3 x_21;
  x_21.x = dot (unity_SHAr, tmpvar_19);
  x_21.y = dot (unity_SHAg, tmpvar_19);
  x_21.z = dot (unity_SHAb, tmpvar_19);
  vec3 x1_22;
  vec4 tmpvar_23;
  tmpvar_23 = (tmpvar_14.xyzz * tmpvar_14.yzzx);
  x1_22.x = dot (unity_SHBr, tmpvar_23);
  x1_22.y = dot (unity_SHBg, tmpvar_23);
  x1_22.z = dot (unity_SHBb, tmpvar_23);
  res_20 = (x_21 + (x1_22 + (unity_SHC.xyz * 
    ((tmpvar_14.x * tmpvar_14.x) - (tmpvar_14.y * tmpvar_14.y))
  )));
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    res_20 = max (((1.055 * 
      pow (max (res_20, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
    ) - 0.055), vec3(0.0, 0.0, 0.0));
  };
  ambientOrLightmapUV_18.xyz = res_20;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = texcoord_8;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = ambientOrLightmapUV_18;
  xlv_TEXCOORD6 = o_15;
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform samplerCube unity_SpecCube0;
uniform vec4 unity_SpecCube0_HDR;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform vec4 _EmissionColor;
uniform sampler2D _EmissionMap;
uniform sampler2D _ShadowMapTexture;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD6;
void main ()
{
  vec4 c_1;
  vec3 tmpvar_2;
  tmpvar_2 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_3;
  vec3 tmpvar_4;
  tmpvar_4 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_2, vec3(_Metallic));
  float tmpvar_5;
  tmpvar_5 = (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w));
  tmpvar_3 = (tmpvar_2 * tmpvar_5);
  vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD2_2.xyz);
  float tmpvar_7;
  tmpvar_7 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y;
  vec3 tmpvar_8;
  float tmpvar_9;
  tmpvar_9 = (1.0 - _Glossiness);
  tmpvar_8 = (xlv_TEXCOORD1 - (2.0 * (
    dot (tmpvar_6, xlv_TEXCOORD1)
   * tmpvar_6)));
  vec4 tmpvar_10;
  tmpvar_10.xyz = tmpvar_8;
  tmpvar_10.w = ((tmpvar_9 * (1.7 - 
    (0.7 * tmpvar_9)
  )) * 6.0);
  vec4 tmpvar_11;
  tmpvar_11 = textureCube (unity_SpecCube0, tmpvar_8, tmpvar_10.w);
  vec3 viewDir_12;
  viewDir_12 = -(xlv_TEXCOORD1);
  vec3 color_13;
  vec2 tmpvar_14;
  tmpvar_14.x = dot ((viewDir_12 - (2.0 * 
    (dot (tmpvar_6, viewDir_12) * tmpvar_6)
  )), _WorldSpaceLightPos0.xyz);
  tmpvar_14.y = (1.0 - clamp (dot (tmpvar_6, viewDir_12), 0.0, 1.0));
  vec2 tmpvar_15;
  tmpvar_15 = ((tmpvar_14 * tmpvar_14) * (tmpvar_14 * tmpvar_14));
  vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = tmpvar_9;
  color_13 = ((tmpvar_3 + (
    (texture2D (unity_NHxRoughness, tmpvar_16).w * 16.0)
   * tmpvar_4)) * ((_LightColor0.xyz * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD6).x) * clamp (
    dot (tmpvar_6, _WorldSpaceLightPos0.xyz)
  , 0.0, 1.0)));
  color_13 = (color_13 + ((
    (xlv_TEXCOORD5.xyz * tmpvar_7)
   * tmpvar_3) + (
    (((unity_SpecCube0_HDR.x * pow (tmpvar_11.w, unity_SpecCube0_HDR.y)) * tmpvar_11.xyz) * tmpvar_7)
   * 
    mix (tmpvar_4, vec3(clamp ((_Glossiness + (1.0 - tmpvar_5)), 0.0, 1.0)), tmpvar_15.yyy)
  )));
  vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = color_13;
  c_1.w = tmpvar_17.w;
  c_1.xyz = (color_13 + (texture2D (_EmissionMap, xlv_TEXCOORD0.xy).xyz * _EmissionColor.xyz));
  vec4 xlat_varoutput_18;
  xlat_varoutput_18.xyz = c_1.xyz;
  xlat_varoutput_18.w = 1.0;
  gl_FragData[0] = xlat_varoutput_18;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "_EMISSION" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "_EMISSION" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "_EMISSION" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "_EMISSION" "VERTEXLIGHT_ON" }
"#version 120

#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 unity_4LightPosX0;
uniform vec4 unity_4LightPosY0;
uniform vec4 unity_4LightPosZ0;
uniform vec4 unity_4LightAtten0;
uniform vec4 unity_LightColor[8];
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec4 tmpvar_7;
  tmpvar_7 = (_Object2World * gl_Vertex);
  tmpvar_3 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_8;
  texcoord_8.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_9;
  if ((_UVSec == 0.0)) {
    tmpvar_9 = tmpvar_1;
  } else {
    tmpvar_9 = tmpvar_2;
  };
  texcoord_8.zw = ((tmpvar_9 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec3 tmpvar_10;
  tmpvar_10 = normalize((tmpvar_7.xyz - _WorldSpaceCameraPos));
  vec4 v_11;
  v_11.x = _World2Object[0].x;
  v_11.y = _World2Object[1].x;
  v_11.z = _World2Object[2].x;
  v_11.w = _World2Object[3].x;
  vec4 v_12;
  v_12.x = _World2Object[0].y;
  v_12.y = _World2Object[1].y;
  v_12.z = _World2Object[2].y;
  v_12.w = _World2Object[3].y;
  vec4 v_13;
  v_13.x = _World2Object[0].z;
  v_13.y = _World2Object[1].z;
  v_13.z = _World2Object[2].z;
  v_13.w = _World2Object[3].z;
  vec3 tmpvar_14;
  tmpvar_14 = normalize(((
    (v_11.xyz * gl_Normal.x)
   + 
    (v_12.xyz * gl_Normal.y)
  ) + (v_13.xyz * gl_Normal.z)));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_14;
  vec4 ambientOrLightmapUV_15;
  ambientOrLightmapUV_15.w = 0.0;
  vec3 col_16;
  vec4 ndotl_17;
  vec4 lengthSq_18;
  vec4 tmpvar_19;
  tmpvar_19 = (unity_4LightPosX0 - tmpvar_7.x);
  vec4 tmpvar_20;
  tmpvar_20 = (unity_4LightPosY0 - tmpvar_7.y);
  vec4 tmpvar_21;
  tmpvar_21 = (unity_4LightPosZ0 - tmpvar_7.z);
  lengthSq_18 = (tmpvar_19 * tmpvar_19);
  lengthSq_18 = (lengthSq_18 + (tmpvar_20 * tmpvar_20));
  lengthSq_18 = (lengthSq_18 + (tmpvar_21 * tmpvar_21));
  ndotl_17 = (tmpvar_19 * tmpvar_14.x);
  ndotl_17 = (ndotl_17 + (tmpvar_20 * tmpvar_14.y));
  ndotl_17 = (ndotl_17 + (tmpvar_21 * tmpvar_14.z));
  vec4 tmpvar_22;
  tmpvar_22 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_17 * inversesqrt(lengthSq_18)));
  ndotl_17 = tmpvar_22;
  vec4 tmpvar_23;
  tmpvar_23 = (tmpvar_22 * (1.0/((1.0 + 
    (lengthSq_18 * unity_4LightAtten0)
  ))));
  col_16 = (unity_LightColor[0].xyz * tmpvar_23.x);
  col_16 = (col_16 + (unity_LightColor[1].xyz * tmpvar_23.y));
  col_16 = (col_16 + (unity_LightColor[2].xyz * tmpvar_23.z));
  col_16 = (col_16 + (unity_LightColor[3].xyz * tmpvar_23.w));
  ambientOrLightmapUV_15.xyz = col_16;
  vec3 ambient_24;
  ambient_24 = ambientOrLightmapUV_15.xyz;
  vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = tmpvar_14;
  vec3 res_26;
  vec3 x_27;
  x_27.x = dot (unity_SHAr, tmpvar_25);
  x_27.y = dot (unity_SHAg, tmpvar_25);
  x_27.z = dot (unity_SHAb, tmpvar_25);
  vec3 x1_28;
  vec4 tmpvar_29;
  tmpvar_29 = (tmpvar_14.xyzz * tmpvar_14.yzzx);
  x1_28.x = dot (unity_SHBr, tmpvar_29);
  x1_28.y = dot (unity_SHBg, tmpvar_29);
  x1_28.z = dot (unity_SHBb, tmpvar_29);
  res_26 = (x_27 + (x1_28 + (unity_SHC.xyz * 
    ((tmpvar_14.x * tmpvar_14.x) - (tmpvar_14.y * tmpvar_14.y))
  )));
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    res_26 = max (((1.055 * 
      pow (max (res_26, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
    ) - 0.055), vec3(0.0, 0.0, 0.0));
  };
  ambient_24 = (col_16 + res_26);
  ambientOrLightmapUV_15.xyz = ambient_24;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = texcoord_8;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = ambientOrLightmapUV_15;
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform samplerCube unity_SpecCube0;
uniform vec4 unity_SpecCube0_HDR;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform vec4 _EmissionColor;
uniform sampler2D _EmissionMap;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
void main ()
{
  vec4 c_1;
  vec3 tmpvar_2;
  tmpvar_2 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_3;
  vec3 tmpvar_4;
  tmpvar_4 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_2, vec3(_Metallic));
  float tmpvar_5;
  tmpvar_5 = (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w));
  tmpvar_3 = (tmpvar_2 * tmpvar_5);
  vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD2_2.xyz);
  float tmpvar_7;
  tmpvar_7 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y;
  vec3 tmpvar_8;
  float tmpvar_9;
  tmpvar_9 = (1.0 - _Glossiness);
  tmpvar_8 = (xlv_TEXCOORD1 - (2.0 * (
    dot (tmpvar_6, xlv_TEXCOORD1)
   * tmpvar_6)));
  vec4 tmpvar_10;
  tmpvar_10.xyz = tmpvar_8;
  tmpvar_10.w = ((tmpvar_9 * (1.7 - 
    (0.7 * tmpvar_9)
  )) * 6.0);
  vec4 tmpvar_11;
  tmpvar_11 = textureCube (unity_SpecCube0, tmpvar_8, tmpvar_10.w);
  vec3 viewDir_12;
  viewDir_12 = -(xlv_TEXCOORD1);
  vec3 color_13;
  vec2 tmpvar_14;
  tmpvar_14.x = dot ((viewDir_12 - (2.0 * 
    (dot (tmpvar_6, viewDir_12) * tmpvar_6)
  )), _WorldSpaceLightPos0.xyz);
  tmpvar_14.y = (1.0 - clamp (dot (tmpvar_6, viewDir_12), 0.0, 1.0));
  vec2 tmpvar_15;
  tmpvar_15 = ((tmpvar_14 * tmpvar_14) * (tmpvar_14 * tmpvar_14));
  vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = tmpvar_9;
  color_13 = ((tmpvar_3 + (
    (texture2D (unity_NHxRoughness, tmpvar_16).w * 16.0)
   * tmpvar_4)) * (_LightColor0.xyz * clamp (
    dot (tmpvar_6, _WorldSpaceLightPos0.xyz)
  , 0.0, 1.0)));
  color_13 = (color_13 + ((
    (xlv_TEXCOORD5.xyz * tmpvar_7)
   * tmpvar_3) + (
    (((unity_SpecCube0_HDR.x * pow (tmpvar_11.w, unity_SpecCube0_HDR.y)) * tmpvar_11.xyz) * tmpvar_7)
   * 
    mix (tmpvar_4, vec3(clamp ((_Glossiness + (1.0 - tmpvar_5)), 0.0, 1.0)), tmpvar_15.yyy)
  )));
  vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = color_13;
  c_1.w = tmpvar_17.w;
  c_1.xyz = (color_13 + (texture2D (_EmissionMap, xlv_TEXCOORD0.xy).xyz * _EmissionColor.xyz));
  vec4 xlat_varoutput_18;
  xlat_varoutput_18.xyz = c_1.xyz;
  xlat_varoutput_18.w = 1.0;
  gl_FragData[0] = xlat_varoutput_18;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "_EMISSION" "VERTEXLIGHT_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "_EMISSION" "VERTEXLIGHT_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "_EMISSION" "VERTEXLIGHT_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "_EMISSION" "VERTEXLIGHT_ON" }
"#version 120

#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;
uniform vec4 unity_4LightPosX0;
uniform vec4 unity_4LightPosY0;
uniform vec4 unity_4LightPosZ0;
uniform vec4 unity_4LightAtten0;
uniform vec4 unity_LightColor[8];
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_ColorSpaceLuminance;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD6;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec4 tmpvar_7;
  tmpvar_7 = (_Object2World * gl_Vertex);
  tmpvar_3 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_8;
  texcoord_8.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_9;
  if ((_UVSec == 0.0)) {
    tmpvar_9 = tmpvar_1;
  } else {
    tmpvar_9 = tmpvar_2;
  };
  texcoord_8.zw = ((tmpvar_9 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec3 tmpvar_10;
  tmpvar_10 = normalize((tmpvar_7.xyz - _WorldSpaceCameraPos));
  vec4 v_11;
  v_11.x = _World2Object[0].x;
  v_11.y = _World2Object[1].x;
  v_11.z = _World2Object[2].x;
  v_11.w = _World2Object[3].x;
  vec4 v_12;
  v_12.x = _World2Object[0].y;
  v_12.y = _World2Object[1].y;
  v_12.z = _World2Object[2].y;
  v_12.w = _World2Object[3].y;
  vec4 v_13;
  v_13.x = _World2Object[0].z;
  v_13.y = _World2Object[1].z;
  v_13.z = _World2Object[2].z;
  v_13.w = _World2Object[3].z;
  vec3 tmpvar_14;
  tmpvar_14 = normalize(((
    (v_11.xyz * gl_Normal.x)
   + 
    (v_12.xyz * gl_Normal.y)
  ) + (v_13.xyz * gl_Normal.z)));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_14;
  vec4 o_15;
  vec4 tmpvar_16;
  tmpvar_16 = (tmpvar_3 * 0.5);
  vec2 tmpvar_17;
  tmpvar_17.x = tmpvar_16.x;
  tmpvar_17.y = (tmpvar_16.y * _ProjectionParams.x);
  o_15.xy = (tmpvar_17 + tmpvar_16.w);
  o_15.zw = tmpvar_3.zw;
  vec4 ambientOrLightmapUV_18;
  ambientOrLightmapUV_18.w = 0.0;
  vec3 col_19;
  vec4 ndotl_20;
  vec4 lengthSq_21;
  vec4 tmpvar_22;
  tmpvar_22 = (unity_4LightPosX0 - tmpvar_7.x);
  vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosY0 - tmpvar_7.y);
  vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosZ0 - tmpvar_7.z);
  lengthSq_21 = (tmpvar_22 * tmpvar_22);
  lengthSq_21 = (lengthSq_21 + (tmpvar_23 * tmpvar_23));
  lengthSq_21 = (lengthSq_21 + (tmpvar_24 * tmpvar_24));
  ndotl_20 = (tmpvar_22 * tmpvar_14.x);
  ndotl_20 = (ndotl_20 + (tmpvar_23 * tmpvar_14.y));
  ndotl_20 = (ndotl_20 + (tmpvar_24 * tmpvar_14.z));
  vec4 tmpvar_25;
  tmpvar_25 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_20 * inversesqrt(lengthSq_21)));
  ndotl_20 = tmpvar_25;
  vec4 tmpvar_26;
  tmpvar_26 = (tmpvar_25 * (1.0/((1.0 + 
    (lengthSq_21 * unity_4LightAtten0)
  ))));
  col_19 = (unity_LightColor[0].xyz * tmpvar_26.x);
  col_19 = (col_19 + (unity_LightColor[1].xyz * tmpvar_26.y));
  col_19 = (col_19 + (unity_LightColor[2].xyz * tmpvar_26.z));
  col_19 = (col_19 + (unity_LightColor[3].xyz * tmpvar_26.w));
  ambientOrLightmapUV_18.xyz = col_19;
  vec3 ambient_27;
  ambient_27 = ambientOrLightmapUV_18.xyz;
  vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xyz = tmpvar_14;
  vec3 res_29;
  vec3 x_30;
  x_30.x = dot (unity_SHAr, tmpvar_28);
  x_30.y = dot (unity_SHAg, tmpvar_28);
  x_30.z = dot (unity_SHAb, tmpvar_28);
  vec3 x1_31;
  vec4 tmpvar_32;
  tmpvar_32 = (tmpvar_14.xyzz * tmpvar_14.yzzx);
  x1_31.x = dot (unity_SHBr, tmpvar_32);
  x1_31.y = dot (unity_SHBg, tmpvar_32);
  x1_31.z = dot (unity_SHBb, tmpvar_32);
  res_29 = (x_30 + (x1_31 + (unity_SHC.xyz * 
    ((tmpvar_14.x * tmpvar_14.x) - (tmpvar_14.y * tmpvar_14.y))
  )));
  if ((unity_ColorSpaceLuminance.w == 0.0)) {
    res_29 = max (((1.055 * 
      pow (max (res_29, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
    ) - 0.055), vec3(0.0, 0.0, 0.0));
  };
  ambient_27 = (col_19 + res_29);
  ambientOrLightmapUV_18.xyz = ambient_27;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = texcoord_8;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = ambientOrLightmapUV_18;
  xlv_TEXCOORD6 = o_15;
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform samplerCube unity_SpecCube0;
uniform vec4 unity_SpecCube0_HDR;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform vec4 _EmissionColor;
uniform sampler2D _EmissionMap;
uniform sampler2D _ShadowMapTexture;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD6;
void main ()
{
  vec4 c_1;
  vec3 tmpvar_2;
  tmpvar_2 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_3;
  vec3 tmpvar_4;
  tmpvar_4 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_2, vec3(_Metallic));
  float tmpvar_5;
  tmpvar_5 = (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w));
  tmpvar_3 = (tmpvar_2 * tmpvar_5);
  vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD2_2.xyz);
  float tmpvar_7;
  tmpvar_7 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y;
  vec3 tmpvar_8;
  float tmpvar_9;
  tmpvar_9 = (1.0 - _Glossiness);
  tmpvar_8 = (xlv_TEXCOORD1 - (2.0 * (
    dot (tmpvar_6, xlv_TEXCOORD1)
   * tmpvar_6)));
  vec4 tmpvar_10;
  tmpvar_10.xyz = tmpvar_8;
  tmpvar_10.w = ((tmpvar_9 * (1.7 - 
    (0.7 * tmpvar_9)
  )) * 6.0);
  vec4 tmpvar_11;
  tmpvar_11 = textureCube (unity_SpecCube0, tmpvar_8, tmpvar_10.w);
  vec3 viewDir_12;
  viewDir_12 = -(xlv_TEXCOORD1);
  vec3 color_13;
  vec2 tmpvar_14;
  tmpvar_14.x = dot ((viewDir_12 - (2.0 * 
    (dot (tmpvar_6, viewDir_12) * tmpvar_6)
  )), _WorldSpaceLightPos0.xyz);
  tmpvar_14.y = (1.0 - clamp (dot (tmpvar_6, viewDir_12), 0.0, 1.0));
  vec2 tmpvar_15;
  tmpvar_15 = ((tmpvar_14 * tmpvar_14) * (tmpvar_14 * tmpvar_14));
  vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = tmpvar_9;
  color_13 = ((tmpvar_3 + (
    (texture2D (unity_NHxRoughness, tmpvar_16).w * 16.0)
   * tmpvar_4)) * ((_LightColor0.xyz * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD6).x) * clamp (
    dot (tmpvar_6, _WorldSpaceLightPos0.xyz)
  , 0.0, 1.0)));
  color_13 = (color_13 + ((
    (xlv_TEXCOORD5.xyz * tmpvar_7)
   * tmpvar_3) + (
    (((unity_SpecCube0_HDR.x * pow (tmpvar_11.w, unity_SpecCube0_HDR.y)) * tmpvar_11.xyz) * tmpvar_7)
   * 
    mix (tmpvar_4, vec3(clamp ((_Glossiness + (1.0 - tmpvar_5)), 0.0, 1.0)), tmpvar_15.yyy)
  )));
  vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = color_13;
  c_1.w = tmpvar_17.w;
  c_1.xyz = (color_13 + (texture2D (_EmissionMap, xlv_TEXCOORD0.xy).xyz * _EmissionColor.xyz));
  vec4 xlat_varoutput_18;
  xlat_varoutput_18.xyz = c_1.xyz;
  xlat_varoutput_18.w = 1.0;
  gl_FragData[0] = xlat_varoutput_18;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "_EMISSION" "VERTEXLIGHT_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "_EMISSION" "VERTEXLIGHT_ON" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "_EMISSION" "VERTEXLIGHT_ON" }
"// shader disassembly not supported on DXBC"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "_EMISSION" }
""
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "_EMISSION" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "_EMISSION" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "_EMISSION" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "_EMISSION" }
""
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "_EMISSION" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "_EMISSION" }
"// shader disassembly not supported on DXBC"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "_EMISSION" }
"// shader disassembly not supported on DXBC"
}
}
 }
 Pass {
  Name "FORWARD_DELTA"
  Tags { "LIGHTMODE"="ForwardAdd" "SHADOWSUPPORT"="true" "RenderType"="Opaque" "PerformanceChecks"="False" }
  ZWrite Off
  Blend [_SrcBlend] One
  GpuProgramID 443686
Program "vp" {
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_OFF" }
"#version 120

#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_WorldTransformParams;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
uniform mat4 _LightMatrix0;
attribute vec4 TANGENT;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec4 tmpvar_7;
  tmpvar_7 = (_Object2World * gl_Vertex);
  tmpvar_3 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_8;
  texcoord_8.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_9;
  if ((_UVSec == 0.0)) {
    tmpvar_9 = tmpvar_1;
  } else {
    tmpvar_9 = tmpvar_2;
  };
  texcoord_8.zw = ((tmpvar_9 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec4 v_10;
  v_10.x = _World2Object[0].x;
  v_10.y = _World2Object[1].x;
  v_10.z = _World2Object[2].x;
  v_10.w = _World2Object[3].x;
  vec4 v_11;
  v_11.x = _World2Object[0].y;
  v_11.y = _World2Object[1].y;
  v_11.z = _World2Object[2].y;
  v_11.w = _World2Object[3].y;
  vec4 v_12;
  v_12.x = _World2Object[0].z;
  v_12.y = _World2Object[1].z;
  v_12.z = _World2Object[2].z;
  v_12.w = _World2Object[3].z;
  vec3 tmpvar_13;
  tmpvar_13 = normalize(((
    (v_10.xyz * gl_Normal.x)
   + 
    (v_11.xyz * gl_Normal.y)
  ) + (v_12.xyz * gl_Normal.z)));
  mat3 tmpvar_14;
  tmpvar_14[0] = _Object2World[0].xyz;
  tmpvar_14[1] = _Object2World[1].xyz;
  tmpvar_14[2] = _Object2World[2].xyz;
  vec4 tmpvar_15;
  tmpvar_15.xyz = normalize((tmpvar_14 * TANGENT.xyz));
  tmpvar_15.w = TANGENT.w;
  vec3 tmpvar_16;
  vec3 tmpvar_17;
  tmpvar_16 = tmpvar_15.xyz;
  tmpvar_17 = (((tmpvar_13.yzx * tmpvar_15.zxy) - (tmpvar_13.zxy * tmpvar_15.yzx)) * (TANGENT.w * unity_WorldTransformParams.w));
  vec3 tmpvar_18;
  vec3 tmpvar_19;
  vec3 tmpvar_20;
  tmpvar_18.x = tmpvar_16.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = tmpvar_13.x;
  tmpvar_19.x = tmpvar_16.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = tmpvar_13.y;
  tmpvar_20.x = tmpvar_16.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = tmpvar_13.z;
  vec3 v_21;
  v_21.x = tmpvar_18.x;
  v_21.y = tmpvar_19.x;
  v_21.z = tmpvar_20.x;
  tmpvar_4.xyz = v_21;
  vec3 v_22;
  v_22.x = tmpvar_18.y;
  v_22.y = tmpvar_19.y;
  v_22.z = tmpvar_20.y;
  tmpvar_5.xyz = v_22;
  vec3 v_23;
  v_23.x = tmpvar_18.z;
  v_23.y = tmpvar_19.z;
  v_23.z = tmpvar_20.z;
  tmpvar_6.xyz = v_23;
  vec3 tmpvar_24;
  tmpvar_24 = normalize((_WorldSpaceLightPos0.xyz - (tmpvar_7.xyz * _WorldSpaceLightPos0.w)));
  tmpvar_4.w = tmpvar_24.x;
  tmpvar_5.w = tmpvar_24.y;
  tmpvar_6.w = tmpvar_24.z;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = texcoord_8;
  xlv_TEXCOORD1 = normalize((tmpvar_7.xyz - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xyz;
}


#endif
#ifdef FRAGMENT
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform sampler2D _LightTexture0;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_2;
  tmpvar_2 = normalize(xlv_TEXCOORD2_2.xyz);
  vec3 tmpvar_3;
  tmpvar_3.x = xlv_TEXCOORD2.w;
  tmpvar_3.y = xlv_TEXCOORD2_1.w;
  tmpvar_3.z = xlv_TEXCOORD2_2.w;
  vec3 viewDir_4;
  viewDir_4 = -(xlv_TEXCOORD1);
  vec2 tmpvar_5;
  tmpvar_5.x = dot ((viewDir_4 - (2.0 * 
    (dot (tmpvar_2, viewDir_4) * tmpvar_2)
  )), tmpvar_3);
  tmpvar_5.y = (1.0 - clamp (dot (tmpvar_2, viewDir_4), 0.0, 1.0));
  vec2 tmpvar_6;
  tmpvar_6.x = ((tmpvar_5 * tmpvar_5) * (tmpvar_5 * tmpvar_5)).x;
  tmpvar_6.y = (1.0 - _Glossiness);
  vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = (((tmpvar_1 * 
    (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w))
  ) + (
    (texture2D (unity_NHxRoughness, tmpvar_6).w * 16.0)
   * 
    mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_1, vec3(_Metallic))
  )) * ((_LightColor0.xyz * texture2D (_LightTexture0, vec2(
    dot (xlv_TEXCOORD5, xlv_TEXCOORD5)
  )).w) * clamp (
    dot (tmpvar_2, tmpvar_3)
  , 0.0, 1.0)));
  vec4 xlat_varoutput_8;
  xlat_varoutput_8.xyz = tmpvar_7.xyz;
  xlat_varoutput_8.w = 1.0;
  gl_FragData[0] = xlat_varoutput_8;
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
SubProgram "d3d11_9x " {
Keywords { "POINT" "SHADOWS_OFF" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"#version 120

#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_WorldTransformParams;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
attribute vec4 TANGENT;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec4 tmpvar_7;
  tmpvar_7 = (_Object2World * gl_Vertex);
  tmpvar_3 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_8;
  texcoord_8.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_9;
  if ((_UVSec == 0.0)) {
    tmpvar_9 = tmpvar_1;
  } else {
    tmpvar_9 = tmpvar_2;
  };
  texcoord_8.zw = ((tmpvar_9 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec4 v_10;
  v_10.x = _World2Object[0].x;
  v_10.y = _World2Object[1].x;
  v_10.z = _World2Object[2].x;
  v_10.w = _World2Object[3].x;
  vec4 v_11;
  v_11.x = _World2Object[0].y;
  v_11.y = _World2Object[1].y;
  v_11.z = _World2Object[2].y;
  v_11.w = _World2Object[3].y;
  vec4 v_12;
  v_12.x = _World2Object[0].z;
  v_12.y = _World2Object[1].z;
  v_12.z = _World2Object[2].z;
  v_12.w = _World2Object[3].z;
  vec3 tmpvar_13;
  tmpvar_13 = normalize(((
    (v_10.xyz * gl_Normal.x)
   + 
    (v_11.xyz * gl_Normal.y)
  ) + (v_12.xyz * gl_Normal.z)));
  mat3 tmpvar_14;
  tmpvar_14[0] = _Object2World[0].xyz;
  tmpvar_14[1] = _Object2World[1].xyz;
  tmpvar_14[2] = _Object2World[2].xyz;
  vec4 tmpvar_15;
  tmpvar_15.xyz = normalize((tmpvar_14 * TANGENT.xyz));
  tmpvar_15.w = TANGENT.w;
  vec3 tmpvar_16;
  vec3 tmpvar_17;
  tmpvar_16 = tmpvar_15.xyz;
  tmpvar_17 = (((tmpvar_13.yzx * tmpvar_15.zxy) - (tmpvar_13.zxy * tmpvar_15.yzx)) * (TANGENT.w * unity_WorldTransformParams.w));
  vec3 tmpvar_18;
  vec3 tmpvar_19;
  vec3 tmpvar_20;
  tmpvar_18.x = tmpvar_16.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = tmpvar_13.x;
  tmpvar_19.x = tmpvar_16.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = tmpvar_13.y;
  tmpvar_20.x = tmpvar_16.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = tmpvar_13.z;
  vec3 v_21;
  v_21.x = tmpvar_18.x;
  v_21.y = tmpvar_19.x;
  v_21.z = tmpvar_20.x;
  tmpvar_4.xyz = v_21;
  vec3 v_22;
  v_22.x = tmpvar_18.y;
  v_22.y = tmpvar_19.y;
  v_22.z = tmpvar_20.y;
  tmpvar_5.xyz = v_22;
  vec3 v_23;
  v_23.x = tmpvar_18.z;
  v_23.y = tmpvar_19.z;
  v_23.z = tmpvar_20.z;
  tmpvar_6.xyz = v_23;
  vec3 tmpvar_24;
  tmpvar_24 = (_WorldSpaceLightPos0.xyz - (tmpvar_7.xyz * _WorldSpaceLightPos0.w));
  tmpvar_4.w = tmpvar_24.x;
  tmpvar_5.w = tmpvar_24.y;
  tmpvar_6.w = tmpvar_24.z;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = texcoord_8;
  xlv_TEXCOORD1 = normalize((tmpvar_7.xyz - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_2;
  tmpvar_2 = normalize(xlv_TEXCOORD2_2.xyz);
  vec3 tmpvar_3;
  tmpvar_3.x = xlv_TEXCOORD2.w;
  tmpvar_3.y = xlv_TEXCOORD2_1.w;
  tmpvar_3.z = xlv_TEXCOORD2_2.w;
  vec3 viewDir_4;
  viewDir_4 = -(xlv_TEXCOORD1);
  vec2 tmpvar_5;
  tmpvar_5.x = dot ((viewDir_4 - (2.0 * 
    (dot (tmpvar_2, viewDir_4) * tmpvar_2)
  )), tmpvar_3);
  tmpvar_5.y = (1.0 - clamp (dot (tmpvar_2, viewDir_4), 0.0, 1.0));
  vec2 tmpvar_6;
  tmpvar_6.x = ((tmpvar_5 * tmpvar_5) * (tmpvar_5 * tmpvar_5)).x;
  tmpvar_6.y = (1.0 - _Glossiness);
  vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = (((tmpvar_1 * 
    (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w))
  ) + (
    (texture2D (unity_NHxRoughness, tmpvar_6).w * 16.0)
   * 
    mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_1, vec3(_Metallic))
  )) * (_LightColor0.xyz * clamp (
    dot (tmpvar_2, tmpvar_3)
  , 0.0, 1.0)));
  vec4 xlat_varoutput_8;
  xlat_varoutput_8.xyz = tmpvar_7.xyz;
  xlat_varoutput_8.w = 1.0;
  gl_FragData[0] = xlat_varoutput_8;
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
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_OFF" }
"#version 120

#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_WorldTransformParams;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
uniform mat4 _LightMatrix0;
attribute vec4 TANGENT;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec4 tmpvar_7;
  tmpvar_7 = (_Object2World * gl_Vertex);
  tmpvar_3 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_8;
  texcoord_8.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_9;
  if ((_UVSec == 0.0)) {
    tmpvar_9 = tmpvar_1;
  } else {
    tmpvar_9 = tmpvar_2;
  };
  texcoord_8.zw = ((tmpvar_9 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec4 v_10;
  v_10.x = _World2Object[0].x;
  v_10.y = _World2Object[1].x;
  v_10.z = _World2Object[2].x;
  v_10.w = _World2Object[3].x;
  vec4 v_11;
  v_11.x = _World2Object[0].y;
  v_11.y = _World2Object[1].y;
  v_11.z = _World2Object[2].y;
  v_11.w = _World2Object[3].y;
  vec4 v_12;
  v_12.x = _World2Object[0].z;
  v_12.y = _World2Object[1].z;
  v_12.z = _World2Object[2].z;
  v_12.w = _World2Object[3].z;
  vec3 tmpvar_13;
  tmpvar_13 = normalize(((
    (v_10.xyz * gl_Normal.x)
   + 
    (v_11.xyz * gl_Normal.y)
  ) + (v_12.xyz * gl_Normal.z)));
  mat3 tmpvar_14;
  tmpvar_14[0] = _Object2World[0].xyz;
  tmpvar_14[1] = _Object2World[1].xyz;
  tmpvar_14[2] = _Object2World[2].xyz;
  vec4 tmpvar_15;
  tmpvar_15.xyz = normalize((tmpvar_14 * TANGENT.xyz));
  tmpvar_15.w = TANGENT.w;
  vec3 tmpvar_16;
  vec3 tmpvar_17;
  tmpvar_16 = tmpvar_15.xyz;
  tmpvar_17 = (((tmpvar_13.yzx * tmpvar_15.zxy) - (tmpvar_13.zxy * tmpvar_15.yzx)) * (TANGENT.w * unity_WorldTransformParams.w));
  vec3 tmpvar_18;
  vec3 tmpvar_19;
  vec3 tmpvar_20;
  tmpvar_18.x = tmpvar_16.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = tmpvar_13.x;
  tmpvar_19.x = tmpvar_16.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = tmpvar_13.y;
  tmpvar_20.x = tmpvar_16.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = tmpvar_13.z;
  vec3 v_21;
  v_21.x = tmpvar_18.x;
  v_21.y = tmpvar_19.x;
  v_21.z = tmpvar_20.x;
  tmpvar_4.xyz = v_21;
  vec3 v_22;
  v_22.x = tmpvar_18.y;
  v_22.y = tmpvar_19.y;
  v_22.z = tmpvar_20.y;
  tmpvar_5.xyz = v_22;
  vec3 v_23;
  v_23.x = tmpvar_18.z;
  v_23.y = tmpvar_19.z;
  v_23.z = tmpvar_20.z;
  tmpvar_6.xyz = v_23;
  vec3 tmpvar_24;
  tmpvar_24 = normalize((_WorldSpaceLightPos0.xyz - (tmpvar_7.xyz * _WorldSpaceLightPos0.w)));
  tmpvar_4.w = tmpvar_24.x;
  tmpvar_5.w = tmpvar_24.y;
  tmpvar_6.w = tmpvar_24.z;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = texcoord_8;
  xlv_TEXCOORD1 = normalize((tmpvar_7.xyz - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = (_LightMatrix0 * (_Object2World * gl_Vertex));
}


#endif
#ifdef FRAGMENT
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_2;
  tmpvar_2 = normalize(xlv_TEXCOORD2_2.xyz);
  vec3 tmpvar_3;
  tmpvar_3.x = xlv_TEXCOORD2.w;
  tmpvar_3.y = xlv_TEXCOORD2_1.w;
  tmpvar_3.z = xlv_TEXCOORD2_2.w;
  vec3 viewDir_4;
  viewDir_4 = -(xlv_TEXCOORD1);
  vec2 tmpvar_5;
  tmpvar_5.x = dot ((viewDir_4 - (2.0 * 
    (dot (tmpvar_2, viewDir_4) * tmpvar_2)
  )), tmpvar_3);
  tmpvar_5.y = (1.0 - clamp (dot (tmpvar_2, viewDir_4), 0.0, 1.0));
  vec2 tmpvar_6;
  tmpvar_6.x = ((tmpvar_5 * tmpvar_5) * (tmpvar_5 * tmpvar_5)).x;
  tmpvar_6.y = (1.0 - _Glossiness);
  vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = (((tmpvar_1 * 
    (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w))
  ) + (
    (texture2D (unity_NHxRoughness, tmpvar_6).w * 16.0)
   * 
    mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_1, vec3(_Metallic))
  )) * ((_LightColor0.xyz * 
    ((float((xlv_TEXCOORD5.z > 0.0)) * texture2D (_LightTexture0, ((xlv_TEXCOORD5.xy / xlv_TEXCOORD5.w) + 0.5)).w) * texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD5.xyz, xlv_TEXCOORD5.xyz))).w)
  ) * clamp (
    dot (tmpvar_2, tmpvar_3)
  , 0.0, 1.0)));
  vec4 xlat_varoutput_8;
  xlat_varoutput_8.xyz = tmpvar_7.xyz;
  xlat_varoutput_8.w = 1.0;
  gl_FragData[0] = xlat_varoutput_8;
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
SubProgram "d3d11_9x " {
Keywords { "SPOT" "SHADOWS_OFF" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"#version 120

#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_WorldTransformParams;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
uniform mat4 _LightMatrix0;
attribute vec4 TANGENT;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec4 tmpvar_7;
  tmpvar_7 = (_Object2World * gl_Vertex);
  tmpvar_3 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_8;
  texcoord_8.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_9;
  if ((_UVSec == 0.0)) {
    tmpvar_9 = tmpvar_1;
  } else {
    tmpvar_9 = tmpvar_2;
  };
  texcoord_8.zw = ((tmpvar_9 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec4 v_10;
  v_10.x = _World2Object[0].x;
  v_10.y = _World2Object[1].x;
  v_10.z = _World2Object[2].x;
  v_10.w = _World2Object[3].x;
  vec4 v_11;
  v_11.x = _World2Object[0].y;
  v_11.y = _World2Object[1].y;
  v_11.z = _World2Object[2].y;
  v_11.w = _World2Object[3].y;
  vec4 v_12;
  v_12.x = _World2Object[0].z;
  v_12.y = _World2Object[1].z;
  v_12.z = _World2Object[2].z;
  v_12.w = _World2Object[3].z;
  vec3 tmpvar_13;
  tmpvar_13 = normalize(((
    (v_10.xyz * gl_Normal.x)
   + 
    (v_11.xyz * gl_Normal.y)
  ) + (v_12.xyz * gl_Normal.z)));
  mat3 tmpvar_14;
  tmpvar_14[0] = _Object2World[0].xyz;
  tmpvar_14[1] = _Object2World[1].xyz;
  tmpvar_14[2] = _Object2World[2].xyz;
  vec4 tmpvar_15;
  tmpvar_15.xyz = normalize((tmpvar_14 * TANGENT.xyz));
  tmpvar_15.w = TANGENT.w;
  vec3 tmpvar_16;
  vec3 tmpvar_17;
  tmpvar_16 = tmpvar_15.xyz;
  tmpvar_17 = (((tmpvar_13.yzx * tmpvar_15.zxy) - (tmpvar_13.zxy * tmpvar_15.yzx)) * (TANGENT.w * unity_WorldTransformParams.w));
  vec3 tmpvar_18;
  vec3 tmpvar_19;
  vec3 tmpvar_20;
  tmpvar_18.x = tmpvar_16.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = tmpvar_13.x;
  tmpvar_19.x = tmpvar_16.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = tmpvar_13.y;
  tmpvar_20.x = tmpvar_16.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = tmpvar_13.z;
  vec3 v_21;
  v_21.x = tmpvar_18.x;
  v_21.y = tmpvar_19.x;
  v_21.z = tmpvar_20.x;
  tmpvar_4.xyz = v_21;
  vec3 v_22;
  v_22.x = tmpvar_18.y;
  v_22.y = tmpvar_19.y;
  v_22.z = tmpvar_20.y;
  tmpvar_5.xyz = v_22;
  vec3 v_23;
  v_23.x = tmpvar_18.z;
  v_23.y = tmpvar_19.z;
  v_23.z = tmpvar_20.z;
  tmpvar_6.xyz = v_23;
  vec3 tmpvar_24;
  tmpvar_24 = normalize((_WorldSpaceLightPos0.xyz - (tmpvar_7.xyz * _WorldSpaceLightPos0.w)));
  tmpvar_4.w = tmpvar_24.x;
  tmpvar_5.w = tmpvar_24.y;
  tmpvar_6.w = tmpvar_24.z;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = texcoord_8;
  xlv_TEXCOORD1 = normalize((tmpvar_7.xyz - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xyz;
}


#endif
#ifdef FRAGMENT
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform samplerCube _LightTexture0;
uniform sampler2D _LightTextureB0;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_2;
  tmpvar_2 = normalize(xlv_TEXCOORD2_2.xyz);
  vec3 tmpvar_3;
  tmpvar_3.x = xlv_TEXCOORD2.w;
  tmpvar_3.y = xlv_TEXCOORD2_1.w;
  tmpvar_3.z = xlv_TEXCOORD2_2.w;
  vec3 viewDir_4;
  viewDir_4 = -(xlv_TEXCOORD1);
  vec2 tmpvar_5;
  tmpvar_5.x = dot ((viewDir_4 - (2.0 * 
    (dot (tmpvar_2, viewDir_4) * tmpvar_2)
  )), tmpvar_3);
  tmpvar_5.y = (1.0 - clamp (dot (tmpvar_2, viewDir_4), 0.0, 1.0));
  vec2 tmpvar_6;
  tmpvar_6.x = ((tmpvar_5 * tmpvar_5) * (tmpvar_5 * tmpvar_5)).x;
  tmpvar_6.y = (1.0 - _Glossiness);
  vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = (((tmpvar_1 * 
    (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w))
  ) + (
    (texture2D (unity_NHxRoughness, tmpvar_6).w * 16.0)
   * 
    mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_1, vec3(_Metallic))
  )) * ((_LightColor0.xyz * 
    (texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD5, xlv_TEXCOORD5))).w * textureCube (_LightTexture0, xlv_TEXCOORD5).w)
  ) * clamp (
    dot (tmpvar_2, tmpvar_3)
  , 0.0, 1.0)));
  vec4 xlat_varoutput_8;
  xlat_varoutput_8.xyz = tmpvar_7.xyz;
  xlat_varoutput_8.w = 1.0;
  gl_FragData[0] = xlat_varoutput_8;
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
SubProgram "d3d11_9x " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"#version 120

#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_WorldTransformParams;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
uniform mat4 _LightMatrix0;
attribute vec4 TANGENT;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec2 xlv_TEXCOORD5;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec4 tmpvar_7;
  tmpvar_7 = (_Object2World * gl_Vertex);
  tmpvar_3 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_8;
  texcoord_8.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_9;
  if ((_UVSec == 0.0)) {
    tmpvar_9 = tmpvar_1;
  } else {
    tmpvar_9 = tmpvar_2;
  };
  texcoord_8.zw = ((tmpvar_9 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec4 v_10;
  v_10.x = _World2Object[0].x;
  v_10.y = _World2Object[1].x;
  v_10.z = _World2Object[2].x;
  v_10.w = _World2Object[3].x;
  vec4 v_11;
  v_11.x = _World2Object[0].y;
  v_11.y = _World2Object[1].y;
  v_11.z = _World2Object[2].y;
  v_11.w = _World2Object[3].y;
  vec4 v_12;
  v_12.x = _World2Object[0].z;
  v_12.y = _World2Object[1].z;
  v_12.z = _World2Object[2].z;
  v_12.w = _World2Object[3].z;
  vec3 tmpvar_13;
  tmpvar_13 = normalize(((
    (v_10.xyz * gl_Normal.x)
   + 
    (v_11.xyz * gl_Normal.y)
  ) + (v_12.xyz * gl_Normal.z)));
  mat3 tmpvar_14;
  tmpvar_14[0] = _Object2World[0].xyz;
  tmpvar_14[1] = _Object2World[1].xyz;
  tmpvar_14[2] = _Object2World[2].xyz;
  vec4 tmpvar_15;
  tmpvar_15.xyz = normalize((tmpvar_14 * TANGENT.xyz));
  tmpvar_15.w = TANGENT.w;
  vec3 tmpvar_16;
  vec3 tmpvar_17;
  tmpvar_16 = tmpvar_15.xyz;
  tmpvar_17 = (((tmpvar_13.yzx * tmpvar_15.zxy) - (tmpvar_13.zxy * tmpvar_15.yzx)) * (TANGENT.w * unity_WorldTransformParams.w));
  vec3 tmpvar_18;
  vec3 tmpvar_19;
  vec3 tmpvar_20;
  tmpvar_18.x = tmpvar_16.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = tmpvar_13.x;
  tmpvar_19.x = tmpvar_16.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = tmpvar_13.y;
  tmpvar_20.x = tmpvar_16.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = tmpvar_13.z;
  vec3 v_21;
  v_21.x = tmpvar_18.x;
  v_21.y = tmpvar_19.x;
  v_21.z = tmpvar_20.x;
  tmpvar_4.xyz = v_21;
  vec3 v_22;
  v_22.x = tmpvar_18.y;
  v_22.y = tmpvar_19.y;
  v_22.z = tmpvar_20.y;
  tmpvar_5.xyz = v_22;
  vec3 v_23;
  v_23.x = tmpvar_18.z;
  v_23.y = tmpvar_19.z;
  v_23.z = tmpvar_20.z;
  tmpvar_6.xyz = v_23;
  vec3 tmpvar_24;
  tmpvar_24 = (_WorldSpaceLightPos0.xyz - (tmpvar_7.xyz * _WorldSpaceLightPos0.w));
  tmpvar_4.w = tmpvar_24.x;
  tmpvar_5.w = tmpvar_24.y;
  tmpvar_6.w = tmpvar_24.z;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = texcoord_8;
  xlv_TEXCOORD1 = normalize((tmpvar_7.xyz - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xy;
}


#endif
#ifdef FRAGMENT
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform sampler2D _LightTexture0;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec2 xlv_TEXCOORD5;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_2;
  tmpvar_2 = normalize(xlv_TEXCOORD2_2.xyz);
  vec3 tmpvar_3;
  tmpvar_3.x = xlv_TEXCOORD2.w;
  tmpvar_3.y = xlv_TEXCOORD2_1.w;
  tmpvar_3.z = xlv_TEXCOORD2_2.w;
  vec3 viewDir_4;
  viewDir_4 = -(xlv_TEXCOORD1);
  vec2 tmpvar_5;
  tmpvar_5.x = dot ((viewDir_4 - (2.0 * 
    (dot (tmpvar_2, viewDir_4) * tmpvar_2)
  )), tmpvar_3);
  tmpvar_5.y = (1.0 - clamp (dot (tmpvar_2, viewDir_4), 0.0, 1.0));
  vec2 tmpvar_6;
  tmpvar_6.x = ((tmpvar_5 * tmpvar_5) * (tmpvar_5 * tmpvar_5)).x;
  tmpvar_6.y = (1.0 - _Glossiness);
  vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = (((tmpvar_1 * 
    (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w))
  ) + (
    (texture2D (unity_NHxRoughness, tmpvar_6).w * 16.0)
   * 
    mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_1, vec3(_Metallic))
  )) * ((_LightColor0.xyz * texture2D (_LightTexture0, xlv_TEXCOORD5).w) * clamp (
    dot (tmpvar_2, tmpvar_3)
  , 0.0, 1.0)));
  vec4 xlat_varoutput_8;
  xlat_varoutput_8.xyz = tmpvar_7.xyz;
  xlat_varoutput_8.w = 1.0;
  gl_FragData[0] = xlat_varoutput_8;
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
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
"#version 120

#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform mat4 unity_World2Shadow[4];

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_WorldTransformParams;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
uniform mat4 _LightMatrix0;
attribute vec4 TANGENT;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD6;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec4 tmpvar_7;
  tmpvar_7 = (_Object2World * gl_Vertex);
  tmpvar_3 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_8;
  texcoord_8.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_9;
  if ((_UVSec == 0.0)) {
    tmpvar_9 = tmpvar_1;
  } else {
    tmpvar_9 = tmpvar_2;
  };
  texcoord_8.zw = ((tmpvar_9 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec4 v_10;
  v_10.x = _World2Object[0].x;
  v_10.y = _World2Object[1].x;
  v_10.z = _World2Object[2].x;
  v_10.w = _World2Object[3].x;
  vec4 v_11;
  v_11.x = _World2Object[0].y;
  v_11.y = _World2Object[1].y;
  v_11.z = _World2Object[2].y;
  v_11.w = _World2Object[3].y;
  vec4 v_12;
  v_12.x = _World2Object[0].z;
  v_12.y = _World2Object[1].z;
  v_12.z = _World2Object[2].z;
  v_12.w = _World2Object[3].z;
  vec3 tmpvar_13;
  tmpvar_13 = normalize(((
    (v_10.xyz * gl_Normal.x)
   + 
    (v_11.xyz * gl_Normal.y)
  ) + (v_12.xyz * gl_Normal.z)));
  mat3 tmpvar_14;
  tmpvar_14[0] = _Object2World[0].xyz;
  tmpvar_14[1] = _Object2World[1].xyz;
  tmpvar_14[2] = _Object2World[2].xyz;
  vec4 tmpvar_15;
  tmpvar_15.xyz = normalize((tmpvar_14 * TANGENT.xyz));
  tmpvar_15.w = TANGENT.w;
  vec3 tmpvar_16;
  vec3 tmpvar_17;
  tmpvar_16 = tmpvar_15.xyz;
  tmpvar_17 = (((tmpvar_13.yzx * tmpvar_15.zxy) - (tmpvar_13.zxy * tmpvar_15.yzx)) * (TANGENT.w * unity_WorldTransformParams.w));
  vec3 tmpvar_18;
  vec3 tmpvar_19;
  vec3 tmpvar_20;
  tmpvar_18.x = tmpvar_16.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = tmpvar_13.x;
  tmpvar_19.x = tmpvar_16.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = tmpvar_13.y;
  tmpvar_20.x = tmpvar_16.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = tmpvar_13.z;
  vec3 v_21;
  v_21.x = tmpvar_18.x;
  v_21.y = tmpvar_19.x;
  v_21.z = tmpvar_20.x;
  tmpvar_4.xyz = v_21;
  vec3 v_22;
  v_22.x = tmpvar_18.y;
  v_22.y = tmpvar_19.y;
  v_22.z = tmpvar_20.y;
  tmpvar_5.xyz = v_22;
  vec3 v_23;
  v_23.x = tmpvar_18.z;
  v_23.y = tmpvar_19.z;
  v_23.z = tmpvar_20.z;
  tmpvar_6.xyz = v_23;
  vec3 tmpvar_24;
  tmpvar_24 = normalize((_WorldSpaceLightPos0.xyz - (tmpvar_7.xyz * _WorldSpaceLightPos0.w)));
  tmpvar_4.w = tmpvar_24.x;
  tmpvar_5.w = tmpvar_24.y;
  tmpvar_6.w = tmpvar_24.z;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = texcoord_8;
  xlv_TEXCOORD1 = normalize((tmpvar_7.xyz - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  vec4 tmpvar_25;
  tmpvar_25 = (_Object2World * gl_Vertex);
  xlv_TEXCOORD5 = (_LightMatrix0 * tmpvar_25);
  xlv_TEXCOORD6 = (unity_World2Shadow[0] * tmpvar_25);
}


#endif
#ifdef FRAGMENT
uniform vec4 _LightShadowData;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform sampler2DShadow _ShadowMapTexture;
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD6;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_2;
  tmpvar_2 = normalize(xlv_TEXCOORD2_2.xyz);
  vec3 tmpvar_3;
  tmpvar_3.x = xlv_TEXCOORD2.w;
  tmpvar_3.y = xlv_TEXCOORD2_1.w;
  tmpvar_3.z = xlv_TEXCOORD2_2.w;
  vec3 viewDir_4;
  viewDir_4 = -(xlv_TEXCOORD1);
  vec2 tmpvar_5;
  tmpvar_5.x = dot ((viewDir_4 - (2.0 * 
    (dot (tmpvar_2, viewDir_4) * tmpvar_2)
  )), tmpvar_3);
  tmpvar_5.y = (1.0 - clamp (dot (tmpvar_2, viewDir_4), 0.0, 1.0));
  vec2 tmpvar_6;
  tmpvar_6.x = ((tmpvar_5 * tmpvar_5) * (tmpvar_5 * tmpvar_5)).x;
  tmpvar_6.y = (1.0 - _Glossiness);
  vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = (((tmpvar_1 * 
    (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w))
  ) + (
    (texture2D (unity_NHxRoughness, tmpvar_6).w * 16.0)
   * 
    mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_1, vec3(_Metallic))
  )) * ((_LightColor0.xyz * 
    (((float(
      (xlv_TEXCOORD5.z > 0.0)
    ) * texture2D (_LightTexture0, (
      (xlv_TEXCOORD5.xy / xlv_TEXCOORD5.w)
     + 0.5)).w) * texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD5.xyz, xlv_TEXCOORD5.xyz))).w) * (_LightShadowData.x + (shadow2DProj (_ShadowMapTexture, xlv_TEXCOORD6).x * (1.0 - _LightShadowData.x))))
  ) * clamp (
    dot (tmpvar_2, tmpvar_3)
  , 0.0, 1.0)));
  vec4 xlat_varoutput_8;
  xlat_varoutput_8.xyz = tmpvar_7.xyz;
  xlat_varoutput_8.w = 1.0;
  gl_FragData[0] = xlat_varoutput_8;
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
SubProgram "d3d11_9x " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#version 120

#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;
uniform vec4 _WorldSpaceLightPos0;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_WorldTransformParams;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
attribute vec4 TANGENT;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec4 tmpvar_7;
  tmpvar_7 = (_Object2World * gl_Vertex);
  tmpvar_3 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_8;
  texcoord_8.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_9;
  if ((_UVSec == 0.0)) {
    tmpvar_9 = tmpvar_1;
  } else {
    tmpvar_9 = tmpvar_2;
  };
  texcoord_8.zw = ((tmpvar_9 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec4 v_10;
  v_10.x = _World2Object[0].x;
  v_10.y = _World2Object[1].x;
  v_10.z = _World2Object[2].x;
  v_10.w = _World2Object[3].x;
  vec4 v_11;
  v_11.x = _World2Object[0].y;
  v_11.y = _World2Object[1].y;
  v_11.z = _World2Object[2].y;
  v_11.w = _World2Object[3].y;
  vec4 v_12;
  v_12.x = _World2Object[0].z;
  v_12.y = _World2Object[1].z;
  v_12.z = _World2Object[2].z;
  v_12.w = _World2Object[3].z;
  vec3 tmpvar_13;
  tmpvar_13 = normalize(((
    (v_10.xyz * gl_Normal.x)
   + 
    (v_11.xyz * gl_Normal.y)
  ) + (v_12.xyz * gl_Normal.z)));
  mat3 tmpvar_14;
  tmpvar_14[0] = _Object2World[0].xyz;
  tmpvar_14[1] = _Object2World[1].xyz;
  tmpvar_14[2] = _Object2World[2].xyz;
  vec4 tmpvar_15;
  tmpvar_15.xyz = normalize((tmpvar_14 * TANGENT.xyz));
  tmpvar_15.w = TANGENT.w;
  vec3 tmpvar_16;
  vec3 tmpvar_17;
  tmpvar_16 = tmpvar_15.xyz;
  tmpvar_17 = (((tmpvar_13.yzx * tmpvar_15.zxy) - (tmpvar_13.zxy * tmpvar_15.yzx)) * (TANGENT.w * unity_WorldTransformParams.w));
  vec3 tmpvar_18;
  vec3 tmpvar_19;
  vec3 tmpvar_20;
  tmpvar_18.x = tmpvar_16.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = tmpvar_13.x;
  tmpvar_19.x = tmpvar_16.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = tmpvar_13.y;
  tmpvar_20.x = tmpvar_16.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = tmpvar_13.z;
  vec3 v_21;
  v_21.x = tmpvar_18.x;
  v_21.y = tmpvar_19.x;
  v_21.z = tmpvar_20.x;
  tmpvar_4.xyz = v_21;
  vec3 v_22;
  v_22.x = tmpvar_18.y;
  v_22.y = tmpvar_19.y;
  v_22.z = tmpvar_20.y;
  tmpvar_5.xyz = v_22;
  vec3 v_23;
  v_23.x = tmpvar_18.z;
  v_23.y = tmpvar_19.z;
  v_23.z = tmpvar_20.z;
  tmpvar_6.xyz = v_23;
  vec4 o_24;
  vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_3 * 0.5);
  vec2 tmpvar_26;
  tmpvar_26.x = tmpvar_25.x;
  tmpvar_26.y = (tmpvar_25.y * _ProjectionParams.x);
  o_24.xy = (tmpvar_26 + tmpvar_25.w);
  o_24.zw = tmpvar_3.zw;
  vec3 tmpvar_27;
  tmpvar_27 = (_WorldSpaceLightPos0.xyz - (tmpvar_7.xyz * _WorldSpaceLightPos0.w));
  tmpvar_4.w = tmpvar_27.x;
  tmpvar_5.w = tmpvar_27.y;
  tmpvar_6.w = tmpvar_27.z;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = texcoord_8;
  xlv_TEXCOORD1 = normalize((tmpvar_7.xyz - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = o_24;
}


#endif
#ifdef FRAGMENT
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform sampler2D _ShadowMapTexture;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec4 xlv_TEXCOORD5;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_2;
  tmpvar_2 = normalize(xlv_TEXCOORD2_2.xyz);
  vec3 tmpvar_3;
  tmpvar_3.x = xlv_TEXCOORD2.w;
  tmpvar_3.y = xlv_TEXCOORD2_1.w;
  tmpvar_3.z = xlv_TEXCOORD2_2.w;
  vec3 viewDir_4;
  viewDir_4 = -(xlv_TEXCOORD1);
  vec2 tmpvar_5;
  tmpvar_5.x = dot ((viewDir_4 - (2.0 * 
    (dot (tmpvar_2, viewDir_4) * tmpvar_2)
  )), tmpvar_3);
  tmpvar_5.y = (1.0 - clamp (dot (tmpvar_2, viewDir_4), 0.0, 1.0));
  vec2 tmpvar_6;
  tmpvar_6.x = ((tmpvar_5 * tmpvar_5) * (tmpvar_5 * tmpvar_5)).x;
  tmpvar_6.y = (1.0 - _Glossiness);
  vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = (((tmpvar_1 * 
    (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w))
  ) + (
    (texture2D (unity_NHxRoughness, tmpvar_6).w * 16.0)
   * 
    mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_1, vec3(_Metallic))
  )) * ((_LightColor0.xyz * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD5).x) * clamp (
    dot (tmpvar_2, tmpvar_3)
  , 0.0, 1.0)));
  vec4 xlat_varoutput_8;
  xlat_varoutput_8.xyz = tmpvar_7.xyz;
  xlat_varoutput_8.w = 1.0;
  gl_FragData[0] = xlat_varoutput_8;
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
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"#version 120

#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;
uniform vec4 _WorldSpaceLightPos0;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_WorldTransformParams;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
uniform mat4 _LightMatrix0;
attribute vec4 TANGENT;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec2 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD6;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec4 tmpvar_7;
  tmpvar_7 = (_Object2World * gl_Vertex);
  tmpvar_3 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_8;
  texcoord_8.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_9;
  if ((_UVSec == 0.0)) {
    tmpvar_9 = tmpvar_1;
  } else {
    tmpvar_9 = tmpvar_2;
  };
  texcoord_8.zw = ((tmpvar_9 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec4 v_10;
  v_10.x = _World2Object[0].x;
  v_10.y = _World2Object[1].x;
  v_10.z = _World2Object[2].x;
  v_10.w = _World2Object[3].x;
  vec4 v_11;
  v_11.x = _World2Object[0].y;
  v_11.y = _World2Object[1].y;
  v_11.z = _World2Object[2].y;
  v_11.w = _World2Object[3].y;
  vec4 v_12;
  v_12.x = _World2Object[0].z;
  v_12.y = _World2Object[1].z;
  v_12.z = _World2Object[2].z;
  v_12.w = _World2Object[3].z;
  vec3 tmpvar_13;
  tmpvar_13 = normalize(((
    (v_10.xyz * gl_Normal.x)
   + 
    (v_11.xyz * gl_Normal.y)
  ) + (v_12.xyz * gl_Normal.z)));
  mat3 tmpvar_14;
  tmpvar_14[0] = _Object2World[0].xyz;
  tmpvar_14[1] = _Object2World[1].xyz;
  tmpvar_14[2] = _Object2World[2].xyz;
  vec4 tmpvar_15;
  tmpvar_15.xyz = normalize((tmpvar_14 * TANGENT.xyz));
  tmpvar_15.w = TANGENT.w;
  vec3 tmpvar_16;
  vec3 tmpvar_17;
  tmpvar_16 = tmpvar_15.xyz;
  tmpvar_17 = (((tmpvar_13.yzx * tmpvar_15.zxy) - (tmpvar_13.zxy * tmpvar_15.yzx)) * (TANGENT.w * unity_WorldTransformParams.w));
  vec3 tmpvar_18;
  vec3 tmpvar_19;
  vec3 tmpvar_20;
  tmpvar_18.x = tmpvar_16.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = tmpvar_13.x;
  tmpvar_19.x = tmpvar_16.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = tmpvar_13.y;
  tmpvar_20.x = tmpvar_16.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = tmpvar_13.z;
  vec3 v_21;
  v_21.x = tmpvar_18.x;
  v_21.y = tmpvar_19.x;
  v_21.z = tmpvar_20.x;
  tmpvar_4.xyz = v_21;
  vec3 v_22;
  v_22.x = tmpvar_18.y;
  v_22.y = tmpvar_19.y;
  v_22.z = tmpvar_20.y;
  tmpvar_5.xyz = v_22;
  vec3 v_23;
  v_23.x = tmpvar_18.z;
  v_23.y = tmpvar_19.z;
  v_23.z = tmpvar_20.z;
  tmpvar_6.xyz = v_23;
  vec4 o_24;
  vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_3 * 0.5);
  vec2 tmpvar_26;
  tmpvar_26.x = tmpvar_25.x;
  tmpvar_26.y = (tmpvar_25.y * _ProjectionParams.x);
  o_24.xy = (tmpvar_26 + tmpvar_25.w);
  o_24.zw = tmpvar_3.zw;
  vec3 tmpvar_27;
  tmpvar_27 = (_WorldSpaceLightPos0.xyz - (tmpvar_7.xyz * _WorldSpaceLightPos0.w));
  tmpvar_4.w = tmpvar_27.x;
  tmpvar_5.w = tmpvar_27.y;
  tmpvar_6.w = tmpvar_27.z;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = texcoord_8;
  xlv_TEXCOORD1 = normalize((tmpvar_7.xyz - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xy;
  xlv_TEXCOORD6 = o_24;
}


#endif
#ifdef FRAGMENT
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _LightTexture0;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec2 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD6;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_2;
  tmpvar_2 = normalize(xlv_TEXCOORD2_2.xyz);
  vec3 tmpvar_3;
  tmpvar_3.x = xlv_TEXCOORD2.w;
  tmpvar_3.y = xlv_TEXCOORD2_1.w;
  tmpvar_3.z = xlv_TEXCOORD2_2.w;
  vec3 viewDir_4;
  viewDir_4 = -(xlv_TEXCOORD1);
  vec2 tmpvar_5;
  tmpvar_5.x = dot ((viewDir_4 - (2.0 * 
    (dot (tmpvar_2, viewDir_4) * tmpvar_2)
  )), tmpvar_3);
  tmpvar_5.y = (1.0 - clamp (dot (tmpvar_2, viewDir_4), 0.0, 1.0));
  vec2 tmpvar_6;
  tmpvar_6.x = ((tmpvar_5 * tmpvar_5) * (tmpvar_5 * tmpvar_5)).x;
  tmpvar_6.y = (1.0 - _Glossiness);
  vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = (((tmpvar_1 * 
    (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w))
  ) + (
    (texture2D (unity_NHxRoughness, tmpvar_6).w * 16.0)
   * 
    mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_1, vec3(_Metallic))
  )) * ((_LightColor0.xyz * 
    (texture2D (_LightTexture0, xlv_TEXCOORD5).w * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD6).x)
  ) * clamp (
    dot (tmpvar_2, tmpvar_3)
  , 0.0, 1.0)));
  vec4 xlat_varoutput_8;
  xlat_varoutput_8.xyz = tmpvar_7.xyz;
  xlat_varoutput_8.w = 1.0;
  gl_FragData[0] = xlat_varoutput_8;
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
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_CUBE" }
"#version 120

#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightPositionRange;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_WorldTransformParams;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
uniform mat4 _LightMatrix0;
attribute vec4 TANGENT;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD6;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec4 tmpvar_7;
  tmpvar_7 = (_Object2World * gl_Vertex);
  tmpvar_3 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_8;
  texcoord_8.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_9;
  if ((_UVSec == 0.0)) {
    tmpvar_9 = tmpvar_1;
  } else {
    tmpvar_9 = tmpvar_2;
  };
  texcoord_8.zw = ((tmpvar_9 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec4 v_10;
  v_10.x = _World2Object[0].x;
  v_10.y = _World2Object[1].x;
  v_10.z = _World2Object[2].x;
  v_10.w = _World2Object[3].x;
  vec4 v_11;
  v_11.x = _World2Object[0].y;
  v_11.y = _World2Object[1].y;
  v_11.z = _World2Object[2].y;
  v_11.w = _World2Object[3].y;
  vec4 v_12;
  v_12.x = _World2Object[0].z;
  v_12.y = _World2Object[1].z;
  v_12.z = _World2Object[2].z;
  v_12.w = _World2Object[3].z;
  vec3 tmpvar_13;
  tmpvar_13 = normalize(((
    (v_10.xyz * gl_Normal.x)
   + 
    (v_11.xyz * gl_Normal.y)
  ) + (v_12.xyz * gl_Normal.z)));
  mat3 tmpvar_14;
  tmpvar_14[0] = _Object2World[0].xyz;
  tmpvar_14[1] = _Object2World[1].xyz;
  tmpvar_14[2] = _Object2World[2].xyz;
  vec4 tmpvar_15;
  tmpvar_15.xyz = normalize((tmpvar_14 * TANGENT.xyz));
  tmpvar_15.w = TANGENT.w;
  vec3 tmpvar_16;
  vec3 tmpvar_17;
  tmpvar_16 = tmpvar_15.xyz;
  tmpvar_17 = (((tmpvar_13.yzx * tmpvar_15.zxy) - (tmpvar_13.zxy * tmpvar_15.yzx)) * (TANGENT.w * unity_WorldTransformParams.w));
  vec3 tmpvar_18;
  vec3 tmpvar_19;
  vec3 tmpvar_20;
  tmpvar_18.x = tmpvar_16.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = tmpvar_13.x;
  tmpvar_19.x = tmpvar_16.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = tmpvar_13.y;
  tmpvar_20.x = tmpvar_16.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = tmpvar_13.z;
  vec3 v_21;
  v_21.x = tmpvar_18.x;
  v_21.y = tmpvar_19.x;
  v_21.z = tmpvar_20.x;
  tmpvar_4.xyz = v_21;
  vec3 v_22;
  v_22.x = tmpvar_18.y;
  v_22.y = tmpvar_19.y;
  v_22.z = tmpvar_20.y;
  tmpvar_5.xyz = v_22;
  vec3 v_23;
  v_23.x = tmpvar_18.z;
  v_23.y = tmpvar_19.z;
  v_23.z = tmpvar_20.z;
  tmpvar_6.xyz = v_23;
  vec3 tmpvar_24;
  tmpvar_24 = normalize((_WorldSpaceLightPos0.xyz - (tmpvar_7.xyz * _WorldSpaceLightPos0.w)));
  tmpvar_4.w = tmpvar_24.x;
  tmpvar_5.w = tmpvar_24.y;
  tmpvar_6.w = tmpvar_24.z;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = texcoord_8;
  xlv_TEXCOORD1 = normalize((tmpvar_7.xyz - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  vec4 tmpvar_25;
  tmpvar_25 = (_Object2World * gl_Vertex);
  xlv_TEXCOORD5 = (_LightMatrix0 * tmpvar_25).xyz;
  xlv_TEXCOORD6 = (tmpvar_25.xyz - _LightPositionRange.xyz);
}


#endif
#ifdef FRAGMENT
uniform vec4 _LightPositionRange;
uniform vec4 _LightShadowData;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform samplerCube _ShadowMapTexture;
uniform sampler2D _LightTexture0;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD6;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_2;
  vec3 tmpvar_3;
  tmpvar_3 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_1, vec3(_Metallic));
  tmpvar_2 = (tmpvar_1 * (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w)));
  vec3 tmpvar_4;
  tmpvar_4 = normalize(xlv_TEXCOORD2_2.xyz);
  vec3 tmpvar_5;
  tmpvar_5.x = xlv_TEXCOORD2.w;
  tmpvar_5.y = xlv_TEXCOORD2_1.w;
  tmpvar_5.z = xlv_TEXCOORD2_2.w;
  vec4 tmpvar_6;
  tmpvar_6 = texture2D (_LightTexture0, vec2(dot (xlv_TEXCOORD5, xlv_TEXCOORD5)));
  float mydist_7;
  mydist_7 = ((sqrt(
    dot (xlv_TEXCOORD6, xlv_TEXCOORD6)
  ) * _LightPositionRange.w) * 0.97);
  vec4 tmpvar_8;
  tmpvar_8 = textureCube (_ShadowMapTexture, xlv_TEXCOORD6);
  float tmpvar_9;
  if ((tmpvar_8.x < mydist_7)) {
    tmpvar_9 = _LightShadowData.x;
  } else {
    tmpvar_9 = 1.0;
  };
  vec3 viewDir_10;
  viewDir_10 = -(xlv_TEXCOORD1);
  vec2 tmpvar_11;
  tmpvar_11.x = dot ((viewDir_10 - (2.0 * 
    (dot (tmpvar_4, viewDir_10) * tmpvar_4)
  )), tmpvar_5);
  tmpvar_11.y = (1.0 - clamp (dot (tmpvar_4, viewDir_10), 0.0, 1.0));
  vec2 tmpvar_12;
  tmpvar_12.x = ((tmpvar_11 * tmpvar_11) * (tmpvar_11 * tmpvar_11)).x;
  tmpvar_12.y = (1.0 - _Glossiness);
  vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = ((tmpvar_2 + (
    (texture2D (unity_NHxRoughness, tmpvar_12).w * 16.0)
   * tmpvar_3)) * ((_LightColor0.xyz * 
    (tmpvar_6.w * tmpvar_9)
  ) * clamp (
    dot (tmpvar_4, tmpvar_5)
  , 0.0, 1.0)));
  vec4 xlat_varoutput_14;
  xlat_varoutput_14.xyz = tmpvar_13.xyz;
  xlat_varoutput_14.w = 1.0;
  gl_FragData[0] = xlat_varoutput_14;
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
SubProgram "d3d11_9x " {
Keywords { "POINT" "SHADOWS_CUBE" }
"// shader disassembly not supported on DXBC"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"#version 120

#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightPositionRange;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_WorldTransformParams;
uniform vec4 _MainTex_ST;
uniform vec4 _DetailAlbedoMap_ST;
uniform float _UVSec;
uniform mat4 _LightMatrix0;
attribute vec4 TANGENT;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD6;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec2 tmpvar_2;
  tmpvar_2 = gl_MultiTexCoord1.xy;
  vec4 tmpvar_3;
  vec4 tmpvar_4;
  vec4 tmpvar_5;
  vec4 tmpvar_6;
  vec4 tmpvar_7;
  tmpvar_7 = (_Object2World * gl_Vertex);
  tmpvar_3 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 texcoord_8;
  texcoord_8.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  vec2 tmpvar_9;
  if ((_UVSec == 0.0)) {
    tmpvar_9 = tmpvar_1;
  } else {
    tmpvar_9 = tmpvar_2;
  };
  texcoord_8.zw = ((tmpvar_9 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  vec4 v_10;
  v_10.x = _World2Object[0].x;
  v_10.y = _World2Object[1].x;
  v_10.z = _World2Object[2].x;
  v_10.w = _World2Object[3].x;
  vec4 v_11;
  v_11.x = _World2Object[0].y;
  v_11.y = _World2Object[1].y;
  v_11.z = _World2Object[2].y;
  v_11.w = _World2Object[3].y;
  vec4 v_12;
  v_12.x = _World2Object[0].z;
  v_12.y = _World2Object[1].z;
  v_12.z = _World2Object[2].z;
  v_12.w = _World2Object[3].z;
  vec3 tmpvar_13;
  tmpvar_13 = normalize(((
    (v_10.xyz * gl_Normal.x)
   + 
    (v_11.xyz * gl_Normal.y)
  ) + (v_12.xyz * gl_Normal.z)));
  mat3 tmpvar_14;
  tmpvar_14[0] = _Object2World[0].xyz;
  tmpvar_14[1] = _Object2World[1].xyz;
  tmpvar_14[2] = _Object2World[2].xyz;
  vec4 tmpvar_15;
  tmpvar_15.xyz = normalize((tmpvar_14 * TANGENT.xyz));
  tmpvar_15.w = TANGENT.w;
  vec3 tmpvar_16;
  vec3 tmpvar_17;
  tmpvar_16 = tmpvar_15.xyz;
  tmpvar_17 = (((tmpvar_13.yzx * tmpvar_15.zxy) - (tmpvar_13.zxy * tmpvar_15.yzx)) * (TANGENT.w * unity_WorldTransformParams.w));
  vec3 tmpvar_18;
  vec3 tmpvar_19;
  vec3 tmpvar_20;
  tmpvar_18.x = tmpvar_16.x;
  tmpvar_18.y = tmpvar_17.x;
  tmpvar_18.z = tmpvar_13.x;
  tmpvar_19.x = tmpvar_16.y;
  tmpvar_19.y = tmpvar_17.y;
  tmpvar_19.z = tmpvar_13.y;
  tmpvar_20.x = tmpvar_16.z;
  tmpvar_20.y = tmpvar_17.z;
  tmpvar_20.z = tmpvar_13.z;
  vec3 v_21;
  v_21.x = tmpvar_18.x;
  v_21.y = tmpvar_19.x;
  v_21.z = tmpvar_20.x;
  tmpvar_4.xyz = v_21;
  vec3 v_22;
  v_22.x = tmpvar_18.y;
  v_22.y = tmpvar_19.y;
  v_22.z = tmpvar_20.y;
  tmpvar_5.xyz = v_22;
  vec3 v_23;
  v_23.x = tmpvar_18.z;
  v_23.y = tmpvar_19.z;
  v_23.z = tmpvar_20.z;
  tmpvar_6.xyz = v_23;
  vec3 tmpvar_24;
  tmpvar_24 = normalize((_WorldSpaceLightPos0.xyz - (tmpvar_7.xyz * _WorldSpaceLightPos0.w)));
  tmpvar_4.w = tmpvar_24.x;
  tmpvar_5.w = tmpvar_24.y;
  tmpvar_6.w = tmpvar_24.z;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = texcoord_8;
  xlv_TEXCOORD1 = normalize((tmpvar_7.xyz - _WorldSpaceCameraPos));
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  vec4 tmpvar_25;
  tmpvar_25 = (_Object2World * gl_Vertex);
  xlv_TEXCOORD5 = (_LightMatrix0 * tmpvar_25).xyz;
  xlv_TEXCOORD6 = (tmpvar_25.xyz - _LightPositionRange.xyz);
}


#endif
#ifdef FRAGMENT
uniform vec4 _LightPositionRange;
uniform vec4 _LightShadowData;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform vec4 _Color;
uniform sampler2D _MainTex;
uniform float _Metallic;
uniform float _Glossiness;
uniform samplerCube _ShadowMapTexture;
uniform samplerCube _LightTexture0;
uniform sampler2D _LightTextureB0;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD2_1;
varying vec4 xlv_TEXCOORD2_2;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD6;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = (_Color.xyz * texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz);
  vec3 tmpvar_2;
  vec3 tmpvar_3;
  tmpvar_3 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_1, vec3(_Metallic));
  tmpvar_2 = (tmpvar_1 * (unity_ColorSpaceDielectricSpec.w - (_Metallic * unity_ColorSpaceDielectricSpec.w)));
  vec3 tmpvar_4;
  tmpvar_4 = normalize(xlv_TEXCOORD2_2.xyz);
  vec3 tmpvar_5;
  tmpvar_5.x = xlv_TEXCOORD2.w;
  tmpvar_5.y = xlv_TEXCOORD2_1.w;
  tmpvar_5.z = xlv_TEXCOORD2_2.w;
  vec4 tmpvar_6;
  tmpvar_6 = texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD5, xlv_TEXCOORD5)));
  vec4 tmpvar_7;
  tmpvar_7 = textureCube (_LightTexture0, xlv_TEXCOORD5);
  float mydist_8;
  mydist_8 = ((sqrt(
    dot (xlv_TEXCOORD6, xlv_TEXCOORD6)
  ) * _LightPositionRange.w) * 0.97);
  vec4 tmpvar_9;
  tmpvar_9 = textureCube (_ShadowMapTexture, xlv_TEXCOORD6);
  float tmpvar_10;
  if ((tmpvar_9.x < mydist_8)) {
    tmpvar_10 = _LightShadowData.x;
  } else {
    tmpvar_10 = 1.0;
  };
  vec3 viewDir_11;
  viewDir_11 = -(xlv_TEXCOORD1);
  vec2 tmpvar_12;
  tmpvar_12.x = dot ((viewDir_11 - (2.0 * 
    (dot (tmpvar_4, viewDir_11) * tmpvar_4)
  )), tmpvar_5);
  tmpvar_12.y = (1.0 - clamp (dot (tmpvar_4, viewDir_11), 0.0, 1.0));
  vec2 tmpvar_13;
  tmpvar_13.x = ((tmpvar_12 * tmpvar_12) * (tmpvar_12 * tmpvar_12)).x;
  tmpvar_13.y = (1.0 - _Glossiness);
  vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = ((tmpvar_2 + (
    (texture2D (unity_NHxRoughness, tmpvar_13).w * 16.0)
   * tmpvar_3)) * ((_LightColor0.xyz * 
    ((tmpvar_6.w * tmpvar_7.w) * tmpvar_10)
  ) * clamp (
    dot (tmpvar_4, tmpvar_5)
  , 0.0, 1.0)));
  vec4 xlat_varoutput_15;
  xlat_varoutput_15.xyz = tmpvar_14.xyz;
  xlat_varoutput_15.w = 1.0;
  gl_FragData[0] = xlat_varoutput_15;
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
SubProgram "d3d11_9x " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
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
SubProgram "d3d11_9x " {
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
SubProgram "d3d11_9x " {
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
SubProgram "d3d11_9x " {
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
SubProgram "d3d11_9x " {
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
SubProgram "d3d11_9x " {
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
SubProgram "d3d11_9x " {
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
SubProgram "d3d11_9x " {
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
SubProgram "d3d11_9x " {
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
SubProgram "d3d11_9x " {
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
SubProgram "d3d11_9x " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"// shader disassembly not supported on DXBC"
}
}
 }
 Pass {
  Name "SHADOWCASTER"
  Tags { "LIGHTMODE"="SHADOWCASTER" "SHADOWSUPPORT"="true" "RenderType"="Opaque" "PerformanceChecks"="False" }
  GpuProgramID 488501
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
Fallback "VertexLit"
}