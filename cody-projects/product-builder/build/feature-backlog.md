# Feature Backlog

This document lists features and enhancements derived from the plan. It is a living document that will evolve throughout the project. It is grouped by version, with the Backlog tracking all features not added to a version yet. It is used to create versions to work on.

| Status |  | Priority |  |
|--------|-------------|---------|-------------|
| 🔴 | Not Started | High | High priority items |
| 🟡 | In Progress | Medium | Medium priority items |
| 🟢 | Completed | Low | Low priority items |


## Backlog

| ID  | Feature             | Description                               | Priority | Status |
|-----|---------------------|-------------------------------------------|----------|--------|

## v1.3.0 - Restructure and Improvements - 🟢 Completed
Major structural reorganization: project output moved to `cody-projects/`, flattened `.cody/config/`, added Cursor support.

| ID  | Feature                 | Description                              | Priority | Status |
|-----|-------------------------|------------------------------------------|----------|--------|
| 1 | Cursor IDE support | Added `.cursor/commands/cody.md` activation command | High | 🟢 Completed |
| 2 | Project output relocation | Moved output to `./cody-projects/product-builder/` from `.cody/project/` | High | 🟢 Completed |
| 3 | Config folder flattening | All config files moved directly into `.cody/` for simpler structure | Medium | 🟢 Completed |
| 4 | Placeholder cleanup | Removed unused placeholders (cfConfig, cfComponents, cfAssets, cfDocs, cfRules, cfPrompts) | Low | 🟢 Completed |

## v1.4.0 - Brownfield Project Support - 🟢 Completed
Added support for existing codebases that don't yet have Cody project files.

| ID  | Feature                 | Description                              | Priority | Status |
|-----|-------------------------|------------------------------------------|----------|--------|
| 5 | Brownfield detection | `:cody refresh` detects when app code exists but no Cody files are present | High | 🟢 Completed |
| 6 | Autonomous codebase analysis | Agent examines project structure, tech stack, dependencies, architecture without manual input | High | 🟢 Completed |
| 7 | Brownfield analysis document | New `brownfield-analysis.md` template replacing `discovery.md` for brownfield projects | High | 🟢 Completed |
| 8 | Auto-generated plan phase | Agent generates brownfield-analysis.md, prd.md, and plan.md with review gates | High | 🟢 Completed |

## v1.5.0 - Patches and Command Restructure - 🟢 Completed
Lightweight patches for quick fixes and command surface reduction from 9 to 6 commands.

| ID  | Feature                 | Description                              | Priority | Status |
|-----|-------------------------|------------------------------------------|----------|--------|
| 9 | Patch command | New `:cody patch` for streamlined fix workflow | High | 🟢 Completed |
| 10 | Patch template | Structured fields for version, date, type, problem, plan, solution, files changed | High | 🟢 Completed |
| 11 | Command restructure | Merged and renamed commands, reduced from 9 to 6 | Medium | 🟢 Completed |
| 12 | Release notes patch format | Separate lightweight entry format for patches in release notes | Medium | 🟢 Completed |

## v1.5.1 - Patch Workflow Improvements - 🟢 Completed
Improvements to patch workflow based on initial usage feedback.

| ID  | Feature                 | Description                              | Priority | Status |
|-----|-------------------------|------------------------------------------|----------|--------|
| 13 | Patch title with name | Patch template now includes both version number and name | Low | 🟢 Completed |
| 14 | Agent verification step | Agent runs its own checks before handing off to user | Medium | 🟢 Completed |
| 15 | User testing step | Agent presents testing notes and waits for user confirmation | Medium | 🟢 Completed |

## v1.5.2 - Project Settings File - 🟢 Completed
Added `project.json` for project metadata tracking.

| ID  | Feature                 | Description                              | Priority | Status |
|-----|-------------------------|------------------------------------------|----------|--------|
| 16 | project.json | Tracks name, description, version, phase, and dates | High | 🟢 Completed |
| 17 | Auto-creation on older projects | Entry-point commands detect missing project.json and create it | Medium | 🟢 Completed |
| 18 | Name/description sync via refresh | Refresh-update checks if project name or description changed | Low | 🟢 Completed |

## v1.6.0 - Unified Build Command - 🟢 Completed
Consolidated build commands into single `:cody build` entry point, reducing from 6 to 4 commands.

| ID  | Feature                 | Description                              | Priority | Status |
|-----|-------------------------|------------------------------------------|----------|--------|
| 19 | Unified `:cody build` | Single entry point for all build work with menu | High | 🟢 Completed |
| 20 | Workflow banners | Each sub-workflow shows its own banner | Low | 🟢 Completed |
| 21 | Internal delegation conversion | Converted build-backlog and patch to internal files | Medium | 🟢 Completed |

## v1.7.0 - Idea Tracker - 🟢 Completed
Quick-capture idea tracker for logging ideas mid-flow.

| ID  | Feature                 | Description                              | Priority | Status |
|-----|-------------------------|------------------------------------------|----------|--------|
| 22 | `:cody idea` command | Capture ideas instantly or view all ideas | High | 🟢 Completed |
| 23 | Ideas offered during build | Open ideas shown when starting new versions or patches | Medium | 🟢 Completed |
| 24 | Idea status tracking | Ideas marked Closed when picked up | Low | 🟢 Completed |

## v1.7.1 - File System Check Safety - 🟢 Completed
Added file system safety rule to prevent false negatives when checking for files and folders.

| ID  | Feature                 | Description                              | Priority | Status |
|-----|-------------------------|------------------------------------------|----------|--------|
| 25 | Dual-method file verification | Always verify with at least two methods before concluding files don't exist | High | 🟢 Completed |
| 26 | Placeholder path enforcement | Always use placeholder paths, never construct paths manually | Medium | 🟢 Completed |
