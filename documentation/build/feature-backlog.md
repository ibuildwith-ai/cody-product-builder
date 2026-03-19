# Feature Backlog

This document lists features and enhancements derived from the plan. It is a living document that will evolve throughout the project. It is grouped by version, with the Backlog tracking all features not added to a version yet. It is used to create versions to work on.

| Status |  | Priority |  |
|--------|-------------|---------|-------------|
| 🔴 | Not Started | High | High priority items |
| 🟡 | In Progress | Medium | Medium priority items |
| 🟢 | Completed | Low | Low priority items |


## Backlog

| #  | Feature             | Description                               | Source |
|----|---------------------|-------------------------------------------|--------|
| 29 | Extensive Refresh | Make sure the refresh command is doing an extensive review not just a very simple review (both when refreshing a current Cody project or a brownfield project) | User |
| 30 | Brownfield Backlog Options | If it's a brownfield project, when building the backlog, it should ask if we want the backlog to have stuff we already worked on or just start fresh (empty ready to add new versions to it) | User |
| 31 | Full Management App | Full app for managing coding installations and projects across multiple projects. | User |
| 33 | Remove Legacy Migration Checks | Remove in June 2026: (1) the project.json auto-creation check added in v1.5.2, and (2) the project.json-to-cody.json migration check added in v1.9.0. By then all users should be on cody.json. | User |
| 37 | Configurable Release Notes Location | Allow the user to pick where to store release-notes.md: Cody Product Builder current location (cody-projects/cody-product-builder/build/), their project root, or a custom path in their project. Store the selection in a new field in the cody-projects/cody-product-builder/project.json file. | User |
| 43 | Build Testing Guidelines | Add testing as something Cody recommends to the user with every build. Incorporate testing patterns and guidelines (e.g., unit tests, integration tests, edge cases, regression checks, test coverage expectations) it should follow when building. | User |
| 44 | Build Security Checks | Add security checks as something Cody recommends to the user with every build. Incorporate security patterns and guidelines (e.g., input validation, auth, dependency vulnerabilities, OWASP top 10) it should follow when building. | User |
| 45 | Modernize Delegation Language | Replace the verbose `**[AGENT TODO: Read and execute ...]**` delegation pattern with a cleaner, more concise syntax across all command and reference files. Ensure the new format is still visually distinct and searchable. | User |
| 46 | Codex Activation Command | Add an activation command for Codex to the activations/ folder. | User |
| 47 | README Generation | Generate a README.md file for the project if one does not exist. Give the user the option to create a new one, or review a current one they have and migrate it to the Cody version and keep maintaining it. | User |
| 48 | Descending Version Order in Backlog | Update feature backlog to show the latest version at the top, below the backlog table. Versions ordered by version number descending (latest first). New versions added to the top, not the bottom. | User |
| 49 | Refresh Template Compliance | Cody Refresh should check that plan phase docs (plan.md, prd.md) and build docs (feature-backlog.md, release-notes.md) follow the latest templates. If not, update them with user permission. | User |


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

## v1.7.2 - Consolidate Ideas Into Backlog - 🟢 Completed
Consolidated ideas.md into the Backlog section of feature-backlog.md.

| ID  | Feature                 | Description                              | Priority | Status |
|-----|-------------------------|------------------------------------------|----------|--------|
| 34 | Consolidate ideas into backlog | Merged ideas.md and Backlog section into a single location with Source column | High | 🟢 Completed |
| 35 | Simplified Backlog columns | Reduced Backlog to #, Feature, Description, Source -- removed Priority and Status | Medium | 🟢 Completed |
| 36 | Deferred backlog removal | Items stay in Backlog until version/patch entry is written, not when picked | Medium | 🟢 Completed |

## v1.7.3 - Activation Restructure - 🟢 Completed
Renamed activation command files and consolidated IDE folders into `activations/`.

| ID  | Feature                 | Description                              | Priority | Status |
|-----|-------------------------|------------------------------------------|----------|--------|
| 27 | Rename Commands | Renamed activation command files from `cody` to `cody-product-builder` | High | 🟢 Completed |
| 32 | Consolidate Command Folders | Created `activations/` folder and moved `.claude/`, `.cursor/`, `.github/` into it | High | 🟢 Completed |

## v1.8.0 - Agent Optimization - 🟢 Completed
Optimize agent.md for progressive disclosure and reduce token footprint by extracting shared content into references.

| ID  | Feature                 | Description                              | Priority | Status |
|-----|-------------------------|------------------------------------------|----------|--------|
| 28 | Slim Down agent.md | Move phase descriptions, document tables, and version naming convention out of agent.md into a references folder. Keep only core instructions, roles, placeholders, file system checks, and command routing. | High | 🟢 Completed |
| 38 | Remove Read-All-Commands Instruction | Remove the instruction that tells the agent to read all command files on activation. Commands should only be loaded when invoked. | High | 🟢 Completed |
| 39 | Move About to Help | Move the full "About Cody Product Builder" description to help.md (synced with README, which is the source of truth). Keep a one-liner in agent.md. | Medium | 🟢 Completed |
| 40 | Create References Folder | Create `.cody/references/` with shared content: phases.md (phase descriptions and document tables), knowledge-criteria.md (shared Q&A criteria used by plan.md and refresh-brownfield.md), project-settings-check.md (shared project.json setup flow used by build.md and refresh.md). Add {{cfReferences}} placeholder. | High | 🟢 Completed |
| 41 | Extract Knowledge Criteria | Extract the duplicated Knowledge Criteria and Q&A guidance from plan.md and refresh-brownfield.md into references/knowledge-criteria.md. Both commands reference it via AGENT TODO delegation. | Medium | 🟢 Completed |
| 42 | Extract Project Settings Check | Extract the duplicated project.json check-and-create flow from build.md and refresh.md into references/project-settings-check.md. Both commands reference it via AGENT TODO delegation. | Medium | 🟢 Completed |

## v1.9.0 - Configurable Project Path - 🟢 Completed
Replace hardcoded project output path with user-configurable location. Introduce root-level `cody.json` for multi-skill config.

| ID  | Feature                 | Description                              | Priority | Status |
|-----|-------------------------|------------------------------------------|----------|--------|
| 48 | Root-level cody.json | Replace `project.json` with a root-level `cody.json` file. Multi-skill structure keyed by skill name (`cody-product-builder`, `cody-article-writer`, etc.). | High | 🟢 Completed |
| 49 | Configurable project path | During first-time setup, prompt the user to choose an output folder. Default: `cody-projects/product-builder`. `plan/` and `build/` created directly inside the chosen path. | High | 🟢 Completed |
| 50 | Dynamic placeholder resolution | `{{cfProject}}` resolves from `cody.json > cody-product-builder > projectPath`. Read once on activation and on `:cody refresh`. Cached for the session. | High | 🟢 Completed |
| 51 | Migration from project.json | If `project.json` exists, migrate its data into `cody.json` and delete it. If user picks a new path, move `plan/` and `build/` folders and clean up old directories. | High | 🟢 Completed |
