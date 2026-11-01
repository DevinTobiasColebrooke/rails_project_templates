# Design System: Voxel Art

Use this design system as the complete visual language for this project. It is
one self-consistent "look": a 19-token color contract, typography, radii/border
treatment, component patterns, and motion language. Implement the UI against
these tokens — do not invent colors, shadows, or type styles.

- **Slug:** `voxel-art`
- **Mode:** native dark theme (light counterpart included)
- **Vibe:** Blocky, isometric-minded 3D pixel world: every pixel is a cube face and the dark canvas glows with neon at the edges.
- **Best for:** Automation cockpit and Playwright run logs — robotic pipelines read like a game console.
- **Adjectives:** blocky, precise, game-console
- **Signature detail:** The cube-lip corner and square status blocks — everything resolves to axis-aligned cubes, even the cursor.
- **Motion:** Chunk-snappy, 60-90ms, linear or stepped easing; elements snap onto the grid rather than fading.

## Source of truth

This is a personal, local design-system library (private, not published).

- Repo on disk: `~/dev/design_systems` (private GitHub mirror: https://github.com/DevinTobiasColebrooke/design_systems)
- This system's folder: `systems/voxel-art/`
- Machine-readable spec (tokens, fonts, schemas): `systems/voxel-art/system.json`
- Drop-in Tailwind v4 theme file: `systems/voxel-art/tailwind.css`
- Full component showcase: `systems/voxel-art/showcase.html` (open in a browser)

If you have filesystem access, read those files. If you don't, everything you
need is inline below.

## 1. The 19-token contract

Every value below is authoritative. Tokens map 1:1 to CSS custom properties
(`bg-canvas` style) and to Tailwind `brand-*` utilities
(`bg-brand-canvas`, `text-brand-action`, ...). Use tokens everywhere; never use a raw hex
outside this block.

| Token | Native (dark) | Light mode | Usage |
|---|---|---|---|
| `--bg-canvas` | `#05060f` | `#eef1f9` | Deepest background layer |
| `--bg-surface` | `#0c0f22` | `#ffffff` | Cards, Sidebars, Panes |
| `--bg-surface-elevated` | `#161a38` | `#e2e7f5` | Dropdowns, hovered states |
| `--border-subtle` | `#232a52` | `#cdd6ee` | Very light separation |
| `--border-default` | `#2f3766` | `#a9b7dc` | Standard card/form borders |
| `--border-focus` | `#7df9ff` | `#0e9fbe` | Focus states |
| `--text-primary` | `#f4f7ff` | `#0a0d1f` | High contrast title/text |
| `--text-secondary` | `#b9c2e8` | `#3a4060` | Standard body paragraph |
| `--text-muted` | `#6b739c` | `#6a7192` | Descriptions, helper text, dates |
| `--color-action` | `#41f0ff` | `#0e9fbe` | Primary action |
| `--color-action-hover` | `#2cd6e6` | `#0c87a2` | Action hover |
| `--color-earnings` | `#4ef36b` | `#1f9d49` | Earnings, Revenue, Profit |
| `--color-earnings-hover` | `#37d456` | `#17833c` | Earnings hover |
| `--color-automation` | `#b86bff` | `#8a4fd8` | Playwright, AI, Terminal accents |
| `--color-alert` | `#ffcc00` | `#9a6b00` | Warnings, pending states |
| `--color-danger` | `#ff4d6d` | `#d93a54` | Error, failed status, deletes |
| `--color-action-glow` | `rgba(65, 240, 255, 0.22)` | `rgba(14, 159, 190, 0.16)` | Halo behind action icons |
| `--color-earnings-glow` | `rgba(78, 243, 107, 0.22)` | `rgba(31, 157, 73, 0.14)` | Halo behind earnings icons |
| `--color-automation-glow` | `rgba(184, 107, 255, 0.22)` | `rgba(138, 79, 216, 0.14)` | Halo behind automation icons |

### Tailwind CSS v4 setup

```css
@import "tailwindcss";

:root {
  --bg-canvas: #05060f;
  --bg-surface: #0c0f22;
  --bg-surface-elevated: #161a38;
  --border-subtle: #232a52;
  --border-default: #2f3766;
  --border-focus: #7df9ff;
  --text-primary: #f4f7ff;
  --text-secondary: #b9c2e8;
  --text-muted: #6b739c;
  --color-action: #41f0ff;
  --color-action-hover: #2cd6e6;
  --color-earnings: #4ef36b;
  --color-earnings-hover: #37d456;
  --color-automation: #b86bff;
  --color-alert: #ffcc00;
  --color-danger: #ff4d6d;
  --color-action-glow: rgba(65, 240, 255, 0.22);
  --color-earnings-glow: rgba(78, 243, 107, 0.22);
  --color-automation-glow: rgba(184, 107, 255, 0.22);
  --action-label: #0d0d12; /* readable text color on --color-action fills */
}

[data-theme="light"] {
  --bg-canvas: #eef1f9;
  --bg-surface: #ffffff;
  --bg-surface-elevated: #e2e7f5;
  --border-subtle: #cdd6ee;
  --border-default: #a9b7dc;
  --border-focus: #0e9fbe;
  --text-primary: #0a0d1f;
  --text-secondary: #3a4060;
  --text-muted: #6a7192;
  --color-action: #0e9fbe;
  --color-action-hover: #0c87a2;
  --color-earnings: #1f9d49;
  --color-earnings-hover: #17833c;
  --color-automation: #8a4fd8;
  --color-alert: #9a6b00;
  --color-danger: #d93a54;
  --color-action-glow: rgba(14, 159, 190, 0.16);
  --color-earnings-glow: rgba(31, 157, 73, 0.14);
  --color-automation-glow: rgba(138, 79, 216, 0.14);
  --action-label: #0d0d12;
}

@theme {
  --font-display: "Chakra Petch", "Space Grotesk", sans-serif;
  --font-sans: "Space Grotesk", system-ui, sans-serif;
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

Equivalent guide: **the full drop-in file is `~/dev/design_systems/systems/voxel-art/tailwind.css`** — copy it to
`app/assets/tailwind/design_system.css` and `@import` it from `application.css`.

## 2. Color schemas (optional accent swaps)

These override accents on top of either mode palette. Apply as a class/attribute
that re-declares the listed tokens (everything else stays from the mode palette).

### `lava-core` — Lava Core

Hot red-orange hero with amber earnings; use dark ink labels.

| Token | Value |
|---|---|
| `--color-action` | `#e8473f` |
| `--color-action-hover` | `#cb372f` |
| `--color-earnings` | `#c67c00` |
| `--color-earnings-hover` | `#a96900` |
| `--color-automation` | `#8a4fd8` |
| `--color-alert` | `#9a6b00` |
| `--color-danger` | `#c0262e` |
| `--border-focus` | `#e8473f` |
| `--color-action-glow` | `rgba(232, 71, 63, 0.16)` |
| `--color-earnings-glow` | `rgba(198, 124, 0, 0.14)` |
| `--color-automation-glow` | `rgba(138, 79, 216, 0.14)` |
### `emerald-block` — Emerald Block

Green-led cube with gold earnings; use dark ink labels.

| Token | Value |
|---|---|
| `--color-action` | `#23b26d` |
| `--color-action-hover` | `#1c9759` |
| `--color-earnings` | `#c67c00` |
| `--color-earnings-hover` | `#a96900` |
| `--color-automation` | `#3f8ef7` |
| `--color-alert` | `#9a6b00` |
| `--color-danger` | `#c0262e` |
| `--border-focus` | `#23b26d` |
| `--color-action-glow` | `rgba(35, 178, 109, 0.16)` |
| `--color-earnings-glow` | `rgba(198, 124, 0, 0.14)` |
| `--color-automation-glow` | `rgba(63, 142, 247, 0.14)` |
## 3. Typography

- **Display** (headings, KPIs, big numbers): `"Chakra Petch", "Space Grotesk", sans-serif`
- **Sans** (body, labels, UI): `"Space Grotesk", system-ui, sans-serif`
- **Mono** (timestamps, IDs, code, logs): `"IBM Plex Mono", ui-monospace, monospace`
- Load the families with the project's normal Google Fonts `<link>` (weights 500-800 for display/sans).

Hard rules:

- Every number (earnings, rates, counts, dates, timers) uses `tabular-nums`.
- Headings/eyebrows use tight tracking; micro-labels are uppercase `text-[10px] tracking-wider`.
- Body text at `text-sm`/`text-xs` for dense operational screens.

## 4. Radii, borders & signature treatment

- Card signature: `border: 2px solid; border-radius: 0; box-shadow: 4px 4px 0 0 rgba(0, 0, 0, 0.65);`
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
5. Motion: Chunk-snappy, 60-90ms, linear or stepped easing; elements snap onto the grid rather than fading.. Respect `prefers-reduced-motion`.
6. Touch targets ≥ 44px on mobile; inline form errors with `aria-live="polite"`.
7. Dark/light: `data-theme="light"` on `<html>` flips to the counterpart palette.

## 7. Full source spec (component patterns, motion, snippet)

### PROPOSAL-02 — Voxel Art

- **slug**: `voxel-art`
- **Vibe**: Blocky, isometric-minded 3D pixel world: every pixel is a cube face and the dark canvas glows with neon at the edges.
- **Best for**: Automation cockpit and Playwright run logs — robotic pipelines read like a game console. Adjectives: blocky, precise, game-console.
- **Palette** (dark theme, `is_dark: true`):

| Token | Value | Usage |
|---|---|---|
| `--bg-canvas` | `#05060f` | Deep space-navy black; app canvas |
| `--bg-surface` | `#0c0f22` | Cube-face panel fill |
| `--bg-surface-elevated` | `#161a38` | Raised cube faces, popovers |
| `--border-subtle` | `#232a52` | Pixel-grid hairlines |
| `--border-default` | `#2f3766` | Standard cube-edge borders |
| `--border-focus` | `#7df9ff` | Electric-cyan focus outline |
| `--text-primary` | `#f4f7ff` | High-contrast text on dark faces |
| `--text-secondary` | `#b9c2e8` | Body text |
| `--text-muted` | `#6b739c` | Helper text, coordinates, IDs |
| `--color-action` | `#41f0ff` | Neon-cyan primary action |
| `--color-action-hover` | `#2cd6e6` | Action hover (deeper cyan) |
| `--color-earnings` | `#4ef36b` | Neon-emerald earnings |
| `--color-earnings-hover` | `#37d456` | Earnings hover (deeper green) |
| `--color-automation` | `#b86bff` | Voxel-purple automation accents |
| `--color-alert` | `#ffcc00` | Warnings, pending states |
| `--color-danger` | `#ff4d6d` | Failed states, deletes |
| `--color-action-glow` | `rgba(65, 240, 255, 0.22)` | Neon aura behind action icons |
| `--color-earnings-glow` | `rgba(78, 243, 107, 0.22)` | Neon aura behind earnings icons |
| `--color-automation-glow` | `rgba(184, 107, 255, 0.22)` | Neon aura behind automation icons |

- **Typography**: Display: `"Chakra Petch", "Space Grotesk", sans-serif` at 600-700 with slightly wide tracking (0.02em). Sans: `"Space Grotesk", system-ui, sans-serif`. Mono: `"IBM Plex Mono", ui-monospace, monospace` — all timestamps, IDs, and log lines are mono. KPIs always `tabular-nums`.
- **Radii & Borders**: Hard squares everywhere — `border-radius: 0`. The only exceptions: 2px on tiny chips and 4px on inputs. 1-2px borders; focus is a 2px `--border-focus` outline, never a ring.
- **Component Patterns**:
  - **Buttons**: Square corners, 2px border, hard 4px offset block shadow (0 blur, like a cube lip). Primary = neon fill with near-black text; hover = the offset flips to the top-left. Secondary = dark fill + neon border. Focus = 2px cyan outline with 2px gap.
  - **Cards**: Square panels with a "cube lip" bottom-right corner (pseudo-element draws a 2px lighter top face + darker side face, implying isometric depth). Hover raises the lip by 2px.
  - **Badges/Status**: Square chips with a pixel-corner notch (one corner cut). Status dot is a 2x2px square block, not a circle. Publishing = blinking square block.
  - **Tables**: Rigid 1px grid with full column rules; header cells tinted as "top cube faces" (lighter); row hover = 2px left neon edge. All numbers monospace.
  - **Forms/Inputs**: Flat square fields, 2px borders, focus = 2px neon outline. Helper text is a small mono caption below.
  - **Loading**: A pixel cube that "steps" through rotation on discrete frames, or three square blocks stacking one at a time.
  - **Signature detail**: The cube-lip corner and square status blocks — everything resolves to axis-aligned cubes, even the cursor.
- **Motion & Animation**: Chunk-snappy, 60-90ms, `linear` or stepped easing; elements snap onto the grid rather than fading. Turbo Stream rows insert with a 2px "block drop" (translateY 4px to 0). No springs, no bounces.
- **Signature Preview Snippet**:

```html
<!-- Voxel publish log line: square edges, pixel status block, mono -->
<div class="vox-log">
  <span class="vox-time">09:42:11</span>
  <span class="vox-tag vox-ok">[PUBLISHED]</span>
  <span class="vox-msg">tiktok-8821.mp4 -> live</span>
  <span class="vox-cursor"></span>
</div>
```

## 8. Acceptance checklist

- [ ] No raw hex outside the token block; all brand colors resolve from tokens.
- [ ] All numeric values use `tabular-nums`.
- [ ] Every interactive element has a visible focus state using `--border-focus`.
- [ ] Status badges use the fixed status colors + text label.
- [ ] Both modes render correctly (`data-theme` toggle) and meet AA contrast.
- [ ] Card/button treatment matches the signature: border: 2px solid; border-radius: 0; box-shadow: 4px 4px 0 0 rgba(0, 0, 0, 0.65);
