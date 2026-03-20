# desync.art

website for desync collective. techno & dnb music from joão pessoa, pb.

## stack

- svelte 5 + sveltekit (static adapter)
- tailwind css 4
- three.js + threlte (webgl shaders)
- gsap (scroll animations)

## dev

```sh
bun install
bun run dev
```

## build

```sh
bun run build
```

output goes to `build/`. serve it with any static file server (caddy, nginx, etc).

## checks

```sh
bun run check   # svelte-check
bun run lint    # prettier + eslint
```

these run automatically on pre-commit via lefthook.

## deploy

pushes to `main` trigger a github actions workflow that checks, builds, and deploys to the vps via ssh.
