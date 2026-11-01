# Design System: CRT Monitor

Use this design system as the complete visual language for this project. It is
one self-consistent "look": a 19-token color contract, typography, radii/border
treatment, component patterns, and motion language. Implement the UI against
these tokens — do not invent colors, shadows, or type styles.

- **Slug:** `crt`
- **Mode:** native dark theme (light counterpart included)
- **Vibe:** A curved-glass tube monitor in a 1990s office — phosphor glow, rolling scanlines, slight barrel distortion, and that soft chromatic halo around bright text.
- **Best for:** Posting history and the agency publishing feed — everything looks played back off a dusty tube.
- **Adjectives:** warm, retro-physical, glowy
- **Signature detail:** The vignette + scanline + bloom triad — every surface reads as curved glass, and bright text always bleeds a little light.
- **Motion:** Soft and analog: 200-300ms ease-out with a gentle bloom on entry (opacity 0→1, brightness 0.8→1). No hard snaps; occasionally a one-frame flicker on state change.

## Source of truth

This is a personal, local design-system library (private, not published).

- Repo on disk: `~/dev/design_systems` (private GitHub mirror: https://github.com/DevinTobiasColebrooke/design_systems)
- This system's folder: `systems/crt/`
- Machine-readable spec (tokens, fonts, schemas): `systems/crt/system.json`
- Drop-in Tailwind v4 theme file: `systems/crt/tailwind.css`
- Full component showcase: `systems/crt/showcase.html` (open in a browser)

If you have filesystem access, read those files. If you don't, everything you
need is inline below.

## 1. The 19-token contract

Every value below is authoritative. Tokens map 1:1 to CSS custom properties
(`bg-canvas` style) and to Tailwind `brand-*` utilities
(`bg-brand-canvas`, `text-brand-action`, ...). Use tokens everywhere; never use a raw hex
outside this block.

| Token | Native (dark) | Light mode | Usage |
|---|---|---|---|
| `--bg-canvas` | `#0c0a08` | `#f2ede3` | Deepest background layer |
| `--bg-surface` | `#171310` | `#faf6ec` | Cards, Sidebars, Panes |
| `--bg-surface-elevated` | `#221c16` | `#eee7d6` | Dropdowns, hovered states |
| `--border-subtle` | `#30271d` | `#ddd3bd` | Very light separation |
| `--border-default` | `#443726` | `#b8a888` | Standard card/form borders |
| `--border-focus` | `#ffcf5c` | `#b35c00` | Focus states |
| `--text-primary` | `#ffe9c2` | `#2b1f10` | High contrast title/text |
| `--text-secondary` | `#d8bf94` | `#5c4a30` | Standard body paragraph |
| `--text-muted` | `#947d58` | `#8a775c` | Descriptions, helper text, dates |
| `--color-action` | `#ffb347` | `#b35c00` | Primary action |
| `--color-action-hover` | `#e69a35` | `#964d00` | Action hover |
| `--color-earnings` | `#8fd66a` | `#2e6b34` | Earnings, Revenue, Profit |
| `--color-earnings-hover` | `#77bd54` | `#255a2a` | Earnings hover |
| `--color-automation` | `#6cc6d8` | `#1f6e80` | Playwright, AI, Terminal accents |
| `--color-alert` | `#ffab4a` | `#9a5200` | Warnings, pending states |
| `--color-danger` | `#ff7355` | `#b83a24` | Error, failed status, deletes |
| `--color-action-glow` | `rgba(255, 179, 71, 0.20)` | `rgba(179, 92, 0, 0.14)` | Halo behind action icons |
| `--color-earnings-glow` | `rgba(143, 214, 106, 0.18)` | `rgba(46, 107, 52, 0.12)` | Halo behind earnings icons |
| `--color-automation-glow` | `rgba(108, 198, 216, 0.18)` | `rgba(31, 110, 128, 0.12)` | Halo behind automation icons |

### Tailwind CSS v4 setup

```css
@import "tailwindcss";

:root {
  --bg-canvas: #0c0a08;
  --bg-surface: #171310;
  --bg-surface-elevated: #221c16;
  --border-subtle: #30271d;
  --border-default: #443726;
  --border-focus: #ffcf5c;
  --text-primary: #ffe9c2;
  --text-secondary: #d8bf94;
  --text-muted: #947d58;
  --color-action: #ffb347;
  --color-action-hover: #e69a35;
  --color-earnings: #8fd66a;
  --color-earnings-hover: #77bd54;
  --color-automation: #6cc6d8;
  --color-alert: #ffab4a;
  --color-danger: #ff7355;
  --color-action-glow: rgba(255, 179, 71, 0.20);
  --color-earnings-glow: rgba(143, 214, 106, 0.18);
  --color-automation-glow: rgba(108, 198, 216, 0.18);
  --action-label: #0d0d12; /* readable text color on --color-action fills */
}

[data-theme="light"] {
  --bg-canvas: #f2ede3;
  --bg-surface: #faf6ec;
  --bg-surface-elevated: #eee7d6;
  --border-subtle: #ddd3bd;
  --border-default: #b8a888;
  --border-focus: #b35c00;
  --text-primary: #2b1f10;
  --text-secondary: #5c4a30;
  --text-muted: #8a775c;
  --color-action: #b35c00;
  --color-action-hover: #964d00;
  --color-earnings: #2e6b34;
  --color-earnings-hover: #255a2a;
  --color-automation: #1f6e80;
  --color-alert: #9a5200;
  --color-danger: #b83a24;
  --color-action-glow: rgba(179, 92, 0, 0.14);
  --color-earnings-glow: rgba(46, 107, 52, 0.12);
  --color-automation-glow: rgba(31, 110, 128, 0.12);
  --action-label: #ffffff;
}

@theme {
  --font-display: "VT323", "Silkscreen", monospace;
  --font-sans: "ChicagoFLF", "Press Start 2P", "Inter", sans-serif;
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

Equivalent guide: **the full drop-in file is `~/dev/design_systems/systems/crt/tailwind.css`** — copy it to
`app/assets/tailwind/design_system.css` and `@import` it from `application.css`.

## 2. Color schemas (optional accent swaps)

These override accents on top of either mode palette. Apply as a class/attribute
that re-declares the listed tokens (everything else stays from the mode palette).

### `white-phosphor` — White Phosphor

P1 white-phosphor tube; use dark ink labels on the pale fill.

| Token | Value |
|---|---|
| `--color-action` | `#b8d4bc` |
| `--color-action-hover` | `#9cbca2` |
| `--color-earnings` | `#8a6d00` |
| `--color-earnings-hover` | `#725800` |
| `--color-automation` | `#4d7d8f` |
| `--color-alert` | `#8f5e00` |
| `--color-danger` | `#b3261e` |
| `--border-focus` | `#b8d4bc` |
| `--color-action-glow` | `rgba(184, 212, 188, 0.18)` |
| `--color-earnings-glow` | `rgba(138, 109, 0, 0.12)` |
| `--color-automation-glow` | `rgba(77, 125, 143, 0.12)` |
### `blue-glow` — Blue Glow

Blue-phosphor tube with gold earnings; use dark ink labels on blue.

| Token | Value |
|---|---|
| `--color-action` | `#4d8cff` |
| `--color-action-hover` | `#3a72d9` |
| `--color-earnings` | `#9a7400` |
| `--color-earnings-hover` | `#806000` |
| `--color-automation` | `#0a9fd6` |
| `--color-alert` | `#b45309` |
| `--color-danger` | `#d93345` |
| `--border-focus` | `#4d8cff` |
| `--color-action-glow` | `rgba(77, 140, 255, 0.16)` |
| `--color-earnings-glow` | `rgba(154, 116, 0, 0.12)` |
| `--color-automation-glow` | `rgba(10, 159, 214, 0.14)` |
## 3. Typography

- **Display** (headings, KPIs, big numbers): `"VT323", "Silkscreen", monospace`
- **Sans** (body, labels, UI): `"ChicagoFLF", "Press Start 2P", "Inter", sans-serif`
- **Mono** (timestamps, IDs, code, logs): `"IBM Plex Mono", ui-monospace, monospace`
- Load the families with the project's normal Google Fonts `<link>` (weights 500-800 for display/sans).

Hard rules:

- Every number (earnings, rates, counts, dates, timers) uses `tabular-nums`.
- Headings/eyebrows use tight tracking; micro-labels are uppercase `text-[10px] tracking-wider`.
- Body text at `text-sm`/`text-xs` for dense operational screens.

## 4. Radii, borders & signature treatment

- Card signature: `border: 1px solid var(--border-default); border-radius: 1rem; box-shadow: inset 0 0 24px rgba(0, 0, 0, 0.55);`
- Canvas/texture signature: `background-image: repeating-linear-gradient(0deg, rgba(255, 179, 71, 0.05) 0 1px, transparent 1px 3px);`
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
5. Motion: Soft and analog: 200-300ms ease-out with a gentle bloom on entry (opacity 0→1, brightness 0.8→1). No hard snaps; occasionally a one-frame flicker on state change.. Respect `prefers-reduced-motion`.
6. Touch targets ≥ 44px on mobile; inline form errors with `aria-live="polite"`.
7. Dark/light: `data-theme="light"` on `<html>` flips to the counterpart palette.

## 7. Full source spec (component patterns, motion, snippet)

### PROPOSAL-17 — CRT Monitor

- **slug**: `crt`
- **Vibe**: A curved-glass tube monitor in a 1990s office — phosphor glow, rolling scanlines, slight barrel distortion, and that soft chromatic halo around bright text.
- **Best for**: Posting history and the agency publishing feed — everything looks played back off a dusty tube. Adjectives: warm, retro-physical, glowy.
- **Palette** (dark theme, `is_dark: true`):

| Token | Value | Usage |
|---|---|---|
| `--bg-canvas` | `#0c0a08` | Warm near-black tube backplane |
| `--bg-surface` | `#171310` | Panel fill on the glass |
| `--bg-surface-elevated` | `#221c16` | Raised panels, hover fills |
| `--border-subtle` | `#30271d` | Faint bezel hairlines |
| `--border-default` | `#443726` | Standard card borders |
| `--border-focus` | `#ffcf5c` | Warm phosphor focus outline |
| `--text-primary` | `#ffe9c2` | Warm white phosphor headings |
| `--text-secondary` | `#d8bf94` | Body text |
| `--text-muted` | `#947d58` | Dimmed captions, timestamps |
| `--color-action` | `#ffb347` | Warm amber action fills |
| `--color-action-hover` | `#e69a35` | Action hover (deeper amber) |
| `--color-earnings` | `#8fd66a` | Green-phosphor earnings |
| `--color-earnings-hover` | `#77bd54` | Earnings hover (deeper green) |
| `--color-automation` | `#6cc6d8` | Cyan-phosphor automation accents |
| `--color-alert` | `#ffab4a` | Amber warnings |
| `--color-danger` | `#ff7355` | Warm red failed states |
| `--color-action-glow` | `rgba(255, 179, 71, 0.20)` | Amber halo behind action icons |
| `--color-earnings-glow` | `rgba(143, 214, 106, 0.18)` | Green halo behind earnings icons |
| `--color-automation-glow` | `rgba(108, 198, 216, 0.18)` | Cyan halo behind automation icons |

- **Typography**: Display: `"VT323", "Silkscreen", monospace` for oversized numerals. Sans: `"ChicagoFLF", "Press Start 2P", "Inter", sans-serif` fallback at 500-700 — use sparingly, prefer mono. Mono: `"IBM Plex Mono", ui-monospace, monospace` for body. Headings carry a soft 1px text-shadow of `--color-action-glow` (phosphor bloom). KPIs `tabular-nums`.
- **Radii & Borders**: Barrel-curve everywhere — cards `rounded-2xl` (1rem), buttons `rounded-lg`, inputs `rounded-md`, mimicking glass curvature. 1px borders with a faint outer glow (no hard shadows — depth comes from the tube).
- **Component Patterns**:
  - **Buttons**: Soft-fill with warm text and a 2px glow shadow (`0 0 8px var(--color-action-glow)`); hover intensifies the bloom. Primary = amber fill, dark text. Focus = 2px warm outline.
  - **Cards**: Rounded panels with a subtle inset vignette (`inset 0 0 24px rgba(0,0,0,0.55)`) — the tube's dark corners. A scanline overlay (3px repeating gradient) sits inside every card.
  - **Badges/Status**: Rounded chips with a phosphor dot; publishing pulses with a slow "refresh flicker" (opacity 1 -> 0.7 -> 1, 1.2s). Failed = warm red text with red glow, never a filled banner.
  - **Tables**: Rounded outer frame, inner 1px grid; rows hover with a faint amber wash. Timestamps in mono, dimmed.
  - **Forms/Inputs**: Rounded fields, 1px borders, inner vignette; focus = warm amber border + soft glow. Caret blinks like an electron gun.
  - **Loading**: A horizontal bright line that "rolls" down the surface every 3s (refresh band); determinate = a glowing bar with bloom on the leading edge.
  - **Signature detail**: The vignette + scanline + bloom triad — every surface reads as curved glass, and bright text always bleeds a little light.
- **Motion & Animation**: Soft and analog: 200-300ms ease-out with a gentle bloom on entry (opacity 0 -> 1, brightness 0.8 -> 1). No hard snaps; occasionally a one-frame flicker on state change.
- **Signature Preview Snippet**:

```html
<!-- CRT posting history row: scanlines, vignette, phosphor bloom -->
<div class="crt-row">
  <span class="crt-time">09:42:11</span>
  <span class="crt-status crt-ok">PUBLISHED</span>
  <span class="crt-msg">tiktok-8821.mp4</span>
</div>
```

## 8. Acceptance checklist

- [ ] No raw hex outside the token block; all brand colors resolve from tokens.
- [ ] All numeric values use `tabular-nums`.
- [ ] Every interactive element has a visible focus state using `--border-focus`.
- [ ] Status badges use the fixed status colors + text label.
- [ ] Both modes render correctly (`data-theme` toggle) and meet AA contrast.
- [ ] Card/button treatment matches the signature: border: 1px solid var(--border-default); border-radius: 1rem; box-shadow: inset 0 0 24px rgba(0, 0, 0, 0.55);
