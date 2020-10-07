#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;

float circle(vec2 position, float radius)
{
    return step(radius, length(position));
    
}


void main()
{
    vec2 position = gl_FragCoord.xy / u_resolution;
    position.x *= u_resolution.x / u_resolution.y;
    
    vec3 color = vec3(0.0);
    color += circle(position-vec2(0.5),0.5);
    //color = vec3(1.0)-color;
    gl_FragColor = vec4(color, 1.0);
}