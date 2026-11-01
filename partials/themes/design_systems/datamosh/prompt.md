# Design System: Datamosh

Use this design system as the complete visual language for this project. It is
one self-consistent "look": a 19-token color contract, typography, radii/border
treatment, component patterns, and motion language. Implement the UI against
these tokens — do not invent colors, shadows, or type styles.

- **Slug:** `datamosh`
- **Mode:** native dark theme (light counterpart included)
- **Vibe:** Corrupted video compression — macroblocks smeared across the frame, RGB channels slipping out of register, and beautiful accidents where motion vectors bleed.
- **Best for:** Launch moments and the creator feed — glitch-art energy for surfaces that should feel alive and unstable.
- **Adjectives:** chaotic, vivid, generative
- **Signature detail:** The channel slip — RGB-split text and smear-blocks on an otherwise clean, readable UI. Corruption decorates; it never destroys legibility.
- **Motion:** Glitch cadence: mostly still, then a 150-250ms burst (translateX ±2px, clip-path slices, channel split) every 4-8s or on hover. Turbo Stream inserts arrive mid-glitch and resolve clean.

## Source of truth

This is a personal, local design-system library (private, not published).

- Repo on disk: `~/dev/design_systems` (private GitHub mirror: https://github.com/DevinTobiasColebrooke/design_systems)
- This system's folder: `systems/datamosh/`
- Machine-readable spec (tokens, fonts, schemas): `systems/datamosh/system.json`
- Drop-in Tailwind v4 theme file: `systems/datamosh/tailwind.css`
- Full component showcase: `systems/datamosh/showcase.html` (open in a browser)

If you have filesystem access, read those files. If you don't, everything you
need is inline below.

## 1. The 19-token contract

Every value below is authoritative. Tokens map 1:1 to CSS custom properties
(`bg-canvas` style) and to Tailwind `brand-*` utilities
(`bg-brand-canvas`, `text-brand-action`, ...). Use tokens everywhere; never use a raw hex
outside this block.

| Token | Native (dark) | Light mode | Usage |
|---|---|---|---|
| `--bg-canvas` | `#07040c` | `#f2eef8` | Deepest background layer |
| `--bg-surface` | `#120a1e` | `#ffffff` | Cards, Sidebars, Panes |
| `--bg-surface-elevated` | `#1c1130` | `#e6def4` | Dropdowns, hovered states |
| `--border-subtle` | `#2a1a4a` | `#d6c8ec` | Very light separation |
| `--border-default` | `#3f2870` | `#b09ad6` | Standard card/form borders |
| `--border-focus` | `#00ffd5` | `#c42a8a` | Focus states |
| `--text-primary` | `#f2ecff` | `#1a0f2e` | High contrast title/text |
| `--text-secondary` | `#c4b2e8` | `#443a5e` | Standard body paragraph |
| `--text-muted` | `#7a68a8` | `#75688f` | Descriptions, helper text, dates |
| `--color-action` | `#ff2b8f` | `#c42a8a` | Primary action |
| `--color-action-hover` | `#e21d7a` | `#a82074` | Action hover |
| `--color-earnings` | `#ffe14e` | `#9a6d00` | Earnings, Revenue, Profit |
| `--color-earnings-hover` | `#e6c933` | `#7f5a00` | Earnings hover |
| `--color-automation` | `#00ffd5` | `#00806a` | Playwright, AI, Terminal accents |
| `--color-alert` | `#ff9d2b` | `#a85c0c` | Warnings, pending states |
| `--color-danger` | `#ff3d5c` | `#c42a48` | Error, failed status, deletes |
| `--color-action-glow` | `rgba(255, 43, 143, 0.22)` | `rgba(196, 42, 138, 0.16)` | Halo behind action icons |
| `--color-earnings-glow` | `rgba(255, 225, 78, 0.18)` | `rgba(154, 109, 0, 0.12)` | Halo behind earnings icons |
| `--color-automation-glow` | `rgba(0, 255, 213, 0.18)` | `rgba(0, 128, 106, 0.12)` | Halo behind automation icons |

### Tailwind CSS v4 setup

```css
@import "tailwindcss";

:root {
  --bg-canvas: #07040c;
  --bg-surface: #120a1e;
  --bg-surface-elevated: #1c1130;
  --border-subtle: #2a1a4a;
  --border-default: #3f2870;
  --border-focus: #00ffd5;
  --text-primary: #f2ecff;
  --text-secondary: #c4b2e8;
  --text-muted: #7a68a8;
  --color-action: #ff2b8f;
  --color-action-hover: #e21d7a;
  --color-earnings: #ffe14e;
  --color-earnings-hover: #e6c933;
  --color-automation: #00ffd5;
  --color-alert: #ff9d2b;
  --color-danger: #ff3d5c;
  --color-action-glow: rgba(255, 43, 143, 0.22);
  --color-earnings-glow: rgba(255, 225, 78, 0.18);
  --color-automation-glow: rgba(0, 255, 213, 0.18);
  --action-label: #ffffff; /* readable text color on --color-action fills */
}

[data-theme="light"] {
  --bg-canvas: #f2eef8;
  --bg-surface: #ffffff;
  --bg-surface-elevated: #e6def4;
  --border-subtle: #d6c8ec;
  --border-default: #b09ad6;
  --border-focus: #c42a8a;
  --text-primary: #1a0f2e;
  --text-secondary: #443a5e;
  --text-muted: #75688f;
  --color-action: #c42a8a;
  --color-action-hover: #a82074;
  --color-earnings: #9a6d00;
  --color-earnings-hover: #7f5a00;
  --color-automation: #00806a;
  --color-alert: #a85c0c;
  --color-danger: #c42a48;
  --color-action-glow: rgba(196, 42, 138, 0.16);
  --color-earnings-glow: rgba(154, 109, 0, 0.12);
  --color-automation-glow: rgba(0, 128, 106, 0.12);
  --action-label: #ffffff;
}

@theme {
  --font-display: "Space Grotesk", "Rajdhani", sans-serif;
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

Equivalent guide: **the full drop-in file is `~/dev/design_systems/systems/datamosh/tailwind.css`** — copy it to
`app/assets/tailwind/design_system.css` and `@import` it from `application.css`.

## 2. Color schemas (optional accent swaps)

These override accents on top of either mode palette. Apply as a class/attribute
that re-declares the listed tokens (everything else stays from the mode palette).

### `vhs-ntsc` — VHS NTSC

NTSC test-bar accents with cyan chroma; use white bold labels on the bar blue.

| Token | Value |
|---|---|
| `--color-action` | `#3a4ae0` |
| `--color-action-hover` | `#2c38c4` |
| `--color-earnings` | `#9a7400` |
| `--color-earnings-hover` | `#806000` |
| `--color-automation` | `#00b4c8` |
| `--color-alert` | `#b45309` |
| `--color-danger` | `#d42a54` |
| `--border-focus` | `#3a4ae0` |
| `--color-action-glow` | `rgba(58, 74, 224, 0.18)` |
| `--color-earnings-glow` | `rgba(154, 116, 0, 0.12)` |
| `--color-automation-glow` | `rgba(0, 180, 200, 0.16)` |
### `static-ghost` — Static Ghost

Grayscale ghost signal with sepia and slate; corrupted but legible.

| Token | Value |
|---|---|
| `--color-action` | `#4a4a5c` |
| `--color-action-hover` | `#38384a` |
| `--color-earnings` | `#7a6d3c` |
| `--color-earnings-hover` | `#645830` |
| `--color-automation` | `#6a7a8c` |
| `--color-alert` | `#8a5c1c` |
| `--color-danger` | `#a8323c` |
| `--border-focus` | `#4a4a5c` |
| `--color-action-glow` | `rgba(74, 74, 92, 0.12)` |
| `--color-earnings-glow` | `rgba(122, 109, 60, 0.10)` |
| `--color-automation-glow` | `rgba(106, 122, 140, 0.12)` |
## 3. Typography

- **Display** (headings, KPIs, big numbers): `"Space Grotesk", "Rajdhani", sans-serif`
- **Sans** (body, labels, UI): `"Inter", system-ui, sans-serif`
- **Mono** (timestamps, IDs, code, logs): `"JetBrains Mono", monospace`
- Load the families with the project's normal Google Fonts `<link>` (weights 500-800 for display/sans).

Hard rules:

- Every number (earnings, rates, counts, dates, timers) uses `tabular-nums`.
- Headings/eyebrows use tight tracking; micro-labels are uppercase `text-[10px] tracking-wider`.
- Body text at `text-sm`/`text-xs` for dense operational screens.

## 4. Radii, borders & signature treatment

- Card signature: `border: 1px solid var(--border-default); border-radius: 4px;`
- Canvas/texture signature: `background-image: linear-gradient(90deg, rgba(255, 43, 143, 0.04) 0 24px, transparent 24px 72px), linear-gradient(0deg, rgba(0, 255, 213, 0.04) 0 16px, transparent 16px 64px);`
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
5. Motion: Glitch cadence: mostly still, then a 150-250ms burst (translateX ±2px, clip-path slices, channel split) every 4-8s or on hover. Turbo Stream inserts arrive mid-glitch and resolve clean.. Respect `prefers-reduced-motion`.
6. Touch targets ≥ 44px on mobile; inline form errors with `aria-live="polite"`.
7. Dark/light: `data-theme="light"` on `<html>` flips to the counterpart palette.

## 7. Full source spec (component patterns, motion, snippet)

### PROPOSAL-23 — Datamosh

- **slug**: `datamosh`
- **Vibe**: Corrupted video compression — macroblocks smeared across the frame, RGB channels slipping out of register, and beautiful accidents where motion vectors bleed.
- **Best for**: Launch moments and the creator feed — glitch-art energy for surfaces that should feel alive and unstable. Adjectives: chaotic, vivid, generative.
- **Palette** (dark theme, `is_dark: true`):

| Token | Value | Usage |
|---|---|---|
| `--bg-canvas` | `#07040c` | Corrupted frame black-violet |
| `--bg-surface` | `#120a1e` | Panel fill with block smear |
| `--bg-surface-elevated` | `#1c1130` | Raised panels, smeared rows |
| `--border-subtle` | `#2a1a4a` | Macroblock hairlines |
| `--border-default` | `#3f2870` | Standard borders |
| `--border-focus` | `#00ffd5` | Chromatic focus outline |
| `--text-primary` | `#f2ecff` | Clean-signal white headings |
| `--text-secondary` | `#c4b2e8` | Body text |
| `--text-muted` | `#7a68a8` | Compression-noise dim text |
| `--color-action` | `#ff2b8f` | Channel-slip magenta action |
| `--color-action-hover` | `#e21d7a` | Action hover (deeper magenta) |
| `--color-earnings` | `#ffe14e` | Blocked-yellow earnings |
| `--color-earnings-hover` | `#e6c933` | Earnings hover (deeper yellow) |
| `--color-automation` | `#00ffd5` | Teal channel automation |
| `--color-alert` | `#ff9d2b` | Bitrate-collapse amber |
| `--color-danger` | `#ff3d5c` | Stream-failure red |
| `--color-action-glow` | `rgba(255, 43, 143, 0.22)` | Magenta channel bleed |
| `--color-earnings-glow` | `rgba(255, 225, 78, 0.18)` | Yellow block bleed |
| `--color-automation-glow` | `rgba(0, 255, 213, 0.18)` | Teal channel bleed |

- **Typography**: Clean type against dirty backgrounds — the contrast is the point. Display: `"Space Grotesk", "Rajdhani", sans-serif` at 600-700, occasionally RGB-split (1px red + 1px cyan text-shadow). Body: `"Inter", system-ui, sans-serif`. Mono: `"JetBrains Mono", monospace` for corruption artifacts and hex IDs. KPIs `tabular-nums`.
- **Radii & Borders**: Sharp 4px radius. 1px borders; some borders "break" — a CSS mask or gradient makes 10-20% of a border's length vanish or smear, like a corrupted edge.
- **Component Patterns**:
  - **Buttons**: Flat saturated fills with dark text; on hover the RGB channels split (text-shadow shifts ±1px red/cyan) and a few horizontal slice-clips flicker. Focus = 2px `--border-focus` outline.
  - **Cards**: Panels with a subtle macroblock smear (CSS: layered linear-gradients forming offset translucent rectangles at low opacity). One corner may carry a displaced "ghost" copy of the border.
  - **Badges/Status**: Chips with occasional character substitution on hover (`PUBLISHED` -> `PUBL1SH3D`); status dot is a small square that occasionally displaces 2px sideways (block shift).
  - **Tables**: Rows separated by 1px rules; every Nth row (deterministic, e.g. `:nth-child(9n)`) gets a smear overlay or slight horizontal displacement. Numbers stay clean — corruption is decoration, never data.
  - **Forms/Inputs**: Clean fields with 1px borders; the focus ring does a quick RGB-split (2-frame flash). Error text arrives glitched-in then settles.
  - **Loading**: A datamosh preloader: macroblocks of the previous content smear and reassemble; indeterminate = slices of color sliding horizontally at different speeds.
  - **Signature detail**: The channel slip — RGB-split text and smear-blocks on an otherwise clean, readable UI. Corruption decorates; it never destroys legibility.
- **Motion & Animation**: Glitch cadence: mostly still, then a 150-250ms burst (translateX ±2px, clip-path slices, channel split) every 4-8s or on hover. Turbo Stream inserts arrive mid-glitch and resolve clean.
- **Signature Preview Snippet**:

```html
<!-- Datamosh KPI: clean data, RGB-split heading, smear edge -->
<div class="mosh-card">
  <span class="mosh-label mosh-split">EARNINGS / 30d</span>
  <strong class="mosh-kpi">$12,480.50</strong>
</div>
```

---

## Comparison Table

| Slug | Name | Vibe | is_dark | Action color | Canvas | Best for |
|---|---|---|---|---|---|---|
| `cel-shading` | Cel-Shading | Flat, crisp anime/game-keyframe UI with hard ink shadows | true | `#ff6a1a` | `#140f26` | Creator Studio, Ad Wizard |
| `voxel-art` | Voxel Art | Blocky isometric pixel world, neon on deep space navy | true | `#41f0ff` | `#05060f` | Automation cockpit, Playwright logs |
| `comic-book` | Comic Book / Graphic Novel | Bold ink outlines, halftone dots, CMYK primary pop | false | `#e6343c` | `#f6f1e3` | Earnings dashboard, campaign bursts |
| `painterly-watercolor` | Painterly / Watercolor | Soft layered washes and warm paper, hand-painted calm | false | `#9a6234` | `#f4ead8` | Onboarding, product show pages |
| `synthwave` | Retro Synthwave / Neon 80s | Magenta/cyan neon glow, sunset gradients, chrome | true | `#ff2bd6` | `#12051f` | Earnings dashboard after dark, launch moments |
| `terminal` | Terminal / Green Phosphor | CRT terminal with phosphor green, scanlines, mono-everything | true | `#46ff9c` | `#050d07` | Playwright automation, publishing logs, agency feed |
| `ukiyo-e` | Japanese Ukiyo-e / Woodblock Print | Indigo, washi paper, vermilion seals, woodblock frames | false | `#d9423a` | `#efe6cf` | Product show pages, campaign calendar |
| `bauhaus` | Bauhaus / Geometric Modern | Primary color blocks, strict grid, Swiss typography | false | `#e63225` | `#f4f4f0` | Analytics dashboards, dense tables |
| `cyberpunk` | Cyberpunk Neo-Tokyo | Holographic neon city, glitch accents, holo-glass panels | true | `#00f0ff` | `#060a14` | Posting Studio dashboard, real-time publish feed |
| `art-deco` | Art Deco Noir | 1920s gold-on-black luxury, sunbursts and chevrons | true | `#d4af37` | `#0d0b09` | Earnings dashboard, campaign calendar |
| `glassmorphism` | Glassmorphism Frosted | Frosted translucent glass over indigo-violet depth | true | `#5747e0` | `#191037` | Onboarding, posting calendar |
| `steampunk` | Steampunk Brass | Victorian industrial, brass and copper, rivets and gauges | true | `#c9812e` | `#12100c` | Automation cockpit, Playwright run logs |
| `brutalist` | Brutalist Raw | Stark raw HTML, heavy black borders, mono-everything | false | `#000000` | `#f5f5f0` | Agency publishing logs, power-user tables |
| `editorial` | Editorial Magazine | High-fashion print, Didot serif, single red accent | false | `#c8102e` | `#faf8f3` | Product show pages, monthly earnings reports |
| `nordic-minimal` | Nordic Minimal | Scandinavian calm, near-white and muted deep blue | false | `#3d5a80` | `#f6f6f4` | Settings, user flows, daily overview |
| `y2k-pop` | Y2K Bubblegum Pop | Retro-future pastel bubbles, gloss, playful tilt | false | `#ff5fa2` | `#fdeef4` | Creator Studio, launch moments |
| `crt` | CRT Monitor | Curved-glass tube, warm phosphor glow, scanlines and vignette | true | `#ffb347` | `#0c0a08` | Posting history, agency publishing feed |
| `receipt` | Receipt Paper | Thermal-printer tape, mono ledger, perforations and rubber stamps | false | `#2a2a28` | `#e8e4dc` | Earnings reports, order summaries, ledgers |
| `night-vision` | Night Vision | Gen-3 goggles, luminous green-on-black, grain, bloom and reticles | true | `#59ff8a` | `#020603` | Automation cockpit, Playwright run logs |
| `1bit-dither` | 1-Bit Dither | Pure black and white, Bayer-dither shades, zero grays | false | `#000000` | `#f4f1ea` | Power-user tables, publishing logs |
| `depth-map` | Depth Map | Point-cloud depth, cyan-near to magenta-far, wireframe contours | true | `#4ef0ff` | `#04070e` | Analytics dashboards, shooting board |
| `blob-tracking` | Blob Tracking | CV motion detection, drifting blob washes, corner brackets, confidence tags | true | `#5cffb0` | `#050807` | Creator Studio, campaign overviews |
| `datamosh` | Datamosh | Corrupted compression, macroblock smears, RGB channel slips | true | `#ff2b8f` | `#07040c` | Launch moments, creator feed |

---

## Mode Palettes & Color Schemas

Every proposal ships with a **counterpart-mode palette** (the opposite dark/light) and **2 alternate color schemas** (accent overrides that apply on top of whichever mode palette is active). Surfaces/text stay identical; only the accent personality changes.

## 8. Acceptance checklist

- [ ] No raw hex outside the token block; all brand colors resolve from tokens.
- [ ] All numeric values use `tabular-nums`.
- [ ] Every interactive element has a visible focus state using `--border-focus`.
- [ ] Status badges use the fixed status colors + text label.
- [ ] Both modes render correctly (`data-theme` toggle) and meet AA contrast.
- [ ] Card/button treatment matches the signature: border: 1px solid var(--border-default); border-radius: 4px;
