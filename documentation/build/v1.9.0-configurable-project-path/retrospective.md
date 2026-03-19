# Version Retrospective -- v1.9.0 - Configurable Project Path
This document reflects on what worked, what didn't, and how future versions can be improved.

## Version Summary
Replaced the hardcoded `cody-projects/product-builder/` output path with a user-configurable project path. Introduced a root-level `cody.json` file structured for multi-skill support, replacing the old `project.json`. Added migration logic to seamlessly transition existing projects and move folders when users choose a new path.

## What Went Well
- **Iterative design conversation**: The feature scope was refined through back-and-forth discussion before any code was written. This caught edge cases early (folder migration, legacy detection on activation, empty parent cleanup).
- **Backward compatibility**: The default path (`cody-projects/product-builder`) means existing users who don't want to change anything get the same behavior with zero friction.
- **Multi-skill architecture**: Structuring `cody.json` by skill name (`cody-product-builder`, `cody-article-writer`) future-proofs the config file for upcoming skills without needing another migration.
- **Clean separation of concerns**: `cody.json` holds project metadata at the root; `.cody/settings.json` continues to hold skill version info. No conflation.

## What Could Have Gone Better
- **Activation fallback was initially a band-aid**: The first attempt at handling legacy `project.json` during activation just read the phase for prompt display, without triggering migration. This was quickly identified and replaced with the correct approach (delegating to `project-settings-check.md` for full migration), but it added a round of rework.
- **Scope of file updates was broad**: 10+ files needed changes across agent.md, activate.md, all command files, references, and templates. A checklist in the design doc from the start would have made tracking easier.

## Lessons Learned
- When adding fallback/legacy logic, always ask: "Should this trigger the real fix, or just paper over it?" Default to triggering the real fix.
- For versions that touch many files (structural changes), the design doc should include a complete file change manifest upfront. The tasklist alone isn't sufficient -- the design doc needs to enumerate every file and the nature of the change.
- Testing migration paths requires a real project with legacy data. Activation testing in a separate agent (GitHub Copilot) caught the missing migration trigger that local review missed.

## Action Items
- Backlog #33: Remove the `project.json` migration check by June 2026.
- Backlog #37: When implementing configurable release notes location, add `releaseNotesPath` to the `cody-product-builder` section in `cody.json`.
- For future structural versions, include a "Files to Change" manifest in the design doc from the start (this was added mid-build for v1.9.0 and proved valuable).
