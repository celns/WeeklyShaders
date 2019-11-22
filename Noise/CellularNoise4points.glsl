#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

uniform vec2 u_mouse;

void main(void)
{
    vec2 st = gl_FragCoord.xy / u_resolution.xy;
    //保持宽高比
    st.x *= u_resolution.x / u_resolution.y;
    vec3 color = vec3(0.0);

    vec2 point[5];
    point[0] = vec2(0.83,0.75);
    point[1] = vec2(0.60,0.07);
    point[2] = vec2(0.28,0.64);
    point[3] =  vec2(0.31,0.26);

    point[4] = u_mouse/u_resolution;
    //不仅仅是保持宽高比
    point[4].x *= u_resolution.x / u_resolution.y;


        float min_dist = 0.7; 


    for (int i = 0; i < 5; i++) 
    {
        float dist = distance(st, point[i]);
        min_dist = min(min_dist, dist);
    }

    min_dist = fract(min_dist);
    color = color + min_dist;

    gl_FragColor = vec4(color, 1.0);
}