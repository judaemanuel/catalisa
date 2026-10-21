# catalisa

Gerador de um harness de melhoria contínua para vault Obsidian, baseado no ciclo PDCA. A partir de um conjunto fixo de templates, `catalisa` cria uma instância (vault) pronta para uso, com estrutura de pastas, templates atômicos e hubs de rito já versionados em git.

## Como instalar uma instância

```bash
./install.sh [caminho-do-destino]
```

Se `caminho-do-destino` não for informado, a instância é criada em `../catalisa-instance` (relativo a este repositório). O script:

- copia a estrutura de templates (`templates/vault`) para o destino;
- grava `.catalisa-version.json` no destino com a versão do gerador usada e a data de instalação;
- inicializa um repositório git no destino com um commit inicial.

O destino precisa estar vazio ou não existir; o script recusa sobrescrever um diretório não vazio.

## Sem update automático

Não existe mecanismo de update automático: instâncias já criadas não são atualizadas quando o gerador `catalisa` muda. Mudanças futuras nos templates ou no `install.sh` precisam ser portadas manualmente para instâncias existentes, comparando a versão registrada em `.catalisa-version.json` da instância com a versão atual de `catalisa.json` neste repositório.

## Versionamento

A versão do gerador é a fonte da verdade em `catalisa.json`. Consulte `CHANGELOG.md` para o histórico de mudanças.
