// Author @patriciogv - 2015
// http://patriciogonzalezvivo.com

#ifdef GL_ES
precision mediump float;
#endif

uniform sampler2D u_texture_0;
uniform sampler2D u_texture_1;

uniform float u_time;
uniform vec2 u_mouse;
uniform vec2 u_resolution;

void main (void) {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    st.x *= u_resolution.x / u_resolution.y;
    vec3 color = vec3(0.);
    vec3 colorA = texture2D(u_texture_0,st).rgb;
    vec3 colorB = texture2D(u_texture_1,st).rgb;

    //叠加
    color = colorA+colorB;
    //插值      
    color = colorA-colorB;  
    //绝对插值
    color = abs(colorA-colorB);
    //相乘
    color = colorA*colorB;  
    //相除   
    color = colorA/colorB;  
    //变亮    
    color = max(colorA,colorB); 
    //变暗
    color = min(colorA,colorB); 
    //pow
    color = pow(colorA, vec3(2));

    gl_FragColor = vec4(color,1.0);
}