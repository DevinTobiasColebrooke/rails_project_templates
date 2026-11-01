# Design System: Nordic Minimal

Use this design system as the complete visual language for this project. It is
one self-consistent "look": a 19-token color contract, typography, radii/border
treatment, component patterns, and motion language. Implement the UI against
these tokens — do not invent colors, shadows, or type styles.

- **Slug:** `nordic-minimal`
- **Mode:** native light theme (dark counterpart included)
- **Vibe:** Scandinavian calm — near-white, soft stone grays, a muted deep blue, and airy spacing; quiet and precise.
- **Best for:** Settings, user flows, and daily overview screens — calm surfaces that let numbers breathe.
- **Adjectives:** calm, precise, airy
- **Signature detail:** The calm itself — muted deep blue on near-white, hairline separators, and generous air; nothing demands attention twice.
- **Motion:** Slow and calm — 300ms ease-out; elements fade in with a 4px upward drift; transitions feel automatic.

## Source of truth

This is a personal, local design-system library (private, not published).

- Repo on disk: `~/dev/design_systems` (private GitHub mirror: https://github.com/DevinTobiasColebrooke/design_systems)
- This system's folder: `systems/nordic-minimal/`
- Machine-readable spec (tokens, fonts, schemas): `systems/nordic-minimal/system.json`
- Drop-in Tailwind v4 theme file: `systems/nordic-minimal/tailwind.css`
- Full component showcase: `systems/nordic-minimal/showcase.html` (open in a browser)

If you have filesystem access, read those files. If you don't, everything you
need is inline below.

## 1. The 19-token contract

Every value below is authoritative. Tokens map 1:1 to CSS custom properties
(`bg-canvas` style) and to Tailwind `brand-*` utilities
(`bg-brand-canvas`, `text-brand-action`, ...). Use tokens everywhere; never use a raw hex
outside this block.

| Token | Native (light) | Dark mode | Usage |
|---|---|---|---|
| `--bg-canvas` | `#f6f6f4` | `#14181f` | Deepest background layer |
| `--bg-surface` | `#ffffff` | `#1b2029` | Cards, Sidebars, Panes |
| `--bg-surface-elevated` | `#ececea` | `#242b36` | Dropdowns, hovered states |
| `--border-subtle` | `#e2e2de` | `#2d3542` | Very light separation |
| `--border-default` | `#c9c9c4` | `#3d4756` | Standard card/form borders |
| `--border-focus` | `#3d5a80` | `#6f95c9` | Focus states |
| `--text-primary` | `#1d2733` | `#eef1f5` | High contrast title/text |
| `--text-secondary` | `#47505c` | `#c3cad4` | Standard body paragraph |
| `--text-muted` | `#6d7580` | `#8a94a3` | Descriptions, helper text, dates |
| `--color-action` | `#3d5a80` | `#5b80a8` | Primary action |
| `--color-action-hover` | `#324a6b` | `#4c6d92` | Action hover |
| `--color-earnings` | `#3e7a5a` | `#7cb08d` | Earnings, Revenue, Profit |
| `--color-earnings-hover` | `#336549` | `#66977a` | Earnings hover |
| `--color-automation` | `#5b748f` | `#7a93af` | Playwright, AI, Terminal accents |
| `--color-alert` | `#b08a3e` | `#c9a15e` | Warnings, pending states |
| `--color-danger` | `#b3543f` | `#c06a56` | Error, failed status, deletes |
| `--color-action-glow` | `rgba(61, 90, 128, 0.10)` | `rgba(91, 128, 168, 0.12)` | Halo behind action icons |
| `--color-earnings-glow` | `rgba(62, 122, 90, 0.10)` | `rgba(124, 176, 141, 0.10)` | Halo behind earnings icons |
| `--color-automation-glow` | `rgba(91, 116, 143, 0.10)` | `rgba(122, 147, 175, 0.10)` | Halo behind automation icons |

### Tailwind CSS v4 setup

```css
@import "tailwindcss";

:root {
  --bg-canvas: #f6f6f4;
  --bg-surface: #ffffff;
  --bg-surface-elevated: #ececea;
  --border-subtle: #e2e2de;
  --border-default: #c9c9c4;
  --border-focus: #3d5a80;
  --text-primary: #1d2733;
  --text-secondary: #47505c;
  --text-muted: #6d7580;
  --color-action: #3d5a80;
  --color-action-hover: #324a6b;
  --color-earnings: #3e7a5a;
  --color-earnings-hover: #336549;
  --color-automation: #5b748f;
  --color-alert: #b08a3e;
  --color-danger: #b3543f;
  --color-action-glow: rgba(61, 90, 128, 0.10);
  --color-earnings-glow: rgba(62, 122, 90, 0.10);
  --color-automation-glow: rgba(91, 116, 143, 0.10);
  --action-label: #ffffff; /* readable text color on --color-action fills */
}

[data-theme="dark"] {
  --bg-canvas: #14181f;
  --bg-surface: #1b2029;
  --bg-surface-elevated: #242b36;
  --border-subtle: #2d3542;
  --border-default: #3d4756;
  --border-focus: #6f95c9;
  --text-primary: #eef1f5;
  --text-secondary: #c3cad4;
  --text-muted: #8a94a3;
  --color-action: #5b80a8;
  --color-action-hover: #4c6d92;
  --color-earnings: #7cb08d;
  --color-earnings-hover: #66977a;
  --color-automation: #7a93af;
  --color-alert: #c9a15e;
  --color-danger: #c06a56;
  --color-action-glow: rgba(91, 128, 168, 0.12);
  --color-earnings-glow: rgba(124, 176, 141, 0.10);
  --color-automation-glow: rgba(122, 147, 175, 0.10);
  --action-label: #0d0d12;
}

@theme {
  --font-display: "Inter Tight", "Inter", sans-serif;
  --font-sans: "Inter", system-ui, sans-serif;
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

Equivalent guide: **the full drop-in file is `~/dev/design_systems/systems/nordic-minimal/tailwind.css`** — copy it to
`app/assets/tailwind/design_system.css` and `@import` it from `application.css`.

## 2. Color schemas (optional accent swaps)

These override accents on top of either mode palette. Apply as a class/attribute
that re-declares the listed tokens (everything else stays from the mode palette).

### `fjord-blue` — Fjord Blue

Deeper blue-led calm; use white bold labels on blue.

| Token | Value |
|---|---|
| `--color-action` | `#3d7ab5` |
| `--color-action-hover` | `#33648f` |
| `--color-earnings` | `#7cb08d` |
| `--color-earnings-hover` | `#66977a` |
| `--color-automation` | `#7a93af` |
| `--color-alert` | `#c9a15e` |
| `--color-danger` | `#c06a56` |
| `--border-focus` | `#3d7ab5` |
| `--color-action-glow` | `rgba(61, 122, 181, 0.14)` |
| `--color-earnings-glow` | `rgba(124, 176, 141, 0.10)` |
| `--color-automation-glow` | `rgba(122, 147, 175, 0.10)` |
### `stone-sage` — Stone Sage

Sage-led northern calm; use white bold labels on sage.

| Token | Value |
|---|---|
| `--color-action` | `#7a9080` |
| `--color-action-hover` | `#64796c` |
| `--color-earnings` | `#7cb08d` |
| `--color-earnings-hover` | `#66977a` |
| `--color-automation` | `#7a93af` |
| `--color-alert` | `#c9a15e` |
| `--color-danger` | `#c06a56` |
| `--border-focus` | `#7a9080` |
| `--color-action-glow` | `rgba(122, 144, 128, 0.12)` |
| `--color-earnings-glow` | `rgba(124, 176, 141, 0.10)` |
| `--color-automation-glow` | `rgba(122, 147, 175, 0.10)` |
## 3. Typography

- **Display** (headings, KPIs, big numbers): `"Inter Tight", "Inter", sans-serif`
- **Sans** (body, labels, UI): `"Inter", system-ui, sans-serif`
- **Mono** (timestamps, IDs, code, logs): `"IBM Plex Mono", ui-monospace, monospace`
- Load the families with the project's normal Google Fonts `<link>` (weights 500-800 for display/sans).

Hard rules:

- Every number (earnings, rates, counts, dates, timers) uses `tabular-nums`.
- Headings/eyebrows use tight tracking; micro-labels are uppercase `text-[10px] tracking-wider`.
- Body text at `text-sm`/`text-xs` for dense operational screens.

## 4. Radii, borders & signature treatment

- Card signature: `border: 1px solid var(--border-default); border-radius: 12px; box-shadow: 0 1px 3px rgba(29, 39, 51, 0.06);`
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
5. Motion: Slow and calm — 300ms ease-out; elements fade in with a 4px upward drift; transitions feel automatic.. Respect `prefers-reduced-motion`.
6. Touch targets ≥ 44px on mobile; inline form errors with `aria-live="polite"`.
7. Dark/light: `data-theme="dark"` on `<html>` flips to the counterpart palette.

## 7. Full source spec (component patterns, motion, snippet)

### PROPOSAL-15 — Nordic Minimal

- **slug**: `nordic-minimal`
- **Vibe**: Scandinavian calm — near-white, soft stone grays, a muted deep blue, and airy spacing; quiet and precise.
- **Best for**: Settings, user flows, and daily overview screens — calm surfaces that let numbers breathe. Adjectives: calm, precise, airy.
- **Palette** (light theme, `is_dark: false`):

| Token | Value | Usage |
|---|---|---|
| `--bg-canvas` | `#f6f6f4` | Near-white stone canvas |
| `--bg-surface` | `#ffffff` | Card and panel fill |
| `--bg-surface-elevated` | `#ececea` | Hover/raised surfaces |
| `--border-subtle` | `#e2e2de` | Fine hairline separators |
| `--border-default` | `#c9c9c4` | Standard stone borders |
| `--border-focus` | `#3d5a80` | Muted deep-blue focus |
| `--text-primary` | `#1d2733` | Near-black blue headings |
| `--text-secondary` | `#47505c` | Body text |
| `--text-muted` | `#6d7580` | Captions, helper text |
| `--color-action` | `#3d5a80` | Muted deep-blue primary action |
| `--color-action-hover` | `#324a6b` | Action hover (darker blue) |
| `--color-earnings` | `#3e7a5a` | Muted spruce-green earnings |
| `--color-earnings-hover` | `#336549` | Earnings hover (deeper spruce) |
| `--color-automation` | `#5b748f` | Slate-blue automation accents |
| `--color-alert` | `#b08a3e` | Muted ochre warnings |
| `--color-danger` | `#b3543f` | Muted terracotta failed states |
| `--color-action-glow` | `rgba(61, 90, 128, 0.10)` | Blue tint behind action icons |
| `--color-earnings-glow` | `rgba(62, 122, 90, 0.10)` | Green tint behind earnings icons |
| `--color-automation-glow` | `rgba(91, 116, 143, 0.10)` | Slate tint behind automation icons |

- **Typography**: Display: `"Inter Tight", "Inter", sans-serif` at 600-700 with slight negative tracking — precise and neutral. Sans: `"Inter", system-ui, sans-serif`. Mono: `"IBM Plex Mono", ui-monospace, monospace` for timestamps and IDs. Numerals `tabular-nums`; labels quiet, sentence-case, `letter-spacing: 0`.
- **Radii & Borders**: Soft and quiet — cards 12px, buttons pill, inputs 10px. Borders are 1px hairlines (`--border-default`). Shadows are very soft or absent; spacing does the hierarchy work.
- **Component Patterns**:
  - **Buttons**: Soft pills; primary = muted blue fill with white text (AA, 6.5:1); secondary = white with 1px border; tertiary = text-only in blue. Focus = 2px `--border-focus` ring with a gap. Hover = 1px lift, no glow.
  - **Cards**: White with a 1px hairline border and a barely-there shadow (`0 1px 3px rgba(29, 39, 51, 0.06)`); generous internal padding. Hover raises the shadow one notch.
  - **Badges/Status**: Soft neutral pills with a small dot; publishing = slow-breathing blue dot; published = spruce dot; failed = terracotta dot. All muted, never saturated.
  - **Tables**: Hairline separators only, generous row padding, header in semibold small caps; row hover = `--bg-surface-elevated` wash.
  - **Forms/Inputs**: White fields with 1px border; focus = blue border. Labels sit above in secondary text; errors in terracotta below.
  - **Loading**: Three small muted dots; determinate = a thin soft progress bar.
  - **Signature detail**: The calm itself — muted deep blue on near-white, hairline separators, and generous air; nothing demands attention twice.
- **Motion & Animation**: Slow and calm — 300ms `ease-out`; elements fade in with a 4px upward drift. Transitions are so gentle they feel automatic; no bounce, no snap.
- **Signature Preview Snippet**:

```html
<!-- Nordic KPI: near-white, hairline border, quiet blue -->
<div class="nord-card">
  <span class="nord-label">Earnings</span>
  <strong class="nord-kpi">$12,480</strong>
  <span class="nord-delta">+14.2%</span>
</div>
```

## 8. Acceptance checklist

- [ ] No raw hex outside the token block; all brand colors resolve from tokens.
- [ ] All numeric values use `tabular-nums`.
- [ ] Every interactive element has a visible focus state using `--border-focus`.
- [ ] Status badges use the fixed status colors + text label.
- [ ] Both modes render correctly (`data-theme` toggle) and meet AA contrast.
- [ ] Card/button treatment matches the signature: border: 1px solid var(--border-default); border-radius: 12px; box-shadow: 0 1px 3px rgba(29, 39, 51, 0.06);
