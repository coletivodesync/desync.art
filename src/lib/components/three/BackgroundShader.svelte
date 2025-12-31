<script lang="ts">
	import { T, useTask } from '@threlte/core';
	import { ShaderMaterial, PlaneGeometry } from 'three';
	import vertexShader from '$lib/shaders/background.vert.glsl?raw';
	import fragmentShader from '$lib/shaders/background.frag.glsl?raw';

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

		// 130 BPM = 2.166 beats/sec, 4/4 bar = 1.846 sec
		// Create pulsing effect that follows the beat
		const bpm = 130;
		const beatsPerSecond = bpm / 60;
		const barDuration = 4 / beatsPerSecond; // One 4/4 bar

		// Pulse multiplier - slower, like kickdrum hits
		const pulse = 1.0 + Math.sin(time * (2 * Math.PI / barDuration)) * 0.5;

		material.uniforms.uTime.value += delta * 0.08 * pulse;
	});
</script>

<T.Mesh {geometry} {material} position={[0, 0, -10]} />
