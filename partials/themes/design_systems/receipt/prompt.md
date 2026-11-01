# Design System: Receipt Paper

Use this design system as the complete visual language for this project. It is
one self-consistent "look": a 19-token color contract, typography, radii/border
treatment, component patterns, and motion language. Implement the UI against
these tokens — do not invent colors, shadows, or type styles.

- **Slug:** `receipt`
- **Mode:** native light theme (dark counterpart included)
- **Vibe:** A thermal-printer roll — narrow mono columns, faint thermal-gray text, perforated edges, and everything slightly warm-smelling and ephemeral.
- **Best for:** Earnings reports, order summaries, and ledger views — data as a printed transaction tape.
- **Adjectives:** ephemeral, tactile, transactional
- **Signature detail:** The sawtooth perforation + dotted leaders + rubber stamps — unmistakably a receipt, not a dashboard.
- **Motion:** Printer-feed timing: rows appear top-down with 40-80ms stagger, slight translateY(-4px)→0; stamps land with a quick scale 1.15→1 “thump”.

## Source of truth

This is a personal, local design-system library (private, not published).

- Repo on disk: `~/dev/design_systems` (private GitHub mirror: https://github.com/DevinTobiasColebrooke/design_systems)
- This system's folder: `systems/receipt/`
- Machine-readable spec (tokens, fonts, schemas): `systems/receipt/system.json`
- Drop-in Tailwind v4 theme file: `systems/receipt/tailwind.css`
- Full component showcase: `systems/receipt/showcase.html` (open in a browser)

If you have filesystem access, read those files. If you don't, everything you
need is inline below.

## 1. The 19-token contract

Every value below is authoritative. Tokens map 1:1 to CSS custom properties
(`bg-canvas` style) and to Tailwind `brand-*` utilities
(`bg-brand-canvas`, `text-brand-action`, ...). Use tokens everywhere; never use a raw hex
outside this block.

| Token | Native (light) | Dark mode | Usage |
|---|---|---|---|
| `--bg-canvas` | `#e8e4dc` | `#161512` | Deepest background layer |
| `--bg-surface` | `#faf7f0` | `#22211c` | Cards, Sidebars, Panes |
| `--bg-surface-elevated` | `#ffffff` | `#2c2b24` | Dropdowns, hovered states |
| `--border-subtle` | `#e6e0d2` | `#3a382e` | Very light separation |
| `--border-default` | `#c9c2ae` | `#57544a` | Standard card/form borders |
| `--border-focus` | `#2a2a28` | `#d8d4c8` | Focus states |
| `--text-primary` | `#2a2a28` | `#f0eee6` | High contrast title/text |
| `--text-secondary` | `#55534c` | `#c2bfb2` | Standard body paragraph |
| `--text-muted` | `#8a877c` | `#8a877c` | Descriptions, helper text, dates |
| `--color-action` | `#2a2a28` | `#f0eee6` | Primary action |
| `--color-action-hover` | `#4a4a46` | `#d4d1c4` | Action hover |
| `--color-earnings` | `#1f6e43` | `#6fd893` | Earnings, Revenue, Profit |
| `--color-earnings-hover` | `#175a36` | `#54bd7a` | Earnings hover |
| `--color-automation` | `#3a5a8c` | `#7da8e0` | Playwright, AI, Terminal accents |
| `--color-alert` | `#a8622a` | `#e0a45c` | Warnings, pending states |
| `--color-danger` | `#a8322a` | `#e0655c` | Error, failed status, deletes |
| `--color-action-glow` | `rgba(42, 42, 40, 0.08)` | `rgba(240, 238, 230, 0.10)` | Halo behind action icons |
| `--color-earnings-glow` | `rgba(31, 110, 67, 0.10)` | `rgba(111, 216, 147, 0.12)` | Halo behind earnings icons |
| `--color-automation-glow` | `rgba(58, 90, 140, 0.10)` | `rgba(125, 168, 224, 0.12)` | Halo behind automation icons |

### Tailwind CSS v4 setup

```css
@import "tailwindcss";

:root {
  --bg-canvas: #e8e4dc;
  --bg-surface: #faf7f0;
  --bg-surface-elevated: #ffffff;
  --border-subtle: #e6e0d2;
  --border-default: #c9c2ae;
  --border-focus: #2a2a28;
  --text-primary: #2a2a28;
  --text-secondary: #55534c;
  --text-muted: #8a877c;
  --color-action: #2a2a28;
  --color-action-hover: #4a4a46;
  --color-earnings: #1f6e43;
  --color-earnings-hover: #175a36;
  --color-automation: #3a5a8c;
  --color-alert: #a8622a;
  --color-danger: #a8322a;
  --color-action-glow: rgba(42, 42, 40, 0.08);
  --color-earnings-glow: rgba(31, 110, 67, 0.10);
  --color-automation-glow: rgba(58, 90, 140, 0.10);
  --action-label: #ffffff; /* readable text color on --color-action fills */
}

[data-theme="dark"] {
  --bg-canvas: #161512;
  --bg-surface: #22211c;
  --bg-surface-elevated: #2c2b24;
  --border-subtle: #3a382e;
  --border-default: #57544a;
  --border-focus: #d8d4c8;
  --text-primary: #f0eee6;
  --text-secondary: #c2bfb2;
  --text-muted: #8a877c;
  --color-action: #f0eee6;
  --color-action-hover: #d4d1c4;
  --color-earnings: #6fd893;
  --color-earnings-hover: #54bd7a;
  --color-automation: #7da8e0;
  --color-alert: #e0a45c;
  --color-danger: #e0655c;
  --color-action-glow: rgba(240, 238, 230, 0.10);
  --color-earnings-glow: rgba(111, 216, 147, 0.12);
  --color-automation-glow: rgba(125, 168, 224, 0.12);
  --action-label: #0d0d12;
}

@theme {
  --font-display: "Courier Prime", "IBM Plex Mono", ui-monospace, monospace;
  --font-sans: "Courier Prime", "IBM Plex Mono", ui-monospace, monospace;
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

Equivalent guide: **the full drop-in file is `~/dev/design_systems/systems/receipt/tailwind.css`** — copy it to
`app/assets/tailwind/design_system.css` and `@import` it from `application.css`.

## 2. Color schemas (optional accent swaps)

These override accents on top of either mode palette. Apply as a class/attribute
that re-declares the listed tokens (everything else stays from the mode palette).

### `green-bar` — Green Bar

Dot-matrix green-bar ledger paper; use white labels on the green.

| Token | Value |
|---|---|
| `--color-action` | `#2e8b57` |
| `--color-action-hover` | `#247246` |
| `--color-earnings` | `#9a7400` |
| `--color-earnings-hover` | `#806000` |
| `--color-automation` | `#3a5a8c` |
| `--color-alert` | `#a8622a` |
| `--color-danger` | `#a8322a` |
| `--border-focus` | `#2e8b57` |
| `--color-action-glow` | `rgba(46, 139, 87, 0.14)` |
| `--color-earnings-glow` | `rgba(154, 116, 0, 0.12)` |
| `--color-automation-glow` | `rgba(58, 90, 140, 0.12)` |
### `carbon-copy` — Carbon Copy

Blue carbon-paper transfer with green totals; use white labels on the blue.

| Token | Value |
|---|---|
| `--color-action` | `#3a5a8c` |
| `--color-action-hover` | `#2e4872` |
| `--color-earnings` | `#1f6e43` |
| `--color-earnings-hover` | `#175a36` |
| `--color-automation` | `#7d5cc9` |
| `--color-alert` | `#a8622a` |
| `--color-danger` | `#a8322a` |
| `--border-focus` | `#3a5a8c` |
| `--color-action-glow` | `rgba(58, 90, 140, 0.14)` |
| `--color-earnings-glow` | `rgba(31, 110, 67, 0.12)` |
| `--color-automation-glow` | `rgba(125, 92, 201, 0.12)` |
## 3. Typography

- **Display** (headings, KPIs, big numbers): `"Courier Prime", "IBM Plex Mono", ui-monospace, monospace`
- **Sans** (body, labels, UI): `"Courier Prime", "IBM Plex Mono", ui-monospace, monospace`
- **Mono** (timestamps, IDs, code, logs): `"IBM Plex Mono", ui-monospace, monospace`
- Load the families with the project's normal Google Fonts `<link>` (weights 500-800 for display/sans).

Hard rules:

- Every number (earnings, rates, counts, dates, timers) uses `tabular-nums`.
- Headings/eyebrows use tight tracking; micro-labels are uppercase `text-[10px] tracking-wider`.
- Body text at `text-sm`/`text-xs` for dense operational screens.

## 4. Radii, borders & signature treatment

- Card signature: `border: 1px dashed var(--border-default); border-radius: 0;`
- Canvas/texture signature: `background-image: linear-gradient(rgba(42, 42, 40, 0.04) 1px, transparent 1px); background-size: 100% 80px;`
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
5. Motion: Printer-feed timing: rows appear top-down with 40-80ms stagger, slight translateY(-4px)→0; stamps land with a quick scale 1.15→1 “thump”.. Respect `prefers-reduced-motion`.
6. Touch targets ≥ 44px on mobile; inline form errors with `aria-live="polite"`.
7. Dark/light: `data-theme="dark"` on `<html>` flips to the counterpart palette.

## 7. Full source spec (component patterns, motion, snippet)

### PROPOSAL-18 — Receipt Paper

- **slug**: `receipt`
- **Vibe**: A thermal-printer roll — narrow mono columns, faint thermal-gray text, perforated edges, and everything slightly warm-smelling and ephemeral.
- **Best for**: Earnings reports, order summaries, and ledger views — data as a printed transaction tape. Adjectives: ephemeral, tactile, transactional.
- **Palette** (light theme, `is_dark: false`):

| Token | Value | Usage |
|---|---|---|
| `--bg-canvas` | `#e8e4dc` | Counter-top backdrop behind the tape |
| `--bg-surface` | `#faf7f0` | Thermal paper fill |
| `--bg-surface-elevated` | `#ffffff` | Pristine paper (popovers) |
| `--border-subtle` | `#e6e0d2` | Perforation hairlines |
| `--border-default` | `#c9c2ae` | Paper edge / fold lines |
| `--border-focus` | `#2a2a28` | Ink-black focus outline |
| `--text-primary` | `#2a2a28` | Thermal ink black |
| `--text-secondary` | `#55534c` | Body text |
| `--text-muted` | `#8a877c` | Faded thermal gray (aged print) |
| `--color-action` | `#2a2a28` | Ink-black primary actions |
| `--color-action-hover` | `#4a4a46` | Action hover (smeared ink) |
| `--color-earnings` | `#1f6e43` | Green "PAID" stamp ink |
| `--color-earnings-hover` | `#175a36` | Earnings hover (deeper stamp) |
| `--color-automation` | `#3a5a8c` | Blue rubber-stamp accents |
| `--color-alert` | `#a8622a` | Rust "REFUND" stamp ink |
| `--color-danger` | `#a8322a` | Red "VOID" stamp ink |
| `--color-action-glow` | `rgba(42, 42, 40, 0.08)` | Ink bleed tint |
| `--color-earnings-glow` | `rgba(31, 110, 67, 0.10)` | Green stamp tint |
| `--color-automation-glow` | `rgba(58, 90, 140, 0.10)` | Blue stamp tint |

- **Typography**: Mono everything, like a dot-matrix head. Display and body: `"Courier Prime", "IBM Plex Mono", ui-monospace, monospace` at 400-700. All-caps labels with wide `letter-spacing: 0.12em`. Totals in bold; amounts `tabular-nums` with right alignment.
- **Radii & Borders**: None — the tape is a rectangle. Cards get sawtooth perforated top/bottom edges (CSS zigzag via `linear-gradient` triangles). Borders are dashed hairlines (perforation), 1px.
- **Component Patterns**:
  - **Buttons**: Rectangle, 1px solid ink border, uppercase mono label. Primary = ink-black fill with paper-white text; hover looks like double-strike (bolder, slight blur). Focus = 2px ink outline.
  - **Cards**: Paper strips with sawtooth edges top and bottom; content is left-aligned mono lines like `1x TIKTOK POST ......... $12.00`. A faint horizontal fold crease every ~80px.
  - **Badges/Status**: Rubber-stamp style: rotated (-6deg) bordered uppercase text like `PAID`, `PENDING`, `VOID` in stamp inks. No fills — stamp outline only.
  - **Tables**: Pure mono ledger: dotted-leader rows (`label ..... value`), no grid, totals row separated by a dashed 2px rule. Header = small caps.
  - **Forms/Inputs**: Underline-only fields on paper (no box); labels uppercase mono; focus = solid ink underline. Error = red `VOID`-style stamp next to the field.
  - **Loading**: The paper "feeds": content slides up one line at a time (mono rows appearing with a 60ms stagger, like printer output).
  - **Signature detail**: The sawtooth perforation + dotted leaders + rubber stamps — unmistakably a receipt, not a dashboard.
- **Motion & Animation**: Printer-feed timing: rows appear top-down with 40-80ms stagger, slight translateY(-4px) -> 0; no fades to black — paper doesn't glow. Stamps land with a quick scale 1.15 -> 1 "thump".
- **Signature Preview Snippet**:

```html
<!-- Receipt earnings tape: dotted leaders, stamp, perforation -->
<div class="receipt-strip">
  <div class="receipt-line"><span>TIKTOK POST</span><span>.... $12.00</span></div>
  <div class="receipt-line"><span>IG REEL</span><span>........ $8.50</span></div>
  <div class="receipt-total">TOTAL ... $20.50</div>
  <span class="receipt-stamp receipt-paid">PAID</span>
</div>
```

## 8. Acceptance checklist

- [ ] No raw hex outside the token block; all brand colors resolve from tokens.
- [ ] All numeric values use `tabular-nums`.
- [ ] Every interactive element has a visible focus state using `--border-focus`.
- [ ] Status badges use the fixed status colors + text label.
- [ ] Both modes render correctly (`data-theme` toggle) and meet AA contrast.
- [ ] Card/button treatment matches the signature: border: 1px dashed var(--border-default); border-radius: 0;
