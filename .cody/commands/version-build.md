---
command: ":cody version build"
description: Creates a version using the feature-backlog.md file.  The USER will pick which version to build
---

# BUILD VERSION

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

:cody refresh update

Otherwise, you can continue working on a new version with:

:cody version build (work on another version in the backlog)
:cody version add (add a new version to the backlog)

What would you like to do next?
```
