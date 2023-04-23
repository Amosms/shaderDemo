#define S(a,b,t) smoothstep(a,b,t)
float DisLine(vec2 p, vec2 a, vec2 b){
    vec2 pa = p -a;
    vec2 ba = b - a;
    float t = clamp(dot(pa, ba)/dot(ba, ba), 0., 1.);
    return length(pa - ba*t);
}
float N21(vec2 p) {
    p = fract(p*vec2(233.34, 805.));
    p += dot(p, p+.5);
    return fract(p.x*p.y);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord){
    vec2 uv = (fragCoord - .5 * iResolution.xy) / min(iResolution.x, iResolution.y);
    // float d = DisLine(uv, vec2(0.), vec2(1.));
    // float m = S(.05, .05, d);
    // m = N21(uv);
    // vec3 col = vec3(m);
    fragColor = vec4(vec3(0., 1., 0.), 1.);
}