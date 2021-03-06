// Star Nest by Pablo Roman Andrioli
//https://www.shadertoy.com/view/XlfGRj

// This content is under the MIT License.

#define iterations 20
#define formuparam 0.53

#define volsteps 10
#define stepsize 0.1

#define zoom   1.5
#define tile   0.850
#define speed  0.010 

#define brightness 0.0015
#define darkmatter 0.300
#define distfading 0.730
#define saturation 0.850


void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	//get coords and direction
	vec2 uv=fragCoord.xy/iResolution.xy-.5;
	uv.y*=iResolution.y/iResolution.x;

	vec3 dir=vec3(uv*zoom,1.0);//z轴方向
	
	float time=iTime*speed+.25;

	//mouse rotation
	float a1=.5+iMouse.x/iResolution.x*2.;
	float a2=.8+iMouse.y/iResolution.y*2.;
	mat2 rot1=mat2(cos(a1),sin(a1),-sin(a1),cos(a1));
	mat2 rot2=mat2(cos(a2),sin(a2),-sin(a2),cos(a2));
	dir.xz*=rot1;
	dir.xy*=rot2;

	vec3 from=vec3(1.0,0.5,0.5);
	from+=vec3(time*2.,time,-2.);
	from.xz*=rot1;
	from.xy*=rot2;
	
	//volumetric rendering
	//s: bright
	float s=0.1,fade=1.0;
	vec3 color=vec3(0.0);
	for (int r=0; r<volsteps; r++) //体积步数
	{
		vec3 p=from+s*dir*.5;
		//p = s * dir * 0.5;
		p = abs(vec3(tile)-mod(p,vec3(tile*2.))); // tiling fold
		float pa,a=0.0;
		for (int i=0; i<iterations; i++) 
		{ 
			p=abs(p)/dot(p,p)-formuparam; // the magic formula
			a+=abs(length(p)-pa); // absolute sum of average change
			pa=length(p);
		}
		float dm=max(0.,darkmatter-a*a*.001); //dark matter
		a*=a*a; // add contrast
		if (r>6) fade*=1.-dm; // dark matter, don't render near
		//v+=vec3(dm,dm*.5,0.);
		color+=fade;
		color+=vec3(s,s*s,s*s*s*s)*a*brightness*fade; // coloring based on distance

		//是一种fbm的变体
		fade*=distfading; // distance fading
		s+=stepsize;
	}
	color=mix(vec3(length(color)),color,saturation); //color adjust
	fragColor = vec4(color*0.01,1.0);	
	
}