# DevSecOps Maturity

Corrente lateral dedicada ao amadurecimento de práticas de segurança no ciclo de desenvolvimento (DevSecOps), cobrindo automação de testes, integração de ferramentas de segurança e compliance.

## Histórico de encontros

<!-- links para notas de ocorrência (criadas a partir de rito-encontro.md) aparecerão aqui -->

## Ações em aberto

```dataview
TABLE tipo, status, data, squad
FROM -"03-Templates"
WHERE contains(rito_origem, this.file.name) AND status != "concluido"
SORT data ASC
```
