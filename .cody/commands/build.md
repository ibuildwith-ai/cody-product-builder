---
command: ":cody build"
description: Starts the BUILD phase and creates the feature backlog.
---

- **AGENT** show the **USER** the following first: 

```
+---------------+
Build Phase Start
+---------------+
```

### CREATE FEATURE BACKLOG 
Check that {{cfTemplates}}/build/feature-backlog.md does not exist.  

If it does not exist:

- Copy from {{cfTemplates}}/build/feature-backlog.md into {{cfWorkPhase}}
- Review the `plan.md` document you created in the discovery phase, then generate and update the `feature-backlog.md` document.
- When you are done, tell the **USER** to review it.  Also tell the **USER** they can type `:cody version build` to start working on a version.
- Stop here.

If it does exist:

- Tell the **USER** that the build phase has already started.
- Tell the **USER** that the Feature Backlog already exists.
- Tell the **USER** they can work on any version they want next.
- Stop here.