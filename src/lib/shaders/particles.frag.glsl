varying vec3 vColor;

void main() {
    // Create circular particle
    float distance = length(gl_PointCoord - vec2(0.5));
    float alpha = 1.0 - smoothstep(0.0, 0.5, distance);

    // Bright center for bloom effect
    float brightness = 1.0 - smoothstep(0.0, 0.3, distance);
    vec3 color = vColor * (1.0 + brightness * 0.5);

    gl_FragColor = vec4(color, alpha * 0.6);
}
