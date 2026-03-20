- IMPORTANT: **AGENT**, please execute the following exactly
    1. Read and commit to memory `@.cody/agent.md`.
    2. Read `cody.json` from the project root.
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
              - After migration is complete, re-resolve `{{cfProject}}`, `{{cfPlanPhase}}`, `{{cfWorkPhase}}`, and `{{cfReleaseNotes}}` from the newly created `cody.json` and cache them for the session.
              - Show the contextual prompt based on the **phase** from `cody.json`.
            - If neither file exists: show `"What would you like to work on? Type :cody help to see all available commands."`
    6. Stop here and wait for the **USER**.
