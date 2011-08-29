varying vec4 P;
varying vec4 Pw;
varying vec3 _V;
varying vec3 _N;
varying vec3 normal;
varying vec4 eyenormal;
varying vec4 eye;
varying vec4 Peye;
varying vec4 bbsize;
uniform vec4 bboxSize;
uniform vec4 transform;
uniform vec4 rotateAngles;
uniform vec4 scale;

float PI = 3.14159265358979323846264;

mat4 rotateX(float angle){
    float rad_angle = angle*PI/180.0;    
    return  mat4( 
                  1.0,           0.0,          0.0, 0.0,
                  0.0,  cos( rad_angle  ), -sin( rad_angle  ), 0.0,
                  0.0,  sin( rad_angle  ),  cos( rad_angle   ), 0.0,
                  0.0,           0.0,          0.0, 1.0 );
}
mat4 rotateY(float angle){
    float rad_angle = angle*PI/180.0;    
    return  mat4( cos( rad_angle  ), -sin( rad_angle  ), 0.0, 0.0,
                  sin( rad_angle  ),  cos( rad_angle   ), 0.0, 0.0,
                  0.0,           0.0,          1.0, 0.0,
                  0.0,           0.0,          0.0, 1.0 );
}
mat4 rotateZ(float angle){
    float rad_angle = angle*PI/180.0;    
    return  mat4( cos( rad_angle  ), 0.0, sin( rad_angle  ), 0.0,
                  0.0,           1.0, 0.0, 0.0,
                  -sin( rad_angle  ),  0.0, cos( rad_angle   ), 0.0,
                  0.0,           0.0,          0.0, 1.0 );
}


void main()
{   
    bbsize = bboxSize;
    bbsize *= scale;
    
//    bbsize = gl_ModelViewMatrix * bbsize;
    
    vec4 new_vertex = gl_Vertex;
    new_vertex +=  transform;
    new_vertex *= rotateX( rotateAngles.x );
    new_vertex *= rotateY( rotateAngles.y );
    new_vertex *= rotateZ( rotateAngles.z );
    new_vertex *= scale;
    
    vec4 newNormal = vec4(gl_Normal,1.0);
    newNormal *= rotateX( rotateAngles.x );
    newNormal *= rotateY( rotateAngles.y );
    newNormal *= rotateZ( rotateAngles.z );
    

    gl_Position = gl_ModelViewProjectionMatrix * new_vertex ;
    P = gl_ProjectionMatrix * new_vertex ;
    Pw = new_vertex ;
    
    _N = normalize(gl_NormalMatrix*newNormal.xyz); 
	_V = -vec3(gl_ModelViewMatrix*new_vertex );
    
//    _N = gl_Normal; 
//	_V = gl_Vertex;
}

