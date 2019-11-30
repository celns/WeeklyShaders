  
// Author @patriciogv - 2015
// http://patriciogonzalezvivo.com

#ifdef GL_ES
precision mediump float;
#endif
//对于wrap模式
//使用等比例图片 会自动repeat模式
//使用非等比图片，会使用border模式
uniform sampler2D u_texture_0;
uniform sampler2D u_tex0Resolution;

uniform sampler2D u_texture_1;
uniform vec2 u_tex1Resolution;

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

void main () {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    st.x *= u_resolution.x / u_resolution.y;
    vec4 color = vec4(st.x,st.y,0.0,1.0);

    color = texture2D(u_texture_0,st);

    gl_FragColor = color;
}