# Changelog

## 0.3.1

Só no gerador; o conteúdo das instâncias não muda.

- `templates/vault/` renomeado para `scaffold/`, para não confundir com `.catalisa/templates`. Continua sendo um espelho exato da instância.
- `catalisa.json`: o campo `templates` (sem uso) foi substituído por `sistema`, a lista de caminhos do gerador que uma atualização manual pode sobrescrever.

## 0.3.0

Camada de IA (Claude Code) na instância.

- `CLAUDE.md` da instância: confidencialidade, operador como dono de toda mudança de estado, proibição de inventar evidência, decisões só acrescentadas (append-only), convenções de nome de arquivo.
- Skills `cat-capturar` (texto livre → dores), `cat-sintetizar` (revisão semanal, postura facilitador), `cat-preparar-rito` (briefing e pauta) e `cat-registrar-encontro` (encontro, decisões ADR, mudanças de estado propostas).
- `cat.py` (Python stdlib): `estado` (o Painel fora do Obsidian, com filtro `--rito`) e `validar` (regras de estado). Os estados válidos são lidos dos próprios templates.

## 0.2.0

Reestruturação do modelo: as notas amadurecem por estado (`status` no frontmatter) e a pasta indica só o tipo da entidade. Vocabulário alinhado a práticas consagradas: nugget de atomic research, A3, Hypothesis-Driven Development e ADR. **Incompatível com a 0.1.0**: recrie a instância com `install.sh`.

- Pastas sem prefixo numérico, cada uma com README de navegação: `Diario`, `Ritos` (+ `Ritos/Encontros`), `Dores`, `Insights`, `Iniciativas`, `Outputs`.
- `Painel.md` substitui `04-Action-Items/`, com views por estado e por lacuna (dor sem evidência, insight parado, iniciativa sem critério de sucesso ou sem desfecho, outputs pendentes).
- Templates movidos para `.catalisa/templates/`, com o Templater pré-configurado. Requer o plugin Hidden Folders Access.
- Entidades `dor`, `insight`, `iniciativa` e `output`, cada uma com um ciclo de estados declarado. `proposta`, `decisao` e `resultado` foram absorvidos pela `iniciativa` (seções A3, log de decisões ADR, medição e aprendizado). `rito-encontro` virou `encontro` e `wip-diario` virou `diario`.
- `02-Corrente-DevSecOps` removido: assessments viram iniciativas com `natureza: diagnostico`.
- Novo Kit em `.catalisa/kit/`: 27 técnicas por transição de estado, movimentos de convergência e posturas de facilitação, curados do BMAD-METHOD (MIT).
- Templates passam a usar sintaxe Templater (`<% tp.date.now() %>`, `<% tp.file.title %>`).

## 0.1.0

Primeira versão do gerador `catalisa`. `install.sh` cria uma instância de vault Obsidian com:

- 5 subpastas do vault: `00-Diario`, `01-Ritos`, `02-Corrente-DevSecOps`, `03-Templates`, `04-Action-Items`;
- 5 templates atômicos: dor, insight, proposta, decisão, resultado;
- 4 hub notes de rito (agentics SDLC, mapeamento de projetos PDCA, people, weekly liderança) e a corrente DevSecOps (hub de maturidade);
- template `rito-encontro.md`, usado para registrar ocorrências/reuniões de um rito, consumido pelas hub notes via wikilink em `rito:`;
- template de WIP diário, com query de itens em carry-over;
- Action Items DB unificado, com agregação cruzada entre ritos.
