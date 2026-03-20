uniform float uTime;
uniform vec2 uResolution;

varying vec2 vUv;

// Simplex 3D Noise by Ian McEwan, Stefan Gustavson
vec4 permute(vec4 x) { return mod(((x*34.0)+1.0)*x, 289.0); }
vec4 taylorInvSqrt(vec4 r) { return 1.79284291400159 - 0.85373472095314 * r; }

float snoise(vec3 v) {
  const vec2  C = vec2(1.0/6.0, 1.0/3.0);
  const vec4  D = vec4(0.0, 0.5, 1.0, 2.0);

  vec3 i  = floor(v + dot(v, C.yyy));
  vec3 x0 = v - i + dot(i, C.xxx);

  vec3 g = step(x0.yzx, x0.xyz);
  vec3 l = 1.0 - g;
  vec3 i1 = min(g.xyz, l.zxy);
  vec3 i2 = max(g.xyz, l.zxy);

  vec3 x1 = x0 - i1 + 1.0 * C.xxx;
  vec3 x2 = x0 - i2 + 2.0 * C.xxx;
  vec3 x3 = x0 - 1. + 3.0 * C.xxx;

  i = mod(i, 289.0);
  vec4 p = permute(permute(permute(
             i.z + vec4(0.0, i1.z, i2.z, 1.0))
           + i.y + vec4(0.0, i1.y, i2.y, 1.0))
           + i.x + vec4(0.0, i1.x, i2.x, 1.0));

  float n_ = 1.0/7.0;
  vec3  ns = n_ * D.wyz - D.xzx;

  vec4 j = p - 49.0 * floor(p * ns.z *ns.z);

  vec4 x_ = floor(j * ns.z);
  vec4 y_ = floor(j - 7.0 * x_);

  vec4 x = x_ *ns.x + ns.yyyy;
  vec4 y = y_ *ns.x + ns.yyyy;
  vec4 h = 1.0 - abs(x) - abs(y);

  vec4 b0 = vec4(x.xy, y.xy);
  vec4 b1 = vec4(x.zw, y.zw);

  vec4 s0 = floor(b0)*2.0 + 1.0;
  vec4 s1 = floor(b1)*2.0 + 1.0;
  vec4 sh = -step(h, vec4(0.0));

  vec4 a0 = b0.xzyw + s0.xzyw*sh.xxyy;
  vec4 a1 = b1.xzyw + s1.xzyw*sh.zzww;

  vec3 p0 = vec3(a0.xy,h.x);
  vec3 p1 = vec3(a0.zw,h.y);
  vec3 p2 = vec3(a1.xy,h.z);
  vec3 p3 = vec3(a1.zw,h.w);

  vec4 norm = taylorInvSqrt(vec4(dot(p0,p0), dot(p1,p1), dot(p2, p2), dot(p3,p3)));
  p0 *= norm.x;
  p1 *= norm.y;
  p2 *= norm.z;
  p3 *= norm.w;

  vec4 m = max(0.6 - vec4(dot(x0,x0), dot(x1,x1), dot(x2,x2), dot(x3,x3)), 0.0);
  m = m * m;
  return 42.0 * dot(m*m, vec4(dot(p0,x0), dot(p1,x1), dot(p2,x2), dot(p3,x3)));
}

