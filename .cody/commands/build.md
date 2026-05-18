---
command: ":cody build"
description: Guided build phase — creates the feature backlog if needed, then offers options to create a new version, work on an existing version, or work on a patch.
---

# BUILD

- **AGENT** show the **USER** the following:
```
+---------------------+
BUILD PHASE : START
+---------------------+
```

### CHECK PREREQUISITES
- Check if {{cfPlanPhase}} folder exists and has plan phase documents (prd.md or plan.md).
  - If it does NOT exist, tell the **USER** they need to complete the plan phase first (`:cody plan`). Stop here.
- If {{cfWorkPhase}} folder does not exist, create it.

### CHECK PROJECT SETTINGS
**[AGENT TODO: Read and execute {{cfReferences}}/project-settings-check.md]**

### CHECK FEATURE BACKLOG
- Check if {{cfWorkPhase}}/feature-backlog.md exists.
  - If it does NOT exist:
    - Tell the **USER**: "Before we start building, I need to create a Feature Backlog. The backlog is a list of all the features, enhancements, and tasks from your plan, organized into versions. It's what we'll use to decide what gets built and in what order."
    - **[AGENT TODO: Read and execute {{cfCommands}}/build-backlog.md]**
    - Update `cody.json` in the project root: in the `cody-product-builder` section, set **phase** to `"build"` and set **updatedAt** to today's date (use `YYYY-MM-DD` format).
    - Tell the **USER** to review the backlog.
    - **STOP** and wait for the **USER**.

### NOTE AVAILABLE PROTOTYPES
- Check the `{{cfPrototypes}}` folder for any prototypes. Verify with at least two methods before concluding there are none.
- If there are none, continue silently to the next section.
- If there are any, mention them to the **USER** in a single line so they know the prototypes are available (for example: `You have these prototypes available if you'd like to use one: <names>`). Do NOT ask a question and do NOT stop.
- If the **USER** asks to use a prototype, read its `prototype.md` from `{{cfPrototypes}}` (and look at its artifact if helpful) and factor it into the build work.

### WHAT WOULD YOU LIKE TO DO?

**AGENT ANNOUNCE**
```
What would you like to do?

1) Create a new version
2) Work on an existing version
3) Work on a patch (quick fix or small enhancement)
```

- **STOP** and wait for the **USER**.

### DELEGATE
- If the **USER** chooses **option 1** (create a new version) → **[AGENT TODO: Read and execute {{cfCommands}}/build-version-new.md]**
- If the **USER** chooses **option 2** (work on an existing version) → **[AGENT TODO: Read and execute {{cfCommands}}/build-version-existing.md]**
- If the **USER** chooses **option 3** (work on a patch) → **[AGENT TODO: Read and execute {{cfCommands}}/patch.md]**
