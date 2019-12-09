//based on https://www.shadertoy.com/view/ldX3zr
#ifdef GL_ES
precision mediump float;
#endif

uniform float u_time;
uniform vec2 u_mouse;
uniform vec2 u_resolution;

uniform sampler2D u_texture_0;


//中心点
vec2 center = vec2(0.5,0.5);
//速度
float speed = 0.035;

void main(void)
{
	//高宽比
    float invAspectRatio = u_resolution.y / u_resolution.x;

    vec2 st = gl_FragCoord.xy / u_resolution.xy;
	//st.x *= u_resolution.x / u_resolution.y;
		
	vec3 col = vec4(st,0.5+0.5*sin(u_time),1.0).rgb;
   
    vec3 ripplemask = vec3(0.0);

	//center居中
	vec2 fixedst = vec2(0.0);		
	fixedst.x = (center.x-st.x);
	fixedst.y = (center.y-st.y) *invAspectRatio;
	//y = center.y - st.y;	

	//ripple深度
	float r = -sqrt(fixedst.x * fixedst.x + fixedst.y * fixedst.y); //uncoment this line to symmetric ripples
	r = -(fixedst.x * fixedst.x + fixedst.y * fixedst.y);
	float depth = 1.0 + 0.5*tan((r+u_time*speed)/0.013);
	
	//ripplemask.x = z;
	//irpplemask.y = z;
	//ripplemask.z = z;
	ripplemask = vec3(depth) ;
	
	gl_FragColor = vec4(col * ripplemask,1.0);
	//ripple mask
	//gl_FragColor = vec4(ripplemask, 1.0);
	//ripple mask 与 纹理贴图
	//gl_FragColor = vec4(texture2D(u_texture_0,fixedst).rbg * ripplemask, 1.0);
}


