# Painel

Visão única do harness, organizada por estado. Cada view aponta uma lacuna a tratar na revisão semanal.

## Dores sem evidência

Não podem sair de `capturada` sem evidência.

```dataview
TABLE data, rito_origem, squad
FROM -".catalisa"
WHERE tipo = "dor" AND status = "capturada" AND (!evidencia OR evidencia = "")
SORT data ASC
```

## Dores aguardando síntese

Confirmadas e ainda não agrupadas em um insight.

```dataview
TABLE data, rito_origem, squad
FROM -".catalisa"
WHERE tipo = "dor" AND status = "confirmada"
SORT data ASC
```

## Insights parados (> 30 dias em hipótese)

```dataview
TABLE data, rito_origem, tecnica
FROM -".catalisa"
WHERE tipo = "insight" AND status = "hipotese" AND date(today) - data > dur(30 days)
SORT data ASC
```

## Iniciativas abertas por rito

```dataview
TABLE status, natureza, criterio_sucesso, data
FROM -".catalisa"
WHERE tipo = "iniciativa" AND status != "resolvida"
SORT data ASC
GROUP BY rito_origem
```

## Iniciativas sem critério de sucesso

Obrigatório a partir de `aprovada`.

```dataview
TABLE status, rito_origem, data
FROM -".catalisa"
WHERE tipo = "iniciativa" AND status != "proposta" AND (!criterio_sucesso OR criterio_sucesso = "")
SORT data ASC
```

## Iniciativas resolvidas sem desfecho

```dataview
TABLE rito_origem, data
FROM -".catalisa"
WHERE tipo = "iniciativa" AND status = "resolvida" AND (!desfecho OR desfecho = "")
SORT data ASC
```

## Outputs pendentes por rito

```dataview
TABLE status, audiencia, data
FROM -".catalisa"
WHERE tipo = "output" AND status != "apresentado"
SORT data ASC
GROUP BY rito_destino
```
