---
name: cat-capturar
description: Use when the operator wants to register observations, problems or pains (from the day, a conversation, a rito or an assessment) as Dor notes in the Catalisa vault, or pastes free text to be turned into dores.
---

# Capturar dores

Turns free text into Dor notes (atomic-research nuggets: one observation, one evidence). Capture is cheap; synthesis happens later in `/cat-sintetizar`.

## Steps

1. Read the input (pasted text, a `Diario/YYYY-MM-DD.md` note or an encounter note). Split it into **observations**: one fact each, no interpretation. Interpretation or a guessed cause is not a dor — set it aside and mention it as possible input for the weekly synthesis.
2. Check duplicates: `grep -ril` key terms in `Dores/`. If an existing dor covers the same fact, propose adding the new evidence to it instead of creating another note.
3. For each new observation, create `Dores/<titulo-em-kebab-case>.md` from `.catalisa/templates/dor.md`:
   - Render the Templater placeholders (date of today, title).
   - Fill `rito_origem` (wikilink to the hub in `Ritos/`) and `encontro` when the source is a rito; `squad` and `stakeholder` when stated.
   - `evidencia`: a literal quote, number or link to the source note. **Ask the operator when there is none** — never write a paraphrase as if it were a quote. A dor without evidence stays `capturada`.
   - `status: capturada` always. Moving to `confirmada` is the operator's call.
4. Run `python3 .claude/skills/cat-common/scripts/cat.py validar` and fix what it reports.
5. Report a table: file | observation | evidence (sim/não) | rito. List the set-aside interpretations separately.

## Rules

- One fact per note. Several symptoms of the same fact go in the same note.
- Never create insights, initiatives or outputs here.
- Keep the operator's wording in "Observação"; correct only spelling.
