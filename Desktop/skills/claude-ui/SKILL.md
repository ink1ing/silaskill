---
name: claude-ui
description: Apply a Claude-aligned UI language to specified parts or an entire interface. Use when the user asks to make a web page, app screen, component library, design tokens, Android Material theme, iOS palette, or frontend artifact feel visually aligned with Anthropic and Claude product aesthetics as commonly seen through 2026, while avoiding direct logo misuse, deceptive cloning, or claims of official endorsement.
---

# Claude UI

Use this skill to restyle part of a product or a full interface so it feels Claude-aligned: warm neutrals, high readability, restrained contrast, editorial whitespace, soft surfaces, and brown-gold emphasis.

This skill is for visual alignment, not for impersonation. Treat the result as "inspired by Claude-era Anthropic product design" rather than an official reproduction.

## When To Use

Use this skill when the user wants any of the following:

- A page, app, or component to look closer to Claude or Anthropic products
- A design token set for web, Android, or iOS
- A partial restyle of specific areas such as chat panels, cards, inputs, settings pages, sidebars, docs, or dashboards
- A full-theme migration from an existing design system to a Claude-aligned visual language

Do not use this skill when the user wants a pixel-perfect clone of an Anthropic property, wants logos or trademarks reproduced without permission, or wants UI that could mislead users into thinking the artifact is official Anthropic software.

## Non-Negotiable Guardrails

- Do not claim the output is official, authorized, or endorsed by Anthropic.
- Do not copy protected brand assets unless the user provides rights and explicitly asks for them.
- Do not reproduce logos, wordmarks, proprietary illustrations, or unique product copy from Anthropic sites or apps.
- Do not create deceptive login, billing, or security screens that could be mistaken for real Anthropic surfaces.
- Prefer "inspired by", "Claude-aligned", or "Anthropic-adjacent" wording in documentation and handoff notes.

## Design Intent

Aim for these qualities:

- Warm neutral canvas instead of stark white
- Paper-like surfaces with subtle separation
- Calm typography with editorial spacing
- Clear hierarchy with limited accent usage
- Accessible contrast and restrained ornamentation
- Interfaces that feel thoughtful, quiet, and premium rather than flashy

## Workflow

### 1. Scope The Alignment

First decide whether the user wants:

- Full-theme alignment
- Partial alignment for named regions only
- Token extraction only
- Platform-specific mapping only, such as Android or iOS

If scope is partial, preserve the rest of the existing design system and align only the requested surfaces.

### 2. Build The Token Layer

Start from the token table in [references/design-tokens.md](references/design-tokens.md).

Always define:

- Background
- Surface
- Surface variant
- Primary text
- Secondary text
- Outline
- Link or primary action
- Error

If the target stack supports semantic tokens, map semantic tokens first and component tokens second.

### 3. Apply Layout And Component Rules

Use [references/component-guidelines.md](references/component-guidelines.md) to translate the token set into actual UI behavior.

Typical component rules:

- Large outer padding and generous vertical rhythm
- Rounded but not overly playful corners
- Low-noise cards with visible but soft separation
- Inputs that read as quiet containers, not hard-bordered boxes
- Sparse accent usage reserved for links, CTA, active state, and selected emphasis

### 4. Map To Platform

If the user is building for:

- Web: expose CSS variables or design tokens first
- Android: map tokens through MaterialTheme
- iOS: use palette constants and scene-based accessors

Platform mappings live in [references/platform-mapping.md](references/platform-mapping.md).

### 5. Preserve Originality

Before finalizing, check that the result is aligned in feel but not deceptively identical in brand expression.

Safe ways to differentiate:

- Use different spacing ratios or elevation values
- Adjust radii slightly to fit the host product
- Keep the palette but avoid copying page composition one-to-one
- Reword headings and labels in original language
- Prefer custom illustrations or none at all

## Implementation Notes

When editing code:

- Prefer semantic tokens over hard-coded colors in components
- Add dark mode and light mode together unless the user explicitly scopes one mode
- Keep comments brief and only around the token architecture or unusual mapping decisions
- If working in React, CSS, Swift, Kotlin, or design-token JSON, keep naming stable across platforms

## Output Expectations

A good result usually includes:

- Updated token definitions
- Platform mapping where relevant
- A short note describing what was aligned and what was intentionally left distinct
- Any accessibility or contrast caveats if a host product has conflicting constraints

## Reference Map

- Palette and typography: [references/design-tokens.md](references/design-tokens.md)
- Component behavior and visual heuristics: [references/component-guidelines.md](references/component-guidelines.md)
- Android and iOS mapping details: [references/platform-mapping.md](references/platform-mapping.md)
