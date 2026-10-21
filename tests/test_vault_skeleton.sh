#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
fail() { echo "FAIL: $1"; exit 1; }

[ -f templates/vault/README.md ] || fail "README.md ausente"
grep -q "Templater" templates/vault/README.md || fail "README não menciona plugin Templater"
grep -q "Dataview" templates/vault/README.md || fail "README não menciona plugin Dataview"
grep -q "QuickAdd" templates/vault/README.md || fail "README não menciona plugin QuickAdd"
for d in 00-Diario 01-Ritos 02-Corrente-DevSecOps 03-Templates 04-Action-Items; do
  [ -d "templates/vault/$d" ] || fail "pasta templates/vault/$d ausente"
done
[ -f catalisa.json ] || fail "catalisa.json ausente"
grep -q '"version"' catalisa.json || fail "catalisa.json sem campo version"
grep -q '"0.1.0"' catalisa.json || fail "catalisa.json não fixa version 0.1.0"
echo "PASS"
