# Release Notes

This document lists new features, bug fixes and other changes implemented during a particular build (version or patch).

The order of releases listed below are descending -- the latest version or patch is always shown at the top.

- [v1.10.0 - Configurable Release Notes Path](#v1100---configurable-release-notes-path---2026-03-20)
- [v1.9.0 - Configurable Project Path](#v190---configurable-project-path---2026-03-19)
- [v1.8.0 - Agent Optimization](#v180---agent-optimization---2026-03-17)
- [v1.7.3 - Activation Restructure](#v173---activation-restructure-patch---2026-03-17)
- [v1.7.2 - Consolidate Ideas Into Backlog](#v172---consolidate-ideas-into-backlog---2026-03-15)
- [v1.7.1 - File System Check Safety](#v171---file-system-check-safety---2026-03-14)
- [v1.7.0 - Idea Tracker](#v170---idea-tracker---2026-03-14)
- [v1.6.0 - Unified Build Command](#v160---unified-build-command---2026-03-14)
- [v1.5.2 - Project Settings File](#v152---project-settings-file---2026-03-14)
- [v1.5.1 - Patch Workflow Improvements](#v151---patch-workflow-improvements---2026-03-13)
- [v1.5.0 - Patches & Command Restructure](#v150---patches--command-restructure---2026-03-12)
- [v1.4.0 - Brownfield Project Support](#v140---brownfield-project-support---2026-02-26)
- [v1.3.0 - Restructure and Improvements](#v130---restructure-and-improvements---2026-02-23)

---

# v1.10.0 - Configurable Release Notes Path - 2026-03-20

## Overview
Added a configurable release notes location so users can choose where `release-notes.md` is stored. Previously hardcoded to the build folder, users can now pick from three options: the build folder (`{{projectPath}}`), the project root (`{{projectRoot}}`), or a custom path. The chosen location is stored as `releaseNotesPath` in `cody.json` and resolved via a new `{{cfReleaseNotes}}` placeholder.

## Key Features
- **Configurable release notes path** -- Users choose where to store `release-notes.md` during project setup. Three options: build folder (default for fresh installs is project root), project root, or a custom path. Stored as `releaseNotesPath` in `cody.json`.
- **`{{cfReleaseNotes}}` placeholder** -- New placeholder in `agent.md` that resolves the release notes location from `cody.json`. Cached on activation, re-resolved on `:cody refresh`.
- **Self-documenting path values** -- Instead of `null` or `.`, paths use `"{{projectPath}}"` (build folder), `"{{projectRoot}}"` (repo root), or a literal custom path. Values are immediately understandable when reading `cody.json`.

## Enhancements
- `cody.json` template updated with `releaseNotesPath` field (default: `"{{projectPath}}"`)
- `project-settings-check.md` updated with Step 4: asks fresh installs for release notes location (default: project root)
- `activate.md` updated with migration check: if `cody.json` exists but missing `releaseNotesPath`, shows current location and prompts to keep or move
- `patch.md` updated to use `{{cfReleaseNotes}}` instead of hardcoded `{{cfWorkPhase}}` for release notes
- `build-version-existing.md` updated to use `{{cfReleaseNotes}}` instead of hardcoded `{{cfWorkPhase}}` for release notes

## Bug Fixes
None

## Other Notes
- Existing projects that already have `release-notes.md` in the build folder are prompted on activation to keep or move it. The current location is shown so they can make an informed choice.
- Fresh installs default to project root (`{{projectRoot}}`), matching the common convention for changelogs.
- If the user picks a custom path and the directory doesn't exist, it is created automatically before writing.

---

# v1.9.0 - Configurable Project Path - 2026-03-19

## Overview
Replaced the hardcoded `cody-projects/product-builder/` output path with a user-configurable project path. Introduced a root-level `cody.json` file structured for multi-skill support, replacing the old `project.json`. Users can now choose where their plan and build folders live during first-time setup.

## Key Features
- **Root-level `cody.json`** -- New multi-skill config file at the project root, keyed by skill name (`cody-product-builder`, `cody-article-writer`, etc.). Replaces the old `project.json` that lived inside `cody-projects/product-builder/`.
- **Configurable project path** -- During first-time setup (via `:cody plan` or `:cody refresh`), users are prompted: "The default project path is `cody-projects/product-builder`. Do you want to choose a different one?" The chosen path becomes the direct parent of `plan/` and `build/` folders.
- **Dynamic placeholder resolution** -- `{{cfProject}}`, `{{cfPlanPhase}}`, and `{{cfWorkPhase}}` are now resolved dynamically from `cody.json > cody-product-builder > projectPath` instead of being hardcoded. Values are read once on activation and cached for the session.
- **Migration from `project.json`** -- If a legacy `project.json` exists, its data is automatically migrated into `cody.json`. If the user chooses a new path, `plan/` and `build/` folders are moved to the new location, and old directories are cleaned up (with user confirmation).

## Enhancements
- Activation now triggers the full migration flow when `cody.json` is missing but legacy `project.json` exists, instead of just showing a generic prompt.
- `project-settings-check.md` fully rewritten with the new migration flow: check `cody.json`, migrate or create fresh, ask for path, move folders if needed.
- All command files updated to reference `cody.json` instead of `project.json` for version/phase/date updates.
- `phases.md` reference updated from `project.json` to `cody.json`.
- Plan phase documentation updated with new architecture, data model, and component references.
- README updated with new file structure diagram and version badge.
- Backlog item #33 updated to include removing the `cody.json` migration check by June 2026.
- Backlog item #37 updated to reference `cody.json` instead of `project.json` for the future `releaseNotesPath` field.

## Bug Fixes
None

## Other Notes
- `releaseNotesPath` is intentionally not added in this version. It will be added when backlog item #37 is implemented.
- The default path (`cody-projects/product-builder`) ensures backward compatibility for users who don't want to change their folder structure.
- `projectPath` is stored as a relative path from the project root (no leading `./`, no absolute paths).
- `.cody/settings.json` is unaffected -- it continues to hold the skill version, separate from the project version in `cody.json`.

---

# v1.8.0 - Agent Optimization - 2026-03-17

## Overview
Optimized the Cody Product Builder agent for progressive disclosure, significantly reducing the token footprint on activation. Shared content extracted into reusable reference files, and the activation flow redesigned to eliminate unnecessary file reads.

## Key Features
- **Progressive disclosure** -- agent.md slimmed from 102 lines to 53 lines. Phase descriptions, document tables, and version naming conventions moved to on-demand reference files.
- **References folder** -- new `.cody/references/` directory with shared content (phases.md, knowledge-criteria.md, project-settings-check.md) loaded only when commands need them.
- **Faster activation** -- removed the instruction to pre-load all 11 command files on activation. Commands are now read only when invoked.
- **Redesigned activation flow** -- banner, description, and contextual prompt now handled directly in activate.md instead of calling `:cody help`. One fewer file read on every activation.

## Enhancements
- Moved full "About Cody Product Builder" description from agent.md to help.md, synced with README (source of truth). Agent.md keeps a one-liner.
- Added `{{cfReferences}}` placeholder to the placeholder table.
- Extracted duplicated Knowledge Criteria from plan.md and refresh-brownfield.md into references/knowledge-criteria.md.
- Extracted duplicated project settings check from build.md and refresh.md into references/project-settings-check.md.
- help.md now shows a contextual prompt based on current phase (plan, build, or unknown).
- Activation banner redesigned with Option C style (horizontal rules) for cross-agent compatibility.
- Version number now displayed in the activation banner.

## Bug Fixes
None

## Other Notes
- No functional changes to any command workflow -- this is purely a token optimization and UX improvement.
- refresh-update.md project settings check was not extracted because it has a different flow (checking if name/description changed, not creating project.json).

---

# v1.7.3 - Activation Restructure (Patch) - 2026-03-17
- **Type:** Small Enhancement
- **Summary:** Renamed IDE activation command files from `cody` to `cody-product-builder` (slash command is now `/cody-product-builder`). Created an `activations/` folder at the project root and moved `.claude/`, `.cursor/`, and `.github/` into it. Users now copy the folder for their IDE from `activations/` into their project root. Updated `refresh-brownfield.md`, plan docs, and README to reflect the new structure.

---

# v1.7.2 - Consolidate Ideas Into Backlog (Patch) - 2026-03-15
- **Type:** Small Enhancement
- **Summary:** Consolidated the separate `ideas.md` tracker into the Backlog section of `feature-backlog.md`. `:cody idea` now writes directly to the backlog with a Source column (User/Agent) to distinguish who added the item. Backlog section simplified to 4 columns (#, Feature, Description, Source) -- no more Priority or Status. Items stay in the Backlog until a version or patch entry is actually written. Deleted `ideas.md` template and project file. Updated all commands, agent.md, templates, and README.

---

# v1.7.1 - File System Check Safety (Patch) - 2026-03-14

## Overview
Added a file system safety rule to `agent.md` to prevent false negatives when checking for files and folders. This addresses an issue where the agent incorrectly concluded a folder was empty due to a path resolution failure, triggering the wrong workflow (brownfield instead of refresh).

## Key Features
None

## Enhancements
- **New "File System Checks" section in `agent.md`** -- Two rules:
  1. Always use placeholder paths (`{{cfPlanPhase}}`, `{{cfProject}}`, etc.), never construct paths manually or use relative paths
  2. Before concluding files don't exist, verify with at least two different methods (e.g., glob search AND directory listing) to prevent false negatives

## Bug Fixes
None

## Other Notes
- Root cause was a relative path (`./cody-projects/...`) failing to resolve in a glob search, while the files existed and were found immediately via directory listing
- This is a global rule in `agent.md` that applies to all commands, so no individual command files needed changes

---

# v1.7.0 - Idea Tracker - 2026-03-14

## Overview
Added a quick-capture idea tracker so users can log ideas mid-flow without disrupting their current work. Ideas are stored in a simple table and offered as starting points when creating new versions or patches.

## Key Features
- **`:cody idea [description]`** -- Captures an idea instantly. Adds a row to the ideas table with an auto-incremented ID, date, description, and status. No follow-up questions, no workflow disruption.
- **`:cody idea`** (no args) -- Shows all captured ideas.
- **Ideas offered during build** -- When starting a new version or patch, the agent checks for open ideas and offers them as a starting point. If the user picks one, its status updates to `Closed`.
- **Simple status tracking** -- Ideas are either `Open` or `Closed`. An idea is marked `Closed` the moment it's picked up as a version or patch.

## Enhancements
- Created `.cody/commands/idea.md` -- new user-facing command
- Created `.cody/templates/ideas.md` -- template for the ideas tracker
- Updated `build-version-new.md` -- checks for open ideas after the banner, before version discovery
- Updated `patch.md` -- checks for open ideas after the banner, before asking what needs fixing
- Updated `build-version-existing.md` and `patch.md` -- idea status updates handled at pick time, not completion
- Updated `agent.md` -- added `:cody idea` to command registry and `ideas.md` to project documentation
- Updated README -- added idea command to table, usage section, and file structure

## Bug Fixes
None

## Other Notes
- Ideas are separate from the feature backlog -- they are unplanned thoughts, not structured work items
- ideas.md is created from a template on first capture, not during project setup
- ideas.md lives at the project root (`cody-projects/product-builder/ideas.md`)

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

## Enhancements
- Created `build.md` as the unified build entry point
- Converted `build-backlog.md` to internal delegation file (removed banner, prereq checks, stop points)
- Converted `patch.md` to internal delegation file (removed prereq checks)
- Deleted `build-version.md` (router replaced by `build.md` menu)
- Removed project settings auto-creation checks from `build-backlog.md`, `patch.md`, and `build-version-existing.md` (centralized in `build.md`)
- Added banners to `build-version-existing.md` and `build-version-new.md`
- Updated all closing messages to reference `:cody build` instead of old commands
- Updated `agent.md` command registry to 4 commands
- Updated README command table and usage instructions

## Bug Fixes
None

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

## Enhancements
None

## Bug Fixes
None

## Other Notes
- Template stored at `.cody/templates/project.json`
- All dates use `YYYY-MM-DD` (ISO 8601) format
- `project.json` lives at `cody-projects/product-builder/project.json` (project root)

---

# v1.5.1 - Patch Workflow Improvements (Patch) - 2026-03-13
- **Type:** Small Enhancement
- **Summary:** Improved the patch workflow with patch titles that include names, an agent verification step before user handoff, a user testing step with confirmation loop, and updated closing message to mention both commit and push.

---

# v1.5.0 - Patches & Command Restructure - 2026-03-12

## Overview
Two changes in this release: (1) lightweight patches for quick fixes that skip the full version build cycle, and (2) a command restructure that simplifies the command surface from 9 commands down to 6.

## Key Features
### Patches
- **`:cody patch` command** -- New command that kicks off a streamlined patch workflow: brief Q&A to understand the problem, user-confirmed plan, fix, auto-generated patch document, and release notes update
- **Patch template** -- New `patch.md` template in `.cody/templates/build/` with structured fields for version, date, type, original prompt, problem, plan, solution, files changed (auto-generated), and testing notes
- **Patch versioning** -- Patches use the same `v[major.minor.patch]` numbering as versions, incrementing the patch segment (e.g., v1.1.0 is a version, v1.1.1 is a patch)
- **Patch folders in build directory** -- Patch folders live alongside version folders in `cody-projects/product-builder/build/`, distinguished by containing only a `patch.md` file

### Command Restructure
- **`:cody build` renamed to `:cody build backlog`** -- Renamed for clarity (it creates the feature backlog, not a build)
- **`:cody version add` + `:cody version build` merged into `:cody build version`** -- Single router command that asks "existing or new?" and delegates accordingly
- **`:cody refresh update` folded into `:cody refresh`** -- Refresh now asks "Would you like me to update the PRD, plan, and release notes?" at the end, instead of requiring a separate command
- **`:cody relearn` removed** -- Redundant with the `/cody` slash command activation, which reads the same files
- **Internal files renamed** -- `version-build.md` to `build-version-existing.md`, `version-add.md` to `build-version-new.md` so all build-related files group together alphabetically

## Enhancements
- Updated release notes template with separate entry formats for versions (full entry) and patches (lightweight inline entry with type and summary)
- Updated `agent.md` command registry to reflect 6-command structure
- Updated `refresh.md` to include recent patch documents when refreshing agent memory and to offer document updates at the end
- Updated README with patch documentation, new command table, and file structure diagram
- Internal delegation files (`refresh-update.md`, `refresh-brownfield.md`, `build-version-existing.md`, `build-version-new.md`) now use `internal: true` frontmatter instead of user-facing command names

## Bug Fixes
None

## Other Notes
- Patches are not tracked in the feature backlog -- they are reactive, not planned
- Patches do not include design docs, tasklists, or retrospectives -- that's the point
- No changes to the Plan phase workflow, templates, or placeholder system

---

# v1.4.0 - Brownfield Project Support - 2026-02-26

## Overview
Added support for brownfield projects -- existing codebases that don't yet have Cody project files. The `:cody refresh` command now automatically detects brownfield projects, performs an autonomous codebase analysis, asks targeted questions, and auto-generates all plan phase documents.

## Key Features
- **Brownfield detection** -- `:cody refresh` now detects when application code exists but no Cody project files are present, and automatically triggers the brownfield workflow
- **Autonomous codebase analysis** -- The agent examines the project structure, tech stack, dependencies, architecture, data models, API endpoints, and existing features without manual input
- **Brownfield analysis document** -- New `brownfield-analysis.md` template and document that captures the technical audit of an existing codebase, replacing `discovery.md` for brownfield projects
- **Auto-generated plan phase** -- After analysis and user Q&A, the agent automatically generates `brownfield-analysis.md`, `prd.md`, and `plan.md` with explicit review gates between each document

## Enhancements
- New command file `refresh-brownfield.md` -- keeps brownfield logic separate from the existing refresh flow (same delegation pattern as `refresh-update.md`)
- New template `brownfield-analysis.md` in `.cody/templates/plan/` with sections for Project Overview, Tech Stack, Project Structure, Key Files, Dependencies, Architecture, Data Model, Existing Features, User Q&A, and Summary
- Updated `refresh.md` with a brownfield detection gate at the top -- existing refresh flow remains unchanged
- Updated `agent.md` with `brownfield-analysis.md` in the Plan phase document table and `:cody refresh brownfield` in the command registry
- The brownfield Q&A uses the same Knowledge Criteria as `:cody plan`, with `help me` and `no more` escape hatches
- Added `brownfield-analysis.md` to the refresh command's review hierarchy for subsequent refreshes

## Bug Fixes
None

## Other Notes
- For greenfield projects (no existing code), `:cody refresh` now suggests running `:cody plan` instead of silently failing
- The brownfield workflow includes explicit STOP gates: after presenting understanding, after each generated document -- matching the iterative review pattern of `:cody plan`

---

# v1.3.0 - Restructure and Improvements - 2026-02-23

## Overview
Major structural reorganization of the Cody Product Builder skill. Project output files are now stored in a shared `cody-projects/` directory, the internal config folder has been flattened, and Cursor support has been added.

## Key Features
- Added Cursor IDE support with `.cursor/commands/cody.md` activation command
- Project output now stored in `./cody-projects/product-builder/` (previously `.cody/project/`), aligning with the shared `cody-projects/` convention used across Cody skills

## Enhancements
- Flattened `.cody/config/` -- all config files now live directly in `.cody/` for a simpler structure
- Removed unused `{{cfConfig}}` and `{{cfComponents}}` placeholders
- Removed `{{cfAssets}}`, `{{cfDocs}}`, `{{cfRules}}`, `{{cfPrompts}}` placeholders and the entire `library/` folder -- unused and unnecessary
- Removed `:cody assets list` command and associated `assets-list.md` file
- Removed "Storing Images and Assets" section from `:cody help` output
- Fixed `{{cProject}}` typo in plan.md (was missing the "f" -- now correctly `{{cfProject}}`)
- Added `cody-projects/` to `.gitignore` so generated project files are not tracked
- Updated README with new file structure diagram, Cursor in activation list, and link to release notes

## Bug Fixes
- Fixed hardcoded path `@.cody/build/` in version naming convention docs -- now uses `{{cfWorkPhase}}` placeholder

## Other Notes
- Existing users with files in `.cody/project/` will need to manually move them to `./cody-projects/product-builder/`
