//Koch Snowflake again by nimitz (@stormoid)
//https://www.shadertoy.com/view/Mlf3RX
//

#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;


//koch函数
float koch(vec2 st)
{
    float ft = mod(floor(u_time),6.)+1.;
    st = abs(fract(st)-0.5);
    for(int i=0;i<12;++i)
    {
        if (floor(float(i)*.5) > ft)break; //"animation"
            //One loc version
            st = -vec2(-st.y + st.x*1.735, abs(st.x + st.y*1.735) - 0.58)*.865; 
            
    }
    
    return mod(floor(u_time),2.)>0. ? abs(st.x)/(ft*ft)*14. : st.x/(ft*ft)*16.;

}

void main(void)
{
    vec2 st = gl_FragCoord.xy / u_resolution.xy;
    st.x *= u_resolution.x / u_resolution.y;

    vec2 offsetst = st - 0.5;
    //暂时没发现有什么卵用
    //offsetst = clamp(offsetst, -0.55, 0.55);

	float rz = koch(offsetst.yx*.9+vec2(0.5, 0.0));
    //取反色
    //rz = 1.-clamp(rz,0.0,1.0);
    
    //vec3 color = vec3(rz)*vec3(1,.97,.92);
    vec3 color = vec3(rz);

    //限定显示数量为1个雪花
	//float lp = length(offsetst*6.);
	//color -= pow(lp*.23,2.)*rz;
	
	//背景颜色
	//vec3 bg = vec3(0.1,0.2,0.3)*1.3;
	//color = mix(bg,color, rz);
	//color -= lp*.03;
    
	gl_FragColor = vec4(color,1.0);
}
