#define PI 3.1415
vec2 fixUv(in vec2 fragCood) {
    return 10. * (fragCood - 0.5 * iResolution.xy) / min(iResolution.x, iResolution.y);
}
vec3 setGrid(in vec2 p) {
    vec3 col = vec3(0.);
    if (fract(p.x) <= fwidth(p.x)) {
        col = vec3(1.);
    }
    if (fract(p.y) <= fwidth(p.y)) {
        col = vec3(1.);
    }
    if (p.x <= fwidth(p.x) && p.x > -fwidth(p.x)) {
        col.y = 0.;
    }
     if (p.y <= fwidth(p.y) && p.y > -fwidth(p.y)) {
        col.z = 0.;
    }
    return col;
}

float setLine(in vec2 p, in vec2 s, in vec2 e, in float r) {
    float w = 0.;
    vec2 ps = p - s;
    vec2 es = e - s;
    float proj = clamp(dot(es, ps) / dot(es, es), 0., 1.);
    float l = length(proj * es - ps);
    if (l <= r) {
        w = 1.;
    }
    return w;
}

float setFunc(in float x) {
    float T = 3. - sin(iTime* 10.) ;
    return sin(2. * PI / T - x);
}

float funcPlot(in vec2 uv) {
    float f = 0.;
    for(float i=0.; i<=iResolution.x; i+=1.0){
        float x1 = fixUv(vec2(i, 0)).x;
        float x2 = fixUv(vec2(i+1., 0)).x;
        f += setLine(uv, vec2(x1, setFunc(x1)), vec2(x2, setFunc(x2)), fwidth(uv.x));
    }
    return clamp(f, 0., 1.);
}



void mainImage(out vec4 fragColor, in vec2 fragcoord){
    vec2 uv = 10. * (fragcoord - 0.5 * iResolution.xy) / min(iResolution.x, iResolution.y);
    vec3 col = setGrid(uv);
    float l = setLine(uv, vec2(0., 0.), vec2(3., 1.), fwidth(uv.x));
    col = mix(col, vec3(1., 0., 0.), l);
    float s = funcPlot(uv);
    col = mix(col, vec3(1., 1., 0.), s);
    fragColor = vec4(col, 1.);
}