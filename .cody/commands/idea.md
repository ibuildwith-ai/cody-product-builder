---
command: ":cody idea"
description: Quick-capture an idea or view all captured ideas.
---

# IDEA

### DETERMINE ACTION
- If the **USER** typed `:cody idea` with a description (e.g., `:cody idea add dark mode toggle`), go to **CAPTURE IDEA**.
- If the **USER** typed `:cody idea` with no description, go to **VIEW IDEAS**.

### CAPTURE IDEA
- Check if `{{cfProject}}/ideas.md` exists.
  - If it does NOT exist, copy from `{{cfTemplates}}/ideas.md` to `{{cfProject}}/ideas.md`.
- Read `{{cfProject}}/ideas.md` to determine the next `#` (auto-increment from the last row).
- Add a new row to the table:
  - **#** -- next number in sequence
  - **Date** -- today's date (use `YYYY-MM-DD` format)
  - **Idea** -- the description the **USER** provided
  - **Status** -- `Open`
- Tell the **USER**: "Idea #[n] captured."
- Do NOT ask follow-up questions. Do NOT disrupt the current workflow. Stop here.

### VIEW IDEAS
- Check if `{{cfProject}}/ideas.md` exists.
  - If it does NOT exist, tell the **USER** there are no ideas captured yet. Tell them they can use `:cody idea [description]` to add one. Stop here.
- Read and show the **USER** the ideas table from `{{cfProject}}/ideas.md`.
- Stop here.
