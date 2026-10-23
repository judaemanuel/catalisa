#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
fail() { echo "FAIL: $1"; exit 1; }

f="templates/vault/Painel.md"
T=templates/vault/.catalisa/templates
[ -f "$f" ] || fail "$f ausente"
[ "$(grep -c '```dataview' "$f")" -ge 6 ] || fail "$f deveria ter ao menos 6 views dataview"
blocks=$(grep -c '^FROM' "$f")
excl=$(grep -c '^FROM.*-"\.catalisa"' "$f")
[ "$blocks" -eq "$excl" ] || fail "$f: toda query precisa excluir -\".catalisa\" (senão lista os próprios templates)"
for k in evidencia criterio_sucesso rito_destino rito_origem; do
  grep -q "$k" "$f" || fail "$f não usa o campo '$k'"
done

# checagem cruzada: todo estado citado em query existe na lista de estados de algum template
todos=$(cat $T/*.md | grep -o '<!-- estados: [^>]*-->')
for s in $(grep -o 'status [!=]*= *"[a-z-]*"' "$f" | grep -o '"[a-z-]*"' | tr -d '"' | sort -u); do
  grep -qw -- "$s" <<<"$todos" || fail "$f usa estado '$s' que nenhum template declara"
done
echo "PASS"
