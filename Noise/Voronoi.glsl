#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

void main(void)
{
    vec2 st = gl_FragCoord.xy / u_resolution.xy;
    
    st.x =st.x * (u_resolution.x / u_resolution.y);
    vec3 color = vec3(0.0);

    vec2 points[5];
    points[0] = vec2(0.83,0.75);
    points[1] = vec2(0.60,0.07);
    points[2] = vec2(0.28，0.64);
    points[3] =  vec2(0.31,0.26);
    points[4] = u_mouse.xy /u_resolution.xy;
    //注释掉这一行，在输出窗口有拉伸的情况下，鼠标和屏幕上的点就错位了
    points[4].x *= u_resolution.x / u_resolution.y;

    float min_distance = 1.0;
    vec2 min_point;

    for(int i = 0; i<=4; i++)
    {
        float distpp = distance(st, points[i]);

            if(distpp < min_distance)
            {
                min_distance = distpp;
                min_point = points[i];
            }

    }

    color += min_distance * 2.0;
    color.rg = min_point;
    color -= abs(0.05 * sin(200.0 * min_distance));
    color += 1.0 - step(0.005, min_distance);

    gl_FragColor = vec4(color, 1.0);


}