<script lang="ts">
  import "./layout.css";
  import favicon from "$lib/assets/favicon.svg";
  import Header from "$lib/components/layout/Header.svelte";
  import Footer from "$lib/components/layout/Footer.svelte";
  import { onMount } from "svelte";
  import { initSmoothScroll } from "$lib/utils/scroll";

  let { children } = $props();

  onMount(() => {
    const lenis = initSmoothScroll();
    return () => lenis.destroy();
  });
</script>

<svelte:head>
  <link rel="icon" href={favicon} />
  <title>Desync Collective – Música Eletrônica em João Pessoa</title>
  <meta
    name="description"
    content="Coletivo de música eletrônica focado em comunidade, trazendo techno, experimental e drum & bass pra João Pessoa."
  />
</svelte:head>

<Header />

<main>
  {@render children()}
</main>

<Footer />
