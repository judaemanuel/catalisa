# Catalisa (instância)

Personal continuous-improvement harness: tracks each improvement from a pain observed in a recurring forum ("rito") to a measured result. Notes mature **in place**: the state is the `status` frontmatter field, the folder is only the entity type. Model, states and cadence: `README.md`.

## Rules

- **Confidential.** This vault holds client data. Never push it to a public remote, never paste its content into external services, never name people outside `stakeholder`/`presentes` fields.
- **The operator owns every state change.** Propose `status` changes and wait for confirmation; never promote a note on your own.
- **Never invent evidence.** Every claim in an insight or output links to a note. If something is unknown, write `não registrado`, never a plausible guess.
- **Decisions are append-only** (ADR format, section "Decisões" of the iniciativa). Never edit or remove a past entry.
- Create notes from `.catalisa/templates/` and render the Templater placeholders yourself: `<% tp.date.now("YYYY-MM-DD") %>` becomes today's date, `<% tp.file.title %>` becomes the title.
- File names: entities `<Pasta>/<titulo-em-kebab-case>.md`; encounters `Ritos/Encontros/YYYY-MM-DD-<rito>.md`; diary `Diario/YYYY-MM-DD.md`; outputs `Outputs/YYYY-MM-DD-<slug>.md`.
- `status` values are ASCII, exactly as declared in each template's `<!-- estados: ... -->` comment.
- After writing any entity run `python3 .claude/skills/cat-common/scripts/cat.py validar` and fix what it reports. `cat.py estado [--rito <hub>]` is the Painel outside Obsidian.
- Answers to the operator in pt-BR, BLUF, no filler.

## Skills

| Skill | When |
|---|---|
| `/cat-capturar` | Daily or after a rito: free text → dores with evidence |
| `/cat-sintetizar` | Weekly review: confirmed dores → insight hypotheses (facilitator stance) |
| `/cat-preparar-rito <rito>` | Before a rito: briefing, agenda and output draft |
| `/cat-registrar-encontro <rito>` | After a rito: encounter note, ADR decisions, proposed state changes |

Techniques, convergence moves and stances: `.catalisa/kit/`.
