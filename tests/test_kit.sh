#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
fail() { echo "FAIL: $1"; exit 1; }

K=templates/vault/.catalisa/kit
c=$K/tecnicas.csv
[ -f "$c" ] || fail "$c ausente"
[ "$(head -1 "$c")" = "id,categoria,nome,descricao,transicao" ] || fail "$c com cabeçalho inesperado"
python3 - "$c" <<'PY' || fail "$c inválido"
import csv, sys, collections
rows = list(csv.DictReader(open(sys.argv[1], encoding="utf-8")))
ok = {"dor-insight", "insight-iniciativa", "iniciativa-output"}
assert len(rows) >= 20, f"apenas {len(rows)} técnicas"
ids = [r["id"] for r in rows]
assert len(ids) == len(set(ids)), "ids duplicados"
assert all(r["transicao"] in ok for r in rows), "transicao fora do domínio"
assert all(r["descricao"].strip() for r in rows), "descricao vazia"
cnt = collections.Counter(r["transicao"] for r in rows)
assert all(cnt[t] >= 3 for t in ok), f"transição com menos de 3 técnicas: {cnt}"
PY

grep -q "MIT" $K/README.md && grep -q "BMAD" $K/README.md || fail "$K/README.md sem atribuição de licença (MIT, BMAD)"
for m in "Affinity" "Impact" "NUF"; do grep -q "$m" $K/convergencia.md || fail "convergencia.md sem '$m'"; done
for p in facilitador parceiro gerador; do grep -q "$p" $K/posturas.md || fail "posturas.md sem postura '$p'"; done
echo "PASS"
