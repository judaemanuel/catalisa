# Action Items DB

Esta é a view unificada de todas as ações em aberto no harness de melhoria contínua. Ela cruza ritos e statusos, permitindo uma visão horizontal do que está em progresso na organização.

## Ações em aberto

```dataview
TABLE status, rito_origem, data, squad
FROM -"03-Templates"
WHERE status != "concluido" AND status != "descartado"
SORT data ASC
```

## Insights sem proposta (> 30 dias)

Mecanismo de descoberta: insights que não foram convertidos em proposta e estão em aberto há mais de 30 dias. Estes são candidatos para revisão ou arquivamento.

```dataview
TABLE data, rito_origem
FROM -"03-Templates"
WHERE tipo = "insight" AND status = "aberto" AND date(today) - data > dur(30 days)
SORT data ASC
```
