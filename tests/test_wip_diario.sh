#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
fail() { echo "FAIL: $1"; exit 1; }

f="templates/vault/03-Templates/wip-diario.md"
[ -f "$f" ] || fail "$f ausente"
grep -q '```dataview' "$f" || fail "$f sem bloco dataview de pendências do dia anterior"
grep -qi "pendente\|pendência\|em-andamento" "$f" || fail "$f não referencia conceito de pendência/carry-over"

r="templates/vault/00-Diario/README.md"
[ -f "$r" ] || fail "$r ausente"
grep -q "YYYY-MM-DD" "$r" || fail "$r não documenta convenção de nome de arquivo"
echo "PASS"
