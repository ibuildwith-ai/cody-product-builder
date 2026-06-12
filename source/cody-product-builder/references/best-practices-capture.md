# Capture Best Practices

Shared snippet that records what was learned during a build into the project's best-practices file. Used at the end of a version build and at the end of a patch. Capturing learnings while they are fresh is what makes the file grow into an accurate, project-specific guide.

The calling command provides:

- **build type** -- `version` or `patch`.
- **source doc** -- the path to read learnings from: the version's `retrospective.md` for a version, or the patch's `patch.md` for a patch.

## Ensure the file exists

- Check whether `{{cfBestPractices}}/project-best-practices.md` exists. Verify with at least two methods before concluding it does not (per the File System Checks rule).
- If it does not exist:
  - Create the `{{cfBestPractices}}` folder if needed.
  - Copy the template from `{{cfAssets}}/best-practices/project-best-practices.md` to `{{cfBestPractices}}/project-best-practices.md`.

## Gather learnings

- Read the **source doc** the calling command named (`retrospective.md` for a version, `patch.md` for a patch).
- Also scan the working session for learnings the source doc did not capture -- the richest signal is often in the conversation, not the written artifact.
- A learning is anything worth following on future builds: an architectural decision, a convention, a tooling or testing practice, a process rule, or a trap to avoid.

## Update the file

Read `{{cfBestPractices}}/project-best-practices.md` and update it so it stays lean, non-redundant, and current. This file is the project's bible, not an append-only log.

- **Add** new learnings as entries under the right category -- each a single rule plus a one-line why.
- **Update / replace** an existing rule when a new learning refines or changes it.
- **Remove** any rule the new learnings contradict or make obsolete.
- **Manage categories**: add a category the project now needs; remove a starter category that stays empty or does not apply.
- Do not add version tags to entries.

## Tell the **USER**

- Tell the **USER** you updated `{{cfBestPractices}}/project-best-practices.md` and summarize what changed.
- Ask them to review, and let them tell you to add, change, or remove entries. Do not wait for approval before writing -- write first, then tell (the same pattern as the plan, PRD, and release notes).
