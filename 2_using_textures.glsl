
#ifdef GL_ES
precision highp float;
precision highp int;
precision highp sampler2D;
#endif

uniform vec2 u_resolution;

uniform sampler2D u_texture_0;
uniform sampler2D u_texture_1;
uniform sampler2D u_texture_2;
uniform sampler2D u_texture_3;
uniform sampler2D u_texture_4;
uniform sampler2D u_texture_5;

void main() {
    vec2 uv = gl_FragCoord.xy/u_resolution;

    if (uv.x < 0.333){
        gl_FragColor = texture2D(u_texture_0, uv);
    }
    else if (uv.x > 0.666){
        gl_FragColor = texture2D(u_texture_2, uv);
    }
    else {
        gl_FragColor = texture2D(u_texture_4, uv);
    }

}