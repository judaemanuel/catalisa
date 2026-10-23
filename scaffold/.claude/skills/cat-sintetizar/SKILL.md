---
name: cat-sintetizar
description: Use when the operator runs the weekly review of the Catalisa vault, wants to group confirmed dores, find root causes, turn pains into insight hypotheses, or apply an analysis technique from the kit.
---

# Síntese semanal (Dor → Insight)

Default stance: **facilitador** (see `.catalisa/kit/posturas.md`). You structure, ask and record; the operator generates the hypothesis and decides. The insight must be the operator's — they will defend it in the ritos. Switch to `parceiro` only if the operator asks.

## Steps

1. **Triage.** Run `python3 .claude/skills/cat-common/scripts/cat.py estado`. Show the counts and the gaps. For each `capturada` dor that already has `evidencia`, ask whether it becomes `confirmada` or `descartada`. For dores without evidence, ask for it or leave them as they are.
2. **Cluster.** Read the `confirmada` dores. Apply Affinity Clustering (`.catalisa/kit/convergencia.md`): propose groups by shared theme, squad or rito, explicitly labelled as a *suggestion*. The operator confirms, splits or merges. Grouping is structure, not a cause: never name a cause at this step.
3. **Pick a technique** for each group the operator wants to work on: offer 2–3 options from `.catalisa/kit/tecnicas.csv` where `transicao = dor-insight`, one line each on why it fits. The operator picks.
4. **Run the technique** in short rounds, asking one question at a time. Record the operator's answers verbatim. Do not answer your own questions.
5. **Write the insight** only when the operator states a hypothesis of cause. Create `Insights/<titulo-em-kebab-case>.md` from `.catalisa/templates/insight.md`:
   - `status: hipotese`, `dores` with the wikilinks of the group, `tecnica` with the technique id.
   - "Hipótese de causa" in the operator's words. "Evidências" points to the dores. Ask explicitly for "Contraevidências"; if there are none, write `nenhuma levantada ainda`.
6. With confirmation, set the dores of the group to `agrupada`. Run `cat.py validar`.
7. **Close.** List the insights created, the dores left `confirmada`, and the insights older than 30 days still in `hipotese` (from step 1): ask whether to look for evidence, refute them or keep them.

## Rules

- Timebox: about 30 minutes. If the session runs long, stop after the current group and list what is left.
- `evidenciado` and `validado` need new evidence linked in the note, never only the operator's conviction. `refutado` is a valid outcome — record it, never delete the note.
- Never create iniciativas here. When an insight is `validado`, suggest the next step: draft an iniciativa (A3 sections) with the operator.
