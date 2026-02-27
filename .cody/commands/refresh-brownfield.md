---
command: ":cody refresh brownfield"
description: Analyzes an existing codebase (brownfield project), asks the USER targeted questions, and auto-generates the plan phase documents.
---

# BROWNFIELD PROJECT ANALYSIS

### ANNOUNCE TO THE **USER**

- **AGENT** show the **USER** the following:
```
+---------------------------+
BROWNFIELD PROJECT DETECTED
+---------------------------+
```
- Tell the **USER** that you (**AGENT**) detected an existing codebase with no Cody project files.
- Tell the **USER** you will now analyze the project and ask targeted questions to build a complete understanding.

---

## AUTONOMOUS CODEBASE ANALYSIS

You (**AGENT**) will thoroughly examine the existing codebase. Review the following (as applicable):

- Root-level files and folder structure
- Package/dependency files (package.json, requirements.txt, go.mod, Gemfile, etc.)
- Config files (tsconfig, vite.config, tailwind.config, .env.example, docker-compose, etc.)
- Entry points (index.html, main.ts, app.ts, index.js, etc.)
- Source code structure (src/, server/, components/, routes/, pages/, lib/, etc.)
- Database models/schemas if present
- API routes/endpoints if present
- README or any existing documentation

**IMPORTANT: Skip Cody Product Builder files — they are not part of the application:**
- `.cody/` — Skip entirely (Cody Product Builder configuration)
- `.claude/commands/cody.md` — Skip this file only (Cody activation). Other files in `.claude/` may describe the project and should be reviewed.
- `.cursor/commands/cody.md` — Skip this file only (Cody activation). Other files in `.cursor/` may describe the project and should be reviewed.
- `.github/prompts/cody.prompt.md` — Skip this file only (Cody activation). Other files in `.github/` may be useful and should be reviewed.

After your analysis, tell the **USER** what you found. Provide a brief summary of the tech stack, project structure, and what the app appears to do.

---

## USER Q&A

After presenting your initial findings, ask the **USER** targeted questions to fill gaps in your understanding. Focus on product-level knowledge the code cannot reveal.

Keep asking until all **Knowledge Criteria** are satisfied:

- **Target Users** — who the app is for
- **Problem Being Solved** — what pain point it addresses
- **Desired Outcome** — what the app should achieve (impact, value, or metric)
- **Success Criteria** — how we'll know the app is successful
- **Primary Use Case(s)** — main ways the app will be used
- **Must-Have Features** — critical to the current state / next milestone
- **Nice-to-Have Features** — can wait until later versions
- **Constraints** — budget, timeline, tech stack, integrations, or compliance
- **Existing Alternatives** — what users are doing today to solve this problem
- **Risks & Assumptions** — anything that could block or shape success

### Guidance for AI

- Some criteria may already be answered by the autonomous analysis (e.g., tech stack constraints, existing features). Confirm those with the **USER** instead of re-asking.
- Focus Q&A on what the code can't reveal (target users, goals, success criteria, etc.).
- Generate and adapt your own questions dynamically based on the **USER's** previous answers.
- Number each question in the format:
  `Question {n} of {total}: [your question]`
  Update `{total}` dynamically depending on how many more questions are required to satisfy the **Knowledge Criteria**.
- If earlier answers already cover a new question, confirm them instead of asking again.
- The goal is not to "get through a list" but to **reach full understanding of the project**.
- If the **USER** types `help me` after a question, provide 5 possible ways they can answer the question based on what you already know about the project.
- If the **USER** types `no more` (or anything equivalent):
  - If you already have enough information to satisfy the **Knowledge Criteria**, stop and summarize your understanding.
  - If you do **not** have enough information, explain politely that you may not be able to guide them effectively without a bit more detail, and suggest continuing with at least a few more questions.
  - If they still choose to stop, respect their decision, but clearly warn them that without further information, they may not get exactly what they have in mind.
- Stop only once all **Knowledge Criteria** are satisfied, or the **USER** insists on `no more`. If stopping early, include the warning:
  *"Based on the limited information provided, outcomes may not be optimal."*

---

## PRESENT UNDERSTANDING

- Summarize your full understanding of the project back to the **USER**:
  - What you learned from the codebase analysis (tech stack, architecture, existing features)
  - What you learned from the Q&A (target users, goals, success criteria, etc.)
- Ask for explicit approval. **STOP** for **USER APPROVAL**.
- If not approved, continue asking targeted questions and refine until approved.

---

## CREATE PROJECT FOLDERS

- Create folder `cody-projects/` if it doesn't exist.
- Create folder `cody-projects/product-builder/` if it doesn't exist.
- Create the following folder structure in the `{{cfProject}}` folder:
```
/build
/plan
```

---

## WRITE BROWNFIELD ANALYSIS

- Copy `{{cfTemplates}}/plan/brownfield-analysis.md` to `{{cfPlanPhase}}/brownfield-analysis.md`.
- Update all sections based on what you learned from the codebase analysis and user Q&A.
- Tell the **USER**:
```
I've created the Brownfield Analysis document summarizing my findings.
I stored it at {{cfProject}}/plan/brownfield-analysis.md.
You can review it and make changes to it.
If you did make changes, tell me to "review it".
If you didn't, just say "continue".
```
- **STOP** and wait for the **USER**.
- If the **USER** made changes, re-read the file and acknowledge the changes.
- If the **USER** says "continue", proceed.

---

## AUTO-GENERATE PRD

- **AGENT** show the **USER** the following:
```
+--------------+
GENERATING PRD
+--------------+
```
- Copy from `{{cfTemplates}}/plan/prd.md` into `{{cfPlanPhase}}`.
- Review the brownfield-analysis.md document and use it to generate and update the prd.md document.
- Tell the **USER** to review the PRD document.
- **STOP** and wait for the **USER**.
- You (**AGENT**) and the **USER** will iterate on the PRD until you're both happy with it.

---

## AUTO-GENERATE PLAN

- **AGENT** show the **USER** the following:
```
+----------------+
GENERATING PLAN
+----------------+
```
- Once the **USER** approves the PRD, copy from `{{cfTemplates}}/plan/plan.md` into `{{cfPlanPhase}}`.
- Review the prd.md document and the brownfield-analysis.md document and use them to generate and update the plan.md document.
- Tell the **USER** to review the Plan document.
- **STOP** and wait for the **USER**.
- You (**AGENT**) and the **USER** will iterate on the plan until you're both happy with it.

---

## PLAN PHASE COMPLETE

- **AGENT** show the **USER** the following:
```
+--------------------+
PLAN PHASE : COMPLETED
+--------------------+
```
- Tell the **USER** the plan phase has ended and if they want to start building, they can just type `:cody build` to create the feature backlog.
- Stop here.
