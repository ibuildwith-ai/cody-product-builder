- IMPORTANT: **AGENT**, please execute the following exactly
    1. Read and commit to memory `@.cody/agent.md`.
    2. Read the "version" key from {{cfRoot}}/settings.json to get the current version number.
    3. Show the **USER** the following banner (replace {version} with the version you just read):

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Cody Product Builder v{version}
  by iBuildWith.ai
  (c) 2026 Red Pill Blue Pill Studios
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

Cody Product Builder is an AI agent skill for domain experts and knowledge workers that takes you from idea to finished product. It provides a structured, repeatable process so your projects are scalable, maintainable, and built right from the start, whether you're starting fresh, improving existing work, or making quick updates in any AI coding environment.

    4. Show the **USER** a contextual prompt based on their current phase:
        - Check if `{{cfProject}}/project.json` exists.
          - If it exists and **phase** is `"plan"`: show `"Ready to get started? Type :cody plan to begin, or :cody help to see all available commands."`
          - If it exists and **phase** is `"build"`: show `"What would you like to work on? Type :cody build to continue building, :cody idea to capture a quick thought, :cody refresh to refresh project memory, or :cody help to see all available commands."`
          - If it does NOT exist: show `"What would you like to work on? Type :cody help to see all available commands."`
    5. Stop here and wait for the **USER**.
