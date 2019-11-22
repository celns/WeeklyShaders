#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;


float rand (float seed) {
    return fract(sin(seed) * 1000000.0);
}


float noise(float noiseAmount)
{
    float floorNoiseAmount = floor(noiseAmount);
    float fractNoiseAmount = fract(noiseAmount);

    return mix(rand(floorNoiseAmount), rand(floorNoiseAmount + 1.0),
                    fractNoiseAmount);
}

void main(void)
{
    vec2 st = gl_FragCoord.xy / u_resolution.xy;
    vec3 color = vec3(noise(u_time));

    gl_FragColor = vec4(color, 1.0);
}