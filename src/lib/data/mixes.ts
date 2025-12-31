// Placeholder data structure for SoundCloud mixes
//
// INTEGRATION OPTIONS:
//
// 1. Manual Embeds (Easiest):
//    - Get SoundCloud embed code from each track
//    - Add to the mix cards below
//    Example: <iframe width="100%" height="166" scrolling="no" frameborder="no" allow="autoplay" src="https://w.soundcloud.com/player/?url=..."></iframe>
//
// 2. SoundCloud API (Automatic):
//    - Register app at https://soundcloud.com/you/apps
//    - Get API credentials
//    - Fetch latest tracks from your account
//    - Requires backend endpoint to proxy requests (CORS)
//
// 3. SoundCloud Widget API:
//    - Use SoundCloud's JavaScript Widget API
//    - More interactive player controls
//    - Doc: https://developers.soundcloud.com/docs/api/html5-widget

export interface Mix {
	id: string;
	title: string;
	artist: string;
	date: string;
	soundcloudUrl: string;
	embedUrl?: string;
	artwork?: string;
}

// Placeholder mixes - replace with real data
export const mixes: Mix[] = [
	{
		id: '1',
		title: 'Deep Session 001',
		artist: 'Artist Name',
		date: '2025-01',
		soundcloudUrl: 'https://soundcloud.com/desync-collective/mix-001',
		embedUrl: '', // Add SoundCloud embed URL here
		artwork: '' // Add artwork URL or leave empty for gradient
	},
	{
		id: '2',
		title: 'Breakbeat Nights 001',
		artist: 'Artist Name',
		date: '2024-12',
		soundcloudUrl: 'https://soundcloud.com/desync-collective/mix-002',
		embedUrl: '',
		artwork: ''
	}
];

// Function to fetch latest mix from SoundCloud API (example)
// Note: Requires SoundCloud API credentials and backend proxy
export async function fetchLatestMix() {
	// const response = await fetch('/api/soundcloud/latest');
	// const data = await response.json();
	// return data;

	// For now, return placeholder
	return mixes[0];
}
