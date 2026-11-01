# Design System: Y2K Bubblegum Pop

Use this design system as the complete visual language for this project. It is
one self-consistent "look": a 19-token color contract, typography, radii/border
treatment, component patterns, and motion language. Implement the UI against
these tokens — do not invent colors, shadows, or type styles.

- **Slug:** `y2k-pop`
- **Mode:** native light theme (dark counterpart included)
- **Vibe:** Retro-future early-2000s — pastel pink, sky blue, and lime on glossy bubbles with playful tilt and chrome-lite shine.
- **Best for:** Creator Studio and fun launch moments — optimistic, toy-like, social-native.
- **Adjectives:** playful, glossy, optimistic
- **Signature detail:** Glossy bubble surfaces + playful tilt + a chrome-lite "Y2K shine" (white gradient streak) across headings — plastic, optimistic, unmistakably 2003.
- **Motion:** Bouncy and springy — 350ms with overshoot (scale 0.9 -> 1.06 -> 1); buttons squash on :active.

## Source of truth

This is a personal, local design-system library (private, not published).

- Repo on disk: `~/dev/design_systems` (private GitHub mirror: https://github.com/DevinTobiasColebrooke/design_systems)
- This system's folder: `systems/y2k-pop/`
- Machine-readable spec (tokens, fonts, schemas): `systems/y2k-pop/system.json`
- Drop-in Tailwind v4 theme file: `systems/y2k-pop/tailwind.css`
- Full component showcase: `systems/y2k-pop/showcase.html` (open in a browser)

If you have filesystem access, read those files. If you don't, everything you
need is inline below.

## 1. The 19-token contract

Every value below is authoritative. Tokens map 1:1 to CSS custom properties
(`bg-canvas` style) and to Tailwind `brand-*` utilities
(`bg-brand-canvas`, `text-brand-action`, ...). Use tokens everywhere; never use a raw hex
outside this block.

| Token | Native (light) | Dark mode | Usage |
|---|---|---|---|
| `--bg-canvas` | `#fdeef4` | `#1a1333` | Deepest background layer |
| `--bg-surface` | `#ffffff` | `#241b42` | Cards, Sidebars, Panes |
| `--bg-surface-elevated` | `#fff5fa` | `#312661` | Dropdowns, hovered states |
| `--border-subtle` | `#f4d9e4` | `#3d3173` | Very light separation |
| `--border-default` | `#e0b6c9` | `#55489a` | Standard card/form borders |
| `--border-focus` | `#4cc9f0` | `#6ad7ff` | Focus states |
| `--text-primary` | `#23203f` | `#fdf4fb` | High contrast title/text |
| `--text-secondary` | `#4a4668` | `#d3c7ea` | Standard body paragraph |
| `--text-muted` | `#756c8a` | `#9a8fc0` | Descriptions, helper text, dates |
| `--color-action` | `#ff5fa2` | `#ff6fa8` | Primary action |
| `--color-action-hover` | `#e84a8e` | `#e85a91` | Action hover |
| `--color-earnings` | `#37c96b` | `#4ade80` | Earnings, Revenue, Profit |
| `--color-earnings-hover` | `#2ba85a` | `#2fc46b` | Earnings hover |
| `--color-automation` | `#4cc9f0` | `#6ad7ff` | Playwright, AI, Terminal accents |
| `--color-alert` | `#ffb020` | `#ffd166` | Warnings, pending states |
| `--color-danger` | `#e03e6e` | `#ff5f8f` | Error, failed status, deletes |
| `--color-action-glow` | `rgba(255, 95, 162, 0.16)` | `rgba(255, 111, 168, 0.18)` | Halo behind action icons |
| `--color-earnings-glow` | `rgba(55, 201, 107, 0.14)` | `rgba(74, 222, 128, 0.16)` | Halo behind earnings icons |
| `--color-automation-glow` | `rgba(76, 201, 240, 0.14)` | `rgba(106, 215, 255, 0.16)` | Halo behind automation icons |

### Tailwind CSS v4 setup

```css
@import "tailwindcss";

:root {
  --bg-canvas: #fdeef4;
  --bg-surface: #ffffff;
  --bg-surface-elevated: #fff5fa;
  --border-subtle: #f4d9e4;
  --border-default: #e0b6c9;
  --border-focus: #4cc9f0;
  --text-primary: #23203f;
  --text-secondary: #4a4668;
  --text-muted: #756c8a;
  --color-action: #ff5fa2;
  --color-action-hover: #e84a8e;
  --color-earnings: #37c96b;
  --color-earnings-hover: #2ba85a;
  --color-automation: #4cc9f0;
  --color-alert: #ffb020;
  --color-danger: #e03e6e;
  --color-action-glow: rgba(255, 95, 162, 0.16);
  --color-earnings-glow: rgba(55, 201, 107, 0.14);
  --color-automation-glow: rgba(76, 201, 240, 0.14);
  --action-label: #23203f; /* readable text color on --color-action fills */
}

[data-theme="dark"] {
  --bg-canvas: #1a1333;
  --bg-surface: #241b42;
  --bg-surface-elevated: #312661;
  --border-subtle: #3d3173;
  --border-default: #55489a;
  --border-focus: #6ad7ff;
  --text-primary: #fdf4fb;
  --text-secondary: #d3c7ea;
  --text-muted: #9a8fc0;
  --color-action: #ff6fa8;
  --color-action-hover: #e85a91;
  --color-earnings: #4ade80;
  --color-earnings-hover: #2fc46b;
  --color-automation: #6ad7ff;
  --color-alert: #ffd166;
  --color-danger: #ff5f8f;
  --color-action-glow: rgba(255, 111, 168, 0.18);
  --color-earnings-glow: rgba(74, 222, 128, 0.16);
  --color-automation-glow: rgba(106, 215, 255, 0.16);
  --action-label: #0d0d12;
}

@theme {
  --font-display: "Bungee", "Baloo 2", sans-serif;
  --font-sans: "Quicksand", "Nunito", system-ui, sans-serif;
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

Equivalent guide: **the full drop-in file is `~/dev/design_systems/systems/y2k-pop/tailwind.css`** — copy it to
`app/assets/tailwind/design_system.css` and `@import` it from `application.css`.

## 2. Color schemas (optional accent swaps)

These override accents on top of either mode palette. Apply as a class/attribute
that re-declares the listed tokens (everything else stays from the mode palette).

### `blue-rave` — Blue Rave

Sky-led rave with lime earnings; use dark ink labels on sky.

| Token | Value |
|---|---|
| `--color-action` | `#6ad7ff` |
| `--color-action-hover` | `#4fc2ec` |
| `--color-earnings` | `#4ade80` |
| `--color-earnings-hover` | `#2fc46b` |
| `--color-automation` | `#ff6fa8` |
| `--color-alert` | `#ffd166` |
| `--color-danger` | `#ff5f8f` |
| `--border-focus` | `#6ad7ff` |
| `--color-action-glow` | `rgba(106, 215, 255, 0.18)` |
| `--color-earnings-glow` | `rgba(74, 222, 128, 0.16)` |
| `--color-automation-glow` | `rgba(255, 111, 168, 0.18)` |
### `lime-glow` — Lime Glow

Lime-led glow with pink earnings; use dark ink labels on lime.

| Token | Value |
|---|---|
| `--color-action` | `#4ade80` |
| `--color-action-hover` | `#2fc46b` |
| `--color-earnings` | `#ff6fa8` |
| `--color-earnings-hover` | `#e85a91` |
| `--color-automation` | `#6ad7ff` |
| `--color-alert` | `#ffd166` |
| `--color-danger` | `#ff5f8f` |
| `--border-focus` | `#4ade80` |
| `--color-action-glow` | `rgba(74, 222, 128, 0.18)` |
| `--color-earnings-glow` | `rgba(255, 111, 168, 0.16)` |
| `--color-automation-glow` | `rgba(106, 215, 255, 0.16)` |
## 3. Typography

- **Display** (headings, KPIs, big numbers): `"Bungee", "Baloo 2", sans-serif`
- **Sans** (body, labels, UI): `"Quicksand", "Nunito", system-ui, sans-serif`
- **Mono** (timestamps, IDs, code, logs): `"Space Mono", ui-monospace, monospace`
- Load the families with the project's normal Google Fonts `<link>` (weights 500-800 for display/sans).

Hard rules:

- Every number (earnings, rates, counts, dates, timers) uses `tabular-nums`.
- Headings/eyebrows use tight tracking; micro-labels are uppercase `text-[10px] tracking-wider`.
- Body text at `text-sm`/`text-xs` for dense operational screens.

## 4. Radii, borders & signature treatment

- Card signature: `border: 2px solid var(--border-default); border-radius: 2rem; box-shadow: 0 6px 0 var(--border-default), inset 0 8px 12px -8px rgba(255, 255, 255, 0.9);`
- Canvas/texture signature: `background-image: linear-gradient(120deg, transparent 35%, rgba(255, 255, 255, 0.65) 50%, transparent 65%);`
- Border roles: `--border-subtle` = hairlines/dividers; `--border-default` = card/form borders;
  `--border-focus` = focus rings and active states.
- Radii scale: `sm` 0.375rem (buttons/inputs) · `md` 0.5rem (cards/small panes) · `lg` 0.75rem (big panels/modals).

## 5. Intent color rules (never swap these)

- `action` → primary buttons, links, active nav, focus. Label text on action fills: `#23203f` (or `var(--action-label)`).
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
5. Motion: Bouncy and springy — 350ms with overshoot (scale 0.9 -> 1.06 -> 1); buttons squash on :active.. Respect `prefers-reduced-motion`.
6. Touch targets ≥ 44px on mobile; inline form errors with `aria-live="polite"`.
7. Dark/light: `data-theme="dark"` on `<html>` flips to the counterpart palette.

## 7. Full source spec (component patterns, motion, snippet)

### PROPOSAL-16 — Y2K Bubblegum Pop

- **slug**: `y2k-pop`
- **Vibe**: Retro-future early-2000s — pastel pink, sky blue, and lime on glossy bubbles with playful tilt and chrome-lite shine.
- **Best for**: Creator Studio and fun launch moments — optimistic, toy-like, social-native. Adjectives: playful, glossy, optimistic.
- **Palette** (light theme, `is_dark: false`):

| Token | Value | Usage |
|---|---|---|
| `--bg-canvas` | `#fdeef4` | Pastel pink-white canvas |
| `--bg-surface` | `#ffffff` | Card and bubble fill |
| `--bg-surface-elevated` | `#fff5fa` | Raised/hover bubbles |
| `--border-subtle` | `#f4d9e4` | Soft pastel hairlines |
| `--border-default` | `#e0b6c9` | Standard pastel borders |
| `--border-focus` | `#4cc9f0` | Sky-blue focus outline |
| `--text-primary` | `#23203f` | Ink-navy headings |
| `--text-secondary` | `#4a4668` | Body text |
| `--text-muted` | `#756c8a` | Captions, helper text |
| `--color-action` | `#ff5fa2` | Bubblegum-pink primary action |
| `--color-action-hover` | `#e84a8e` | Action hover (deeper pink) |
| `--color-earnings` | `#37c96b` | Lime-green earnings |
| `--color-earnings-hover` | `#2ba85a` | Earnings hover (deeper lime) |
| `--color-automation` | `#4cc9f0` | Sky-blue automation accents |
| `--color-alert` | `#ffb020` | Candy-amber warnings |
| `--color-danger` | `#e03e6e` | Bubblegum-red failed states |
| `--color-action-glow` | `rgba(255, 95, 162, 0.16)` | Pink tint behind action icons |
| `--color-earnings-glow` | `rgba(55, 201, 107, 0.14)` | Lime tint behind earnings icons |
| `--color-automation-glow` | `rgba(76, 201, 240, 0.14)` | Sky tint behind automation icons |

- **Typography**: Display: `"Bungee", "Baloo 2", sans-serif` — chunky rounded display for headings and KPI numerals, weight 400-800. Sans: `"Quicksand", "Nunito", system-ui, sans-serif` at 500-700 — friendly and round. Mono: `"Space Mono", ui-monospace, monospace` for timestamps. Numerals `tabular-nums`; labels uppercase with `letter-spacing: 0.06em`.
- **Radii & Borders**: Extra bubbly — cards 24px+, buttons full pill, inputs 16px. Borders are 2px pastel; cards carry a glossy inset top highlight (`inset 0 8px 12px -8px rgba(255,255,255,0.9)`) and a 3D bottom lip shadow (0 6px 0 pastel darker).
- **Component Patterns**:
  - **Buttons**: Glossy bubble pills with a 3D bottom lip (solid 4px darker shadow, no blur) and inset top shine; primary = bubblegum pink with dark ink text (`#23203f`) for AA; hover bounces scale 1.03. Secondary = white with 2px pastel border. Focus = 2px sky outline.
  - **Cards**: White bubbles with 2px pastel border, glossy top highlight, a subtle -2deg playful tilt on featured cards, and `rounded-[2rem]`. No soft shadows — plastic depth only.
  - **Badges/Status**: Glossy bubble chips with a dot; publishing = pulsing lime "loading" bubble; published = sky bubble; failed = pink-red bubble. Rounded-full, never square.
  - **Tables**: Soft pastel zebra rows inside a rounded container; header in bold rounded sans. Row hover = pastel pink wash.
  - **Forms/Inputs**: Bubbly rounded fields with a glossy inset; focus = sky border. Labels in rounded bold sans.
  - **Loading**: Three bouncing glossy bubbles; determinate = a segmented candy bar filling left to right.
  - **Signature detail**: Glossy bubble surfaces + playful tilt + a chrome-lite "Y2K shine" (white gradient streak) across headings — plastic, optimistic, unmistakably 2003.
- **Motion & Animation**: Bouncy and springy — 350ms with overshoot (`scale 0.9 -> 1.06 -> 1`); cards tilt further on hover; buttons squash on `:active`. Turbo Stream inserts bounce in; nothing is still for long.
- **Signature Preview Snippet**:

```html
<!-- Y2K KPI bubble: gloss, pastel border, playful tilt -->
<div class="y2k-bubble">
  <span class="y2k-label">EARNINGS!!</span>
  <strong class="y2k-kpi">$12,480</strong>
  <span class="y2k-gloss"></span>
</div>
```

## 8. Acceptance checklist

- [ ] No raw hex outside the token block; all brand colors resolve from tokens.
- [ ] All numeric values use `tabular-nums`.
- [ ] Every interactive element has a visible focus state using `--border-focus`.
- [ ] Status badges use the fixed status colors + text label.
- [ ] Both modes render correctly (`data-theme` toggle) and meet AA contrast.
- [ ] Card/button treatment matches the signature: border: 2px solid var(--border-default); border-radius: 2rem; box-shadow: 0 6px 0 var(--border-default), inset 0 8px 12px -8px rgba(255, 255, 255, 0.9);
