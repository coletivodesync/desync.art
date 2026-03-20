<script lang="ts">
  import Hero from "$lib/components/sections/Hero.svelte";
  import { onMount } from "svelte";
  import { gsap } from "gsap";
  import { ScrollTrigger } from "gsap/ScrollTrigger";

  gsap.registerPlugin(ScrollTrigger);

  onMount(() => {
    // Animate sections on scroll
    gsap.utils.toArray("section:not(:first-child)").forEach((section: any) => {
      gsap.from(section, {
        opacity: 0,
        y: 40,
        duration: 0.7,
        ease: "power3.out",
        scrollTrigger: {
          trigger: section,
          start: "top 75%",
          toggleActions: "play none none reverse",
        },
      });
    });

    // Animate cards/items with stagger
    gsap.utils.toArray(".glassmorphism").forEach((card: any) => {
      gsap.from(card, {
        opacity: 0,
        y: 20,
        scale: 0.97,
        duration: 0.6,
        ease: "power2.out",
        scrollTrigger: {
          trigger: card,
          start: "top 80%",
        },
      });
    });
  });
</script>

<!-- Hero Section -->
<Hero />

<!-- About Section - Broken Grid -->
<section
  id="about"
  class="px-6 py-24 md:px-12 md:py-32 relative overflow-hidden"
>
  <!-- Organic branches - left -->
  <svg
    class="absolute left-0 top-20 w-32 h-64 opacity-30"
    viewBox="0 0 100 200"
  >
    <path
      d="M 10 0 Q 30 50, 15 100 T 25 200"
      stroke="#E83FC7"
      stroke-width="3"
      fill="none"
      opacity="0.8"
    />
    <path
      d="M 10 0 Q 5 60, 20 120 T 10 200"
      stroke="#E83FC7"
      stroke-width="2"
      fill="none"
      opacity="0.6"
    />
  </svg>
  <!-- Organic branches - right -->
  <svg
    class="absolute right-0 bottom-32 w-32 h-64 opacity-30"
    viewBox="0 0 100 200"
  >
    <path
      d="M 90 0 Q 70 50, 85 100 T 75 200"
      stroke="#4D3F9F"
      stroke-width="3"
      fill="none"
      opacity="0.8"
    />
    <path
      d="M 90 0 Q 95 60, 80 120 T 90 200"
      stroke="#4D3F9F"
      stroke-width="2"
      fill="none"
      opacity="0.6"
    />
  </svg>

  <div class="max-w-7xl mx-auto relative z-10">
    <h2
      class="font-display font-bold text-7xl md:text-9xl mb-24 gradient-text"
      style="letter-spacing: -0.05em; transform: rotate(-1deg);"
    >
      dessincronize
    </h2>

    <!-- Asymmetric Values -->
    <div class="grid grid-cols-1 md:grid-cols-12 gap-12 md:gap-6">
      <div class="md:col-span-3 md:col-start-2 transform md:-rotate-2">
        <h3 class="font-display text-5xl font-bold mb-3 text-desync-magenta">
          em
        </h3>
        <p class="text-foreground/60 text-sm" style="margin-left: 7px;">
          joão pessoa,
        </p>
      </div>
      <div class="md:col-span-4 md:col-start-6 transform md:translate-y-12">
        <h3
          class="font-display text-5xl font-bold mb-3 text-desync-deep-purple"
        >
          dance
        </h3>
        <p class="text-foreground/60 text-sm" style="margin-left: 3px;">
          com o melhor do
        </p>
      </div>
      <div
        class="md:col-span-3 md:col-start-10 transform md:rotate-1 md:-translate-y-6"
      >
        <h3 class="font-display text-5xl font-bold mb-3 text-desync-magenta">
          som
        </h3>
        <p class="text-foreground/60 text-sm" style="margin-left: 11px;">
          qualidade e
        </p>
      </div>
      <div
        class="md:col-span-5 md:col-start-6 transform md:-rotate-z-5 md:translate-y-16"
      >
        <h3 class="font-display text-6xl font-bold mb-3 text-desync-magenta">
          atenção
        </h3>
        <p class="text-foreground/60 text-sm" style="margin-left: 11px;">
          aos detalhes.
        </p>
      </div>
    </div>
  </div>
</section>

