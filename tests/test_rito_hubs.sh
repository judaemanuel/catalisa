#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
fail() { echo "FAIL: $1"; exit 1; }

declare -A hubs=(
  [pdca-mapeamento-projetos]="PDCA / Mapeamento de Projetos"
  [weekly-lideranca]="Weekly Liderança"
  [agentics-sdlc]="Agentics SDLC"
  [people]="People"
)
for f in "${!hubs[@]}"; do
  path="scaffold/Ritos/$f.md"
  [ -f "$path" ] || fail "$path ausente"
  grep -qF "${hubs[$f]}" "$path" || fail "$path não contém o título '${hubs[$f]}'"
  grep -q 'FROM "Ritos/Encontros"' "$path" || fail "$path não lista encontros de Ritos/Encontros"
  grep -q 'FROM -"\.catalisa"' "$path" || fail "$path sem view de itens em aberto excluindo .catalisa"
done
[ ! -e scaffold/Ritos/devsecops-maturity.md ] || fail "DevSecOps não é rito (virou iniciativa de diagnóstico)"

e=scaffold/.catalisa/templates/encontro.md
[ -f "$e" ] || fail "$e ausente"
for field in rito: data: presentes:; do grep -q "^$field" "$e" || fail "$e sem campo '$field'"; done
for s in Pauta Decisões Capturas Pendências; do grep -q "## $s" "$e" || fail "$e sem seção '$s'"; done
grep -q "YYYY-MM-DD-" scaffold/Ritos/README.md || fail "Ritos/README.md não documenta nome dos encontros"
echo "PASS"
