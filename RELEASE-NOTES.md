# Release Notes

This document lists new features, bug fixes and other changes implemented in each version of Cody Product Builder.

The order of releases listed below are descending — the latest version is always shown at the top.

---

# v1.3.0 - Restructure and Improvements - 2026-02-23

## Overview
Major structural reorganization of the Cody Product Builder skill. Project output files are now stored in a shared `cody-projects/` directory, the internal config folder has been flattened, and Cursor support has been added.

## Key Features
- Added Cursor IDE support with `.cursor/commands/cody.md` activation command
- Project output now stored in `./cody-projects/product-builder/` (previously `.cody/project/`), aligning with the shared `cody-projects/` convention used across Cody skills

## Enhancements
- Flattened `.cody/config/` — all config files now live directly in `.cody/` for a simpler structure
- Removed unused `{{cfConfig}}` and `{{cfComponents}}` placeholders
- Removed `{{cfAssets}}`, `{{cfDocs}}`, `{{cfRules}}`, `{{cfPrompts}}` placeholders and the entire `library/` folder — unused and unnecessary
- Removed `:cody assets list` command and associated `assets-list.md` file
- Removed "Storing Images and Assets" section from `:cody help` output
- Fixed `{{cProject}}` typo in plan.md (was missing the "f" — now correctly `{{cfProject}}`)
- Added `cody-projects/` to `.gitignore` so generated project files are not tracked
- Updated README with new file structure diagram, Cursor in activation list, and link to release notes

## Bug Fixes
- Fixed hardcoded path `@.cody/build/` in version naming convention docs — now uses `{{cfWorkPhase}}` placeholder

## Other Notes
- Existing users with files in `.cody/project/` will need to manually move them to `./cody-projects/product-builder/`
