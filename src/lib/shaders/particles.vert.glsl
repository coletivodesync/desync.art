uniform float uTime;
uniform float uSize;

attribute float aScale;
attribute vec3 aRandomPos;

varying vec3 vColor;

void main() {
    vec4 modelPosition = modelMatrix * vec4(position, 1.0);

    // Animate particles - chaotic, organic movement
    float wave = sin(uTime * 0.8 + aRandomPos.x * 10.0) * 0.5;
    modelPosition.y += wave;
    modelPosition.x += sin(uTime * 0.6 + aRandomPos.y * 8.0) * 0.6;
    modelPosition.z += cos(uTime * 0.7 + aRandomPos.z * 6.0) * 0.4;

    // Add secondary wave for more complexity
    modelPosition.y += sin(uTime * 0.3 + aRandomPos.z * 5.0) * 0.3;
    modelPosition.x += cos(uTime * 0.4 + aRandomPos.x * 7.0) * 0.25;

    vec4 viewPosition = viewMatrix * modelPosition;
    vec4 projectedPosition = projectionMatrix * viewPosition;
    gl_Position = projectedPosition;

    // Size attenuation
    gl_PointSize = uSize * aScale * (1.0 / -viewPosition.z);

    // Color variation
    float colorMix = aRandomPos.x;
    vec3 magenta = vec3(0.910, 0.247, 0.780);
    vec3 deepPurple = vec3(0.302, 0.247, 0.624);
    vColor = mix(deepPurple, magenta, colorMix);
}
