//
//  Light.h
//  Ders 7
//
//  Created by Gurel Erceis on 3/31/13.
//  Copyright (c) 2013 Yogurt3D. All rights reserved.
//

#ifndef Ders_7_Light_h
#define Ders_7_Light_h

#ifdef _WIN32
#include <GL/glew.h>
#include <GL/gl.h>
#else if __APPLE__
#include <OpenGL/gl.h>
#endif
#include "SceneNode.h"

class Light:public SceneNode{
public:
	glm::vec3 spotDire;
    Light(){
		 spotDire = glm::vec3(0,0,-1);
		 
        
    }
    virtual ~Light(){
     
	
    }
    void setId(unsigned int index){
        _index = index; 
    }
	void rotateSpot(GLfloat x,GLfloat y , GLfloat z)
	{	
		
		spotDire+=glm::vec3(x,y,z);
	}
    void draw(SceneNode* camera){
        glm::vec4 position = glm::vec4(getGlobalPosition(),1.0);
        GLfloat light_ambient[] = { 0.1, 0.1, 0.1,1.0 };
        GLfloat light_diffuse[] = { 1,1, 1.0, 1.0 }; 
        GLfloat light_specular[] = { 1.0, 1.0, 1.0, 1.0 };
		//GLfloat pos[] = { 0.0,900.0,0,1.0 };
		glm::vec3 spotDir = glm::vec3(spotDire);
        glLoadIdentity();
        glEnable(GL_LIGHTING);
        
        // GL_LIGHT0 = 0x4000
        glEnable(0x4000+_index);
        glLightfv(0x4000+_index, GL_POSITION,  &position[0]);
        glLightfv(0x4000+_index, GL_AMBIENT, light_ambient);
        glLightfv(0x4000+_index, GL_DIFFUSE, light_diffuse);
        glLightfv(0x4000+_index, GL_SPECULAR, light_specular);

		glLightf(0x4000+_index,GL_SPOT_CUTOFF,30);
        glLightf(0x4000+_index,GL_SPOT_EXPONENT,1);
       glLightfv(0x4000+_index,GL_SPOT_DIRECTION,&spotDir[0]);
	   glLightf( GL_LIGHT0, GL_CONSTANT_ATTENUATION, 0.0f );	
       glLightf( GL_LIGHT0, GL_LINEAR_ATTENUATION , 0.0f );	
       glLightf( GL_LIGHT0, GL_QUADRATIC_ATTENUATION , 0.00003 );

        
    }
private:
    unsigned int _index;
};


#endif
