# Project Settings Check

Check if `{{cfProject}}/project.json` exists.

- If it does NOT exist AND `{{cfProject}}` folder exists, tell the **USER**: "This version of Cody Product Builder uses a project settings file. Let me set that up."
  - Read the PRD or plan docs to determine the project name and description.
  - Scan version and patch folders in {{cfWorkPhase}} to find the latest completed version (default to `"0.0.0"` if none found).
  - Set phase to `"build"` if {{cfWorkPhase}} has version or patch folders, otherwise `"plan"`.
  - Present all values to the **USER** for confirmation.
  - **STOP** and wait for the **USER**.
  - Copy `{{cfTemplates}}/project.json` to `{{cfProject}}/project.json` and fill in the confirmed values. Use `YYYY-MM-DD` format for dates.
