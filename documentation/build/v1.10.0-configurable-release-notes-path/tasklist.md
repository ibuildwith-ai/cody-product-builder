# Version Tasklist -- v1.10.0 - Configurable Release Notes Path
This document outlines all the tasks to deliver this particular version, grouped by phases.

| Status |      |
|--------|------|
| 🔴 | Not Started |
| 🟡 | In Progress |
| 🟢 | Completed |


## Phase 1: Schema and Template Updates

| ID  | Task             | Description                             | Dependencies | Status | Assigned To |
|-----|------------------|-----------------------------------------|-------------|----------|--------|
| 1 | Update cody.json template | Add `releaseNotesPath: "{{projectPath}}"` field to `.cody/templates/cody.json` | None | 🟢 Completed | AGENT |
| 2 | Add `{{cfReleaseNotes}}` placeholder | Add new placeholder to the placeholder table in `.cody/agent.md` with resolution logic | None | 🟢 Completed | AGENT |
| 3 | Update live cody.json | Add `releaseNotesPath` field to this project's `cody.json` | 1 | 🟢 Completed | AGENT |

## Phase 2: Setup and Migration Flows

| ID  | Task             | Description                             | Dependencies | Status | Assigned To |
|-----|------------------|-----------------------------------------|-------------|----------|--------|
| 4 | Update project-settings-check.md | Add Step 4: ask fresh installs for release notes location (default: `{{projectRoot}}`) | 1, 2 | 🟢 Completed | AGENT |
| 5 | Update activate.md | Add migration check: if `cody.json` exists but missing `releaseNotesPath`, show current location and prompt. Move file if needed. | 1, 2 | 🟢 Completed | AGENT |

## Phase 3: Command Updates

| ID  | Task             | Description                             | Dependencies | Status | Assigned To |
|-----|------------------|-----------------------------------------|-------------|----------|--------|
| 6 | Update patch.md | Replace hardcoded `{{cfWorkPhase}}` release notes references with `{{cfReleaseNotes}}` | 2 | 🟢 Completed | AGENT |
| 7 | Update build-version-existing.md | Replace hardcoded `{{cfWorkPhase}}` release notes references with `{{cfReleaseNotes}}` | 2 | 🟢 Completed | AGENT |

## Phase 4: Documentation and Closeout

| ID  | Task             | Description                             | Dependencies | Status | Assigned To |
|-----|------------------|-----------------------------------------|-------------|----------|--------|
| 8 | Update feature backlog | Add v1.10.0 version entry, move #37 from backlog to version | 1-7 | 🟢 Completed | AGENT |
| 9 | Update release notes | Add v1.10.0 entry to release-notes.md | 8 | 🟢 Completed | AGENT |
| 10 | Update README.md | Update version number and any relevant sections | 9 | 🟢 Completed | AGENT |
| 11 | Update cody.json version | Set version to `1.10.0` and updatedAt to today | 10 | 🟢 Completed | AGENT |
| 12 | Create retrospective | Copy retrospective template and fill in | 11 | 🟢 Completed | AGENT |
| 13 | User testing | User verifies activation migration flow and fresh install flow | 12 | 🔴 Not Started | USER |