<!-- Party Series Section - Asymmetric -->
<section id="parties" class="relative py-32 overflow-hidden">
  <div
    class="absolute inset-0 bg-gradient-to-br from-desync-deep-purple/5 to-transparent"
    style="transform: skewY(-2deg);"
  ></div>
  <!-- Organic branches - left -->
  <svg
    class="absolute left-0 top-1/3 w-28 h-56 opacity-30"
    viewBox="0 0 100 200"
  >
    <path
      d="M 15 0 Q 35 60, 20 120 T 30 200"
      stroke="#2A4A7A"
      stroke-width="3"
      fill="none"
      opacity="0.8"
    />
    <path
      d="M 15 0 Q 10 70, 25 130 T 15 200"
      stroke="#2A4A7A"
      stroke-width="2"
      fill="none"
      opacity="0.6"
    />
  </svg>
  <!-- Organic branches - right -->
  <svg
    class="absolute right-0 top-1/2 w-28 h-56 opacity-30"
    viewBox="0 0 100 200"
  >
    <path
      d="M 85 0 Q 65 60, 80 120 T 70 200"
      stroke="#E83FC7"
      stroke-width="3"
      fill="none"
      opacity="0.8"
    />
    <path
      d="M 85 0 Q 90 70, 75 130 T 85 200"
      stroke="#E83FC7"
      stroke-width="2"
      fill="none"
      opacity="0.6"
    />
  </svg>

  <div class="relative px-6 md:px-12 max-w-7xl mx-auto z-10">
    <!-- Deep - Left Heavy -->
    <div class="mb-32 md:mb-48 transform md:-translate-x-12">
      <div
        class="inline-block border-l-4 border-desync-deep-purple pl-8 md:pl-12"
      >
        <h3
          class="font-display font-bold text-6xl md:text-8xl mb-2 text-desync-deep-purple"
          style="letter-spacing: -0.03em; line-height: 0.9;"
        >
          Deep
        </h3>
        <p
          class="text-foreground/40 text-sm tracking-widest uppercase"
          style="margin-left: 2px;"
        >
          Experimental / Hypnotic Techno / Dub Techno
        </p>
        <p
          class="text-text-secondary/30 text-xs mt-1"
          style="margin-left: 5px;"
        >
          explore sua verdadeira forma
        </p>
      </div>
    </div>

    <!-- Breakbeat - Right Heavy -->
    <div class="text-right transform md:translate-x-12">
      <div class="inline-block border-r-4 border-desync-magenta pr-8 md:pr-12">
        <h3
          class="font-display font-bold text-6xl md:text-8xl mb-2 text-desync-magenta"
          style="letter-spacing: -0.03em; line-height: 0.9;"
        >
          Jungle
        </h3>
        <p
          class="text-foreground/40 text-sm tracking-widest uppercase"
          style="margin-right: 2px;"
        >
          Drum & Bass / UK Garage
        </p>
        <p
          class="text-text-secondary/30 text-xs mt-1"
          style="margin-right: 5px;"
        >
          dance sem parar
        </p>
      </div>
    </div>
  </div>
</section>

<!-- Events Section - Diagonal -->
<section
  id="events"
  class="py-24 md:py-40 px-6 md:px-12 relative overflow-hidden"
>
  <div
    class="absolute top-0 right-0 w-1/3 h-full bg-desync-magenta/5"
    style="transform: skewX(-12deg) translateX(20%);"
  ></div>
  <!-- Organic branches - left -->
  <svg
    class="absolute left-0 bottom-20 w-32 h-64 opacity-30"
    viewBox="0 0 100 200"
  >
    <path
      d="M 10 0 Q 30 50, 15 100 T 25 200"
      stroke="#6B5444"
      stroke-width="3"
      fill="none"
      opacity="0.8"
    />
    <path
      d="M 10 0 Q 5 60, 20 120 T 10 200"
      stroke="#6B5444"
      stroke-width="2"
      fill="none"
      opacity="0.6"
    />
  </svg>
  <!-- Organic branches - right -->
  <svg
    class="absolute right-0 top-40 w-32 h-64 opacity-30"
    viewBox="0 0 100 200"
  >
    <path
      d="M 90 0 Q 70 50, 85 100 T 75 200"
      stroke="#4D3F9F"
      stroke-width="3"
      fill="none"
      opacity="0.8"
    />
    <path
      d="M 90 0 Q 95 60, 80 120 T 90 200"
      stroke="#4D3F9F"
      stroke-width="2"
      fill="none"
      opacity="0.6"
    />
  </svg>

  <div class="max-w-7xl mx-auto relative z-10">
    <div class="transform md:-rotate-1">
      <h2
        class="font-display font-bold text-7xl md:text-9xl mb-6 gradient-text"
        style="letter-spacing: -0.04em;"
      >
        Eventos
      </h2>
      <p
        class="text-foreground/30 text-xs tracking-[0.3em] uppercase mb-12"
        style="margin-left: 9px;"
      >
        Trimestral / Shotgun
      </p>
      <div style="margin-left: 23px;">
        <a
          href="https://shotgun.live"
          target="_blank"
          rel="noopener noreferrer"
          class="btn-primary inline-block transform hover:rotate-1 transition-transform"
        >
          Shotgun
        </a>
      </div>
    </div>
  </div>
