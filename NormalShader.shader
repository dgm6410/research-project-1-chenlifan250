// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'



Shader "Custom/MyShader" {

	//Properties will appear on the inspector in unity editor. Usually, it could be color, texture map, normal map, etc.
	//However, I don't need any property, so I leave it blank.
	Properties {

	}

	// A shader can contain several SubShaders. If GPU support, the first SubShader will be used. If GPU don't support, the unity will try next SubShader. 
	//So, actually, only one of the SubShaders will be used. Therefore, it's good to write subshaders as many as possible to adapt on different computers.
	SubShader {

		//A SubShader can contain several Passes and every pass will be used. I consider a Pass as a layer in Photoshop.
		Pass{

			//CG is one of shader languages, used in DirectX originally.
			CGPROGRAM

			//tell unity 'vert' is vertex shader 
			#pragma vertex vert

			//tell unity 'frag' is fragment shader
			#pragma fragment frag

			//define a structure.
			//'a2v'means 'application to vertex shader'
			struct a2v{
				float4 vertex: POSITION;
				float3 normal: NORMAL;
				float4 texcoord: TEXCOORD0;
			};

			//'v2f' means 'vertex shader to fragment shader'
			struct v2f{
				float4 pos: SV_POSITION;
				fixed3 color: COLOR0;
			};

			//Here is my vertex Shader
			v2f vert(a2v v) {
				v2f o;
				//transfer vertex position from world coordinates to screen clip coordinates
				o.pos = UnityObjectToClipPos (v.vertex);
				//color = normal + 0.5
				o.color = v.normal * 0.5 + fixed3(0.5, 0.5, 0.5);
				//return vertex position and color
				return o;
			}

			//Here is my fragment shader
			fixed4 frag(v2f i) : SV_Target{
				//simply return the color from vertex shader
				return fixed4(i.color, 1.0);
			}

			ENDCG
		}
	}
	
}
