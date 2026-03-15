# Patch -- v1.7.2 -- Consolidate Ideas Into Backlog
This document captures a lightweight fix or small enhancement that does not require a full version build cycle.

## Patch Version
v1.7.2 -- Consolidate Ideas Into Backlog

## Date
2026-03-15

## Type
Small Enhancement

## Original Prompt
_What the **USER** originally said or requested._

Idea #5 from the ideas tracker: "Should the idea tracker just store the ideas in the backlog?" The user questioned whether ideas.md and the Backlog section of feature-backlog.md were duplicates, and decided to consolidate them into a single location.

## Problem
_The **AGENT's** understanding of the issue or change needed._

The project had two overlapping concepts for tracking unscheduled work: `ideas.md` (user-captured ideas with ID, date, description, status) and the Backlog section of `feature-backlog.md` (agent-generated features with ID, feature, description, priority, status). After discussion, it became clear that:
- The Backlog section and ideas serve different sources (agent vs. user) but the same purpose: "stuff to build later"
- Having two files creates confusion about where to look
- Priority and Status columns in the Backlog section are unnecessary -- priority is decided when you pick something to work on
- A Source column (User/Agent) is the only distinction needed

## Plan
_How the **AGENT** intends to fix or implement the change._

1. Update `:cody idea` command to write to the Backlog section of feature-backlog.md instead of ideas.md. AI derives Feature name from the user's description. Source = User.
2. Update `patch.md` and `build-version-new.md` commands to check Backlog section instead of ideas.md. Don't remove item from Backlog until the version or patch entry is actually written.
3. Update `build-backlog.md` command so agent suggestions use Source = Agent with simplified columns.
4. Update `agent.md` to remove ideas.md references from data model.
5. Delete `.cody/templates/ideas.md` template.
6. Update `.cody/templates/build/feature-backlog.md` template with new Backlog section columns.
7. Update project `feature-backlog.md` with new Backlog columns and migrate 7 open ideas from ideas.md (including the new idea #8).
8. Delete project `ideas.md`.
9. Update `plan.md` data model table.
10. Update `README.md` ideas references.

## Solution
_What was actually done to resolve the issue._

Consolidated ideas.md into the Backlog section of feature-backlog.md. All changes executed as planned:

- **`:cody idea` command** now writes directly to the Backlog section of feature-backlog.md. The AI derives a short Feature name from the user's description automatically. Source column set to `User`.
- **`:cody idea` (no args)** now shows the Backlog section instead of ideas.md.
- **`patch.md` and `build-version-new.md`** now check the Backlog section for items instead of ideas.md. Items are only removed from the Backlog when the version or patch entry is actually written in the feature backlog (not when picked).
- **`build-backlog.md`** updated so agent-generated suggestions during greenfield backlog creation use Source = `Agent`.
- **Backlog section format simplified** to 4 columns: #, Feature, Description, Source. Removed Priority and Status (Priority is decided when you pick something; Status is implicit -- if it's in Backlog, it's unworked).
- **Version/patch sections unchanged** -- they keep their existing ID, Feature, Description, Priority, Status columns.
- **7 open ideas migrated** from ideas.md to the Backlog section (IDs 27-33, continuing from the last existing ID).
- **ideas.md deleted** -- both the template and the project file.
- **brownfield-analysis.md data model** updated to remove ideas.md reference.

## Files Changed
_List of files that were created, modified, or deleted._

| File | Action |
|------|--------|
| `.cody/commands/idea.md` | Modified |
| `.cody/commands/patch.md` | Modified |
| `.cody/commands/build-version-new.md` | Modified |
| `.cody/commands/build-backlog.md` | Modified |
| `.cody/agent.md` | Modified |
| `.cody/templates/ideas.md` | Deleted |
| `.cody/templates/build/feature-backlog.md` | Modified |
| `cody-projects/product-builder/build/feature-backlog.md` | Modified |
| `cody-projects/product-builder/ideas.md` | Deleted |
| `cody-projects/product-builder/plan/plan.md` | Modified |
| `cody-projects/product-builder/plan/brownfield-analysis.md` | Modified |
| `README.md` | Modified |

## Testing Notes
_How to verify the fix or change._

1. Run `:cody idea test idea for verification` -- should add a row to the Backlog section of feature-backlog.md with an auto-derived Feature name and Source = User.
2. Run `:cody idea` (no args) -- should display the Backlog section items.
3. Run `:cody build` and choose "Create a new version" -- should show Backlog items instead of ideas.
4. Run `:cody build` and choose "Work on a patch" -- should show Backlog items instead of ideas.
5. Verify ideas.md no longer exists in both `.cody/templates/` and `cody-projects/product-builder/`.
6. Verify the Backlog section of feature-backlog.md has 7 migrated items (IDs 27-33) with Source = User.
