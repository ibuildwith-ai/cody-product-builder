---
command: ":cody build version"
description: Work on a version — choose an existing version or add a new one.
---

# BUILD VERSION

### CHECK PREREQUISITES
- Check if {{cfWorkPhase}}/feature-backlog.md exists.
  - If it does NOT exist, tell the **USER** they need to create the feature backlog first (`:cody build backlog`). Stop here.

### ASK THE USER
- Ask the **USER**: `Would you like to work on an existing version from the backlog, or add a new version?`
- **STOP** and wait for the **USER**.

### DELEGATE
- If the **USER** wants to work on an **existing version** → **[AGENT TODO: Read and execute {{cfCommands}}/build-version-existing.md]**
- If the **USER** wants to **add a new version** → **[AGENT TODO: Read and execute {{cfCommands}}/build-version-new.md]**
