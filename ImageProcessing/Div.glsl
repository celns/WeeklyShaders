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
    //float aspect = u_resolution.x / u_resolution.y;

    st.x *= u_resolution.x / u_resolution.y;
    //st.y /= aspect;

    vec3 colorA = texture2D(u_texture_0,st).rgb;
    vec3 colorB = texture2D(u_texture_1,st).rgb;

    vec3 color = colorA/colorB;

    gl_FragColor = vec4(color,1.0);
}