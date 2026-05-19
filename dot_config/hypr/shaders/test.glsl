
precision highp float;
varying vec2 v_texcoord;
varying float v_time;
uniform sampler2D tex;

void main() {
    vec4 pc = texture2D(tex, v_texcoord);

    float k = 1.0;
    // float k = cos(pc.r);
    // float k = gl_time;

    float r = pc.r*k + (pc.g + pc.b)/2.0 * (1.0 - k);
    float g = pc.g*k + (pc.b + pc.r)/2.0 * (1.0 - k);
    float b = pc.b*k + (pc.r + pc.g)/2.0 * (1.0 - k);

    // nightmare
    gl_FragColor = vec4(r, g, b, pc.a);

    // invert
    // gl_FragColor = vec4(1.0 - pixColor.r, 1.0 - pixColor.g, 1.0 - pixColor.b, pixColor.a);


}

