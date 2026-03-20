---
internal: true
description: Creates a lightweight patch for a quick bug fix or small enhancement. Delegated from build.md.
---

# PATCH

### ASK WHAT NEEDS TO BE DONE

- **AGENT** show the **USER** the following:
```
+-----------+
PATCH : START
+-----------+
```

### CHECK BACKLOG FOR IDEAS
- Check if `{{cfWorkPhase}}/feature-backlog.md` exists and has items in the **Backlog** section.
  - If YES, show the Backlog items and ask the **USER**: "Would you like to work on one of these backlog items, or describe something new?"
    - If the **USER** picks a backlog item, use it as the starting point for understanding the problem. Do NOT remove it from the Backlog section yet -- it will be removed when the patch entry is written in the feature backlog.
    - If the **USER** wants something new, continue with the normal flow below.
  - If NO (no file or no Backlog items), continue with the normal flow below.

- Ask the **USER**: `What needs to be fixed or changed?`
- **STOP** and wait for the **USER**.

### UNDERSTAND THE PROBLEM
- Ask brief, targeted follow-up questions until you (**AGENT**) understand the problem clearly. Keep it to 2-3 questions maximum -- patches are meant to be fast.
- If the **USER** types `help me`, provide 3 possible ways they can clarify.
- Once you understand the problem, continue.

### DETERMINE PATCH VERSION
- Look at all existing version and patch folders in {{cfWorkPhase}} to determine the next available patch version number.
- Suggest a patch version number and a short name to the **USER** (following the Version Naming Convention in {{cfRoot}}/agent.md -- the patch increment of `v[major.minor.patch]`).
- Ask the **USER** to confirm the version number and name.
- **STOP** and wait for the **USER**.

### CREATE PATCH FOLDER AND DOCUMENT
- Create the patch folder in {{cfWorkPhase}} using the confirmed version name (e.g., `v0.2.1-fix-login-bug`).
- Copy `{{cfTemplates}}/build/patch.md` to the patch folder.
- Fill in the following sections of the patch document:
  - **Patch Version** -- the confirmed version number and name
  - **Date** -- today's date
  - **Type** -- Bug Fix, Small Enhancement, or Hotfix (determine from the conversation)
  - **Original Prompt** -- the **USER's** original request
  - **Problem** -- your understanding of the issue

### PRESENT THE PLAN
- Write your proposed approach in the **Plan** section of the patch document.
- Present the plan to the **USER** and ask for confirmation.
- **STOP** and wait for the **USER**.
- If the **USER** wants changes, adjust the plan and ask again.

### DO THE FIX
- Once the **USER** confirms the plan, implement the fix.
- Iterate with the **USER** until the fix is completed and approved.

### UPDATE PATCH DOCUMENT
- Update the patch document with:
  - **Solution** -- what was actually done
  - **Files Changed** -- auto-generate the list of files you created, modified, or deleted
  - **Testing Notes** -- how the **USER** can verify the fix

### UPDATE RELEASE NOTES
- Check if {{cfReleaseNotes}}/release-notes.md exists.
  - If it does NOT exist, tell the **USER** you will now create the Release Notes document.
    - If the {{cfReleaseNotes}} directory does not exist, create it.
    - Copy from {{cfTemplates}}/build/release-notes.md to {{cfReleaseNotes}}/release-notes.md.
- Add a patch entry to the release notes in the correct chronological position (latest at the top). Use the patch entry format defined in the release notes template.

### VERIFY THE FIX
- Run any applicable verification you (**AGENT**) can do: check the code compiles, run related tests, or do a quick sanity check.
- If anything fails, fix it and iterate with the **USER** before continuing.

### USER TESTING
- Present the **Testing Notes** from the patch document to the **USER**.
- Ask the **USER** to test the fix and confirm it works.
- **STOP** and wait for the **USER**.
- If the **USER** reports issues, go back to "DO THE FIX" and iterate.

### UPDATE PROJECT SETTINGS
- Update `cody.json` in the project root, in the `cody-product-builder` section:
  - Set **version** to the patch version number just completed
  - If **phase** is `"plan"`, update it to `"build"`
  - Set **updatedAt** to today's date (use `YYYY-MM-DD` format)

### DONE

- **AGENT** show the **USER** the following:
```
+---------------+
PATCH : COMPLETED
+---------------+
```

**AGENT ANNOUNCE**
```
Patch completed and verified. Please commit and push your changes to git.

When you're ready, you can continue with:

:cody build (to work on another version or patch)
:cody refresh (to update project documents)

What would you like to do next?
```
