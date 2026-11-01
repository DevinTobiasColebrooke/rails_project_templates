# Design System: Depth Map

Use this design system as the complete visual language for this project. It is
one self-consistent "look": a 19-token color contract, typography, radii/border
treatment, component patterns, and motion language. Implement the UI against
these tokens — do not invent colors, shadows, or type styles.

- **Slug:** `depth-map`
- **Mode:** native dark theme (light counterpart included)
- **Vibe:** A sensor's point-cloud view of the app — surfaces colored by distance, luminous cyan-to-magenta gradients marking near-to-far, wireframe contours on hover.
- **Best for:** Analytics dashboards and the shooting board — literal visual depth for information priority.
- **Adjectives:** technical, luminous, dimensional
- **Signature detail:** The cyan-near / magenta-far gradient language — priority is literally distance, and everything important glows closer.
- **Motion:** Smooth and parallax-minded: 200-300ms ease-out; elements “arrive from depth” (scale 0.96→1 + brightness 0.7→1). Hover lifts z; leaving settles back.

## Source of truth

This is a personal, local design-system library (private, not published).

- Repo on disk: `~/dev/design_systems` (private GitHub mirror: https://github.com/DevinTobiasColebrooke/design_systems)
- This system's folder: `systems/depth-map/`
- Machine-readable spec (tokens, fonts, schemas): `systems/depth-map/system.json`
- Drop-in Tailwind v4 theme file: `systems/depth-map/tailwind.css`
- Full component showcase: `systems/depth-map/showcase.html` (open in a browser)

If you have filesystem access, read those files. If you don't, everything you
need is inline below.

## 1. The 19-token contract

Every value below is authoritative. Tokens map 1:1 to CSS custom properties
(`bg-canvas` style) and to Tailwind `brand-*` utilities
(`bg-brand-canvas`, `text-brand-action`, ...). Use tokens everywhere; never use a raw hex
outside this block.

| Token | Native (dark) | Light mode | Usage |
|---|---|---|---|
| `--bg-canvas` | `#04070e` | `#e8f0f8` | Deepest background layer |
| `--bg-surface` | `#0a1120` | `#ffffff` | Cards, Sidebars, Panes |
| `--bg-surface-elevated` | `#111b33` | `#dbe8f4` | Dropdowns, hovered states |
| `--border-subtle` | `#1a2745` | `#c4d6e8` | Very light separation |
| `--border-default` | `#2a3c66` | `#93aed0` | Standard card/form borders |
| `--border-focus` | `#4ef0ff` | `#0087a8` | Focus states |
| `--text-primary` | `#e8f4ff` | `#0a1626` | High contrast title/text |
| `--text-secondary` | `#a8c4e8` | `#38485e` | Standard body paragraph |
| `--text-muted` | `#5c739c` | `#66788f` | Descriptions, helper text, dates |
| `--color-action` | `#4ef0ff` | `#0087a8` | Primary action |
| `--color-action-hover` | `#38d4e6` | `#006e8a` | Action hover |
| `--color-earnings` | `#ff9d4e` | `#b05f10` | Earnings, Revenue, Profit |
| `--color-earnings-hover` | `#e6843a` | `#944e0c` | Earnings hover |
| `--color-automation` | `#c44eff` | `#8a2bc4` | Playwright, AI, Terminal accents |
| `--color-alert` | `#ffd23c` | `#9a6d00` | Warnings, pending states |
| `--color-danger` | `#ff4e6a` | `#c42a48` | Error, failed status, deletes |
| `--color-action-glow` | `rgba(78, 240, 255, 0.18)` | `rgba(0, 135, 168, 0.16)` | Halo behind action icons |
| `--color-earnings-glow` | `rgba(255, 157, 78, 0.16)` | `rgba(176, 95, 16, 0.12)` | Halo behind earnings icons |
| `--color-automation-glow` | `rgba(196, 78, 255, 0.16)` | `rgba(138, 43, 196, 0.14)` | Halo behind automation icons |

### Tailwind CSS v4 setup

```css
@import "tailwindcss";

:root {
  --bg-canvas: #04070e;
  --bg-surface: #0a1120;
  --bg-surface-elevated: #111b33;
  --border-subtle: #1a2745;
  --border-default: #2a3c66;
  --border-focus: #4ef0ff;
  --text-primary: #e8f4ff;
  --text-secondary: #a8c4e8;
  --text-muted: #5c739c;
  --color-action: #4ef0ff;
  --color-action-hover: #38d4e6;
  --color-earnings: #ff9d4e;
  --color-earnings-hover: #e6843a;
  --color-automation: #c44eff;
  --color-alert: #ffd23c;
  --color-danger: #ff4e6a;
  --color-action-glow: rgba(78, 240, 255, 0.18);
  --color-earnings-glow: rgba(255, 157, 78, 0.16);
  --color-automation-glow: rgba(196, 78, 255, 0.16);
  --action-label: #0d0d12; /* readable text color on --color-action fills */
}

[data-theme="light"] {
  --bg-canvas: #e8f0f8;
  --bg-surface: #ffffff;
  --bg-surface-elevated: #dbe8f4;
  --border-subtle: #c4d6e8;
  --border-default: #93aed0;
  --border-focus: #0087a8;
  --text-primary: #0a1626;
  --text-secondary: #38485e;
  --text-muted: #66788f;
  --color-action: #0087a8;
  --color-action-hover: #006e8a;
  --color-earnings: #b05f10;
  --color-earnings-hover: #944e0c;
  --color-automation: #8a2bc4;
  --color-alert: #9a6d00;
  --color-danger: #c42a48;
  --color-action-glow: rgba(0, 135, 168, 0.16);
  --color-earnings-glow: rgba(176, 95, 16, 0.12);
  --color-automation-glow: rgba(138, 43, 196, 0.14);
  --action-label: #ffffff;
}

@theme {
  --font-display: "Space Grotesk", "Chakra Petch", sans-serif;
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

Equivalent guide: **the full drop-in file is `~/dev/design_systems/systems/depth-map/tailwind.css`** — copy it to
`app/assets/tailwind/design_system.css` and `@import` it from `application.css`.

## 2. Color schemas (optional accent swaps)

These override accents on top of either mode palette. Apply as a class/attribute
that re-declares the listed tokens (everything else stays from the mode palette).

### `thermal` — Thermal

Hot-metal thermal ramp with amber returns; use white bold labels on hot fills.

| Token | Value |
|---|---|
| `--color-action` | `#e04a2e` |
| `--color-action-hover` | `#c43e24` |
| `--color-earnings` | `#e0a02e` |
| `--color-earnings-hover` | `#c48a1f` |
| `--color-automation` | `#4a6ac4` |
| `--color-alert` | `#c47a1c` |
| `--color-danger` | `#a8321c` |
| `--border-focus` | `#e04a2e` |
| `--color-action-glow` | `rgba(224, 74, 46, 0.16)` |
| `--color-earnings-glow` | `rgba(224, 160, 46, 0.14)` |
| `--color-automation-glow` | `rgba(74, 106, 196, 0.14)` |
### `sonar` — Sonar

Monochrome-green sonar sweep; use white bold labels on the sweep green.

| Token | Value |
|---|---|
| `--color-action` | `#2ea86a` |
| `--color-action-hover` | `#238a54` |
| `--color-earnings` | `#8a6d00` |
| `--color-earnings-hover` | `#725800` |
| `--color-automation` | `#4a8a5c` |
| `--color-alert` | `#9a6d00` |
| `--color-danger` | `#b3261e` |
| `--border-focus` | `#2ea86a` |
| `--color-action-glow` | `rgba(46, 168, 106, 0.16)` |
| `--color-earnings-glow` | `rgba(138, 109, 0, 0.12)` |
| `--color-automation-glow` | `rgba(74, 138, 92, 0.12)` |
## 3. Typography

- **Display** (headings, KPIs, big numbers): `"Space Grotesk", "Chakra Petch", sans-serif`
- **Sans** (body, labels, UI): `"Inter", system-ui, sans-serif`
- **Mono** (timestamps, IDs, code, logs): `"JetBrains Mono", monospace`
- Load the families with the project's normal Google Fonts `<link>` (weights 500-800 for display/sans).

Hard rules:

- Every number (earnings, rates, counts, dates, timers) uses `tabular-nums`.
- Headings/eyebrows use tight tracking; micro-labels are uppercase `text-[10px] tracking-wider`.
- Body text at `text-sm`/`text-xs` for dense operational screens.

## 4. Radii, borders & signature treatment

- Card signature: `border: 1px solid var(--border-default); border-radius: 0.5rem; border-left: 3px solid var(--color-action);`
- Canvas/texture signature: `background-image: radial-gradient(circle at 88% 8%, rgba(78, 240, 255, 0.10), transparent 55%);`
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
5. Motion: Smooth and parallax-minded: 200-300ms ease-out; elements “arrive from depth” (scale 0.96→1 + brightness 0.7→1). Hover lifts z; leaving settles back.. Respect `prefers-reduced-motion`.
6. Touch targets ≥ 44px on mobile; inline form errors with `aria-live="polite"`.
7. Dark/light: `data-theme="light"` on `<html>` flips to the counterpart palette.

## 7. Full source spec (component patterns, motion, snippet)

### PROPOSAL-21 — Depth Map

- **slug**: `depth-map`
- **Vibe**: A sensor's point-cloud view of the app — surfaces colored by distance, luminous cyan-to-magenta gradients marking near-to-far, wireframe contours on hover.
- **Best for**: Analytics dashboards and the shooting board — literal visual depth for information priority. Adjectives: technical, luminous, dimensional.
- **Palette** (dark theme, `is_dark: true`):

| Token | Value | Usage |
|---|---|---|
| `--bg-canvas` | `#04070e` | Sensor-black void |
| `--bg-surface` | `#0a1120` | Near-field panel fill |
| `--bg-surface-elevated` | `#111b33` | Closer/higher-priority fill |
| `--border-subtle` | `#1a2745` | Contour hairlines |
| `--border-default` | `#2a3c66` | Standard borders |
| `--border-focus` | `#4ef0ff` | Sensor-cyan focus outline |
| `--text-primary` | `#e8f4ff` | Near-white headings (closest) |
| `--text-secondary` | `#a8c4e8` | Mid-field body text |
| `--text-muted` | `#5c739c` | Far-field dim text |
| `--color-action` | `#4ef0ff` | Cyan = nearest action |
| `--color-action-hover` | `#38d4e6` | Action hover (deeper cyan) |
| `--color-earnings` | `#ff9d4e` | Warm near-IR earnings |
| `--color-earnings-hover` | `#e6843a` | Earnings hover (deeper amber) |
| `--color-automation` | `#c44eff` | Far-field magenta automation |
| `--color-alert` | `#ffd23c` | Hot-return warnings |
| `--color-danger` | `#ff4e6a` | Collision-red failed states |
| `--color-action-glow` | `rgba(78, 240, 255, 0.18)` | Cyan depth glow |
| `--color-earnings-glow` | `rgba(255, 157, 78, 0.16)` | Amber depth glow |
| `--color-automation-glow` | `rgba(196, 78, 255, 0.16)` | Magenta depth glow |

- **Typography**: Technical instrument type. Display: `"Space Grotesk", "Chakra Petch", sans-serif` at 600-700. Body: `"Inter", system-ui, sans-serif`. Mono: `"JetBrains Mono", monospace` for coordinates, ranges, and IDs. Distance labels like `z=0.4m` accompany depth emphasis. KPIs `tabular-nums`.
- **Radii & Borders**: Soft-tech: cards `rounded-lg`, inputs `rounded-md`. 1px borders, and emphasized (near) panels get a gradient left edge (cyan -> transparent) encoding "closest to user".
- **Component Patterns**:
  - **Buttons**: Flat fill with subtle vertical gradient (lighter top = nearer); primary = cyan fill, dark text. Hover raises "z" (translateY -1px + brighter gradient). Focus = 2px cyan outline.
  - **Cards**: Panel depth = priority: primary cards use `bg-surface-elevated` + gradient edge, secondary cards sit "further" (darker, dimmer text). Hover draws a 1px wireframe contour (outline) over the card.
  - **Badges/Status**: Depth-coded chips with a small dot: near = filled bright, mid = filled dim, far = outline only. Publishing = a dot that drifts nearer (scale 0.8 -> 1) on a loop.
  - **Tables**: Rows tinted by column importance — the key column is brightest ("nearest"), supporting columns dimmer ("further"). Hover = contour outline on the row.
  - **Forms/Inputs**: Flat fields, 1px borders; focused field "comes nearer" (brighter border + slight scale 1.01). Helper text is far-field dim.
  - **Loading**: A depth-sweep: a soft gradient band travels down the skeleton (near-color cyan, 1.2s loop). Determinate = bar whose fill gradient shifts cyan->magenta.
  - **Signature detail**: The cyan-near / magenta-far gradient language — priority is literally distance, and everything important glows closer.
- **Motion & Animation**: Smooth and parallax-minded: 200-300ms ease-out; elements "arrive from depth" (scale 0.96 -> 1 + brightness 0.7 -> 1). Hover lifts z; leaving settles back.
- **Signature Preview Snippet**:

```html
<!-- Depth-map KPI: near-field panel with gradient edge -->
<div class="depth-card depth-near">
  <span class="depth-label">EARNINGS / 30d · z=0.4m</span>
  <strong class="depth-kpi">$12,480.50</strong>
</div>
```

## 8. Acceptance checklist

- [ ] No raw hex outside the token block; all brand colors resolve from tokens.
- [ ] All numeric values use `tabular-nums`.
- [ ] Every interactive element has a visible focus state using `--border-focus`.
- [ ] Status badges use the fixed status colors + text label.
- [ ] Both modes render correctly (`data-theme` toggle) and meet AA contrast.
- [ ] Card/button treatment matches the signature: border: 1px solid var(--border-default); border-radius: 0.5rem; border-left: 3px solid var(--color-action);
