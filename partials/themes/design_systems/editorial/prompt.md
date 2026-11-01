# Design System: Editorial Magazine

Use this design system as the complete visual language for this project. It is
one self-consistent "look": a 19-token color contract, typography, radii/border
treatment, component patterns, and motion language. Implement the UI against
these tokens — do not invent colors, shadows, or type styles.

- **Slug:** `editorial`
- **Mode:** native light theme (dark counterpart included)
- **Vibe:** High-fashion editorial print — ivory and ink, Didot-style serif display, a single red accent, and generous whitespace.
- **Best for:** Product show pages and monthly earnings reports — data presented like a magazine feature.
- **Adjectives:** refined, confident, print-like
- **Signature detail:** Oversized Didot-style serif numerals + 3px masthead rules + small-caps overlines floating in whitespace — a print feature, not an app.
- **Motion:** Quiet and print-like — 250ms ease-in-out; content reveals with a vertical "press" easing (clip from top).

## Source of truth

This is a personal, local design-system library (private, not published).

- Repo on disk: `~/dev/design_systems` (private GitHub mirror: https://github.com/DevinTobiasColebrooke/design_systems)
- This system's folder: `systems/editorial/`
- Machine-readable spec (tokens, fonts, schemas): `systems/editorial/system.json`
- Drop-in Tailwind v4 theme file: `systems/editorial/tailwind.css`
- Full component showcase: `systems/editorial/showcase.html` (open in a browser)

If you have filesystem access, read those files. If you don't, everything you
need is inline below.

## 1. The 19-token contract

Every value below is authoritative. Tokens map 1:1 to CSS custom properties
(`bg-canvas` style) and to Tailwind `brand-*` utilities
(`bg-brand-canvas`, `text-brand-action`, ...). Use tokens everywhere; never use a raw hex
outside this block.

| Token | Native (light) | Dark mode | Usage |
|---|---|---|---|
| `--bg-canvas` | `#faf8f3` | `#101010` | Deepest background layer |
| `--bg-surface` | `#ffffff` | `#181818` | Cards, Sidebars, Panes |
| `--bg-surface-elevated` | `#f3efe6` | `#222222` | Dropdowns, hovered states |
| `--border-subtle` | `#e2dccd` | `#2e2e2e` | Very light separation |
| `--border-default` | `#c4bba8` | `#4a4a4a` | Standard card/form borders |
| `--border-focus` | `#c8102e` | `#ff3350` | Focus states |
| `--text-primary` | `#111111` | `#f5f2ea` | High contrast title/text |
| `--text-secondary` | `#3d3d3d` | `#c9c5ba` | Standard body paragraph |
| `--text-muted` | `#6f6857` | `#8f8b80` | Descriptions, helper text, dates |
| `--color-action` | `#c8102e` | `#df2c34` | Primary action |
| `--color-action-hover` | `#a50d25` | `#bf2229` | Action hover |
| `--color-earnings` | `#0f6b3a` | `#2f9d5e` | Earnings, Revenue, Profit |
| `--color-earnings-hover` | `#0c5730` | `#27844f` | Earnings hover |
| `--color-automation` | `#1f3a6e` | `#6f8fc8` | Playwright, AI, Terminal accents |
| `--color-alert` | `#a86f1f` | `#b8860b` | Warnings, pending states |
| `--color-danger` | `#8f1022` | `#c0283c` | Error, failed status, deletes |
| `--color-action-glow` | `rgba(200, 16, 46, 0.10)` | `rgba(223, 44, 52, 0.14)` | Halo behind action icons |
| `--color-earnings-glow` | `rgba(15, 107, 58, 0.10)` | `rgba(47, 157, 94, 0.12)` | Halo behind earnings icons |
| `--color-automation-glow` | `rgba(31, 58, 110, 0.10)` | `rgba(111, 143, 200, 0.12)` | Halo behind automation icons |

### Tailwind CSS v4 setup

```css
@import "tailwindcss";

:root {
  --bg-canvas: #faf8f3;
  --bg-surface: #ffffff;
  --bg-surface-elevated: #f3efe6;
  --border-subtle: #e2dccd;
  --border-default: #c4bba8;
  --border-focus: #c8102e;
  --text-primary: #111111;
  --text-secondary: #3d3d3d;
  --text-muted: #6f6857;
  --color-action: #c8102e;
  --color-action-hover: #a50d25;
  --color-earnings: #0f6b3a;
  --color-earnings-hover: #0c5730;
  --color-automation: #1f3a6e;
  --color-alert: #a86f1f;
  --color-danger: #8f1022;
  --color-action-glow: rgba(200, 16, 46, 0.10);
  --color-earnings-glow: rgba(15, 107, 58, 0.10);
  --color-automation-glow: rgba(31, 58, 110, 0.10);
  --action-label: #ffffff; /* readable text color on --color-action fills */
}

[data-theme="dark"] {
  --bg-canvas: #101010;
  --bg-surface: #181818;
  --bg-surface-elevated: #222222;
  --border-subtle: #2e2e2e;
  --border-default: #4a4a4a;
  --border-focus: #ff3350;
  --text-primary: #f5f2ea;
  --text-secondary: #c9c5ba;
  --text-muted: #8f8b80;
  --color-action: #df2c34;
  --color-action-hover: #bf2229;
  --color-earnings: #2f9d5e;
  --color-earnings-hover: #27844f;
  --color-automation: #6f8fc8;
  --color-alert: #b8860b;
  --color-danger: #c0283c;
  --color-action-glow: rgba(223, 44, 52, 0.14);
  --color-earnings-glow: rgba(47, 157, 94, 0.12);
  --color-automation-glow: rgba(111, 143, 200, 0.12);
  --action-label: #ffffff;
}

@theme {
  --font-display: "Bodoni Moda", "Playfair Display", Georgia, serif;
  --font-sans: "Inter", "Archivo", system-ui, sans-serif;
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

Equivalent guide: **the full drop-in file is `~/dev/design_systems/systems/editorial/tailwind.css`** — copy it to
`app/assets/tailwind/design_system.css` and `@import` it from `application.css`.

## 2. Color schemas (optional accent swaps)

These override accents on top of either mode palette. Apply as a class/attribute
that re-declares the listed tokens (everything else stays from the mode palette).

### `bold-black` — Bold Black

Ink-black-led with ivory type; pure print contrast, white labels.

| Token | Value |
|---|---|
| `--color-action` | `#141414` |
| `--color-action-hover` | `#333333` |
| `--color-earnings` | `#2f9d5e` |
| `--color-earnings-hover` | `#27844f` |
| `--color-automation` | `#6f8fc8` |
| `--color-alert` | `#b8860b` |
| `--color-danger` | `#c0283c` |
| `--border-focus` | `#141414` |
| `--color-action-glow` | `rgba(20, 20, 20, 0.16)` |
| `--color-earnings-glow` | `rgba(47, 157, 94, 0.12)` |
| `--color-automation-glow` | `rgba(111, 143, 200, 0.12)` |
### `ink-blue` — Ink Blue

Navy-led editorial with red automation; use white bold labels on navy.

| Token | Value |
|---|---|
| `--color-action` | `#1f3a6e` |
| `--color-action-hover` | `#162c54` |
| `--color-earnings` | `#2f9d5e` |
| `--color-earnings-hover` | `#27844f` |
| `--color-automation` | `#df2c34` |
| `--color-alert` | `#b8860b` |
| `--color-danger` | `#c0283c` |
| `--border-focus` | `#1f3a6e` |
| `--color-action-glow` | `rgba(31, 58, 110, 0.14)` |
| `--color-earnings-glow` | `rgba(47, 157, 94, 0.12)` |
| `--color-automation-glow` | `rgba(223, 44, 52, 0.12)` |
## 3. Typography

- **Display** (headings, KPIs, big numbers): `"Bodoni Moda", "Playfair Display", Georgia, serif`
- **Sans** (body, labels, UI): `"Inter", "Archivo", system-ui, sans-serif`
- **Mono** (timestamps, IDs, code, logs): `"IBM Plex Mono", ui-monospace, monospace`
- Load the families with the project's normal Google Fonts `<link>` (weights 500-800 for display/sans).

Hard rules:

- Every number (earnings, rates, counts, dates, timers) uses `tabular-nums`.
- Headings/eyebrows use tight tracking; micro-labels are uppercase `text-[10px] tracking-wider`.
- Body text at `text-sm`/`text-xs` for dense operational screens.

## 4. Radii, borders & signature treatment

- Card signature: `border: 1px solid var(--border-default); border-radius: 0; border-top: 3px solid var(--color-action);`
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
5. Motion: Quiet and print-like — 250ms ease-in-out; content reveals with a vertical "press" easing (clip from top).. Respect `prefers-reduced-motion`.
6. Touch targets ≥ 44px on mobile; inline form errors with `aria-live="polite"`.
7. Dark/light: `data-theme="dark"` on `<html>` flips to the counterpart palette.

## 7. Full source spec (component patterns, motion, snippet)

### PROPOSAL-14 — Editorial Magazine

- **slug**: `editorial`
- **Vibe**: High-fashion editorial print — ivory and ink, Didot-style serif display, a single red accent, and generous whitespace.
- **Best for**: Product show pages and monthly earnings reports — data presented like a magazine feature. Adjectives: refined, confident, print-like.
- **Palette** (light theme, `is_dark: false`):

| Token | Value | Usage |
|---|---|---|
| `--bg-canvas` | `#faf8f3` | Ivory paper canvas |
| `--bg-surface` | `#ffffff` | Card and panel fill |
| `--bg-surface-elevated` | `#f3efe6` | Raised/hover paper |
| `--border-subtle` | `#e2dccd` | Fine hairline rules |
| `--border-default` | `#c4bba8` | Standard print borders |
| `--border-focus` | `#c8102e` | Editorial-red focus rule |
| `--text-primary` | `#111111` | Ink-black headings |
| `--text-secondary` | `#3d3d3d` | Body text |
| `--text-muted` | `#6f6857` | Captions, bylines, fine print |
| `--color-action` | `#c8102e` | Editorial-red primary action |
| `--color-action-hover` | `#a50d25` | Action hover (deeper red) |
| `--color-earnings` | `#0f6b3a` | Deep-print-green earnings |
| `--color-earnings-hover` | `#0c5730` | Earnings hover (deeper green) |
| `--color-automation` | `#1f3a6e` | Print-navy automation accents |
| `--color-alert` | `#a86f1f` | Ochre warnings |
| `--color-danger` | `#8f1022` | Dark-red destructive states |
| `--color-action-glow` | `rgba(200, 16, 46, 0.10)` | Red tint behind action icons |
| `--color-earnings-glow` | `rgba(15, 107, 58, 0.10)` | Green tint behind earnings icons |
| `--color-automation-glow` | `rgba(31, 58, 110, 0.10)` | Navy tint behind automation icons |

- **Typography**: Display: `"Bodoni Moda", "Playfair Display", Georgia, serif` — Didot-style high-contrast serif for KPI numerals and mastheads, 600-800 weight, tight leading. Sans: `"Inter", "Archivo", system-ui, sans-serif` for UI labels and body. Mono: `"IBM Plex Mono", ui-monospace, monospace` for prices, timestamps, and fine print. Overlines in uppercase sans with `letter-spacing: 0.14em`.
- **Radii & Borders**: Sharp — `border-radius: 0`. Borders are hairline 1px rules; the masthead rule under headings is 3-4px. Dividers are thin rules with generous padding above and below.
- **Component Patterns**:
  - **Buttons**: Sharp rectangles, uppercase sans labels with wide tracking. Primary = red block with white text (AA-large); secondary = hairline-outlined ink; tertiary = text-only with a red underline. Focus = red underline rule.
  - **Cards**: White with a hairline border, oversized display numeral, small-caps overline, and a thin masthead rule at top; padding is generous (`p-8`+). Hover = subtle paper lift (2px), never a glow.
  - **Badges/Status**: Small-caps italic labels or a tiny red square bullet; publishing = pulsing red dot; published = deep green dot.
  - **Tables**: Magazine spread style — hairlines, generous row height, oversized tabular serif numerals; header row in small caps. Row hover = red hairline above/below.
  - **Forms/Inputs**: Baseline-only fields with a hairline rule; focus = red baseline. Labels in small caps.
  - **Loading**: An elegant red dot pulse ("stand by"); determinate = a thin hairline progress rule.
  - **Signature detail**: Oversized Didot-style serif numerals + 3px masthead rules + small-caps overlines floating in whitespace — a print feature, not an app.
- **Motion & Animation**: Quiet and print-like — 250ms `ease-in-out`; content reveals with a vertical "press" easing (clip from top). Nothing bounces; hover shifts are almost imperceptible.
- **Signature Preview Snippet**:

```html
<!-- Editorial masthead KPI: hairline rules, oversized serif numeral -->
<div class="edit-card">
  <span class="edit-overline">EARNINGS · THIS MONTH</span>
  <strong class="edit-kpi">$8,240</strong>
  <span class="edit-byline">+22% vs. July 2026</span>
</div>
```

## 8. Acceptance checklist

- [ ] No raw hex outside the token block; all brand colors resolve from tokens.
- [ ] All numeric values use `tabular-nums`.
- [ ] Every interactive element has a visible focus state using `--border-focus`.
- [ ] Status badges use the fixed status colors + text label.
- [ ] Both modes render correctly (`data-theme` toggle) and meet AA contrast.
- [ ] Card/button treatment matches the signature: border: 1px solid var(--border-default); border-radius: 0; border-top: 3px solid var(--color-action);
