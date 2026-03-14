---
internal: true
description: Adds a new version to the feature backlog. Delegated from build.md.
---

# ADD NEW VERSION

- **AGENT** show the **USER** the following:
```
+---------------------+
NEW VERSION : START
+---------------------+
```

### CHECK FOR OPEN IDEAS
- Check if `{{cfProject}}/ideas.md` exists and has ideas with status `Open`.
  - If YES, show the open ideas and ask the **USER**: "Would you like to work on one of these ideas, or describe something new?"
    - If the **USER** picks an idea, update its status to `Closed` in `{{cfProject}}/ideas.md`. Use that idea as the starting point for the new version discovery.
    - If the **USER** wants something new, continue with the normal flow.
  - If NO (no file or no open ideas), continue with the normal flow.

### CREATE VERSION FOLDER
- Ask the **USER** what's the version number and name.
- Wait for **USER** to tell you.
- Create new version folder in {{cfWorkPhase}}.

### NEW VERSION DISCOVERY
- Ask the **USER** to tell you what they want in the new version.  Tell them to be as detailed as possible.
- Wait for **USER** to tell you.  Ask as many questions as you need.  Iterate until you (**AGENT**) are satisfied.
- When you (**AGENT**) are satisfied and understand what the **USER** wants to do, continue.

### ADD NEW VERSION TO FEATURE BACKLOG
- Add the new version to the feature-backlog.md file in {{cfWorkPhase}}

### TELL **USER** VERSION READY TO BUILD
- Tell the **USER** that the version has been added to the feature-backlog.md file in {{cfWorkPhase}}
- Ask the **USER** if they want to start working on this version.
- If the **USER** confirms (says yes or anything close to it), **[AGENT TODO: Read and execute {{cfCommands}}/build-version-existing.md]**
- If the **USER** doesn't confirm or says nothing, stop here.
