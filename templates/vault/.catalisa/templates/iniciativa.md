---
tipo: iniciativa
natureza: melhoria
status: proposta
desfecho: ""
rito_origem: ""
insights: []
criterio_sucesso: ""
metrica_antes: ""
metrica_depois: ""
squad: ""
stakeholder: ""
tags: []
data: <% tp.date.now("YYYY-MM-DD") %>
relacionados: []
---

<!-- estados: proposta | aprovada | em-execucao | analisada | resolvida -->
<!-- natureza: melhoria | diagnostico — diagnostico (ex.: assessment) produz Dores e Insights com `relacionados` apontando para esta nota -->
<!-- desfecho (preencher ao chegar em resolvida): perseverar | pivotar | encerrar -->
<!-- RESSALVA: `criterio_sucesso` é obrigatório a partir de `aprovada`; Aprendizado é obrigatório se desfecho for pivotar ou encerrar. Estados alinhados ao Hypothesis-Driven Development, com `aprovada` no lugar de `validated` porque aqui a validação é a decisão em rito -->

# <% tp.file.title %>

## Condição atual

Situação de hoje, com dados. Ligue os insights em `insights`.

## Condição alvo

Onde se quer chegar e como saberemos que chegamos. Replique em `criterio_sucesso` (mensurável, com prazo).

## Obstáculos

O que impede de ir da condição atual à condição alvo.

## Contramedidas

Experimentos ou ações para remover cada obstáculo, com responsável.

## Decisões

Log append-only (formato ADR). Uma entrada por decisão, nunca editar entradas antigas:

### <% tp.date.now("YYYY-MM-DD") %> — título da decisão
- **Encontro:** [[YYYY-MM-DD-rito]]
- **Contexto:** o que forçou a decisão.
- **Decisão:** o que foi decidido e por quem.
- **Alternativas rejeitadas:** opções consideradas e por que caíram.
- **Consequências:** o que passa a ser verdade, incluindo trade-offs aceitos.

## Medição

Valores de `metrica_antes` e `metrica_depois`, fonte e data de cada medição.

## Aprendizado

O que esta iniciativa ensinou, independentemente do desfecho.
