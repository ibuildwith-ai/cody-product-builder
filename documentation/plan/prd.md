# Product Requirements Document (PRD)
This document formalizes the idea and defines the what and the why of the product the USER is building.

## Section Explanations
| Section           | Overview |
|-------------------|--------------------------|
| Summary           | Sets the high-level context for the product. |
| Goals             | Articulates the product's purpose -- core to the "why". |
| Target Users      | Clarifies the audience, essential for shaping features and priorities. |
| Key Features      | Describes what needs to be built to meet the goals -- part of the "what". |
| Success Criteria  | Defines what outcomes validate the goals. |
| Out of Scope      | Prevents scope creep and sets boundaries. |
| User Stories      | High-level stories keep focus on user needs (why) and guide what to build. |
| Assumptions       | Makes the context and unknowns explicit -- essential for product clarity. |
| Dependencies      | Identifies blockers and critical integrations -- valuable for planning dependencies and realism. |

## Summary
Cody Product Builder is an AI agent skill that provides a structured, repeatable methodology for knowledge workers and domain experts to go from a raw product idea to a finished, shippable product using AI coding environments. It replaces unstructured prompting with a two-phase system (Plan and Build) that produces consistent, well-documented project artifacts at every step.

## Goals
- **Guide non-developers from 0 to 1** -- Enable people who have never built software to produce real, working products using AI coding tools
- **Provide structure without killing creativity** -- Give users a methodology that organizes their work without over-constraining their ideas
- **Work across AI coding environments** -- Support Claude Code, Cursor, GitHub Copilot, Codex, OpenCode, and others through a portable, markdown-based architecture
- **Produce maintainable, documented projects** -- Every project built with Cody has a PRD, plan, feature backlog, design docs, tasklists, retrospectives, and release notes
- **Support both greenfield and brownfield projects** -- Whether starting from scratch or building on an existing codebase

## Target Users
**Primary:** Knowledge workers and domain experts who want to build software products using AI coding tools but are not developers and don't want to be. They have ideas and domain knowledge, can guide AI agents through conversation, but have little or no programming experience.

**Secondary:** Product builders and indie developers who want a repeatable, AI-assisted workflow for planning and building software incrementally.

## Key Features
- **Guided discovery and planning** -- Interactive Q&A that transforms vague ideas into well-defined PRDs and implementation plans
- **Brownfield project support** -- Autonomous codebase analysis that detects existing projects, audits the tech stack, and generates planning documents
- **Version-based building** -- Feature backlogs broken into versions, each with design documents, tasklists, and retrospectives
- **Patch workflow** -- Lightweight fixes and small enhancements that skip the full version build cycle while still tracking changes
- **Idea quick-capture** -- Log ideas mid-flow without disrupting the current workflow; ideas are offered as starting points for new versions/patches
- **Release notes management** -- Automatic generation and updates after each version or patch
- **Project metadata tracking** -- `cody.json` at the project root for multi-skill configuration and external tooling consumption
- **Configurable project path** -- Users choose where plan and build folders live during first-time setup
- **Agent memory refresh** -- Re-read all project documents so the AI agent can pick up where it left off in a new session
- **Multi-environment activation** -- Activation entry points for Claude Code, Cursor, and GitHub Copilot

## Success Criteria
- **GitHub stars** -- Primary adoption metric; increasing star count indicates growing usage and community interest
- **User completion rate** -- Users who activate Cody can successfully go from `:cody plan` through `:cody build` and produce a working product
- **Cross-environment compatibility** -- The skill works reliably across Claude Code, Cursor, and GitHub Copilot without environment-specific workarounds
- **Repeat usage** -- Users return to Cody for subsequent projects or versions, indicating the methodology provides lasting value

## Out of Scope
- **Code generation** -- Cody guides the AI agent's workflow but does not generate application code itself; that is the AI coding environment's job
- **Project hosting or deployment** -- Cody does not manage infrastructure, CI/CD, or deployment
- **Team collaboration features** -- Currently designed for individual builders, not multi-user workflows
- **AI model training or fine-tuning** -- Cody works with general-purpose AI models as-is
- **Plugin/extension marketplace** -- No plans for a plugin system within Cody itself

## User Stories
- As a non-developer with a product idea, I want to describe my idea in plain language and have the AI guide me through refining it into a clear plan, so I can start building with confidence
- As a builder returning to a project after a break, I want to refresh the AI agent's memory of my project so it picks up exactly where I left off
- As a builder mid-flow, I want to quickly capture an idea without losing my current context, so I can come back to it later
- As a builder with a bug, I want to fix it quickly without going through the full version process, so I can keep momentum
- As a builder with an existing codebase, I want Cody to analyze what I already have and generate planning documents, so I don't have to start from scratch

## Assumptions
- Users have access to at least one supported AI coding environment (Claude Code, Cursor, GitHub Copilot, or equivalent)
- AI coding environments can reliably read and follow markdown-based instructions
- Users are willing to engage in a guided Q&A process rather than just free-form prompting
- The markdown/JSON format remains portable across current and future AI coding tools
- Users have basic familiarity with using an AI coding environment (can type commands, review files)

## Dependencies
- **AI coding environments** -- Claude Code, Cursor, GitHub Copilot, and others must be able to interpret Cody's markdown command files and follow multi-step instructions
- **File system access** -- The AI environment must be able to read, create, and modify files in the project directory
- **GitHub** -- Distribution channel for the skill; users clone or download from the official repository
