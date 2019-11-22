#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;
uniform vec2 u_mouse;

vec2 random2d(vec2 rect)
{
    vec2 randomvec2seed = vec2(dot(rect, vec2(127.1, 311.7)), 
                                dot(rect, vec2(269.5,183.3)));
    return fract(sin(randomvec2seed) * 43758.5457);
}

void main(void)
{
    vec2 st = gl_FragCoord.xy / u_resolution.xy;
    st.x *= u_resolution.x / u_resolution.y;
    vec3 color = vec3(0.0);

    st = st*10.0;

    vec2 int_st = floor(st);
    vec2 fract_st = fract(st);

    float min_distance = 1.0;

    for(int i = -1; i <= 1; i++)
    {
        for(int k = -1; k <= 1; k++)
        {
            vec2 neighboroffset = vec2 (float(i), float(k));
            vec2 gridMainPoint = random2d(int_st + neighboroffset);

            gridMainPoint =0.5+ 0.5 * cos(.5 *(u_time) + 6.28 * gridMainPoint);

            vec2  vecPixPoint = neighboroffset + gridMainPoint -fract_st;
            float vppdistance = length(vecPixPoint);
            min_distance = min(min_distance, vppdistance);
        }
    }

    color = color + (min_distance);
    //color = color + step(0.6, abs(sin(20.0 * min_distance)));

    gl_FragColor = vec4(color.x*0.5, color.x*0.7, 0.0, 1.0);

}