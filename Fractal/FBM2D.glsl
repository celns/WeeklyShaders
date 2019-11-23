// Author @patriciogv - 2015
// http://patriciogonzalezvivo.com

#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

//一维随机
float random (in vec2 st) {
    return fract(sin(dot(st.xy,
                         vec2(12.9898,78.233)))*
        43758.5453123);
}

// Based on Morgan McGuire @morgan3d
// https://www.shadertoy.com/view/4dS3Wd
//四值插值噪声
float noise (in vec2 st) {
    vec2 i = floor(st);
    vec2 f = fract(st);

    // Four corners in 2D of a tile
    float a = random(i);
    float b = random(i + vec2(1.0, 0.0));
    float c = random(i + vec2(0.0, 1.0));
    float d = random(i + vec2(1.0, 1.0));

    vec2 u = f * f * (3.0 - 2.0 * f);

    return mix(a, b, u.x) +
            (c - a)* u.y * (1.0 - u.x) +
            (d - b) * u.x * u.y;
}

//分形就是相似波的叠加，而且是一个细分的过程
//也就是说先由粗粒度到细粒度进行分形
//通过多次迭代，缩小幅度（amp）， 增大频率（frequency）进行波的叠加
//其中octave控制了迭代次数，这是个音乐用语，八度
#define OCTAVES 6
float fbm (in vec2 st) {
    // Initial values
    float value = 0.0;
    float amplitude = .5;
    float frequency = 1.;
    //
    // Loop of octaves
    for (int i = 0; i < OCTAVES; i++) {
        //noise就是原始波
        value += amplitude * noise(frequency * st);
        frequency *= 2.;//频率增高
        amplitude *= .5;//幅度降低
    }
    return value;
}

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    st.x *= u_resolution.x/u_resolution.y;

    vec3 color = vec3(0.0);
    color += fbm(st*5.0);

    gl_FragColor = vec4(color,1.0);
}
