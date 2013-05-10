#version 120

// sabit degiskenler
uniform mat4 MVP,ModelView;

// diziden alinacak degiskenler
attribute vec4 Position;
attribute vec3 Normal;


// Reflected and refracted vectors
varying vec3 reflectedVector, refractedVector;
// Reflection factor based on fresnel equation
varying float refFactor;
void main()
{
	// camera space position
    vec3 vVertex = vec3(ModelView * Position);
    // camera space normal
    vec3 normal = mat3(ModelView)*Normal;
    
    vec3 lightDir = vec3(gl_LightSource[0].position.xyz - vVertex);
	vec3 eyeVec = -vVertex;

	
    vec3 N = normalize(normal);
    vec3 L = normalize(lightDir);


	float fresnelBias = 2;
	float fresnelPower = 1;

	vec3 Normal = normalize(normal);

	
    // Calculate reflected and refracted vectors
    reflectedVector = reflect(L, N);
    refractedVector = refract(L, N, 0.5);
    // Appoximation of the fresnel equation
     refFactor = fresnelBias+(1-fresnelBias)*pow(1+dot(L,N), fresnelPower);
  
    gl_Position = MVP * Position;
} 
