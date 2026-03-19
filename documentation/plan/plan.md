# Product Implementation Plan
This document defines how the product will be built and when.

## Section Explanations
| Section                  | Overview |
|--------------------------|--------------------------|
| Overview                 | A brief recap of what we're building and the current state of the PRD. |
| Architecture             | High-level technical decisions and structure (e.g., frontend/backend split, frameworks, storage). |
| Components               | Major parts of the system and their roles. Think modular: what pieces are needed to make it work. |
| Data Model               | What data structures or models are needed. Keep it conceptual unless structure is critical. |
| Major Technical Steps    | High-level implementation tasks that guide development. Not detailed coding steps. |
| Tools & Services         | External tools, APIs, libraries, or platforms this app will depend on. |
| Risks & Unknowns         | Technical or project-related risks, open questions, or blockers that need attention. |
| Milestones    | Key implementation checkpoints or phases to show progress. |
| Environment Setup | Prerequisites or steps to get the app running in a local/dev environment. |

## Overview
Cody Product Builder is a markdown-based AI agent skill that guides knowledge workers and domain experts through structured product development using AI coding environments. At v1.9.0, the core two-phase workflow (Plan and Build) is mature, with 5 user-facing commands, brownfield/greenfield support, version and patch workflows, idea tracking, configurable project paths, and multi-skill project configuration. Future development focuses on refining the existing experience, expanding compatibility, and improving adoption.

## Architecture
Cody Product Builder uses a **command-delegation architecture** built entirely on static files:

- **Entry layer** -- IDE-specific activation files in `activations/` (`.claude/commands/cody-product-builder.md`, `.cursor/commands/cody-product-builder.md`, `.github/prompts/cody-product-builder.prompt.md`) that bootstrap the agent by reading `.cody/activate.md`
- **Agent core** -- `.cody/agent.md` defines phases, placeholder system, command registry, version naming conventions, and file system rules
- **Command layer** -- 5 user-facing command files in `.cody/commands/` that implement the skill's workflows
- **Delegation layer** -- 6 internal command files that handle sub-workflows (backlog creation, version building, patching, brownfield analysis, document updates)
- **Template layer** -- 10 template files in `.cody/templates/` that scaffold generated documents with `[AI AGENT TODO]` placeholders
- **Config layer** -- `cody.json` at the project root stores per-skill settings including the configurable output path
- **Output layer** -- Generated project files in a user-configurable path (default: `cody-projects/product-builder/`). Contains plan docs, build docs, and version artifacts.

**Placeholder system:** Template variables like `{{cfPlanPhase}}`, `{{cfWorkPhase}}`, `{{cfTemplates}}` abstract file paths so commands remain portable regardless of project structure changes. `{{cfProject}}`, `{{cfPlanPhase}}`, and `{{cfWorkPhase}}` are dynamically resolved from `cody.json` on activation.

**No runtime, no dependencies, no build step.** The AI coding environment is the runtime.

## Components

- **Activation system** -- IDE-specific entry points that read `activate.md`, which reads `agent.md` and bootstraps the command set. Supports Claude Code, Cursor, and GitHub Copilot.
- **Plan phase commands** -- `:cody plan` drives guided discovery Q&A, generates discovery.md, prd.md, and plan.md. `:cody refresh` with brownfield detection generates brownfield-analysis.md instead of discovery.md.
- **Build phase commands** -- `:cody build` is the unified entry point that checks prerequisites, creates the feature backlog if needed, then presents a menu for new versions, existing versions, or patches.
- **Version workflow** -- Creates version folders with design.md, tasklist.md, and retrospective.md. Guides the user through phased implementation with explicit commit checkpoints.
- **Patch workflow** -- Lightweight alternative to versions for quick fixes. Creates patch.md with problem/plan/solution/files-changed sections.
- **Idea tracker** -- `:cody idea` for quick-capture. Ideas are offered when starting new versions or patches.
- **Refresh system** -- `:cody refresh` re-reads project documents to restore agent context. Optionally updates PRD, plan, and release notes. Detects brownfield projects.
- **Template engine** -- Markdown templates with `[AI AGENT TODO]` placeholders that the agent fills in based on context from previous documents and user input.
- **Project settings** -- `cody.json` at the project root tracks per-skill settings. The `cody-product-builder` section includes name, description, version, phase, projectPath, and dates. Migrated from legacy `project.json` on older projects.

