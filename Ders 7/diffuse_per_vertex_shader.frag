#version 120

// vertex shaderindan gelen veriler
varying vec4 color;

// fragment shader main metodu
void main(void)
{
	gl_FragColor = color;
    
    
}