void main() {
    vec2 uv = vUv;

    // Tribal palette — pink-shifted
    vec3 crimson = vec3(0.7, 0.18, 0.42);
    vec3 moss = vec3(0.165, 0.227, 0.157);
    vec3 smoke = vec3(0.24, 0.15, 0.17);
    vec3 ember = vec3(0.722, 0.353, 0.118);
    vec3 bg = vec3(0.035, 0.02, 0.028);

    // Layered noise at different scales — the bones of everything
    float noise1 = snoise(vec3(uv * 1.7, uTime * 0.08));
    float noise2 = snoise(vec3(uv * 3.3 + 5.2, uTime * 0.12));
    float noise3 = snoise(vec3(uv * 7.1 + 2.7, uTime * 0.04));
    float noise4 = snoise(vec3(uv * 13.0 + 8.1, uTime * 0.03)); // fine grain
    float combinedNoise = noise1 * 0.45 + noise2 * 0.3 + noise3 * 0.15 + noise4 * 0.1;

    // Warped coordinates — nothing is centered or symmetrical
    vec2 warpedCenter = uv - vec2(0.48 + noise1 * 0.03, 0.52 + noise2 * 0.02);
    float dist = length(warpedCenter);
    float angle = atan(warpedCenter.y, warpedCenter.x);

    // --- Organic ripples — fine, detailed rings ---
    float warpedDist = dist + noise1 * 0.06 + noise2 * 0.03 + noise3 * 0.015;
    float ringSpeed = uTime * 0.25;
    // Higher frequency rings for finer detail
    float rings1 = sin((warpedDist * 28.0 - ringSpeed) * 3.14159);
    float rings2 = sin((warpedDist * 19.0 + ringSpeed * 0.7) * 3.14159 + 1.3);
    float rings3 = sin((warpedDist * 43.0 - ringSpeed * 0.4) * 3.14159 + 2.7);
    float rings = rings1 * 0.5 + rings2 * 0.3 + rings3 * 0.2;
    rings = smoothstep(0.75, 0.95, rings); // Tighter threshold = thinner lines
    rings *= smoothstep(0.6, 0.15, dist) * (0.7 + noise3 * 0.3);

    // --- Organic veins / root-like tendrils — hi-res ---
    float veinNoise1 = snoise(vec3(uv * 10.0 + vec2(uTime * 0.03, -uTime * 0.05), uTime * 0.04));
    float veinNoise2 = snoise(vec3(uv * 18.0 + vec2(-uTime * 0.02, uTime * 0.04), uTime * 0.03));
    float veinNoise3 = snoise(vec3(uv * 30.0 + vec2(uTime * 0.015, uTime * 0.025), uTime * 0.02));
    float veins = abs(veinNoise1);
    veins = smoothstep(0.025, 0.0, veins) * 0.6; // Thinner lines
    float veins2 = abs(veinNoise2);
    veins2 = smoothstep(0.02, 0.0, veins2) * 0.35;
    float veins3 = abs(veinNoise3);
    veins3 = smoothstep(0.015, 0.0, veins3) * 0.2; // Finest detail layer
    veins = max(veins, max(veins2, veins3));

    // --- Smoke / fog drifting ---
    float smokeA = snoise(vec3(uv.x * 2.5 + 0.3, uv.y * 1.8 - uTime * 0.1, uTime * 0.06));
    float smokeB = snoise(vec3(uv.x * 4.8 + 1.7, uv.y * 3.2 - uTime * 0.08, uTime * 0.05));
    float smokeC = snoise(vec3(uv.x * 1.2 - 3.0, uv.y * 2.5 - uTime * 0.13, uTime * 0.07));
    float smokeTendril = smoothstep(0.1, 0.55, smokeA * 0.5 + smokeB * 0.3 + smokeC * 0.2);
    // Irregular vertical fade
    float vertFade = smoothstep(0.0, 0.25 + noise1 * 0.1, uv.y) * smoothstep(1.0, 0.55 + noise2 * 0.1, uv.y);
    smokeTendril *= vertFade;

    // --- Build color organically ---
    vec3 color = bg;

    // Smoke base — uneven fog
    color = mix(color, smoke, smokeTendril * 0.55);

    // Noise color field — asymmetric blending
    color = mix(color, smoke * 1.2, smoothstep(0.15, 0.55, combinedNoise + 0.45) * 0.35);
    color = mix(color, moss * 0.9, smoothstep(-0.1, 0.35, noise1 - dist * 0.5) * 0.35);
    color = mix(color, moss * 0.6, smoothstep(0.2, 0.5, noise3 + 0.3) * 0.15);

    // Organic ripples — pink crimson
    color = mix(color, crimson * 0.7, rings * 0.45);

    // Veins / roots — pink + ember
    color = mix(color, crimson * 0.5, veins * smoothstep(0.5, 0.1, dist) * 0.7);
    color = mix(color, ember * 0.4, veins * smoothstep(0.5, 0.1, dist) * 0.3);
    color = mix(color, crimson * 0.45, veins * smoothstep(0.1, 0.4, dist) * 0.6);

    // Warm patches — pink glow, wandering
    float warmth1 = smoothstep(0.3, 0.0, length(uv - vec2(0.45 + sin(uTime * 0.07) * 0.05, 0.5 + cos(uTime * 0.09) * 0.04)));
    float warmth2 = smoothstep(0.2, 0.0, length(uv - vec2(0.6 + cos(uTime * 0.05) * 0.04, 0.35 + sin(uTime * 0.08) * 0.03)));
    color = mix(color, crimson * 0.4, warmth1 * 0.35);
    color = mix(color, crimson * 0.3, warmth2 * 0.2);

    // Overall pink wash
    color += crimson * 0.03;

    // Vignette — asymmetric
    float vignette = 1.0 - dist * (0.6 + noise1 * 0.15);
    color *= max(vignette, 0.0);

    gl_FragColor = vec4(color, 1.0);
}
