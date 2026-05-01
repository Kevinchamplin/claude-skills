---
name: frontend-design
description: Create distinctive, production-grade frontend interfaces with high design quality. Use this skill when the user asks to build web components, pages, or applications. Generates creative, polished code that avoids generic AI aesthetics.
---

This skill guides creation of distinctive, production-grade frontend interfaces that avoid generic "AI slop" aesthetics. Implement real working code with exceptional attention to aesthetic details and creative choices.

## Stack Awareness

Detect the project's stack and match the implementation approach. Read existing config files (`package.json`, `tailwind.config.*`, `globals.css`, Blade layouts) before writing anything.

### Next.js / App Router projects
- Server Components by default; `'use client'` only for state/interactivity
- If the project ships a custom CSS design system, USE IT — do not introduce Tailwind
- If the project ships Tailwind, USE IT — do not introduce a parallel custom system
- Prefer CSS-only animation with Intersection Observer over animation libraries
- Reuse existing design tokens (`--color-*`, `--space-*`, `--font-*`, `--ease-*`) instead of inventing new ones

### Laravel projects (Blade + Alpine / Livewire)
- Blade templates with component syntax (`<x-button>`, `<x-layout>`) and slots
- Tailwind CSS is the standard — don't bolt on custom CSS unless the project already does
- Alpine.js for client state; Livewire if present
- If the project uses Tailwind JIT, remember: new utility classes must appear in scanned files for the bundle to include them. Run the build after adding novel classes.

### Standalone pages (landing pages, tools, microsites)
- Plain HTML/CSS/JS, self-contained, no build step
- Maximum creative freedom — these are where bold aesthetic experiments shine

## Design Thinking

Before coding, understand the context and commit to a clear aesthetic direction:
- **Purpose**: What problem does this interface solve? Who uses it?
- **Tone**: Match the project's existing aesthetic, or if greenfield, pick a direction: brutally minimal, luxury/refined, editorial/magazine, retro-futuristic, brutalist/raw, art deco/geometric, industrial/utilitarian, etc.
- **Constraints**: Which stack? Server or client component? Existing design tokens?
- **Differentiation**: What makes this memorable? What's the one detail someone will notice?

**CRITICAL**: Choose a clear conceptual direction and execute it with precision. Bold maximalism and refined minimalism both work — the key is intentionality, not intensity.

Then implement working code that is:
- Production-grade and functional
- Visually striking and memorable
- Cohesive with a clear aesthetic point-of-view
- Meticulously refined in every detail

## Frontend Aesthetics Guidelines

Focus on:
- **Typography**: Choose fonts that serve the context. If the project has an established pairing, use it. Otherwise pick distinctive, characterful fonts — avoid generic defaults (Arial, Roboto, system fonts when not intentional). Pair a display font with a refined body font.
- **Color & Theme**: Commit to a cohesive palette. Use CSS variables for consistency. Dominant colors with sharp accents outperform timid, evenly-distributed palettes.
- **Motion**: CSS-only animations preferred. Focus on high-impact moments — one well-orchestrated page load with staggered reveals creates more delight than scattered micro-interactions. Use scroll-triggering and hover states that surprise. A solid default: `cubic-bezier(0.16, 1, 0.3, 1)` easing, 400ms duration.
- **Spatial Composition**: Unexpected layouts. Asymmetry. Overlap. Diagonal flow. Grid-breaking elements. Generous negative space OR controlled density.
- **Backgrounds & Visual Details**: Create atmosphere and depth. Apply gradient meshes, noise textures, geometric patterns, layered transparencies, dramatic shadows, decorative borders, and grain overlays where they serve the design.

### Anti-Patterns to Avoid
- Generic AI aesthetics: cookie-cutter layouts, predictable component patterns
- Cliched color schemes: lavender-on-white SaaS gradients applied without intent
- Animation libraries when CSS handles it fine
- Tailwind in projects that already have a custom design system
- Custom CSS in Laravel/Tailwind projects
- Adding new CSS variables when existing design tokens fit
- `'use client'` on components that don't need state/interactivity

## Implementation Notes

- Read the existing CSS/Blade/component code before writing new code — match conventions
- If the project has a `BRAND_GUIDE.md`, `DESIGN.md`, or similar, read it first
- Performance matters: self-hosted fonts, minimal JS, CSS-only animation where possible
- Reveal/scroll-triggered classes commonly use `opacity: 0` until a `.visible` class is added — never double up the trigger class on both wrapper and child

Remember: Claude is capable of extraordinary creative work. Don't hold back — show what can truly be created when thinking outside the box and committing fully to a distinctive vision. But always respect the project's established patterns.
