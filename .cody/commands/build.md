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
    - Update `{{cfProject}}/project.json`: set **phase** to `"build"`, set **updatedAt** to today's date (use `YYYY-MM-DD` format).
    - Tell the **USER** to review the backlog.
    - **STOP** and wait for the **USER**.

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
