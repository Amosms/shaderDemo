float setCicle(vec2 p, vec2 c, float r){
    return step(length(p-c), r);
}
float setLine(vec2 p, vec2 a, vec2 b) {
    vec2 pa = p-a;
    vec2 ba = b-a;
    float proj = clamp(dot(pa, ba)/dot(ba, ba), 0., 1.);
    vec2 c = a + proj*ba;
    float len = length(c - p);
    return smoothstep(len, 0., len-0.001);
}
void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = (fragCoord - 0.5*iResolution.xy) / iResolution.x;
    vec3 col = vec3(0.);
    vec2 a = vec2(0.1, 0.4);
    vec2 b = vec2(-0.2, -0.4);
    vec2 c = (iMouse.xy - 0.5*iResolution.xy) / iResolution.x;
    float t = sin(iTime)*0.5+0.5;
    vec2 ac = mix(a, c, t);
    vec2 cb = mix(c, b, t);
    vec2 abc = mix(ac, cb, t);
    col += vec3(1., 1., 1.)*setCicle(uv, a, 0.02);
    col += vec3(1., 1., 1.)*setCicle(uv, b, 0.02);
    // col += vec3(1., 1., 1.)*setCicle(uv, c, 0.02);
    // col += vec3(1., 1., 1.)*setCicle(uv, ac, 0.02);
    // col += vec3(1., 1., 1.)*setCicle(uv, cb, 0.02);
    col += vec3(1., 1., 1.)*setCicle(uv, abc, 0.02);

    // col += vec3(1., 1., 1.)*setLine(uv, a, c);
    // col += vec3(1., 1., 1.)*setLine(uv, b, c);
    // col += vec3(1., 1., 1.)*setLine(uv, ac, cb);
    fragColor = vec4(vec3(col), 1.);
}