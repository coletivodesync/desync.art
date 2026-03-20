<script lang="ts">
  import "./layout.css";
  import favicon from "$lib/assets/favicon.svg";

  import Footer from "$lib/components/layout/Footer.svelte";
  let { children } = $props();
</script>

<svelte:head>
  <link rel="icon" href={favicon} />
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="anonymous" />
  <link href="https://fonts.googleapis.com/css2?family=Chakra+Petch:wght@300;400;500&display=swap" rel="stylesheet" />
  <title>desync</title>
  <meta
    name="description"
    content="Coletivo de música eletrônica focado em comunidade, trazendo techno, experimental e drum & bass pra João Pessoa."
  />
</svelte:head>

<main>
  {@render children()}
</main>

<Footer />
