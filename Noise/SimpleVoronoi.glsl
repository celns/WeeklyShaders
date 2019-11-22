#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

vec2 random2(vec2 seed)
{
    vec2 vec2seed = vec2(dot(seed, vec2(127.1, 311.7)), 
        dot(seed, vec2(269.71,183.457)));
    
    return fract(sin(vec2seed) * 43758.254);
}

void main(void)
{
    vec2 st = gl_FragCoord.xy / u_resolution.xy;
    st.x *= u_resolution.x/u_resolution.y;
    vec3 color = vec3(0.0);

    st *= 5.0;

    vec2 int_st = floor(st);
    vec2 fract_st = fract(st);
    //最短距离
    float min_distance = 10.0;
    vec2 m_point;

    for(int i = -1; i<= 1; i++)
    {
        for(int k = -1; k<= 1; k++)
        {
            vec2 neroffset = vec2(float(k), float(i));

            vec2 point = random2(int_st + neroffset);
            point *= 0.5 * sin(u_time + 3.24*point) +0.5;

            vec2 pixpoint = neroffset + point - fract_st;
            float ppdistance = length(pixpoint);

            //不是取最小，而是通过一个判断
            //判断提供了交互可能，也就是是说，我们可以加一个鼠标控制的点进去
            
            if(ppdistance < min_distance)
            {
                min_distance = ppdistance;
                m_point = point;
            }

        }
    }

    color += dot(m_point,vec2(.3,.6));

    //color.r = m_point.x;

    //color -= abs(0.1 * sin(50. *min_distance));

    color += 1.0 - step(0.01, min_distance);


    gl_FragColor = vec4(color,1.0);

}