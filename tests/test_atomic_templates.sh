#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
fail() { echo "FAIL: $1"; exit 1; }

for t in dor insight proposta decisao resultado; do
  f="templates/vault/03-Templates/$t.md"
  [ -f "$f" ] || fail "$f ausente"
  for field in "tipo:" "status:" "rito_origem:" "squad:" "stakeholder:" "tags:" "data:" "relacionados:"; do
    grep -q "^$field" "$f" || fail "$f sem campo de frontmatter '$field'"
  done
  grep -q "^tipo: $t" "$f" || fail "$f não fixa tipo: $t"
done
echo "PASS"
