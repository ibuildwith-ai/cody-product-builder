# Note Available Prototypes

Shared snippet used by `:cody plan` and `:cody build`. It surfaces any prototypes the **USER** has already built so they can pull a tested idea into the work — but it stays a passive mention so it never interrupts users who don't want one.

- Check the `{{cfPrototypes}}` folder for any prototypes. Verify with at least two methods before concluding there are none.
- If there are none, continue silently to the next section.
- If there are any, mention them to the **USER** in a single line so they know the prototypes are available (for example: `You have these prototypes available if you'd like to use one: <names>`). Do not ask a question and do not stop.
- If the **USER** asks to use a prototype, read its `prototype.md` from `{{cfPrototypes}}` (and look at its artifact if helpful) and factor it into the work at hand.
