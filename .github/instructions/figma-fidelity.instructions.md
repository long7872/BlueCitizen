---
description: 'Pixel-accurate implementation of Figma frames: read exact values, resolve them to shared tokens or feature overrides, log every value that has no shared token, and report any difference.'
applyTo: 'lib/features/**'
---

# Figma fidelity rules

Goal: every screen matches its Figma frame 1:1 (colors, typography, spacing, radius, borders, shadows, icons, images, layout, text). Figma is the source of truth. Shared tokens are the way to express Figma values in code, never a reason to approximate them. Any Figma value that has no shared token must be saved in the codebase and logged (Section 9), so nothing is lost between sessions and the shared-code owner can promote it later.

## 1. Get exact values before writing code
- Use the Figma frame link or screenshot provided in the prompt. If none is provided, ask for it. Do not guess from memory or from similar screens.
- When Figma MCP is available, call `get_design_context` (structure and styles), `get_variable_defs` (variables), and `get_screenshot` (visual reference) for the frame.
- Figma MCP output is React + Tailwind. Use it only as a measurement source. Never copy its classes, raw hex values, or markup style into Dart.
- Before coding, write a spec table with one row per distinct element: color (hex and opacity), font (size, weight, line height, letter spacing), padding, gap, corner radius, border (width, color), shadow, icon/image size, width/height behavior (fixed, fill, hug).

## 2. Resolve every value in this order
For every color, text style, spacing, radius, border, and shadow value:
1. Exact match in a shared token (`AppColors`, `AppTextStyles`, `AppSpacing`, `AppRadius`; read their declarations). Use the token.
2. Exact match in this feature's `lib/features/<feature>/<feature>_design_overrides.dart` (read it first). Reuse that constant.
3. Neither exists: create a new override constant and log it (Section 9).

Never use the nearest token and never round a value. Raw values (`Color(0x...)`, raw font sizes, raw spacing numbers) are allowed only inside `<feature>_design_overrides.dart`. Screens reference only tokens or override constants.

## 3. Colors
- Match each Figma color by exact hex (and by variable name when Figma uses variables).
- Fill with opacity: use the exact token or constant with `withAlpha(...)` computed from the Figma opacity (percent x 255 / 100, rounded).
- Gradients: build them from tokens or override constants, using the Figma stops, positions, and angle.
- Exception allowed in screens: `Colors.transparent`.

## 4. Typography
- The font is Afacad Flux through `AppTextStyles`. Never set `fontFamily` as a string and never use a font package.
- Size and weight match an existing style exactly: use that style as is.
- Same base but different weight, color, line height, or letter spacing: define a named text style in the override file, built with `AppTextStyles.<style>.copyWith(...)` using the exact Figma values (colors from tokens). Log it.
- Size not in the scale: define a named text style in the override file with the exact size. Log it.
- Line height: Figma px divided by font size gives `height`; a Figma percent is used directly as the fraction.
- Letter spacing: Figma percent x font size / 100 gives pixels.
- Weights: only use weights declared in the font entries of `pubspec.yaml`. If Figma uses another weight, do not substitute silently: log it as a design delta and add a `REQUEST` to add the font file.
- Match Figma text alignment, max lines, and truncation.

## 5. Spacing, radius, borders, shadows
- Use `AppSpacing` and `AppRadius` only when the value matches the Figma value exactly. Off-scale values (for example 10 or 20) become named constants in the override file and are logged. Never round to the scale.
- Corner radius per corner as in Figma. Border width and color exactly as in Figma; a Figma outside or center stroke changes the element size in Flutter, so adjust the size.
- Shadows: map x, y, blur, spread, and color with opacity directly to `BoxShadow`. A shadow that is not in shared tokens goes into the override file and is logged.

## 6. Layout
- Auto layout becomes `Row`, `Column`, or `Wrap` with the exact gap and padding. Fill becomes `Expanded`/`Flexible`/full width, hug uses natural size, fixed uses an exact size.
- The reference frame is an iPhone 14/15 Pro screen. Do not hardcode the screen width; use fill behavior where Figma uses fill.
- Frames include the status bar and the bottom navigation. Do NOT redraw them: the app shell provides the bottom navigation and the system provides the status bar.
- Respect the scroll behavior implied by the frame (what scrolls, what stays fixed).

## 7. Icons and images
- Use the exact icon or image shown in Figma at the exact size. Do not swap in the nearest Material `Icons.*` unless Figma uses that exact icon.
- Other assets go in `assets/images/<feature>/` (already declared in `pubspec.yaml`). If an asset needs a package that is not in `pubspec.yaml` (for example SVG), do not add it: write a `REQUEST`.

## 8. Text content and states
- Use the exact strings from Figma (language, punctuation, capitalization). Values bound to data come from the providers, not from the Figma sample text.
- Implement only the states visible in the frames (default, selected, disabled, loading, empty, error). Do not invent others.

## 9. Design memory: save new values and log them
Both files below live inside the feature folder, so they respect the "edit only your feature folder" rule.

### 9.1 Override file (code)
- Path: `lib/features/<feature>/<feature>_design_overrides.dart`. Create it the first time a value has no shared token.
- One `abstract final class <Feature>Design` containing `static const` members. Use `static final` for text styles built with `copyWith` and for shadow lists.
- Name each member by its role in the UI (for example `campaignCardOverlay`), never by its value (not `blue2`).
- Every member has a doc comment: `/// Figma: frame "<frame>", layer "<layer>": <exact value>.`
- Never import an override file from another feature.

### 9.2 Notes file (log)
- Path: `lib/features/<feature>/DESIGN_NOTES.md`. If it does not exist, create it with exactly this template:

```
# Design notes: <feature>

Memory of Figma values that have no shared token yet. Append-only table, one row per distinct value. Promotion into `lib/core/theme/` is done only by the shared-code owner.

Status flow: `Open` -> `Requested` -> `Promoted` -> `Migrated`

| ID | Type | Constant | Exact Figma value | Figma frame / layer | Used in | Status | Note |
|----|------|----------|-------------------|---------------------|---------|--------|------|
```

- `Type` is one of: color, textStyle, spacing, radius, border, shadow, fontWeight, asset.

### 9.3 Every time you add an override
1. Add the constant with its doc comment (9.1).
2. Append one row to the table (never rewrite or delete existing rows): ID `<FEATURE>-001`, `-002`, ... in order; type; constant name; exact Figma value; frame and layer; file(s) using it; status `Open`; note with why no token matches and the closest existing token for reference.
3. If the same value already has a row, do not add a second row: add the new file to "Used in".
4. In the response, list both changes under "Design memory updates" and add a `REQUEST` proposing the shared token.

### 9.4 At the start of every UI task
- Read `DESIGN_NOTES.md` if it exists.
- If a row is `Promoted`, use the shared token in the code you write or change, and tell the owner to run a MIGRATION TASK. Do not migrate other files on your own.
- Never edit shared token files (`lib/core/theme/`) except in a task whose prompt starts with `PROMOTION TASK`.
- If a value cannot be read from Figma (no link, MCP unavailable), do not invent it: ask for the frame link or screenshot.

## 10. Self-check and report
- After coding, go through every row of your spec table and confirm the value exists in the code. Fix mismatches before answering.
- Confirm that no screen contains a raw color, font size, or spacing number, and that every override constant has a doc comment and a row in `DESIGN_NOTES.md`.
- Add a "Design deltas" section to the response: element, Figma value, code value, reason, and whether a `REQUEST` is needed. Write "None" only if every row matches.
- Never say "matches Figma 1:1" without completing the check above.