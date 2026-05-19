#!/usr/bin/env python3
"""
resolve-config.py -- Cody Product Builder activation config resolver.

Reads cody.json from the project root and resolves the dynamic skill
placeholders ({{cfProject}}, {{cfPlanPhase}}, {{cfWorkPhase}},
{{cfReleaseNotes}}, {{cfPrototypes}}) to concrete paths. Emits a JSON
object on stdout.

This is the deterministic half of the skill's activation step. SKILL.md
keeps a markdown fallback for environments where this script cannot run,
and handles the one-time migration cases (legacy project.json, missing
releaseNotesPath) itself -- those involve user prompts a script cannot do.

Usage:
    python3 resolve-config.py [project_root]

project_root defaults to the current working directory.

Exit 0 always: a missing cody.json is a normal first-run state, not an error.
Zero third-party dependencies; Python standard library only.
"""

import json
import sys
from pathlib import Path

DEFAULT_PROJECT_PATH = "cody-projects/product-builder"


def resolve(project_root: Path) -> dict:
    cody_json = project_root / "cody.json"
    legacy = project_root / DEFAULT_PROJECT_PATH / "project.json"

    result = {
        "cody_json_exists": cody_json.is_file(),
        "has_section": False,
        "release_notes_path_present": False,
        "legacy_project_json_exists": legacy.is_file(),
        "resolved": {},
    }

    section = None
    if result["cody_json_exists"]:
        try:
            data = json.loads(cody_json.read_text(encoding="utf-8"))
            section = data.get("cody-product-builder")
        except (json.JSONDecodeError, OSError):
            section = None

    if isinstance(section, dict):
        result["has_section"] = True
        project_path = section.get("projectPath") or DEFAULT_PROJECT_PATH
        release_notes_path = section.get("releaseNotesPath")
        result["release_notes_path_present"] = release_notes_path is not None
    else:
        project_path = DEFAULT_PROJECT_PATH
        release_notes_path = None

    work_phase = f"{project_path}/build"

    if release_notes_path == "{{projectPath}}":
        release_notes = work_phase
    elif release_notes_path == "{{projectRoot}}":
        release_notes = "."
    elif release_notes_path:
        release_notes = release_notes_path
    else:
        # No releaseNotesPath yet -- SKILL.md's markdown step resolves this.
        release_notes = work_phase

    result["resolved"] = {
        "cfProject": project_path,
        "cfPlanPhase": f"{project_path}/plan",
        "cfWorkPhase": work_phase,
        "cfReleaseNotes": release_notes,
        "cfPrototypes": f"{project_path}/prototypes",
    }
    return result


def main(argv):
    project_root = Path(argv[1]).resolve() if len(argv) > 1 else Path.cwd()
    print(json.dumps(resolve(project_root), indent=2))
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
