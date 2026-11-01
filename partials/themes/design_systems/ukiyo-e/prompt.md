# Design System: Japanese Ukiyo-e / Woodblock Print

Use this design system as the complete visual language for this project. It is
one self-consistent "look": a 19-token color contract, typography, radii/border
treatment, component patterns, and motion language. Implement the UI against
these tokens — do not invent colors, shadows, or type styles.

- **Slug:** `ukiyo-e`
- **Mode:** native light theme (dark counterpart included)
- **Vibe:** The great wave of data — indigo, washi paper, and vermilion seals composed like a woodblock print.
- **Best for:** Product show pages and the campaign calendar — calm, disciplined surfaces with artful accents.
- **Adjectives:** serene, disciplined, artful
- **Signature detail:** The vermilion hanko seal used as the logo mark and status stamp, plus double-line frames and washi texture — a print, not a screen.
- **Motion:** Slow and ceremonial: entries use a “paper-turn” feel (400ms, slight rotateX, fade); Turbo Stream updates wipe in with a vertical “iris” reveal.

## Source of truth

This is a personal, local design-system library (private, not published).

- Repo on disk: `~/dev/design_systems` (private GitHub mirror: https://github.com/DevinTobiasColebrooke/design_systems)
- This system's folder: `systems/ukiyo-e/`
- Machine-readable spec (tokens, fonts, schemas): `systems/ukiyo-e/system.json`
- Drop-in Tailwind v4 theme file: `systems/ukiyo-e/tailwind.css`
- Full component showcase: `systems/ukiyo-e/showcase.html` (open in a browser)

If you have filesystem access, read those files. If you don't, everything you
need is inline below.

## 1. The 19-token contract

Every value below is authoritative. Tokens map 1:1 to CSS custom properties
(`bg-canvas` style) and to Tailwind `brand-*` utilities
(`bg-brand-canvas`, `text-brand-action`, ...). Use tokens everywhere; never use a raw hex
outside this block.

| Token | Native (light) | Dark mode | Usage |
|---|---|---|---|
| `--bg-canvas` | `#efe6cf` | `#161b2e` | Deepest background layer |
| `--bg-surface` | `#f7f1e0` | `#1e2438` | Cards, Sidebars, Panes |
| `--bg-surface-elevated` | `#fffaf0` | `#2a3148` | Dropdowns, hovered states |
| `--border-subtle` | `#ddd0b0` | `#363e57` | Very light separation |
| `--border-default` | `#b7a37c` | `#4c5574` | Standard card/form borders |
| `--border-focus` | `#d9423a` | `#e0604a` | Focus states |
| `--text-primary` | `#20263f` | `#f0e8d2` | High contrast title/text |
| `--text-secondary` | `#4c4f63` | `#c7c2ae` | Standard body paragraph |
| `--text-muted` | `#6f6c5e` | `#8d8c7a` | Descriptions, helper text, dates |
| `--color-action` | `#d9423a` | `#c9422c` | Primary action |
| `--color-action-hover` | `#bd342e` | `#ae3826` | Action hover |
| `--color-earnings` | `#2e6b4f` | `#7fae6a` | Earnings, Revenue, Profit |
| `--color-earnings-hover` | `#245640` | `#6b9957` | Earnings hover |
| `--color-automation` | `#2f5d9e` | `#6f95cf` | Playwright, AI, Terminal accents |
| `--color-alert` | `#c98a1b` | `#d9a03c` | Warnings, pending states |
| `--color-danger` | `#a22f2f` | `#c95c4a` | Error, failed status, deletes |
| `--color-action-glow` | `rgba(217, 66, 58, 0.14)` | `rgba(201, 66, 44, 0.16)` | Halo behind action icons |
| `--color-earnings-glow` | `rgba(46, 107, 79, 0.14)` | `rgba(127, 174, 106, 0.14)` | Halo behind earnings icons |
| `--color-automation-glow` | `rgba(47, 93, 158, 0.14)` | `rgba(111, 149, 207, 0.14)` | Halo behind automation icons |

### Tailwind CSS v4 setup

```css
@import "tailwindcss";

:root {
  --bg-canvas: #efe6cf;
  --bg-surface: #f7f1e0;
  --bg-surface-elevated: #fffaf0;
  --border-subtle: #ddd0b0;
  --border-default: #b7a37c;
  --border-focus: #d9423a;
  --text-primary: #20263f;
  --text-secondary: #4c4f63;
  --text-muted: #6f6c5e;
  --color-action: #d9423a;
  --color-action-hover: #bd342e;
  --color-earnings: #2e6b4f;
  --color-earnings-hover: #245640;
  --color-automation: #2f5d9e;
  --color-alert: #c98a1b;
  --color-danger: #a22f2f;
  --color-action-glow: rgba(217, 66, 58, 0.14);
  --color-earnings-glow: rgba(46, 107, 79, 0.14);
  --color-automation-glow: rgba(47, 93, 158, 0.14);
  --action-label: #ffffff; /* readable text color on --color-action fills */
}

[data-theme="dark"] {
  --bg-canvas: #161b2e;
  --bg-surface: #1e2438;
  --bg-surface-elevated: #2a3148;
  --border-subtle: #363e57;
  --border-default: #4c5574;
  --border-focus: #e0604a;
  --text-primary: #f0e8d2;
  --text-secondary: #c7c2ae;
  --text-muted: #8d8c7a;
  --color-action: #c9422c;
  --color-action-hover: #ae3826;
  --color-earnings: #7fae6a;
  --color-earnings-hover: #6b9957;
  --color-automation: #6f95cf;
  --color-alert: #d9a03c;
  --color-danger: #c95c4a;
  --color-action-glow: rgba(201, 66, 44, 0.16);
  --color-earnings-glow: rgba(127, 174, 106, 0.14);
  --color-automation-glow: rgba(111, 149, 207, 0.14);
  --action-label: #ffffff;
}

@theme {
  --font-display: "Shippori Mincho B1", "Noto Serif JP", Georgia, serif;
  --font-sans: "Zen Kaku Gothic New", "Inter", system-ui, sans-serif;
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

Equivalent guide: **the full drop-in file is `~/dev/design_systems/systems/ukiyo-e/tailwind.css`** — copy it to
`app/assets/tailwind/design_system.css` and `@import` it from `application.css`.

## 2. Color schemas (optional accent swaps)

These override accents on top of either mode palette. Apply as a class/attribute
that re-declares the listed tokens (everything else stays from the mode palette).

### `gold-leaf` — Gold Leaf

Gold-led nocturnal print; use cream bold labels on gold.

| Token | Value |
|---|---|
| `--color-action` | `#d9a03c` |
| `--color-action-hover` | `#c28a2b` |
| `--color-earnings` | `#7fae6a` |
| `--color-earnings-hover` | `#6b9957` |
| `--color-automation` | `#6f95cf` |
| `--color-alert` | `#b8860b` |
| `--color-danger` | `#c95c4a` |
| `--border-focus` | `#d9a03c` |
| `--color-action-glow` | `rgba(217, 160, 60, 0.16)` |
| `--color-earnings-glow` | `rgba(127, 174, 106, 0.14)` |
| `--color-automation-glow` | `rgba(111, 149, 207, 0.14)` |
### `spring-blossom` — Spring Blossom

Sakura pink-led with green and indigo; use cream bold labels.

| Token | Value |
|---|---|
| `--color-action` | `#e87d9e` |
| `--color-action-hover` | `#cf6687` |
| `--color-earnings` | `#7fae6a` |
| `--color-earnings-hover` | `#6b9957` |
| `--color-automation` | `#6f95cf` |
| `--color-alert` | `#d9a03c` |
| `--color-danger` | `#c95c4a` |
| `--border-focus` | `#e87d9e` |
| `--color-action-glow` | `rgba(232, 125, 158, 0.16)` |
| `--color-earnings-glow` | `rgba(127, 174, 106, 0.14)` |
| `--color-automation-glow` | `rgba(111, 149, 207, 0.14)` |
## 3. Typography

- **Display** (headings, KPIs, big numbers): `"Shippori Mincho B1", "Noto Serif JP", Georgia, serif`
- **Sans** (body, labels, UI): `"Zen Kaku Gothic New", "Inter", system-ui, sans-serif`
- **Mono** (timestamps, IDs, code, logs): `"IBM Plex Mono", ui-monospace, monospace`
- Load the families with the project's normal Google Fonts `<link>` (weights 500-800 for display/sans).

Hard rules:

- Every number (earnings, rates, counts, dates, timers) uses `tabular-nums`.
- Headings/eyebrows use tight tracking; micro-labels are uppercase `text-[10px] tracking-wider`.
- Body text at `text-sm`/`text-xs` for dense operational screens.

## 4. Radii, borders & signature treatment

- Card signature: `border: 1px solid var(--border-default); border-radius: 2px; box-shadow: inset 0 0 0 3px var(--bg-surface), inset 0 0 0 4px var(--border-default);`
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
5. Motion: Slow and ceremonial: entries use a “paper-turn” feel (400ms, slight rotateX, fade); Turbo Stream updates wipe in with a vertical “iris” reveal.. Respect `prefers-reduced-motion`.
6. Touch targets ≥ 44px on mobile; inline form errors with `aria-live="polite"`.
7. Dark/light: `data-theme="dark"` on `<html>` flips to the counterpart palette.

## 7. Full source spec (component patterns, motion, snippet)

### PROPOSAL-07 — Japanese Ukiyo-e / Woodblock Print

- **slug**: `ukiyo-e`
- **Vibe**: The great wave of data — indigo, washi paper, and vermilion seals composed like a woodblock print.
- **Best for**: Product show pages and the campaign calendar — calm, disciplined surfaces with artful accents. Adjectives: serene, disciplined, artful.
- **Palette** (light theme, `is_dark: false`):

| Token | Value | Usage |
|---|---|---|
| `--bg-canvas` | `#efe6cf` | Washi-paper canvas |
| `--bg-surface` | `#f7f1e0` | Lighter washi panel fill |
| `--bg-surface-elevated` | `#fffaf0` | Raised paper, modals |
| `--border-subtle` | `#ddd0b0` | Fine ink hairlines |
| `--border-default` | `#b7a37c` | Standard woodblock borders |
| `--border-focus` | `#d9423a` | Vermilion focus outline |
| `--text-primary` | `#20263f` | Indigo-ink headings |
| `--text-secondary` | `#4c4f63` | Body text |
| `--text-muted` | `#6f6c5e` | Captions, dates, fine print |
| `--color-action` | `#d9423a` | Vermilion primary action |
| `--color-action-hover` | `#bd342e` | Action hover (deeper vermilion) |
| `--color-earnings` | `#2e6b4f` | Ukiyo-e green earnings |
| `--color-earnings-hover` | `#245640` | Earnings hover (deeper green) |
| `--color-automation` | `#2f5d9e` | Indigo-blue automation accents |
| `--color-alert` | `#c98a1b` | Gold/ochre warnings |
| `--color-danger` | `#a22f2f` | Dark vermilion destructive states |
| `--color-action-glow` | `rgba(217, 66, 58, 0.14)` | Vermilion tint behind action icons |
| `--color-earnings-glow` | `rgba(46, 107, 79, 0.14)` | Green tint behind earnings icons |
| `--color-automation-glow` | `rgba(47, 93, 158, 0.14)` | Indigo tint behind automation icons |

- **Typography**: Display: `"Shippori Mincho B1", "Noto Serif JP", Georgia, serif` — a modulated, bookish serif for headings. Sans: `"Zen Kaku Gothic New", "Inter", system-ui, sans-serif` for body. Mono: `"IBM Plex Mono", ui-monospace, monospace` for timestamps and IDs. Minimal tracking; numerals `tabular-nums`.
- **Radii & Borders**: Small and crisp — 2px radius on cards and buttons. Borders are 1px thin ink lines. Cards use the **double-line woodblock frame**: a 1px outer border plus a second 1px inner border inset 3px.
- **Component Patterns**:
  - **Buttons**: Rectangular, thin 1px border. Primary = vermilion fill with white text (AA-large, bold). Secondary = outlined in ink with indigo text. Tertiary = text with a small vermilion square before it. Focus = 2px vermilion outline with a 2px gap.
  - **Cards**: Washi-paper fill with the double-line frame; an optional faint woodgrain/watermark (SVG noise at 3% opacity) in one corner. No shadows — print is flat.
  - **Badges/Status**: Seal-stamp badges — small squares with rounded corners (hanko style) in vermilion, indigo, or green; white text. Publishing = indigo seal with a soft breathe.
  - **Tables**: Thin 1px grid lines; header row has a subtle indigo wash; row hover = 1px vermilion left tick. Numbers feel like printed ledger figures.
  - **Forms/Inputs**: Bordered boxes with 1px ink lines; focus = vermilion bottom rule. Labels in small, slightly tracked sans.
  - **Loading**: A brush-stroke bar that sweeps left to right, or a small "wave" motif that gently undulates.
  - **Signature detail**: The vermilion hanko seal used as the logo mark and status stamp, plus double-line frames and washi texture — a print, not a screen.
- **Motion & Animation**: Slow and ceremonial: entries use a "paper-turn" feel (400ms, slight rotateX, fade), and Turbo Stream updates wipe in with a vertical "iris" reveal. Nothing bounces.
- **Signature Preview Snippet**:

```html
<!-- Ukiyo-e calendar day: woodblock frame + vermilion seal -->
<div class="ukiyo-frame">
  <span class="ukiyo-day">MON · 12</span>
  <span class="ukiyo-count">3 posts queued</span>
  <span class="ukiyo-seal">稿</span>
</div>
```

## 8. Acceptance checklist

- [ ] No raw hex outside the token block; all brand colors resolve from tokens.
- [ ] All numeric values use `tabular-nums`.
- [ ] Every interactive element has a visible focus state using `--border-focus`.
- [ ] Status badges use the fixed status colors + text label.
- [ ] Both modes render correctly (`data-theme` toggle) and meet AA contrast.
- [ ] Card/button treatment matches the signature: border: 1px solid var(--border-default); border-radius: 2px; box-shadow: inset 0 0 0 3px var(--bg-surface), inset 0 0 0 4px var(--border-default);
