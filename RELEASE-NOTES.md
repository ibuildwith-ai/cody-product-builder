# Release Notes

This document lists new features, bug fixes and other changes implemented in each version of Cody Product Builder.

The order of releases listed below are descending — the latest version is always shown at the top.

---

# v1.4.0 - Brownfield Project Support - 2026-02-26

## Overview
Added support for brownfield projects — existing codebases that don't yet have Cody project files. The `:cody refresh` command now automatically detects brownfield projects, performs an autonomous codebase analysis, asks targeted questions, and auto-generates all plan phase documents.

## Key Features
- **Brownfield detection** — `:cody refresh` now detects when application code exists but no Cody project files are present, and automatically triggers the brownfield workflow
- **Autonomous codebase analysis** — The agent examines the project structure, tech stack, dependencies, architecture, data models, API endpoints, and existing features without manual input
- **Brownfield analysis document** — New `brownfield-analysis.md` template and document that captures the technical audit of an existing codebase, replacing `discovery.md` for brownfield projects
- **Auto-generated plan phase** — After analysis and user Q&A, the agent automatically generates `brownfield-analysis.md`, `prd.md`, and `plan.md` with explicit review gates between each document

## Enhancements
- New command file `refresh-brownfield.md` — keeps brownfield logic separate from the existing refresh flow (same delegation pattern as `refresh-update.md`)
- New template `brownfield-analysis.md` in `.cody/templates/plan/` with sections for Project Overview, Tech Stack, Project Structure, Key Files, Dependencies, Architecture, Data Model, Existing Features, User Q&A, and Summary
- Updated `refresh.md` with a brownfield detection gate at the top — existing refresh flow remains unchanged
- Updated `agent.md` with `brownfield-analysis.md` in the Plan phase document table and `:cody refresh brownfield` in the command registry
- The brownfield Q&A uses the same Knowledge Criteria as `:cody plan`, with `help me` and `no more` escape hatches
- Added `brownfield-analysis.md` to the refresh command's review hierarchy for subsequent refreshes

## Other Notes
- For greenfield projects (no existing code), `:cody refresh` now suggests running `:cody plan` instead of silently failing
- The brownfield workflow includes explicit STOP gates: after presenting understanding, after each generated document — matching the iterative review pattern of `:cody plan`

---

# v1.3.0 - Restructure and Improvements - 2026-02-23

## Overview
Major structural reorganization of the Cody Product Builder skill. Project output files are now stored in a shared `cody-projects/` directory, the internal config folder has been flattened, and Cursor support has been added.

## Key Features
- Added Cursor IDE support with `.cursor/commands/cody.md` activation command
- Project output now stored in `./cody-projects/product-builder/` (previously `.cody/project/`), aligning with the shared `cody-projects/` convention used across Cody skills

## Enhancements
- Flattened `.cody/config/` — all config files now live directly in `.cody/` for a simpler structure
- Removed unused `{{cfConfig}}` and `{{cfComponents}}` placeholders
- Removed `{{cfAssets}}`, `{{cfDocs}}`, `{{cfRules}}`, `{{cfPrompts}}` placeholders and the entire `library/` folder — unused and unnecessary
- Removed `:cody assets list` command and associated `assets-list.md` file
- Removed "Storing Images and Assets" section from `:cody help` output
- Fixed `{{cProject}}` typo in plan.md (was missing the "f" — now correctly `{{cfProject}}`)
- Added `cody-projects/` to `.gitignore` so generated project files are not tracked
- Updated README with new file structure diagram, Cursor in activation list, and link to release notes

## Bug Fixes
- Fixed hardcoded path `@.cody/build/` in version naming convention docs — now uses `{{cfWorkPhase}}` placeholder

## Other Notes
- Existing users with files in `.cody/project/` will need to manually move them to `./cody-projects/product-builder/`
