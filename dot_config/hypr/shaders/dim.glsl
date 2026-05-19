precision highp float;
varying vec2 v_texcoord;
uniform sampler2D tex;

void main() {
    vec4 c = texture2D(tex, v_texcoord);
    gl_FragColor = vec4(c.rgb * 0.5, c.a);
}

