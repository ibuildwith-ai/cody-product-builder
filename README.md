# Cody Product Builder

![Cody Product Builder](./cody-product-builder-logo.png)

![Version](https://img.shields.io/badge/version-1.6.0-blue)
[![License](https://img.shields.io/badge/license-Custom-orange)](LICENSE.md)
[![iBuildWith.ai](https://img.shields.io/badge/by-iBuildWith.ai-20c05b)](https://www.ibuildwith.ai)

# Star the Repo
⭐⭐ **If you find this skill helpful, please star this repo to show your support!** ⭐⭐

# About Cody Product Builder
Cody Product Builder is an AI agent skill that helps you go from idea to finished product, whether you're building apps, workflows, tools, or agents. It guides you through a structured flow of discovery, planning, and building so your AI-built projects are scalable, maintainable, and built right from the start.

Whether you're a knowledge worker building your first app, a domain expert turning expertise into software, or a product builder scaling an existing project, Cody gives you a repeatable methodology that works with any AI coding environment (Claude Code, Codex, Cursor, OpenCode, GitHub Copilot, and others).

**Starting fresh?** Cody walks you through idea refinement, requirements, and planning before a single line of code is written.

**Have an existing project?** Cody analyzes your codebase, understands what's already built, and picks up from there.

**Need a quick fix?** Patches let you skip the full build cycle while still tracking what was changed and why.

# What Cody Product Builder Helps You Do

### **Idea Discovery & Refinement**  
> Capture sparks of inspiration and shape them into clear, aligned, well-defined product concepts.

### **Structured Planning (without killing creativity)**  
> Use AI-ready documents that organize your thoughts, requirements, flows, and decisions - while still letting ideas evolve naturally.

### **Chunked Implementation (Versions)**
> Break the work into manageable, incremental “versions” that you can build, test, and ship faster with AI.

### **Lightweight Patches**
> Fix bugs and make small enhancements quickly without the overhead of a full version build cycle, while still tracking everything.

# Why Cody Product Builder Exists

AI tools are powerful, but without structure, things fall apart: messy prompts, inconsistent code, unclear requirements, lost context, and endless rework.

Cody Product Builder solves this by giving you:

- A repeatable workflow your AI coding tools can follow
- Templates and commands that eliminate guesswork
- A shared rhythm between you, your team, and your AI agents
- A consistent structure for specs, docs, tasks, and versions
- A methodology for building **products**, not just writing code

# Two-Phase Development Cycle

### Phase 1: Plan
Turn raw ideas into actionable plans using three core documents:

### **Discovery Document (`discovery.md`)**
> Captures the unfiltered initial idea and starts an interactive Q&A with the AI agent. The outcome is a clear vision and baseline requirements. Used for greenfield projects.

### **Brownfield Analysis (`brownfield-analysis.md`)**
> For existing codebases: captures an autonomous technical audit of the project (tech stack, architecture, dependencies, existing features) combined with targeted user Q&A. Replaces `discovery.md` for brownfield projects.

### **Product Requirements Document (`prd.md`)**
> Defines “what and why,” including goals, target users, features, success criteria, stories, assumptions, and dependencies.

### **Implementation Plan (`plan.md`)**
> Defines “how and when,” including architecture, components, data model, milestones, risks, tooling, and delivery strategy.

### Phase 2: Build
The build phase translates the plan into structured, version-based execution.

### **Feature Backlog (`feature-backlog.md`)**  
> A centralized list of all features, organized into versions with priority and status tracking (🔴 Not Started, 🟡 In Progress, 🟢 Completed).

### **Version Documents**
Each version includes:

#### **Design Document (`design.md`)**  
> Technical implementation guidance, architecture overview, and open questions.

#### **Task List (`tasklist.md`)**  
> A detailed breakdown of tasks derived from the Feature Backlog.

#### **Retrospective (`retrospective.md`)**
> Lessons learned, improvements, successes, and feedback for both you and the AI agent.

### **Patches**
Patches are lightweight fixes or small enhancements that skip the full version build cycle. Each patch lives in its own folder alongside versions in the build directory.

#### **Patch Document (`patch.md`)**
> Captures the problem, the plan, the solution, and files changed. Does not require a design doc, tasklist, or retrospective.

### **Release Notes (`release-notes.md`)**
> Automatically updated after each version or patch, tracking changes, enhancements, and fixes.

# Version Naming Convention

- **Format:** `v[major.minor.patch]-[name]`  
- **Example:** `v1.0.3-refactor-code`  

### Rules:
- Start at `v0.1.0` unless specified  
- Names ≤ 30 characters, lowercase, alphanumeric + `-`  
- Automatic version increment unless specified  
- `[name]` is optional  

# Command Reference
Commands use the format: `:cody [command]`

| Command | Description |
|--------|-------------|
| `:cody help` | Shows help and all available commands. |
| `:cody plan` | Starts the PLAN phase and creates a new Cody Product Builder project. |
| `:cody build` | Guided build phase: creates the feature backlog if needed, then lets you create a new version, work on an existing version, or work on a patch. |
| `:cody refresh` | Refreshes the AI agent’s memory about the project. Auto-detects brownfield projects. Optionally updates PRD, plan, and release notes. |

---

# File Structure

```
.claude/
└── commands/              # Claude Code slash commands
    └── cody.md            # Activation command for Claude Code

.cursor/
└── commands/              # Cursor slash commands
    └── cody.md            # Activation command for Cursor

.cody/
├── activate.md            # Activation instructions for AI agents
├── agent.md               # Core agent instructions and command registry
├── settings.json          # Tool version and settings
├── commands/              # Command implementation files
└── templates/             # Document templates
    ├── project.json       # Template for project metadata settings
    ├── plan/              # Templates for discovery.md, brownfield-analysis.md, prd.md, plan.md
    └── build/             # Templates for feature-backlog.md, release-notes.md, patch.md
        └── version/       # Templates for design.md, tasklist.md, retrospective.md

.github/
└── prompts/               # GitHub Copilot prompt files
    └── cody.prompt.md     # Activation prompt for GitHub Copilot

cody-projects/
└── product-builder/       # Generated project files (created during :cody plan)
    ├── project.json       # Project metadata (name, version, phase, dates)
    ├── plan/              # Planning phase documents
    └── build/             # Build phase documents (backlog, versions, patches)
```

# Installing and Using Cody Product Builder

## Installing
1. Clone or download Cody Product Builder from: https://github.com/ibuildwith-ai/cody-product-builder
2. Copy the `.cody`, `.claude`, `.cursor`, and `.github` folders into your project root.

## Activating
- **Claude Code**: Use the `/cody` command
- **Cursor**: Use the `/cody` command
- **GitHub Copilot**: Use the `/cody` command
- **Other AI Agents**: Say: *"Please read and execute the @.cody/activate.md"*

## Using

**Get help and see all available commands:**
`:cody help`

**Starting a new project from scratch:**
`:cody plan` to kick off the planning phase, then `:cody build` to start building.

**Building versions:**
`:cody build` to add a new version or work on an existing one. Cody will create the feature backlog automatically if it doesn't exist yet.

**Quick bug fixes, small enhancements, or updates:**
`:cody build` and choose the patch option for a lightweight fix without going through the full version build cycle.

**Working on an existing project:**
`:cody refresh` to have Cody analyze your codebase and generate all planning documents automatically, then `:cody build` to start building.

**Returning to a Cody-managed project in a new AI session?**
Activate Cody first, then `:cody refresh` so the agent reads your existing project documents and picks up where you left off.

## Author

**iBuildWith.ai**

Copyright 2026, Red Pill Blue Pill Studios, LLC. All Rights Reserved.

## License

Cody Product Builder is licensed under a custom license that permits free use for product building (including commercial use), but prohibits redistribution, modification, and sale of the software itself.

See [LICENSE.md](LICENSE.md) for complete terms.

## Release Notes

See [RELEASE-NOTES.md](RELEASE-NOTES.md) for version history.