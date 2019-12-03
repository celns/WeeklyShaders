
#ifdef GL_ES
precision mediump float;
#endif

uniform sampler2D u_texture_1;
uniform vec2 u_texture_1Resolution;

uniform vec2 u_resolution;

void main () {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    st.x *= u_resolution.x / u_resolution.y;
    vec4 color = vec4(0.0);

    // 保持宽高比 aspect ration
    float aspect = u_texture_1Resolution.x/u_texture_1Resolution.y;
    st.y *= aspect;  

    color = texture2D(u_texture_1,st);

    gl_FragColor = color;
}