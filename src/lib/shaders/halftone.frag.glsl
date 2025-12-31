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

	// Match background shader noise pattern
	float noise1 = snoise(vec3(uv * 2.0, uTime * 0.1));
	float noise2 = snoise(vec3(uv * 4.0, uTime * 0.15));
	float noise3 = snoise(vec3(uv * 8.0, uTime * 0.05));

	// Combine noise layers
	float combinedNoise = noise1 * 0.5 + noise2 * 0.3 + noise3 * 0.2;

	// Create gradient based on UV position (same as background)
	float gradient = length(uv - 0.5);

	// Match background shader colors (same as background.frag.glsl)
	vec3 magenta = vec3(0.910, 0.247, 0.780);      // #E83FC7
	vec3 darkBlue = vec3(0.165, 0.290, 0.478);     // #2A4A7A
	vec3 brown = vec3(0.420, 0.329, 0.267);        // #6B5444
	vec3 deepPurple = vec3(0.302, 0.247, 0.624);   // #4D3F9F
	vec3 background = vec3(0.039, 0.055, 0.078);   // #0A0E14

	// Calculate background color (same logic as background shader)
	vec3 bgColor = background;
	bgColor = mix(bgColor, deepPurple, smoothstep(0.3, 0.7, combinedNoise + 0.5));
	bgColor = mix(bgColor, magenta, smoothstep(0.6, 1.0, combinedNoise + gradient * 0.5));
	bgColor = mix(bgColor, darkBlue, smoothstep(0.0, 0.4, gradient - combinedNoise * 0.3));
	bgColor = mix(bgColor, brown, smoothstep(0.7, 1.0, gradient) * 0.2);

	// Vignette
	float vignette = 1.0 - gradient * 0.6;
	bgColor *= vignette;

	// Lighten the background color for the squares - very subtle
	vec3 lightenedColor = bgColor + vec3(0.08); // Barely lighter

	// Determine where the shader has color based on actual brightness
	float luminance = dot(bgColor, vec3(0.299, 0.587, 0.114));
	float colorPresence = smoothstep(0.08, 0.25, luminance); // Only show where visibly bright

	// Grid density - even smaller squares
	float gridSize = 150.0;
	vec2 grid = uv * gridSize;
	vec2 gridId = floor(grid);
	vec2 gridUv = fract(grid);

	// Wave pattern - creates size variation
	float wave1 = sin(gridId.x * 0.3 + uTime * 1.0) * 0.5 + 0.5;
	float wave2 = sin(gridId.y * 0.4 - uTime * 0.8) * 0.5 + 0.5;
	float wave3 = sin((gridId.x + gridId.y) * 0.2 + uTime * 0.6) * 0.5 + 0.5;

	// Combine waves for size variation - smaller range so squares don't open too much
	float sizeVariation = mix(0.15, 0.55, (wave1 + wave2 + wave3) / 3.0);

	// Create square pattern
	vec2 center = vec2(0.5);
	vec2 fromCenter = abs(gridUv - center);
	float squareSize = sizeVariation * 0.45;

	// Square distance
	float square = max(fromCenter.x, fromCenter.y);
	float squareMask = step(square, squareSize);

	// Output - lightened version of background color
	float alpha = squareMask * 0.25 * colorPresence; // Very subtle overlay

	gl_FragColor = vec4(lightenedColor, alpha);
}
