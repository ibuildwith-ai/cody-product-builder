# Create Project Workspace

Shared snippet used by `:cody plan` and `:cody refresh` (brownfield). It creates the `cody.json` settings file and the project folder structure. Both commands need an identical workspace; the only differences are three values the calling command supplies.

The calling command provides these three values before invoking this snippet:

- **name/description source** -- where the project name and description come from
- **version** -- the value to write to the `version` field
- **phase** -- the value to write to the `phase` field (`"plan"` or `"build"`)

## Create Project Settings

- Create `cody.json` in the project root using the `{{cfAssets}}/cody.json` template.
- Fill in the `cody-product-builder` section:
  - **name** and **description** -- from the source the calling command specified
  - **createdAt** and **updatedAt** -- with today's date (use `YYYY-MM-DD` format)
  - **version** -- the value the calling command specified
  - **phase** -- the value the calling command specified
- Ask the **USER**: "The default project path is `cody-projects/product-builder`. Do you want to choose a different one?"
- **STOP** and wait for the **USER**.
- Set **projectPath** to the chosen path (default or custom).
- Present all values to the **USER** and ask them to confirm or change anything.
- **STOP** and wait for the **USER**.
- Apply any changes the USER requests, then continue.

## Create Project Folders

- Create the `{{cfProject}}` folder if it doesn't exist.
- Create the following folder structure in the `{{cfProject}}` folder:

```
/build
/plan
```
