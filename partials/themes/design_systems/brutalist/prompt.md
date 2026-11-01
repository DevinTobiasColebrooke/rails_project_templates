# Design System: Brutalist Raw

Use this design system as the complete visual language for this project. It is
one self-consistent "look": a 19-token color contract, typography, radii/border
treatment, component patterns, and motion language. Implement the UI against
these tokens — do not invent colors, shadows, or type styles.

- **Slug:** `brutalist`
- **Mode:** native light theme (dark counterpart included)
- **Vibe:** Stark, unapologetic raw HTML — heavy black borders, monospace everywhere, hard offset shadows, zero rounding.
- **Best for:** Agency publishing logs and power-user tables — a "no chrome, just data" aesthetic.
- **Adjectives:** stark, honest, confrontational
- **Signature detail:** Heavy black outlines + hard offset shadows + mono-everything and zero rounding — it looks like a 1996 default stylesheet with intent.
- **Motion:** Instant — 0-60ms linear; elements hard-cut in with no fade; hover states snap.

## Source of truth

This is a personal, local design-system library (private, not published).

- Repo on disk: `~/dev/design_systems` (private GitHub mirror: https://github.com/DevinTobiasColebrooke/design_systems)
- This system's folder: `systems/brutalist/`
- Machine-readable spec (tokens, fonts, schemas): `systems/brutalist/system.json`
- Drop-in Tailwind v4 theme file: `systems/brutalist/tailwind.css`
- Full component showcase: `systems/brutalist/showcase.html` (open in a browser)

If you have filesystem access, read those files. If you don't, everything you
need is inline below.

## 1. The 19-token contract

Every value below is authoritative. Tokens map 1:1 to CSS custom properties
(`bg-canvas` style) and to Tailwind `brand-*` utilities
(`bg-brand-canvas`, `text-brand-action`, ...). Use tokens everywhere; never use a raw hex
outside this block.

| Token | Native (light) | Dark mode | Usage |
|---|---|---|---|
| `--bg-canvas` | `#f5f5f0` | `#0a0a0a` | Deepest background layer |
| `--bg-surface` | `#ffffff` | `#141414` | Cards, Sidebars, Panes |
| `--bg-surface-elevated` | `#e8e8e0` | `#1f1f1f` | Dropdowns, hovered states |
| `--border-subtle` | `#c9c9c0` | `#2e2e2e` | Very light separation |
| `--border-default` | `#000000` | `#ffffff` | Standard card/form borders |
| `--border-focus` | `#0000ff` | `#00aaff` | Focus states |
| `--text-primary` | `#000000` | `#ffffff` | High contrast title/text |
| `--text-secondary` | `#1a1a1a` | `#d9d9d9` | Standard body paragraph |
| `--text-muted` | `#55554e` | `#8a8a8a` | Descriptions, helper text, dates |
| `--color-action` | `#000000` | `#ffffff` | Primary action |
| `--color-action-hover` | `#333333` | `#d9d9d9` | Action hover |
| `--color-earnings` | `#007a3d` | `#4ade80` | Earnings, Revenue, Profit |
| `--color-earnings-hover` | `#006331` | `#2fc46b` | Earnings hover |
| `--color-automation` | `#0000ff` | `#00aaff` | Playwright, AI, Terminal accents |
| `--color-alert` | `#b45309` | `#fbbf24` | Warnings, pending states |
| `--color-danger` | `#c00000` | `#ff4d4d` | Error, failed status, deletes |
| `--color-action-glow` | `rgba(0, 0, 0, 0.08)` | `rgba(255, 255, 255, 0.12)` | Halo behind action icons |
| `--color-earnings-glow` | `rgba(0, 122, 61, 0.08)` | `rgba(74, 222, 128, 0.10)` | Halo behind earnings icons |
| `--color-automation-glow` | `rgba(0, 0, 255, 0.08)` | `rgba(0, 170, 255, 0.10)` | Halo behind automation icons |

### Tailwind CSS v4 setup

```css
@import "tailwindcss";

:root {
  --bg-canvas: #f5f5f0;
  --bg-surface: #ffffff;
  --bg-surface-elevated: #e8e8e0;
  --border-subtle: #c9c9c0;
  --border-default: #000000;
  --border-focus: #0000ff;
  --text-primary: #000000;
  --text-secondary: #1a1a1a;
  --text-muted: #55554e;
  --color-action: #000000;
  --color-action-hover: #333333;
  --color-earnings: #007a3d;
  --color-earnings-hover: #006331;
  --color-automation: #0000ff;
  --color-alert: #b45309;
  --color-danger: #c00000;
  --color-action-glow: rgba(0, 0, 0, 0.08);
  --color-earnings-glow: rgba(0, 122, 61, 0.08);
  --color-automation-glow: rgba(0, 0, 255, 0.08);
  --action-label: #ffffff; /* readable text color on --color-action fills */
}

[data-theme="dark"] {
  --bg-canvas: #0a0a0a;
  --bg-surface: #141414;
  --bg-surface-elevated: #1f1f1f;
  --border-subtle: #2e2e2e;
  --border-default: #ffffff;
  --border-focus: #00aaff;
  --text-primary: #ffffff;
  --text-secondary: #d9d9d9;
  --text-muted: #8a8a8a;
  --color-action: #ffffff;
  --color-action-hover: #d9d9d9;
  --color-earnings: #4ade80;
  --color-earnings-hover: #2fc46b;
  --color-automation: #00aaff;
  --color-alert: #fbbf24;
  --color-danger: #ff4d4d;
  --color-action-glow: rgba(255, 255, 255, 0.12);
  --color-earnings-glow: rgba(74, 222, 128, 0.10);
  --color-automation-glow: rgba(0, 170, 255, 0.10);
  --action-label: #0d0d12;
}

@theme {
  --font-display: "Space Mono", "Courier New", ui-monospace, monospace;
  --font-sans: "Space Mono", "Courier New", ui-monospace, monospace;
  --font-mono: "Space Mono", "Courier New", ui-monospace, monospace;

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

Equivalent guide: **the full drop-in file is `~/dev/design_systems/systems/brutalist/tailwind.css`** — copy it to
`app/assets/tailwind/design_system.css` and `@import` it from `application.css`.

## 2. Color schemas (optional accent swaps)

These override accents on top of either mode palette. Apply as a class/attribute
that re-declares the listed tokens (everything else stays from the mode palette).

### `raw-red` — Raw Red

Red-led raw UI; use black labels on red fills.

| Token | Value |
|---|---|
| `--color-action` | `#ff4d4d` |
| `--color-action-hover` | `#e03a3a` |
| `--color-earnings` | `#4ade80` |
| `--color-earnings-hover` | `#2fc46b` |
| `--color-automation` | `#00aaff` |
| `--color-alert` | `#fbbf24` |
| `--color-danger` | `#ff2e2e` |
| `--border-focus` | `#ff4d4d` |
| `--color-action-glow` | `rgba(255, 77, 77, 0.14)` |
| `--color-earnings-glow` | `rgba(74, 222, 128, 0.10)` |
| `--color-automation-glow` | `rgba(0, 170, 255, 0.10)` |
### `zine-yellow` — Zine Yellow

Yellow-led zine energy; use black labels on yellow.

| Token | Value |
|---|---|
| `--color-action` | `#fbbf24` |
| `--color-action-hover` | `#e0a60f` |
| `--color-earnings` | `#4ade80` |
| `--color-earnings-hover` | `#2fc46b` |
| `--color-automation` | `#00aaff` |
| `--color-alert` | `#ff8c00` |
| `--color-danger` | `#ff4d4d` |
| `--border-focus` | `#fbbf24` |
| `--color-action-glow` | `rgba(251, 191, 36, 0.16)` |
| `--color-earnings-glow` | `rgba(74, 222, 128, 0.10)` |
| `--color-automation-glow` | `rgba(0, 170, 255, 0.10)` |
## 3. Typography

- **Display** (headings, KPIs, big numbers): `"Space Mono", "Courier New", ui-monospace, monospace`
- **Sans** (body, labels, UI): `"Space Mono", "Courier New", ui-monospace, monospace`
- **Mono** (timestamps, IDs, code, logs): `"Space Mono", "Courier New", ui-monospace, monospace`
- Load the families with the project's normal Google Fonts `<link>` (weights 500-800 for display/sans).

Hard rules:

- Every number (earnings, rates, counts, dates, timers) uses `tabular-nums`.
- Headings/eyebrows use tight tracking; micro-labels are uppercase `text-[10px] tracking-wider`.
- Body text at `text-sm`/`text-xs` for dense operational screens.

## 4. Radii, borders & signature treatment

- Card signature: `border: 3px solid #000000; border-radius: 0; box-shadow: 6px 6px 0 0 #000000;`
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
5. Motion: Instant — 0-60ms linear; elements hard-cut in with no fade; hover states snap.. Respect `prefers-reduced-motion`.
6. Touch targets ≥ 44px on mobile; inline form errors with `aria-live="polite"`.
7. Dark/light: `data-theme="dark"` on `<html>` flips to the counterpart palette.

## 7. Full source spec (component patterns, motion, snippet)

### PROPOSAL-13 — Brutalist Raw

- **slug**: `brutalist`
- **Vibe**: Stark, unapologetic raw HTML — heavy black borders, monospace everywhere, hard offset shadows, zero rounding.
- **Best for**: Agency publishing logs and power-user tables — a "no chrome, just data" aesthetic. Adjectives: stark, honest, confrontational.
- **Palette** (light theme, `is_dark: false`):

| Token | Value | Usage |
|---|---|---|
| `--bg-canvas` | `#f5f5f0` | Off-white raw canvas |
| `--bg-surface` | `#ffffff` | Card and panel fill |
| `--bg-surface-elevated` | `#e8e8e0` | Hover/raised fills |
| `--border-subtle` | `#c9c9c0` | Fine grey hairlines |
| `--border-default` | `#000000` | Heavy black borders (2-3px) |
| `--border-focus` | `#0000ff` | Raw-blue focus outline |
| `--text-primary` | `#000000` | Pure black text |
| `--text-secondary` | `#1a1a1a` | Body text |
| `--text-muted` | `#55554e` | Captions, helper text |
| `--color-action` | `#000000` | Black primary action |
| `--color-action-hover` | `#333333` | Action hover (dark grey) |
| `--color-earnings` | `#007a3d` | Print-green earnings |
| `--color-earnings-hover` | `#006331` | Earnings hover (deeper green) |
| `--color-automation` | `#0000ff` | Raw-blue automation accents |
| `--color-alert` | `#b45309` | Amber-brown warnings |
| `--color-danger` | `#c00000` | Raw-red failed states |
| `--color-action-glow` | `rgba(0, 0, 0, 0.08)` | Grey tint behind action icons |
| `--color-earnings-glow` | `rgba(0, 122, 61, 0.08)` | Green tint behind earnings icons |
| `--color-automation-glow` | `rgba(0, 0, 255, 0.08)` | Blue tint behind automation icons |

- **Typography**: Mono everything — display, sans, and mono all use `"Space Mono", "Courier New", ui-monospace, monospace`. Display at 700, body at 400-700, uppercase labels at `letter-spacing: 0.04em`. Numerals `tabular-nums`. Nothing decorative; every glyph is typewriter-honest.
- **Radii & Borders**: `border-radius: 0` everywhere. Borders are 2-3px solid black (`--border-default`); hairlines are 1px. Shadows are hard offsets (`4px 4px 0 0 #000`) with zero blur.
- **Component Patterns**:
  - **Buttons**: Square, 3px black border, solid black fill with white text; hover inverts (white fill, black text) and shifts the offset shadow. Secondary = white with 3px border. Focus = 3px `#0000ff` outline with a 2px gap.
  - **Cards**: White with 3px black border and a hard 6px black offset shadow; header bar is a solid black strip with white mono text. No gradients, no glows.
  - **Badges/Status**: Square mono chips with 2px black border; publishing = blinking black square; published = green text chip; failed = red text chip. No pills.
  - **Tables**: Stark 1px grid with a thick black header bar (white text); row hover = 4px black left rule. All values mono and aligned.
  - **Forms/Inputs**: 2px black border, no rounding; focus = 3px black border plus a blue offset. Labels are uppercase mono.
  - **Loading**: A blinking block cursor on a `LOADING...` line, or a hard black square bar sweeping; determinate = solid black bar filling from left.
  - **Signature detail**: Heavy black outlines + hard offset shadows + mono-everything and zero rounding — it looks like a 1996 default stylesheet with intent.
- **Motion & Animation**: Instant — 0-60ms linear; elements hard-cut in with no fade. Hover states snap; Turbo Stream inserts appear as abrupt line insertions.
- **Signature Preview Snippet**:

```html
<!-- Brutalist KPI: black border, hard offset shadow, mono -->
<div class="brut-card">
  <span class="brut-label">EARNINGS / 30D</span>
  <strong class="brut-kpi">$12,480</strong>
  <span class="brut-delta">+14.2%</span>
  <button class="brut-btn">QUEUE POST</button>
</div>
```

## 8. Acceptance checklist

- [ ] No raw hex outside the token block; all brand colors resolve from tokens.
- [ ] All numeric values use `tabular-nums`.
- [ ] Every interactive element has a visible focus state using `--border-focus`.
- [ ] Status badges use the fixed status colors + text label.
- [ ] Both modes render correctly (`data-theme` toggle) and meet AA contrast.
- [ ] Card/button treatment matches the signature: border: 3px solid #000000; border-radius: 0; box-shadow: 6px 6px 0 0 #000000;
