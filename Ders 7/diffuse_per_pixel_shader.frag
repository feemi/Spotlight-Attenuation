#version 120

// vertex shaderindan gelen veriler
varying vec3 normal,pos;

const float cos_outer_cone_angle = 0.8; // 36 degrees

// fragment shader main metodu
void main(void)
{
    vec3 lightDir = vec3(gl_LightSource[0].position.xyz -pos);
    vec3 eyeVec = -pos;
    vec3 N = normalize(normal);
    vec3 L = normalize(lightDir);
    vec3 D = normalize(gl_LightSource[0].spotDirection);
	float cos_cur_angle = dot(-L, D);
	float cos_inner_cone_angle = gl_LightSource[0].spotCosCutoff;
	float cos_inner_minus_outer_angle = 
	cos_inner_cone_angle - cos_outer_cone_angle;

	float spot = 0.0;
	spot = clamp((cos_cur_angle - cos_outer_cone_angle) / cos_inner_minus_outer_angle, 0.0, 1.0);

    float lambertTerm = max( dot(N,L), 0.0);
    float d = length(lightDir);
    vec4 final_color = vec4(0.0,0.0,0.0,1.0);

    float att = 1.0 / ( gl_LightSource[0].constantAttenuation + (gl_LightSource[0].linearAttenuation*d) + (gl_LightSource[0].quadraticAttenuation*d*d) );
    
    
        // Specular Light
		if(lambertTerm > 0.0)
		{
			    final_color = gl_LightSource[0].ambient *att *spot;
				final_color += gl_LightSource[0].diffuse * lambertTerm *att *spot;

            vec3 E = normalize(eyeVec);
            vec3 R = reflect(-L, N);
            float specular = pow( max(dot(R, E), 0.0), 32 );
            final_color += gl_LightSource[0].specular * specular *att*spot ;
        }
    
	
	
	
	gl_FragColor = final_color;
}

