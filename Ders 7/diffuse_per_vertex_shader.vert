#version 120

// sabit degiskenler
uniform mat4 MVP,ModelView;

// diziden alinacak degiskenler
attribute vec4 Position;
attribute vec3 Normal;

// fragment shader'a aktarilacak veriler
varying vec4 color;

// vertex shader main metodu
void main()
{	
    // camera space position
    vec3 vVertex = vec3(ModelView * Position);
    // camera space normal
    vec3 normal = mat3(ModelView)*Normal;
    
    vec3 lightDir = vec3(gl_LightSource[0].position.xyz - vVertex);
	vec3 eyeVec = -vVertex;
    
    vec3 N = normal;
	vec3 L = normalize(lightDir);
	
	float intensity = dot(N,L);
    
    color = gl_LightSource[0].ambient;
    
    color += gl_LightSource[0].diffuse * intensity;
    
    if(intensity > 0.0)
    {
        vec3 E = normalize(eyeVec);
		vec3 R = reflect(-L, N);
		float specular = pow( max(dot(R, E), 0.0), 32 );
		color += gl_LightSource[0].specular * specular;	
	}
    
    gl_Position = MVP * Position;
}
	
