# catalisa

Gerador de um harness de melhoria contínua baseado no ciclo PDCA. A partir de um conjunto fixo de templates, `catalisa` cria uma instância (vault Obsidian) pronta para uso, já versionada em git.

O vault rastreia o ciclo Dor → Insight → Iniciativa → Output, com cada nota amadurecendo por estado. Ele inclui hubs de rito, um Painel de lacunas e um Kit de técnicas de análise. Detalhes de uso e plugins obrigatórios: `scaffold/README.md`.

## Como instalar uma instância

```bash
./install.sh [caminho-do-destino]
```

Se `caminho-do-destino` não for informado, a instância é criada em `../catalisa-instance` (relativo a este repositório). O script:

- copia o scaffold do vault (`scaffold/`, espelho exato de uma instância) para o destino;
- grava `.catalisa-version.json` no destino com a versão do gerador usada e a data de instalação;
- inicializa um repositório git no destino com um commit inicial.

O destino precisa estar vazio ou não existir; o script recusa sobrescrever um diretório não vazio.

## Sem update automático

Não existe mecanismo de update automático: instâncias já criadas não são atualizadas quando o gerador `catalisa` muda. Mudanças futuras nos templates ou no `install.sh` precisam ser portadas manualmente para instâncias existentes, comparando a versão registrada em `.catalisa-version.json` da instância com a versão atual de `catalisa.json` neste repositório.

A lista `sistema` de `catalisa.json` diz quais caminhos pertencem ao gerador e podem ser sobrescritos numa atualização manual: copie-os de `scaffold/` para a instância e atualize `version` em `.catalisa-version.json`. Todo o resto é conteúdo ou configuração do operador e nunca deve ser sobrescrito: notas, hubs de rito e `.obsidian/`.

## Versionamento

A versão do gerador é a fonte da verdade em `catalisa.json`. Consulte `CHANGELOG.md` para o histórico de mudanças.
