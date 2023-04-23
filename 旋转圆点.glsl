vec2 fixUv(in vec2 fragCood) {
    return 10. * (fragCood - 0.5 * iResolution.xy) / min(iResolution.x, iResolution.y);
}
vec2 rotateXY(in vec2 p, in float angle) {
    float x = p.x*cos(angle) - p.y*sin(angle);
    float y = p.x * sin(angle) + p.y * cos(angle);
    return vec2(x, y);
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

float setCircle(in vec2 p, in vec2 point, in float r) {
    float w = 0.0;
    vec2 new = rotateXY(p, iTime*3.);
    vec2 v = new - point;
    w += step(length(v), r);
    w += setLine(p, vec2(0.,0.), rotateXY(point, -iTime*3.), fwidth(p.x));
    return w;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fixUv(fragCoord);

    vec3 col = vec3(0.);
    float c = setCircle(uv, vec2(3., 3.), 0.2);
    col = mix(col, vec3(1.), c);

    float yuan = step(length(uv), 0.2);
    col = mix(col, vec3(1.), yuan);


    fragColor = vec4(col, 1.);
}