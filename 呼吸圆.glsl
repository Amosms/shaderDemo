vec2 fixUv(in vec2 fragCood) {
    return 10. * (fragCood - 0.5 * iResolution.xy) / min(iResolution.x, iResolution.y);
}
void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fixUv(fragCoord);

    vec3 col = vec3(0.);

    float s =step(length(uv), clamp(sin(iTime*2.), 0.1, 1.)*8.);
    col = mix(col, vec3(1.), s);

    fragColor = vec4(col, 1.);
}