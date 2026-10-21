#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
fail() { echo "FAIL: $1"; exit 1; }

[ -f README.md ] || fail "README.md (gerador) ausente"
grep -qi "install.sh" README.md || fail "README do gerador não documenta uso do install.sh"
grep -qi "não há.*update\|sem.*update\|manual" README.md || fail "README não documenta que não há update automático"

[ -f CHANGELOG.md ] || fail "CHANGELOG.md ausente"
manifest_version=$(grep -o '"version"[^,}]*' catalisa.json | grep -o '[0-9][0-9.]*')
grep -q "$manifest_version" CHANGELOG.md || fail "CHANGELOG não documenta a version de catalisa.json ($manifest_version)"
echo "PASS"
