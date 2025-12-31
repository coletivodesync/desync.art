import Lenis from 'lenis';

export function initSmoothScroll() {
	const lenis = new Lenis({
		duration: 0.9,
		easing: (t) => Math.min(1, 1.001 - Math.pow(2, -10 * t)),
		orientation: 'vertical',
		smoothWheel: true,
		wheelMultiplier: 1,
		touchMultiplier: 2
	});

	function raf(time: number) {
		lenis.raf(time);
		requestAnimationFrame(raf);
	}

	requestAnimationFrame(raf);

	return lenis;
}
