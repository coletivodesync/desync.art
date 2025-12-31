<script lang="ts">
	import { T, useTask } from '@threlte/core';
	import { ShaderMaterial, PlaneGeometry } from 'three';
	import vertexShader from '$lib/shaders/halftone.vert.glsl?raw';
	import fragmentShader from '$lib/shaders/halftone.frag.glsl?raw';

	const geometry = new PlaneGeometry(100, 100);
	const material = new ShaderMaterial({
		vertexShader,
		fragmentShader,
		uniforms: {
			uTime: { value: 0 },
			uResolution: { value: [typeof window !== 'undefined' ? window.innerWidth : 1920, typeof window !== 'undefined' ? window.innerHeight : 1080] }
		},
		transparent: true,
		depthWrite: false
	});

	let time = 0;
	useTask((delta) => {
		time += delta;

		// 130 BPM 4/4 rhythm - sync with other animations
		const bpm = 130;
		const beatsPerSecond = bpm / 60;
		const barDuration = 4 / beatsPerSecond;

		// Pulse multiplier for rhythmic wave movement
		const pulse = 1.0 + Math.sin(time * (2 * Math.PI / barDuration)) * 0.3;

		material.uniforms.uTime.value += delta * 0.5 * pulse;
	});
</script>

<T.Mesh {geometry} {material} position={[0, 0, -9]} />
