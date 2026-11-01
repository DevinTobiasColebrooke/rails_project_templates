# Design System: 1-Bit Dither

Use this design system as the complete visual language for this project. It is
one self-consistent "look": a 19-token color contract, typography, radii/border
treatment, component patterns, and motion language. Implement the UI against
these tokens — do not invent colors, shadows, or type styles.

- **Slug:** `1bit-dither`
- **Mode:** native light theme (dark counterpart included)
- **Vibe:** A Macintosh-classic or Game Boy camera screen — pure black and pure white, with every shade faked by Bayer-dither dot patterns. No grays exist.
- **Best for:** Power-user tables, agency publishing logs, and any surface that should look like 1991 portable hardware.
- **Adjectives:** austere, mechanical, print-like
- **Signature detail:** Bayer-dither patterns standing in for every gray — squint and you get shades; look close and there are only two colors.
- **Motion:** Stepped and frame-based: 80-120ms, steps(4) easing, no sub-pixel movement — things jump in 2px increments like a low-DPI screen. Blinking is a hard on/off at 1-2Hz.

## Source of truth

This is a personal, local design-system library (private, not published).

- Repo on disk: `~/dev/design_systems` (private GitHub mirror: https://github.com/DevinTobiasColebrooke/design_systems)
- This system's folder: `systems/1bit-dither/`
- Machine-readable spec (tokens, fonts, schemas): `systems/1bit-dither/system.json`
- Drop-in Tailwind v4 theme file: `systems/1bit-dither/tailwind.css`
- Full component showcase: `systems/1bit-dither/showcase.html` (open in a browser)

If you have filesystem access, read those files. If you don't, everything you
need is inline below.

## 1. The 19-token contract

Every value below is authoritative. Tokens map 1:1 to CSS custom properties
(`bg-canvas` style) and to Tailwind `brand-*` utilities
(`bg-brand-canvas`, `text-brand-action`, ...). Use tokens everywhere; never use a raw hex
outside this block.

| Token | Native (light) | Dark mode | Usage |
|---|---|---|---|
| `--bg-canvas` | `#f4f1ea` | `#0f380f` | Deepest background layer |
| `--bg-surface` | `#ffffff` | `#204820` | Cards, Sidebars, Panes |
| `--bg-surface-elevated` | `#f4f1ea` | `#306230` | Dropdowns, hovered states |
| `--border-subtle` | `#d8d4c8` | `#2c542c` | Very light separation |
| `--border-default` | `#000000` | `#8bac0f` | Standard card/form borders |
| `--border-focus` | `#000000` | `#9bbc0f` | Focus states |
| `--text-primary` | `#000000` | `#cfe89a` | High contrast title/text |
| `--text-secondary` | `#000000` | `#93b04a` | Standard body paragraph |
| `--text-muted` | `#000000` | `#5c7a2e` | Descriptions, helper text, dates |
| `--color-action` | `#000000` | `#9bbc0f` | Primary action |
| `--color-action-hover` | `#000000` | `#8bac0f` | Action hover |
| `--color-earnings` | `#000000` | `#cde86a` | Earnings, Revenue, Profit |
| `--color-earnings-hover` | `#000000` | `#b4d44e` | Earnings hover |
| `--color-automation` | `#000000` | `#7a9c4a` | Playwright, AI, Terminal accents |
| `--color-alert` | `#000000` | `#cde86a` | Warnings, pending states |
| `--color-danger` | `#000000` | `#c86a4a` | Error, failed status, deletes |
| `--color-action-glow` | `rgba(0, 0, 0, 0.06)` | `rgba(155, 188, 15, 0.16)` | Halo behind action icons |
| `--color-earnings-glow` | `rgba(0, 0, 0, 0.06)` | `rgba(205, 232, 106, 0.14)` | Halo behind earnings icons |
| `--color-automation-glow` | `rgba(0, 0, 0, 0.06)` | `rgba(122, 156, 74, 0.14)` | Halo behind automation icons |

### Tailwind CSS v4 setup

```css
@import "tailwindcss";

:root {
  --bg-canvas: #f4f1ea;
  --bg-surface: #ffffff;
  --bg-surface-elevated: #f4f1ea;
  --border-subtle: #d8d4c8;
  --border-default: #000000;
  --border-focus: #000000;
  --text-primary: #000000;
  --text-secondary: #000000;
  --text-muted: #000000;
  --color-action: #000000;
  --color-action-hover: #000000;
  --color-earnings: #000000;
  --color-earnings-hover: #000000;
  --color-automation: #000000;
  --color-alert: #000000;
  --color-danger: #000000;
  --color-action-glow: rgba(0, 0, 0, 0.06);
  --color-earnings-glow: rgba(0, 0, 0, 0.06);
  --color-automation-glow: rgba(0, 0, 0, 0.06);
  --action-label: #ffffff; /* readable text color on --color-action fills */
}

[data-theme="dark"] {
  --bg-canvas: #0f380f;
  --bg-surface: #204820;
  --bg-surface-elevated: #306230;
  --border-subtle: #2c542c;
  --border-default: #8bac0f;
  --border-focus: #9bbc0f;
  --text-primary: #cfe89a;
  --text-secondary: #93b04a;
  --text-muted: #5c7a2e;
  --color-action: #9bbc0f;
  --color-action-hover: #8bac0f;
  --color-earnings: #cde86a;
  --color-earnings-hover: #b4d44e;
  --color-automation: #7a9c4a;
  --color-alert: #cde86a;
  --color-danger: #c86a4a;
  --color-action-glow: rgba(155, 188, 15, 0.16);
  --color-earnings-glow: rgba(205, 232, 106, 0.14);
  --color-automation-glow: rgba(122, 156, 74, 0.14);
  --action-label: #0d0d12;
}

@theme {
  --font-display: "Silkscreen", "Pixelify Sans", monospace;
  --font-sans: "IBM Plex Mono", ui-monospace, monospace;
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

Equivalent guide: **the full drop-in file is `~/dev/design_systems/systems/1bit-dither/tailwind.css`** — copy it to
`app/assets/tailwind/design_system.css` and `@import` it from `application.css`.

## 2. Color schemas (optional accent swaps)

These override accents on top of either mode palette. Apply as a class/attribute
that re-declares the listed tokens (everything else stays from the mode palette).

### `gameboy-pea` — Gameboy Pea

Deep pea-soup accents; use white bold labels on the deep green.

| Token | Value |
|---|---|
| `--color-action` | `#4a6624` |
| `--color-action-hover` | `#3c541c` |
| `--color-earnings` | `#6b5900` |
| `--color-earnings-hover` | `#574800` |
| `--color-automation` | `#2e5c46` |
| `--color-alert` | `#7a5c00` |
| `--color-danger` | `#8a2e1c` |
| `--border-focus` | `#4a6624` |
| `--color-action-glow` | `rgba(74, 102, 36, 0.12)` |
| `--color-earnings-glow` | `rgba(107, 89, 0, 0.12)` |
| `--color-automation-glow` | `rgba(46, 92, 70, 0.12)` |
### `newsprint` — Newsprint

Ink-on-newsprint with sepia and slate accents; pure print contrast.

| Token | Value |
|---|---|
| `--color-action` | `#000000` |
| `--color-action-hover` | `#333333` |
| `--color-earnings` | `#5c4a1c` |
| `--color-earnings-hover` | `#4a3c16` |
| `--color-automation` | `#1c3a5c` |
| `--color-alert` | `#7a4a10` |
| `--color-danger` | `#7a1c14` |
| `--border-focus` | `#000000` |
| `--color-action-glow` | `rgba(0, 0, 0, 0.06)` |
| `--color-earnings-glow` | `rgba(92, 74, 28, 0.08)` |
| `--color-automation-glow` | `rgba(28, 58, 92, 0.08)` |
## 3. Typography

- **Display** (headings, KPIs, big numbers): `"Silkscreen", "Pixelify Sans", monospace`
- **Sans** (body, labels, UI): `"IBM Plex Mono", ui-monospace, monospace`
- **Mono** (timestamps, IDs, code, logs): `"IBM Plex Mono", ui-monospace, monospace`
- Load the families with the project's normal Google Fonts `<link>` (weights 500-800 for display/sans).

Hard rules:

- Every number (earnings, rates, counts, dates, timers) uses `tabular-nums`.
- Headings/eyebrows use tight tracking; micro-labels are uppercase `text-[10px] tracking-wider`.
- Body text at `text-sm`/`text-xs` for dense operational screens.

## 4. Radii, borders & signature treatment

- Card signature: `border: 2px solid #000000; border-radius: 0; box-shadow: 4px 4px 0 0 #000000;`
- Canvas/texture signature: `background-image: repeating-conic-gradient(#000000 0% 25%, transparent 0% 50%); background-size: 4px 4px;`
- Border roles: `--border-subtle` = hairlines/dividers; `--border-default` = card/form borders;
  `--border-focus` = focus rings and active states.
- Radii scale: `sm` 0.375rem (buttons/inputs) · `md` 0.5rem (cards/small panes) · `lg` 0.75rem (big panels/modals).

## 5. Intent color rules (never swap these)

- `action` → primary buttons, links, active nav, focus. Label text on action fills: `#ffffff` (or `var(--action-label)`).
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
5. Motion: Stepped and frame-based: 80-120ms, steps(4) easing, no sub-pixel movement — things jump in 2px increments like a low-DPI screen. Blinking is a hard on/off at 1-2Hz.. Respect `prefers-reduced-motion`.
6. Touch targets ≥ 44px on mobile; inline form errors with `aria-live="polite"`.
7. Dark/light: `data-theme="dark"` on `<html>` flips to the counterpart palette.

## 7. Full source spec (component patterns, motion, snippet)

### PROPOSAL-20 — 1-Bit Dither

- **slug**: `1bit-dither`
- **Vibe**: A Macintosh-classic or Game Boy camera screen — pure black and pure white, with every shade faked by Bayer-dither dot patterns. No grays exist.
- **Best for**: Power-user tables, agency publishing logs, and any surface that should look like 1991 portable hardware. Adjectives: austere, mechanical, print-like.
- **Palette** (light theme, `is_dark: false`):

| Token | Value | Usage |
|---|---|---|
| `--bg-canvas` | `#f4f1ea` | Paper-white LCD backdrop |
| `--bg-surface` | `#ffffff` | Pure white panel |
| `--bg-surface-elevated` | `#f4f1ea` | Dither-pattern panel (50% checker) |
| `--border-subtle` | `#d8d4c8` | Hairline (rendered as 1px dotted) |
| `--border-default` | `#000000` | Pure black borders |
| `--border-focus` | `#000000` | Black focus outline (double-strike) |
| `--text-primary` | `#000000` | Pure black text |
| `--text-secondary` | `#000000` | Black text at 70% dither (pattern) |
| `--text-muted` | `#000000` | Black text at 30% dither (pattern) |
| `--color-action` | `#000000` | Black primary fills (white text) |
| `--color-action-hover` | `#000000` | Hover = inverted (black↔white) |
| `--color-earnings` | `#000000` | Black + 50% dither highlight |
| `--color-earnings-hover` | `#000000` | Hover = solid black |
| `--color-automation` | `#000000` | Black + 25% dither accents |
| `--color-alert` | `#000000` | Black, blinking 1Hz |
| `--color-danger` | `#000000` | Black, inverted field |
| `--color-action-glow` | `rgba(0, 0, 0, 0.06)` | 6% checker tint (only "glow") |
| `--color-earnings-glow` | `rgba(0, 0, 0, 0.06)` | 6% checker tint |
| `--color-automation-glow` | `rgba(0, 0, 0, 0.06)` | 6% checker tint |

- **Typography**: Bitmap-flavored system: Display: `"Silkscreen", "Pixelify Sans", monospace` for headings. Body: `"IBM Plex Mono", ui-monospace, monospace`. Uppercase labels, `letter-spacing: 0.06em`. No font-weight games — hierarchy via dither density and size only. KPIs `tabular-nums`.
- **Radii & Borders**: Zero radius anywhere. Borders are 1-3px solid black; the 2px "double border" (outer 2px + inner 1px with 2px gap) marks selected/active surfaces, like classic Mac chrome.
- **Component Patterns**:
  - **Buttons**: Rectangular, 2px black border. Primary = solid black with white text; hover inverts to outline style. Active = shifted 2px down-right with the shadow collapsing (classic Mac press). Focus = 2px black outline with 2px gap.
  - **Cards**: White panels with 2px black border and a 4px hard offset black shadow; "elevated" surfaces use a 50% Bayer checker pattern instead of a lighter gray.
  - **Badges/Status**: Square chips: filled black = active, 50% dither = pending, outline only = done. Status dot is a 4x4px black square. Blinking = attention.
  - **Tables**: 1px black grid, header row uses the 25% dither pattern as its background. Row hover = full-row dither wash. Numbers right-aligned mono.
  - **Forms/Inputs**: White field, 2px black border, block cursor. Focus = double-strike border (3px). Disabled = 50% dither text.
  - **Loading**: A marching-ants border (animated dashed outline) or a classic watch-cursor alternation. Determinate = black bar filling in 8px "pixel" steps.
  - **Signature detail**: Bayer-dither patterns standing in for every gray — squint and you get shades; look close and there are only two colors.
- **Motion & Animation**: Stepped and frame-based: 80-120ms, `steps(4)` easing, no sub-pixel movement — things jump in 2px increments like a low-DPI screen. Blinking is a hard on/off at 1-2Hz.
- **Signature Preview Snippet**:

```html
<!-- 1-bit KPI: dithered emphasis, hard border, offset shadow -->
<div class="bit-card">
  <span class="bit-label">EARNINGS/30D</span>
  <strong class="bit-kpi">$12,480</strong>
  <span class="bit-delta bit-dither-50">+14.2%</span>
</div>
```

## 8. Acceptance checklist

- [ ] No raw hex outside the token block; all brand colors resolve from tokens.
- [ ] All numeric values use `tabular-nums`.
- [ ] Every interactive element has a visible focus state using `--border-focus`.
- [ ] Status badges use the fixed status colors + text label.
- [ ] Both modes render correctly (`data-theme` toggle) and meet AA contrast.
- [ ] Card/button treatment matches the signature: border: 2px solid #000000; border-radius: 0; box-shadow: 4px 4px 0 0 #000000;
