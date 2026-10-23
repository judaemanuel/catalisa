---
rito: ""
data: <% tp.date.now("YYYY-MM-DD") %>
presentes: []
---

<!-- Campo `rito:` (wikilink para a hub do rito, ex.: "[[people]]") é distinto de `rito_origem:` usado pelas entidades (dor, insight, iniciativa, output) — ocorrência de reunião vs. item de conteúdo. Nome do arquivo: YYYY-MM-DD-<rito>.md em Ritos/Encontros/ -->

# <% tp.file.title %>

## Pauta

- Item 1

## Decisões

Resumo de cada decisão com link para a Iniciativa afetada; o registro completo (formato ADR) vai na seção Decisões da Iniciativa.

- [[iniciativa]] — decisão

## Capturas

Dores e observações novas surgidas no encontro (crie a Dor com `encontro:` apontando para esta nota).

- [[dor]]

## Pendências

- [ ] Ação — responsável
