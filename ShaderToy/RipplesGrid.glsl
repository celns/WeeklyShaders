//这是一个基于距离场处理的shader

float pi = 3.141592;

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = (fragCoord.xy / iResolution.xy) ;
    //居中
    uv = uv  -0.5; //*2.0 - 1.0
    //保持宽高比
    float aspect = iResolution.x/iResolution.y;
    uv.x *= aspect;
    
    
    vec2 center = vec2(0.0);
    //距离场    
    float dist = length(uv - center);// * sin(3.141592 * iTime);
    //dist *= sin(pi * iTime);
    
    float time = iTime;
    
    float rippleRadius = time;
    //时间减去距离场
    float diff = rippleRadius - dist;
    
    float func = 2.0 * sin(pi * diff);
    
    uv = uv + uv * func * 0.1;
    
    
    
    //uv *= vec2(sin(iTime), cos(iTime));
    
    float stripes = 30.0;
    float thickness = 10.0;
    float sharpness = 5.0;
    vec2 pulse = abs(sin(stripes * uv));
    
    
    //绘制网格,基本就是exp函数的各种参数调整
    vec3 grid = vec3(0.0);
    //grid +=exp( -thickness * pulse.x);

    //绘制列
    //第一个参数可以控制亮度
    grid += 1.0 * exp(-thickness * pulse.x * (0.8 + 0.5 * sin(pi * iTime)));
    //绘制行
    grid += 1.0 * exp(-thickness * pulse.y);
    //发光边缘
    grid += 0.5 * exp(-(thickness/5.0) * sin(pulse.x));
    grid += 0.5 * exp(-(thickness/3.0) * pulse.y);
    
    //mask,距离center的一个随距离场渐变mask
    
    float mask = exp(-4.5 * clamp(pow(dist, 3.0), 0.0, 1.0));
    //反转一下mask试试？
    //mask = 1.0 - mask;

    //基于uv的颜色变换
    vec3 color = vec3(uv.x * 0.5+0.5*sin(iTime), uv.y * 0.5+0.5*cos(iTime), pow(cos(iTime), 4.0)) + 0.5;
    
    fragColor = vec4(grid * color * mask , 0.0);
    
}