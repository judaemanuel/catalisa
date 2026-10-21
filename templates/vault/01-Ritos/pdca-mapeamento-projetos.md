# PDCA / Mapeamento de Projetos

Rito de mapeamento contínuo de projetos e iniciativas em portfólio, usando ciclo PDCA para validar estrutura e priorização.

## Histórico de encontros

- [[2026-10-21-pdca-mapeamento]]

## Ações em aberto

```dataview
TASK
FROM -"03-Templates"
WHERE contains(rito_origem, this.file.name) AND status != "concluido"
SORT data ASC
```
