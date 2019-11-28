#ifdef GL_ES
precision mediump float;
#endif

uniform sampler2D u_tex0;
uniform vec2 u_tex0Resolution;

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

#define PI 3.14159265358979

//sin噪声
float random(in vec2 st)
{
    return fract(sin(dot(st.xy, vec2(12.9898, 78.2323)))
     * 43758.54321);
}

//四数插值噪声
float noise(in vec2 st)
{
    vec2 i_st = floor(st);
    vec2 f_st = fract(st);

    float lb = random(i_st);//左下
    float rb = random(i_st + vec2(1.0, 0.0));//右下
    float lt = random(i_st + vec2(0.0, 1.0)); //左上
    float rt = random(i_st + vec2(1.0, 1.0));//右上

    vec2 u = f_st * f_st * (3.0 - 2.0 *f_st);//f的三次函数作为alpha

    //返回一个四随机数插值
    return mix(lb, rb, u.x) + //左下到右下 通过三次f函数的x分量(也就是u.x)插值
            (lt - lb) * u.y *//左下到左上通过u.y进行插值
            (1.0 - u.x) +
            (rt - rb) * u.x * u.y;
    
}

void main(void)
{
    vec2 st = gl_FragCoord.xy / u_resolution.xy;

    float scale = 1.0;
    float offset = 0.25;

    float angle = noise(st + u_time * 0.1) * PI;
    float radius = offset;

    st *= scale;
    st += radius * vec2(cos(angle), sin(angle));

    vec4 color = texture2D(u_tex0, st);

    gl_FragColor = color;
}