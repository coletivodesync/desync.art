<script lang="ts">
	import { T, useTask } from '@threlte/core';
	import { BufferGeometry, BufferAttribute, ShaderMaterial, Points } from 'three';
	import vertexShader from '$lib/shaders/particles.vert.glsl?raw';
	import fragmentShader from '$lib/shaders/particles.frag.glsl?raw';

	interface Props {
		count?: number;
	}

	let { count = 3000 }: Props = $props();

	// Create geometry with random positions
	function createGeometry(particleCount: number) {
		const geometry = new BufferGeometry();
		const positions = new Float32Array(particleCount * 3);
		const scales = new Float32Array(particleCount);
		const randomPos = new Float32Array(particleCount * 3);

		for (let i = 0; i < particleCount; i++) {
			// Random positions in a sphere
			const radius = 5 + Math.random() * 5;
			const theta = Math.random() * Math.PI * 2;
			const phi = Math.acos(Math.random() * 2 - 1);

			positions[i * 3] = radius * Math.sin(phi) * Math.cos(theta);
			positions[i * 3 + 1] = radius * Math.sin(phi) * Math.sin(theta);
			positions[i * 3 + 2] = radius * Math.cos(phi) - 5;

			// Random scale
			scales[i] = Math.random();

			// Random values for animation
			randomPos[i * 3] = Math.random();
			randomPos[i * 3 + 1] = Math.random();
			randomPos[i * 3 + 2] = Math.random();
		}

		geometry.setAttribute('position', new BufferAttribute(positions, 3));
		geometry.setAttribute('aScale', new BufferAttribute(scales, 1));
		geometry.setAttribute('aRandomPos', new BufferAttribute(randomPos, 3));

		return geometry;
	}

	const geometry = createGeometry(count);

	// Create material
	const material = new ShaderMaterial({
		vertexShader,
		fragmentShader,
		uniforms: {
			uTime: { value: 0 },
			uSize: { value: 40.0 }
		},
		transparent: true,
		depthWrite: false,
		blending: 2 // AdditiveBlending
	});

	// Create points
	const points = new Points(geometry, material);

	let time = 0;
	useTask((delta) => {
		time += delta;

		// 130 BPM 4/4 rhythm - breathing with the music
		const bpm = 130;
		const beatsPerSecond = bpm / 60;
		const barDuration = 4 / beatsPerSecond; // One 4/4 bar (~1.846 sec)

		// Pulse multiplier - slower, like kickdrum hits driving the motion
		const pulse = 1.0 + Math.sin(time * (2 * Math.PI / barDuration)) * 0.6;

		material.uniforms.uTime.value = time;
		points.rotation.y += delta * 0.025 * pulse;
		points.rotation.x = Math.sin(time * 0.015) * 0.06;
	});
</script>

<T is={points} />
