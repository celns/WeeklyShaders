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
//波纹大小
float rippleSize = 0.01;
//亮度
float brightness = 1.2;

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

	//计算距离场的两种方式，区别在于有没有开根号
	//也就是说没开根就是二次函数，开了根就是线性的
	//显然看出来开根的，也就线性的，每个波纹相距是一样的
	//而未开根的，也就是二次的，波纹相距不一样
	float r = -sqrt(fixedst.x * fixedst.x + fixedst.y * fixedst.y); 
	r = -(fixedst.x * fixedst.x + fixedst.y * fixedst.y);
	//试试用不同的三角函数构造depth
	float depth = 0.5 * sin((r+u_time*speed)/rippleSize) + brightness;
	
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


