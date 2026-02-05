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

    <!-- Desktop Navigation -->
    <nav class="hidden md:flex items-center gap-8">
      <button
        onclick={() => scrollToSection("parties")}
        class="text-foreground hover:text-desync-magenta transition-colors"
      >
        Genres
      </button>
      <button
        onclick={() => scrollToSection("events")}
        class="text-foreground hover:text-desync-magenta transition-colors"
      >
        Events
      </button>
      <button
        onclick={() => scrollToSection("mixes")}
        class="text-foreground hover:text-desync-magenta transition-colors"
      >
        Mixes
      </button>
      <button onclick={() => scrollToSection("newsletter")} class="btn-primary">
        Join
      </button>
    </nav>

    <!-- Mobile Menu Button -->
    <button
      onclick={() => (mobileMenuOpen = !mobileMenuOpen)}
      class="md:hidden p-2 text-foreground"
      aria-label="Toggle menu"
      aria-expanded={mobileMenuOpen}
    >
      {#if !mobileMenuOpen}
        <svg
          xmlns="http://www.w3.org/2000/svg"
          class="h-6 w-6"
          fill="none"
          viewBox="0 0 24 24"
          stroke="currentColor"
        >
          <path
            stroke-linecap="round"
            stroke-linejoin="round"
            stroke-width="2"
            d="M4 6h16M4 12h16M4 18h16"
          />
        </svg>
      {:else}
        <svg
          xmlns="http://www.w3.org/2000/svg"
          class="h-6 w-6"
          fill="none"
          viewBox="0 0 24 24"
          stroke="currentColor"
        >
          <path
            stroke-linecap="round"
            stroke-linejoin="round"
            stroke-width="2"
            d="M6 18L18 6M6 6l12 12"
          />
        </svg>
      {/if}
    </button>
  </div>
</header>

<!-- Mobile Menu Overlay -->
{#if mobileMenuOpen}
  <div
    class="fixed inset-0 z-40 bg-background md:hidden"
    role="dialog"
    aria-modal="true"
  >
    <div class="flex flex-col items-center justify-center h-full gap-8">
      <button
        onclick={() => scrollToSection("parties")}
        class="text-3xl font-display text-foreground hover:gradient-text transition-colors"
      >
        Parties
      </button>
      <button
        onclick={() => scrollToSection("events")}
        class="text-3xl font-display text-foreground hover:gradient-text transition-colors"
      >
        Events
      </button>
      <button
        onclick={() => scrollToSection("mixes")}
        class="text-3xl font-display text-foreground hover:gradient-text transition-colors"
      >
        Mixes
      </button>
      <button
        onclick={() => scrollToSection("newsletter")}
        class="btn-primary text-xl"
      >
        Join
      </button>
    </div>
  </div>
{/if}

<style>
  button {
    background: none;
    border: none;
    cursor: pointer;
    font: inherit;
  }
</style>
