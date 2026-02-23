---
command: ":cody help"
description: Provides the USER with help about Cody.
---

- **AGENT** show the **USER** the following: 
```
+------------------------------------------+
Cody Product Builder
+------------------------------------------+

Created and maintained by iBuildWith.ai
(©) 2026 by Red Pill Blue Pill Studios, LLC
```

- Provide the **USER** with a short overview of Cody Product Builder.
- Provide the **USER** the current version of Cody Product Builder.  You can it from the "version" key in {{cfConfig}}/settings.json.

- **AGENT** show the **USER** the following: 
```
+---------------------+
Available Help Commands
+---------------------+
```

- Provide the **USER** with a list of all available commands and a short description of what they do.


- **AGENT** show the **USER** the following: 
```
+-----------------------+
Storing Images and Assets
+-----------------------+
````

- Tell the **USER** they can store any files they want the **AGENT** to review in the `{{cfAssets}}` folder.
- Tell the USER that if they store assets there, they use them in their prompt by telling the **AGENT** they are stored in the `{{cfAssets}}` and provide an example of how to add that to a prompt (but for the example, use the literal assets with braces).

- Stop here.