<script lang="ts">
  import Hero from "$lib/components/sections/Hero.svelte";
  import { onMount } from "svelte";
  import { gsap } from "gsap";
  import { ScrollTrigger } from "gsap/ScrollTrigger";

  gsap.registerPlugin(ScrollTrigger);

  onMount(() => {
    // Animate sections on scroll
    gsap.utils
      .toArray<Element>("section:not(:first-child)")
      .forEach((section) => {
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
    gsap.utils.toArray<Element>(".glassmorphism").forEach((card) => {
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
      stroke="#b32e6b"
      stroke-width="3"
      fill="none"
      opacity="0.8"
    />
    <path
      d="M 10 0 Q 5 60, 20 120 T 10 200"
      stroke="#b32e6b"
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
      stroke="#b85a1e"
      stroke-width="3"
      fill="none"
      opacity="0.8"
    />
    <path
      d="M 90 0 Q 95 60, 80 120 T 90 200"
      stroke="#b85a1e"
      stroke-width="2"
      fill="none"
      opacity="0.6"
    />
  </svg>

  <div class="max-w-7xl mx-auto relative z-10">
    <h2
      class="font-display font-bold mb-24 gradient-text"
      style="font-size: clamp(2.5rem, 10vw, 8rem); letter-spacing: -0.05em; transform: rotate(-1deg);"
    >
      dessincronize
    </h2>

    <!-- Scattered values -->
    <div class="grid grid-cols-1 md:grid-cols-12 gap-16 md:gap-8">
      <div class="md:col-span-5 md:col-start-1 transform md:-rotate-1">
        <h3
          class="font-display text-3xl md:text-4xl font-bold mb-2 text-desync-crimson"
        >
          música como ritual
        </h3>
        <p
          class="text-foreground/40 text-sm md:text-base leading-relaxed"
          style="margin-left: 4px;"
        >
          não é só uma festa. é aquele momento que vc fecha o olho e o som tá
          passando pelo corpo inteiro. é isso que a gente quer criar.
        </p>
      </div>
      <div
        class="md:col-span-4 md:col-start-8 transform md:translate-y-16 md:rotate-0.5"
      >
        <h3
          class="font-display text-3xl md:text-4xl font-bold mb-2 text-desync-ember"
        >
          raízes em joão pessoa
        </h3>
        <p
          class="text-foreground/40 text-sm md:text-base leading-relaxed"
          style="margin-left: 3px;"
        >
          a cena underground aqui tá crescendo e a gente tá no meio disso.
          trazendo o som que faz sentido pra quem sente. com o cuidado aos
          detalhes e a qualidade que tanto amamos.
        </p>
      </div>
      <div
        class="md:col-span-5 md:col-start-3 transform md:translate-y-10 md:-rotate-0.5"
      >
        <h3
          class="font-display text-3xl md:text-4xl font-bold mb-2 text-desync-crimson"
        >
          sem fórmula
        </h3>
        <p
          class="text-foreground/40 text-sm md:text-base leading-relaxed"
          style="margin-left: 7px;"
        >
          techno, dub, experimental, drum n bass – a gente não fica preso em
          gênero. o que importa é a energia, o resto a gente resolve na hora.
        </p>
      </div>
    </div>
  </div>
</section>

<!-- Party Series Section - Asymmetric -->
<section id="parties" class="relative py-32 overflow-hidden">
  <div
    class="absolute inset-0 bg-linear-to-br from-desync-ember/5 to-transparent"
    style="transform: skewY(-2deg);"
  ></div>
  <!-- Organic branches - left -->
  <svg
    class="absolute left-0 top-1/3 w-28 h-56 opacity-30"
    viewBox="0 0 100 200"
  >
    <path
      d="M 15 0 Q 35 60, 20 120 T 30 200"
      stroke="#2a3a28"
      stroke-width="3"
      fill="none"
      opacity="0.8"
    />
    <path
      d="M 15 0 Q 10 70, 25 130 T 15 200"
      stroke="#2a3a28"
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
      stroke="#b32e6b"
      stroke-width="3"
      fill="none"
      opacity="0.8"
    />
    <path
      d="M 85 0 Q 90 70, 75 130 T 85 200"
      stroke="#b32e6b"
      stroke-width="2"
      fill="none"
      opacity="0.6"
    />
  </svg>

  <div class="relative px-6 md:px-12 max-w-7xl mx-auto z-10">
    <!-- Deep - Left Heavy -->
    <div class="mb-32 md:mb-48 transform md:-translate-x-12">
      <div class="inline-block border-l-4 border-desync-ember pl-8 md:pl-12">
        <h3
          class="font-display font-bold mb-3 text-desync-ember"
          style="font-size: clamp(3rem, 10vw, 6rem); letter-spacing: -0.03em; line-height: 0.9;"
        >
          deep
        </h3>
        <p
          class="text-foreground/30 text-xs tracking-widest lowercase mb-3"
          style="margin-left: 2px;"
        >
          experimental · hypnotic techno · dub techno
        </p>
        <p
          class="text-foreground/40 text-sm md:text-base leading-relaxed max-w-md"
          style="margin-left: 3px;"
        >
          aquele tipo de som que vc não escuta, vc sente. fecha o olho e deixa o
          grave te levar. sem pressa, sem destino.
        </p>
      </div>
    </div>

    <!-- Jungle - Right Heavy -->
    <div class="text-left md:text-right transform md:translate-x-12">
      <div
        class="inline-block border-l-4 md:border-l-0 md:border-r-4 border-desync-crimson pl-8 md:pl-0 md:pr-12"
      >
        <h3
          class="font-display font-bold mb-3 text-desync-crimson"
          style="font-size: clamp(3rem, 10vw, 6rem); letter-spacing: -0.03em; line-height: 0.9;"
        >
          jungle
        </h3>
        <p
          class="text-foreground/30 text-xs tracking-widest lowercase mb-3"
          style="margin-right: 2px;"
        >
          drum & bass · uk garage
        </p>
        <p
          class="text-foreground/40 text-sm md:text-base leading-relaxed max-w-md md:ml-auto"
          style=""
        >
          o break cai e teu corpo já sabe o que fazer. é instinto, é caos
          organizado. não tem como ficar parado.
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
    class="absolute top-0 right-0 w-1/3 h-full bg-desync-crimson/5"
    style="transform: skewX(-12deg) translateX(20%);"
  ></div>
  <!-- Organic branches - left -->
  <svg
    class="absolute left-0 bottom-20 w-32 h-64 opacity-30"
    viewBox="0 0 100 200"
  >
    <path
      d="M 10 0 Q 30 50, 15 100 T 25 200"
      stroke="#3a2a20"
      stroke-width="3"
      fill="none"
      opacity="0.8"
    />
    <path
      d="M 10 0 Q 5 60, 20 120 T 10 200"
      stroke="#3a2a20"
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
      stroke="#b85a1e"
      stroke-width="3"
      fill="none"
      opacity="0.8"
    />
    <path
      d="M 90 0 Q 95 60, 80 120 T 90 200"
      stroke="#b85a1e"
      stroke-width="2"
      fill="none"
      opacity="0.6"
    />
  </svg>

  <div class="max-w-7xl mx-auto relative z-10">
    <div class="transform md:-rotate-1">
      <h2
        class="font-display font-bold mb-6 gradient-text"
        style="font-size: clamp(3rem, 12vw, 8rem); letter-spacing: -0.04em;"
      >
        eventos
      </h2>
      <p
        class="text-foreground/40 text-sm md:text-base leading-relaxed max-w-lg mb-10"
        style="margin-left: 5px;"
      >
        a gente faz evento quando faz sentido, não por calendário. quando
        acontece, vocês podem acompanhar pelo Shotgun e Resident Advisor.
      </p>
      <div class="flex flex-wrap gap-4" style="margin-left: 5px;">
        <a
          href="https://shotgun.live/en/venues/desync-collective"
          target="_blank"
          rel="noopener noreferrer"
          class="btn-primary inline-block transform hover:rotate-1 transition-transform"
        >
          shotgun
        </a>
        <a
          href="https://ra.co"
          target="_blank"
          rel="noopener noreferrer"
          class="btn-secondary inline-block transform hover:-rotate-1 transition-transform"
        >
          resident advisor
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
    class="absolute inset-0 bg-linear-to-tr from-background via-desync-smoke/5 to-background"
  ></div>
  <!-- Organic branches - left -->
  <svg
    class="absolute left-0 top-1/4 w-36 h-72 opacity-30"
    viewBox="0 0 100 200"
  >
    <path
      d="M 10 0 Q 30 50, 15 100 T 25 200"
      stroke="#b32e6b"
      stroke-width="3"
      fill="none"
      opacity="0.8"
    />
    <path
      d="M 10 0 Q 5 60, 20 120 T 10 200"
      stroke="#b32e6b"
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
      stroke="#2a3a28"
      stroke-width="3"
      fill="none"
      opacity="0.8"
    />
    <path
      d="M 90 0 Q 95 60, 80 120 T 90 200"
      stroke="#2a3a28"
      stroke-width="2"
      fill="none"
      opacity="0.6"
    />
  </svg>

  <div class="relative max-w-7xl mx-auto z-10">
    <h2
      class="font-display font-bold mb-8 gradient-text text-right transform rotate-1"
      style="font-size: clamp(3.5rem, 14vw, 8rem); letter-spacing: -0.05em; margin-right: -3px;"
    >
      mixes
    </h2>

    <div class="max-w-lg ml-auto text-right transform md:rotate-0.5">
      <p
        class="text-foreground/40 text-sm md:text-base leading-relaxed mb-10"
        style="margin-right: 5px;"
      >
        sets gravados, sessões ao vivo, o que a gente tá ouvindo, o que a gente
        tá fazendo. tudo para lá, no SoundCloud.
      </p>
      <p
        class="text-foreground/20 text-xs leading-relaxed mb-8"
        style="margin-right: 5px;"
      >
        (a gente finge que vai fazer uma rádio mas nada confirmado ainda)
      </p>
      <a
        href="https://soundcloud.com"
        target="_blank"
        rel="noopener noreferrer"
        class="btn-primary inline-block transform hover:-rotate-1 transition-transform"
        style="margin-right: 5px;"
      >
        soundcloud
      </a>
    </div>
  </div>
</section>
