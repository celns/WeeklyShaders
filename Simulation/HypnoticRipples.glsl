//based on https://www.shadertoy.com/view/ldX3zr
#ifdef GL_ES
precision mediump float;
#endif

uniform float u_time;
uniform vec2 u_mouse;
uniform vec2 u_resolution;

vec2 center = vec2(0.5,0.5);
float speed = 0.035;

void main(void)
{
    float invAr = u_resolution.y / u_resolution.x;

    vec2 uv = gl_FragCoord.xy / u_resolution.xy;
		
	vec3 col = vec4(uv,0.5+0.5*sin(u_time),1.0).rgb;
   
    vec3 texcol;
			
	float x = (center.x-uv.x);
	float y = (center.y-uv.y) *invAr;
		
	//float r = -sqrt(x*x + y*y); //uncoment this line to symmetric ripples
	float r = -(x*x + y*y);
	float z = 1.0 + 0.5*sin((r+u_time*speed)/0.013);
	
	texcol.x = z;
	texcol.y = z;
	texcol.z = z;
	
	gl_FragColor = vec4(col*texcol,1.0);
}


