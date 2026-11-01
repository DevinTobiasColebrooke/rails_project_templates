# Design System: Cel-Shading

Use this design system as the complete visual language for this project. It is
one self-consistent "look": a 19-token color contract, typography, radii/border
treatment, component patterns, and motion language. Implement the UI against
these tokens — do not invent colors, shadows, or type styles.

- **Slug:** `cel-shading`
- **Mode:** native dark theme (light counterpart included)
- **Vibe:** Flat, crisp anime/game-keyframe UI where every surface is a hard-edged color block with an offset ink shadow.
- **Best for:** Creator Studio and Ad Wizard — video-combinatorial flows feel like building a game asset.
- **Adjectives:** playful, crisp, high-energy
- **Signature detail:** The 4px hard offset “cel shadow” on every interactive surface — the one unmistakable cue that this is cel-shaded, not soft-shadow UI.
- **Motion:** Snappy and stepped — Turbo Stream entries “pop” in (scale 0.9→1) without opacity fades.

## Source of truth

This is a personal, local design-system library (private, not published).

- Repo on disk: `~/dev/design_systems` (private GitHub mirror: https://github.com/DevinTobiasColebrooke/design_systems)
- This system's folder: `systems/cel-shading/`
- Machine-readable spec (tokens, fonts, schemas): `systems/cel-shading/system.json`
- Drop-in Tailwind v4 theme file: `systems/cel-shading/tailwind.css`
- Full component showcase: `systems/cel-shading/showcase.html` (open in a browser)

If you have filesystem access, read those files. If you don't, everything you
need is inline below.

## 1. The 19-token contract

Every value below is authoritative. Tokens map 1:1 to CSS custom properties
(`bg-canvas` style) and to Tailwind `brand-*` utilities
(`bg-brand-canvas`, `text-brand-action`, ...). Use tokens everywhere; never use a raw hex
outside this block.

| Token | Native (dark) | Light mode | Usage |
|---|---|---|---|
| `--bg-canvas` | `#140f26` | `#eef1f8` | Deepest background layer |
| `--bg-surface` | `#211a3a` | `#ffffff` | Cards, Sidebars, Panes |
| `--bg-surface-elevated` | `#2d2447` | `#e3e8f5` | Dropdowns, hovered states |
| `--border-subtle` | `#3a2f5c` | `#d3d9ec` | Very light separation |
| `--border-default` | `#4a3d70` | `#aab4d6` | Standard card/form borders |
| `--border-focus` | `#ffd54f` | `#ffd54f` | Focus states |
| `--text-primary` | `#fdfbff` | `#1a1630` | High contrast title/text |
| `--text-secondary` | `#c9c2e6` | `#44405e` | Standard body paragraph |
| `--text-muted` | `#8f86b8` | `#6f6a8c` | Descriptions, helper text, dates |
| `--color-action` | `#ff6a1a` | `#ff6a1a` | Primary action |
| `--color-action-hover` | `#e85a0e` | `#e85a0e` | Action hover |
| `--color-earnings` | `#ffd54f` | `#9a7400` | Earnings, Revenue, Profit |
| `--color-earnings-hover` | `#f2c21f` | `#806000` | Earnings hover |
| `--color-automation` | `#38e1ff` | `#067a9e` | Playwright, AI, Terminal accents |
| `--color-alert` | `#ffb300` | `#b45309` | Warnings, pending states |
| `--color-danger` | `#ff4d5e` | `#d93345` | Error, failed status, deletes |
| `--color-action-glow` | `rgba(255, 106, 26, 0.16)` | `rgba(255, 106, 26, 0.14)` | Halo behind action icons |
| `--color-earnings-glow` | `rgba(255, 213, 79, 0.16)` | `rgba(154, 116, 0, 0.12)` | Halo behind earnings icons |
| `--color-automation-glow` | `rgba(56, 225, 255, 0.16)` | `rgba(6, 122, 158, 0.12)` | Halo behind automation icons |

### Tailwind CSS v4 setup

```css
@import "tailwindcss";

:root {
  --bg-canvas: #140f26;
  --bg-surface: #211a3a;
  --bg-surface-elevated: #2d2447;
  --border-subtle: #3a2f5c;
  --border-default: #4a3d70;
  --border-focus: #ffd54f;
  --text-primary: #fdfbff;
  --text-secondary: #c9c2e6;
  --text-muted: #8f86b8;
  --color-action: #ff6a1a;
  --color-action-hover: #e85a0e;
  --color-earnings: #ffd54f;
  --color-earnings-hover: #f2c21f;
  --color-automation: #38e1ff;
  --color-alert: #ffb300;
  --color-danger: #ff4d5e;
  --color-action-glow: rgba(255, 106, 26, 0.16);
  --color-earnings-glow: rgba(255, 213, 79, 0.16);
  --color-automation-glow: rgba(56, 225, 255, 0.16);
  --action-label: #0d0d12; /* readable text color on --color-action fills */
}

[data-theme="light"] {
  --bg-canvas: #eef1f8;
  --bg-surface: #ffffff;
  --bg-surface-elevated: #e3e8f5;
  --border-subtle: #d3d9ec;
  --border-default: #aab4d6;
  --border-focus: #ffd54f;
  --text-primary: #1a1630;
  --text-secondary: #44405e;
  --text-muted: #6f6a8c;
  --color-action: #ff6a1a;
  --color-action-hover: #e85a0e;
  --color-earnings: #9a7400;
  --color-earnings-hover: #806000;
  --color-automation: #067a9e;
  --color-alert: #b45309;
  --color-danger: #d93345;
  --color-action-glow: rgba(255, 106, 26, 0.14);
  --color-earnings-glow: rgba(154, 116, 0, 0.12);
  --color-automation-glow: rgba(6, 122, 158, 0.12);
  --action-label: #0d0d12;
}

@theme {
  --font-display: "Fredoka", "Baloo 2", system-ui, sans-serif;
  --font-sans: "Nunito", "Inter", system-ui, sans-serif;
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

Equivalent guide: **the full drop-in file is `~/dev/design_systems/systems/cel-shading/tailwind.css`** — copy it to
`app/assets/tailwind/design_system.css` and `@import` it from `application.css`.

## 2. Color schemas (optional accent swaps)

These override accents on top of either mode palette. Apply as a class/attribute
that re-declares the listed tokens (everything else stays from the mode palette).

### `ocean-pop` — Ocean Pop

Cool deep-blue hero with gold earnings; use dark ink labels on the blue fill.

| Token | Value |
|---|---|
| `--color-action` | `#1d7ae8` |
| `--color-action-hover` | `#1663c2` |
| `--color-earnings` | `#9a7400` |
| `--color-earnings-hover` | `#806000` |
| `--color-automation` | `#067a9e` |
| `--color-alert` | `#b45309` |
| `--color-danger` | `#d93345` |
| `--border-focus` | `#1d7ae8` |
| `--color-action-glow` | `rgba(29, 122, 232, 0.14)` |
| `--color-earnings-glow` | `rgba(154, 116, 0, 0.12)` |
| `--color-automation-glow` | `rgba(6, 122, 158, 0.12)` |
### `mint-arcade` — Mint Arcade

Mint hero with magenta automation for an arcade twist; use dark ink labels on mint.

| Token | Value |
|---|---|
| `--color-action` | `#0fbf8f` |
| `--color-action-hover` | `#0ca37b` |
| `--color-earnings` | `#9a7400` |
| `--color-earnings-hover` | `#806000` |
| `--color-automation` | `#d633c4` |
| `--color-alert` | `#b45309` |
| `--color-danger` | `#d93345` |
| `--border-focus` | `#0fbf8f` |
| `--color-action-glow` | `rgba(15, 191, 143, 0.14)` |
| `--color-earnings-glow` | `rgba(154, 116, 0, 0.12)` |
| `--color-automation-glow` | `rgba(214, 51, 196, 0.12)` |
## 3. Typography

- **Display** (headings, KPIs, big numbers): `"Fredoka", "Baloo 2", system-ui, sans-serif`
- **Sans** (body, labels, UI): `"Nunito", "Inter", system-ui, sans-serif`
- **Mono** (timestamps, IDs, code, logs): `"Space Mono", ui-monospace, monospace`
- Load the families with the project's normal Google Fonts `<link>` (weights 500-800 for display/sans).

Hard rules:

- Every number (earnings, rates, counts, dates, timers) uses `tabular-nums`.
- Headings/eyebrows use tight tracking; micro-labels are uppercase `text-[10px] tracking-wider`.
- Body text at `text-sm`/`text-xs` for dense operational screens.

## 4. Radii, borders & signature treatment

- Card signature: `border: 2px solid; border-radius: 0.75rem; box-shadow: 0 4px 0 0 #0d0a1a;`
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
5. Motion: Snappy and stepped — Turbo Stream entries “pop” in (scale 0.9→1) without opacity fades.. Respect `prefers-reduced-motion`.
6. Touch targets ≥ 44px on mobile; inline form errors with `aria-live="polite"`.
7. Dark/light: `data-theme="light"` on `<html>` flips to the counterpart palette.

## 7. Full source spec (component patterns, motion, snippet)

### PROPOSAL-01 — Cel-Shading

- **slug**: `cel-shading`
- **Vibe**: Flat, crisp anime/game-keyframe UI where every surface is a hard-edged color block with an offset ink shadow.
- **Best for**: Creator Studio and Ad Wizard — video-combinatorial flows feel like building a game asset. Adjectives: playful, crisp, high-energy.
- **Palette** (dark theme, `is_dark: true`):

| Token | Value | Usage |
|---|---|---|
| `--bg-canvas` | `#140f26` | Deep night-sky violet; app canvas |
| `--bg-surface` | `#211a3a` | Flat panel fill; cards, sidebars |
| `--bg-surface-elevated` | `#2d2447` | Raised panels, popovers, hover fills |
| `--border-subtle` | `#3a2f5c` | Hairline separation between panels |
| `--border-default` | `#4a3d70` | Standard card/form borders |
| `--border-focus` | `#ffd54f` | Hard yellow "keyframe highlight" outline |
| `--text-primary` | `#fdfbff` | Headings and emphasis on dark fills |
| `--text-secondary` | `#c9c2e6` | Standard body text |
| `--text-muted` | `#8f86b8` | Helper text, dates, captions |
| `--color-action` | `#ff6a1a` | Hero-orange primary action fills |
| `--color-action-hover` | `#e85a0e` | Action hover (deeper orange) |
| `--color-earnings` | `#ffd54f` | Coin-gold earnings, revenue, profit |
| `--color-earnings-hover` | `#f2c21f` | Earnings hover (deeper gold) |
| `--color-automation` | `#38e1ff` | Cel-cyan; Playwright/AI/terminal accents |
| `--color-alert` | `#ffb300` | Warnings, pending, publishing pulse |
| `--color-danger` | `#ff4d5e` | Failed status, destructive actions |
| `--color-action-glow` | `rgba(255, 106, 26, 0.16)` | Soft tint behind action icons |
| `--color-earnings-glow` | `rgba(255, 213, 79, 0.16)` | Soft tint behind earnings icons |
| `--color-automation-glow` | `rgba(56, 225, 255, 0.16)` | Soft tint behind automation icons |

- **Typography**: Display: `"Fredoka", "Baloo 2", system-ui, sans-serif` at 600-700 weight, tight leading. Sans: `"Nunito", "Inter", system-ui, sans-serif` at 500-700. Mono: `"Space Mono", ui-monospace, monospace` for timestamps and IDs. Headings use `letter-spacing: 0.01em`; numeric KPIs enforce `tabular-nums`.
- **Radii & Borders**: Chunky-but-friendly: cards `rounded-xl` (0.75rem), buttons pill (`rounded-full`), inputs `rounded-md`. 2px borders. The signature is the **hard offset shadow**: a solid 4px shadow (`0 4px 0 0 #0d0a1a`) with zero blur — no soft shadows anywhere.
- **Component Patterns**:
  - **Buttons**: Primary = flat saturated fill with dark ink text (`#140f26`) + 4px hard offset shadow; hover "presses down" (shadow shrinks to 1px). Secondary = transparent with 2px border. Tertiary = text-only with underline on hover. Focus-visible = 2px `--border-focus` outline. Sharp-edged, never ghosted.
  - **Cards**: Flat surface fill, hard offset shadow, 2px border. No gradients, no blur. Hover raises the offset shadow from 4px to 6px. KPI cards get a colored top "keyframe strip" (action/earnings/automation).
  - **Badges/Status**: Pill with a square status dot (cel style, not round); publishing status uses the pulsing gold "spark". Failed = red pill with dark text.
  - **Tables**: Two flat alternating row fills (`surface` / `surface-elevated`), no zebra glow; header row has a hard 2px underline and uppercase micro-labels. Hover = left 3px action strip.
  - **Forms/Inputs**: Flat fills, 2px borders, no inner glow; focus = yellow border only. Error text sits inline below the field with a small square alert glyph.
  - **Loading**: A bouncing 3-block "sprite" (three squares that hop in sequence, 120ms per hop). Determinate progress = segmented blocks filling one-by-one.
  - **Signature detail**: The 4px hard offset "cel shadow" on every interactive surface — the one unmistakable cue that this is cel-shaded, not soft-shadow UI.
- **Motion & Animation**: Snappy and stepped (`cubic-bezier(0.9, 0, 0.1, 1)`, 100-150ms). Turbo Stream entries "pop" in (scale 0.9 to 1) without opacity fades. Buttons compress on `:active` like a keyframe squash.
- **Signature Preview Snippet**:

```html
<!-- Cel KPI card: flat fill, 4px hard ink shadow, coin-gold KPI -->
<div class="cel-card">
  <span class="cel-label">Earnings / 30d</span>
  <strong class="cel-kpi">$12,480.50</strong>
  <span class="cel-delta cel-up">+14.2% vs last month</span>
  <button class="cel-btn">Queue Post</button>
</div>
```

## 8. Acceptance checklist

- [ ] No raw hex outside the token block; all brand colors resolve from tokens.
- [ ] All numeric values use `tabular-nums`.
- [ ] Every interactive element has a visible focus state using `--border-focus`.
- [ ] Status badges use the fixed status colors + text label.
- [ ] Both modes render correctly (`data-theme` toggle) and meet AA contrast.
- [ ] Card/button treatment matches the signature: border: 2px solid; border-radius: 0.75rem; box-shadow: 0 4px 0 0 #0d0a1a;
