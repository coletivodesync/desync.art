<script lang="ts">
  import { onMount } from "svelte";

  let scrolled = $state(false);
  let mobileMenuOpen = $state(false);

  onMount(() => {
    const handleScroll = () => {
      scrolled = window.scrollY > 50;
    };

    window.addEventListener("scroll", handleScroll);
    return () => window.removeEventListener("scroll", handleScroll);
  });

  function scrollToSection(id: string) {
    const element = document.getElementById(id);
    if (element) {
      element.scrollIntoView({ behavior: "smooth" });
      mobileMenuOpen = false;
    }
  }
</script>

<header
  class="fixed top-0 left-0 right-0 z-50 transition-all duration-300"
  class:glassmorphism={scrolled}
  class:bg-transparent={!scrolled}
>
  <div class="section-container py-4 flex items-center justify-between">
    <!-- Logo -->
    <a
      href="/"
      class="text-2xl font-display font-planet-kosmos gradient-text no-underline"
    >
      desync
    </a>
  </div>
</header>

<style>
  button {
    background: none;
    border: none;
    cursor: pointer;
    font: inherit;
  }
</style>
