# Version Design Document : v1.8.0 - Agent Optimization
Technical implementation and design guide for the upcoming version.

## 1. Features Summary

This version optimizes the Cody Product Builder agent for progressive disclosure, reducing the token footprint on activation by restructuring how content is loaded.

| ID | Feature | Description |
|----|---------|-------------|
| 28 | Slim Down agent.md | Remove phase descriptions, document tables, and version naming convention from agent.md. Move to references. |
| 38 | Remove Read-All-Commands | Remove the instruction that tells the agent to read all command files on activation. |
| 39 | Move About to Help | Move full "About" description to help.md (synced with README). Keep one-liner in agent.md. |
| 40 | Create References Folder | Create `.cody/references/` with phases.md, knowledge-criteria.md, project-settings-check.md. Add {{cfReferences}} placeholder. |
| 41 | Extract Knowledge Criteria | Extract duplicated Knowledge Criteria from plan.md and refresh-brownfield.md into references/knowledge-criteria.md. |
| 42 | Extract Project Settings Check | Extract duplicated project.json setup flow from build.md, refresh.md, refresh-update.md into references/project-settings-check.md. |

## 2. Technical Architecture Overview

### Current State
- `agent.md` loads ~101 lines on every activation, including reference material only needed by specific commands
- Line 86 instructs the agent to "read all the files in the {{cfCommands}} folder" -- loading 11 command files upfront
- Knowledge Criteria block is duplicated in plan.md and refresh-brownfield.md
- Project settings check block is duplicated in build.md, refresh.md, and refresh-update.md

### Target State
```
.cody/
├── agent.md                    # Slim: core instructions, placeholders, command routing
├── commands/                   # Executable workflows (no change to structure)
│   ├── help.md
│   ├── plan.md                 # References knowledge-criteria.md
│   ├── build.md                # References project-settings-check.md
│   ├── build-backlog.md
│   ├── build-version-existing.md
│   ├── build-version-new.md
│   ├── idea.md
│   ├── patch.md
│   ├── refresh.md              # References project-settings-check.md
│   ├── refresh-brownfield.md   # References knowledge-criteria.md
│   └── refresh-update.md       # References project-settings-check.md
├── references/                 # NEW: shared content, loaded on demand
│   ├── phases.md               # Phase descriptions & document tables
│   ├── knowledge-criteria.md   # Q&A criteria + guidance
│   └── project-settings-check.md  # project.json setup flow
├── settings.json
└── templates/
```

### Delegation Pattern
Commands reference shared content using the existing pattern:
```
**[AGENT TODO: Read {{cfReferences}}/knowledge-criteria.md]**
```
This is a read-only reference (no "execute"), unlike command delegation which uses "Read and execute."

## 3. Implementation Notes

- **agent.md changes are the riskiest** -- every command depends on it. The placeholder table, file system checks, and command routing must remain intact.
- **References are read-only** -- they provide context/criteria, not executable steps. Commands still own their workflow logic.
- **help.md About section** -- sync the description with README.md (README is source of truth). If README changes later, help.md should be updated to match.
- **No functional changes** -- every command should behave identically after this refactor. This is purely a token optimization.

## 4. Other Technical Considerations

- The `{{cfReferences}}` placeholder needs to be added to the placeholder table in agent.md.
- Commands that currently reference phase descriptions inline (if any) will need to reference `{{cfReferences}}/phases.md` instead.
- The version naming convention currently in agent.md is referenced by build-version-new.md and patch.md. It could stay in agent.md (it's only 8 lines) or move to references. Moving it keeps agent.md minimal; keeping it avoids an extra file read for common operations. Recommend moving to phases.md since it's part of the build phase reference material.

## 5. Open Questions

None -- approach confirmed with user.
