# Design System: Bauhaus / Geometric Modern

Use this design system as the complete visual language for this project. It is
one self-consistent "look": a 19-token color contract, typography, radii/border
treatment, component patterns, and motion language. Implement the UI against
these tokens — do not invent colors, shadows, or type styles.

- **Slug:** `bauhaus`
- **Mode:** native light theme (dark counterpart included)
- **Vibe:** Primary color blocks, a strict grid, and Swiss typography — form follows function, boldly.
- **Best for:** Analytics dashboards and dense tables where structure is the aesthetic.
- **Adjectives:** rigorous, timeless, confident
- **Signature detail:** The primary-color geometric motif (red square, yellow circle, blue triangle) as section markers, plus heavy uppercase Swiss type.
- **Motion:** Crisp and instant — 80ms linear; Turbo Stream inserts use a geometric wipe (clip-path sweep from left) rather than fade.

## Source of truth

This is a personal, local design-system library (private, not published).

- Repo on disk: `~/dev/design_systems` (private GitHub mirror: https://github.com/DevinTobiasColebrooke/design_systems)
- This system's folder: `systems/bauhaus/`
- Machine-readable spec (tokens, fonts, schemas): `systems/bauhaus/system.json`
- Drop-in Tailwind v4 theme file: `systems/bauhaus/tailwind.css`
- Full component showcase: `systems/bauhaus/showcase.html` (open in a browser)

If you have filesystem access, read those files. If you don't, everything you
need is inline below.

## 1. The 19-token contract

Every value below is authoritative. Tokens map 1:1 to CSS custom properties
(`bg-canvas` style) and to Tailwind `brand-*` utilities
(`bg-brand-canvas`, `text-brand-action`, ...). Use tokens everywhere; never use a raw hex
outside this block.

| Token | Native (light) | Dark mode | Usage |
|---|---|---|---|
| `--bg-canvas` | `#f4f4f0` | `#111111` | Deepest background layer |
| `--bg-surface` | `#ffffff` | `#1a1a1a` | Cards, Sidebars, Panes |
| `--bg-surface-elevated` | `#ecebe4` | `#262626` | Dropdowns, hovered states |
| `--border-subtle` | `#dedcd2` | `#2e2e2e` | Very light separation |
| `--border-default` | `#b8b5a8` | `#4a4a4a` | Standard card/form borders |
| `--border-focus` | `#0033a0` | `#4d8cff` | Focus states |
| `--text-primary` | `#141414` | `#f5f5f0` | High contrast title/text |
| `--text-secondary` | `#44423c` | `#c7c7c0` | Standard body paragraph |
| `--text-muted` | `#6f6c62` | `#8f8f86` | Descriptions, helper text, dates |
| `--color-action` | `#e63225` | `#ef3d2f` | Primary action |
| `--color-action-hover` | `#c92a1e` | `#d23326` | Action hover |
| `--color-earnings` | `#9a7b00` | `#e0b400` | Earnings, Revenue, Profit |
| `--color-earnings-hover` | `#7f6600` | `#c7a100` | Earnings hover |
| `--color-automation` | `#0033a0` | `#4d8cff` | Playwright, AI, Terminal accents |
| `--color-alert` | `#d08a00` | `#f59e0b` | Warnings, pending states |
| `--color-danger` | `#a1121f` | `#e02d2d` | Error, failed status, deletes |
| `--color-action-glow` | `rgba(230, 50, 37, 0.12)` | `rgba(239, 61, 47, 0.16)` | Halo behind action icons |
| `--color-earnings-glow` | `rgba(154, 123, 0, 0.12)` | `rgba(224, 180, 0, 0.14)` | Halo behind earnings icons |
| `--color-automation-glow` | `rgba(0, 51, 160, 0.12)` | `rgba(77, 140, 255, 0.14)` | Halo behind automation icons |

### Tailwind CSS v4 setup

```css
@import "tailwindcss";

:root {
  --bg-canvas: #f4f4f0;
  --bg-surface: #ffffff;
  --bg-surface-elevated: #ecebe4;
  --border-subtle: #dedcd2;
  --border-default: #b8b5a8;
  --border-focus: #0033a0;
  --text-primary: #141414;
  --text-secondary: #44423c;
  --text-muted: #6f6c62;
  --color-action: #e63225;
  --color-action-hover: #c92a1e;
  --color-earnings: #9a7b00;
  --color-earnings-hover: #7f6600;
  --color-automation: #0033a0;
  --color-alert: #d08a00;
  --color-danger: #a1121f;
  --color-action-glow: rgba(230, 50, 37, 0.12);
  --color-earnings-glow: rgba(154, 123, 0, 0.12);
  --color-automation-glow: rgba(0, 51, 160, 0.12);
  --action-label: #ffffff; /* readable text color on --color-action fills */
}

[data-theme="dark"] {
  --bg-canvas: #111111;
  --bg-surface: #1a1a1a;
  --bg-surface-elevated: #262626;
  --border-subtle: #2e2e2e;
  --border-default: #4a4a4a;
  --border-focus: #4d8cff;
  --text-primary: #f5f5f0;
  --text-secondary: #c7c7c0;
  --text-muted: #8f8f86;
  --color-action: #ef3d2f;
  --color-action-hover: #d23326;
  --color-earnings: #e0b400;
  --color-earnings-hover: #c7a100;
  --color-automation: #4d8cff;
  --color-alert: #f59e0b;
  --color-danger: #e02d2d;
  --color-action-glow: rgba(239, 61, 47, 0.16);
  --color-earnings-glow: rgba(224, 180, 0, 0.14);
  --color-automation-glow: rgba(77, 140, 255, 0.14);
  --action-label: #ffffff;
}

@theme {
  --font-display: "Archivo", "Helvetica Neue", Arial, sans-serif;
  --font-sans: "Inter", "Helvetica Neue", system-ui, sans-serif;
  --font-mono: "Space Mono", ui-monospace, monospace;

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

Equivalent guide: **the full drop-in file is `~/dev/design_systems/systems/bauhaus/tailwind.css`** — copy it to
`app/assets/tailwind/design_system.css` and `@import` it from `application.css`.

## 2. Color schemas (optional accent swaps)

These override accents on top of either mode palette. Apply as a class/attribute
that re-declares the listed tokens (everything else stays from the mode palette).

### `blue-led` — Blue-Led

Blue-led with red automation; use white bold labels on blue.

| Token | Value |
|---|---|
| `--color-action` | `#3b82f6` |
| `--color-action-hover` | `#2563eb` |
| `--color-earnings` | `#e0b400` |
| `--color-earnings-hover` | `#c7a100` |
| `--color-automation` | `#ef3d2f` |
| `--color-alert` | `#f59e0b` |
| `--color-danger` | `#e02d2d` |
| `--border-focus` | `#3b82f6` |
| `--color-action-glow` | `rgba(59, 130, 246, 0.16)` |
| `--color-earnings-glow` | `rgba(224, 180, 0, 0.14)` |
| `--color-automation-glow` | `rgba(239, 61, 47, 0.14)` |
### `yellow-led` — Yellow-Led

Yellow-led with red automation; use dark ink labels on yellow.

| Token | Value |
|---|---|
| `--color-action` | `#e6c200` |
| `--color-action-hover` | `#c7a100` |
| `--color-earnings` | `#ef3d2f` |
| `--color-earnings-hover` | `#d23326` |
| `--color-automation` | `#4d8cff` |
| `--color-alert` | `#f59e0b` |
| `--color-danger` | `#e02d2d` |
| `--border-focus` | `#e6c200` |
| `--color-action-glow` | `rgba(230, 194, 0, 0.16)` |
| `--color-earnings-glow` | `rgba(239, 61, 47, 0.14)` |
| `--color-automation-glow` | `rgba(77, 140, 255, 0.14)` |
## 3. Typography

- **Display** (headings, KPIs, big numbers): `"Archivo", "Helvetica Neue", Arial, sans-serif`
- **Sans** (body, labels, UI): `"Inter", "Helvetica Neue", system-ui, sans-serif`
- **Mono** (timestamps, IDs, code, logs): `"Space Mono", ui-monospace, monospace`
- Load the families with the project's normal Google Fonts `<link>` (weights 500-800 for display/sans).

Hard rules:

- Every number (earnings, rates, counts, dates, timers) uses `tabular-nums`.
- Headings/eyebrows use tight tracking; micro-labels are uppercase `text-[10px] tracking-wider`.
- Body text at `text-sm`/`text-xs` for dense operational screens.

## 4. Radii, borders & signature treatment

- Card signature: `border: 1px solid var(--border-default); border-radius: 0; border-top: 4px solid var(--color-action);`
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
5. Motion: Crisp and instant — 80ms linear; Turbo Stream inserts use a geometric wipe (clip-path sweep from left) rather than fade.. Respect `prefers-reduced-motion`.
6. Touch targets ≥ 44px on mobile; inline form errors with `aria-live="polite"`.
7. Dark/light: `data-theme="dark"` on `<html>` flips to the counterpart palette.

## 7. Full source spec (component patterns, motion, snippet)

### PROPOSAL-08 — Bauhaus / Geometric Modern

- **slug**: `bauhaus`
- **Vibe**: Primary color blocks, a strict grid, and Swiss typography — form follows function, boldly.
- **Best for**: Analytics dashboards and dense tables where structure is the aesthetic. Adjectives: rigorous, timeless, confident.
- **Palette** (light theme, `is_dark: false`):

| Token | Value | Usage |
|---|---|---|
| `--bg-canvas` | `#f4f4f0` | Off-white gallery canvas |
| `--bg-surface` | `#ffffff` | Card and panel fill |
| `--bg-surface-elevated` | `#ecebe4` | Raised surfaces, hover fills |
| `--border-subtle` | `#dedcd2` | Fine grid hairlines |
| `--border-default` | `#b8b5a8` | Standard structural borders |
| `--border-focus` | `#0033a0` | Bauhaus-blue focus outline |
| `--text-primary` | `#141414` | Near-black headings |
| `--text-secondary` | `#44423c` | Body text |
| `--text-muted` | `#6f6c62` | Captions, helper text |
| `--color-action` | `#e63225` | Bauhaus-red primary action |
| `--color-action-hover` | `#c92a1e` | Action hover (deeper red) |
| `--color-earnings` | `#9a7b00` | Darkened bauhaus-yellow earnings (AA-safe) |
| `--color-earnings-hover` | `#7f6600` | Earnings hover (deeper olive-gold) |
| `--color-automation` | `#0033a0` | Bauhaus-blue automation accents |
| `--color-alert` | `#d08a00` | Amber warnings |
| `--color-danger` | `#a1121f` | Deep-red destructive states |
| `--color-action-glow` | `rgba(230, 50, 37, 0.12)` | Red tint behind action icons |
| `--color-earnings-glow` | `rgba(154, 123, 0, 0.12)` | Gold tint behind earnings icons |
| `--color-automation-glow` | `rgba(0, 51, 160, 0.12)` | Blue tint behind automation icons |

- **Typography**: Display: `"Archivo", "Helvetica Neue", Arial, sans-serif` at 700-800 weight, tight tracking; KPI numerals use heavy weights and `tabular-nums`. Sans: `"Inter", "Helvetica Neue", system-ui, sans-serif`. Mono: `"Space Mono", ui-monospace, monospace`. Micro-labels are uppercase with `letter-spacing: 0.12em` — pure Swiss grid discipline.
- **Radii & Borders**: Sharp corners — `border-radius: 0` everywhere. 1px borders on structure; 2px rules used as deliberate geometric accents (section dividers, top strips). No shadows; hierarchy comes from contrast and geometry.
- **Component Patterns**:
  - **Buttons**: Square corners. Primary = solid red block with white text (bold, AA-large). Secondary = white fill with 2px ink border. Tertiary = text-only with a trailing arrow. Focus = 2px blue outline with a 2px gap. Hover = background flips to a 2px block under the label.
  - **Cards**: White with a 1px border and an optional 4px geometric strip on top (red, yellow, or blue). No shadows, no rounding — pure blocks.
  - **Badges/Status**: Square chips, uppercase, with a tiny square status dot. Publishing = red square pulsing; published = blue square. No pills.
  - **Tables**: Strict grid with 1px rules and generous tabular numerals; header row is uppercase micro-type. Row hover = 2px left rule in the section color.
  - **Forms/Inputs**: Square fields with only a 2px bottom rule; focus = 2px blue bottom rule. Labels sit above in uppercase micro-type.
  - **Loading**: Indeterminate = red/yellow/blue segments cycling left-to-right; determinate = a straight, square progress bar filling in 1px steps.
  - **Signature detail**: The primary-color geometric motif (red square, yellow circle, blue triangle) used as section markers and empty-state art, plus heavy uppercase Swiss type — unmistakably Bauhaus.
- **Motion & Animation**: Crisp and instant — 80ms linear; Turbo Stream inserts use a geometric wipe (clip-path sweep from left) rather than fade. Nothing lingers; state changes snap like a press.
- **Signature Preview Snippet**:

```html
<!-- Bauhaus stat tile: red block accent, geometric strip, numeral -->
<div class="bau-tile">
  <span class="bau-overline">AUTOMATED POSTS</span>
  <strong class="bau-kpi">128</strong>
  <span class="bau-accent bau-accent-red"></span>
</div>
```

## 8. Acceptance checklist

- [ ] No raw hex outside the token block; all brand colors resolve from tokens.
- [ ] All numeric values use `tabular-nums`.
- [ ] Every interactive element has a visible focus state using `--border-focus`.
- [ ] Status badges use the fixed status colors + text label.
- [ ] Both modes render correctly (`data-theme` toggle) and meet AA contrast.
- [ ] Card/button treatment matches the signature: border: 1px solid var(--border-default); border-radius: 0; border-top: 4px solid var(--color-action);
