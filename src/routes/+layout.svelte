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
  <title>Desync Collective – Electronic Music in João Pessoa</title>
  <meta
    name="description"
    content="Community-first electronic music collective bringing techno, experimental, and drum & bass to João Pessoa, Brazil."
  />
</svelte:head>

<Header />

<main>
  {@render children()}
</main>

<Footer />
