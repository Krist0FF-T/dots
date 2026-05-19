#version 320 es
precision highp float;

in vec2 v_texcoord;
uniform sampler2D tex;
out vec4 fragColor;

float f(float x) {
    // float a = 8.0;
    // return round(x * a) / a;

    return 1.0 - pow(1.0 - x, 2.0);
}

void main() {
    float a = 1920.0 / 2.0;
    float b = 1080.0 / 2.0;

    // vec2 p = vec2(
    //     floor(v_texcoord.x * a) / a,
    //     floor(v_texcoord.y * b) / b
    // );

    // vec2 p = vec2(
    //     floor(v_texcoord.x * a) / a,
    //     floor(v_texcoord.y * b) / b
    // );

    // vec4 color = texture(tex, p);
    vec4 color = texture(tex, v_texcoord);
    // float c = 64.0 / 255.0;
    // float c = 64.0 / 255.0;
    fragColor = color;

    fragColor = vec4(
        f(color.r),
        f(color.g),
        f(color.b),
        color.a
    );
}

