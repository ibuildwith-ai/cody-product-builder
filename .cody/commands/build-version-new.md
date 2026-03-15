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

### CHECK BACKLOG FOR IDEAS
- Check if `{{cfWorkPhase}}/feature-backlog.md` exists and has items in the **Backlog** section.
  - If YES, show the Backlog items and ask the **USER**: "Would you like to work on one of these backlog items, or describe something new?"
    - If the **USER** picks a backlog item, use it as the starting point for the new version discovery. Do NOT remove it from the Backlog section yet -- it will be removed when the version entry is written in the feature backlog.
    - If the **USER** wants something new, continue with the normal flow.
  - If NO (no file or no Backlog items), continue with the normal flow.

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
