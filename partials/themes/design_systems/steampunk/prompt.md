# Design System: Steampunk Brass

Use this design system as the complete visual language for this project. It is
one self-consistent "look": a 19-token color contract, typography, radii/border
treatment, component patterns, and motion language. Implement the UI against
these tokens — do not invent colors, shadows, or type styles.

- **Slug:** `steampunk`
- **Mode:** native dark theme (light counterpart included)
- **Vibe:** Victorian industrial machinery — dark leather and charcoal with brass, copper, rivets, and gauge dials.
- **Best for:** Automation cockpit and Playwright run logs — publishing pipelines as steam-driven machinery.
- **Adjectives:** mechanical, warm, hand-built
- **Signature detail:** Brass rivets + copper/brass borders + gear and gauge dial motifs — machinery you can almost hear.
- **Motion:** Heavy and mechanical — 200-300ms with one small overshoot "clunk"; gears rotate slowly on hover.

## Source of truth

This is a personal, local design-system library (private, not published).

- Repo on disk: `~/dev/design_systems` (private GitHub mirror: https://github.com/DevinTobiasColebrooke/design_systems)
- This system's folder: `systems/steampunk/`
- Machine-readable spec (tokens, fonts, schemas): `systems/steampunk/system.json`
- Drop-in Tailwind v4 theme file: `systems/steampunk/tailwind.css`
- Full component showcase: `systems/steampunk/showcase.html` (open in a browser)

If you have filesystem access, read those files. If you don't, everything you
need is inline below.

## 1. The 19-token contract

Every value below is authoritative. Tokens map 1:1 to CSS custom properties
(`bg-canvas` style) and to Tailwind `brand-*` utilities
(`bg-brand-canvas`, `text-brand-action`, ...). Use tokens everywhere; never use a raw hex
outside this block.

| Token | Native (dark) | Light mode | Usage |
|---|---|---|---|
| `--bg-canvas` | `#12100c` | `#ece3d0` | Deepest background layer |
| `--bg-surface` | `#1c1914` | `#f7f0e0` | Cards, Sidebars, Panes |
| `--bg-surface-elevated` | `#272219` | `#e5d9c0` | Dropdowns, hovered states |
| `--border-subtle` | `#332c20` | `#d4c6a8` | Very light separation |
| `--border-default` | `#4d4230` | `#b39a6e` | Standard card/form borders |
| `--border-focus` | `#d9a441` | `#a0711f` | Focus states |
| `--text-primary` | `#f2e9d8` | `#241d13` | High contrast title/text |
| `--text-secondary` | `#c9bda4` | `#4f4431` | Standard body paragraph |
| `--text-muted` | `#8a7f6b` | `#7a6d52` | Descriptions, helper text, dates |
| `--color-action` | `#c9812e` | `#9a6b23` | Primary action |
| `--color-action-hover` | `#b06f24` | `#825820` | Action hover |
| `--color-earnings` | `#d9a441` | `#a8802e` | Earnings, Revenue, Profit |
| `--color-earnings-hover` | `#c28c32` | `#8f6d25` | Earnings hover |
| `--color-automation` | `#7fb0a8` | `#5e8f86` | Playwright, AI, Terminal accents |
| `--color-alert` | `#e0a02f` | `#8f6b18` | Warnings, pending states |
| `--color-danger` | `#a4452c` | `#9a3f22` | Error, failed status, deletes |
| `--color-action-glow` | `rgba(201, 129, 46, 0.18)` | `rgba(154, 107, 35, 0.14)` | Halo behind action icons |
| `--color-earnings-glow` | `rgba(217, 164, 65, 0.16)` | `rgba(168, 128, 46, 0.12)` | Halo behind earnings icons |
| `--color-automation-glow` | `rgba(127, 176, 168, 0.14)` | `rgba(94, 143, 134, 0.12)` | Halo behind automation icons |

### Tailwind CSS v4 setup

```css
@import "tailwindcss";

:root {
  --bg-canvas: #12100c;
  --bg-surface: #1c1914;
  --bg-surface-elevated: #272219;
  --border-subtle: #332c20;
  --border-default: #4d4230;
  --border-focus: #d9a441;
  --text-primary: #f2e9d8;
  --text-secondary: #c9bda4;
  --text-muted: #8a7f6b;
  --color-action: #c9812e;
  --color-action-hover: #b06f24;
  --color-earnings: #d9a441;
  --color-earnings-hover: #c28c32;
  --color-automation: #7fb0a8;
  --color-alert: #e0a02f;
  --color-danger: #a4452c;
  --color-action-glow: rgba(201, 129, 46, 0.18);
  --color-earnings-glow: rgba(217, 164, 65, 0.16);
  --color-automation-glow: rgba(127, 176, 168, 0.14);
  --action-label: #0d0d12; /* readable text color on --color-action fills */
}

[data-theme="light"] {
  --bg-canvas: #ece3d0;
  --bg-surface: #f7f0e0;
  --bg-surface-elevated: #e5d9c0;
  --border-subtle: #d4c6a8;
  --border-default: #b39a6e;
  --border-focus: #a0711f;
  --text-primary: #241d13;
  --text-secondary: #4f4431;
  --text-muted: #7a6d52;
  --color-action: #9a6b23;
  --color-action-hover: #825820;
  --color-earnings: #a8802e;
  --color-earnings-hover: #8f6d25;
  --color-automation: #5e8f86;
  --color-alert: #8f6b18;
  --color-danger: #9a3f22;
  --color-action-glow: rgba(154, 107, 35, 0.14);
  --color-earnings-glow: rgba(168, 128, 46, 0.12);
  --color-automation-glow: rgba(94, 143, 134, 0.12);
  --action-label: #ffffff;
}

@theme {
  --font-display: "IM Fell English", "Marcellus", serif;
  --font-sans: "Spectral", Georgia, serif;
  --font-mono: "IBM Plex Mono", ui-monospace, monospace;

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

Equivalent guide: **the full drop-in file is `~/dev/design_systems/systems/steampunk/tailwind.css`** — copy it to
`app/assets/tailwind/design_system.css` and `@import` it from `application.css`.

## 2. Color schemas (optional accent swaps)

These override accents on top of either mode palette. Apply as a class/attribute
that re-declares the listed tokens (everything else stays from the mode palette).

### `copper-fire` — Copper Fire

Copper-led with amber; use white bold labels on copper.

| Token | Value |
|---|---|
| `--color-action` | `#b4502e` |
| `--color-action-hover` | `#9a4226` |
| `--color-earnings` | `#a8802e` |
| `--color-earnings-hover` | `#8f6d25` |
| `--color-automation` | `#5e8f86` |
| `--color-alert` | `#8f6b18` |
| `--color-danger` | `#9a3f22` |
| `--border-focus` | `#b4502e` |
| `--color-action-glow` | `rgba(180, 80, 46, 0.16)` |
| `--color-earnings-glow` | `rgba(168, 128, 46, 0.12)` |
| `--color-automation-glow` | `rgba(94, 143, 134, 0.12)` |
### `mercury-silver` — Mercury Silver

Silver-steel-led machinery; use white bold labels on steel.

| Token | Value |
|---|---|
| `--color-action` | `#7a8590` |
| `--color-action-hover` | `#68737e` |
| `--color-earnings` | `#a8802e` |
| `--color-earnings-hover` | `#8f6d25` |
| `--color-automation` | `#5e8f86` |
| `--color-alert` | `#8f6b18` |
| `--color-danger` | `#9a3f22` |
| `--border-focus` | `#7a8590` |
| `--color-action-glow` | `rgba(122, 133, 144, 0.14)` |
| `--color-earnings-glow` | `rgba(168, 128, 46, 0.12)` |
| `--color-automation-glow` | `rgba(94, 143, 134, 0.12)` |
## 3. Typography

- **Display** (headings, KPIs, big numbers): `"IM Fell English", "Marcellus", serif`
- **Sans** (body, labels, UI): `"Spectral", Georgia, serif`
- **Mono** (timestamps, IDs, code, logs): `"IBM Plex Mono", ui-monospace, monospace`
- Load the families with the project's normal Google Fonts `<link>` (weights 500-800 for display/sans).

Hard rules:

- Every number (earnings, rates, counts, dates, timers) uses `tabular-nums`.
- Headings/eyebrows use tight tracking; micro-labels are uppercase `text-[10px] tracking-wider`.
- Body text at `text-sm`/`text-xs` for dense operational screens.

## 4. Radii, borders & signature treatment

- Card signature: `border: 2px solid var(--border-default); border-radius: 8px; box-shadow: inset 0 0 0 1px rgba(201, 129, 46, 0.28);`
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
5. Motion: Heavy and mechanical — 200-300ms with one small overshoot "clunk"; gears rotate slowly on hover.. Respect `prefers-reduced-motion`.
6. Touch targets ≥ 44px on mobile; inline form errors with `aria-live="polite"`.
7. Dark/light: `data-theme="light"` on `<html>` flips to the counterpart palette.

## 7. Full source spec (component patterns, motion, snippet)

### PROPOSAL-12 — Steampunk Brass

- **slug**: `steampunk`
- **Vibe**: Victorian industrial machinery — dark leather and charcoal with brass, copper, rivets, and gauge dials.
- **Best for**: Automation cockpit and Playwright run logs — publishing pipelines as steam-driven machinery. Adjectives: mechanical, warm, hand-built.
- **Palette** (dark theme, `is_dark: true`):

| Token | Value | Usage |
|---|---|---|
| `--bg-canvas` | `#12100c` | Dark leather-charcoal canvas |
| `--bg-surface` | `#1c1914` | Panel fill |
| `--bg-surface-elevated` | `#272219` | Raised panels, modals |
| `--border-subtle` | `#332c20` | Fine seam lines |
| `--border-default` | `#4d4230` | Standard brass borders |
| `--border-focus` | `#d9a441` | Brass focus outline |
| `--text-primary` | `#f2e9d8` | Warm parchment headings |
| `--text-secondary` | `#c9bda4` | Body text |
| `--text-muted` | `#8a7f6b` | Captions, gauge labels |
| `--color-action` | `#c9812e` | Copper primary action |
| `--color-action-hover` | `#b06f24` | Action hover (deeper copper) |
| `--color-earnings` | `#d9a441` | Brass-gold earnings |
| `--color-earnings-hover` | `#c28c32` | Earnings hover (deeper brass) |
| `--color-automation` | `#7fb0a8` | Tarnished-teal gauge glass accents |
| `--color-alert` | `#e0a02f` | Amber warnings |
| `--color-danger` | `#a4452c` | Rust-red failed states |
| `--color-action-glow` | `rgba(201, 129, 46, 0.18)` | Copper tint behind action icons |
| `--color-earnings-glow` | `rgba(217, 164, 65, 0.16)` | Brass tint behind earnings icons |
| `--color-automation-glow` | `rgba(127, 176, 168, 0.14)` | Teal tint behind automation icons |

- **Typography**: Display: `"IM Fell English", "Marcellus", serif` — engraved Victorian serif for headings and nameplates. Sans/body: `"Spectral", Georgia, serif` at 400-600. Mono: `"IBM Plex Mono", ui-monospace, monospace` for gauge readouts, timestamps, and log lines. Small caps with `letter-spacing: 0.04em`; numerals `tabular-nums`.
- **Radii & Borders**: Rounded mechanical parts — 6-10px on cards, 8px on buttons. Borders are 2px brass (`--border-default`) with an engraved inner hairline. Rivet dots (2-3px brass circles) sit at card corners.
- **Component Patterns**:
  - **Buttons**: Brass-bordered with warm dark fill; primary = copper gradient fill with dark ink text (`#1c1914`); hover = brass glow. Secondary = transparent with 2px brass border. Focus = brass double outline. Small rivets flank the label on primary buttons.
  - **Cards**: Leather-dark panels with a 2px brass frame, engraved nameplate header bar, and rivets at the corners. Optional gauge dial motif in the header for status.
  - **Badges/Status**: Octagonal or oval brass-bezel chips with a glowing dot; publishing = rotating gear + pulsing amber; published = brass; failed = rust red.
  - **Tables**: Parchment-tinted rows on charcoal with thin brass rules; header row engraved-plate style (small caps, lighter). Row hover = 1px brass left rule.
  - **Forms/Inputs**: Engraved-line fields (dark fill, 1px brass border); focus = brass underline. Helper text in small caps.
  - **Loading**: A rotating gear (8-tooth, CSS-stepped) or a needle gauge sweeping; determinate = a dial gauge filling clockwise.
  - **Signature detail**: Brass rivets + copper/brass borders + gear and gauge dial motifs — machinery you can almost hear.
- **Motion & Animation**: Heavy and mechanical — 200-300ms with one small overshoot "clunk"; gears rotate slowly on hover; status toggles click. No springs, no glides.
- **Signature Preview Snippet**:

```html
<!-- Steampunk gauge KPI: brass frame, rivets, dial readout -->
<div class="steam-card">
  <span class="steam-plate">REVENUE / 30D</span>
  <strong class="steam-readout">$12,480</strong>
  <span class="steam-rivet steam-r1"></span>
  <span class="steam-rivet steam-r2"></span>
</div>
```

## 8. Acceptance checklist

- [ ] No raw hex outside the token block; all brand colors resolve from tokens.
- [ ] All numeric values use `tabular-nums`.
- [ ] Every interactive element has a visible focus state using `--border-focus`.
- [ ] Status badges use the fixed status colors + text label.
- [ ] Both modes render correctly (`data-theme` toggle) and meet AA contrast.
- [ ] Card/button treatment matches the signature: border: 2px solid var(--border-default); border-radius: 8px; box-shadow: inset 0 0 0 1px rgba(201, 129, 46, 0.28);
