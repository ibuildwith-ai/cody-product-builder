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

**[AGENT TODO: Read {{cfReferences}}/knowledge-criteria.md and follow the Knowledge Criteria, Q&A Guidance, and Example Questions defined there.]**

# PROVIDE YOUR UNDERSTANDING TO THE **USER**
- Summarize your understanding of the idea back to the **USER**.
- Ask for approval explicitly. **STOP** for **USER APPROVAL**.
- If not approved, continue asking targeted questions and refine until approved.

# CREATE DISCOVERY DOCUMENT

### CREATE PROJECT SETTINGS
- Create `cody.json` in the project root using the `{{cfTemplates}}/cody.json` template.
- Fill in the `cody-product-builder` section:
  - **name** and **description** from what you learned during discovery
  - **createdAt** and **updatedAt** with today's date (use `YYYY-MM-DD` format)
  - **version** as `"0.0.0"`
  - **phase** as `"plan"`
- Ask the **USER**: "The default project path is `cody-projects/product-builder`. Do you want to choose a different one?"
- **STOP** and wait for the **USER**.
- Set **projectPath** to the chosen path (default or custom).
- Present all values to the **USER** and ask them to confirm or change anything.
- **STOP** and wait for the **USER**.
- Apply any changes the USER requests, then continue.

### CREATE PROJECT FOLDERS
- Create the `{{cfProject}}` folder if it doesn't exist.
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