#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
fail() { echo "FAIL: $1"; exit 1; }

TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT
V="$TMP/vault"
cp -r templates/vault "$V"
CAT="$V/.claude/skills/cat-common/scripts/cat.py"
[ -f "$CAT" ] || fail "$CAT ausente"

note() { mkdir -p "$(dirname "$V/$1")"; cat > "$V/$1"; }

# vault recém-instalado: válido e sem entidades
python3 "$CAT" validar "$V" >/dev/null || fail "vault limpo deveria validar"

note Dores/ok.md <<'EOF'
---
tipo: dor
status: confirmada
rito_origem: "[[people]]"
evidencia: "fala do PO no encontro"
data: 2026-10-01
---
EOF
note Dores/sem-evidencia.md <<'EOF'
---
tipo: dor
status: capturada
evidencia: ""
data: 2026-10-02
---
EOF
note Insights/parado.md <<'EOF'
---
tipo: insight
status: hipotese
dores:
  - "[[ok]]"
data: 2020-01-01
---
EOF
note Iniciativas/aberta.md <<'EOF'
---
tipo: iniciativa
natureza: melhoria
status: proposta
rito_origem: "[[people]]"
criterio_sucesso: ""
data: 2026-10-03
---
EOF

python3 "$CAT" validar "$V" >/dev/null || fail "vault com entidades válidas deveria validar"
out=$(python3 "$CAT" estado "$V")
grep -q "dor.*confirmada.*1" <<<"$out" || fail "estado não contou dor confirmada"
grep -q "Dores sem evidência" <<<"$out" && grep -q "sem-evidencia" <<<"$out" || fail "estado não apontou dor sem evidência"
grep -q "Insights parados" <<<"$out" && grep -q "parado" <<<"$out" || fail "estado não apontou insight parado > 30 dias"
grep -q "Dores aguardando síntese" <<<"$out" && grep -q "Dores/ok.md" <<<"$out" || fail "estado não apontou dor confirmada aguardando síntese"
out=$(python3 "$CAT" estado "$V" --rito people)
grep -q "aberta" <<<"$out" || fail "--rito people não listou a iniciativa do rito"
grep -q "sem-evidencia" <<<"$out" && fail "--rito people listou dor de outro rito"

# casos inválidos: cada um sozinho deve reprovar com mensagem citando o arquivo
invalid() {
  local name="$1" expect="$2"
  note "Dores/$name.md"
  set +e; out=$(python3 "$CAT" validar "$V" 2>&1); rc=$?; set -e
  [ "$rc" -ne 0 ] || fail "validar aceitou caso inválido '$name'"
  grep -q "$name" <<<"$out" && grep -qi "$expect" <<<"$out" || fail "validar não explicou '$name' (esperado: $expect). Saída: $out"
  rm "$V/Dores/$name.md"
}
invalid estado-invalido "estado" <<'EOF'
---
tipo: dor
status: confirmado
evidencia: "x"
data: 2026-10-01
---
EOF
invalid confirmada-sem-evidencia "evidencia" <<'EOF'
---
tipo: dor
status: confirmada
evidencia: ""
data: 2026-10-01
---
EOF
invalid insight-sem-dores "dores" <<'EOF'
---
tipo: insight
status: hipotese
dores: []
data: 2026-10-01
---
EOF
invalid aprovada-sem-criterio "criterio_sucesso" <<'EOF'
---
tipo: iniciativa
natureza: melhoria
status: aprovada
criterio_sucesso: ""
data: 2026-10-01
---
EOF
invalid resolvida-sem-desfecho "desfecho" <<'EOF'
---
tipo: iniciativa
natureza: melhoria
status: resolvida
criterio_sucesso: "x"
desfecho: ""
data: 2026-10-01
---
EOF
invalid natureza-invalida "natureza" <<'EOF'
---
tipo: iniciativa
natureza: assessment
status: proposta
data: 2026-10-01
---
EOF
invalid data-nao-renderizada "data" <<'EOF'
---
tipo: dor
status: capturada
evidencia: ""
data: <% tp.date.now("YYYY-MM-DD") %>
---
EOF

python3 "$CAT" validar "$V" >/dev/null || fail "vault deveria voltar a validar após remover inválidos"
echo "PASS"
