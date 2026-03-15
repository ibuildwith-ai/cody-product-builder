---
command: ":cody idea"
description: Quick-capture an idea or view the backlog.
---

# IDEA

### DETERMINE ACTION
- If the **USER** typed `:cody idea` with a description (e.g., `:cody idea add dark mode toggle`), go to **CAPTURE IDEA**.
- If the **USER** typed `:cody idea` with no description, go to **VIEW BACKLOG**.

### CAPTURE IDEA
- Check if `{{cfWorkPhase}}/feature-backlog.md` exists.
  - If it does NOT exist, copy from `{{cfTemplates}}/build/feature-backlog.md` to `{{cfWorkPhase}}/feature-backlog.md`.
- Read the Backlog section of `{{cfWorkPhase}}/feature-backlog.md` to determine the next `#` (auto-increment from the highest ID across ALL sections in the file, not just the Backlog section).
- Derive a short **Feature** name from the description the **USER** provided. Keep it to 2-4 words, title case.
- Add a new row to the **Backlog** section table:
  - **#** -- next number in sequence
  - **Feature** -- the short name you derived
  - **Description** -- the description the **USER** provided
  - **Source** -- `User`
- Tell the **USER**: "Idea #[n] captured in the backlog."
- Do NOT ask follow-up questions. Do NOT disrupt the current workflow. Stop here.

### VIEW BACKLOG
- Check if `{{cfWorkPhase}}/feature-backlog.md` exists.
  - If it does NOT exist, tell the **USER** there are no backlog items yet. Tell them they can use `:cody idea [description]` to add one. Stop here.
- Read and show the **USER** the Backlog section table from `{{cfWorkPhase}}/feature-backlog.md`.
- Stop here.
