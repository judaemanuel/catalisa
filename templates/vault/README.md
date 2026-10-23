# Vault Catalisa

Harness pessoal de melhoria contínua em Obsidian. Rastreia o ciclo completo de uma melhoria, da dor observada num rito até o resultado medido, com vocabulário de práticas consagradas: nugget de atomic research, A3, Hypothesis-Driven Development e ADR.

Comece pelo [[Painel]].

## Fluxo

```
Rito / Diário ──► Dor ──► Insight ──► Iniciativa ──► Output
  (captura)     capturada  hipotese    proposta       rascunho
                confirmada evidenciado aprovada       revisao
                agrupada   validado    em-execucao    pronto
                           refutado    analisada      apresentado
                                       resolvida
```

Cada nota amadurece **no próprio lugar**: o estado fica no frontmatter (`status`), e a pasta indica apenas o tipo da entidade. As views do [[Painel]] e das hubs de rito filtram por estado.

| Pasta | Conteúdo |
|---|---|
| [[Diario/README\|Diario]] | Captura diária (~5 min) e carry-over de pendências |
| [[Ritos/README\|Ritos]] | Hubs dos ritos e `Encontros/` (uma nota por ocorrência) |
| [[Dores/README\|Dores]] | Problemas observados, com evidência |
| [[Insights/README\|Insights]] | Hipóteses de causa ligando dores |
| [[Iniciativas/README\|Iniciativas]] | Melhorias e diagnósticos: A3, decisões (ADR), medição |
| [[Outputs/README\|Outputs]] | Material para audiências específicas |

## Cadência

| Momento | Duração | O que fazer |
|---|---|---|
| Diário | ~5 min | Só capturar |
| Revisão semanal | ~30 min | Promover estados: confirmar dores, sintetizar insights (técnicas do Kit) |
| Pré-rito | — | Montar pauta e Output a partir do Painel e da hub do rito |
| Pós-rito | — | Registrar o encontro e lançar decisões nas Iniciativas |

## Infraestrutura (`.catalisa/`)

- `.catalisa/templates/`: templates do Templater (`dor`, `insight`, `iniciativa`, `output`, `encontro`, `diario`).
- `.catalisa/kit/`: técnicas de análise, movimentos de convergência e posturas de facilitação, usados na revisão semanal e pela camada de IA.

## Camada de IA (Claude Code)

Abra o Claude Code na raiz do vault. As regras ficam em `CLAUDE.md`, e as skills `/cat-capturar`, `/cat-sintetizar`, `/cat-preparar-rito` e `/cat-registrar-encontro` cobrem a cadência. `python3 .claude/skills/cat-common/scripts/cat.py estado` mostra o Painel no terminal, e `cat.py validar` checa as regras de estado.

## Plugins Obsidian obrigatórios

- **Templater**: cria notas a partir de `.catalisa/templates/`. O vault já vem com `templates_folder` configurado em `.obsidian/plugins/templater-obsidian/data.json`.
- **Dataview**: views por estado no Painel e nas hubs de rito.
- **QuickAdd**: captura rápida.
- **Hidden Folders Access**: o Obsidian ignora pastas que começam com `.`. Este plugin injeta `.catalisa/` no índice para o Templater enxergar os templates. Desktop-only; requer Obsidian 1.13+.

### Configuração após instalar os plugins

1. **Settings → Hidden Folders Access**: ative a pasta `.catalisa`.
2. **Settings → Templater**: confirme que *Template folder location* está em `.catalisa/templates`.
3. Crie uma nota de teste com *Templater: Create new note from template* e confira se os 6 templates aparecem.

Com o plugin ativo, `.catalisa/` fica visível no explorador e na busca. As queries do Painel e das hubs excluem a pasta (`FROM -".catalisa"`), então os templates não aparecem como itens.
