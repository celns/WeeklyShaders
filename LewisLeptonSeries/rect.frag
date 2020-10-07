#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;

float rectangle(vec2 position, vec2 shape)
{
    shape = vec2(0.5) - shape*0.5;
    vec2 rect = vec2(step(shape.x, position.x), step(shape.y, position.y));
    rect *= vec2(step(shape.x, 1. - position.x), step(shape.y, 1.- position.y));
    return rect.x * rect.y;
}


void main(){
    vec2 position = gl_FragCoord.xy / u_resolution;
    position.x *= u_resolution.x / u_resolution.y;

    vec3 color = vec3(0.0);
    color += rectangle(position, vec2(0.8));

    gl_FragColor = vec4(color, 1.0);
}