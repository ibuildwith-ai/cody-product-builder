---
name: cody-product-builder
description: Guides knowledge workers and domain experts from idea to finished product through a structured two-phase workflow (Plan and Build). Use this skill whenever the user wants to plan, design, build, or ship a product, app, tool, or feature; add a new version or patch to an existing project; prototype or test an idea quickly; capture a product idea; or types any :cody command. Trigger it even when the user does not say "Cody" but describes wanting to build something, start a project, scope features, write a PRD, or organize product development.
version: 2.0.0
---

# Cody Product Builder

## Agent Instructions
- Read this entire document (`SKILL.md`) and commit it to memory.
- Make sure you check this document often if you need to understand how to process any Cody Product Builder commands.
- Anything that has **[AGENT TODO: to do item]** means you need to take action.
- When you see **AGENT ANNOUNCE**, anything in between the ```[message]``` (tick marks), you will display to the user exactly as stated.
- After every phase, make sure you re-read this document.
- {{cfPlaceholders}} used in commands are defined in this document, under the "Template Placeholder Values" section. When you see a placeholder, you will replace it with its appropriate value.
- The roles are as follows:
    - **USER** Is the human guiding you in the building process.
    - **AGENT** That's you! The AI Development **AGENT**.

## About Cody Product Builder
Cody Product Builder is an AI agent skill that guides users from idea to finished product through structured planning and iterative building.

For detailed phase descriptions, document references, and version naming conventions, see `{{cfReferences}}/phases.md`.

## Template Placeholder Values
These placeholders are a pointer to actual values. They are created here and used throughout various commands. When you encounter a placeholder, you will replace it with its value and consider that as the literal (e.g. `{{cfCommands}}/help.md` translates to `commands/help.md`).

The skill-file placeholders (`{{cfRoot}}`, `{{cfTemplates}}`, `{{cfCommands}}`, `{{cfReferences}}`) are paths relative to this skill's own folder.

| Placeholder | Maps to | Description |
|------------|---------|-------------|
| {{cfRoot}} | . | This skill's root folder. |
| {{cfTemplates}} | templates | Cody templates folder. |
| {{cfCommands}} | commands | Cody commands to be executed. |
| {{cfReferences}} | references | Shared reference content loaded on demand by commands. |
| {{cfProject}} | *Dynamic -- resolved from `cody.json`* | Project output folder. Read from `cody.json > cody-product-builder > projectPath`. Default: `cody-projects/product-builder`. Resolved on activation and cached for the session. Re-resolved on `:cody refresh`. |
| {{cfPlanPhase}} | *`{{cfProject}}/plan`* | Plan phase folder. |
| {{cfWorkPhase}} | *`{{cfProject}}/build`* | Build phase folder. |
| {{cfReleaseNotes}} | *Dynamic -- resolved from `cody.json`* | Release notes folder. Read from `cody.json > cody-product-builder > releaseNotesPath`. If `"{{projectPath}}"`: resolves to `{{cfWorkPhase}}`. If `"{{projectRoot}}"`: resolves to project root. Otherwise: resolves to the custom path. Resolved on activation and cached for the session. Re-resolved on `:cody refresh`. |
| {{cfPrototypes}} | *`{{cfProject}}/prototypes`* | Prototype output folder. Holds throwaway, self-contained prototype subfolders, each with its own `prototype.md` and code. Sits outside the Plan and Build phases. |

## File System Checks
- Always use the placeholder paths (e.g., `{{cfPlanPhase}}`, `{{cfProject}}`) when checking for files or folders. Never construct paths manually or use relative paths like `./cody-projects/...`.
- Before concluding that a folder is empty or files don't exist, always verify with at least two different methods (e.g., a glob search AND a directory listing). Never make decisions based on a single failed search. This prevents false negatives caused by path resolution issues.

## Executing Commands

- If the **USER** types any of the commands listed below, read and execute the corresponding command file.
- Only read command files when they are invoked. Do not pre-load all commands.

> ### `:cody help`
**[AGENT TODO: Read and execute {{cfCommands}}/help.md]**

> ### `:cody plan`
**[AGENT TODO: Read and execute {{cfCommands}}/plan.md]**

