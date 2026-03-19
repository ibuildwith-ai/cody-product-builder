# Version Design Document : v1.9.0 - Configurable Project Path
Technical implementation and design guide for the upcoming version.

## 1. Features Summary

This version replaces the hardcoded `cody-projects/product-builder/` output path with a user-configurable project path, and moves project metadata from `project.json` into a root-level `cody.json` file structured for multi-skill support.

| ID | Feature | Description |
|----|---------|-------------|
| NEW-1 | Root-level cody.json | Replace `project.json` with a root-level `cody.json` file. Multi-skill structure keyed by skill name (`cody-product-builder`, `cody-article-writer`, etc.). |
| NEW-2 | Configurable project path | During first-time setup, prompt the user to choose an output folder. Default: `cody-projects/product-builder`. `plan/` and `build/` are created directly inside the chosen path. |
| NEW-3 | Dynamic placeholder resolution | `{{cfProject}}` resolves from `cody.json > cody-product-builder > projectPath`. Read once on activation and on `:cody refresh`. Cached for the session. |
| NEW-4 | Migration from project.json | If `project.json` exists, migrate its data into `cody.json` and delete `project.json`. If the user picks a new path, move `plan/` and `build/` folders and clean up old directories. |

## 2. Technical Architecture Overview

### Current State
- Project metadata lives in `cody-projects/product-builder/project.json`
- `{{cfProject}}` is hardcoded to `./cody-projects/product-builder/` in agent.md
- `{{cfPlanPhase}}` and `{{cfWorkPhase}}` are hardcoded relative to `{{cfProject}}`
- Activation reads `project.json` from the hardcoded path to determine phase
- `project-settings-check.md` creates `project.json` at the hardcoded path

### Target State
```
project-root/
├── cody.json                              # NEW: root-level, multi-skill config
├── .cody/
│   ├── agent.md                           # CHANGED: dynamic placeholder resolution
│   ├── activate.md                        # CHANGED: reads cody.json instead of project.json
│   ├── references/
│   │   └── project-settings-check.md      # CHANGED: cody.json setup + migration flow
│   └── templates/
│       └── cody.json                      # NEW: replaces project.json template
├── <user-chosen-path>/                    # e.g., docs/, cody-projects/product-builder/, etc.
│   ├── plan/
│   │   ├── prd.md
│   │   ├── plan.md
│   │   └── ...
│   └── build/
│       ├── feature-backlog.md
│       ├── release-notes.md
│       └── v1.9.0-.../
```

### cody.json Structure
```json
{
  "cody-product-builder": {
    "name": "Project Name",
    "description": "Short project description",
    "version": "1.0.0",
    "phase": "plan",
    "projectPath": "cody-projects/product-builder",
    "createdAt": "2026-03-19",
    "updatedAt": "2026-03-19"
  }
}
```

### Placeholder Resolution (Changed)
| Placeholder | Current (Hardcoded) | New (Dynamic) |
|------------|---------------------|---------------|
| `{{cfProject}}` | `./cody-projects/product-builder/` | Resolved from `cody.json > cody-product-builder > projectPath` |
| `{{cfPlanPhase}}` | `./cody-projects/product-builder/plan` | `projectPath + /plan` |
| `{{cfWorkPhase}}` | `./cody-projects/product-builder/build` | `projectPath + /build` |

All other placeholders (`{{cfRoot}}`, `{{cfTemplates}}`, `{{cfCommands}}`, `{{cfReferences}}`) remain unchanged.

### Resolution Timing
- **On activation**: `activate.md` reads `cody.json`, resolves `{{cfProject}}`, `{{cfPlanPhase}}`, `{{cfWorkPhase}}`, and caches for the session.
- **On `:cody refresh`**: Re-reads `cody.json` and re-resolves placeholders.
- **All other commands**: Use the cached values. No re-reading of `cody.json`.

## 3. Implementation Notes

