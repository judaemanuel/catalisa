#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
fail() { echo "FAIL: $1"; exit 1; }

declare -A hubs=(
  [pdca-mapeamento-projetos]="PDCA / Mapeamento de Projetos"
  [weekly-lideranca-prudential]="Weekly Liderança Prudential"
  [agentics-sdlc-prudential]="Agentics SDLC Prudential"
  [prudential-people]="Prudential People"
)
for f in "${!hubs[@]}"; do
  path="templates/vault/01-Ritos/$f.md"
  [ -f "$path" ] || fail "$path ausente"
  grep -qF "${hubs[$f]}" "$path" || fail "$path não contém o título '${hubs[$f]}'"
  grep -q '```dataview' "$path" || fail "$path sem bloco dataview de ações em aberto"
done

[ -f templates/vault/02-Corrente-DevSecOps/devsecops-maturity.md ] || fail "devsecops-maturity.md ausente"
grep -qF "DevSecOps Maturity" templates/vault/02-Corrente-DevSecOps/devsecops-maturity.md || fail "devsecops-maturity.md sem título esperado"

[ -f templates/vault/03-Templates/rito-encontro.md ] || fail "rito-encontro.md ausente"
grep -q "^rito:" templates/vault/03-Templates/rito-encontro.md || fail "rito-encontro.md sem campo frontmatter 'rito'"
echo "PASS"
