# AGENT INSTRUCTIONS:
- Read this entire document and commit it to memory.
- Make sure you check this document often if you need to understand how to process any Cody Product Builder Toolkit commands.
- Anything that has **[AGENT TODO: to do item]** means you need to take action.
- When you see **AGENT ANNOUNCE**, anthing in betweeen the ```[message]``` (tick marks), you will display to the user exactly was stated.
- After every phase, make sure you re-read this document.
- If this is the first time this file was accessed in this project, execute the command `:cody help`
- {{cfPlaceholders}} used in commands are defined in this document, under the "Template Placeholder Values" section.  When you see a placeholder, you will replace it with its appropriate value.
- The roles are as follows:
    - **USER** Is the human guding you in the building process.
    - **AGENT** That's you!  The AI Development **AGENT**.

## About Cody Product Builder Toolkit
Cody PBT is a spec-driven development toolkit built specifically to help Vibe Coders bring their ideas to life. Cody guides builders through idea discovery and refinement, transforming vague concepts into well-defined plans, then breaking them into manageable chunks (called versions) for systematic implementation, all without stifling creativity. It is designed for Claude Code, Codex, Gemini CLI, OpenCode, Cursor, Copilot, and other AI coding environments.

## About Phases
Cody PBT has the following 2 phases that all **USERS** will go through:

### 1. Plan
This phase guides **USERS** through the creation of documents that help define, transform and formalize their product idea into actionable documents.

| Document | Description |
|----------|-------------|
| `discovery.md` | This document captures the raw, unfiltered idea or initial AI prompt that sparked the project. It also holds the iterative process of Q&A between the **USER** and the **AGENT**. |
| `prd.md` | This document formalizes the idea and defines "the what and the why" of the product the **USER** is building. |
| `plan.md` | This document defines how the product will be built and when. |


### 2. Build
This phase guides USERS through the iterative development cycle by creating documents that break their application into manageable chunks called versions.  We first start creating the feature backlog.

| Document | Description |
|----------|-------------|
| `feature-backlog.md` | This document lists features and enhancements derived from the plan. It lives on the top level of the Build phase, accessible by all versions. It is a living document that will evolve throughout the project. It is grouped by version (each version is a table), with the Backlog (table) tracking all features not added to a version yet.  It is used to build versions. |
| `release-notes.md` | This document provides automatic release notes generation and management throughout the build lifecycle. It tracks all versions, key features, enhancements, bug fixes, and other notable changes. This document is created and updated automatically after each version build and during global project updates. |

> Then we create versions based on the feature backlog. The following documents are used for every version a **USER** works on.

| Document | Description |
|----------|-------------|
| `design.md` | This document outlines the technical implementation and design guide for the upcoming version. |
| `tasklist.md` | This document outlines all the tasks to work on, grouped by phases, to deliver this particular version. |
| `retrospective.md` | This document reflects on what worked, what didn't, and how future versions can be improved. |

## Version Naming Convention
- Version numbers follow the format v[major.minor.patch] and increment by one automatically, unless the USER specifically requests a particular version number.
- Version folders inside the @.cody/build/ folder are named "v[major.minor.patch]-[name]" (e.g. v1.0.3-refactor-code)
- The starting version will be 0.1.0, unless the USER specifically requests a particular version number.
- Names can't be longer than 30 characters in total.  Names can only include dashes to separate words and must be all in lower case.  Only allow letters (lower case), numbers (0-9) and '-' (dashes) to separate words.
- If the USER didn't provide a version, automatically assign one.
- If the USER didn't provide a name for the version, skip the `-[name]`

## Template Placeholder Values
These placeholders are a pointer to actual values. They are created here and used throughout various commands.  When you encounter a placeholder value, you will replace it with it's value and consider that as the literal (e.g. {{cfConfig}}/agent.md would translate to .cody/config/agent.md)

| Placeholder | Maps to | Description |
|------------|---------|-------------|
| {{cfRoot}} | .cody/ | Cody root folder |
| {{cfConfig}} | .cody/config/ | Cody configuration folder |
| {{cfTemplates}} | .cody/config/templates | Cody templates folder |
| {{cfCommands}} | .cody/config/commands | Cody commands to be executed. |
| {{cfComponents}} | .cody/config/components | Cody design system components the **AGENT** will use to display stylized messages in the chat window. |
| {{cfScripts}} | .cody/config/scripts | Cody scripts folder for utility scripts. |
| {{cfProject}} | .cody/project/ | Project folder for generate files. |
| {{cfPlanPhase}} | .cody/project/plan | Cody root folder for the planning phase. |
| {{cfWorkPhase}} | .cody/project/build | Cody root folder for the build phase. |
| {{cfDocs}} | .cody/project/library/docs | Cody documentation folder for reference docs such as Tech Stacks, CMS Management, Design System, etc. |
| {{cfAssets}} | .cody/project/library/assets | Cody assets folder for the **USER** to store assets the **AGENT** can review (e.g. diagrams, images, etc). |
| {{cfRules}} | .cody/project/library/rules | Cody rules that a **USER** can create for the **AGENT** to follow. |
| {{cfPrompts}} | .cody/project/library/prompts | Cody prompt templates that a **USER** can reuse. |

##  `{{cfAssets}}` in USER Prompts and What the **AGENT** Should Do
The **USER** at times may want to tell the **AGENT** about a particular file that they need to review as part of their prompt. For example, the **USER** may state something like "Check out the database.png file in the `{{cfAssets}}` folder". If the **USER** uses in any of their prompts `{{cfAssets}}`, the **AGENT* can use the Template Placeholder Values table to look up the actual location of the {{cfAssets}} for that file. If it does not find it, it should tell the user that it was not found and give a list of all the files found in the `{{cfAssets}}` folder.

## Executing Commands

- If the **USER** types any of the commands listed below, follow the instructions inside the files for each command listed below.
- If you (**AGENT**) are reading this file to get familiar (or re-familiarize yourself) with it, please make sure you read all the files in the {{commands}} folder.

> ### `:cody assets list`
**[AGENT TODO: Read and execute {{cfCommands}}/assets-list.md]** 

> ### `:cody build`
**[AGENT TODO: Read and execute {{cfCommands}}/build.md]** 

> ###  `:cody help` 
**[AGENT TODO: Read and execute {{cfCommands}}/help.md ]** 

> ### `:cody plan`
**[AGENT TODO: Read and execute {{cfCommands}}/plan.md]** 

> ### `:cody refresh update`
**[AGENT TODO: Read and execute {{cfCommands}}/refresh-update.md]** 

> ### `:cody refresh`
**[AGENT TODO: Read and execute {{cfCommands}}/refresh.md]** 

> ### `:cody relearn`
**[AGENT TODO: Read and execute {{cfCommands}}/relearn.md]** 

> ### `:cody version add`
**[AGENT TODO: Read and execute {{cfCommands}}/version-add.md]** 

> ### `:cody upgrade`
**[AGENT TODO: Read and execute {{cfCommands}}/upgrade.md]**

> ### `:cody version build`
**[AGENT TODO: Read and execute {{cfCommands}}/version-build.md]** 