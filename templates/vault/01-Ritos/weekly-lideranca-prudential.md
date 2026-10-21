# Weekly Liderança Prudential

Encontro semanal da liderança técnica e produto Prudential para alinhamento de prioridades, bloqueadores e decisões estratégicas.

## Histórico de encontros

<!-- links para notas de ocorrência (criadas a partir de rito-encontro.md) aparecerão aqui -->

## Ações em aberto

```dataview
TABLE tipo, status, data, squad
FROM -"03-Templates"
WHERE contains(rito_origem, this.file.name) AND status != "concluido"
SORT data ASC
```
