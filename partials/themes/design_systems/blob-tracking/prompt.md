# Design System: Blob Tracking

Use this design system as the complete visual language for this project. It is
one self-consistent "look": a 19-token color contract, typography, radii/border
treatment, component patterns, and motion language. Implement the UI against
these tokens — do not invent colors, shadows, or type styles.

- **Slug:** `blob-tracking`
- **Mode:** native dark theme (light counterpart included)
- **Vibe:** Computer-vision motion detection — soft amorphous blobs of color drift over a dark feed, tagged with bounding boxes and confidence labels like `person 0.97`.
- **Best for:** Creator Studio and campaign overviews — content clusters as detectable “blobs” moving through the feed.
- **Adjectives:** organic, analytical, fluid
- **Signature detail:** Corner tracking brackets + drifting blob washes + mono confidence labels — the feed is always watching, always labeling.
- **Motion:** Organic and fluid: 250-400ms ease-in-out; blobs drift on 8-20s loops; entries soften in (opacity + blur 4px→0). Nothing moves linearly — everything eases like matter.

## Source of truth

This is a personal, local design-system library (private, not published).

- Repo on disk: `~/dev/design_systems` (private GitHub mirror: https://github.com/DevinTobiasColebrooke/design_systems)
- This system's folder: `systems/blob-tracking/`
- Machine-readable spec (tokens, fonts, schemas): `systems/blob-tracking/system.json`
- Drop-in Tailwind v4 theme file: `systems/blob-tracking/tailwind.css`
- Full component showcase: `systems/blob-tracking/showcase.html` (open in a browser)

If you have filesystem access, read those files. If you don't, everything you
need is inline below.

## 1. The 19-token contract

Every value below is authoritative. Tokens map 1:1 to CSS custom properties
(`bg-canvas` style) and to Tailwind `brand-*` utilities
(`bg-brand-canvas`, `text-brand-action`, ...). Use tokens everywhere; never use a raw hex
outside this block.

| Token | Native (dark) | Light mode | Usage |
|---|---|---|---|
| `--bg-canvas` | `#050807` | `#eef4f0` | Deepest background layer |
| `--bg-surface` | `#0d1512` | `#ffffff` | Cards, Sidebars, Panes |
| `--bg-surface-elevated` | `#152220` | `#e0eee7` | Dropdowns, hovered states |
| `--border-subtle` | `#1e332c` | `#cfe2d8` | Very light separation |
| `--border-default` | `#2e4f42` | `#93bfa8` | Standard card/form borders |
| `--border-focus` | `#5cffb0` | `#0f8a52` | Focus states |
| `--text-primary` | `#eafff4` | `#0a2016` | High contrast title/text |
| `--text-secondary` | `#b2d8c6` | `#38584a` | Standard body paragraph |
| `--text-muted` | `#6a9482` | `#6a887a` | Descriptions, helper text, dates |
| `--color-action` | `#5cffb0` | `#0f8a52` | Primary action |
| `--color-action-hover` | `#3fe596` | `#0c7244` | Action hover |
| `--color-earnings` | `#ffe45c` | `#9a7400` | Earnings, Revenue, Profit |
| `--color-earnings-hover` | `#e6c93f` | `#806000` | Earnings hover |
| `--color-automation` | `#5cc8ff` | `#0a7ab8` | Playwright, AI, Terminal accents |
| `--color-alert` | `#ffb54a` | `#b45309` | Warnings, pending states |
| `--color-danger` | `#ff5c7a` | `#c42a54` | Error, failed status, deletes |
| `--color-action-glow` | `rgba(92, 255, 176, 0.18)` | `rgba(15, 138, 82, 0.14)` | Halo behind action icons |
| `--color-earnings-glow` | `rgba(255, 228, 92, 0.16)` | `rgba(154, 116, 0, 0.12)` | Halo behind earnings icons |
| `--color-automation-glow` | `rgba(92, 200, 255, 0.16)` | `rgba(10, 122, 184, 0.12)` | Halo behind automation icons |

### Tailwind CSS v4 setup

```css
@import "tailwindcss";

:root {
  --bg-canvas: #050807;
  --bg-surface: #0d1512;
  --bg-surface-elevated: #152220;
  --border-subtle: #1e332c;
  --border-default: #2e4f42;
  --border-focus: #5cffb0;
  --text-primary: #eafff4;
  --text-secondary: #b2d8c6;
  --text-muted: #6a9482;
  --color-action: #5cffb0;
  --color-action-hover: #3fe596;
  --color-earnings: #ffe45c;
  --color-earnings-hover: #e6c93f;
  --color-automation: #5cc8ff;
  --color-alert: #ffb54a;
  --color-danger: #ff5c7a;
  --color-action-glow: rgba(92, 255, 176, 0.18);
  --color-earnings-glow: rgba(255, 228, 92, 0.16);
  --color-automation-glow: rgba(92, 200, 255, 0.16);
  --action-label: #0d0d12; /* readable text color on --color-action fills */
}

[data-theme="light"] {
  --bg-canvas: #eef4f0;
  --bg-surface: #ffffff;
  --bg-surface-elevated: #e0eee7;
  --border-subtle: #cfe2d8;
  --border-default: #93bfa8;
  --border-focus: #0f8a52;
  --text-primary: #0a2016;
  --text-secondary: #38584a;
  --text-muted: #6a887a;
  --color-action: #0f8a52;
  --color-action-hover: #0c7244;
  --color-earnings: #9a7400;
  --color-earnings-hover: #806000;
  --color-automation: #0a7ab8;
  --color-alert: #b45309;
  --color-danger: #c42a54;
  --color-action-glow: rgba(15, 138, 82, 0.14);
  --color-earnings-glow: rgba(154, 116, 0, 0.12);
  --color-automation-glow: rgba(10, 122, 184, 0.12);
  --action-label: #ffffff;
}

@theme {
  --font-display: "Space Grotesk", sans-serif;
  --font-sans: "Inter", system-ui, sans-serif;
  --font-mono: "JetBrains Mono", monospace;

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

Equivalent guide: **the full drop-in file is `~/dev/design_systems/systems/blob-tracking/tailwind.css`** — copy it to
`app/assets/tailwind/design_system.css` and `@import` it from `application.css`.

## 2. Color schemas (optional accent swaps)

These override accents on top of either mode palette. Apply as a class/attribute
that re-declares the listed tokens (everything else stays from the mode palette).

### `heatmap` — Heatmap

Jet-heatmap accents with electric blue secondary; use white bold labels on hot fills.

| Token | Value |
|---|---|
| `--color-action` | `#e05c2a` |
| `--color-action-hover` | `#c44a1c` |
| `--color-earnings` | `#e0b02a` |
| `--color-earnings-hover` | `#c4961c` |
| `--color-automation` | `#3a5ce0` |
| `--color-alert` | `#b45309` |
| `--color-danger` | `#c42a54` |
| `--border-focus` | `#e05c2a` |
| `--color-action-glow` | `rgba(224, 92, 42, 0.16)` |
| `--color-earnings-glow` | `rgba(224, 176, 42, 0.14)` |
| `--color-automation-glow` | `rgba(58, 92, 224, 0.16)` |
### `thermal-cyan` — Thermal Cyan

Cool cyan tracks with violet secondary; use dark ink labels on cyan.

| Token | Value |
|---|---|
| `--color-action` | `#2ab8c4` |
| `--color-action-hover` | `#219aa4` |
| `--color-earnings` | `#9a7400` |
| `--color-earnings-hover` | `#806000` |
| `--color-automation` | `#7a5ce0` |
| `--color-alert` | `#b45309` |
| `--color-danger` | `#c42a54` |
| `--border-focus` | `#2ab8c4` |
| `--color-action-glow` | `rgba(42, 184, 196, 0.16)` |
| `--color-earnings-glow` | `rgba(154, 116, 0, 0.12)` |
| `--color-automation-glow` | `rgba(122, 92, 224, 0.16)` |
## 3. Typography

- **Display** (headings, KPIs, big numbers): `"Space Grotesk", sans-serif`
- **Sans** (body, labels, UI): `"Inter", system-ui, sans-serif`
- **Mono** (timestamps, IDs, code, logs): `"JetBrains Mono", monospace`
- Load the families with the project's normal Google Fonts `<link>` (weights 500-800 for display/sans).

Hard rules:

- Every number (earnings, rates, counts, dates, timers) uses `tabular-nums`.
- Headings/eyebrows use tight tracking; micro-labels are uppercase `text-[10px] tracking-wider`.
- Body text at `text-sm`/`text-xs` for dense operational screens.

## 4. Radii, borders & signature treatment

- Card signature: `border: 1px solid var(--border-default); border-radius: 0.5rem;`
- Canvas/texture signature: `background-image: radial-gradient(circle at 20% 30%, rgba(92, 255, 176, 0.08), transparent 50%), radial-gradient(circle at 80% 70%, rgba(92, 200, 255, 0.08), transparent 50%);`
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
5. Motion: Organic and fluid: 250-400ms ease-in-out; blobs drift on 8-20s loops; entries soften in (opacity + blur 4px→0). Nothing moves linearly — everything eases like matter.. Respect `prefers-reduced-motion`.
6. Touch targets ≥ 44px on mobile; inline form errors with `aria-live="polite"`.
7. Dark/light: `data-theme="light"` on `<html>` flips to the counterpart palette.

## 7. Full source spec (component patterns, motion, snippet)

### PROPOSAL-22 — Blob Tracking

- **slug**: `blob-tracking`
- **Vibe**: Computer-vision motion detection — soft amorphous blobs of color drift over a dark feed, tagged with bounding boxes and confidence labels like `person 0.97`.
- **Best for**: Creator Studio and campaign overviews — content clusters as detectable "blobs" moving through the feed. Adjectives: organic, analytical, fluid.
- **Palette** (dark theme, `is_dark: true`):

| Token | Value | Usage |
|---|---|---|
| `--bg-canvas` | `#050807` | Camera-feed black-green |
| `--bg-surface` | `#0d1512` | Feed panel fill |
| `--bg-surface-elevated` | `#152220` | Tracked-region highlight fill |
| `--border-subtle` | `#1e332c` | Faint grid hairlines |
| `--border-default` | `#2e4f42` | Detection-box borders |
| `--border-focus` | `#5cffb0` | Tracker-lock focus outline |
| `--text-primary` | `#eafff4` | Bright label text |
| `--text-secondary` | `#b2d8c6` | Body text |
| `--text-muted` | `#6a9482` | Feed-noise dim text |
| `--color-action` | `#5cffb0` | Tracker-green primary |
| `--color-action-hover` | `#3fe596` | Action hover (deeper green) |
| `--color-earnings` | `#ffe45c` | High-confidence yellow tag |
| `--color-earnings-hover` | `#e6c93f` | Earnings hover (deeper yellow) |
| `--color-automation` | `#5cc8ff` | Secondary-track cyan |
| `--color-alert` | `#ffb54a` | Motion-detected amber |
| `--color-danger` | `#ff5c7a` | Track-lost red |
| `--color-action-glow` | `rgba(92, 255, 176, 0.18)` | Tracker bloom |
| `--color-earnings-glow` | `rgba(255, 228, 92, 0.16)` | Tag bloom |
| `--color-automation-glow` | `rgba(92, 200, 255, 0.16)` | Cyan bloom |

- **Typography**: CV-overlay labeling. Display: `"Space Grotesk", sans-serif` at 600. Body: `"Inter", system-ui, sans-serif`. Mono: `"JetBrains Mono", monospace` for confidence scores and IDs — every blob gets a label like `earnings_blob 0.97`. Uppercase micro-labels on boxes. KPIs `tabular-nums`.
- **Radii & Borders**: Detection-box language: 2px radius on chips and boxes, cards `rounded-lg`. Borders 1px; tracked items get corner brackets (like camera focus brackets) instead of full outlines.
- **Component Patterns**:
  - **Buttons**: Soft rounded fills with a 1px border; primary = tracker-green with dark text. Hover = corner brackets appear around the button (tracking acquired). Focus = 2px outline.
  - **Cards**: Panels with soft blob-wash backgrounds (large radial gradients of action/automation glow at 6-10% opacity drifting slowly via CSS animation). Active cards get corner brackets + a mono confidence label.
  - **Badges/Status**: Tag chips like CV labels: `PUBLISHED 0.98`, `FAILED 0.02`, `RUNNING …` — colored border, dark fill, mono confidence. Dot pulses when a track is live.
  - **Tables**: Rows are "tracks": hover locks the row (corner brackets + brighter fill); a small mono trail of dots (motion trail) follows the hover across columns.
  - **Forms/Inputs**: Rounded fields, 1px borders; focus = tracker-lock border + brackets. Placeholder text dimmed like feed noise.
  - **Loading**: Blobs wander: 2-3 soft radial-gradient shapes drift and morph (border-radius animation) until content arrives; determinate = blob shrinking onto its target box.
  - **Signature detail**: Corner tracking brackets + drifting blob washes + mono confidence labels — the feed is always watching, always labeling.
- **Motion & Animation**: Organic and fluid: 250-400ms ease-in-out; blobs drift on 8-20s loops; entries soften in (opacity + blur 4px -> 0). Nothing moves linearly — everything eases like matter.
- **Signature Preview Snippet**:

```html
<!-- Blob-tracked KPI: corner brackets + confidence label -->
<div class="blob-card">
  <div class="blob-brackets"></div>
  <span class="blob-label">EARNINGS_BLOB 0.97</span>
  <strong class="blob-kpi">$12,480.50</strong>
</div>
```

## 8. Acceptance checklist

- [ ] No raw hex outside the token block; all brand colors resolve from tokens.
- [ ] All numeric values use `tabular-nums`.
- [ ] Every interactive element has a visible focus state using `--border-focus`.
- [ ] Status badges use the fixed status colors + text label.
- [ ] Both modes render correctly (`data-theme` toggle) and meet AA contrast.
- [ ] Card/button treatment matches the signature: border: 1px solid var(--border-default); border-radius: 0.5rem;
