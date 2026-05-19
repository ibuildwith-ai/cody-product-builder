---
command: ":cody prototype"
description: Build a throwaway prototype to test an idea, independent of the Plan and Build phases.
---

# PROTOTYPE

- **AGENT** show the **USER** the following:
```
+-----------------+
PROTOTYPE : START
+-----------------+
```

### ABOUT
- A prototype is a throwaway, interactive mockup built to test an idea. You build it beginning to end in one session.
- Prototyping is independent of the Plan and Build phases. You can run `:cody prototype` anytime: before planning, while planning, before or during a build, or after one. This command does NOT change the `phase` value in `cody.json`.
- A prototype lives in its own self-contained folder under `{{cfPrototypes}}`. When you plan or build later, you can ask Cody to use a prototype to help inform that work.

### NAME THE PROTOTYPE
- Ask the **USER** what they want to call this prototype.
- **STOP** and wait for the **USER**.
- Derive a `<slug>` from the name: lowercase letters, digits, and dashes only; dashes separate words; 30 characters maximum.

### CREATE THE PROTOTYPE FOLDER
- Create the `{{cfPrototypes}}` folder if it does not exist.
- Create the folder `{{cfPrototypes}}/<slug>/`.
- Tell the **USER**:
```
A heads-up on git: I don't manage git for prototypes. If this project uses git,
everything inside this prototype folder -- including node_modules for a Node
prototype -- will be committed unless you exclude it yourself.
```

### DISCOVER THE PROTOTYPE
- Ask the **USER** what idea they want to test and what they hope to learn from it. Ask as many follow-up questions as you need to understand it clearly.
- Ask the **USER** what specific things they want to be able to test in the prototype.

### SCAFFOLD THE PROTOTYPE DOCUMENT
- Copy `{{cfAssets}}/prototype/prototype.md` to `{{cfPrototypes}}/<slug>/prototype.md`.
- Fill in:
  - **Prototype name** -- the name the **USER** chose
  - **Created** and **Last Updated** -- today's date (YYYY-MM-DD)
  - **The Idea** -- the idea the **USER** wants to test and what they hope to learn
  - **What to Test** -- the specific things to evaluate
  - **Build Approach** -- the form the prototype will take and any tech choices

### BUILD THE PROTOTYPE
- Build the prototype with the **USER** inside `{{cfPrototypes}}/<slug>/`. Keep it lightweight -- it is throwaway.
- Iterate with the **USER**: build it, change it, try things.
- As you go, keep `prototype.md` updated:
  - Each time the **USER** reports something they learned, append a dated row to the **Findings Log**. Never overwrite earlier entries.
  - Each time the **USER** expresses a judgment about the prototype (what they like, dislike, want to keep, want to throw away, opinions on the design or architecture), record it in the **Likes & Dislikes** section.
  - Update the **Last Updated** date whenever you change the document.
- Continue until the **USER** indicates they are done.

### WRAP UP THE PROTOTYPE
- When the **USER** indicates they are done, review the prototype against its purpose: look at **The Idea** and **What to Test** in `prototype.md`.
- Confirm with the **USER** that they have tested what they set out to test and learned what they wanted to learn about the idea. If they have not, return to BUILD THE PROTOTYPE and keep going.
- Ask the **USER** directly for their likes and dislikes: what worked, what did not, what they would keep, what they would throw away, and any opinions on the design or architecture.
- Make sure the **Likes & Dislikes** and **Findings Log** sections of `prototype.md` are complete and reflect the whole session.
- Update the **Last Updated** date in `prototype.md` to today's date (YYYY-MM-DD).

### FINISH
- Ask the **USER** whether to keep this prototype or delete it. Remind them a prototype is a throwaway artifact: keep it if it is useful to revisit or reference when planning or building, delete it if it has served its purpose.
- **STOP** and wait for the **USER**.
- If the **USER** wants to keep it, leave `{{cfPrototypes}}/<slug>/` as-is. Tell them the prototype is saved and they can ask Cody to use it later when planning or building.
- If the **USER** wants to delete it, delete the entire `{{cfPrototypes}}/<slug>/` folder.
- Tell the **USER** the prototype session is complete.
