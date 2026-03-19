# Version Tasklist -- v1.9.0 - Configurable Project Path
This document outlines all the tasks to work on to deliver this particular version, grouped by phases.

| Status |      |
|--------|------|
| 🔴 | Not Started |
| 🟡 | In Progress |
| 🟢 | Completed |


## Phase 1: Create cody.json Template and Migration Logic

| ID  | Task             | Description                             | Dependencies | Status | Assigned To |
|-----|------------------|-----------------------------------------|-------------|----------|--------|
| 1 | Create cody.json template | Create `.cody/templates/cody.json` with the multi-skill structure (`cody-product-builder` key, all fields including `projectPath`). | None | 🟢 Completed | AGENT |
| 2 | Delete project.json template | Remove `.cody/templates/project.json` (replaced by cody.json template). | 1 | 🟢 Completed | AGENT |
| 3 | Rewrite project-settings-check.md | Rewrite `.cody/references/project-settings-check.md` with the full migration flow: check cody.json, migrate from project.json or create fresh, ask for project path, move folders if needed, clean up old directories. | 1 | 🟢 Completed | AGENT |

## Phase 2: Update Activation and Agent Core

| ID  | Task             | Description                             | Dependencies | Status | Assigned To |
|-----|------------------|-----------------------------------------|-------------|----------|--------|
| 4 | Update agent.md placeholder table | Change `{{cfProject}}`, `{{cfPlanPhase}}`, `{{cfWorkPhase}}` from hardcoded paths to dynamic (resolved from cody.json). Add note that these are cached on activation. | None | 🟢 Completed | AGENT |
| 5 | Update activate.md | Read `cody.json` instead of `project.json`. Resolve and cache dynamic placeholders. Fall back to defaults if `cody.json` doesn't exist yet. Update phase-check logic. | 4 | 🟢 Completed | AGENT |

## Phase 3: Update Commands

| ID  | Task             | Description                             | Dependencies | Status | Assigned To |
|-----|------------------|-----------------------------------------|-------------|----------|--------|
| 6 | Update plan.md | Add project path prompt during first-time greenfield setup. Create cody.json with project path before creating output folders. | 3, 5 | 🟢 Completed | AGENT |
| 7 | Update refresh.md | Re-read `cody.json` and re-resolve dynamic placeholders on refresh. | 3, 5 | 🟢 Completed | AGENT |
| 8 | Update refresh-brownfield.md | Add project path prompt during first-time brownfield setup. Create cody.json with project path before creating output folders. | 3, 5 | 🟢 Completed | AGENT |
| 9 | Update build.md | Updated project.json reference to cody.json for phase/date updates. | 3 | 🟢 Completed | AGENT |
| 10 | Update refresh-update.md | Updated name/description sync logic to use cody.json instead of project.json. | 3 | 🟢 Completed | AGENT |
| 10a | Update build-version-existing.md | Updated project settings update to use cody.json instead of project.json. | 3 | 🟢 Completed | AGENT |
| 10b | Update patch.md | Updated project settings update to use cody.json instead of project.json. | 3 | 🟢 Completed | AGENT |
| 10c | Update phases.md | Updated project settings reference from project.json to cody.json. | 3 | 🟢 Completed | AGENT |

## Phase 4: Verify and Document

| ID  | Task             | Description                             | Dependencies | Status | Assigned To |
|-----|------------------|-----------------------------------------|-------------|----------|--------|
| 11 | Verify all command paths | Verified no stale references to `project.json` or hardcoded `cody-projects/product-builder` paths remain (only intentional ones in migration logic, defaults, and user prompts). | 6-10 | 🟢 Completed | AGENT |
| 12 | Update plan.md (plan phase doc) | Updated architecture, components, and data model sections to reflect cody.json, dynamic placeholders, and configurable paths. | 11 | 🟢 Completed | AGENT |
| 13 | Update README.md | Updated file structure diagram, version badge, and output path references. | 11 | 🟢 Completed | AGENT |
| 14 | User testing | User verifies: (a) fresh activation with no cody.json triggers setup, (b) migration from project.json works, (c) custom path creates correct folder structure, (d) default path still works, (e) refresh re-reads cody.json. | 11-13 | 🔴 Not Started | USER |
