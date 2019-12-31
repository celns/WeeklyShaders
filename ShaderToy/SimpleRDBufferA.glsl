#iChannel0 'self'

#define TIMESTEP 1.0

#define F 0.0545
#define K 0.062
#define Da 1.0
#define Db 0.5

void getVal(vec2 p, out vec2 val, out vec2 laplacian) {
  vec2 r = iResolution.xy;
  vec2 uv = p / r;
  vec2 n = p + vec2(0.0, 1.0);
  vec2 ne = p + vec2(1.0, 1.0);
  vec2 nw = p + vec2(-1.0, 1.0);
  vec2 e = p + vec2(1.0, 0.0);
  vec2 s = p + vec2(0.0, -1.0);
  vec2 se = p + vec2(1.0, -1.0);
  vec2 sw = p + vec2(-1.0, -1.0);
  vec2 w = p + vec2(-1.0, 0.0);

  val = texture(iChannel0, uv).xy;
  laplacian = texture(iChannel0, n / r).xy * 0.2;
  laplacian += texture(iChannel0, e / r).xy * 0.2;
  laplacian += texture(iChannel0, s / r).xy * 0.2;
  laplacian += texture(iChannel0, w / r).xy * 0.2;
  laplacian += texture(iChannel0, nw / r).xy * 0.05;
  laplacian += texture(iChannel0, ne / r).xy * 0.05;
  laplacian += texture(iChannel0, sw / r).xy * 0.05;
  laplacian += texture(iChannel0, se / r).xy * 0.05;
  laplacian += -1.0 * val;   
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord.xy / iResolution.xy;
    
    vec3 colour = vec3(0.0);
    if (iFrame < 10) {
        if (uv.x > 0.45 && uv.x < 0.55 && uv.y > 0.45 && uv.y < 0.55) {
            colour = vec3(1.0);
        }
    } else {
     	vec2 val, laplacian;
        getVal(fragCoord.xy, val, laplacian);
        
        vec2 delta;
 		delta.x = Da * laplacian.x - val.x * val.y * val.y + F * (1.0 - val.x);
  		delta.y = Db * laplacian.y + val.x * val.y * val.y - (K + F) * val.y;
        
        colour = vec3(val + delta * TIMESTEP, 0.0);
    }
    
    fragColor = vec4(colour,1.0);
}