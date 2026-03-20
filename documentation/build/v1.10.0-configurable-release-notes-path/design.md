# Version Design Document : v1.10.0 - Configurable Release Notes Path
Technical implementation and design guide for the upcoming version.

## 1. Features Summary

This version adds a configurable release notes location to Cody Product Builder. Currently, `release-notes.md` is always stored in `{{cfWorkPhase}}` (the build folder). After this version, users can choose one of three locations:

1. **Default (build folder)** -- `{projectPath}/build/` (current behavior, no change needed)
2. **Project root** -- the repository root
3. **Custom path** -- any path the user specifies

The chosen path is stored as `releaseNotesPath` in `cody.json` under the `cody-product-builder` section.

### Feature Breakdown

| ID | Feature | Description |
|----|---------|-------------|
| 1 | Add `releaseNotesPath` to cody.json | New field in the `cody-product-builder` section. Defaults to `"{{projectPath}}"` (build folder). |
| 2 | Prompt user for release notes location | Fresh installs: asked during `project-settings-check.md` (first build/plan). Existing installs: asked during activation if `releaseNotesPath` is missing from `cody.json`. |
| 3 | Update all release notes references | `patch.md`, `build-version-existing.md`, and any other files that read/write `release-notes.md` must use the `{{cfReleaseNotes}}` placeholder. |
| 4 | Update cody.json template | Add `releaseNotesPath` field to the template. |
| 5 | Migration for existing projects | Existing projects without `releaseNotesPath` in `cody.json` get prompted on activation. If they pick a new location, move the existing `release-notes.md`. |

## 2. Technical Architecture Overview

### cody.json Schema Change

```json
{
  "cody-product-builder": {
    "name": "...",
    "description": "...",
    "version": "1.10.0",
    "phase": "build",
    "projectPath": "documentation",
    "releaseNotesPath": "{{projectPath}}",
    "createdAt": "2026-03-15",
    "updatedAt": "2026-03-20"
  }
}
```

**`releaseNotesPath` values:**
- `"{{projectPath}}"` -- default behavior, release notes stored in `{projectPath}/build/`
- `"{{projectRoot}}"` -- project/repo root
- `"docs/releases"` -- any custom path relative to project root

### Path Resolution

A new `{{cfReleaseNotes}}` placeholder is added to `agent.md`. It is resolved on activation (alongside `{{cfProject}}`) and cached for the session. Re-resolved on `:cody refresh`.

**Resolution logic:**
1. Read `cody.json > cody-product-builder > releaseNotesPath`
2. If `"{{projectPath}}"`: `{{cfReleaseNotes}}` = `{{cfWorkPhase}}` (build folder)
3. If `"{{projectRoot}}"`: `{{cfReleaseNotes}}` = project/repo root
4. Otherwise (custom path): `{{cfReleaseNotes}}` = that path

Commands reference `{{cfReleaseNotes}}/release-notes.md` instead of hardcoding `{{cfWorkPhase}}/release-notes.md`.

### Files That Change

| File | Change |
|------|--------|
| `.cody/templates/cody.json` | Add `releaseNotesPath: "{{projectPath}}"` field |
| `.cody/references/project-settings-check.md` | Add Step 4: ask for release notes location (fresh installs) |
| `.cody/activate.md` | Add migration check: if `cody.json` exists but missing `releaseNotesPath`, prompt and update (existing installs) |
| `.cody/agent.md` | Add `{{cfReleaseNotes}}` placeholder to the placeholder table |
| `.cody/commands/patch.md` | Use `{{cfReleaseNotes}}` instead of hardcoded `{{cfWorkPhase}}` for release notes |
| `.cody/commands/build-version-existing.md` | Same -- use `{{cfReleaseNotes}}` for release notes |
| `cody.json` (project root) | Add `releaseNotesPath` field to live config |

## 3. Implementation Notes

### Prompt Flow (project-settings-check.md)

After the existing project path setup, add a new step:

> **Step 4: Ask for Release Notes Location**
>
> Ask the **USER**: "Where would you like to store release notes? The default is your project root."
> 1. Project root (default)
> 2. Build folder -- `{projectPath}/build/`
> 3. Custom path
>
> - If project root (or user accepts default), set `releaseNotesPath` to `"{{projectRoot}}"`.
> - If build folder, set `releaseNotesPath` to `"{{projectPath}}"`.
> - If custom, ask for the path and set `releaseNotesPath` to that value.

### Migration for Existing Projects (activate.md)

During activation, if `cody.json` exists and has a `cody-product-builder` section but no `releaseNotesPath` field:
- Tell the user where `release-notes.md` currently lives (e.g., "Your release notes are currently stored in `documentation/build/`.").
- Ask: "Would you like to keep them there, or move them?" with the same 3 options (showing the current location as the default).
- If they choose a different location and `release-notes.md` exists at the current location, move it.
- Update `cody.json` with the chosen path.
- Cache `{{cfReleaseNotes}}` and continue with normal activation.

This does NOT trigger for fresh installs (no `cody.json` at all). Fresh installs get the prompt during `project-settings-check.md` on their first `:cody build` or `:cody plan`.

### Release Notes Path Usage in Commands

Commands that read or write `release-notes.md` use `{{cfReleaseNotes}}/release-notes.md`. The placeholder is already resolved -- no inline logic needed. If the target directory doesn't exist, create it before writing.

## 4. Other Technical Considerations

- `{{cfReleaseNotes}}` is resolved on activation and cached for the session, same as `{{cfProject}}`. Re-resolved on `:cody refresh`.
- The release notes template (`{{cfTemplates}}/build/release-notes.md`) does not move -- only the output file location changes.
- If the user picks project root (`"{{projectRoot}}"`), the file will be at `./release-notes.md` in their repo root. This is a common convention for changelogs.

## 5. Open Questions

None -- all design decisions resolved.
