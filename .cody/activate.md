- IMPORTANT: **AGENT**, please execute the following exactly
    1. Read and commit to memory `@.cody/agent.md`.
    2. Read `cody.json` from the project root.
       - If it exists and has a `cody-product-builder` section:
         - Resolve `{{cfProject}}` from the `projectPath` value.
         - Resolve `{{cfPlanPhase}}` as `{{cfProject}}/plan`.
         - Resolve `{{cfWorkPhase}}` as `{{cfProject}}/build`.
         - Cache these resolved values for the rest of the session.
       - If it does NOT exist:
         - Use defaults: `{{cfProject}}` = `cody-projects/product-builder`, `{{cfPlanPhase}}` = `cody-projects/product-builder/plan`, `{{cfWorkPhase}}` = `cody-projects/product-builder/build`.
         - Cache these defaults for the rest of the session.
    3. Read the "version" key from {{cfRoot}}/settings.json to get the current version number.
    4. Show the **USER** the following banner (replace {version} with the version you just read):

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Cody Product Builder v{version}
  by iBuildWith.ai
  (c) 2026 Red Pill Blue Pill Studios
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

Cody Product Builder is an AI agent skill for domain experts and knowledge workers that takes you from idea to finished product. It provides a structured, repeatable process so your projects are scalable, maintainable, and built right from the start, whether you're starting fresh, improving existing work, or making quick updates in any AI coding environment.

    5. Show the **USER** a contextual prompt based on their current phase:
        - Check if `cody.json` exists and has a `cody-product-builder` section.
          - If it exists and **phase** is `"plan"`: show `"Ready to get started? Type :cody plan to begin, or :cody help to see all available commands."`
          - If it exists and **phase** is `"build"`: show `"What would you like to work on? Type :cody build to continue building, :cody idea to capture a quick thought, :cody refresh to refresh project memory, or :cody help to see all available commands."`
          - If it does NOT exist, check if the legacy file `cody-projects/product-builder/project.json` exists.
            - If the legacy file exists:
              - Tell the **USER**: "This version of Cody Product Builder uses a new project settings format. Let me migrate your settings."
              - **[AGENT TODO: Read and execute {{cfReferences}}/project-settings-check.md]**
              - After migration is complete, re-resolve `{{cfProject}}`, `{{cfPlanPhase}}`, and `{{cfWorkPhase}}` from the newly created `cody.json` and cache them for the session.
              - Show the contextual prompt based on the **phase** from `cody.json`.
            - If neither file exists: show `"What would you like to work on? Type :cody help to see all available commands."`
    6. Stop here and wait for the **USER**.
