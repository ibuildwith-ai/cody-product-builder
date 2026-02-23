---
command: ":cody plan"
description: Creates a Cody project and starts the PLAN phase.
---

### CHECK IF PLAN PHASE HAS ALREADY STARTED
- Check if {{cfPlanPhase}} folder has any documents.  
    - If it does, list the documents already started.
    - Tell the **USER** that the plan phase was already started.
    - End here.
- If it does not, continue to the next section.

- **AGENT** show the **USER** the following: 
```
+-----------------+
PLAN PHASE : START
+-----------------+
```

# TALK ABOUT IDEA
- Start by asking the **USER**:  
  `What do you want to create?` **STOP**
- After the **USER** responds, display this message:  

- **AGENT** show the **USER** the following: 
```
Great. I’m going to ask you questions to fully understand the outcome you want.
If you are not sure how to answer, just type "help me" and I’ll provide you with some example answers based on your idea.
If you don’t want me to ask any more questions, just type "no more".
```

- If the **USER** types `help me` after a question, instead of giving you an answer, provide the **USER** with 5 possible ways they can answer the question.
- If the **USER** types `no more` (or anything equivalent):  
- If you already have enough information to satisfy the **Knowledge Criteria**, stop and summarize your understanding.  
- If you do **not** have enough information, explain politely that you may not be able to guide them effectively without a bit more detail, and suggest continuing with at least a few more questions.  
- If they still choose to stop, respect their decision, but clearly warn them that without further information, they may not get exactly what they have in mind. 

---

## Knowledge Criteria

Keep asking as many questions as needed until you can confidently describe the following in your own words:  

- **Target Users** — who the app is for.  
- **Problem Being Solved** — what pain point it addresses.  
- **Desired Outcome** — what the app should achieve for the user (impact, value, or metric).  
- **Success Criteria** — how we’ll know the app is successful.  
- **Primary Use Case(s)** — main ways the app will be used.  
- **Must-Have Features** — critical to version 1.0.  
- **Nice-to-Have Features** — can wait until later versions.  
- **Constraints** — budget, timeline, tech stack, integrations, or compliance.  
- **Existing Alternatives** — what users are doing today to solve this problem.  
- **Risks & Assumptions** — anything that could block or shape success.  

---

## Guidance for AI

- Generate and adapt your own questions dynamically based on the **USER’s** previous answers.  
- Number each question in the format:  
`Question {n} of {total}: [your question]`  
Update `{total}` dynamically depending on how many more questions are required to satisfy the **Knowledge Criteria**.  
- If earlier answers already cover a new question, confirm them instead of asking again.  
- The goal is not to “get through a list” but to **reach full understanding of the outcome**.  
- Stop only once all **Knowledge Criteria** are satisfied, or the **USER** insists on `no more`. If stopping early, include the warning:  
*“Based on the limited information provided, outcomes may not be optimal.”*  

---

## Example Questions (Optional Scaffolding)

These are not required, but you may use or adapt them if helpful, especially when the **USER** is stuck or answers are unclear:  

- What outcome should this app deliver for its users?  
- How will we know this app is successful (metrics, outcomes, or user impact)?  
- What would failure look like?  
- On which platforms should it run? (web, mobile, desktop, etc.)  
- What constraints should we keep in mind? (budget, time, tech stack, integrations, compliance)  
- What existing solutions are users using today?  
- What risks or assumptions should we note early?  

# PROVIDE YOUR UNDERSTANDING TO THE **USER**
- Summarize your understanding of the idea back to the **USER**.
- Ask for approval explicitly. **STOP** for **USER APPROVAL**.
- If not approved, continue asking targeted questions and refine until approved.

# CREATE DISCOVERY DOCUMENT
- Create folder `cody-projects/` if it doesn't exist.
- Create folder `cody-projects/product-builder/` if it doesn't exist.
- Create the following folder structure in the `{{cfProject}}` folder:
```
/build
/plan
```
- Copy `{{cfTemplates}}/plan/discovery.md` to `{{cfPlanPhase}}/discovery.md`.
- Update all sections based on what you learned.
- Make sure you update the "DISCOVERY SUMMARY" section in the discovery.md file with your understanding summary listed previously.
- Tell the **USER**:
```
I've created the Discovery Document summarizing our conversation.
I stored it at {{cfProject}}/plan/discovery.md.
You can review it and make changes to it.
If you did make changes, tell me to "review it".
If you didn't, just say “continue”.
```

### CREATE PRD DOCUMENT
- Copy from {{cfTemplates}}/plan/prd.md into {{cfPlanPhase}}
- You (**AGENT**) will review the discovery.md document you created in the last section and use it to generate and update the prd.md document you just copied.
- You (**AGENT**) and the **USER** will iterate on the PRD until you're both happy with it.

### CREATE PLAN DOCUMENT
- Once you and the **USER** are ready to move on, you (**AGENT**) will copy from {{cfTemplates}}/plan/plan.md into {{cfPlanPhase}}
- You will review the prd.md document and use it to generate and update the plan.md document you just copied.
- You (**AGENT**) and the **USER** will iterate on the plan until you're both happy with it.

### PLAN PHASE ENDS

- **AGENT** show the **USER** the following: 
```
+--------------------+
PLAN PHASE : COMPLETED
+--------------------+
```
- Tell the **USER** the plan phase has ended and if they want to start building, they can just type `:cody build` to create the feature backlog.
- Stop here.