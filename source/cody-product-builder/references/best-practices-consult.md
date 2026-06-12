# Consult Best Practices

Shared snippet that loads the project's best practices so the **AGENT** follows them. Used by `:cody build` (version and patch) and `:cody refresh`. Reading the project's own learned rules before and during work is what keeps each build consistent with the ones before it.

## Ensure the file exists

- Check whether `{{cfBestPractices}}/project-best-practices.md` exists. Verify with at least two methods before concluding it does not (per the File System Checks rule).
- If it does not exist:
  - Create the `{{cfBestPractices}}` folder if needed.
  - Copy the template from `{{cfAssets}}/best-practices/project-best-practices.md` to `{{cfBestPractices}}/project-best-practices.md`.
  - This is a brand-new, empty best-practices file (category headers only) -- that is expected for a project that has not recorded any learnings yet.

## Load and follow

- Read `{{cfBestPractices}}/project-best-practices.md`.
- Keep its rules in mind for the current work and follow them. If any rule conflicts with what the **USER** explicitly asks for, follow the **USER** and note the conflict so it can be reconciled when best practices are next captured.
