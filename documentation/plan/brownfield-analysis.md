# Brownfield Analysis
This document captures the technical audit of an existing codebase performed by the **AGENT**. It serves as the foundation for generating the PRD and Plan documents for a brownfield project.

## Project Overview
Cody Product Builder is an AI agent skill -- not a traditional software application. It is a collection of markdown command files, templates, and JSON configuration that AI coding environments (Claude Code, Cursor, GitHub Copilot, and others) consume to guide non-developers through a structured, two-phase development methodology: Plan and Build. The skill transforms vague product ideas into well-defined plans, then breaks them into manageable versions for systematic implementation.

## Tech Stack
- **Markdown** -- All commands, templates, and documentation are written in markdown with structured sections and AI agent instructions
- **JSON** -- Configuration files (settings.json, project.json template)
- **Prompt Engineering** -- The core "code" is structured prompts that instruct AI agents on workflow, decision-making, and document generation
- **No build tools, no dependencies, no runtime** -- This is a static skill consumed by external AI environments

## Project Structure

| Folder | Purpose |
|--------|---------|
| `.cody/` | Core skill root -- activation, agent instructions, settings |
| `.cody/commands/` | Command implementation files (11 files) -- the "logic" of the skill |
| `.cody/templates/` | Document scaffolding templates (10 files) used to generate project artifacts |
| `.cody/templates/plan/` | Templates for planning phase docs (discovery, brownfield-analysis, prd, plan) |
| `.cody/templates/build/` | Templates for build phase docs (feature-backlog, release-notes, patch) |
| `.cody/templates/build/version/` | Templates for per-version docs (design, tasklist, retrospective) |
| `.claude/commands/` | Claude Code activation entry point |
| `.cursor/commands/` | Cursor activation entry point |
| `.github/prompts/` | GitHub Copilot activation entry point |
| `cody-projects/product-builder/` | Generated project output (gitignored) |
| `ignore/` | Planning documents for past features (gitignored) |

## Key Files

| File | Description |
|------|-------------|
| `.cody/agent.md` | Core agent instructions -- phases, placeholders, commands registry, version naming, file system rules |
| `.cody/activate.md` | Activation sequence that bootstraps the agent |
| `.cody/settings.json` | Skill version and metadata (currently v1.7.1) |
| `.cody/commands/build.md` | Unified build entry point -- backlog creation, version/patch menu |
| `.cody/commands/plan.md` | Planning phase -- guided discovery Q&A, document generation |
| `.cody/commands/refresh.md` | Memory refresh -- brownfield detection, document review |
| `.cody/commands/idea.md` | Quick-capture idea tracker |
| `.cody/templates/project.json` | Template for project metadata settings |
| `README.md` | Public-facing documentation with installation, usage, and feature descriptions |
| `RELEASE-NOTES.md` | Version history from v1.3.0 through v1.7.1 |
| `LICENSE.md` | Custom license by Red Pill Blue Pill Studios, LLC |

## Dependencies
None. Cody Product Builder has no external dependencies. It is consumed by AI coding environments that interpret its markdown instructions.

## Architecture
The skill follows a **command-delegation architecture**:

- **5 user-facing commands** (help, plan, build, idea, refresh) serve as entry points
- **6 internal delegation files** (build-backlog, build-version-existing, build-version-new, patch, refresh-brownfield, refresh-update) handle sub-workflows
- **Templates** provide document scaffolding with `[AI AGENT TODO]` placeholders that the agent fills in
- **Placeholder system** (e.g., `{{cfPlanPhase}}`, `{{cfWorkPhase}}`) abstracts file paths across all commands
- **Two-phase model**: Plan phase produces discovery/brownfield-analysis, PRD, and plan documents; Build phase produces feature backlogs, versioned design/tasklist/retrospective documents, patches, and release notes

The commands use a consistent pattern: banner display, prerequisite checks, guided Q&A with the user, document generation, explicit STOP gates for user review, and delegation to sub-workflows.

## Data Model
No database. All data is stored as markdown files and a single JSON settings file:

- `project.json` -- Project metadata (name, description, version, phase, dates)
- `feature-backlog.md` -- Feature tables grouped by version with priority and status; Backlog section for unscheduled ideas (ID, feature, description, source)
- Per-version folders contain design.md, tasklist.md, and retrospective.md
- Per-patch folders contain patch.md

## Existing Features

| Feature | Version | Description |
|---------|---------|-------------|
| Greenfield planning | v1.0+ | Guided discovery Q&A, PRD and plan generation |
| Version-based building | v1.0+ | Feature backlog, design docs, tasklists, retrospectives |
| Release notes | v1.0+ | Auto-generated after each version or patch |
| Command restructure | v1.5.0 | Consolidated from 9 commands to 6, added patches |
| Patch workflow | v1.5.0 | Lightweight fixes that skip the full version cycle |
| Patch improvements | v1.5.1 | Agent verification step, user testing step |
| Project settings | v1.5.2 | project.json for metadata tracking |
| Unified build command | v1.6.0 | Single `:cody build` entry point (6 commands to 4) |
| Idea tracker | v1.7.0 | Quick-capture ideas mid-flow, offered when starting versions/patches |
| File system safety | v1.7.1 | Dual-method verification to prevent false negatives |
| Brownfield support | v1.4.0 | Auto-detection and analysis of existing codebases |
| Cursor support | v1.3.0 | IDE activation for Cursor |
| GitHub Copilot support | v1.3.0+ | Prompt-based activation for Copilot |

## User Q&A

**AGENT Q1:** Who are the primary target users for Cody Product Builder?
**USER A1:** Knowledge workers and domain experts who want to build with AI but are not developers (and don't want to be). The focus is guiding them from 0 to 1.

**AGENT Q2:** What problem does Cody Product Builder solve?
**USER A2:** The lack of structure when building with AI. Guiding non-developers from 0 to 1.

**AGENT Q3:** What does success look like?
**USER A3:** GitHub stars as a proxy for adoption. Stars are low for now but that's the metric.

**AGENT Q4:** What constraints should we keep in mind?
**USER A4:** No constraints identified.

**AGENT Q5:** What are the biggest risks or open questions?
**USER A5:** AI models getting so good that structured methodology products like this are no longer needed.

## Summary
Cody Product Builder is a markdown-based AI agent skill that provides a repeatable, structured methodology for non-developers building products with AI coding tools. It has no traditional code, dependencies, or runtime -- the "product" is the prompt engineering and document templates that AI environments consume. At v1.7.1, it has a mature two-phase workflow (Plan and Build) with 5 user-facing commands, brownfield/greenfield support, version and patch workflows, idea tracking, and project metadata management. The primary risk is AI models advancing to the point where structured methodology becomes unnecessary. Success is measured by GitHub star adoption. Key competitors include BMAD, SpecKit, and built-in plan modes from AI coding tools.
