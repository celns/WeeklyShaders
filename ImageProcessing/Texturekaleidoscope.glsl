//万花镜
//整个变换并不是移动了texture，而是变换了像素坐标st，或者可以称之为uv

//极坐标与笛卡尔坐标的互相转换
//笛卡尔转极坐标
//tan θ = y/x,
// 所以 θ = atan（y/x)
//r = sqrt(x*x + y*y)
//极坐标转笛卡尔
//x = r * cos(θ)
//y = r * sin(θ)


#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359
#define TWO_PI 6.28318530718

uniform sampler2D u_texture_0;
//uniform vec2 u_tex0Resolution;

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;
//x轴偏移
float xoffset = 1.0;

// Based on Asalga shader
// https://www.shadertoy.com/view/4ss3WX

//在笛卡尔坐标中。x, y 均有变化
//在极坐标中，r在曾减，同时角度在正负变换

void main () {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    st.x *= u_resolution.x /u_resolution.y;
    
    float time = u_time*0.5;

    //x轴偏移
    //st.x -= xoffset;
    // 中心偏移
    st = st - 0.5;
    
    // 笛卡尔转换为极坐标
    float radius = length(st);

    //下面两个atan是相同的, 
    //但是用第二个应该会有性能提升(这里需要取查看atan的源码来下定论)
    //float theta = atan( st.y/st.x );
    float theta = atan( st.y, st.x);


    // 万花个数
    //也就是基本图元的重复个数
    float side_num = 10.0;
    //
    //万花镜的移动是向着极坐标中心，并且图元总是中心对称的
    //
    //变换角度ma，ma主要是用来复制并切分基本图元
    //theta 对 2Π/side_num 取余
    float ma = mod(theta, TWO_PI/side_num);
    //切分，就是说将每个side进行内部切分，对半切，由分形的元素
    ma = abs(ma - PI/side_num);
    //
    //上面，用TWO_PI进行图元复制
    //用PI进行切分
    //用成2倍的数字都可以完成这项工作
    //

    // 极坐标转到笛卡尔坐标，使用ma作为角度进行变换
    //对radius进行的移动处理
    st = radius * vec2(cos(ma), sin(ma));

    //试一试同心圆
    //st = radius * vec2(2.0);

    st*=3.0;
    //动起来，试试正负号不同的效果
    //st = fract(st - time);
    //st = fract(st + time);

    vec4 color = vec4(st.x,st.y,0.0,1.0);
    //vec4 color = vec4(0.0);
    color = texture2D(u_texture_0,st);

    gl_FragColor = color;
}