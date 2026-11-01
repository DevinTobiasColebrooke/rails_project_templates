# Design System: Comic Book / Graphic Novel

Use this design system as the complete visual language for this project. It is
one self-consistent "look": a 19-token color contract, typography, radii/border
treatment, component patterns, and motion language. Implement the UI against
these tokens — do not invent colors, shadows, or type styles.

- **Slug:** `comic-book`
- **Mode:** native light theme (dark counterpart included)
- **Vibe:** Bold black ink outlines, halftone dot fields, and CMYK primary pop on pulp paper — every stat reads like a panel from a graphic novel.
- **Best for:** Earnings dashboard and campaign bursts — big, dramatic numbers.
- **Adjectives:** loud, dramatic, unmistakable
- **Signature detail:** The halftone dot field plus heavy ink outlines on every panel — the unmistakable print-comic texture.
- **Motion:** Fast and theatrical: entries “POP” in with scale(0.85)→scale(1.05)→scale(1) over 200ms with a slight rotate.

## Source of truth

This is a personal, local design-system library (private, not published).

- Repo on disk: `~/dev/design_systems` (private GitHub mirror: https://github.com/DevinTobiasColebrooke/design_systems)
- This system's folder: `systems/comic-book/`
- Machine-readable spec (tokens, fonts, schemas): `systems/comic-book/system.json`
- Drop-in Tailwind v4 theme file: `systems/comic-book/tailwind.css`
- Full component showcase: `systems/comic-book/showcase.html` (open in a browser)

If you have filesystem access, read those files. If you don't, everything you
need is inline below.

## 1. The 19-token contract

Every value below is authoritative. Tokens map 1:1 to CSS custom properties
(`bg-canvas` style) and to Tailwind `brand-*` utilities
(`bg-brand-canvas`, `text-brand-action`, ...). Use tokens everywhere; never use a raw hex
outside this block.

| Token | Native (light) | Dark mode | Usage |
|---|---|---|---|
| `--bg-canvas` | `#f6f1e3` | `#141414` | Deepest background layer |
| `--bg-surface` | `#ffffff` | `#1e1d1b` | Cards, Sidebars, Panes |
| `--bg-surface-elevated` | `#fff9eb` | `#2a2825` | Dropdowns, hovered states |
| `--border-subtle` | `#cfc8b6` | `#3a3732` | Very light separation |
| `--border-default` | `#141414` | `#d9d2c0` | Standard card/form borders |
| `--border-focus` | `#e6343c` | `#ff4d5e` | Focus states |
| `--text-primary` | `#141414` | `#f5efe0` | High contrast title/text |
| `--text-secondary` | `#3a3a3a` | `#c9c0aa` | Standard body paragraph |
| `--text-muted` | `#6e6757` | `#8f8772` | Descriptions, helper text, dates |
| `--color-action` | `#e6343c` | `#ff4d5e` | Primary action |
| `--color-action-hover` | `#c92a31` | `#e53a4a` | Action hover |
| `--color-earnings` | `#0a9d4e` | `#3ddc84` | Earnings, Revenue, Profit |
| `--color-earnings-hover` | `#0b8a44` | `#2bc471` | Earnings hover |
| `--color-automation` | `#2f6bff` | `#6f9bff` | Playwright, AI, Terminal accents |
| `--color-alert` | `#ffb302` | `#ffd54f` | Warnings, pending states |
| `--color-danger` | `#8c1c22` | `#e5313f` | Error, failed status, deletes |
| `--color-action-glow` | `rgba(230, 52, 60, 0.14)` | `rgba(255, 77, 94, 0.16)` | Halo behind action icons |
| `--color-earnings-glow` | `rgba(10, 157, 78, 0.14)` | `rgba(61, 220, 132, 0.14)` | Halo behind earnings icons |
| `--color-automation-glow` | `rgba(47, 107, 255, 0.14)` | `rgba(111, 155, 255, 0.14)` | Halo behind automation icons |

### Tailwind CSS v4 setup

```css
@import "tailwindcss";

:root {
  --bg-canvas: #f6f1e3;
  --bg-surface: #ffffff;
  --bg-surface-elevated: #fff9eb;
  --border-subtle: #cfc8b6;
  --border-default: #141414;
  --border-focus: #e6343c;
  --text-primary: #141414;
  --text-secondary: #3a3a3a;
  --text-muted: #6e6757;
  --color-action: #e6343c;
  --color-action-hover: #c92a31;
  --color-earnings: #0a9d4e;
  --color-earnings-hover: #0b8a44;
  --color-automation: #2f6bff;
  --color-alert: #ffb302;
  --color-danger: #8c1c22;
  --color-action-glow: rgba(230, 52, 60, 0.14);
  --color-earnings-glow: rgba(10, 157, 78, 0.14);
  --color-automation-glow: rgba(47, 107, 255, 0.14);
  --action-label: #ffffff; /* readable text color on --color-action fills */
}

[data-theme="dark"] {
  --bg-canvas: #141414;
  --bg-surface: #1e1d1b;
  --bg-surface-elevated: #2a2825;
  --border-subtle: #3a3732;
  --border-default: #d9d2c0;
  --border-focus: #ff4d5e;
  --text-primary: #f5efe0;
  --text-secondary: #c9c0aa;
  --text-muted: #8f8772;
  --color-action: #ff4d5e;
  --color-action-hover: #e53a4a;
  --color-earnings: #3ddc84;
  --color-earnings-hover: #2bc471;
  --color-automation: #6f9bff;
  --color-alert: #ffd54f;
  --color-danger: #e5313f;
  --color-action-glow: rgba(255, 77, 94, 0.16);
  --color-earnings-glow: rgba(61, 220, 132, 0.14);
  --color-automation-glow: rgba(111, 155, 255, 0.14);
  --action-label: #0d0d12;
}

@theme {
  --font-display: "Bangers", "Archivo Black", sans-serif;
  --font-sans: "Archivo", "Inter", system-ui, sans-serif;
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

Equivalent guide: **the full drop-in file is `~/dev/design_systems/systems/comic-book/tailwind.css`** — copy it to
`app/assets/tailwind/design_system.css` and `@import` it from `application.css`.

## 2. Color schemas (optional accent swaps)

These override accents on top of either mode palette. Apply as a class/attribute
that re-declares the listed tokens (everything else stays from the mode palette).

### `villain-purple` — Villain Purple

Menacing purple hero with cyan secondary; use white bold labels on purple.

| Token | Value |
|---|---|
| `--color-action` | `#a855f7` |
| `--color-action-hover` | `#8b3ce0` |
| `--color-earnings` | `#ffd54f` |
| `--color-earnings-hover` | `#e6bc00` |
| `--color-automation` | `#22d3ee` |
| `--color-alert` | `#f59e0b` |
| `--color-danger` | `#ef4444` |
| `--border-focus` | `#a855f7` |
| `--color-action-glow` | `rgba(168, 85, 247, 0.18)` |
| `--color-earnings-glow` | `rgba(255, 213, 79, 0.14)` |
| `--color-automation-glow` | `rgba(34, 211, 238, 0.14)` |
### `super-blue` — Super Blue

Heroic blue with pink automation; use white bold labels on blue.

| Token | Value |
|---|---|
| `--color-action` | `#3b82f6` |
| `--color-action-hover` | `#2563eb` |
| `--color-earnings` | `#ffd54f` |
| `--color-earnings-hover` | `#e6bc00` |
| `--color-automation` | `#f472b6` |
| `--color-alert` | `#f59e0b` |
| `--color-danger` | `#ef4444` |
| `--border-focus` | `#3b82f6` |
| `--color-action-glow` | `rgba(59, 130, 246, 0.16)` |
| `--color-earnings-glow` | `rgba(255, 213, 79, 0.14)` |
| `--color-automation-glow` | `rgba(244, 114, 182, 0.14)` |
## 3. Typography

- **Display** (headings, KPIs, big numbers): `"Bangers", "Archivo Black", sans-serif`
- **Sans** (body, labels, UI): `"Archivo", "Inter", system-ui, sans-serif`
- **Mono** (timestamps, IDs, code, logs): `"Space Mono", ui-monospace, monospace`
- Load the families with the project's normal Google Fonts `<link>` (weights 500-800 for display/sans).

Hard rules:

- Every number (earnings, rates, counts, dates, timers) uses `tabular-nums`.
- Headings/eyebrows use tight tracking; micro-labels are uppercase `text-[10px] tracking-wider`.
- Body text at `text-sm`/`text-xs` for dense operational screens.

## 4. Radii, borders & signature treatment

- Card signature: `border: 3px solid #141414; border-radius: 2px; box-shadow: 5px 5px 0 0 rgba(20, 20, 20, 0.9);`
- Canvas/texture signature: `background-image: repeating-radial-gradient(circle at 3px 3px, rgba(20,20,20,0.14) 0 1px, transparent 1px 6px);`
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
5. Motion: Fast and theatrical: entries “POP” in with scale(0.85)→scale(1.05)→scale(1) over 200ms with a slight rotate.. Respect `prefers-reduced-motion`.
6. Touch targets ≥ 44px on mobile; inline form errors with `aria-live="polite"`.
7. Dark/light: `data-theme="dark"` on `<html>` flips to the counterpart palette.

## 7. Full source spec (component patterns, motion, snippet)

### PROPOSAL-03 — Comic Book / Graphic Novel

- **slug**: `comic-book`
- **Vibe**: Bold black ink outlines, halftone dot fields, and CMYK primary pop on pulp paper — every stat reads like a panel from a graphic novel.
- **Best for**: Earnings dashboard and campaign bursts — big, dramatic numbers. Adjectives: loud, dramatic, unmistakable.
- **Palette** (light theme, `is_dark: false`):

| Token | Value | Usage |
|---|---|---|
| `--bg-canvas` | `#f6f1e3` | Pulp-paper canvas |
| `--bg-surface` | `#ffffff` | Card and panel fill |
| `--bg-surface-elevated` | `#fff9eb` | Hovered/raised paper highlight |
| `--border-subtle` | `#cfc8b6` | Light ink hairlines |
| `--border-default` | `#141414` | Heavy ink outlines (2-3px) |
| `--border-focus` | `#e6343c` | Comic-red focus outline |
| `--text-primary` | `#141414` | Ink-black headings and body |
| `--text-secondary` | `#3a3a3a` | Standard body text |
| `--text-muted` | `#6e6757` | Captions, dates, fine print |
| `--color-action` | `#e6343c` | CMYK-red primary action |
| `--color-action-hover` | `#c92a31` | Action hover (darker red) |
| `--color-earnings` | `#0a9d4e` | Comic green for earnings |
| `--color-earnings-hover` | `#0b8a44` | Earnings hover (deeper green) |
| `--color-automation` | `#2f6bff` | CMYK-blue automation accents |
| `--color-alert` | `#ffb302` | Comic-yellow warnings |
| `--color-danger` | `#8c1c22` | Dark blood-red destructive states |
| `--color-action-glow` | `rgba(230, 52, 60, 0.14)` | Halftone-red tint behind icons |
| `--color-earnings-glow` | `rgba(10, 157, 78, 0.14)` | Halftone-green tint behind icons |
| `--color-automation-glow` | `rgba(47, 107, 255, 0.14)` | Halftone-blue tint behind icons |

- **Typography**: Display: `"Bangers", "Archivo Black", sans-serif` — always uppercase, `letter-spacing: 0.02em`, used only for KPI numerals, section headers, and CTA labels. Sans: `"Archivo", "Inter", system-ui, sans-serif`. Mono: `"Space Mono", ui-monospace, monospace` for timestamps. Numbers are `tabular-nums` and deliberately heavy.
- **Radii & Borders**: Sharp and inked — cards and buttons at 2px radius; the ink border is 2-3px solid `--border-default` plus a 1px inner white "frame" (double-line comic panel). Buttons may tilt -1deg on hover for a "paste-up" feel.
- **Component Patterns**:
  - **Buttons**: 3px ink border + solid pop fill, uppercase Bangers label, hard offset ink shadow (4px, no blur). Primary = red fill with white bold text (large text, passes AA). Secondary = white fill + ink outline. Focus = 3px `--border-focus` outline.
  - **Cards**: Paper-white fill, 3px ink outline + hard offset shadow, header banded with a halftone dot strip (CSS `repeating-radial-gradient`). The KPI numeral sits on the halftone field like a panel caption.
  - **Badges/Status**: Sticker-style pills with ink border and halftone background; publishing = pulsing "burst" starburst; failed = red sticker with white text.
  - **Tables**: Alternating white/cream rows with ink column rules; header row is a red banner strip with white uppercase labels. Hover = 2px left ink tick.
  - **Forms/Inputs**: "Lined-paper" fields — only a 2px ink baseline under the input; focus = red baseline + small star burst in the corner.
  - **Loading**: A comic "POW" starburst that pulses and scales in a 3-frame cycle; determinate progress = speech-bubble meter filling with dots.
  - **Signature detail**: The halftone dot field + heavy ink outlines on every panel — the unmistakable print-comic texture.
- **Motion & Animation**: Fast and theatrical: entries "POP" in with `scale(0.85) -> scale(1.05) -> scale(1)` over 200ms with a slight rotate; buttons smash down 2px on `:active`. Turbo Stream inserts inherit the POP.
- **Signature Preview Snippet**:

```html
<!-- Comic earnings hero: ink outline, halftone band, burst delta -->
<div class="comic-card">
  <span class="comic-overline">EARNINGS THIS MONTH</span>
  <strong class="comic-kpi">$8,240</strong>
  <span class="comic-burst">+22%</span>
</div>
```

## 8. Acceptance checklist

- [ ] No raw hex outside the token block; all brand colors resolve from tokens.
- [ ] All numeric values use `tabular-nums`.
- [ ] Every interactive element has a visible focus state using `--border-focus`.
- [ ] Status badges use the fixed status colors + text label.
- [ ] Both modes render correctly (`data-theme` toggle) and meet AA contrast.
- [ ] Card/button treatment matches the signature: border: 3px solid #141414; border-radius: 2px; box-shadow: 5px 5px 0 0 rgba(20, 20, 20, 0.9);
