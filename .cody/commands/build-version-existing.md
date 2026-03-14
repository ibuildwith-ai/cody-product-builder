---
internal: true
description: Builds an existing version from the feature backlog. Delegated from build-version.md.
---

# BUILD VERSION

### CHECK PROJECT SETTINGS
- Check if `{{cfProject}}/project.json` exists.
  - If it does NOT exist, tell the **USER**: "This version of Cody Product Builder uses a project settings file. Let me set that up."
    - Read the PRD or plan docs to determine the project name and description.
    - Scan version and patch folders in {{cfWorkPhase}} to find the latest completed version (default to `"0.0.0"` if none found).
    - Set phase to `"build"` if {{cfWorkPhase}} has version or patch folders, otherwise `"plan"`.
    - Present all values to the **USER** for confirmation.
    - **STOP** and wait for the **USER**.
    - Copy `{{cfTemplates}}/project.json` to `{{cfProject}}/project.json` and fill in the confirmed values. Use `YYYY-MM-DD` format for dates.

### CHOOSE VERSION TO BUILD
- If the **USER** already typed the version they want to build, you can skip to the next section, 'CREATE VERSION FOLDER', otherwise:
- Show the **USER** a list of versions available from the {cfWorkPhase}feature-backlog.md file that have a Status of "Not Started" or "In Progress"
- Ask the **USER** which version they would like to build.

### CREATE VERSION FOLDER
- Create the version folder, using the version name from the selected version, but make sure you convert that name to follow the 'Version Naming Convention' section rules in {{cfRoot}}/agent.md file.

### GENERATE DESIGN DOCUMENT
- Copy the design.md template from {{cfTemplates}}/build/version/design.md to the version folder you just created.
- Generate and update the design.md document with details from the version the **USER** chose to build.
- Tell the **USER** to check the design.md document in the current version.
- Tell the **USER** to announce when they are done.
- Stop and wait for the **USER**.

### GENERATE TASKLIST
- Copy the tasklist.md template from {{cfTemplates}}/build/version/tasklist.md to the version folder you just created.
- Create and generate the tasklist.md document using any of the previous documents created as reference.
- Tell the **USER** to review the tasklist.md document in the current version and when they are done, to tell you.
- Stop and wait for the **USER**.

### CHOOSE WHAT TO BUILD
- Ask the **USER** which task or phase in the tasklist.md file they would like to start working on.
- Stop here and wait for **USER** to tell you.

### CODING TIME
- Iterate with the **USER** on the work until completed and approved by **USER**.
- CRITICAL: When you (**AGENT**) announce that the phase is completed, make sure you tell the **USER** to test and then to `commit to git`, before moving on to the next phase.
- Once completed, ask **USER** what to work on next.
- Iterate until all phases for the version are completed.

### VERSION COMPLETED
When you (**AGENT**) reached the end of the version, tell the **USER** this version has been completed.

### UPDATE FEATURE BACKLOG
- Tell the **USER** that you will update the Feature Backlog now.
- Update the version in {{cfWorkPhase}}/feature-backlog.md to `completed` status.

### CREATE RETROSPECTIVE
- Tell the **USER** that you will create a Retrospective now.
- Copy from {{cfTemplates}}/build/version/retrospective.md to the current version folder.
- Update the retrospective.md file.

### UPDATE PROJECT SETTINGS
- Update `{{cfProject}}/project.json`:
  - Set **version** to the version number just completed
  - Set **updatedAt** to today's date (use `YYYY-MM-DD` format)

### CREATE / UPDATE RELEASE NOTES
- Check to see if the {{cfWorkPhase}}/release-notes.md file exists.
    - If it does not exist, tell the **USER** you will now create the Release Notes document.
        - Copy from {{cfTemplates}}/build/release-notes.md to {{cfWorkPhase}}/release-notes.md.
- Read and follow the instructions in the {{cfWorkPhase}}/release-notes.md file for updating it.

### REFRESH AI AGENT MEMORY AND PROJECT DOCUMENTS

**AGENT ANNOUNCE**
```
This version is now completed. If you think the PRD or PLAN files need update
due to the changes implemented in this version, you can use the following
command:

:cody refresh

Otherwise, you can continue working on a new version with:

:cody build version

What would you like to do next?
```
