# PDCA / Mapeamento de Projetos

Rito de mapeamento contínuo de projetos e iniciativas em portfólio, usando ciclo PDCA para validar estrutura e priorização.

## Histórico de encontros

<!-- links para notas de ocorrência (criadas a partir de rito-encontro.md) aparecerão aqui -->

## Ações em aberto

```dataview
TABLE tipo, status, data, squad
FROM -"03-Templates"
WHERE contains(rito_origem, this.file.name) AND status != "concluido"
SORT data ASC
```
