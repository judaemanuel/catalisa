# Agentics SDLC

Rito dedicado à evolução do SDLC (Software Development Lifecycle) com foco em agentics, automação e inteligência artificial aplicada ao desenvolvimento.

## Histórico de encontros

<!-- links para notas de ocorrência (criadas a partir de rito-encontro.md) aparecerão aqui -->

## Ações em aberto

```dataview
TABLE tipo, status, data, squad
FROM -"03-Templates"
WHERE contains(rito_origem, this.file.name) AND status != "concluido"
SORT data ASC
```
