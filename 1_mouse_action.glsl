
#ifdef GL_ES
precision highp float;
precision highp int;
precision highp sampler2D;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;

void main() {
    vec2 uv = gl_FragCoord.xy/u_resolution;
    vec2 color_shift = u_mouse/1000.0;

    gl_FragColor = vec4(color_shift, 0.0, 1.0);
}