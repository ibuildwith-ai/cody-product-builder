---
command: ":cody build backlog"
description: Generates the feature backlog from the plan.
---

- **AGENT** show the **USER** the following first:

```
+---------------+
Build Phase Start
+---------------+
```

### CHECK PROJECT SETTINGS
- Check if `{{cfProject}}/project.json` exists.
  - If it does NOT exist, tell the **USER**: "This version of Cody Product Builder uses a project settings file. Let me set that up."
    - Read the PRD or plan docs to determine the project name and description.
    - Set version to `"0.0.0"` and phase to `"build"`.
    - Present all values to the **USER** for confirmation.
    - **STOP** and wait for the **USER**.
    - Copy `{{cfTemplates}}/project.json` to `{{cfProject}}/project.json` and fill in the confirmed values. Use `YYYY-MM-DD` format for dates.

### CREATE FEATURE BACKLOG
Check that {{cfTemplates}}/build/feature-backlog.md does not exist.

If it does not exist:

- Copy from {{cfTemplates}}/build/feature-backlog.md into {{cfWorkPhase}}
- Review the `plan.md` document you created in the discovery phase, then generate and update the `feature-backlog.md` document.
- Update `{{cfProject}}/project.json`: set **phase** to `"build"`, set **updatedAt** to today's date (use `YYYY-MM-DD` format).
- When you are done, tell the **USER** to review it.  Also tell the **USER** they can type `:cody build version` to start working on a version.
- Stop here.

If it does exist:

- Tell the **USER** that the build phase has already started.
- Tell the **USER** that the Feature Backlog already exists.
- Tell the **USER** they can work on any version they want next.
- Stop here.
