# Release Notes

This document lists new features, bug fixes and other changes implemented in each version of Cody Product Builder.

The order of releases listed below are descending — the latest version is always shown at the top.

---

# v1.6.0 - Unified Build Command - 2026-03-14

## Overview
Consolidated `:cody build backlog`, `:cody build version`, and `:cody patch` into a single guided `:cody build` command. Reduces the command surface from 6 to 4, making it simpler for non-technical users to navigate the build phase.

## Key Features
- **Unified `:cody build` command** -- One entry point for all build work. Creates the feature backlog automatically if it doesn't exist, explains what it is, then presents a menu:
  1. Create a new version
  2. Work on an existing version
  3. Work on a patch (quick fix or small enhancement)
- **Workflow banners** -- Each delegated workflow now shows its own banner (`BUILD VERSION : START`, `NEW VERSION : START`, `PATCH : START`) so the user always knows which workflow they're in
- **Simplified command set** -- Down to 4 commands: `help`, `plan`, `build`, `refresh`

## Changes
- Created `build.md` as the unified build entry point
- Converted `build-backlog.md` to internal delegation file (removed banner, prereq checks, stop points)
- Converted `patch.md` to internal delegation file (removed prereq checks)
- Deleted `build-version.md` (router replaced by `build.md` menu)
- Removed project settings auto-creation checks from `build-backlog.md`, `patch.md`, and `build-version-existing.md` (centralized in `build.md`)
- Added banners to `build-version-existing.md` and `build-version-new.md`
- Updated all closing messages to reference `:cody build` instead of old commands
- Updated `agent.md` command registry to 4 commands
- Updated README command table and usage instructions

## Other Notes
- All internal workflows (version building, patching, backlog creation) remain functionally identical
- Previous individual commands are no longer available as separate entry points
- project.json auto-creation check now lives in two places: `build.md` and `refresh.md`

---

# v1.5.2 - Project Settings File - 2026-03-14

## Overview
Added a `project.json` file that tracks project metadata (name, description, version, phase, dates). Created automatically during project setup and updated after version/patch completions. Designed for consumption by external tooling to discover and understand Cody-managed projects.

## Key Features
- **`project.json` created during `:cody plan`** -- Populated from discovery Q&A, confirmed by the user before saving
- **`project.json` created during brownfield setup** -- Populated from codebase analysis, user provides current version
- **Auto-creation on older projects** -- Entry-point commands (`:cody build backlog`, `:cody build version`, `:cody patch`, `:cody refresh`) detect when `project.json` is missing and create it by reading existing project docs, with user confirmation
- **Automatic version tracking** -- `version` field updated after every version or patch completion
- **Phase transitions** -- `phase` field updates from `"plan"` to `"build"` when entering the build phase
- **Name/description sync via refresh** -- When `:cody refresh` updates PRD/plan docs, it checks if the project name or description changed and offers to update `project.json` (with user confirmation)

## Other Notes
- Template stored at `.cody/templates/project.json`
- All dates use `YYYY-MM-DD` (ISO 8601) format
- `project.json` lives at `cody-projects/product-builder/project.json` (project root)

---

# v1.5.1 - Patch Workflow Improvements - 2026-03-13

## Overview
Improvements to the patch workflow and template based on initial usage feedback.

## Enhancements
- **Patch title now includes name** — Patch template title and version field now include both version number and name (e.g., "v0.2.1 -- Fix Login Bug") instead of just the version number
- **Agent verification step** — New "VERIFY THE FIX" step where the agent runs its own checks (compile, tests, sanity check) before handing off to the user
- **User testing step** — New "USER TESTING" step where the agent presents testing notes, waits for user confirmation, and loops back to fix if issues are found
- **Improved closing message** — Updated to tell the user to commit and push (previously only said commit)

---

# v1.5.0 - Patches & Command Restructure - 2026-03-12

## Overview
Two changes in this release: (1) lightweight patches for quick fixes that skip the full version build cycle, and (2) a command restructure that simplifies the command surface from 9 commands down to 6.

## Key Features

### Patches
- **`:cody patch` command** — New command that kicks off a streamlined patch workflow: brief Q&A to understand the problem, user-confirmed plan, fix, auto-generated patch document, and release notes update
- **Patch template** — New `patch.md` template in `.cody/templates/build/` with structured fields for version, date, type, original prompt, problem, plan, solution, files changed (auto-generated), and testing notes
- **Patch versioning** — Patches use the same `v[major.minor.patch]` numbering as versions, incrementing the patch segment (e.g., v1.1.0 is a version, v1.1.1 is a patch)
- **Patch folders in build directory** — Patch folders live alongside version folders in `cody-projects/product-builder/build/`, distinguished by containing only a `patch.md` file

### Command Restructure
- **`:cody build` → `:cody build backlog`** — Renamed for clarity (it creates the feature backlog, not a build)
- **`:cody version add` + `:cody version build` → `:cody build version`** — Merged into a single router command that asks "existing or new?" and delegates accordingly
- **`:cody refresh update` folded into `:cody refresh`** — Refresh now asks "Would you like me to update the PRD, plan, and release notes?" at the end, instead of requiring a separate command
- **`:cody relearn` removed** — Redundant with the `/cody` slash command activation, which reads the same files
- **Internal files renamed** — `version-build.md` → `build-version-existing.md`, `version-add.md` → `build-version-new.md` so all build-related files group together alphabetically

### Final 6-Command Set
| Command | Description |
|---------|-------------|
| `:cody help` | Shows help and all available commands |
| `:cody plan` | Starts the PLAN phase |
| `:cody build backlog` | Generates the feature backlog from the plan |
| `:cody build version` | Work on a version — choose existing or add new |
| `:cody patch` | Lightweight fix or small enhancement |
| `:cody refresh` | Refreshes agent memory, optionally updates docs |

## Enhancements
- Updated release notes template with separate entry formats for versions (full entry) and patches (lightweight inline entry with type and summary)
- Updated `agent.md` command registry to reflect 6-command structure
- Updated `refresh.md` to include recent patch documents when refreshing agent memory and to offer document updates at the end
- Updated README with patch documentation, new command table, and file structure diagram
- Internal delegation files (`refresh-update.md`, `refresh-brownfield.md`, `build-version-existing.md`, `build-version-new.md`) now use `internal: true` frontmatter instead of user-facing command names

## Other Notes
- Patches are not tracked in the feature backlog — they are reactive, not planned
- Patches do not include design docs, tasklists, or retrospectives — that's the point
- No changes to the Plan phase workflow, templates, or placeholder system

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
