#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
fail() { echo "FAIL: $1"; exit 1; }

V=templates/vault
c=$V/CLAUDE.md
[ -f "$c" ] || fail "$c ausente"
[ "$(wc -l < "$c")" -le 40 ] || fail "$c deve ser curto (<= 40 linhas)"

for s in cat-capturar cat-sintetizar cat-preparar-rito cat-registrar-encontro; do
  f=$V/.claude/skills/$s/SKILL.md
  [ -f "$f" ] || fail "$f ausente"
  [ "$(sed -n 1p "$f")" = "---" ] || fail "$f sem frontmatter"
  grep -q "^name: $s$" "$f" || fail "$f com name diferente de $s"
  grep -q "^description: Use when" "$f" || fail "$f: description deve começar com 'Use when'"
  grep -q "$s" "$c" || fail "$c não lista a skill $s"
done

# todo caminho do vault citado em CLAUDE.md e skills existe
for f in "$c" $V/.claude/skills/*/SKILL.md; do
  for p in $(grep -oE '\.(catalisa|claude)/[A-Za-z0-9_./-]*[A-Za-z0-9_]' "$f" | sort -u); do
    [ -e "$V/$p" ] || fail "$f cita caminho inexistente: $p"
  done
done
grep -q "cat.py validar" $V/.claude/skills/cat-capturar/SKILL.md || fail "cat-capturar não valida após escrever"
grep -q "facilitador" $V/.claude/skills/cat-sintetizar/SKILL.md || fail "cat-sintetizar não declara postura facilitador"
echo "PASS"
