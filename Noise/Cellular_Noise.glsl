// Author: @patriciogv
// Title: CellularNoise

#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

vec2 random2( vec2 p ) {
    //伪随机的产生，总是以fract处理一个sin*某个较大的float来产生的
    //这里sin处理了一个vec2，而组成vec2的两个量又是通过dot产生
    //然后sin*某个较大的浮点数，最后用fract来做处理得到最终随机值
    //既然sin处理的是vec2, 那么fract处理之后依然是一个vec2，于是就有了一个二维随机数
    return fract(sin(vec2(dot(p,vec2(127.1,311.7)),dot(p,vec2(269.5,183.3))))*43758.5453);
}

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    //在y轴扩展，也就是说可以将输出窗口拉长，同时会保证基于x轴的比例正确
    st.x *= u_resolution.x/u_resolution.y;
    vec3 color = vec3(.0);

    // uv扩展倍数
    st *= 10.;

    //取整作为uv块坐标
    //取浮作为uv块内坐标
    vec2 i_st = floor(st);
    vec2 f_st = fract(st);

    float m_dist = 1.;  // minimun distance

    //进行基于当前像素点的九个uv块特征点遍历与计算
    //x,y∈{-1, 0, 1}, 三个数，但是如果用类似{1，2，3}之类的是会产生错位的
    for (int y= -1; y <= 1; y++) {
        for (int x= -1; x <= 1; x++) {
            // 当前遍历到的uv块坐标，存一下
            vec2 neighbor = vec2(float(x),float(y));

            //求一下当前遍历到的uv块的特征点坐标，
            //这里伪随机函数很重要，使得我们可以求出这个特征点的坐标
            //比如，当另外的像素在运行这个frag时，他求出来的这个uv快的特征点和现在我们求出来的一样
            vec2 point = random2(i_st + neighbor );

			// 让当前遍历的uv块的特征点动起来
            point = 0.5 + 0.5*sin(10. * u_time + 6.2831*point);

			// 当前像素与特征点的向量
            //
            vec2 diff = neighbor + point - f_st;

            // 向量取模，即为距离
            float dist = length(diff);

            // 九个遍历，距离取最小的
            m_dist = min(m_dist, dist);
        }
    }

    // 把距离可视化出来
    //这就是传说中的距离场
    color += m_dist;

    // Draw cell center
    color += 1.-step(.02, m_dist);

    // Draw grid
    //color.r += step(.98, f_st.x) + step(.98, f_st.y);

    // Show isolines
    //color -= step(.7,abs(sin(27.0*m_dist)))*.5;

    gl_FragColor = vec4(color,1.0);
}
