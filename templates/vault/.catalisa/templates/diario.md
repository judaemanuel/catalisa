---
data: <% tp.date.now("YYYY-MM-DD") %>
---

# <% tp.file.title %>

## Captura do dia

Registro rápido (~5 min). Observação com cara de dor vira nota em Dores/ na revisão semanal.

## Pendências de dias anteriores

```dataview
TASK
FROM "Diario"
WHERE !completed AND file.name != this.file.name
SORT file.name ASC
```