## Data Model
All data is file-based. No database.

| File | Location | Format | Purpose |
|------|----------|--------|---------|
| `cody.json` | Project root | JSON | Multi-skill config. `cody-product-builder` section: name, description, version, phase, projectPath, dates |
| `feature-backlog.md` Backlog section | `{{cfWorkPhase}}/` | Markdown table | Unscheduled ideas and suggestions (ID, feature, description, source) |
| `discovery.md` | `{{cfPlanPhase}}/` | Markdown | Greenfield discovery Q&A and summary |
| `brownfield-analysis.md` | `{{cfPlanPhase}}/` | Markdown | Brownfield codebase audit and Q&A |
| `prd.md` | `{{cfPlanPhase}}/` | Markdown | Product requirements (goals, features, users, stories) |
| `plan.md` | `{{cfPlanPhase}}/` | Markdown | Implementation plan (architecture, components, milestones) |
| `feature-backlog.md` | `{{cfWorkPhase}}/` | Markdown tables | Features grouped by version with priority and status |
| `release-notes.md` | `{{cfWorkPhase}}/` | Markdown | Version and patch changelog |
| `design.md` | `{{cfWorkPhase}}/v[x.y.z]-[name]/` | Markdown | Per-version technical design |
| `tasklist.md` | `{{cfWorkPhase}}/v[x.y.z]-[name]/` | Markdown tables | Per-version task breakdown with status tracking |
| `retrospective.md` | `{{cfWorkPhase}}/v[x.y.z]-[name]/` | Markdown | Per-version lessons learned |
| `patch.md` | `{{cfWorkPhase}}/v[x.y.z]-[name]/` | Markdown | Per-patch problem/plan/solution/files |

## Major Technical Steps
Since Cody Product Builder is a mature skill at v1.9.0, future work falls into these categories:

- **Refinement** -- Improve existing command flows based on user feedback (clearer prompts, better defaults, smoother transitions between phases)
- **Compatibility** -- Test and adapt for new AI coding environments as they emerge (Codex, OpenCode, Gemini CLI, etc.)
- **Template improvements** -- Evolve templates based on patterns observed across real projects
- **Documentation** -- Keep README, release notes, and in-skill help current with each change
- **Adoption** -- Improve onboarding experience, reduce friction for first-time users

## Tools & Services
- **GitHub** -- Primary distribution channel (official repository)
- **AI coding environments** -- Claude Code, Cursor, GitHub Copilot (and others) are the "runtime" that executes the skill
- **Git** -- Version control for the skill itself

## Risks & Unknowns
- **AI model advancement** -- Models may become good enough that structured methodology is unnecessary, reducing the need for Cody. Mitigation: focus on the value Cody provides beyond what raw AI can do (documentation, traceability, repeatability).
- **Environment fragmentation** -- Each AI coding tool interprets markdown instructions slightly differently. Mitigation: keep commands simple, test across environments, use the activation layer to handle environment-specific quirks.
- **Competition** -- BMAD, SpecKit, and built-in plan modes from AI tools offer overlapping functionality. Mitigation: differentiate through simplicity, the 0-to-1 focus for non-developers, and the comprehensive document trail.
- **Prompt brittleness** -- AI agents sometimes misinterpret or skip command instructions. Mitigation: file system safety rules (v1.7.1), explicit STOP gates, prerequisite checks, and clear delegation patterns.

## Milestones
Cody Product Builder follows an incremental release model. Each version or patch is its own milestone:

| Milestone | Description | Status |
|-----------|-------------|--------|
| v1.3.0 | Restructure and Cursor support | Completed |
| v1.4.0 | Brownfield project support | Completed |
| v1.5.0 | Patches and command restructure | Completed |
| v1.5.1 | Patch workflow improvements | Completed |
| v1.5.2 | Project settings (project.json) | Completed |
| v1.6.0 | Unified build command | Completed |
| v1.7.0 | Idea tracker | Completed |
| v1.7.1 | File system check safety | Completed |
| v1.7.2 | Consolidate ideas into backlog | Completed |
| v1.7.3 | Activation restructure | Completed |
| v1.8.0 | Agent optimization | Completed |
| v1.9.0 | Configurable project path | Completed |
