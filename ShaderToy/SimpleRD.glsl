#iChannel0 'buf://./ShaderToy/SimpleRDBufferA.glsl'


#define COLOR_MIN 0.2
#define COLOR_MAX 0.35

float getGradient(vec2 uv)
{
  return (COLOR_MAX - texture(iChannel0, uv).y) /
         (COLOR_MAX - COLOR_MIN);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
	float v = getGradient(uv);
    
    fragColor = vec4(v, v, v, 0.0);
}