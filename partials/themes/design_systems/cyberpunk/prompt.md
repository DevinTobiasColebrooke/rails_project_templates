# Design System: Cyberpunk Neo-Tokyo

Use this design system as the complete visual language for this project. It is
one self-consistent "look": a 19-token color contract, typography, radii/border
treatment, component patterns, and motion language. Implement the UI against
these tokens — do not invent colors, shadows, or type styles.

- **Slug:** `cyberpunk`
- **Mode:** native dark theme (light counterpart included)
- **Vibe:** Holographic neon city at night — deep black-navy panels with electric magenta, cyan, and yellow, glitch accents, and hologram corners.
- **Best for:** Posting Studio dashboard and real-time publish feed — automation that feels like a cyber deck.
- **Adjectives:** electric, futuristic, dense
- **Signature detail:** The glitch text effect — headings carry a 1px red/cyan RGB-split text-shadow — plus the clipped holo corner. Unmistakably Neo-Tokyo.
- **Motion:** Glitchy and fast: 80-150ms with occasional two-frame horizontal displacement on entry; Turbo Stream inserts glitch-in (translateX 2px -> -2px -> 0).

## Source of truth

This is a personal, local design-system library (private, not published).

- Repo on disk: `~/dev/design_systems` (private GitHub mirror: https://github.com/DevinTobiasColebrooke/design_systems)
- This system's folder: `systems/cyberpunk/`
- Machine-readable spec (tokens, fonts, schemas): `systems/cyberpunk/system.json`
- Drop-in Tailwind v4 theme file: `systems/cyberpunk/tailwind.css`
- Full component showcase: `systems/cyberpunk/showcase.html` (open in a browser)

If you have filesystem access, read those files. If you don't, everything you
need is inline below.

## 1. The 19-token contract

Every value below is authoritative. Tokens map 1:1 to CSS custom properties
(`bg-canvas` style) and to Tailwind `brand-*` utilities
(`bg-brand-canvas`, `text-brand-action`, ...). Use tokens everywhere; never use a raw hex
outside this block.

| Token | Native (dark) | Light mode | Usage |
|---|---|---|---|
| `--bg-canvas` | `#060a14` | `#eef2fb` | Deepest background layer |
| `--bg-surface` | `#0c1220` | `#ffffff` | Cards, Sidebars, Panes |
| `--bg-surface-elevated` | `#141d33` | `#e0e7f5` | Dropdowns, hovered states |
| `--border-subtle` | `#1d2a45` | `#ccd8ee` | Very light separation |
| `--border-default` | `#2b3d63` | `#a3b5d9` | Standard card/form borders |
| `--border-focus` | `#00f0ff` | `#0092b8` | Focus states |
| `--text-primary` | `#eef4ff` | `#0b1020` | High contrast title/text |
| `--text-secondary` | `#b7c3e0` | `#38405e` | Standard body paragraph |
| `--text-muted` | `#6f7ea3` | `#66708f` | Descriptions, helper text, dates |
| `--color-action` | `#00f0ff` | `#0092b8` | Primary action |
| `--color-action-hover` | `#00c8d6` | `#007a99` | Action hover |
| `--color-earnings` | `#ffe600` | `#b89e00` | Earnings, Revenue, Profit |
| `--color-earnings-hover` | `#e6cf00` | `#9c8600` | Earnings hover |
| `--color-automation` | `#ff2bd6` | `#c71fa8` | Playwright, AI, Terminal accents |
| `--color-alert` | `#ffb000` | `#b45309` | Warnings, pending states |
| `--color-danger` | `#ff3b5c` | `#d42a54` | Error, failed status, deletes |
| `--color-action-glow` | `rgba(0, 240, 255, 0.25)` | `rgba(0, 146, 184, 0.20)` | Halo behind action icons |
| `--color-earnings-glow` | `rgba(255, 230, 0, 0.20)` | `rgba(184, 158, 0, 0.16)` | Halo behind earnings icons |
| `--color-automation-glow` | `rgba(255, 43, 214, 0.25)` | `rgba(199, 31, 168, 0.20)` | Halo behind automation icons |

### Tailwind CSS v4 setup

```css
@import "tailwindcss";

:root {
  --bg-canvas: #060a14;
  --bg-surface: #0c1220;
  --bg-surface-elevated: #141d33;
  --border-subtle: #1d2a45;
  --border-default: #2b3d63;
  --border-focus: #00f0ff;
  --text-primary: #eef4ff;
  --text-secondary: #b7c3e0;
  --text-muted: #6f7ea3;
  --color-action: #00f0ff;
  --color-action-hover: #00c8d6;
  --color-earnings: #ffe600;
  --color-earnings-hover: #e6cf00;
  --color-automation: #ff2bd6;
  --color-alert: #ffb000;
  --color-danger: #ff3b5c;
  --color-action-glow: rgba(0, 240, 255, 0.25);
  --color-earnings-glow: rgba(255, 230, 0, 0.20);
  --color-automation-glow: rgba(255, 43, 214, 0.25);
  --action-label: #0d0d12; /* readable text color on --color-action fills */
}

[data-theme="light"] {
  --bg-canvas: #eef2fb;
  --bg-surface: #ffffff;
  --bg-surface-elevated: #e0e7f5;
  --border-subtle: #ccd8ee;
  --border-default: #a3b5d9;
  --border-focus: #0092b8;
  --text-primary: #0b1020;
  --text-secondary: #38405e;
  --text-muted: #66708f;
  --color-action: #0092b8;
  --color-action-hover: #007a99;
  --color-earnings: #b89e00;
  --color-earnings-hover: #9c8600;
  --color-automation: #c71fa8;
  --color-alert: #b45309;
  --color-danger: #d42a54;
  --color-action-glow: rgba(0, 146, 184, 0.20);
  --color-earnings-glow: rgba(184, 158, 0, 0.16);
  --color-automation-glow: rgba(199, 31, 168, 0.20);
  --action-label: #0d0d12;
}

@theme {
  --font-display: "Orbitron", "Rajdhani", sans-serif;
  --font-sans: "Rajdhani", "Exo 2", system-ui, sans-serif;
  --font-mono: "Share Tech Mono", "IBM Plex Mono", ui-monospace, monospace;

  --color-brand-canvas: var(--bg-canvas);
  --color-brand-surface: var(--bg-surface);
  --color-brand-surface-elevated: var(--bg-surface-elevated);
  --color-brand-border-subtle: var(--border-subtle);
  --color-brand-border-default: var(--border-default);
  --color-brand-border-focus: var(--border-focus);
  --color-brand-text-primary: var(--text-primary);
  --color-brand-text-secondary: var(--text-secondary);
  --color-brand-text-muted: var(--text-muted);
  --color-brand-action: var(--color-action);
  --color-brand-action-hover: var(--color-action-hover);
  --color-brand-earnings: var(--color-earnings);
  --color-brand-earnings-hover: var(--color-earnings-hover);
  --color-brand-automation: var(--color-automation);
  --color-brand-alert: var(--color-alert);
  --color-brand-danger: var(--color-danger);
  --color-brand-action-glow: var(--color-action-glow);
  --color-brand-earnings-glow: var(--color-earnings-glow);
  --color-brand-automation-glow: var(--color-automation-glow);
}
```

Equivalent guide: **the full drop-in file is `~/dev/design_systems/systems/cyberpunk/tailwind.css`** — copy it to
`app/assets/tailwind/design_system.css` and `@import` it from `application.css`.

## 2. Color schemas (optional accent swaps)

These override accents on top of either mode palette. Apply as a class/attribute
that re-declares the listed tokens (everything else stays from the mode palette).

### `magenta-hacker` — Magenta Hacker

Magenta-led with cyan secondary; use white bold labels on magenta.

| Token | Value |
|---|---|
| `--color-action` | `#c71fa8` |
| `--color-action-hover` | `#ac1890` |
| `--color-earnings` | `#b89e00` |
| `--color-earnings-hover` | `#9c8600` |
| `--color-automation` | `#0092b8` |
| `--color-alert` | `#b45309` |
| `--color-danger` | `#d42a54` |
| `--border-focus` | `#c71fa8` |
| `--color-action-glow` | `rgba(199, 31, 168, 0.22)` |
| `--color-earnings-glow` | `rgba(184, 158, 0, 0.16)` |
| `--color-automation-glow` | `rgba(0, 146, 184, 0.20)` |
### `gold-corpo` — Gold Corpo

Gold-led corpo with emerald earnings; use dark ink labels on gold.

| Token | Value |
|---|---|
| `--color-action` | `#b8860b` |
| `--color-action-hover` | `#9a7209` |
| `--color-earnings` | `#1f8f6b` |
| `--color-earnings-hover` | `#197659` |
| `--color-automation` | `#0092b8` |
| `--color-alert` | `#b45309` |
| `--color-danger` | `#d42a54` |
| `--border-focus` | `#b8860b` |
| `--color-action-glow` | `rgba(184, 134, 11, 0.18)` |
| `--color-earnings-glow` | `rgba(31, 143, 107, 0.16)` |
| `--color-automation-glow` | `rgba(0, 146, 184, 0.20)` |
## 3. Typography

- **Display** (headings, KPIs, big numbers): `"Orbitron", "Rajdhani", sans-serif`
- **Sans** (body, labels, UI): `"Rajdhani", "Exo 2", system-ui, sans-serif`
- **Mono** (timestamps, IDs, code, logs): `"Share Tech Mono", "IBM Plex Mono", ui-monospace, monospace`
- Load the families with the project's normal Google Fonts `<link>` (weights 500-800 for display/sans).

Hard rules:

- Every number (earnings, rates, counts, dates, timers) uses `tabular-nums`.
- Headings/eyebrows use tight tracking; micro-labels are uppercase `text-[10px] tracking-wider`.
- Body text at `text-sm`/`text-xs` for dense operational screens.

## 4. Radii, borders & signature treatment

- Card signature: `border: 1px solid; border-radius: 4px; box-shadow: 0 0 14px var(--color-action-glow);`
- Canvas/texture signature: `background-image: repeating-linear-gradient(0deg, rgba(0, 240, 255, 0.05) 0 1px, transparent 1px 3px);`
- Border roles: `--border-subtle` = hairlines/dividers; `--border-default` = card/form borders;
  `--border-focus` = focus rings and active states.
- Radii scale: `sm` 0.375rem (buttons/inputs) · `md` 0.5rem (cards/small panes) · `lg` 0.75rem (big panels/modals).

## 5. Intent color rules (never swap these)

- `action` → primary buttons, links, active nav, focus. Label text on action fills: `#0d0d12` (or `var(--action-label)`).
- `earnings` → revenue, profit, payouts, positive deltas.
- `automation` → AI, Playwright, terminal, background jobs.
- `alert` → warnings, pending/publishing states.
- `danger` → errors, failed status, destructive actions.
- **Status colors are fixed** across every design system (meaning never changes):
  draft `#6b7280` · scheduled `#3b82f6` · publishing `#f59e0b` · published `#10b981` · failed `#ef4444`.
  Status is never color alone — always color + label (+ icon).

## 6. Implementation rules (Rails 8 + Tailwind v4 + Hotwire)

1. Use only the tokens above; no arbitrary hex, no default Tailwind palette colors for brand surfaces.
2. Surfaces: canvas = page background, surface = cards/sidebars, surface-elevated = dropdowns/hover.
3. Contrast: text pairs are WCAG AA — `text-primary` on canvas/surface, `text-secondary` for body,
   `text-muted` for helper text. Keep them on their intended backgrounds.
4. Focus: `2px` `--border-focus` ring/outline on every interactive element; never remove outlines without a replacement.
5. Motion: Glitchy and fast: 80-150ms with occasional two-frame horizontal displacement on entry; Turbo Stream inserts glitch-in (translateX 2px -> -2px -> 0).. Respect `prefers-reduced-motion`.
6. Touch targets ≥ 44px on mobile; inline form errors with `aria-live="polite"`.
7. Dark/light: `data-theme="light"` on `<html>` flips to the counterpart palette.

## 7. Full source spec (component patterns, motion, snippet)

### PROPOSAL-09 — Cyberpunk Neo-Tokyo

- **slug**: `cyberpunk`
- **Vibe**: Holographic neon city at night — deep black-navy panels with electric magenta, cyan, and yellow, glitch accents, and hologram corners.
- **Best for**: Posting Studio dashboard and real-time publish feed — automation that feels like a cyber deck. Adjectives: electric, futuristic, dense.
- **Palette** (dark theme, `is_dark: true`):

| Token | Value | Usage |
|---|---|---|
| `--bg-canvas` | `#060a14` | Deep black-navy city canvas |
| `--bg-surface` | `#0c1220` | Holo panel fill |
| `--bg-surface-elevated` | `#141d33` | Raised holo panels, modals |
| `--border-subtle` | `#1d2a45` | Fine circuit hairlines |
| `--border-default` | `#2b3d63` | Standard neon borders |
| `--border-focus` | `#00f0ff` | Electric-cyan focus outline |
| `--text-primary` | `#eef4ff` | High-contrast holo text |
| `--text-secondary` | `#b7c3e0` | Body text |
| `--text-muted` | `#6f7ea3` | Captions, timestamps, IDs |
| `--color-action` | `#00f0ff` | Electric-cyan primary action |
| `--color-action-hover` | `#00c8d6` | Action hover (deeper cyan) |
| `--color-earnings` | `#ffe600` | Holographic-yellow earnings |
| `--color-earnings-hover` | `#e6cf00` | Earnings hover (deeper yellow) |
| `--color-automation` | `#ff2bd6` | Magenta automation accents |
| `--color-alert` | `#ffb000` | Amber warnings |
| `--color-danger` | `#ff3b5c` | Neon-red failed states |
| `--color-action-glow` | `rgba(0, 240, 255, 0.25)` | Cyan aura behind action icons |
| `--color-earnings-glow` | `rgba(255, 230, 0, 0.20)` | Yellow aura behind earnings icons |
| `--color-automation-glow` | `rgba(255, 43, 214, 0.25)` | Magenta aura behind automation icons |

- **Typography**: Display: `"Orbitron", "Rajdhani", sans-serif` at 700-900 — squared, techno, slightly wide; used for KPI numerals and section IDs. Sans: `"Rajdhani", "Exo 2", system-ui, sans-serif` at 500-700 with `letter-spacing: 0.02em`; uppercase micro-labels at 0.08em. Mono: `"Share Tech Mono", "IBM Plex Mono", ui-monospace, monospace` for log lines and hex-style IDs. Numerals `tabular-nums`.
- **Radii & Borders**: Sharp hologram panels: 4px radius on panels, 2px on chips, pill buttons. Borders are 1px neon in `--border-default`; focus is a 2px cyan outline with a 2px gap. Signature panel corner: the top-left corner is clipped (via `clip-path`) like a cut holo-glass corner.
- **Component Patterns**:
  - **Buttons**: Dark fill with 1px neon border and glowing label; primary = cyan fill with near-black text (`#060a14`), hover runs a diagonal scan sweep. Secondary = transparent with magenta border. Focus = 2px `--border-focus` outline.
  - **Cards**: Holo-glass panels (dark translucent fill) with a 1px neon border, clipped corner, and a top-left `ACC-####` holo ID tag. Headers carry a thin cyan scan line. No soft shadows — glow only.
  - **Badges/Status**: Square chips with neon border and a square dot; publishing = blinking magenta square with RGB-split edge; published = cyan; failed = red.
  - **Tables**: Full 1px grid with neon column rules; header row mono uppercase; row hover = glitch-style double underline (red/cyan offset).
  - **Forms/Inputs**: Dark fields with a neon bottom rule; focus = cyan border + glow. Labels are uppercase Rajdhani.
  - **Loading**: A horizontal scanline sweeping the panel, or glitch "chunks" that pop in; determinate = segmented bar filling with RGB-split segments.
  - **Signature detail**: The glitch text effect — headings carry a 1px red/cyan RGB-split `text-shadow` — plus the clipped holo corner. Unmistakably Neo-Tokyo.
- **Motion & Animation**: Glitchy and fast: 80-150ms with occasional two-frame horizontal displacement on entry; Turbo Stream inserts "glitch-in" (translateX 2px -> -2px -> 0). Hover scan sweeps; nothing floats.
- **Signature Preview Snippet**:

```html
<!-- Cyber holo KPI: corner-clipped panel, neon border, glitch label -->
<div class="cyber-panel">
  <span class="cyber-id">ACC-8821 // EARNINGS</span>
  <strong class="cyber-kpi">$12,480</strong>
  <span class="cyber-delta">+14.2% SYNCED</span>
  <button class="cyber-btn">Deploy Post</button>
</div>
```

## 8. Acceptance checklist

- [ ] No raw hex outside the token block; all brand colors resolve from tokens.
- [ ] All numeric values use `tabular-nums`.
- [ ] Every interactive element has a visible focus state using `--border-focus`.
- [ ] Status badges use the fixed status colors + text label.
- [ ] Both modes render correctly (`data-theme` toggle) and meet AA contrast.
- [ ] Card/button treatment matches the signature: border: 1px solid; border-radius: 4px; box-shadow: 0 0 14px var(--color-action-glow);
