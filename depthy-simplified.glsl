
#ifdef GL_ES
precision highp float;
precision highp int;
precision highp sampler2D;
#endif

uniform sampler2D u_texture_0;
uniform sampler2D u_texture_1;

uniform vec2 u_resolution;
uniform vec2 u_mouse;

// Zero depth
float focus = 0.5;
// Scale depth range
float scale = 1.;
// ViewSynPos
vec2 offset = vec2(u_mouse.x/10000.0, 0.0)+vec2(-0.05, 0.);

#define COLORAVG
#define MAXSTEPS 40.0
#define CONFIDENCE_MAX 4.5

float steps = MAXSTEPS;

float correctPower = 1.0;//max(1.0, steps / 8.0);

const float dmin = 0.0;
const float dmax = 1.0;

const float vectorCutoff = 0.0 + dmin - 0.0001;

float aspect = 1.0;
vec2 scale2 = vec2(min(1.0, 1.0 / aspect), min(1.0, aspect)) * vec2(1, -1);
// scale2 = vec2(1.0, -1.0);

mat2 baseVector = mat2(vec2(-offset/2.0) * scale2, 
                       vec2(offset/2.0) * scale2);
//baseVector ~ vec2(-1,0), vec2(1,0) for viewSynPos +
//baseVector ~ vec2(1,0), vec2(-1,0) for viewSynPos -

void main(void) {

  vec2 uv = gl_FragCoord.xy/u_resolution;
  mat2 vector = baseVector;
  
  float dstep = 1.0 / (steps - 1.0);
  // 1 / 39

  vec2 vectorStep = (vector[1] - vector[0]) / vec2(steps - 1.0);
  // (1/39, 0)
  // (-1/39, 0)

  vec4 colSum = vec4(0.0);

  float confidenceSum = 0.0;

  for(float i = 0.0; i < MAXSTEPS; ++i) {
        // i == 0 => uv+vector[1]    (uv + 1)
        // i == 39 => uv+vector[0]   (uv - 1)
        vec2 ithTexturePos = uv + vector[1] - i * vectorStep;

        // i == 0 => 1.0             (x)
        // i == 39 => 0.0            (x)
        float dpos = 1.0 - i * dstep;

        float ithTexel = texture2D(u_texture_1, ithTexturePos).r;
        ithTexel = clamp(ithTexel, dmin, dmax);

        float confidence;

        // non-zero if dpos < ithTexel
        confidence = step(dpos, ithTexel + 0.001);

        // confidence *= step(vectorCutoff, dpos);
        // Pick first 4 texels
        confidence *= step(confidenceSum, CONFIDENCE_MAX);

        colSum += texture2D(u_texture_0, ithTexturePos +
            (
                vec2(  (ithTexel - dpos) / dstep ) * vectorStep
            )
        ) * confidence;

        confidenceSum += confidence;

  };
    gl_FragColor = colSum / vec4(confidenceSum);

}