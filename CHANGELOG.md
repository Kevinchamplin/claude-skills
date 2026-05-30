# Changelog

All notable changes to the Claude Skills library are recorded here.
Format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [Unreleased] — 2026-05-30

Integrated a modern web & UI design research guide into the two design skills:
a token-driven, OKLCH-first, accessibility-grounded foundation aimed at producing
distinctive work instead of the generic "AI vibe-coded" look.

### Added

- **frontend-design — new `references/` library.** The skill previously shipped as
  a single `SKILL.md`; it now carries four load-on-demand references:
  - `design-tokens.md` — OKLCH color foundation (perceptual uniformity, no hue
    shift, P3) with a per-step lightness ramp, a ready-to-drop Tailwind v4 `@theme`
    block, three-tier token architecture, spacing/type/radii scales, and dark-mode
    elevation by lightness (plus the Material-2 overlay ladder as a relative guide).
  - `premium-rubric.md` — a 12-point pre-ship premium filter plus the named
    anti-AI-slop FAIL tells (Tech Bro Gradient, identical centered hero, heavy
    glassmorphism, default-Lucide-everywhere) and the PASS counter-rule.
  - `motion-library.md` — ease-curve catalog with exact cubic-béziers,
    durations-by-intent, the asymmetric enter/exit rule, spatial continuity via
    `transform-origin`, the Doherty threshold, and a `prefers-reduced-motion` block.
  - `imagery-and-icons.md` — AVIF→WebP→JPEG `<picture>` cascade, `srcset`/`sizes`
    byte budgeting, CLS prevention, hero `preload`/`fetchpriority`, an icon-library
    comparison with `currentColor`/ARIA wiring, and OKLCH-interpolated art direction.
- **ux-designer — `references/27-navigation-and-footers.md`.** Slim sticky-header
  patterns (transparent→solid, shrink/hide-on-scroll, mega-menu a11y) and fat-footer
  strategy, each with an accessibility review bar.

### Changed

- **ux-designer references deepened** from the same research:
  - `03-accessibility.md` — exact WCAG 2.2 contrast ratios, non-text contrast
    (1.4.11, 3:1), the WebAIM Million 2026 + EU Accessibility Act evidence, and an
    APCA / WCAG 3 note.
  - `04-visual-design.md` — OKLCH rationale, color harmonies, neutrals-first +
    temperature, the 60-30-10 rule, modular type scales + pairings, the 8-point
    grid, and container queries.
  - `07-forms-and-inputs.md` — cited research attached to existing guidance (NN/g
    placeholder-as-label findings, Baymard optional-field 32%, radio-vs-dropdown).
  - `11-design-systems.md` — three-tier token architecture
    (primitive → semantic → component) and W3C Design Tokens naming conventions.
  - `23-modern-ui-patterns-2026.md` — the anti-AI-sameness thesis and the
    Linear / Stripe / Vercel / Mercury "high contrast + whitespace + one disciplined
    accent + sharp type" formula, with the caution that dark-mode-plus-one-neon is
    itself now a cliché.
- Both `SKILL.md` index files updated to point at the new and expanded references.
