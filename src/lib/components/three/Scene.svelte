<script lang="ts">
	import { Canvas } from '@threlte/core';
	import { onMount } from 'svelte';
	import BackgroundShader from './BackgroundShader.svelte';
	import HalftoneOverlay from './HalftoneOverlay.svelte';
	let mounted = $state(false);

	onMount(() => {
		mounted = true;
	});
</script>

{#if mounted}
	<div class="absolute inset-0 z-0">
		<Canvas>
			<BackgroundShader />
			<HalftoneOverlay />
		</Canvas>
	</div>
{/if}
