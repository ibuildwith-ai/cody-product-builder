---
command: ":cody patch"
description: Creates a lightweight patch for a quick bug fix or small enhancement, skipping the full version build cycle.
---

# PATCH

### CHECK PREREQUISITES
- Check if {{cfPlanPhase}} folder exists and has plan phase documents (prd.md or plan.md).
  - If it does NOT exist, tell the **USER** they need to complete the plan phase first (`:cody plan`). Stop here.
- If {{cfWorkPhase}} folder does not exist, create it.

### ASK WHAT NEEDS TO BE DONE

- **AGENT** show the **USER** the following:
```
+-----------+
PATCH : START
+-----------+
```

- Ask the **USER**: `What needs to be fixed or changed?`
- **STOP** and wait for the **USER**.

### UNDERSTAND THE PROBLEM
- Ask brief, targeted follow-up questions until you (**AGENT**) understand the problem clearly. Keep it to 2–3 questions maximum — patches are meant to be fast.
- If the **USER** types `help me`, provide 3 possible ways they can clarify.
- Once you understand the problem, continue.

### DETERMINE PATCH VERSION
- Look at all existing version and patch folders in {{cfWorkPhase}} to determine the next available patch version number.
- Suggest a patch version number and a short name to the **USER** (following the Version Naming Convention in {{cfRoot}}/agent.md — the patch increment of `v[major.minor.patch]`).
- Ask the **USER** to confirm the version number and name.
- **STOP** and wait for the **USER**.

### CREATE PATCH FOLDER AND DOCUMENT
- Create the patch folder in {{cfWorkPhase}} using the confirmed version name (e.g., `v0.2.1-fix-login-bug`).
- Copy `{{cfTemplates}}/build/patch.md` to the patch folder.
- Fill in the following sections of the patch document:
  - **Patch Version** — the confirmed version number
  - **Date** — today's date
  - **Type** — Bug Fix, Small Enhancement, or Hotfix (determine from the conversation)
  - **Original Prompt** — the **USER's** original request
  - **Problem** — your understanding of the issue

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
  - **Solution** — what was actually done
  - **Files Changed** — auto-generate the list of files you created, modified, or deleted
  - **Testing Notes** — how the **USER** can verify the fix

### UPDATE RELEASE NOTES
- Check if {{cfWorkPhase}}/release-notes.md exists.
  - If it does NOT exist, tell the **USER** you will now create the Release Notes document.
    - Copy from {{cfTemplates}}/build/release-notes.md to {{cfWorkPhase}}/release-notes.md.
- Add a patch entry to the release notes in the correct chronological position (latest at the top). Use the patch entry format defined in the release notes template.

### DONE

- **AGENT** show the **USER** the following:
```
+---------------+
PATCH : COMPLETED
+---------------+
```

- Tell the **USER** to test the fix and then `commit to git`.

**AGENT ANNOUNCE**
```
Patch completed. You can continue with:

:cody patch (apply another patch)
:cody build version (work on a version from the backlog)

What would you like to do next?
```