### Files to Change
| File | Change |
|------|--------|
| `.cody/agent.md` | Update placeholder table: `{{cfProject}}`, `{{cfPlanPhase}}`, `{{cfWorkPhase}}` become dynamic (resolved from `cody.json`). Remove hardcoded paths. |
| `.cody/activate.md` | Read `cody.json` instead of `project.json`. Resolve and cache dynamic placeholders. Update phase-check logic. |
| `.cody/references/project-settings-check.md` | Full rewrite: new migration flow (see below). |
| `.cody/commands/refresh.md` | Re-read `cody.json` and re-resolve placeholders on refresh. |
| `.cody/commands/plan.md` | Add project path prompt during first-time greenfield setup. |
| `.cody/commands/refresh-brownfield.md` | Add project path prompt during first-time brownfield setup. |
| `.cody/templates/cody.json` | NEW: template for `cody.json` (replaces `project.json` template). |
| `.cody/templates/project.json` | DELETE: replaced by `cody.json` template. |

### Migration Flow (project-settings-check.md)

This replaces the current `project-settings-check.md` logic entirely.

**Step 1: Check for `cody.json`**
- If `cody.json` exists and has `cody-product-builder` section with a valid `projectPath`, use it. Done.
- If `cody.json` does not exist, continue to Step 2.

**Step 2: Migrate or create**
- If `project.json` exists (at the old hardcoded path `cody-projects/product-builder/project.json`):
  - Read its data (name, description, version, phase, dates).
  - Create `cody.json` at the project root with the migrated data.
  - Delete `project.json`.
- If `project.json` does not exist:
  - Read the PRD or plan docs to determine the project name and description.
  - Scan version and patch folders in the build folder to find the latest completed version (default to `"0.0.0"` if none found).
  - Set phase to `"build"` if the build folder has version or patch folders, otherwise `"plan"`.
  - Present all values to the user for confirmation.
  - **STOP** and wait for the user.
  - Create a fresh `cody.json` with the confirmed values.

**Step 3: Ask for project path**
- Prompt: "The default project path is `cody-projects/product-builder`. Do you want to choose a different one?"
- Record the chosen path in `cody.json` under `projectPath`.

**Step 4: If the user chose a different path**
- If the new path already exists, use it as-is. If not, create it.
- Move `plan/` and `build/` folders from the old location to the new path.
- Confirm with the user before deleting old folders.
- Remove `product-builder/` folder.
- Remove `cody-projects/` folder if empty (may contain other skill data).

### Activation Flow (activate.md)

Updated activation sequence:
1. Read `.cody/agent.md`
2. Read `cody.json` from the project root
   - If it exists and has `cody-product-builder` section: resolve `{{cfProject}}`, `{{cfPlanPhase}}`, `{{cfWorkPhase}}` from `projectPath`. Cache these for the session.
   - If it does not exist: set placeholders to defaults (`cody-projects/product-builder`, etc.) so commands can still run and trigger the setup flow.
3. Read version from `.cody/settings.json`
4. Show banner
5. Show contextual prompt based on phase from `cody.json`

### agent.md Placeholder Table Update

The placeholder table changes from hardcoded values to dynamic resolution:

| Placeholder | Maps to | Description |
|------------|---------|-------------|
| `{{cfProject}}` | *Resolved from `cody.json`* | Project output folder (default: `cody-projects/product-builder/`) |
| `{{cfPlanPhase}}` | *`{{cfProject}}/plan`* | Plan phase folder |
| `{{cfWorkPhase}}` | *`{{cfProject}}/build`* | Build phase folder |

The agent reads and caches these on activation. All other placeholders remain static.

## 4. Other Technical Considerations

- **Backward compatibility for first session**: If `cody.json` doesn't exist yet, activation defaults to the old paths so commands can run and trigger the migration. This is temporary until `project-settings-check.md` creates `cody.json`.
- **Relative paths only**: `projectPath` in `cody.json` should be stored as a relative path from the project root (no leading `./`, no absolute paths).
- **`cody-projects/` may persist**: If the user has Cody Article Writer or other skills using that folder, only `product-builder/` gets removed. Check before deleting `cody-projects/`.
- **settings.json stays in `.cody/`**: The skill version lives in `.cody/settings.json` and is not affected by this change. `cody.json` tracks the *project* version, not the *skill* version.
- **Feature backlog item #37**: `releaseNotesPath` is intentionally not added in this version. When #37 is implemented, it will add a new field to the `cody-product-builder` section in `cody.json`.
- **Feature backlog item #33**: The `project.json` migration check added in this version should be removed in June 2026 along with the v1.5.2 auto-creation check.

## 5. Open Questions

None -- approach confirmed with user.
