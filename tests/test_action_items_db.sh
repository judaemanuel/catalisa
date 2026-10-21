#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
fail() { echo "FAIL: $1"; exit 1; }

f="templates/vault/04-Action-Items/action-items-db.md"
[ -f "$f" ] || fail "$f ausente"
grep -q '```dataview' "$f" || fail "$f sem bloco dataview"
grep -q "status" "$f" || fail "$f não referencia campo 'status'"
grep -q "rito_origem" "$f" || fail "$f não referencia campo 'rito_origem'"
grep -qF -- '-"03-Templates"' "$f" || fail "$f não exclui a pasta de templates da query (evita listar os próprios templates como itens)"

# checagem cruzada: todo template atômico usa os mesmos nomes de campo que esta query espera
for t in dor insight proposta decisao resultado; do
  grep -q "^status:" "templates/vault/03-Templates/$t.md" || fail "$t.md não usa o campo 'status' esperado pela DB"
  grep -q "^rito_origem:" "templates/vault/03-Templates/$t.md" || fail "$t.md não usa o campo 'rito_origem' esperado pela DB"
done
echo "PASS"
