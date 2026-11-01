# Design System: Night Vision

Use this design system as the complete visual language for this project. It is
one self-consistent "look": a 19-token color contract, typography, radii/border
treatment, component patterns, and motion language. Implement the UI against
these tokens — do not invent colors, shadows, or type styles.

- **Slug:** `night-vision`
- **Mode:** native dark theme (light counterpart included)
- **Vibe:** Gen-3 goggles in a moonless field — everything is luminous green-on-black with intensifier noise, a subtle bloom on hot objects, and a reticle in the corner.
- **Best for:** Automation cockpit and Playwright run logs — the machine sees in the dark.
- **Adjectives:** tactical, luminous, surveillance
- **Signature detail:** The vignette + grain + bloom triad — the UI is a view through optics, with hot things literally glowing brighter.
- **Motion:** Instant with grain: 100ms snaps, entries gain brightness (filter: brightness 0.6→1) over 150ms; occasional 1-frame flicker (intensifier). No easing curves you can see.

## Source of truth

This is a personal, local design-system library (private, not published).

- Repo on disk: `~/dev/design_systems` (private GitHub mirror: https://github.com/DevinTobiasColebrooke/design_systems)
- This system's folder: `systems/night-vision/`
- Machine-readable spec (tokens, fonts, schemas): `systems/night-vision/system.json`
- Drop-in Tailwind v4 theme file: `systems/night-vision/tailwind.css`
- Full component showcase: `systems/night-vision/showcase.html` (open in a browser)

If you have filesystem access, read those files. If you don't, everything you
need is inline below.

## 1. The 19-token contract

Every value below is authoritative. Tokens map 1:1 to CSS custom properties
(`bg-canvas` style) and to Tailwind `brand-*` utilities
(`bg-brand-canvas`, `text-brand-action`, ...). Use tokens everywhere; never use a raw hex
outside this block.

| Token | Native (dark) | Light mode | Usage |
|---|---|---|---|
| `--bg-canvas` | `#020603` | `#e9f2e9` | Deepest background layer |
| `--bg-surface` | `#061408` | `#f6fbf6` | Cards, Sidebars, Panes |
| `--bg-surface-elevated` | `#0a1f0d` | `#dcecdc` | Dropdowns, hovered states |
| `--border-subtle` | `#12351a` | `#c8dfc8` | Very light separation |
| `--border-default` | `#1e5229` | `#93bda1` | Standard card/form borders |
| `--border-focus` | `#7dff9a` | `#1f7a3c` | Focus states |
| `--text-primary` | `#aaffc0` | `#0a2814` | High contrast title/text |
| `--text-secondary` | `#6ed489` | `#2f5c3f` | Standard body paragraph |
| `--text-muted` | `#3c8a52` | `#5c8068` | Descriptions, helper text, dates |
| `--color-action` | `#59ff8a` | `#1f8a45` | Primary action |
| `--color-action-hover` | `#3fe572` | `#177238` | Action hover |
| `--color-earnings` | `#d8ff5c` | `#7a8f00` | Earnings, Revenue, Profit |
| `--color-earnings-hover` | `#bfe643` | `#637500` | Earnings hover |
| `--color-automation` | `#8ad8ff` | `#1f6e8c` | Playwright, AI, Terminal accents |
| `--color-alert` | `#ffd23c` | `#9a6d00` | Warnings, pending states |
| `--color-danger` | `#ff5c4a` | `#b83226` | Error, failed status, deletes |
| `--color-action-glow` | `rgba(89, 255, 138, 0.20)` | `rgba(31, 138, 69, 0.14)` | Halo behind action icons |
| `--color-earnings-glow` | `rgba(216, 255, 92, 0.18)` | `rgba(122, 143, 0, 0.12)` | Halo behind earnings icons |
| `--color-automation-glow` | `rgba(138, 216, 255, 0.16)` | `rgba(31, 110, 140, 0.12)` | Halo behind automation icons |

### Tailwind CSS v4 setup

```css
@import "tailwindcss";

:root {
  --bg-canvas: #020603;
  --bg-surface: #061408;
  --bg-surface-elevated: #0a1f0d;
  --border-subtle: #12351a;
  --border-default: #1e5229;
  --border-focus: #7dff9a;
  --text-primary: #aaffc0;
  --text-secondary: #6ed489;
  --text-muted: #3c8a52;
  --color-action: #59ff8a;
  --color-action-hover: #3fe572;
  --color-earnings: #d8ff5c;
  --color-earnings-hover: #bfe643;
  --color-automation: #8ad8ff;
  --color-alert: #ffd23c;
  --color-danger: #ff5c4a;
  --color-action-glow: rgba(89, 255, 138, 0.20);
  --color-earnings-glow: rgba(216, 255, 92, 0.18);
  --color-automation-glow: rgba(138, 216, 255, 0.16);
  --action-label: #0d0d12; /* readable text color on --color-action fills */
}

[data-theme="light"] {
  --bg-canvas: #e9f2e9;
  --bg-surface: #f6fbf6;
  --bg-surface-elevated: #dcecdc;
  --border-subtle: #c8dfc8;
  --border-default: #93bda1;
  --border-focus: #1f7a3c;
  --text-primary: #0a2814;
  --text-secondary: #2f5c3f;
  --text-muted: #5c8068;
  --color-action: #1f8a45;
  --color-action-hover: #177238;
  --color-earnings: #7a8f00;
  --color-earnings-hover: #637500;
  --color-automation: #1f6e8c;
  --color-alert: #9a6d00;
  --color-danger: #b83226;
  --color-action-glow: rgba(31, 138, 69, 0.14);
  --color-earnings-glow: rgba(122, 143, 0, 0.12);
  --color-automation-glow: rgba(31, 110, 140, 0.12);
  --action-label: #ffffff;
}

@theme {
  --font-display: "Chakra Petch", "Share Tech Mono", sans-serif;
  --font-sans: "Inter", system-ui, sans-serif;
  --font-mono: "Share Tech Mono", "IBM Plex Mono", monospace;

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

Equivalent guide: **the full drop-in file is `~/dev/design_systems/systems/night-vision/tailwind.css`** — copy it to
`app/assets/tailwind/design_system.css` and `@import` it from `application.css`.

## 2. Color schemas (optional accent swaps)

These override accents on top of either mode palette. Apply as a class/attribute
that re-declares the listed tokens (everything else stays from the mode palette).

### `white-hot` — White Hot

Thermal white-hot palette; use dark ink labels on the pale fill.

| Token | Value |
|---|---|
| `--color-action` | `#c8dcd0` |
| `--color-action-hover` | `#adc4b6` |
| `--color-earnings` | `#a89400` |
| `--color-earnings-hover` | `#8a7a00` |
| `--color-automation` | `#7d95a8` |
| `--color-alert` | `#9a6d00` |
| `--color-danger` | `#c04030` |
| `--border-focus` | `#c8dcd0` |
| `--color-action-glow` | `rgba(200, 220, 208, 0.20)` |
| `--color-earnings-glow` | `rgba(168, 148, 0, 0.12)` |
| `--color-automation-glow` | `rgba(125, 149, 168, 0.12)` |
### `phosphor-amber` — Phosphor Amber

Amber-intensifier tube with olive earnings; use dark ink labels on amber.

| Token | Value |
|---|---|
| `--color-action` | `#c98a2e` |
| `--color-action-hover` | `#a8701f` |
| `--color-earnings` | `#7a8f00` |
| `--color-earnings-hover` | `#637500` |
| `--color-automation` | `#1f6e8c` |
| `--color-alert` | `#b45309` |
| `--color-danger` | `#b83226` |
| `--border-focus` | `#c98a2e` |
| `--color-action-glow` | `rgba(201, 138, 46, 0.16)` |
| `--color-earnings-glow` | `rgba(122, 143, 0, 0.12)` |
| `--color-automation-glow` | `rgba(31, 110, 140, 0.12)` |
## 3. Typography

- **Display** (headings, KPIs, big numbers): `"Chakra Petch", "Share Tech Mono", sans-serif`
- **Sans** (body, labels, UI): `"Inter", system-ui, sans-serif`
- **Mono** (timestamps, IDs, code, logs): `"Share Tech Mono", "IBM Plex Mono", monospace`
- Load the families with the project's normal Google Fonts `<link>` (weights 500-800 for display/sans).

Hard rules:

- Every number (earnings, rates, counts, dates, timers) uses `tabular-nums`.
- Headings/eyebrows use tight tracking; micro-labels are uppercase `text-[10px] tracking-wider`.
- Body text at `text-sm`/`text-xs` for dense operational screens.

## 4. Radii, borders & signature treatment

- Card signature: `border: 1px solid var(--border-default); border-radius: 2px; box-shadow: inset 0 0 40px rgba(0, 0, 0, 0.65);`
- Canvas/texture signature: `background-image: radial-gradient(ellipse at center, transparent 55%, rgba(0, 0, 0, 0.55) 100%);`
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
5. Motion: Instant with grain: 100ms snaps, entries gain brightness (filter: brightness 0.6→1) over 150ms; occasional 1-frame flicker (intensifier). No easing curves you can see.. Respect `prefers-reduced-motion`.
6. Touch targets ≥ 44px on mobile; inline form errors with `aria-live="polite"`.
7. Dark/light: `data-theme="light"` on `<html>` flips to the counterpart palette.

## 7. Full source spec (component patterns, motion, snippet)

### PROPOSAL-19 — Night Vision

- **slug**: `night-vision`
- **Vibe**: Gen-3 goggles in a moonless field — everything is luminous green-on-black with intensifier noise, a subtle bloom on hot objects, and a reticle in the corner.
- **Best for**: Automation cockpit and Playwright run logs — the machine sees in the dark. Adjectives: tactical, luminous, surveillance.
- **Palette** (dark theme, `is_dark: true`):

| Token | Value | Usage |
|---|---|---|
| `--bg-canvas` | `#020603` | Tubes-off black with green cast |
| `--bg-surface` | `#061408` | Intensifier-lit panel fill |
| `--bg-surface-elevated` | `#0a1f0d` | Hot rows, popovers |
| `--border-subtle` | `#12351a` | Faint grid lines |
| `--border-default` | `#1e5229` | Standard borders |
| `--border-focus` | `#7dff9a` | Bright intensifier outline |
| `--text-primary` | `#aaffc0` | Bright luminous-green headings |
| `--text-secondary` | `#6ed489` | Body text |
| `--text-muted` | `#3c8a52` | Noise-floor dim text |
| `--color-action` | `#59ff8a` | Primary intensifier green |
| `--color-action-hover` | `#3fe572` | Action hover (deeper green) |
| `--color-earnings` | `#d8ff5c` | Hot-target yellow-green earnings |
| `--color-earnings-hover` | `#bfe643` | Earnings hover (deeper lime) |
| `--color-automation` | `#8ad8ff` | IR-illumina­tor cyan accents |
| `--color-alert` | `#ffd23c` | Hot amber warnings |
| `--color-danger` | `#ff5c4a` | Threat-red failed states |
| `--color-action-glow` | `rgba(89, 255, 138, 0.20)` | Bloom behind active markers |
| `--color-earnings-glow` | `rgba(216, 255, 92, 0.18)` | Hot bloom behind earnings |
| `--color-automation-glow` | `rgba(138, 216, 255, 0.16)` | IR bloom behind automation |

- **Typography**: Mono-first tactical readout. Display: `"Chakra Petch", "Share Tech Mono", sans-serif` at 600-700, uppercase. Body: `"Share Tech Mono", "IBM Plex Mono", monospace`. Labels carry bracket/coordinate framing like `[GRID 34N-118W]`. All numbers `tabular-nums`.
- **Radii & Borders**: Near-square — 2px radius max. 1px borders. The signature edge is the **goggle vignette**: the viewport corners stay dark (radial-gradient overlay), so panels feel seen through optics, not drawn.
- **Component Patterns**:
  - **Buttons**: Square, 1px green border, uppercase mono label. Primary = bright green fill, black text, mild bloom shadow; hover = brighter bloom. Focus = 1px `--border-focus` outline.
  - **Cards**: Dark panels with a corner reticle mark (small L-bracket in each corner, 1px). A faint animated noise/grain overlay sits above everything (2-3% opacity).
  - **Badges/Status**: Readout chips: `TRK` (running), `LOST` (failed), `HIT` (published) in intensifier colors; the hot state pulses its bloom slowly (2s).
  - **Tables**: Monospace grid with 1px rules; hot (positive) numbers get a bloom text-shadow; header row prefixed with `//` like a log stream.
  - **Forms/Inputs**: Flat fields, 1px borders, green caret; focus = bright green border + bloom. Helper text reads like a whisper: lowercase, dimmed.
  - **Loading**: A sweeping horizontal "refresh line" like an intensifier refresh, or a blinking reticle in the panel corner. Never a spinner.
  - **Signature detail**: The vignette + grain + bloom triad — the UI is a view through optics, with hot things literally glowing brighter.
- **Motion & Animation**: Instant with grain: 100ms snaps, entries gain brightness (filter: brightness 0.6 -> 1) over 150ms; occasional 1-frame flicker (intensifier). No easing curves you can see.
- **Signature Preview Snippet**:

```html
<!-- Night-vision run log: reticle corners, bloom, grain -->
<div class="nv-panel">
  <div class="nv-reticle"></div>
  <span class="nv-time">[23:41:07]</span>
  <span class="nv-tag nv-trk">TRK</span>
  <span class="nv-msg">playwright run #4421 · 3 clips hot</span>
</div>
```

## 8. Acceptance checklist

- [ ] No raw hex outside the token block; all brand colors resolve from tokens.
- [ ] All numeric values use `tabular-nums`.
- [ ] Every interactive element has a visible focus state using `--border-focus`.
- [ ] Status badges use the fixed status colors + text label.
- [ ] Both modes render correctly (`data-theme` toggle) and meet AA contrast.
- [ ] Card/button treatment matches the signature: border: 1px solid var(--border-default); border-radius: 2px; box-shadow: inset 0 0 40px rgba(0, 0, 0, 0.65);
