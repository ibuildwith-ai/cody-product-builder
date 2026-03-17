# Patch -- v1.7.3 Activation Restructure
This document captures a lightweight fix or small enhancement that does not require a full version build cycle.

## Patch Version
v1.7.3 -- Activation Restructure

## Date
2026-03-17

## Type
Small Enhancement

## Original Prompt
User wants to combine backlog items #27 (Rename Commands) and #32 (Consolidate Command Folders). Rename the IDE activation command files from `cody` to `cody-product-builder` so the slash command is `/cody-product-builder`. Then create an `activations/` folder at the project root and move the `.claude/`, `.cursor/`, and `.github/` folders into it, so users can copy whichever IDE folder they need.

## Problem
The activation command files are named `cody` which is generic and could conflict with other skills or tools. They also live at the project root in separate dot-folders (`.claude/`, `.cursor/`, `.github/`), cluttering the root directory. Users need a clear, standardized way to find and copy the activation file for their IDE.

## Plan
1. Rename the activation command files:
   - `.claude/commands/cody.md` to `.claude/commands/cody-product-builder.md`
   - `.cursor/commands/cody.md` to `.cursor/commands/cody-product-builder.md`
   - `.github/prompts/cody.prompt.md` to `.github/prompts/cody-product-builder.prompt.md`
2. Create `activations/` folder at the project root
3. Move `.claude/`, `.cursor/`, and `.github/` into `activations/`
4. Update `agent.md` references to reflect the new paths
5. Update `activate.md` if it references old paths
6. Update README to reflect the new structure

## Solution
1. Renamed all three activation command files from `cody` to `cody-product-builder` (the slash command is now `/cody-product-builder` instead of `/cody`)
2. Created `activations/` folder at the project root
3. Moved `.claude/`, `.cursor/`, and `.github/` from the project root into `activations/`
4. Updated `refresh-brownfield.md` to reference the new file names and add `activations/` to the skip list
5. Updated `brownfield-analysis.md` and `plan.md` project structure references to reflect the new paths
6. Updated `README.md`: version badge, file structure diagram, installation instructions, and activation commands

## Files Changed

| File | Action |
|------|--------|
| `activations/.claude/commands/cody-product-builder.md` | Created (renamed from `.claude/commands/cody.md`) |
| `activations/.cursor/commands/cody-product-builder.md` | Created (renamed from `.cursor/commands/cody.md`) |
| `activations/.github/prompts/cody-product-builder.prompt.md` | Created (renamed from `.github/prompts/cody.prompt.md`) |
| `.claude/commands/cody.md` | Deleted |
| `.cursor/commands/cody.md` | Deleted |
| `.github/prompts/cody.prompt.md` | Deleted |
| `.cody/commands/refresh-brownfield.md` | Modified (updated skip list with new file names and activations/ folder) |
| `cody-projects/product-builder/plan/plan.md` | Modified (updated entry layer paths) |
| `cody-projects/product-builder/plan/brownfield-analysis.md` | Modified (updated project structure table) |
| `README.md` | Modified (version badge, file structure, install/activation instructions) |

## Testing Notes
1. Verify `activations/` folder exists at the project root and contains `.claude/`, `.cursor/`, and `.github/` with the renamed files
2. Verify the old `.claude/`, `.cursor/`, `.github/` folders no longer exist at the project root
3. Verify `.cody/` folder is untouched and still at the project root
4. Copy `activations/.claude/` to the project root as `.claude/` and test that `/cody-product-builder` activates Cody correctly in Claude Code
5. Check the README file structure diagram and installation instructions match the new layout
