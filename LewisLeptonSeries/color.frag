#ifdef GL_ES
precision mediump float;
#endif

void main(){
    vec3 color = vec3(0.1,0.2,0.3);
    gl_FragColor = vec4(color, 1.0);
}