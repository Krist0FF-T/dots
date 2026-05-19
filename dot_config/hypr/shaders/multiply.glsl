precision highp float;
varying vec2 v_texcoord;
uniform sampler2D tex;

void main() {
    vec4 ci = texture2D(tex, v_texcoord);
    float m = v_texcoord.y;

    gl_FragColor = vec4(
        ci.rgb * m,
        ci.a
    );
}
