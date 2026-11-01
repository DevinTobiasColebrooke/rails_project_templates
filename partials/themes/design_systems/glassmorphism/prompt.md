# Design System: Glassmorphism Frosted

Use this design system as the complete visual language for this project. It is
one self-consistent "look": a 19-token color contract, typography, radii/border
treatment, component patterns, and motion language. Implement the UI against
these tokens — do not invent colors, shadows, or type styles.

- **Slug:** `glassmorphism`
- **Mode:** native dark theme (light counterpart included)
- **Vibe:** Frosted translucent glass layers floating over a rich indigo-to-violet depth — airy, light, and softly luminous.
- **Best for:** Onboarding and the posting calendar — surfaces that feel weightless over a colorful backdrop.
- **Adjectives:** airy, modern, luminous
- **Signature detail:** The frosted blur itself — translucent layers with backdrop-filter over the indigo-violet depth. If the backdrop is flat, the effect dies.
- **Motion:** Airy and weightless — 250-350ms ease-out; elements float in with a 10px upward drift and blur(6px) -> blur(0).

## Source of truth

This is a personal, local design-system library (private, not published).

- Repo on disk: `~/dev/design_systems` (private GitHub mirror: https://github.com/DevinTobiasColebrooke/design_systems)
- This system's folder: `systems/glassmorphism/`
- Machine-readable spec (tokens, fonts, schemas): `systems/glassmorphism/system.json`
- Drop-in Tailwind v4 theme file: `systems/glassmorphism/tailwind.css`
- Full component showcase: `systems/glassmorphism/showcase.html` (open in a browser)

If you have filesystem access, read those files. If you don't, everything you
need is inline below.

## 1. The 19-token contract

Every value below is authoritative. Tokens map 1:1 to CSS custom properties
(`bg-canvas` style) and to Tailwind `brand-*` utilities
(`bg-brand-canvas`, `text-brand-action`, ...). Use tokens everywhere; never use a raw hex
outside this block.

| Token | Native (dark) | Light mode | Usage |
|---|---|---|---|
| `--bg-canvas` | `#191037` | `#e6e0f6` | Deepest background layer |
| `--bg-surface` | `rgba(255, 255, 255, 0.08)` | `rgba(255, 255, 255, 0.55)` | Cards, Sidebars, Panes |
| `--bg-surface-elevated` | `rgba(255, 255, 255, 0.14)` | `rgba(255, 255, 255, 0.75)` | Dropdowns, hovered states |
| `--border-subtle` | `rgba(255, 255, 255, 0.10)` | `rgba(30, 27, 75, 0.08)` | Very light separation |
| `--border-default` | `rgba(255, 255, 255, 0.18)` | `rgba(30, 27, 75, 0.16)` | Standard card/form borders |
| `--border-focus` | `#b7c4ff` | `#4f46e5` | Focus states |
| `--text-primary` | `#ffffff` | `#1e1b4b` | High contrast title/text |
| `--text-secondary` | `#e2e0f5` | `#3f3a6e` | Standard body paragraph |
| `--text-muted` | `#a8a3cf` | `#6f6a99` | Descriptions, helper text, dates |
| `--color-action` | `#5747e0` | `#4f46e5` | Primary action |
| `--color-action-hover` | `#4637cc` | `#4338ca` | Action hover |
| `--color-earnings` | `#6ee7b7` | `#0e9f6e` | Earnings, Revenue, Profit |
| `--color-earnings-hover` | `#4fd1a0` | `#0b8158` | Earnings hover |
| `--color-automation` | `#93c5fd` | `#3b82f6` | Playwright, AI, Terminal accents |
| `--color-alert` | `#fcd34d` | `#a16207` | Warnings, pending states |
| `--color-danger` | `#f87171` | `#dc2626` | Error, failed status, deletes |
| `--color-action-glow` | `rgba(87, 71, 224, 0.25)` | `rgba(79, 70, 229, 0.20)` | Halo behind action icons |
| `--color-earnings-glow` | `rgba(110, 231, 183, 0.20)` | `rgba(14, 159, 110, 0.16)` | Halo behind earnings icons |
| `--color-automation-glow` | `rgba(147, 197, 253, 0.20)` | `rgba(59, 130, 246, 0.16)` | Halo behind automation icons |

### Tailwind CSS v4 setup

```css
@import "tailwindcss";

:root {
  --bg-canvas: #191037;
  --bg-surface: rgba(255, 255, 255, 0.08);
  --bg-surface-elevated: rgba(255, 255, 255, 0.14);
  --border-subtle: rgba(255, 255, 255, 0.10);
  --border-default: rgba(255, 255, 255, 0.18);
  --border-focus: #b7c4ff;
  --text-primary: #ffffff;
  --text-secondary: #e2e0f5;
  --text-muted: #a8a3cf;
  --color-action: #5747e0;
  --color-action-hover: #4637cc;
  --color-earnings: #6ee7b7;
  --color-earnings-hover: #4fd1a0;
  --color-automation: #93c5fd;
  --color-alert: #fcd34d;
  --color-danger: #f87171;
  --color-action-glow: rgba(87, 71, 224, 0.25);
  --color-earnings-glow: rgba(110, 231, 183, 0.20);
  --color-automation-glow: rgba(147, 197, 253, 0.20);
  --action-label: #ffffff; /* readable text color on --color-action fills */
}

[data-theme="light"] {
  --bg-canvas: #e6e0f6;
  --bg-surface: rgba(255, 255, 255, 0.55);
  --bg-surface-elevated: rgba(255, 255, 255, 0.75);
  --border-subtle: rgba(30, 27, 75, 0.08);
  --border-default: rgba(30, 27, 75, 0.16);
  --border-focus: #4f46e5;
  --text-primary: #1e1b4b;
  --text-secondary: #3f3a6e;
  --text-muted: #6f6a99;
  --color-action: #4f46e5;
  --color-action-hover: #4338ca;
  --color-earnings: #0e9f6e;
  --color-earnings-hover: #0b8158;
  --color-automation: #3b82f6;
  --color-alert: #a16207;
  --color-danger: #dc2626;
  --color-action-glow: rgba(79, 70, 229, 0.20);
  --color-earnings-glow: rgba(14, 159, 110, 0.16);
  --color-automation-glow: rgba(59, 130, 246, 0.16);
  --action-label: #ffffff;
}

@theme {
  --font-display: "Sora", "Outfit", sans-serif;
  --font-sans: "Inter", system-ui, sans-serif;
  --font-mono: "JetBrains Mono", ui-monospace, monospace;

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

Equivalent guide: **the full drop-in file is `~/dev/design_systems/systems/glassmorphism/tailwind.css`** — copy it to
`app/assets/tailwind/design_system.css` and `@import` it from `application.css`.

## 2. Color schemas (optional accent swaps)

These override accents on top of either mode palette. Apply as a class/attribute
that re-declares the listed tokens (everything else stays from the mode palette).

### `rose-quartz` — Rose Quartz

Rose-led glass with mint and sky; use white bold labels on rose.

| Token | Value |
|---|---|
| `--color-action` | `#e11d74` |
| `--color-action-hover` | `#c0125f` |
| `--color-earnings` | `#0e9f6e` |
| `--color-earnings-hover` | `#0b8158` |
| `--color-automation` | `#3b82f6` |
| `--color-alert` | `#a16207` |
| `--color-danger` | `#dc2626` |
| `--border-focus` | `#e11d74` |
| `--color-action-glow` | `rgba(225, 29, 116, 0.20)` |
| `--color-earnings-glow` | `rgba(14, 159, 110, 0.16)` |
| `--color-automation-glow` | `rgba(59, 130, 246, 0.16)` |
### `azure-float` — Azure Float

Azure-led glass with rose automation; use white bold labels on azure.

| Token | Value |
|---|---|
| `--color-action` | `#2563eb` |
| `--color-action-hover` | `#1d4ed8` |
| `--color-earnings` | `#0e9f6e` |
| `--color-earnings-hover` | `#0b8158` |
| `--color-automation` | `#e11d74` |
| `--color-alert` | `#a16207` |
| `--color-danger` | `#dc2626` |
| `--border-focus` | `#2563eb` |
| `--color-action-glow` | `rgba(37, 99, 235, 0.20)` |
| `--color-earnings-glow` | `rgba(14, 159, 110, 0.16)` |
| `--color-automation-glow` | `rgba(225, 29, 116, 0.16)` |
## 3. Typography

- **Display** (headings, KPIs, big numbers): `"Sora", "Outfit", sans-serif`
- **Sans** (body, labels, UI): `"Inter", system-ui, sans-serif`
- **Mono** (timestamps, IDs, code, logs): `"JetBrains Mono", ui-monospace, monospace`
- Load the families with the project's normal Google Fonts `<link>` (weights 500-800 for display/sans).

Hard rules:

- Every number (earnings, rates, counts, dates, timers) uses `tabular-nums`.
- Headings/eyebrows use tight tracking; micro-labels are uppercase `text-[10px] tracking-wider`.
- Body text at `text-sm`/`text-xs` for dense operational screens.

## 4. Radii, borders & signature treatment

- Card signature: `border: 1px solid var(--border-default); border-radius: 20px; backdrop-filter: blur(20px); box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.20);`
- Canvas/texture signature: `background-image: radial-gradient(circle at 85% 0%, rgba(87, 71, 224, 0.20), transparent 55%);`
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
5. Motion: Airy and weightless — 250-350ms ease-out; elements float in with a 10px upward drift and blur(6px) -> blur(0).. Respect `prefers-reduced-motion`.
6. Touch targets ≥ 44px on mobile; inline form errors with `aria-live="polite"`.
7. Dark/light: `data-theme="light"` on `<html>` flips to the counterpart palette.

## 7. Full source spec (component patterns, motion, snippet)

### PROPOSAL-11 — Glassmorphism Frosted

- **slug**: `glassmorphism`
- **Vibe**: Frosted translucent glass layers floating over a rich indigo-to-violet depth — airy, light, and softly luminous.
- **Best for**: Onboarding and the posting calendar — surfaces that feel weightless over a colorful backdrop. Adjectives: airy, modern, luminous.
- **Palette** (dark theme, `is_dark: true`; surface tokens are translucent and must render over a rich indigo-to-violet gradient canvas; all glass surfaces apply `backdrop-filter: blur(20px)`):

| Token | Value | Usage |
|---|---|---|
| `--bg-canvas` | `#191037` | Rich indigo-violet depth (gradient base) |
| `--bg-surface` | `rgba(255, 255, 255, 0.08)` | Frosted glass panel fill |
| `--bg-surface-elevated` | `rgba(255, 255, 255, 0.14)` | Raised glass, modals, hover |
| `--border-subtle` | `rgba(255, 255, 255, 0.10)` | Hairline frost separators |
| `--border-default` | `rgba(255, 255, 255, 0.18)` | Standard glass borders |
| `--border-focus` | `#b7c4ff` | Soft indigo focus outline |
| `--text-primary` | `#ffffff` | High-contrast headings on glass |
| `--text-secondary` | `#e2e0f5` | Body text |
| `--text-muted` | `#a8a3cf` | Captions, helper text |
| `--color-action` | `#5747e0` | Deep indigo-violet primary action |
| `--color-action-hover` | `#4637cc` | Action hover (deeper violet) |
| `--color-earnings` | `#6ee7b7` | Soft mint earnings |
| `--color-earnings-hover` | `#4fd1a0` | Earnings hover (deeper mint) |
| `--color-automation` | `#93c5fd` | Soft sky automation accents |
| `--color-alert` | `#fcd34d` | Soft amber warnings |
| `--color-danger` | `#f87171` | Soft red failed states |
| `--color-action-glow` | `rgba(87, 71, 224, 0.25)` | Violet aura behind action icons |
| `--color-earnings-glow` | `rgba(110, 231, 183, 0.20)` | Mint aura behind earnings icons |
| `--color-automation-glow` | `rgba(147, 197, 253, 0.20)` | Sky aura behind automation icons |

- **Typography**: Display: `"Sora", "Outfit", sans-serif` at 600-700 — airy, geometric, open. Sans: `"Inter", system-ui, sans-serif`. Mono: `"JetBrains Mono", ui-monospace, monospace` for timestamps and IDs. Numerals `tabular-nums`; generous line-height (1.6 body).
- **Radii & Borders**: Large and soft — cards 20-24px, buttons pill, inputs 14px. Borders are 1px translucent white; glass panels add an inset 1px top highlight (`inset 0 1px 0 rgba(255,255,255,0.20)`). No hard shadows — soft 40px ambient shadows only.
- **Component Patterns**:
  - **Buttons**: Frosted glass pills (translucent fill + blur), 1px translucent border, soft white text; hover raises fill opacity to `0.16`. Primary = violet-tinted glass with bold white text (AA-large, bold 14px+); secondary = neutral glass. Focus = 2px soft indigo ring with a gap.
  - **Cards**: Translucent frosted panels with `backdrop-filter: blur(20px)`, 1px `rgba(255,255,255,0.18)` border, and the inset top highlight. They float over the gradient depth in staggered layers; modal dialogs use `--bg-surface-elevated`.
  - **Badges/Status**: Glass pills with a tinted glowing dot; publishing = softly breathing mint dot; failed = soft red pill. All fills translucent.
  - **Tables**: One glass panel with `rgba(255,255,255,0.05)` row separators; header in soft caps. Row hover = `--bg-surface-elevated` tint.
  - **Forms/Inputs**: Glass fields (translucent fill + blur); focus = soft indigo border plus a gentle glow. Labels sit above in muted white.
  - **Loading**: Three floating glass orbs pulsing in sequence; determinate = a glass track with a white fill bar.
  - **Signature detail**: The frosted blur itself — translucent layers with `backdrop-filter` over the indigo-violet depth. If the backdrop is flat, the effect dies; the canvas must keep a colorful gradient.
- **Motion & Animation**: Airy and weightless — 250-350ms `ease-out`; elements float in with a 10px upward drift and `blur(6px) -> blur(0)`. Glass layers shift subtly on hover; no bounce.
- **Signature Preview Snippet**:

```html
<!-- Glass KPI: frosted blur panel over violet depth -->
<div class="glass-card">
  <span class="glass-label">Earnings / 30d</span>
  <strong class="glass-kpi">$12,480.50</strong>
  <span class="glass-delta">+14.2%</span>
  <button class="glass-btn">Queue Post</button>
</div>
```

## 8. Acceptance checklist

- [ ] No raw hex outside the token block; all brand colors resolve from tokens.
- [ ] All numeric values use `tabular-nums`.
- [ ] Every interactive element has a visible focus state using `--border-focus`.
- [ ] Status badges use the fixed status colors + text label.
- [ ] Both modes render correctly (`data-theme` toggle) and meet AA contrast.
- [ ] Card/button treatment matches the signature: border: 1px solid var(--border-default); border-radius: 20px; backdrop-filter: blur(20px); box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.20);
