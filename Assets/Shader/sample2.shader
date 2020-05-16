Shader "Custom/sample2"
{
    Properties
    {
        // _Color ("Color", Color) = (1,1,1,1)
         _MainTex ("Texture", 2D) = "white" {}
        // _Glossiness ("Smoothness", Range(0,1)) = 0.5
        // _Metallic ("Metallic", Range(0,1)) = 0.0
    }
    SubShader
    {
        Tags { "Queue"="Transparent" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard alpha:fade

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
            // float3 worldNormal;
            // float3 viewDir;
        };

        half _Glossiness;
        half _Metallic;
        fixed4 _Color;

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            // Albedo comes from a texture tinted by color
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            // fixed4 baseColor = fixed4(0.05, 0.1, 0, 1);
			// fixed4 rimColor  = fixed4(0.5,0.7,0.5,1);
            o.Albedo = c.rgb;
            o.Alpha=(c.r*0.3 + c.g*0.6 + c.b*0.1 < 0.2) ? 1 : 0.5;
            // float rim=1-(saturate(dot(IN.viewDir,o.Normal)));
            // o.Emission=rimColor*pow(rim,2.5);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
