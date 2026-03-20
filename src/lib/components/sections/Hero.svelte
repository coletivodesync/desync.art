<script lang="ts">
  import { onMount } from "svelte";
  import Scene from "$lib/components/three/Scene.svelte";

  let mounted = $state(false);

  onMount(() => {
    mounted = true;
  });
</script>

<section
  class="relative h-screen flex items-center justify-center overflow-hidden"
>
  <!-- 3D Background -->
  {#if mounted}
    <Scene />
  {:else}
    <!-- Fallback gradient while mounting -->
    <div
      class="absolute inset-0 bg-gradient-to-br from-desync-ember/30 via-background to-desync-crimson/20"
    ></div>
  {/if}

  <!-- Content - Organic Positioning -->
  <div class="relative z-20 px-4" style="margin-left: -3vw; margin-top: -2vh;">
    <h1
      class="font-display font-planet-kosmos transition-all duration-1000 pointer-events-none"
      class:opacity-0={!mounted}
      class:translate-y-10={!mounted}
      class:opacity-100={mounted}
      class:translate-y-0={mounted}
      style="font-size: clamp(2rem, 10vw, 7rem); letter-spacing: -0.03em; line-height: 1; padding-bottom: 0.05em; overflow: visible; transform: rotate(-0.5deg);"
    >
      <span class="gradient-text" style="display: inline-block; padding: 0.3em 0.5em 0 0;">desync</span>
    </h1>
  </div>

  <!-- Scroll Indicator -->
  <div class="absolute bottom-8 left-1/2 -translate-x-1/2 pulse-irregular">
    <svg
      xmlns="http://www.w3.org/2000/svg"
      class="h-6 w-6 text-foreground/50"
      fill="none"
      viewBox="0 0 24 24"
      stroke="currentColor"
    >
      <path
        stroke-linecap="round"
        stroke-linejoin="round"
        stroke-width="2"
        d="M19 14l-7 7m0 0l-7-7m7 7V3"
      />
    </svg>
  </div>
</section>

<style>
  .translate-y-10 {
    transform: translateY(2.5rem);
  }

  .translate-y-0 {
    transform: translateY(0);
  }
</style>
