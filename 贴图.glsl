#iChannel0 "file://xunjianluxiantuAA.png"

float smootherstep(float edge0, float edge1, float x) {
    float t = (x - edge0)/(edge1 - edge0);
    float t1 = t*t*t*(t*(t*6. - 15.) + 10.);
    return clamp(t1, 0.0, 1.0);
}
void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = (fragCoord - 0.5 * fragCoord.xy / min(iResolution.x, iResolution.y));
    uv *= 6.;
   vec4 color = vec4(0.0,0.0,0.0,0.0);
   float minN = 0., maxxN=0.8, maxyN=0.8;
    if (uv.x-floor(uv.x) > minN && uv.x-floor(uv.x) < maxxN && uv.y-floor(uv.y) > minN && uv.y-floor(uv.y) < maxyN)
    {
        uv.x = smootherstep(floor(uv.x), floor(uv.x)+maxxN, uv.x);
        uv.y = smootherstep(floor(uv.y), floor(uv.y)+maxyN, uv.y);
   		color = texture(iChannel0, uv);
    }

	fragColor = color;
}