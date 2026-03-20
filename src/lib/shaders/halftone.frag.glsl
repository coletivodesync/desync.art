uniform float uTime;
uniform vec2 uResolution;

varying vec2 vUv;

#define PI 3.14159265359

// Simple hash for per-element randomness
float hash(vec2 p) {
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453);
}

float hash2(vec2 p) {
    return fract(sin(dot(p, vec2(269.5, 183.3))) * 27614.3721);
}

// Simplex-ish noise for warping
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
  vec3 x1 = x0 - i1 + C.xxx;
  vec3 x2 = x0 - i2 + 2.0 * C.xxx;
  vec3 x3 = x0 - 1.0 + 3.0 * C.xxx;
  i = mod(i, 289.0);
  vec4 p = permute(permute(permute(
             i.z + vec4(0.0, i1.z, i2.z, 1.0))
           + i.y + vec4(0.0, i1.y, i2.y, 1.0))
           + i.x + vec4(0.0, i1.x, i2.x, 1.0));
  float n_ = 1.0/7.0;
  vec3  ns = n_ * D.wyz - D.xzx;
  vec4 j = p - 49.0 * floor(p * ns.z * ns.z);
  vec4 x_ = floor(j * ns.z);
  vec4 y_ = floor(j - 7.0 * x_);
  vec4 x = x_ * ns.x + ns.yyyy;
  vec4 y = y_ * ns.x + ns.yyyy;
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
  vec4 norm = taylorInvSqrt(vec4(dot(p0,p0), dot(p1,p1), dot(p2,p2), dot(p3,p3)));
  p0 *= norm.x; p1 *= norm.y; p2 *= norm.z; p3 *= norm.w;
  vec4 m = max(0.6 - vec4(dot(x0,x0), dot(x1,x1), dot(x2,x2), dot(x3,x3)), 0.0);
  m = m * m;
  return 42.0 * dot(m*m, vec4(dot(p0,x0), dot(p1,x1), dot(p2,x2), dot(p3,x3)));
}

void main() {
    vec2 uv = vUv;

    // Tribal palette
    vec3 crimson = vec3(0.7, 0.18, 0.42);
    vec3 ember = vec3(0.722, 0.353, 0.118);
    vec3 smoke = vec3(0.24, 0.15, 0.17);

    // Noise for warping everything
    float n1 = snoise(vec3(uv * 2.3, uTime * 0.06));
    float n2 = snoise(vec3(uv * 4.7 + 3.1, uTime * 0.04));

    // Warped center — not screen center, drifts slowly
    vec2 center = uv - vec2(0.48 + n1 * 0.04, 0.52 + n2 * 0.03);
    float dist = length(center);
    float angle = atan(center.y, center.x);

    // --- Scattered dots — like spores, not a grid ---
    // Use a loose grid but warp each cell's dot position randomly
    float cellSize = 0.035;
    vec2 cellId = floor(uv / cellSize);
    vec2 cellUv = fract(uv / cellSize);

    // Random offset per cell — dots aren't centered in their cells
    float rx = hash(cellId) * 0.7 + 0.15;
    float ry = hash2(cellId) * 0.7 + 0.15;
    vec2 dotCenter = vec2(rx, ry);

    // Random size per dot
    float dotRand = hash(cellId + 100.0);
    float alive = step(0.55, dotRand); // Only ~45% of cells have a dot

    // Dot size varies — some big, some tiny
    float sizeRand = hash(cellId + 200.0);
    float breathe = sin(uTime * 0.4 + dotRand * 12.0) * 0.3 + 0.7;
    float dotRadius = mix(0.04, 0.18, sizeRand * sizeRand) * breathe;

    float dotDist = length(cellUv - dotCenter);
    float dot = smoothstep(dotRadius, dotRadius * 0.2, dotDist) * alive;

    // Fade based on warped distance from center
    float dotFade = smoothstep(0.55, 0.2, dist) * smoothstep(0.02, 0.1, dist);
    // Some dots fade independently with noise
    dotFade *= smoothstep(-0.2, 0.3, n1 + n2 * 0.5 - 0.1);
    dot *= dotFade;

    // --- Wandering veins / cracks — fine detail ---
    float veinN = snoise(vec3(uv * 12.0 + vec2(uTime * 0.02, -uTime * 0.03), uTime * 0.03));
    float vein = smoothstep(0.015, 0.0, abs(veinN)) * 0.4;
    vein *= smoothstep(0.5, 0.15, dist);
    float veinN2 = snoise(vec3(uv * 22.0 + vec2(-uTime * 0.015, uTime * 0.02), uTime * 0.025));
    float vein2 = smoothstep(0.012, 0.0, abs(veinN2)) * 0.25;
    vein2 *= smoothstep(0.4, 0.1, dist);
    float veinN3 = snoise(vec3(uv * 35.0 + vec2(uTime * 0.01, uTime * 0.015), uTime * 0.02));
    float vein3 = smoothstep(0.01, 0.0, abs(veinN3)) * 0.15;
    vein3 *= smoothstep(0.35, 0.1, dist);
    vein = max(vein, max(vein2, vein3));

    // --- Irregular radial marks — like scratches on rock ---
    // Not evenly spaced, not all the same length
    float scratchAngle = angle + n1 * 0.5; // Warped angle
    float scratchId = floor(scratchAngle * 3.5); // ~7 uneven segments
    float scratchRand = hash(vec2(scratchId, 42.0));
    float scratchPresent = step(0.4, scratchRand); // Only some angles have scratches
    float scratchWidth = 0.008 + scratchRand * 0.012;
    float scratchInner = 0.08 + hash(vec2(scratchId, 13.0)) * 0.12;
    float scratchOuter = scratchInner + 0.06 + hash(vec2(scratchId, 77.0)) * 0.15;
    float scratchLine = smoothstep(scratchWidth, 0.0, abs(mod(scratchAngle, PI * 2.0 / 7.0) - PI / 7.0) * dist);
    scratchLine *= smoothstep(scratchInner, scratchInner + 0.02, dist) * smoothstep(scratchOuter, scratchOuter - 0.02, dist);
    scratchLine *= scratchPresent;
    // Flicker
    scratchLine *= sin(uTime * 0.2 + scratchId * 2.0) * 0.4 + 0.6;

    // --- Compose ---
    // Dot color varies per dot
    float colorVar = hash(cellId + 300.0);
    vec3 dotColor = mix(crimson, ember, colorVar);

    vec3 finalColor = dotColor * dot + smoke * 1.3 * vein + ember * 0.6 * scratchLine;
    float alpha = dot * 0.35 + vein * 0.3 + scratchLine * 0.15;

    gl_FragColor = vec4(finalColor, alpha);
}
