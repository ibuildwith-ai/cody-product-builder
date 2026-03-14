---
command: ":cody refresh"
description: Refreshes the memory about the current project of the AI AGENT.
---

# REFRESH AGENT MEMORY

### CHECK FOR BROWNFIELD PROJECT
- Check if {{cfPlanPhase}} folder exists and has documents (prd.md, plan.md, or brownfield-analysis.md).
  - If YES → continue to "ANNOUNCE TO THE **USER**" below (existing flow).
  - If NO → check if the project root has application code (source files, package files, config files beyond just `.cody/`).
    - If YES (brownfield) → **[AGENT TODO: Read and execute {{cfCommands}}/refresh-brownfield.md]**. Stop here.
    - If NO (empty project) → tell the **USER** no project files were found. Suggest running `:cody plan` to start from scratch. Stop here.

### CHECK PROJECT SETTINGS
- Check if `{{cfProject}}/project.json` exists.
  - If it does NOT exist AND `{{cfProject}}` folder exists, tell the **USER**: "This version of Cody Product Builder uses a project settings file. Let me set that up."
    - Read the PRD or plan docs to determine the project name and description.
    - Scan version and patch folders in {{cfWorkPhase}} to find the latest completed version (default to `"0.0.0"` if none found).
    - Set phase to `"build"` if {{cfWorkPhase}} has version or patch folders, otherwise `"plan"`.
    - Present all values to the **USER** for confirmation.
    - **STOP** and wait for the **USER**.
    - Copy `{{cfTemplates}}/project.json` to `{{cfProject}}/project.json` and fill in the confirmed values. Use `YYYY-MM-DD` format for dates.

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

### DONE REVIEWING THE ENTIRE PROJECT
- Please tell the **USER** that your memory is refreshed and that you are ready to start working.

### OFFER TO UPDATE DOCUMENTS
- Ask the **USER**: `Would you also like me to review and update the PRD, plan, and release notes?`
- **STOP** and wait for the **USER**.
- If YES → **[AGENT TODO: Read and execute {{cfCommands}}/refresh-update.md]**
- If NO → done.
