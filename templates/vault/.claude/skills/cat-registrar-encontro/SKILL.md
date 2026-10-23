---
name: cat-registrar-encontro
description: Use when a rito (recurring meeting) just happened and the operator wants to register it in the Catalisa vault — encounter notes, decisions taken, new pains raised, action items — or pastes raw meeting notes or a transcript summary. Argument: the rito hub name (file in Ritos/).
---

# Registrar encontro

Turns what happened in a rito into vault records: the encounter note, ADR entries in the affected iniciativas, new dores and proposed state changes.

## Steps

1. **Resolve the encounter.** Rito = `Ritos/<rito>.md`; date = today unless the operator says otherwise. Open `Ritos/Encontros/YYYY-MM-DD-<rito>.md`, or create it from `.catalisa/templates/encontro.md` (`rito` = wikilink to the hub). Ask for `presentes` if not given.
2. **Read the input** (raw notes, transcript summary, or answers to your questions). If the input is thin, ask in this order: what was decided? what new problems came up? who does what by when?
3. **Fill the encounter note:** "Decisões" (one line each, with a wikilink to the affected iniciativa), "Capturas" (new dores), "Pendências" (`- [ ] ação — responsável`).
4. **Decisions → iniciativas.** For each decision, find the iniciativa (`grep -ril` in `Iniciativas/`; ask if unsure). Append an entry to its "Decisões" section in ADR format: date heading, Encontro (wikilink), Contexto, Decisão, Alternativas rejeitadas, Consequências. Unknown fields get `não registrado` — never guess the rejected alternatives. If a decision has no iniciativa yet, ask whether to create one from `.catalisa/templates/iniciativa.md` (`status: proposta`).
5. **New dores.** Follow the `/cat-capturar` rules (one fact per note, evidence = link to this encounter, `status: capturada`).
6. **Propose state changes** as a table: note | current status | proposed status | reason. Typical cases: proposta → aprovada (requires `criterio_sucesso`, ask for it), em-execucao → analisada, analisada → resolvida (requires `desfecho`; if it is pivotar or encerrar, ask for the Aprendizado). Apply only what the operator confirms.
7. Run `python3 .claude/skills/cat-common/scripts/cat.py validar` and fix what it reports.
8. Report: encounter path, decisions recorded (by iniciativa), dores created, state changes applied, and pendências without an owner.

## Rules

- Decisions are append-only: never edit or remove a previous ADR entry; a reversal is a new entry that references the old one.
- Record what was decided, not what you think should have been decided.
- Never create insights here; leave interpretations as notes for `/cat-sintetizar`.
