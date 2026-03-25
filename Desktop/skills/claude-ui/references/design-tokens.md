# Design Tokens

These tokens describe a Claude-aligned visual system distilled from public-facing Anthropic and Claude product aesthetics as commonly observed through 2026. Treat them as a practical approximation for implementation, not as an official brand specification.

## Core Palette

### Light mode

| Token | Value | Usage |
| --- | --- | --- |
| `background` | `#F5F0EB` | Main page canvas |
| `surface` | `#FFFFFDFA` | Primary card and panel surface |
| `surfaceVariant` | `#EDE5DD` | Secondary card, input area, muted container |
| `textPrimary` | `#1A1A18` | Main body text |
| `textPrimaryAlt` | `#1C1C1A` | Alternate primary text |
| `textSecondary` | `#6B6B6B` | Secondary or helper text |
| `codeText` | `#1A1A18` | Code foreground |
| `outline` | `#1A1A18` | Key outline or divider color |
| `link` | `#8B5E3C` | Link and emphasis |
| `primary` | `#8B5E3C` | Primary action |

### Dark mode

| Token | Value | Usage |
| --- | --- | --- |
| `background` | `#1C1B19` | Main page canvas |
| `surface` | `#242320` | Primary card and panel surface |
| `surfaceVariant` | `#2E2D2A` | Secondary card, input area, muted container |
| `textPrimary` | `#ECECEC` | Main body text |
| `textPrimaryAlt` | `#E8E8E6` | Alternate primary text |
| `textSecondary` | `#9B9B9B` | Secondary or helper text |
| `codeText` | `#D4D4D4` | Code foreground |
| `outline` | `#D4D4D4` | Key outline or divider color |
| `link` | `#C8A97E` | Link and emphasis |
| `primary` | `#C8A97E` | Primary action |

## State And Label Colors

These category colors are task-specific additions, not part of any official Anthropic palette.

| Token | Value |
| --- | --- |
| `cet4` | `#4FC3F7` |
| `cet6` | `#81C784` |
| `ielts` | `#FFB74D` |
| `toefl` | `#E57373` |
| `error` | `#B3261E` |

## Typography

- Title and brand-forward headings: `Plus Jakarta Sans`
- Body text and UI copy: `Inter`

If those fonts are unavailable, use a metrically compatible sans fallback and keep line height relaxed.

## Suggested CSS Variables

```css
:root {
  --background: #F5F0EB;
  --surface: #FFFFFDFA;
  --surface-variant: #EDE5DD;
  --text-primary: #1A1A18;
  --text-primary-alt: #1C1C1A;
  --text-secondary: #6B6B6B;
  --outline: #1A1A18;
  --link: #8B5E3C;
  --primary: #8B5E3C;
  --error: #B3261E;
}

.dark {
  --background: #1C1B19;
  --surface: #242320;
  --surface-variant: #2E2D2A;
  --text-primary: #ECECEC;
  --text-primary-alt: #E8E8E6;
  --text-secondary: #9B9B9B;
  --outline: #D4D4D4;
  --link: #C8A97E;
  --primary: #C8A97E;
  --error: #B3261E;
}
```
