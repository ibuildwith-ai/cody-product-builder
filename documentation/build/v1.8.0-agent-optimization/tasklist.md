# Version Tasklist -- v1.8.0 - Agent Optimization
This document outlines all the tasks to work on to deliver this particular version, grouped by phases.

| Status |      |
|--------|------|
| 🔴 | Not Started |
| 🟡 | In Progress |
| 🟢 | Completed |


## Phase 1: Create References Infrastructure

| ID  | Task             | Description                             | Dependencies | Status | Assigned To |
|-----|------------------|-----------------------------------------|-------------|----------|--------|
| 1 | Create references folder | Create `.cody/references/` directory | None | 🟢 Completed | AGENT |
| 2 | Add cfReferences placeholder | Add `{{cfReferences}}` -> `.cody/references` to the placeholder table in agent.md | 1 | 🟢 Completed | AGENT |

## Phase 2: Extract Shared Content

| ID  | Task             | Description                             | Dependencies | Status | Assigned To |
|-----|------------------|-----------------------------------------|-------------|----------|--------|
| 3 | Create phases.md | Extract phase descriptions, document tables, and version naming convention from agent.md into `references/phases.md` | 1 | 🟢 Completed | AGENT |
| 4 | Create knowledge-criteria.md | Extract the Knowledge Criteria block, Q&A guidance, and "help me"/"no more" handling from plan.md into `references/knowledge-criteria.md` | 1 | 🟢 Completed | AGENT |
| 5 | Create project-settings-check.md | Extract the project.json check-and-create flow from build.md into `references/project-settings-check.md` | 1 | 🟢 Completed | AGENT |

## Phase 3: Update agent.md

| ID  | Task             | Description                             | Dependencies | Status | Assigned To |
|-----|------------------|-----------------------------------------|-------------|----------|--------|
| 6 | Remove phase content from agent.md | Remove "About Phases", document tables, and version naming convention. Replace with a reference to `{{cfReferences}}/phases.md` for commands that need it. | 3 | 🟢 Completed | AGENT |
| 7 | Slim About section | Replace full "About Cody Product Builder" with a one-liner. | None | 🟢 Completed | AGENT |
| 8 | Remove read-all-commands instruction | Remove the line that tells the agent to read all files in {{cfCommands}} on activation. | None | 🟢 Completed | AGENT |

## Phase 4: Update Commands

| ID  | Task             | Description                             | Dependencies | Status | Assigned To |
|-----|------------------|-----------------------------------------|-------------|----------|--------|
| 9 | Update help.md | Add full "About Cody Product Builder" description synced from README.md (source of truth). | 7 | 🟢 Completed | AGENT |
| 10 | Update plan.md | Replace inline Knowledge Criteria with reference to `{{cfReferences}}/knowledge-criteria.md`. | 4 | 🟢 Completed | AGENT |
| 11 | Update refresh-brownfield.md | Replace inline Knowledge Criteria with reference to `{{cfReferences}}/knowledge-criteria.md`. | 4 | 🟢 Completed | AGENT |
| 12 | Update build.md | Replace inline project settings check with reference to `{{cfReferences}}/project-settings-check.md`. | 5 | 🟢 Completed | AGENT |
| 13 | Update refresh.md | Replace inline project settings check with reference to `{{cfReferences}}/project-settings-check.md`. | 5 | 🟢 Completed | AGENT |
| 14 | Update refresh-update.md | Reviewed -- no change needed. Its project settings check is a different flow (checking if name/description changed after doc updates, not the create-if-missing flow). | 5 | 🟢 Completed | AGENT |

## Phase 5: Verify and Document

| ID  | Task             | Description                             | Dependencies | Status | Assigned To |
|-----|------------------|-----------------------------------------|-------------|----------|--------|
| 15 | Verify all commands still work | Walk through each command path to confirm no broken references. | 6-14 | 🟢 Completed | AGENT |
| 16 | Update README.md | Update file structure diagram to include `references/` folder. | 1 | 🟢 Completed | AGENT |
| 17 | User testing | User verifies activation and key commands work correctly. | 15, 16 | 🔴 Not Started | USER |
