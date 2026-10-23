#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
fail() { echo "FAIL: $1"; exit 1; }

V=scaffold
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
grep -q '"0.3.1"' catalisa.json || fail "catalisa.json não fixa version 0.3.1"

# caminhos de sistema (sobrescrevíveis num update) existem no scaffold e nunca incluem pastas de conteúdo
python3 - <<'PY' || fail "lista 'sistema' de catalisa.json inválida"
import json, os
sistema = json.load(open("catalisa.json"))["sistema"]
assert sistema, "lista sistema vazia"
for p in sistema:
    assert os.path.exists(os.path.join("scaffold", p)), f"{p} não existe em scaffold/"
    assert p.split("/")[0] not in {"Dores", "Insights", "Iniciativas", "Outputs", "Diario", "Ritos"} or p.endswith("/README.md"), f"{p} é conteúdo do operador"
    assert not p.startswith(".obsidian"), f"{p}: config do Obsidian é customizada pelo operador"
PY
echo "PASS"
