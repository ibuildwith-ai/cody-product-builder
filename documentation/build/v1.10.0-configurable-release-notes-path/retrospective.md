# Version Retrospective -- v1.10.0 - Configurable Release Notes Path

This document reflects on what worked, what didn't, and how future versions can be improved.

## Version Summary
Added configurable release notes location with three options (build folder, project root, custom path), a new `{{cfReleaseNotes}}` placeholder, migration flow for existing projects, and fresh install prompting. Touched 7 files across templates, commands, references, and activation.

## What Went Well
- Design decisions were resolved iteratively through conversation before any code was written. The `{{projectPath}}`/`{{projectRoot}}` naming convention came from a back-and-forth that produced a cleaner result than the initial `null`/`"."` approach.
- Scope stayed tight. Only one backlog item (#37) with supporting infrastructure. No feature creep.
- The two-path strategy (activation migration for existing installs, project-settings-check for fresh installs) avoids code duplication while handling both scenarios cleanly.

## What Could Have Gone Better
- Initially started as a patch before recognizing it was a version-sized change. Could have caught this earlier by checking the number of files affected before committing to a workflow.
- The `releaseNotesPath` was deferred from v1.9.0, which meant some design context had to be re-established. Capturing the "why we deferred" in the backlog item would have saved time.

## Lessons Learned
- When a change touches schema, templates, activation, and multiple commands, it's a version, not a patch. A quick file-count check before choosing the workflow would help.
- Self-documenting config values (`{{projectPath}}` instead of `null`) are worth the small implementation overhead. They eliminate ambiguity when reading config files months later.
- Prompting existing users with their current location as the default reduces friction and avoids accidental moves.

## Action Items
- Test activation migration flow with a project that has `cody.json` but no `releaseNotesPath` field.
- Test fresh install flow to verify the project root default works correctly.
- Test that `patch.md` and `build-version-existing.md` correctly resolve `{{cfReleaseNotes}}` for all three path types.
