# Design System: Terminal / Green Phosphor

Use this design system as the complete visual language for this project. It is
one self-consistent "look": a 19-token color contract, typography, radii/border
treatment, component patterns, and motion language. Implement the UI against
these tokens — do not invent colors, shadows, or type styles.

- **Slug:** `terminal`
- **Mode:** native dark theme (light counterpart included)
- **Vibe:** You are in the machine — a CRT terminal where every pixel is phosphor green and every word is honest log output.
- **Best for:** Playwright automation cockpit, posting logs, and the agency publishing feed — the “fit for purpose” theme for a product built on browser automation.
- **Adjectives:** precise, no-nonsense, authentic
- **Signature detail:** The scanline overlay (repeating-linear-gradient at ~3px) plus the blinking block cursor and $/> prompts — unmistakably a terminal.
- **Motion:** Instant and mechanical: new log lines “type” in (per-character 0-30ms, per-line 150ms fade); status toggles flicker once.

## Source of truth

This is a personal, local design-system library (private, not published).

- Repo on disk: `~/dev/design_systems` (private GitHub mirror: https://github.com/DevinTobiasColebrooke/design_systems)
- This system's folder: `systems/terminal/`
- Machine-readable spec (tokens, fonts, schemas): `systems/terminal/system.json`
- Drop-in Tailwind v4 theme file: `systems/terminal/tailwind.css`
- Full component showcase: `systems/terminal/showcase.html` (open in a browser)

If you have filesystem access, read those files. If you don't, everything you
need is inline below.

## 1. The 19-token contract

Every value below is authoritative. Tokens map 1:1 to CSS custom properties
(`bg-canvas` style) and to Tailwind `brand-*` utilities
(`bg-brand-canvas`, `text-brand-action`, ...). Use tokens everywhere; never use a raw hex
outside this block.

| Token | Native (dark) | Light mode | Usage |
|---|---|---|---|
| `--bg-canvas` | `#050d07` | `#eef5ef` | Deepest background layer |
| `--bg-surface` | `#0a1a10` | `#fbfdfb` | Cards, Sidebars, Panes |
| `--bg-surface-elevated` | `#0f2417` | `#e0ece4` | Dropdowns, hovered states |
| `--border-subtle` | `#14331f` | `#cfe2d4` | Very light separation |
| `--border-default` | `#1f4d2e` | `#93bda1` | Standard card/form borders |
| `--border-focus` | `#5cff9e` | `#159a4b` | Focus states |
| `--text-primary` | `#b4ffc8` | `#0a2814` | High contrast title/text |
| `--text-secondary` | `#74d99a` | `#2f5c3f` | Standard body paragraph |
| `--text-muted` | `#3f8f60` | `#5c8068` | Descriptions, helper text, dates |
| `--color-action` | `#46ff9c` | `#159a4b` | Primary action |
| `--color-action-hover` | `#2ce084` | `#0f7f3c` | Action hover |
| `--color-earnings` | `#ffd166` | `#9a6d00` | Earnings, Revenue, Profit |
| `--color-earnings-hover` | `#f2b93d` | `#7f5a00` | Earnings hover |
| `--color-automation` | `#6cd6ff` | `#156e9c` | Playwright, AI, Terminal accents |
| `--color-alert` | `#ffb000` | `#8f5e00` | Warnings, pending states |
| `--color-danger` | `#ff6b6b` | `#b3261e` | Error, failed status, deletes |
| `--color-action-glow` | `rgba(70, 255, 156, 0.18)` | `rgba(21, 154, 75, 0.14)` | Halo behind action icons |
| `--color-earnings-glow` | `rgba(255, 209, 102, 0.14)` | `rgba(154, 109, 0, 0.12)` | Halo behind earnings icons |
| `--color-automation-glow` | `rgba(108, 214, 255, 0.14)` | `rgba(21, 110, 156, 0.12)` | Halo behind automation icons |

### Tailwind CSS v4 setup

```css
@import "tailwindcss";

:root {
  --bg-canvas: #050d07;
  --bg-surface: #0a1a10;
  --bg-surface-elevated: #0f2417;
  --border-subtle: #14331f;
  --border-default: #1f4d2e;
  --border-focus: #5cff9e;
  --text-primary: #b4ffc8;
  --text-secondary: #74d99a;
  --text-muted: #3f8f60;
  --color-action: #46ff9c;
  --color-action-hover: #2ce084;
  --color-earnings: #ffd166;
  --color-earnings-hover: #f2b93d;
  --color-automation: #6cd6ff;
  --color-alert: #ffb000;
  --color-danger: #ff6b6b;
  --color-action-glow: rgba(70, 255, 156, 0.18);
  --color-earnings-glow: rgba(255, 209, 102, 0.14);
  --color-automation-glow: rgba(108, 214, 255, 0.14);
  --action-label: #0d0d12; /* readable text color on --color-action fills */
}

[data-theme="light"] {
  --bg-canvas: #eef5ef;
  --bg-surface: #fbfdfb;
  --bg-surface-elevated: #e0ece4;
  --border-subtle: #cfe2d4;
  --border-default: #93bda1;
  --border-focus: #159a4b;
  --text-primary: #0a2814;
  --text-secondary: #2f5c3f;
  --text-muted: #5c8068;
  --color-action: #159a4b;
  --color-action-hover: #0f7f3c;
  --color-earnings: #9a6d00;
  --color-earnings-hover: #7f5a00;
  --color-automation: #156e9c;
  --color-alert: #8f5e00;
  --color-danger: #b3261e;
  --color-action-glow: rgba(21, 154, 75, 0.14);
  --color-earnings-glow: rgba(154, 109, 0, 0.12);
  --color-automation-glow: rgba(21, 110, 156, 0.12);
  --action-label: #0d0d12;
}

@theme {
  --font-display: "VT323", "IBM Plex Mono", monospace;
  --font-sans: "IBM Plex Mono", ui-monospace, monospace;
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

Equivalent guide: **the full drop-in file is `~/dev/design_systems/systems/terminal/tailwind.css`** — copy it to
`app/assets/tailwind/design_system.css` and `@import` it from `application.css`.

## 2. Color schemas (optional accent swaps)

These override accents on top of either mode palette. Apply as a class/attribute
that re-declares the listed tokens (everything else stays from the mode palette).

### `amber-phosphor` — Amber Phosphor

Amber-led terminal; use dark ink labels on amber.

| Token | Value |
|---|---|
| `--color-action` | `#b8860b` |
| `--color-action-hover` | `#9a7209` |
| `--color-earnings` | `#9a6d00` |
| `--color-earnings-hover` | `#7f5a00` |
| `--color-automation` | `#159a4b` |
| `--color-alert` | `#8f5e00` |
| `--color-danger` | `#b3261e` |
| `--border-focus` | `#b8860b` |
| `--color-action-glow` | `rgba(184, 134, 11, 0.14)` |
| `--color-earnings-glow` | `rgba(154, 109, 0, 0.12)` |
| `--color-automation-glow` | `rgba(21, 154, 75, 0.12)` |
### `cyan-phosphor` — Cyan Phosphor

Cyan-led terminal; use dark ink labels on cyan.

| Token | Value |
|---|---|
| `--color-action` | `#0e7490` |
| `--color-action-hover` | `#0c6076` |
| `--color-earnings` | `#9a6d00` |
| `--color-earnings-hover` | `#7f5a00` |
| `--color-automation` | `#159a4b` |
| `--color-alert` | `#8f5e00` |
| `--color-danger` | `#b3261e` |
| `--border-focus` | `#0e7490` |
| `--color-action-glow` | `rgba(14, 116, 144, 0.14)` |
| `--color-earnings-glow` | `rgba(154, 109, 0, 0.12)` |
| `--color-automation-glow` | `rgba(21, 154, 75, 0.12)` |
## 3. Typography

- **Display** (headings, KPIs, big numbers): `"VT323", "IBM Plex Mono", monospace`
- **Sans** (body, labels, UI): `"IBM Plex Mono", ui-monospace, monospace`
- **Mono** (timestamps, IDs, code, logs): `"IBM Plex Mono", ui-monospace, monospace`
- Load the families with the project's normal Google Fonts `<link>` (weights 500-800 for display/sans).

Hard rules:

- Every number (earnings, rates, counts, dates, timers) uses `tabular-nums`.
- Headings/eyebrows use tight tracking; micro-labels are uppercase `text-[10px] tracking-wider`.
- Body text at `text-sm`/`text-xs` for dense operational screens.

## 4. Radii, borders & signature treatment

- Card signature: `border: 1px solid; border-radius: 0;`
- Canvas/texture signature: `background-image: repeating-linear-gradient(0deg, rgba(70, 255, 156, 0.06) 0 1px, transparent 1px 3px);`
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
5. Motion: Instant and mechanical: new log lines “type” in (per-character 0-30ms, per-line 150ms fade); status toggles flicker once.. Respect `prefers-reduced-motion`.
6. Touch targets ≥ 44px on mobile; inline form errors with `aria-live="polite"`.
7. Dark/light: `data-theme="light"` on `<html>` flips to the counterpart palette.

## 7. Full source spec (component patterns, motion, snippet)

### PROPOSAL-06 — Terminal / Green Phosphor

- **slug**: `terminal`
- **Vibe**: You are in the machine — a CRT terminal where every pixel is phosphor green and every word is honest log output.
- **Best for**: Playwright automation cockpit, posting logs, and the agency publishing feed — the "fit for purpose" theme for a product built on browser automation. Adjectives: precise, no-nonsense, authentic.
- **Palette** (dark theme, `is_dark: true`):

| Token | Value | Usage |
|---|---|---|
| `--bg-canvas` | `#050d07` | Near-black CRT phosphor canvas |
| `--bg-surface` | `#0a1a10` | Terminal panel fill |
| `--bg-surface-elevated` | `#0f2417` | Raised panels, log focus rows |
| `--border-subtle` | `#14331f` | Faint grid lines |
| `--border-default` | `#1f4d2e` | Standard borders |
| `--border-focus` | `#5cff9e` | Bright phosphor focus outline |
| `--text-primary` | `#b4ffc8` | Bright green headings and output |
| `--text-secondary` | `#74d99a` | Body/log text |
| `--text-muted` | `#3f8f60` | Dimmed log lines, timestamps |
| `--color-action` | `#46ff9c` | Phosphor-green primary action |
| `--color-action-hover` | `#2ce084` | Action hover (deeper green) |
| `--color-earnings` | `#ffd166` | Amber-phosphor earnings line |
| `--color-earnings-hover` | `#f2b93d` | Earnings hover (deeper amber) |
| `--color-automation` | `#6cd6ff` | Cyan-phosphor automation accents |
| `--color-alert` | `#ffb000` | Amber warnings |
| `--color-danger` | `#ff6b6b` | Red-phosphor failed states |
| `--color-action-glow` | `rgba(70, 255, 156, 0.18)` | Green glow behind active markers |
| `--color-earnings-glow` | `rgba(255, 209, 102, 0.14)` | Amber glow behind earnings markers |
| `--color-automation-glow` | `rgba(108, 214, 255, 0.14)` | Cyan glow behind automation markers |

- **Typography**: Mono everything. Display: `"VT323", "IBM Plex Mono", monospace` used only for very large numerals/headings (it is pixelated at small sizes). Sans and body: `"IBM Plex Mono", ui-monospace, monospace` at 400-600. Labels uppercase at `letter-spacing: 0.08em`. All numbers `tabular-nums`.
- **Radii & Borders**: Square — `border-radius: 0` everywhere, except 2px on buttons. Borders are 1px. No shadows, no glows beyond token glows; the CRT effect comes from scanlines, not depth.
- **Component Patterns**:
  - **Buttons**: Square, 1px border, uppercase mono label. Primary = bright green fill with black text; hover inverts (dark fill, bright green text). Secondary = transparent with 1px border; focus = 1px bright border, no ring.
  - **Cards**: Square with a 1px border and a title bar that reads `[task_id]` or `~/affiliatemanager`; subtle scanline overlay inside. No elevation — flat CRT.
  - **Badges/Status**: Bracket chips: `[PUBLISHED]`, `[FAILED]`, `[RUNNING]` in phosphor colors; publishing = blinking block cursor after the label. Failed = red text on black, never a filled banner.
  - **Tables**: Monospace cells, single 1px grid, header rows prefixed with `>`. Rows are log lines; hover = bright green text.
  - **Forms/Inputs**: Single-line fields with a block underscore cursor; labels prefixed with `$` or `>`. Focus = bright green border.
  - **Loading**: Indeterminate = blinking block cursor on a `$` prompt; determinate = a `[====>    ]` bar built from ASCII-ish segments. No spinners.
  - **Signature detail**: The scanline overlay (repeating-linear-gradient at ~3px) plus the blinking block cursor and `$`/`>` prompts — unmistakably a terminal.
- **Motion & Animation**: Instant and mechanical: new log lines "type" in (per-character 0-30ms, per-line 150ms fade), status toggles flicker once. No springs, no parallax. Everything snaps to a mono grid.
- **Signature Preview Snippet**:

```html
<!-- Terminal publish status: bracket chip + block cursor, mono -->
<div class="term-line">
  <span class="term-time">[09:42:11]</span>
  <span class="term-tag term-ok">PUBLISHED</span>
  <span class="term-msg">tiktok-8821.mp4 -> live · views 120</span>
  <span class="term-cursor"></span>
</div>
```

## 8. Acceptance checklist

- [ ] No raw hex outside the token block; all brand colors resolve from tokens.
- [ ] All numeric values use `tabular-nums`.
- [ ] Every interactive element has a visible focus state using `--border-focus`.
- [ ] Status badges use the fixed status colors + text label.
- [ ] Both modes render correctly (`data-theme` toggle) and meet AA contrast.
- [ ] Card/button treatment matches the signature: border: 1px solid; border-radius: 0;
