---
name: cat-preparar-rito
description: Use when the operator is preparing for an upcoming rito (recurring meeting) in the Catalisa vault and wants a briefing, an agenda, what changed since the last encounter, initiatives awaiting decision, or a draft of material for the audience. Argument: the rito hub name (file in Ritos/).
---

# Preparar rito

Stance: **gerador** for the draft (see `.catalisa/kit/posturas.md`), but every statement must be traceable to a note. The goal is to reduce the operator's preparation time without inventing anything.

## Steps

1. **Resolve the rito.** The argument must match a hub in `Ritos/<rito>.md`. If it is missing or ambiguous, list the hubs and ask.
2. **Collect.**
   - Last encounter: the most recent `Ritos/Encontros/*-<rito>.md`. Read its "Decisões" and "Pendências". If there is none, treat it as a first encounter.
   - Items of the rito: `python3 .claude/skills/cat-common/scripts/cat.py estado --rito <rito>`.
   - What changed since the last encounter: `git log --since=<encounter date> --name-status -- Dores Insights Iniciativas Outputs`, then read the changed notes.
3. **Write the briefing** as `Outputs/YYYY-MM-DD-<rito>-briefing.md` from `.catalisa/templates/output.md`: `status: rascunho`, `rito_destino` = wikilink to the hub, `audiencia` (ask if unknown), `fontes` = every note used. Free body in pt-BR, BLUF, suggested sections:
   - Pendências do último encontro — feitas / não feitas.
   - O que mudou — new validated insights, initiatives that changed state, measurements.
   - Para decidir — iniciativas `proposta` (with their A3 condição atual/alvo) and iniciativas `analisada` awaiting a desfecho.
   - Lacunas — dores without evidence, initiatives without success criterion.
   Each item ends with the wikilink of its source. Hypotheses are written as hypotheses (`hipótese:`), never as facts.
4. **Agenda.** If `Ritos/Encontros/YYYY-MM-DD-<rito>.md` for the meeting date does not exist, create it from `.catalisa/templates/encontro.md` (`rito` = wikilink to the hub) with only the "Pauta" filled, derived from "Para decidir" and the open pendências. Ask the operator for the meeting date if it is not today.
5. **Optional pressure test.** For each item to decide, offer one technique from `.catalisa/kit/tecnicas.csv` with `transicao = iniciativa-output` (e.g. pre-mortem, lente-de-stakeholders) to anticipate objections. Run it only if the operator wants.
6. Report: the briefing path, the number of items per section, and anything you could not find a source for.

## Rules

- Do not change the `status` of any entity here.
- The briefing is a draft for the operator, not a document to forward as is: say so when presenting it.
- No people's names beyond what the source notes already contain.
