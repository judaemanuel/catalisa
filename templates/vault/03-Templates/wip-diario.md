---
data:
---

# WIP Diário

## Captura do dia



## Pendências de dias anteriores

```dataview
TASK
FROM "00-Diario"
WHERE !completed AND file.name != this.file.name
SORT file.name ASC
```
