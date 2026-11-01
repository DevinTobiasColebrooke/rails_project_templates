# Design System: Retro Synthwave / Neon 80s

Use this design system as the complete visual language for this project. It is
one self-consistent "look": a 19-token color contract, typography, radii/border
treatment, component patterns, and motion language. Implement the UI against
these tokens — do not invent colors, shadows, or type styles.

- **Slug:** `synthwave`
- **Mode:** native dark theme (light counterpart included)
- **Vibe:** Cruise the neon grid at midnight — magenta, cyan, purple glow, sunset gradients, and chrome trim.
- **Best for:** Earnings dashboard after dark and launch/flash moments that deserve spectacle.
- **Adjectives:** electric, nostalgic, theatrical
- **Signature detail:** Chrome-gradient text on primary headings plus the sunset gradient and perspective-grid horizon in empty states and marketing surfaces.
- **Motion:** Cinematic and slow-glow: fade in with blur(8px)→blur(0), scale 1.02→1 over 350ms; neon glows pulse on hover.

## Source of truth

This is a personal, local design-system library (private, not published).

- Repo on disk: `~/dev/design_systems` (private GitHub mirror: https://github.com/DevinTobiasColebrooke/design_systems)
- This system's folder: `systems/synthwave/`
- Machine-readable spec (tokens, fonts, schemas): `systems/synthwave/system.json`
- Drop-in Tailwind v4 theme file: `systems/synthwave/tailwind.css`
- Full component showcase: `systems/synthwave/showcase.html` (open in a browser)

If you have filesystem access, read those files. If you don't, everything you
need is inline below.

## 1. The 19-token contract

Every value below is authoritative. Tokens map 1:1 to CSS custom properties
(`bg-canvas` style) and to Tailwind `brand-*` utilities
(`bg-brand-canvas`, `text-brand-action`, ...). Use tokens everywhere; never use a raw hex
outside this block.

| Token | Native (dark) | Light mode | Usage |
|---|---|---|---|
| `--bg-canvas` | `#12051f` | `#f3e8fb` | Deepest background layer |
| `--bg-surface` | `#1d0b33` | `#ffffff` | Cards, Sidebars, Panes |
| `--bg-surface-elevated` | `#2a1250` | `#e8dcf5` | Dropdowns, hovered states |
| `--border-subtle` | `#3a1e66` | `#d9c9ef` | Very light separation |
| `--border-default` | `#532a8f` | `#b99adf` | Standard card/form borders |
| `--border-focus` | `#ff2bd6` | `#d624b8` | Focus states |
| `--text-primary` | `#fdf2ff` | `#2a0a44` | High contrast title/text |
| `--text-secondary` | `#cfa8f0` | `#5a3a7a` | Standard body paragraph |
| `--text-muted` | `#8d63b8` | `#7d6196` | Descriptions, helper text, dates |
| `--color-action` | `#ff2bd6` | `#d624b8` | Primary action |
| `--color-action-hover` | `#e21dbb` | `#ba1c9f` | Action hover |
| `--color-earnings` | `#ffd319` | `#9a7400` | Earnings, Revenue, Profit |
| `--color-earnings-hover` | `#e6bc00` | `#806000` | Earnings hover |
| `--color-automation` | `#3ce0ff` | `#0a9fd6` | Playwright, AI, Terminal accents |
| `--color-alert` | `#ff9f1c` | `#b45309` | Warnings, pending states |
| `--color-danger` | `#ff3b5c` | `#e0286e` | Error, failed status, deletes |
| `--color-action-glow` | `rgba(255, 43, 214, 0.35)` | `rgba(214, 36, 184, 0.22)` | Halo behind action icons |
| `--color-earnings-glow` | `rgba(255, 211, 25, 0.30)` | `rgba(154, 116, 0, 0.16)` | Halo behind earnings icons |
| `--color-automation-glow` | `rgba(60, 224, 255, 0.30)` | `rgba(10, 159, 214, 0.18)` | Halo behind automation icons |

### Tailwind CSS v4 setup

```css
@import "tailwindcss";

:root {
  --bg-canvas: #12051f;
  --bg-surface: #1d0b33;
  --bg-surface-elevated: #2a1250;
  --border-subtle: #3a1e66;
  --border-default: #532a8f;
  --border-focus: #ff2bd6;
  --text-primary: #fdf2ff;
  --text-secondary: #cfa8f0;
  --text-muted: #8d63b8;
  --color-action: #ff2bd6;
  --color-action-hover: #e21dbb;
  --color-earnings: #ffd319;
  --color-earnings-hover: #e6bc00;
  --color-automation: #3ce0ff;
  --color-alert: #ff9f1c;
  --color-danger: #ff3b5c;
  --color-action-glow: rgba(255, 43, 214, 0.35);
  --color-earnings-glow: rgba(255, 211, 25, 0.30);
  --color-automation-glow: rgba(60, 224, 255, 0.30);
  --action-label: #ffffff; /* readable text color on --color-action fills */
}

[data-theme="light"] {
  --bg-canvas: #f3e8fb;
  --bg-surface: #ffffff;
  --bg-surface-elevated: #e8dcf5;
  --border-subtle: #d9c9ef;
  --border-default: #b99adf;
  --border-focus: #d624b8;
  --text-primary: #2a0a44;
  --text-secondary: #5a3a7a;
  --text-muted: #7d6196;
  --color-action: #d624b8;
  --color-action-hover: #ba1c9f;
  --color-earnings: #9a7400;
  --color-earnings-hover: #806000;
  --color-automation: #0a9fd6;
  --color-alert: #b45309;
  --color-danger: #e0286e;
  --color-action-glow: rgba(214, 36, 184, 0.22);
  --color-earnings-glow: rgba(154, 116, 0, 0.16);
  --color-automation-glow: rgba(10, 159, 214, 0.18);
  --action-label: #ffffff;
}

@theme {
  --font-display: "Audiowide", "Orbitron", sans-serif;
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

Equivalent guide: **the full drop-in file is `~/dev/design_systems/systems/synthwave/tailwind.css`** — copy it to
`app/assets/tailwind/design_system.css` and `@import` it from `application.css`.

## 2. Color schemas (optional accent swaps)

These override accents on top of either mode palette. Apply as a class/attribute
that re-declares the listed tokens (everything else stays from the mode palette).

### `cyan-horizon` — Cyan Horizon

Cyan-led with violet automation; use dark ink labels on cyan.

| Token | Value |
|---|---|
| `--color-action` | `#0a9fd6` |
| `--color-action-hover` | `#0887b5` |
| `--color-earnings` | `#9a7400` |
| `--color-earnings-hover` | `#806000` |
| `--color-automation` | `#8a5cd6` |
| `--color-alert` | `#b45309` |
| `--color-danger` | `#e0286e` |
| `--border-focus` | `#0a9fd6` |
| `--color-action-glow` | `rgba(10, 159, 214, 0.20)` |
| `--color-earnings-glow` | `rgba(154, 116, 0, 0.16)` |
| `--color-automation-glow` | `rgba(138, 92, 214, 0.18)` |
### `violet-static` — Violet Static

Violet-led with magenta and cyan accents; use dark ink labels.

| Token | Value |
|---|---|
| `--color-action` | `#8a2be2` |
| `--color-action-hover` | `#7a1fce` |
| `--color-earnings` | `#c99900` |
| `--color-earnings-hover` | `#a87f00` |
| `--color-automation` | `#0a9fd6` |
| `--color-alert` | `#b45309` |
| `--color-danger` | `#e0286e` |
| `--border-focus` | `#8a2be2` |
| `--color-action-glow` | `rgba(138, 43, 226, 0.22)` |
| `--color-earnings-glow` | `rgba(201, 153, 0, 0.16)` |
| `--color-automation-glow` | `rgba(10, 159, 214, 0.18)` |
## 3. Typography

- **Display** (headings, KPIs, big numbers): `"Audiowide", "Orbitron", sans-serif`
- **Sans** (body, labels, UI): `"Rajdhani", "Exo 2", system-ui, sans-serif`
- **Mono** (timestamps, IDs, code, logs): `"Share Tech Mono", "IBM Plex Mono", ui-monospace, monospace`
- Load the families with the project's normal Google Fonts `<link>` (weights 500-800 for display/sans).

Hard rules:

- Every number (earnings, rates, counts, dates, timers) uses `tabular-nums`.
- Headings/eyebrows use tight tracking; micro-labels are uppercase `text-[10px] tracking-wider`.
- Body text at `text-sm`/`text-xs` for dense operational screens.

## 4. Radii, borders & signature treatment

- Card signature: `border: 1px solid; border-radius: 12px; border-top: 2px solid; box-shadow: 0 0 18px var(--color-action-glow), 0 0 28px var(--color-action-glow);`
- Canvas/texture signature: `background-image: linear-gradient(90deg, #ff2bd6, #ffd319);`
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
5. Motion: Cinematic and slow-glow: fade in with blur(8px)→blur(0), scale 1.02→1 over 350ms; neon glows pulse on hover.. Respect `prefers-reduced-motion`.
6. Touch targets ≥ 44px on mobile; inline form errors with `aria-live="polite"`.
7. Dark/light: `data-theme="light"` on `<html>` flips to the counterpart palette.

## 7. Full source spec (component patterns, motion, snippet)

### PROPOSAL-05 — Retro Synthwave / Neon 80s

- **slug**: `synthwave`
- **Vibe**: Cruise the neon grid at midnight — magenta, cyan, purple glow, sunset gradients, and chrome trim.
- **Best for**: Earnings dashboard after dark and launch/flash moments that deserve spectacle. Adjectives: electric, nostalgic, theatrical.
- **Palette** (dark theme, `is_dark: true`):

| Token | Value | Usage |
|---|---|---|
| `--bg-canvas` | `#12051f` | Deep violet-black canvas |
| `--bg-surface` | `#1d0b33` | Panel fill |
| `--bg-surface-elevated` | `#2a1250` | Raised panels, modals |
| `--border-subtle` | `#3a1e66` | Subtle neon hairlines |
| `--border-default` | `#532a8f` | Standard neon borders |
| `--border-focus` | `#ff2bd6` | Hot-magenta focus outline |
| `--text-primary` | `#fdf2ff` | High-contrast headings |
| `--text-secondary` | `#cfa8f0` | Body text |
| `--text-muted` | `#8d63b8` | Captions, helper text |
| `--color-action` | `#ff2bd6` | Hot-magenta primary action |
| `--color-action-hover` | `#e21dbb` | Action hover (deeper magenta) |
| `--color-earnings` | `#ffd319` | Sunset-yellow earnings |
| `--color-earnings-hover` | `#e6bc00` | Earnings hover (deeper gold) |
| `--color-automation` | `#3ce0ff` | Neon-cyan automation accents |
| `--color-alert` | `#ff9f1c` | Hot-orange warnings |
| `--color-danger` | `#ff3b5c` | Neon-red destructive states |
| `--color-action-glow` | `rgba(255, 43, 214, 0.35)` | Strong neon aura behind action icons |
| `--color-earnings-glow` | `rgba(255, 211, 25, 0.30)` | Strong neon aura behind earnings icons |
| `--color-automation-glow` | `rgba(60, 224, 255, 0.30)` | Strong neon aura behind automation icons |

- **Typography**: Display: `"Audiowide", "Orbitron", sans-serif` for KPI numerals and big headings — squared, futuristic, slightly wide. Sans: `"Rajdhani", "Exo 2", system-ui, sans-serif` at 500-700 with `letter-spacing: 0.02em`; uppercase micro-labels at 0.08em. Mono: `"Share Tech Mono", "IBM Plex Mono", ui-monospace, monospace` for logs and IDs. Numerals `tabular-nums`.
- **Radii & Borders**: Rounded-but-glowy: cards 12px, buttons pill or 8px. Borders are 1-2px neon with a matching outer glow (`box-shadow: 0 0 12px`). Card tops get a 2px bright "sunset line" in magenta or cyan.
- **Component Patterns**:
  - **Buttons**: Neon fill + 2px brighter border + outer glow; near-black text (`#12051f`) for contrast. Hover intensifies the glow and raises it. Secondary = transparent fill, neon border, subtle glow. Focus = 2px `--border-focus` plus glow ring.
  - **Cards**: Dark surfaces with a 1px neon border and soft outer glow; top edge carries the 2px sunset line. Empty states and headers may layer a perspective-grid motif.
  - **Badges/Status**: Neon-outlined pills with a glowing dot; publishing = pulsing magenta dot with glow; published = cyan glow. All badges read as "lit" elements.
  - **Tables**: Header row runs a sunset gradient strip (yellow to magenta) with dark text; zebra rows very subtle; row hover = left 3px neon bar. Numbers glow slightly at high values.
  - **Forms/Inputs**: Dark fields, 1px neon border; focus = border brightens + soft glow. Labels in Rajdhani uppercase.
  - **Loading**: A horizontal "synth scanner" line sweeping across a dark track, or three neon dots pulsing with glow in sequence.
  - **Signature detail**: Chrome-gradient text on primary headings plus the sunset gradient + perspective grid horizon used in empty states and the login/marketing surfaces — pure 80s.
- **Motion & Animation**: Cinematic and slow-glow: elements fade in with `opacity 0 -> 1` plus `filter: blur(8px) -> blur(0)` and scale 1.02 to 1, 350ms. Neon glows pulse on hover. No hard snaps.
- **Signature Preview Snippet**:

```html
<!-- Synthwave earnings tile: neon border, glow, chrome label -->
<div class="syn-card">
  <span class="syn-chrome">TODAY'S EARNINGS</span>
  <strong class="syn-kpi">$412.80</strong>
  <span class="syn-grid"></span>
</div>
```

## 8. Acceptance checklist

- [ ] No raw hex outside the token block; all brand colors resolve from tokens.
- [ ] All numeric values use `tabular-nums`.
- [ ] Every interactive element has a visible focus state using `--border-focus`.
- [ ] Status badges use the fixed status colors + text label.
- [ ] Both modes render correctly (`data-theme` toggle) and meet AA contrast.
- [ ] Card/button treatment matches the signature: border: 1px solid; border-radius: 12px; border-top: 2px solid; box-shadow: 0 0 18px var(--color-action-glow), 0 0 28px var(--color-action-glow);