</section>

<!-- Mixes Section - Organic Chaos -->
<section
  id="mixes"
  class="py-32 md:py-48 px-6 md:px-12 relative overflow-hidden"
>
  <div
    class="absolute inset-0 bg-gradient-to-tr from-background via-desync-brown/5 to-background"
  ></div>
  <!-- Organic branches - left -->
  <svg
    class="absolute left-0 top-1/4 w-36 h-72 opacity-30"
    viewBox="0 0 100 200"
  >
    <path
      d="M 10 0 Q 30 50, 15 100 T 25 200"
      stroke="#E83FC7"
      stroke-width="3"
      fill="none"
      opacity="0.8"
    />
    <path
      d="M 10 0 Q 5 60, 20 120 T 10 200"
      stroke="#E83FC7"
      stroke-width="2"
      fill="none"
      opacity="0.6"
    />
  </svg>
  <!-- Organic branches - right -->
  <svg
    class="absolute right-0 bottom-1/3 w-32 h-64 opacity-30"
    viewBox="0 0 100 200"
  >
    <path
      d="M 90 0 Q 70 50, 85 100 T 75 200"
      stroke="#2A4A7A"
      stroke-width="3"
      fill="none"
      opacity="0.8"
    />
    <path
      d="M 90 0 Q 95 60, 80 120 T 90 200"
      stroke="#2A4A7A"
      stroke-width="2"
      fill="none"
      opacity="0.6"
    />
  </svg>

  <div class="relative max-w-7xl mx-auto z-10">
    <h2
      class="font-display font-bold text-8xl md:text-9xl mb-20 gradient-text text-right transform rotate-1"
      style="letter-spacing: -0.05em; margin-right: -3px;"
    >
      Mixes
    </h2>

    <!-- Asymmetric Cards -->
    <div class="space-y-16 md:space-y-0">
      <!-- Latest Mix - Top Left -->
      <div
        class="glassmorphism p-8 max-w-md transform md:-translate-x-8 hover:border-desync-magenta/50 transition-all drift"
        style="margin-left: 17px;"
      >
        <div
          class="aspect-square bg-gradient-to-br from-desync-magenta/20 to-desync-deep-purple/20 mb-6 flex items-center justify-center transform -rotate-1"
        >
          <div
            class="text-desync-magenta/30 text-6xl font-display pulse-irregular"
          >
            01
          </div>
        </div>
        <h3
          class="font-display font-bold text-2xl mb-2"
          style="margin-left: 3px;"
        >
          Recente
        </h3>
        <p
          class="text-foreground/40 text-xs tracking-wider"
          style="margin-left: 7px;"
        >
          Em breve
        </p>
      </div>

      <!-- Archive - Bottom Right -->
      <div
        class="glassmorphism p-8 max-w-md ml-auto transform md:translate-x-12 md:-translate-y-24 hover:border-desync-deep-purple/50 transition-all drift"
        style="margin-right: 11px;"
      >
        <div
          class="aspect-square bg-gradient-to-br from-desync-deep-purple/20 to-desync-dark-blue/20 mb-6 flex items-center justify-center transform rotate-2"
        >
          <div
            class="text-desync-deep-purple/30 text-6xl font-display pulse-irregular"
          >
            ∞
          </div>
        </div>
        <h3
          class="font-display font-bold text-2xl mb-2 text-right"
          style="margin-right: 5px;"
        >
          Arquivo
        </h3>
        <p
          class="text-foreground/40 text-xs tracking-wider text-right"
          style="margin-right: 9px;"
        >
          Sets anteriores
        </p>
      </div>

      <!-- SoundCloud - Floating -->
      <div
        class="text-center md:absolute md:top-1/2 md:left-1/2 md:-translate-x-1/2 md:-translate-y-1/2 transform rotate-0 md:rotate-3"
      >
        <a
          href="https://soundcloud.com"
          target="_blank"
          rel="noopener noreferrer"
          class="inline-block glassmorphism px-12 py-8 hover:border-desync-magenta/50 transition-all group"
        >
          <h3
            class="font-display font-bold text-4xl gradient-text group-hover:scale-110 transition-transform inline-block"
          >
            SoundCloud
          </h3>
        </a>
      </div>
    </div>
  </div>
</section>
