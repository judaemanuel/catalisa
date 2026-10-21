#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
fail() { echo "FAIL: $1"; exit 1; }

TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT
PWD_REPO="$(pwd)"

# Caso 1: alvo novo, script chamado por caminho absoluto de outro cwd
( cd /tmp && bash "$PWD_REPO/install.sh" "$TMP/fresh" )
[ -f "$TMP/fresh/README.md" ] || fail "install.sh não criou README.md no alvo"
[ -d "$TMP/fresh/01-Ritos" ] || fail "install.sh não copiou 01-Ritos"
[ -d "$TMP/fresh/.git" ] || fail "install.sh não inicializou git no alvo"
commits=$(git -C "$TMP/fresh" log --oneline | wc -l)
[ "$commits" -eq 1 ] || fail "esperado exatamente 1 commit no alvo, encontrado $commits"
[ -f "$TMP/fresh/.catalisa-version.json" ] || fail "install.sh não gravou .catalisa-version.json no alvo"
manifest_version=$(grep -o '"version"[^,}]*' "$PWD_REPO/catalisa.json" | grep -o '[0-9][0-9.]*')
grep -q "$manifest_version" "$TMP/fresh/.catalisa-version.json" || fail ".catalisa-version.json não reflete a version de catalisa.json"
grep -q '"instalado_em"' "$TMP/fresh/.catalisa-version.json" || fail ".catalisa-version.json sem campo instalado_em"

# Caso 2: alvo já existe com conteúdo real -> deve abortar sem apagar nada
mkdir -p "$TMP/existing"
echo "conteudo do usuario" > "$TMP/existing/nota-real.md"
set +e
bash "$PWD_REPO/install.sh" "$TMP/existing"
rc=$?
set -e
[ "$rc" -ne 0 ] || fail "install.sh deveria falhar quando o alvo já tem conteúdo"
[ -f "$TMP/existing/nota-real.md" ] || fail "install.sh apagou conteúdo real do usuário"
echo "PASS"
