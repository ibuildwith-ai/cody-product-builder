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

### ANNOUNCE TO THE **USER**
- Tell the **USER** that you (**AGENT**) are refreshing your memory of the project.

### REVIEW DOCUMENTS AND PROJECT STRUCTURE
- Read {{cfPlanPhase}}/plan.md
- If you need more information, read {{cfPlanPhase}}/prd.md
- If you still need more information, read {{cfPlanPhase}}/brownfield-analysis.md (if it exists)
- If you still need more information, read {{cfWorkPhase}}/feature-backlog.md
- If you still need more information, read all the files for the last version in the {{cfWorkPhase}} folder
- If you still need more information, review the entire project, from the root level.
- If you still need more information, ask the **USER**.

### DONE REVIEWING THE ENTIRE PROJECT
- Please tell the **USER** that your memory is refreshed and that you are ready to start working.
