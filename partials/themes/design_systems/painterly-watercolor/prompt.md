# Design System: Painterly / Watercolor

Use this design system as the complete visual language for this project. It is
one self-consistent "look": a 19-token color contract, typography, radii/border
treatment, component patterns, and motion language. Implement the UI against
these tokens — do not invent colors, shadows, or type styles.

- **Slug:** `painterly-watercolor`
- **Mode:** native light theme (dark counterpart included)
- **Vibe:** Soft layered washes, translucent color, and warm paper — the UI looks hand-painted rather than rendered.
- **Best for:** Onboarding flows, product show pages, and campaign storytelling.
- **Adjectives:** calm, handcrafted, warm
- **Signature detail:** The layered translucent wash gradient on the canvas plus hand-drawn underline accents on headings — watercolor bleed, no hard edges.
- **Motion:** Slow and liquid — 300-450ms ease-in-out; elements fade in with a 6px upward drift and slight blur-to-sharp.

## Source of truth

This is a personal, local design-system library (private, not published).

- Repo on disk: `~/dev/design_systems` (private GitHub mirror: https://github.com/DevinTobiasColebrooke/design_systems)
- This system's folder: `systems/painterly-watercolor/`
- Machine-readable spec (tokens, fonts, schemas): `systems/painterly-watercolor/system.json`
- Drop-in Tailwind v4 theme file: `systems/painterly-watercolor/tailwind.css`
- Full component showcase: `systems/painterly-watercolor/showcase.html` (open in a browser)

If you have filesystem access, read those files. If you don't, everything you
need is inline below.

## 1. The 19-token contract

Every value below is authoritative. Tokens map 1:1 to CSS custom properties
(`bg-canvas` style) and to Tailwind `brand-*` utilities
(`bg-brand-canvas`, `text-brand-action`, ...). Use tokens everywhere; never use a raw hex
outside this block.

| Token | Native (light) | Dark mode | Usage |
|---|---|---|---|
| `--bg-canvas` | `#f4ead8` | `#1a1612` | Deepest background layer |
| `--bg-surface` | `#fdf8ef` | `#241f19` | Cards, Sidebars, Panes |
| `--bg-surface-elevated` | `#fffcf4` | `#2f2921` | Dropdowns, hovered states |
| `--border-subtle` | `#e6d9c0` | `#3d362c` | Very light separation |
| `--border-default` | `#cdbfa3` | `#57503f` | Standard card/form borders |
| `--border-focus` | `#9a6234` | `#d1844f` | Focus states |
| `--text-primary` | `#3b2f26` | `#f3ead9` | High contrast title/text |
| `--text-secondary` | `#5c4f42` | `#c9bdab` | Standard body paragraph |
| `--text-muted` | `#7a6a58` | `#948875` | Descriptions, helper text, dates |
| `--color-action` | `#9a6234` | `#d1844f` | Primary action |
| `--color-action-hover` | `#7f5127` | `#b96f3e` | Action hover |
| `--color-earnings` | `#4f7d4f` | `#86b98a` | Earnings, Revenue, Profit |
| `--color-earnings-hover` | `#3f6a40` | `#6ea372` | Earnings hover |
| `--color-automation` | `#5a7f9e` | `#7fa6c9` | Playwright, AI, Terminal accents |
| `--color-alert` | `#c9922e` | `#e0a84f` | Warnings, pending states |
| `--color-danger` | `#a6534f` | `#c96a5f` | Error, failed status, deletes |
| `--color-action-glow` | `rgba(154, 98, 52, 0.12)` | `rgba(209, 132, 79, 0.14)` | Halo behind action icons |
| `--color-earnings-glow` | `rgba(79, 125, 79, 0.12)` | `rgba(134, 185, 138, 0.12)` | Halo behind earnings icons |
| `--color-automation-glow` | `rgba(90, 127, 158, 0.12)` | `rgba(127, 166, 201, 0.12)` | Halo behind automation icons |

### Tailwind CSS v4 setup

```css
@import "tailwindcss";

:root {
  --bg-canvas: #f4ead8;
  --bg-surface: #fdf8ef;
  --bg-surface-elevated: #fffcf4;
  --border-subtle: #e6d9c0;
  --border-default: #cdbfa3;
  --border-focus: #9a6234;
  --text-primary: #3b2f26;
  --text-secondary: #5c4f42;
  --text-muted: #7a6a58;
  --color-action: #9a6234;
  --color-action-hover: #7f5127;
  --color-earnings: #4f7d4f;
  --color-earnings-hover: #3f6a40;
  --color-automation: #5a7f9e;
  --color-alert: #c9922e;
  --color-danger: #a6534f;
  --color-action-glow: rgba(154, 98, 52, 0.12);
  --color-earnings-glow: rgba(79, 125, 79, 0.12);
  --color-automation-glow: rgba(90, 127, 158, 0.12);
  --action-label: #ffffff; /* readable text color on --color-action fills */
}

[data-theme="dark"] {
  --bg-canvas: #1a1612;
  --bg-surface: #241f19;
  --bg-surface-elevated: #2f2921;
  --border-subtle: #3d362c;
  --border-default: #57503f;
  --border-focus: #d1844f;
  --text-primary: #f3ead9;
  --text-secondary: #c9bdab;
  --text-muted: #948875;
  --color-action: #d1844f;
  --color-action-hover: #b96f3e;
  --color-earnings: #86b98a;
  --color-earnings-hover: #6ea372;
  --color-automation: #7fa6c9;
  --color-alert: #e0a84f;
  --color-danger: #c96a5f;
  --color-action-glow: rgba(209, 132, 79, 0.14);
  --color-earnings-glow: rgba(134, 185, 138, 0.12);
  --color-automation-glow: rgba(127, 166, 201, 0.12);
  --action-label: #0d0d12;
}

@theme {
  --font-display: "Fraunces", Georgia, serif;
  --font-sans: "Lora", Georgia, serif;
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

Equivalent guide: **the full drop-in file is `~/dev/design_systems/systems/painterly-watercolor/tailwind.css`** — copy it to
`app/assets/tailwind/design_system.css` and `@import` it from `application.css`.

## 2. Color schemas (optional accent swaps)

These override accents on top of either mode palette. Apply as a class/attribute
that re-declares the listed tokens (everything else stays from the mode palette).

### `rosewater-wash` — Rosewater Wash

Soft rose hero with sage and dusty blue; use cream bold labels.

| Token | Value |
|---|---|
| `--color-action` | `#d9738a` |
| `--color-action-hover` | `#c05f76` |
| `--color-earnings` | `#86b98a` |
| `--color-earnings-hover` | `#6ea372` |
| `--color-automation` | `#7fa6c9` |
| `--color-alert` | `#e0a84f` |
| `--color-danger` | `#c96a5f` |
| `--border-focus` | `#d9738a` |
| `--color-action-glow` | `rgba(217, 115, 138, 0.14)` |
| `--color-earnings-glow` | `rgba(134, 185, 138, 0.12)` |
| `--color-automation-glow` | `rgba(127, 166, 201, 0.12)` |
### `lavender-bloom` — Lavender Bloom

Gentle lavender hero; use cream bold labels.

| Token | Value |
|---|---|
| `--color-action` | `#a98fd6` |
| `--color-action-hover` | `#9074c0` |
| `--color-earnings` | `#86b98a` |
| `--color-earnings-hover` | `#6ea372` |
| `--color-automation` | `#7fa6c9` |
| `--color-alert` | `#e0a84f` |
| `--color-danger` | `#c96a5f` |
| `--border-focus` | `#a98fd6` |
| `--color-action-glow` | `rgba(169, 143, 214, 0.14)` |
| `--color-earnings-glow` | `rgba(134, 185, 138, 0.12)` |
| `--color-automation-glow` | `rgba(127, 166, 201, 0.12)` |
## 3. Typography

- **Display** (headings, KPIs, big numbers): `"Fraunces", Georgia, serif`
- **Sans** (body, labels, UI): `"Lora", Georgia, serif`
- **Mono** (timestamps, IDs, code, logs): `"IBM Plex Mono", ui-monospace, monospace`
- Load the families with the project's normal Google Fonts `<link>` (weights 500-800 for display/sans).

Hard rules:

- Every number (earnings, rates, counts, dates, timers) uses `tabular-nums`.
- Headings/eyebrows use tight tracking; micro-labels are uppercase `text-[10px] tracking-wider`.
- Body text at `text-sm`/`text-xs` for dense operational screens.

## 4. Radii, borders & signature treatment

- Card signature: `border: 1px solid; border-radius: 1rem 1rem 1rem 0.25rem; box-shadow: 0 12px 40px rgba(80, 60, 40, 0.12);`
- Canvas/texture signature: `background-image: radial-gradient(circle at 88% 8%, rgba(154, 98, 52, 0.18), transparent 55%);`
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
5. Motion: Slow and liquid — 300-450ms ease-in-out; elements fade in with a 6px upward drift and slight blur-to-sharp.. Respect `prefers-reduced-motion`.
6. Touch targets ≥ 44px on mobile; inline form errors with `aria-live="polite"`.
7. Dark/light: `data-theme="dark"` on `<html>` flips to the counterpart palette.

## 7. Full source spec (component patterns, motion, snippet)

### PROPOSAL-04 — Painterly / Watercolor

- **slug**: `painterly-watercolor`
- **Vibe**: Soft layered washes, translucent color, and warm paper — the UI looks hand-painted rather than rendered.
- **Best for**: Onboarding flows, product show pages, and campaign storytelling. Adjectives: calm, handcrafted, warm.
- **Palette** (light theme, `is_dark: false`):

| Token | Value | Usage |
|---|---|---|
| `--bg-canvas` | `#f4ead8` | Warm paper canvas with wash overlay |
| `--bg-surface` | `#fdf8ef` | Card paper fill |
| `--bg-surface-elevated` | `#fffcf4` | Raised/hovered paper |
| `--border-subtle` | `#e6d9c0` | Soft wash hairlines |
| `--border-default` | `#cdbfa3` | Standard soft borders |
| `--border-focus` | `#9a6234` | Burnt-sienna brush focus |
| `--text-primary` | `#3b2f26` | Warm dark ink-brown headings |
| `--text-secondary` | `#5c4f42` | Body text |
| `--text-muted` | `#7a6a58` | Captions, dates, helper text |
| `--color-action` | `#9a6234` | Burnt-sienna primary action |
| `--color-action-hover` | `#7f5127` | Action hover (deeper sienna) |
| `--color-earnings` | `#4f7d4f` | Sage-green wash for earnings |
| `--color-earnings-hover` | `#3f6a40` | Earnings hover (deeper sage) |
| `--color-automation` | `#5a7f9e` | Dusty-blue automation wash |
| `--color-alert` | `#c9922e` | Ochre warnings |
| `--color-danger` | `#a6534f` | Muted vermilion destructive states |
| `--color-action-glow` | `rgba(154, 98, 52, 0.12)` | Translucent wash behind action icons |
| `--color-earnings-glow` | `rgba(79, 125, 79, 0.12)` | Translucent wash behind earnings icons |
| `--color-automation-glow` | `rgba(90, 127, 158, 0.12)` | Translucent wash behind automation icons |

- **Typography**: Display: `"Fraunces", Georgia, serif` at 500-600 weight, soft optical sizing, no extra tracking. Sans: `"Lora", Georgia, serif` (warm, readable). Mono: `"IBM Plex Mono", ui-monospace, monospace` reserved for timestamps and IDs so data reads "typeset". Numerals `tabular-nums`.
- **Radii & Borders**: Organic and irregular: cards use asymmetric radii (e.g., `1rem 1rem 1rem 0.25rem`), buttons are soft pills. 1px borders only, in muted tones. Shadows are very soft (`0 12px 40px rgba(80, 60, 40, 0.10)`).
- **Component Patterns**:
  - **Buttons**: Soft pills with a translucent wash fill and a 1px border in a deeper tone of the same hue; white/ink text depending on wash depth. Hover deepens the wash opacity. Focus = soft double border (2px sienna ring with gap).
  - **Cards**: Paper-white with a soft shadow and a layered translucent accent wash in one corner (radial-gradient, low opacity). Optional deckled edge via asymmetric radii. No hard outlines.
  - **Badges/Status**: Translucent pills with a soft dot; no hard borders — status reads as colored water on paper. Publishing = slowly breathing dot.
  - **Tables**: Minimal rules; generous row padding; header labels in small-caps serif. Row hover = soft wash band rather than a hard highlight.
  - **Forms/Inputs**: Underline-only fields with placeholder in italic serif; focus = sienna brush underline that fades in. Errors in muted vermilion below the field.
  - **Loading**: Three soft ink dots that "bloom" (opacity + scale) in sequence; determinate progress = a gentle wash filling a rounded track.
  - **Signature detail**: The layered translucent wash gradient on the canvas plus hand-drawn underline accents on headings — watercolor bleed, no hard edges.
- **Motion & Animation**: Slow and liquid — 300-450ms ease-in-out; elements fade in with a 6px upward drift and slight blur-to-sharp. Turbo Stream additions "bleed" in rather than pop.
- **Signature Preview Snippet**:

```html
<!-- Watercolor product card: paper surface, wash accent, serif -->
<div class="wash-card">
  <span class="wash-kicker">Campaign</span>
  <h3 class="wash-title">Summer Launch — Soundcore Q45</h3>
  <span class="wash-badge">3 posts scheduled</span>
</div>
```

## 8. Acceptance checklist

- [ ] No raw hex outside the token block; all brand colors resolve from tokens.
- [ ] All numeric values use `tabular-nums`.
- [ ] Every interactive element has a visible focus state using `--border-focus`.
- [ ] Status badges use the fixed status colors + text label.
- [ ] Both modes render correctly (`data-theme` toggle) and meet AA contrast.
- [ ] Card/button treatment matches the signature: border: 1px solid; border-radius: 1rem 1rem 1rem 0.25rem; box-shadow: 0 12px 40px rgba(80, 60, 40, 0.12);
