---
command: ":cody refresh"
description: Refreshes the memory about the current project of the AI AGENT.
---

# REFRESH AGENT MEMORY

A new AI session starts with no memory of the project. Refresh rebuilds that context by re-reading the project's own documents, so the agent works from current facts rather than assumptions.

### RE-RESOLVE PROJECT PATH
The project path can change between sessions -- a moved folder, an edited `cody.json` -- so re-resolve it before doing anything else. This is the same deterministic resolution the skill performs on activation, so it uses the same script.

- Run `{{cfRoot}}/scripts/resolve-config.py` from the project root. Cache the resolved `cfProject`, `cfPlanPhase`, `cfWorkPhase`, `cfReleaseNotes`, `cfPrototypes`, and `cfBestPractices` values for the rest of the session.
- Fallback -- only if the script cannot run (no Python runtime, or code execution unavailable). Read `cody.json` from the project root and resolve by hand:
  - If it has a `cody-product-builder` section: `{{cfProject}}` = `projectPath`; `{{cfPlanPhase}}` = `{{cfProject}}/plan`; `{{cfWorkPhase}}` = `{{cfProject}}/build`; `{{cfPrototypes}}` = `{{cfProject}}/prototypes`; `{{cfBestPractices}}` = `{{cfProject}}/best-practices`; `{{cfReleaseNotes}}` from `releaseNotesPath` (`"{{projectPath}}"` resolves to `{{cfWorkPhase}}`, `"{{projectRoot}}"` to the project root, any other value to that path).
  - If `cody.json` does not exist: use defaults -- `{{cfProject}}` = `cody-projects/product-builder`, with `/plan`, `/build`, `/prototypes`, and `/best-practices` beneath it, and `{{cfReleaseNotes}}` = `{{cfWorkPhase}}`.

### CHECK FOR BROWNFIELD PROJECT
- Check if {{cfPlanPhase}} folder exists and has documents (prd.md, plan.md, or brownfield-analysis.md).
  - If YES → continue to "ANNOUNCE TO THE **USER**" below (existing flow).
  - If NO → check if the project root has application code (source files, package files, config files beyond just `cody.json`).
    - If YES (brownfield) → **[AGENT TODO: Read and execute {{cfCommands}}/refresh-brownfield.md]**. Stop here.
    - If NO (empty project) → tell the **USER** no project files were found. Suggest running `:cody plan` to start from scratch. Stop here.

### CHECK PROJECT SETTINGS
**[AGENT TODO: Read and execute {{cfReferences}}/project-settings-check.md]**

### ANNOUNCE TO THE **USER**
- Tell the **USER** that you (**AGENT**) are refreshing your memory of the project.

### REVIEW DOCUMENTS AND PROJECT STRUCTURE
- Read {{cfPlanPhase}}/plan.md
- If you need more information, read {{cfPlanPhase}}/prd.md
- If you still need more information, read {{cfPlanPhase}}/brownfield-analysis.md (if it exists)
- If you still need more information, read {{cfWorkPhase}}/feature-backlog.md
- If you still need more information, read all the files for the last version in the {{cfWorkPhase}} folder
- If you still need more information, read the most recent patch documents in the {{cfWorkPhase}} folder (patch folders contain a `patch.md` file)
- If you still need more information, review the entire project, from the root level.
- If you still need more information, ask the **USER**.

### LOAD BEST PRACTICES
Best practices are the project's own learned rules, so loading them as part of the memory rebuild means the agent works to the project's standards from the start of the session.

**[AGENT TODO: Read and execute {{cfReferences}}/best-practices-consult.md]**

### DONE REVIEWING THE ENTIRE PROJECT
- Please tell the **USER** that your memory is refreshed and that you are ready to start working.

### OFFER TO UPDATE DOCUMENTS
- Ask the **USER**: `Would you also like me to review and update the PRD, plan, and release notes?`
- **STOP** and wait for the **USER**.
- If YES → **[AGENT TODO: Read and execute {{cfCommands}}/refresh-update.md]**
- If NO → done.
