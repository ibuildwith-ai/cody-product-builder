---
internal: true
description: Creates the feature backlog from the plan. Delegated from build.md.
---

### CREATE FEATURE BACKLOG
Check that {{cfWorkPhase}}/feature-backlog.md does not exist.

If it does not exist:

- Copy from {{cfTemplates}}/build/feature-backlog.md into {{cfWorkPhase}}
- Review the `plan.md` document you created in the discovery phase, then generate and update the `feature-backlog.md` document.
- When adding items to the **Backlog** section (features not assigned to a version), use Source = `Agent`. When creating version sections, use the version section format (ID, Feature, Description, Priority, Status) -- version sections do not have a Source column.

If it does exist:

- Tell the **USER** that the Feature Backlog already exists.
