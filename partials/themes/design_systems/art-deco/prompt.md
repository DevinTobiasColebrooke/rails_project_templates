# Design System: Art Deco Noir

Use this design system as the complete visual language for this project. It is
one self-consistent "look": a 19-token color contract, typography, radii/border
treatment, component patterns, and motion language. Implement the UI against
these tokens — do not invent colors, shadows, or type styles.

- **Slug:** `art-deco`
- **Mode:** native dark theme (light counterpart included)
- **Vibe:** 1920s gold-on-black luxury — geometric sunbursts, chevron lines, and champagne accents over deep noir.
- **Best for:** Earnings dashboard and campaign calendar — premium, quiet opulence for high-ticket affiliate reporting.
- **Adjectives:** luxurious, geometric, refined
- **Signature detail:** The sunburst/chevron geometric divider and gold double-line frames — pure Gatsby-era geometry on noir black.
- **Motion:** Measured and stately — 300ms ease-in-out; content fades in with an 8px upward drift (velvet curtain feel).

## Source of truth

This is a personal, local design-system library (private, not published).

- Repo on disk: `~/dev/design_systems` (private GitHub mirror: https://github.com/DevinTobiasColebrooke/design_systems)
- This system's folder: `systems/art-deco/`
- Machine-readable spec (tokens, fonts, schemas): `systems/art-deco/system.json`
- Drop-in Tailwind v4 theme file: `systems/art-deco/tailwind.css`
- Full component showcase: `systems/art-deco/showcase.html` (open in a browser)

If you have filesystem access, read those files. If you don't, everything you
need is inline below.

## 1. The 19-token contract

Every value below is authoritative. Tokens map 1:1 to CSS custom properties
(`bg-canvas` style) and to Tailwind `brand-*` utilities
(`bg-brand-canvas`, `text-brand-action`, ...). Use tokens everywhere; never use a raw hex
outside this block.

| Token | Native (dark) | Light mode | Usage |
|---|---|---|---|
| `--bg-canvas` | `#0d0b09` | `#f6f1e6` | Deepest background layer |
| `--bg-surface` | `#161310` | `#fffdf7` | Cards, Sidebars, Panes |
| `--bg-surface-elevated` | `#211d18` | `#efe7d6` | Dropdowns, hovered states |
| `--border-subtle` | `#2c261e` | `#e0d5bd` | Very light separation |
| `--border-default` | `#4a4134` | `#b8a887` | Standard card/form borders |
| `--border-focus` | `#d4af37` | `#a87f1f` | Focus states |
| `--text-primary` | `#f5f0e6` | `#1c1711` | High contrast title/text |
| `--text-secondary` | `#cfc5b2` | `#4a4236` | Standard body paragraph |
| `--text-muted` | `#8d8271` | `#7a7060` | Descriptions, helper text, dates |
| `--color-action` | `#d4af37` | `#a87f1f` | Primary action |
| `--color-action-hover` | `#b8942f` | `#8f6b18` | Action hover |
| `--color-earnings` | `#e6d3a0` | `#a88d45` | Earnings, Revenue, Profit |
| `--color-earnings-hover` | `#d9c489` | `#937a37` | Earnings hover |
| `--color-automation` | `#c7d1d8` | `#7b8a94` | Playwright, AI, Terminal accents |
| `--color-alert` | `#c9922e` | `#8f6b18` | Warnings, pending states |
| `--color-danger` | `#a63a2e` | `#a63a2e` | Error, failed status, deletes |
| `--color-action-glow` | `rgba(212, 175, 55, 0.18)` | `rgba(168, 127, 31, 0.14)` | Halo behind action icons |
| `--color-earnings-glow` | `rgba(230, 211, 160, 0.14)` | `rgba(168, 141, 69, 0.12)` | Halo behind earnings icons |
| `--color-automation-glow` | `rgba(199, 209, 216, 0.12)` | `rgba(123, 138, 148, 0.10)` | Halo behind automation icons |

### Tailwind CSS v4 setup

```css
@import "tailwindcss";

:root {
  --bg-canvas: #0d0b09;
  --bg-surface: #161310;
  --bg-surface-elevated: #211d18;
  --border-subtle: #2c261e;
  --border-default: #4a4134;
  --border-focus: #d4af37;
  --text-primary: #f5f0e6;
  --text-secondary: #cfc5b2;
  --text-muted: #8d8271;
  --color-action: #d4af37;
  --color-action-hover: #b8942f;
  --color-earnings: #e6d3a0;
  --color-earnings-hover: #d9c489;
  --color-automation: #c7d1d8;
  --color-alert: #c9922e;
  --color-danger: #a63a2e;
  --color-action-glow: rgba(212, 175, 55, 0.18);
  --color-earnings-glow: rgba(230, 211, 160, 0.14);
  --color-automation-glow: rgba(199, 209, 216, 0.12);
  --action-label: #0d0d12; /* readable text color on --color-action fills */
}

[data-theme="light"] {
  --bg-canvas: #f6f1e6;
  --bg-surface: #fffdf7;
  --bg-surface-elevated: #efe7d6;
  --border-subtle: #e0d5bd;
  --border-default: #b8a887;
  --border-focus: #a87f1f;
  --text-primary: #1c1711;
  --text-secondary: #4a4236;
  --text-muted: #7a7060;
  --color-action: #a87f1f;
  --color-action-hover: #8f6b18;
  --color-earnings: #a88d45;
  --color-earnings-hover: #937a37;
  --color-automation: #7b8a94;
  --color-alert: #8f6b18;
  --color-danger: #a63a2e;
  --color-action-glow: rgba(168, 127, 31, 0.14);
  --color-earnings-glow: rgba(168, 141, 69, 0.12);
  --color-automation-glow: rgba(123, 138, 148, 0.10);
  --action-label: #0d0d12;
}

@theme {
  --font-display: "Cinzel", "Marcellus", serif;
  --font-sans: "Cormorant Garamond", "EB Garamond", Georgia, serif;
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

Equivalent guide: **the full drop-in file is `~/dev/design_systems/systems/art-deco/tailwind.css`** — copy it to
`app/assets/tailwind/design_system.css` and `@import` it from `application.css`.

## 2. Color schemas (optional accent swaps)

These override accents on top of either mode palette. Apply as a class/attribute
that re-declares the listed tokens (everything else stays from the mode palette).

### `ruby-noir` — Ruby Noir

Ruby-led deco; use white bold labels on ruby.

| Token | Value |
|---|---|
| `--color-action` | `#a63a2e` |
| `--color-action-hover` | `#8f2f24` |
| `--color-earnings` | `#a88d45` |
| `--color-earnings-hover` | `#937a37` |
| `--color-automation` | `#7b8a94` |
| `--color-alert` | `#8f6b18` |
| `--color-danger` | `#7a1f14` |
| `--border-focus` | `#a63a2e` |
| `--color-action-glow` | `rgba(166, 58, 46, 0.14)` |
| `--color-earnings-glow` | `rgba(168, 141, 69, 0.12)` |
| `--color-automation-glow` | `rgba(123, 138, 148, 0.10)` |
### `emerald-envy` — Emerald Envy

Emerald-led deco; use white bold labels on emerald.

| Token | Value |
|---|---|
| `--color-action` | `#2e6b4f` |
| `--color-action-hover` | `#245640` |
| `--color-earnings` | `#a88d45` |
| `--color-earnings-hover` | `#937a37` |
| `--color-automation` | `#7b8a94` |
| `--color-alert` | `#8f6b18` |
| `--color-danger` | `#a63a2e` |
| `--border-focus` | `#2e6b4f` |
| `--color-action-glow` | `rgba(46, 107, 79, 0.14)` |
| `--color-earnings-glow` | `rgba(168, 141, 69, 0.12)` |
| `--color-automation-glow` | `rgba(123, 138, 148, 0.10)` |
## 3. Typography

- **Display** (headings, KPIs, big numbers): `"Cinzel", "Marcellus", serif`
- **Sans** (body, labels, UI): `"Cormorant Garamond", "EB Garamond", Georgia, serif`
- **Mono** (timestamps, IDs, code, logs): `"IBM Plex Mono", ui-monospace, monospace`
- Load the families with the project's normal Google Fonts `<link>` (weights 500-800 for display/sans).

Hard rules:

- Every number (earnings, rates, counts, dates, timers) uses `tabular-nums`.
- Headings/eyebrows use tight tracking; micro-labels are uppercase `text-[10px] tracking-wider`.
- Body text at `text-sm`/`text-xs` for dense operational screens.

## 4. Radii, borders & signature treatment

- Card signature: `border: 1px solid var(--border-default); border-radius: 0; box-shadow: inset 0 0 0 3px var(--bg-surface), inset 0 0 0 4px var(--border-default);`
- Canvas/texture signature: `background-image: radial-gradient(circle at 92% 8%, rgba(212, 175, 55, 0.14), transparent 45%);`
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
5. Motion: Measured and stately — 300ms ease-in-out; content fades in with an 8px upward drift (velvet curtain feel).. Respect `prefers-reduced-motion`.
6. Touch targets ≥ 44px on mobile; inline form errors with `aria-live="polite"`.
7. Dark/light: `data-theme="light"` on `<html>` flips to the counterpart palette.

## 7. Full source spec (component patterns, motion, snippet)

### PROPOSAL-10 — Art Deco Noir

- **slug**: `art-deco`
- **Vibe**: 1920s gold-on-black luxury — geometric sunbursts, chevron lines, and champagne accents over deep noir.
- **Best for**: Earnings dashboard and campaign calendar — premium, quiet opulence for high-ticket affiliate reporting. Adjectives: luxurious, geometric, refined.
- **Palette** (dark theme, `is_dark: true`):

| Token | Value | Usage |
|---|---|---|
| `--bg-canvas` | `#0d0b09` | Deep warm-black noir canvas |
| `--bg-surface` | `#161310` | Charcoal panel fill |
| `--bg-surface-elevated` | `#211d18` | Raised panels, modals |
| `--border-subtle` | `#2c261e` | Fine shadow hairlines |
| `--border-default` | `#4a4134` | Standard bronze borders |
| `--border-focus` | `#d4af37` | Gold focus outline |
| `--text-primary` | `#f5f0e6` | Cream headings and body |
| `--text-secondary` | `#cfc5b2` | Standard body text |
| `--text-muted` | `#8d8271` | Captions, dates, fine print |
| `--color-action` | `#d4af37` | Gold primary action |
| `--color-action-hover` | `#b8942f` | Action hover (deeper gold) |
| `--color-earnings` | `#e6d3a0` | Champagne earnings |
| `--color-earnings-hover` | `#d9c489` | Earnings hover (deeper champagne) |
| `--color-automation` | `#c7d1d8` | Chrome-silver automation accents |
| `--color-alert` | `#c9922e` | Amber-gold warnings |
| `--color-danger` | `#a63a2e` | Dark red destructive states |
| `--color-action-glow` | `rgba(212, 175, 55, 0.18)` | Gold tint behind action icons |
| `--color-earnings-glow` | `rgba(230, 211, 160, 0.14)` | Champagne tint behind earnings icons |
| `--color-automation-glow` | `rgba(199, 209, 216, 0.12)` | Silver tint behind automation icons |

- **Typography**: Display: `"Cinzel", "Marcellus", serif` — Roman inscriptional caps, `letter-spacing: 0.06em`, used for headings and KPI labels. Sans/body: `"Cormorant Garamond", "EB Garamond", Georgia, serif` at 500-600 (elegant serif body). Mono: `"IBM Plex Mono", ui-monospace, monospace` for timestamps and IDs. Numerals `tabular-nums`; overlines in Cinzel small caps.
- **Radii & Borders**: Sharp and architectural — 0-2px radius. Borders are thin 1px gold/bronze lines; cards use a **double-line deco frame** (outer 1px + inner hairline inset 3px). Dividers are chevron or sunburst motifs, never plain rules.
- **Component Patterns**:
  - **Buttons**: Rectangular, thin gold border, uppercase Cinzel label with wide tracking. Primary = gold fill with black text (`#0d0b09`); hover = champagne. Secondary = transparent with gold border; tertiary = text-only with gold underline. Focus = gold double outline.
  - **Cards**: Noir panels with the double-line gold frame, a chevron divider under the header, and a faint sunburst watermark in the corner. No shadows; depth is implied by gold line weight.
  - **Badges/Status**: Small gold-outlined pills with a diamond status mark (deco, not round); publishing = pulsing gold diamond; published = champagne; failed = dark red diamond.
  - **Tables**: Noir with thin gold rules; header row in cream Cinzel caps; row hover = 1px gold left rule.
  - **Forms/Inputs**: Fields with a single gold baseline; focus = gold double underline. Labels in small cream caps.
  - **Loading**: A rotating sunburst fan (12 rays) or three chevrons sliding in sequence; determinate = a gold segment gauge.
  - **Signature detail**: The sunburst/chevron geometric divider and gold double-line frames — pure Gatsby-era geometry on noir black.
- **Motion & Animation**: Measured and stately — 300ms `ease-in-out`; content fades in with a 8px upward drift (velvet curtain feel). Status changes cross-fade; nothing pops or bounces.
- **Signature Preview Snippet**:

```html
<!-- Deco KPI: gold double-line frame, sunburst divider, cream type -->
<div class="deco-card">
  <span class="deco-overline">EARNINGS THIS QUARTER</span>
  <strong class="deco-kpi">$48,210</strong>
  <span class="deco-sunburst"></span>
  <span class="deco-note">+22% vs prior</span>
</div>
```

## 8. Acceptance checklist

- [ ] No raw hex outside the token block; all brand colors resolve from tokens.
- [ ] All numeric values use `tabular-nums`.
- [ ] Every interactive element has a visible focus state using `--border-focus`.
- [ ] Status badges use the fixed status colors + text label.
- [ ] Both modes render correctly (`data-theme` toggle) and meet AA contrast.
- [ ] Card/button treatment matches the signature: border: 1px solid var(--border-default); border-radius: 0; box-shadow: inset 0 0 0 3px var(--bg-surface), inset 0 0 0 4px var(--border-default);