> ### `:cody build`
**[AGENT TODO: Read and execute {{cfCommands}}/build.md]**

> ### `:cody idea`
**[AGENT TODO: Read and execute {{cfCommands}}/idea.md]**

> ### `:cody prototype`
**[AGENT TODO: Read and execute {{cfCommands}}/prototype.md]**

> ### `:cody refresh`
**[AGENT TODO: Read and execute {{cfCommands}}/refresh.md]**

## Activation

When this skill is activated, **AGENT**, please execute the following exactly:

1. Read `cody.json` from the project root.
   - If it exists and has a `cody-product-builder` section:
     - Resolve `{{cfProject}}` from the `projectPath` value.
     - Resolve `{{cfPlanPhase}}` as `{{cfProject}}/plan`.
     - Resolve `{{cfWorkPhase}}` as `{{cfProject}}/build`.
     - Resolve `{{cfReleaseNotes}}` from the `releaseNotesPath` value: if `"{{projectPath}}"` use `{{cfWorkPhase}}`, if `"{{projectRoot}}"` use the project root, otherwise use the custom path.
     - Cache these resolved values for the rest of the session.
     - If the `releaseNotesPath` field is missing from `cody.json`:
       - Tell the **USER** where `release-notes.md` currently lives (check `{{cfWorkPhase}}/release-notes.md`).
       - Ask: "Would you like to keep release notes there, or move them?" with options:
         1. Keep current location
         2. Project root
         3. Custom path
       - **STOP** and wait for the **USER**.
       - If they keep the current location, set `releaseNotesPath` to `"{{projectPath}}"` in `cody.json`.
       - If project root, set `releaseNotesPath` to `"{{projectRoot}}"` in `cody.json`.
       - If custom, ask for the path and set `releaseNotesPath` to that value in `cody.json`.
       - If they chose a different location and `release-notes.md` exists at the current location, move it to the new location.
       - Re-resolve `{{cfReleaseNotes}}` and cache it.
   - If it does NOT exist:
     - Use defaults: `{{cfProject}}` = `cody-projects/product-builder`, `{{cfPlanPhase}}` = `cody-projects/product-builder/plan`, `{{cfWorkPhase}}` = `cody-projects/product-builder/build`, `{{cfReleaseNotes}}` = `cody-projects/product-builder/build`.
     - Cache these defaults for the rest of the session.

2. Show the **USER** the following banner (replace {version} with the `version` value from this file's frontmatter):

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Cody Product Builder v{version}
  by iBuildWith.ai
  (c) 2026 Red Pill Blue Pill Studios
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

Cody Product Builder is an AI agent skill for domain experts and knowledge workers that takes you from idea to finished product. It provides a structured, repeatable process so your projects are scalable, maintainable, and built right from the start, whether you're starting fresh, improving existing work, or making quick updates in any AI coding environment.

3. Show the **USER** a contextual prompt based on their current phase:
    - Check if `cody.json` exists and has a `cody-product-builder` section.
      - If it exists and **phase** is `"plan"`: show `"Ready to get started? Type :cody plan to begin, :cody prototype to test an idea first, or :cody help to see all available commands."`
      - If it exists and **phase** is `"build"`: show `"What would you like to work on? Type :cody build to continue building, :cody prototype to test an idea, :cody idea to capture a quick thought, :cody refresh to refresh project memory, or :cody help to see all available commands."`
      - If it does NOT exist, check if the legacy file `cody-projects/product-builder/project.json` exists.
        - If the legacy file exists:
          - Tell the **USER**: "This version of Cody Product Builder uses a new project settings format. Let me migrate your settings."
          - **[AGENT TODO: Read and execute {{cfReferences}}/project-settings-check.md]**
          - After migration is complete, re-resolve `{{cfProject}}`, `{{cfPlanPhase}}`, `{{cfWorkPhase}}`, and `{{cfReleaseNotes}}` from the newly created `cody.json` and cache them for the session.
          - Show the contextual prompt based on the **phase** from `cody.json`.
        - If neither file exists: show `"What would you like to work on? Type :cody help to see all available commands."`

4. Stop here and wait for the **USER**.
