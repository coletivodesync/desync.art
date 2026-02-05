import Lenis from 'lenis';

export function initSmoothScroll() {
	const lenis = new Lenis({
		duration: 0.3,
		easing: (t) => t, // Linear for immediate response
		orientation: 'vertical',
		smoothWheel: false, // Disable smooth wheel for snappier feel
		wheelMultiplier: 1.5,
		touchMultiplier: 2.5,
		syncTouch: true
	});

	function raf(time: number) {
		lenis.raf(time);
		requestAnimationFrame(raf);
	}

	requestAnimationFrame(raf);

	return lenis;
}
