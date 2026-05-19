precision highp float;
varying vec2 v_texcoord;
uniform sampler2D tex;

float color_dist(vec3 c1, vec3 c2) {
    vec3 diff = normalize(c1) - c2;
    return length(diff);
}

float func(float f) {
    // return sin(f * 3.1416);
    return abs(sin(f * 3.14159 * 0.4));
}

void main() {
    vec4 ci = texture2D(tex, v_texcoord);

    // vec3 co = vec3(
    //     func(ci.r),
    //     func(ci.g),
    //     func(ci.b)
    // );

    vec3 from = vec3(1.0, 1.0, 1.0);
    vec3 to = vec3(1.0, 0.0, 0.0);
    float dist = color_dist(ci.rgb, from);
    vec3 co = mix(ci.rgb, to, 1.0 - dist);

    gl_FragColor = vec4(co, ci.a);
}
