# PDCA / Mapeamento de Projetos

Rito de mapeamento contínuo de projetos e iniciativas em portfólio, usando ciclo PDCA para validar estrutura e priorização.

## Histórico de encontros

```dataview
TABLE data, presentes
FROM "Ritos/Encontros"
WHERE contains(string(rito), this.file.name)
SORT data DESC
```

## Itens em aberto

```dataview
TABLE tipo, status, data, squad
FROM -".catalisa"
WHERE tipo AND contains(string(rito_origem), this.file.name) AND !contains(list("descartada", "refutado", "resolvida", "apresentado"), status)
SORT data ASC
```
