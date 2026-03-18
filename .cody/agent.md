# AGENT INSTRUCTIONS:
- Read this entire document and commit it to memory.
- Make sure you check this document often if you need to understand how to process any Cody Product Builder commands.
- Anything that has **[AGENT TODO: to do item]** means you need to take action.
- When you see **AGENT ANNOUNCE**, anthing in betweeen the ```[message]``` (tick marks), you will display to the user exactly was stated.
- After every phase, make sure you re-read this document.
- {{cfPlaceholders}} used in commands are defined in this document, under the "Template Placeholder Values" section.  When you see a placeholder, you will replace it with its appropriate value.
- The roles are as follows:
    - **USER** Is the human guding you in the building process.
    - **AGENT** That's you!  The AI Development **AGENT**.

## About Cody Product Builder
Cody Product Builder is an AI agent skill that guides users from idea to finished product through structured planning and iterative building.

For detailed phase descriptions, document references, and version naming conventions, see `{{cfReferences}}/phases.md`.

## Template Placeholder Values
These placeholders are a pointer to actual values. They are created here and used throughout various commands.  When you encounter a placeholder value, you will replace it with it's value and consider that as the literal (e.g. {{cfRoot}}/agent.md would translate to .cody/agent.md)

| Placeholder | Maps to | Description |
|------------|---------|-------------|
| {{cfRoot}} | .cody/ | Cody root folder |
| {{cfTemplates}} | .cody/templates | Cody templates folder |
| {{cfCommands}} | .cody/commands | Cody commands to be executed. |
| {{cfReferences}} | .cody/references | Shared reference content loaded on demand by commands. |
| {{cfProject}} | ./cody-projects/product-builder/ | Project folder for generated files. |
| {{cfPlanPhase}} | ./cody-projects/product-builder/plan | Cody root folder for the planning phase. |
| {{cfWorkPhase}} | ./cody-projects/product-builder/build | Cody root folder for the build phase. |

## File System Checks
- Always use the placeholder paths (e.g., `{{cfPlanPhase}}`, `{{cfProject}}`) when checking for files or folders. Never construct paths manually or use relative paths like `./cody-projects/...`.
- Before concluding that a folder is empty or files don't exist, always verify with at least two different methods (e.g., a glob search AND a directory listing). Never make decisions based on a single failed search. This prevents false negatives caused by path resolution issues.

## Executing Commands

- If the **USER** types any of the commands listed below, read and execute the corresponding command file.
- Only read command files when they are invoked. Do not pre-load all commands.

> ### `:cody help`
**[AGENT TODO: Read and execute {{cfCommands}}/help.md]**

> ### `:cody plan`
**[AGENT TODO: Read and execute {{cfCommands}}/plan.md]**

> ### `:cody build`
**[AGENT TODO: Read and execute {{cfCommands}}/build.md]**

> ### `:cody idea`
**[AGENT TODO: Read and execute {{cfCommands}}/idea.md]**

> ### `:cody refresh`
**[AGENT TODO: Read and execute {{cfCommands}}/refresh.md]**
