float pi = 3.141592;

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = (fragCoord.xy / iResolution.xy) * 2.0 - 1.0;
    float aspect = iResolution.x/iResolution.y;
    uv.x *= aspect;
    
    
    vec2 pos = vec2(0.0, 0.0);
        
    float dist = length(uv - pos);// * sin(3.141592 * iTime);
    
    float time = iTime;
    
    float rippleRadius = time;
    
    float diff = rippleRadius - dist;
    
    float func = sin(pi * diff);
    
    uv += uv * func * 0.1;
    
    
    
    //uv *= vec2(sin(iTime), cos(iTime));
    
    float stripes = 10.0;
    float thickness = 10.0;
    float sharpness = 2.0;
    vec2 a = sin(stripes * 0.5 * pi * uv - pi/2.0);
    vec2 b = abs(a);
    
    vec3 color = vec3(0.0);
    color += 1.0 * exp(-thickness * b.x * (0.8 + 0.5 * sin(pi * iTime)));
    color += 1.0 * exp(-thickness * b.y);
    color += 0.5 * exp(-(thickness/4.0) * sin(b.x));
    color += 0.5 * exp(-(thickness/3.0) * b.y);
    
    float ddd = exp(-5.5 * clamp(pow(dist, 3.0), 0.0, 1.0));
    
    vec3 t = vec3(uv.x * 0.5+0.5*sin(iTime), uv.y * 0.5+0.5*cos(iTime), pow(cos(iTime), 4.0)) + 0.5;
    
    fragColor = vec4(color * t * ddd, 0.0);
    //fragColor = vec4(ddd);
}