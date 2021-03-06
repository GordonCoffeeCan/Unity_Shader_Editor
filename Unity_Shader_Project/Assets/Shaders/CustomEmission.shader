// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:0,bdst:0,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:9361,x:33397,y:32798,varname:node_9361,prsc:2|emission-889-OUT;n:type:ShaderForge.SFN_Tex2d,id:7481,x:32611,y:32721,ptovrint:False,ptlb:node_7481,ptin:_node_7481,varname:node_7481,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:600624ded2b17344aa5b8e68f36b1837,ntxv:0,isnm:False|UVIN-4054-UVOUT;n:type:ShaderForge.SFN_Panner,id:4054,x:32382,y:32721,varname:node_4054,prsc:2,spu:0.3,spv:0|UVIN-4753-UVOUT;n:type:ShaderForge.SFN_TexCoord,id:4753,x:32140,y:32841,varname:node_4753,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Tex2d,id:8187,x:32611,y:32949,ptovrint:False,ptlb:node_7481_copy,ptin:_node_7481_copy,varname:_node_7481_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:1af45cacbc75a3245b2546bbd8079c97,ntxv:0,isnm:False|UVIN-7549-UVOUT;n:type:ShaderForge.SFN_Panner,id:7549,x:32382,y:32949,varname:node_7549,prsc:2,spu:0,spv:0.2|UVIN-4753-UVOUT;n:type:ShaderForge.SFN_Add,id:1035,x:32885,y:32841,varname:node_1035,prsc:2|A-7481-RGB,B-8187-RGB;n:type:ShaderForge.SFN_Color,id:9399,x:32885,y:33058,ptovrint:False,ptlb:node_9399,ptin:_node_9399,varname:node_9399,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Multiply,id:889,x:33129,y:32954,varname:node_889,prsc:2|A-1035-OUT,B-9399-RGB;proporder:7481-8187-9399;pass:END;sub:END;*/

Shader "MyShader/CustomEmission" {
    Properties {
        _node_7481 ("node_7481", 2D) = "white" {}
        _node_7481_copy ("node_7481_copy", 2D) = "white" {}
        [HDR]_node_9399 ("node_9399", Color) = (0.5,0.5,0.5,1)
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Blend One One
            Cull Off
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform sampler2D _node_7481; uniform float4 _node_7481_ST;
            uniform sampler2D _node_7481_copy; uniform float4 _node_7481_copy_ST;
            uniform float4 _node_9399;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                UNITY_FOG_COORDS(1)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
////// Lighting:
////// Emissive:
                float4 node_2182 = _Time;
                float2 node_4054 = (i.uv0+node_2182.g*float2(0.3,0));
                float4 _node_7481_var = tex2D(_node_7481,TRANSFORM_TEX(node_4054, _node_7481));
                float2 node_7549 = (i.uv0+node_2182.g*float2(0,0.2));
                float4 _node_7481_copy_var = tex2D(_node_7481_copy,TRANSFORM_TEX(node_7549, _node_7481_copy));
                float3 emissive = ((_node_7481_var.rgb+_node_7481_copy_var.rgb)*_node_9399.rgb);
                float3 finalColor = emissive;
                fixed4 finalRGBA = fixed4(finalColor,1);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
        Pass {
            Name "ShadowCaster"
            Tags {
                "LightMode"="ShadowCaster"
            }
            Offset 1, 1
            Cull Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_SHADOWCASTER
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            struct VertexInput {
                float4 vertex : POSITION;
            };
            struct VertexOutput {
                V2F_SHADOW_CASTER;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_SHADOW_CASTER(o)
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
