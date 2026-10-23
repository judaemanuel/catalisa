#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
fail() { echo "FAIL: $1"; exit 1; }

V=templates/vault
[ -f $V/README.md ] || fail "README.md ausente"
for p in "Templater" "Dataview" "QuickAdd" "Hidden Folders Access"; do
  grep -q "$p" $V/README.md || fail "README não menciona plugin $p"
done
grep -q "\.catalisa/templates" $V/README.md || fail "README não documenta a pasta de templates .catalisa/templates"

for d in Diario Ritos Dores Insights Iniciativas Outputs; do
  [ -d "$V/$d" ] || fail "pasta $V/$d ausente"
  [ -f "$V/$d/README.md" ] || fail "$V/$d sem README.md de navegação"
done
for d in Ritos/Encontros .catalisa/templates .catalisa/kit; do
  [ -d "$V/$d" ] || fail "pasta $V/$d ausente"
done
[ -f $V/Painel.md ] || fail "Painel.md ausente"

for d in 00-Diario 01-Ritos 02-Corrente-DevSecOps 03-Templates 04-Action-Items Action-Items Correntes; do
  [ ! -e "$V/$d" ] || fail "pasta legada $V/$d ainda existe"
done

cfg=$V/.obsidian/plugins/templater-obsidian/data.json
[ -f "$cfg" ] || fail "$cfg ausente (Templater não apontaria para .catalisa/templates)"
grep -q '"templates_folder": *".catalisa/templates"' "$cfg" || fail "$cfg não aponta templates_folder para .catalisa/templates"

[ -f catalisa.json ] || fail "catalisa.json ausente"
grep -q '"0.2.0"' catalisa.json || fail "catalisa.json não fixa version 0.2.0"
echo "PASS"
