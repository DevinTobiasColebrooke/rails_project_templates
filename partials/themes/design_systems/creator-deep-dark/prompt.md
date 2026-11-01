# Design System: Creator Deep Dark

Use this design system as the complete visual language for this project. It is
one self-consistent "look": a 19-token color contract, typography, radii/border
treatment, component patterns, and motion language. Implement the UI against
these tokens — do not invent colors, shadows, or type styles.

- **Slug:** `creator-deep-dark`
- **Mode:** native dark theme (light counterpart included)
- **Vibe:** Sleek, operational, premium command-center UI — dark-mode-first with crisp borders and clearly elevated surfaces.
- **Best for:** The Cadensia baseline: dense performance tables, scripts, email streams, and real-time terminal output.
- **Adjectives:** operational, premium, dark-mode-first
- **Signature detail:** Crisp slate surfaces with indigo action, emerald earnings, and cyan automation accents — a high-performance command center.
- **Motion:** Hotwire-aware transitions: slide-up-fade entries, gauge-fill progress, scale-in modals, pulse states for AI processes.

## Source of truth

This is a personal, local design-system library (private, not published).

- Repo on disk: `~/dev/design_systems` (private GitHub mirror: https://github.com/DevinTobiasColebrooke/design_systems)
- This system's folder: `systems/creator-deep-dark/`
- Machine-readable spec (tokens, fonts, schemas): `systems/creator-deep-dark/system.json`
- Drop-in Tailwind v4 theme file: `systems/creator-deep-dark/tailwind.css`
- Full component showcase: `systems/creator-deep-dark/showcase.html` (open in a browser)

If you have filesystem access, read those files. If you don't, everything you
need is inline below.

## 1. The 19-token contract

Every value below is authoritative. Tokens map 1:1 to CSS custom properties
(`bg-canvas` style) and to Tailwind `brand-*` utilities
(`bg-brand-canvas`, `text-brand-action`, ...). Use tokens everywhere; never use a raw hex
outside this block.

| Token | Native (dark) | Light mode | Usage |
|---|---|---|---|
| `--bg-canvas` | `#090d16` | `#f1f5f9` | Deepest background layer |
| `--bg-surface` | `#0f172a` | `#ffffff` | Cards, Sidebars, Panes |
| `--bg-surface-elevated` | `#1e293b` | `#f8fafc` | Dropdowns, hovered states |
| `--border-subtle` | `#1e293b` | `#e2e8f0` | Very light separation |
| `--border-default` | `#334155` | `#cbd5e1` | Standard card/form borders |
| `--border-focus` | `#6366f1` | `#4f46e5` | Focus states |
| `--text-primary` | `#f8fafc` | `#0f172a` | High contrast title/text |
| `--text-secondary` | `#cbd5e1` | `#334155` | Standard body paragraph |
| `--text-muted` | `#64748b` | `#64748b` | Descriptions, helper text, dates |
| `--color-action` | `#6366f1` | `#4f46e5` | Primary action |
| `--color-action-hover` | `#4f46e5` | `#4338ca` | Action hover |
| `--color-earnings` | `#10b981` | `#059669` | Earnings, Revenue, Profit |
| `--color-earnings-hover` | `#059669` | `#047857` | Earnings hover |
| `--color-automation` | `#06b6d4` | `#0891b2` | Playwright, AI, Terminal accents |
| `--color-alert` | `#f59e0b` | `#d97706` | Warnings, pending states |
| `--color-danger` | `#ef4444` | `#dc2626` | Error, failed status, deletes |
| `--color-action-glow` | `rgba(99, 102, 241, 0.15)` | `rgba(79, 70, 229, 0.12)` | Halo behind action icons |
| `--color-earnings-glow` | `rgba(16, 185, 129, 0.15)` | `rgba(5, 150, 105, 0.12)` | Halo behind earnings icons |
| `--color-automation-glow` | `rgba(6, 182, 212, 0.15)` | `rgba(8, 145, 178, 0.12)` | Halo behind automation icons |

### Tailwind CSS v4 setup

```css
@import "tailwindcss";

:root {
  --bg-canvas: #090d16;
  --bg-surface: #0f172a;
  --bg-surface-elevated: #1e293b;
  --border-subtle: #1e293b;
  --border-default: #334155;
  --border-focus: #6366f1;
  --text-primary: #f8fafc;
  --text-secondary: #cbd5e1;
  --text-muted: #64748b;
  --color-action: #6366f1;
  --color-action-hover: #4f46e5;
  --color-earnings: #10b981;
  --color-earnings-hover: #059669;
  --color-automation: #06b6d4;
  --color-alert: #f59e0b;
  --color-danger: #ef4444;
  --color-action-glow: rgba(99, 102, 241, 0.15);
  --color-earnings-glow: rgba(16, 185, 129, 0.15);
  --color-automation-glow: rgba(6, 182, 212, 0.15);
  --action-label: #ffffff; /* readable text color on --color-action fills */
}

[data-theme="light"] {
  --bg-canvas: #f1f5f9;
  --bg-surface: #ffffff;
  --bg-surface-elevated: #f8fafc;
  --border-subtle: #e2e8f0;
  --border-default: #cbd5e1;
  --border-focus: #4f46e5;
  --text-primary: #0f172a;
  --text-secondary: #334155;
  --text-muted: #64748b;
  --color-action: #4f46e5;
  --color-action-hover: #4338ca;
  --color-earnings: #059669;
  --color-earnings-hover: #047857;
  --color-automation: #0891b2;
  --color-alert: #d97706;
  --color-danger: #dc2626;
  --color-action-glow: rgba(79, 70, 229, 0.12);
  --color-earnings-glow: rgba(5, 150, 105, 0.12);
  --color-automation-glow: rgba(8, 145, 178, 0.12);
  --action-label: #ffffff;
}

@theme {
  --font-display: "Inter", system-ui, -apple-system, sans-serif;
  --font-sans: "Inter", system-ui, -apple-system, sans-serif;
  --font-mono: "Fira Code", "JetBrains Mono", ui-monospace, monospace;

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

Equivalent guide: **the full drop-in file is `~/dev/design_systems/systems/creator-deep-dark/tailwind.css`** — copy it to
`app/assets/tailwind/design_system.css` and `@import` it from `application.css`.

## 2. Typography

- **Display** (headings, KPIs, big numbers): `"Inter", system-ui, -apple-system, sans-serif`
- **Sans** (body, labels, UI): `"Inter", system-ui, -apple-system, sans-serif`
- **Mono** (timestamps, IDs, code, logs): `"Fira Code", "JetBrains Mono", ui-monospace, monospace`
- Load the families with the project's normal Google Fonts `<link>` (weights 500-800 for display/sans).

Hard rules:

- Every number (earnings, rates, counts, dates, timers) uses `tabular-nums`.
- Headings/eyebrows use tight tracking; micro-labels are uppercase `text-[10px] tracking-wider`.
- Body text at `text-sm`/`text-xs` for dense operational screens.

## 3. Radii, borders & signature treatment

- Card signature: `border: 1px solid; border-radius: 0.5rem;`
- Border roles: `--border-subtle` = hairlines/dividers; `--border-default` = card/form borders;
  `--border-focus` = focus rings and active states.
- Radii scale: `sm` 0.375rem (buttons/inputs) · `md` 0.5rem (cards/small panes) · `lg` 0.75rem (big panels/modals).

## 4. Intent color rules (never swap these)

- `action` → primary buttons, links, active nav, focus. Label text on action fills: `#ffffff` (or `var(--action-label)`).
- `earnings` → revenue, profit, payouts, positive deltas.
- `automation` → AI, Playwright, terminal, background jobs.
- `alert` → warnings, pending/publishing states.
- `danger` → errors, failed status, destructive actions.
- **Status colors are fixed** across every design system (meaning never changes):
  draft `#6b7280` · scheduled `#3b82f6` · publishing `#f59e0b` · published `#10b981` · failed `#ef4444`.
  Status is never color alone — always color + label (+ icon).

## 5. Implementation rules (Rails 8 + Tailwind v4 + Hotwire)

1. Use only the tokens above; no arbitrary hex, no default Tailwind palette colors for brand surfaces.
2. Surfaces: canvas = page background, surface = cards/sidebars, surface-elevated = dropdowns/hover.
3. Contrast: text pairs are WCAG AA — `text-primary` on canvas/surface, `text-secondary` for body,
   `text-muted` for helper text. Keep them on their intended backgrounds.
4. Focus: `2px` `--border-focus` ring/outline on every interactive element; never remove outlines without a replacement.
5. Motion: Hotwire-aware transitions: slide-up-fade entries, gauge-fill progress, scale-in modals, pulse states for AI processes.. Respect `prefers-reduced-motion`.
6. Touch targets ≥ 44px on mobile; inline form errors with `aria-live="polite"`.
7. Dark/light: `data-theme="light"` on `<html>` flips to the counterpart palette.

## 6. Full source spec (component patterns, motion, snippet)



## 7. Acceptance checklist

- [ ] No raw hex outside the token block; all brand colors resolve from tokens.
- [ ] All numeric values use `tabular-nums`.
- [ ] Every interactive element has a visible focus state using `--border-focus`.
- [ ] Status badges use the fixed status colors + text label.
- [ ] Both modes render correctly (`data-theme` toggle) and meet AA contrast.
- [ ] Card/button treatment matches the signature: border: 1px solid; border-radius: 0.5rem;
