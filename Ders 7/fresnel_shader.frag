#version 120


// Reflected and refracted vectors
varying vec3 reflectedVector, refractedVector;
// Reflection factor based on fresnel equation
varying float refFactor;
void main()
{

vec4 reflectedColor = vec4(1.0,0.0,1.0,0.5);
vec4 refractedColor = vec4(1.0,1.0,0.0,1);
gl_FragColor = mix(refractedColor, reflectedColor, refFactor);
}