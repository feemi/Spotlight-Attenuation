#version 120

// sabit degiskenler
uniform mat4 MVP,ModelView;

// diziden alinacak degiskenler
attribute vec4 Position;
attribute vec3 Normal;

// fragment shader'a aktarilacak veriler
varying vec3 normal,pos;

// vertex shader main metodu
void main()
{	
    // gl_Position ekranda noktanin nerede olacagini belirtir.
    vec3 vVertex = vec3(ModelView * Position);
    
    normal = mat3(ModelView)*Normal;
    pos = vVertex;

	vec3 lightDir = vec3(gl_LightSource[0].position.xyz - vVertex);
	vec3 eyeVec = -vVertex;
    
    vec3 N = normalize(normal);
	vec3 L = normalize(lightDir);


    
    gl_Position = MVP * Position;
}