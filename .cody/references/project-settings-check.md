# Project Settings Check

Check if `cody.json` exists in the project root.

- If it exists and has a `cody-product-builder` section with a valid `projectPath` and `releaseNotesPath`, use it. Done -- no further action needed.

- If it does NOT exist, continue below.

---

## Step 1: Migrate or Create

### If `cody-projects/product-builder/project.json` exists (legacy project):
- Tell the **USER**: "I found a legacy project settings file. Let me migrate it to the new format."
- Read the data from `cody-projects/product-builder/project.json` (name, description, version, phase, createdAt, updatedAt).
- Create `cody.json` in the project root using the `{{cfTemplates}}/cody.json` template.
- Fill in the `cody-product-builder` section with the migrated values.
- Set `projectPath` to `cody-projects/product-builder` (the current location).
- Delete `cody-projects/product-builder/project.json`.

### If `cody-projects/product-builder/project.json` does NOT exist (new project or already deleted):
- Tell the **USER**: "This version of Cody Product Builder uses a project settings file. Let me set that up."
- Read the PRD or plan docs to determine the project name and description.
- Scan version and patch folders in the build folder to find the latest completed version (default to `"0.0.0"` if none found).
- Set phase to `"build"` if the build folder has version or patch folders, otherwise `"plan"`.
- Present all values to the **USER** for confirmation.
- **STOP** and wait for the **USER**.
- Create `cody.json` in the project root using the `{{cfTemplates}}/cody.json` template.
- Fill in the `cody-product-builder` section with the confirmed values.

---

## Step 2: Ask for Project Path

- Ask the **USER**: "The default project path is `cody-projects/product-builder`. Do you want to choose a different one?"
- **STOP** and wait for the **USER**.
- Record the chosen path (default or custom) in `cody.json` under `cody-product-builder > projectPath`.

---

## Step 3: Move Files (if custom path chosen)

If the **USER** chose a path different from `cody-projects/product-builder`:
- If the new path already exists, use it as-is. If it does not exist, create it.
- Move the `plan/` folder from `cody-projects/product-builder/plan` to the new path (if it exists).
- Move the `build/` folder from `cody-projects/product-builder/build` to the new path (if it exists).
- Confirm with the **USER** before deleting old folders.
- **STOP** and wait for the **USER**.
- If confirmed:
  - Remove the `cody-projects/product-builder/` folder.
  - Check if `cody-projects/` is empty. If empty, remove it too. If not empty (other skills may use it), leave it.

---

## Step 4: Ask for Release Notes Location

- Ask the **USER**: "Where would you like to store release notes? The default is your project root."
  1. Project root (default)
  2. Build folder -- `{projectPath}/build/`
  3. Custom path
- **STOP** and wait for the **USER**.
- If project root (or user accepts default), set `releaseNotesPath` to `"{{projectRoot}}"` in `cody.json`.
- If build folder, set `releaseNotesPath` to `"{{projectPath}}"` in `cody.json`.
- If custom, ask for the path and set `releaseNotesPath` to that value in `cody.json`.
