#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
fail() { echo "FAIL: $1"; exit 1; }

T=templates/vault/.catalisa/templates
declare -A inicial=([dor]=capturada [insight]=hipotese [iniciativa]=proposta [output]=rascunho)
declare -A extras=(
  [dor]="evidencia: encontro:"
  [insight]="dores: tecnica:"
  [iniciativa]="natureza: desfecho: insights: criterio_sucesso: metrica_antes: metrica_depois:"
  [output]="audiencia: rito_destino: fontes:"
)

for t in dor insight iniciativa output; do
  f="$T/$t.md"
  [ -f "$f" ] || fail "$f ausente"
  for field in tipo: status: rito_origem: squad: stakeholder: tags: data: relacionados: ${extras[$t]}; do
    grep -q "^$field" "$f" || fail "$f sem campo de frontmatter '$field'"
  done
  grep -q "^tipo: $t$" "$f" || fail "$f não fixa tipo: $t"
  grep -q "^status: ${inicial[$t]}$" "$f" || fail "$f não inicia em status ${inicial[$t]}"
  estados=$(grep -o '<!-- estados: [^>]*-->' "$f") || fail "$f sem comentário '<!-- estados: ... -->'"
  LC_ALL=C grep -q '[^ -~]' <<<"$estados" && fail "$f declara estados com caracteres não-ASCII (quebra comparação no Dataview)"
  grep -q "${inicial[$t]}" <<<"$estados" || fail "$f: estado inicial ausente da lista de estados"
done

for s in "Condição atual" "Condição alvo" "Obstáculos" "Contramedidas" "Decisões" "Alternativas rejeitadas" "Consequências" "Medição" "Aprendizado"; do
  grep -q "$s" $T/iniciativa.md || fail "iniciativa.md sem seção/campo '$s' (A3 + ADR + HDD)"
done
grep -q "perseverar" $T/iniciativa.md && grep -q "pivotar" $T/iniciativa.md && grep -q "encerrar" $T/iniciativa.md \
  || fail "iniciativa.md não documenta desfechos perseverar|pivotar|encerrar"
grep -q "melhoria" $T/iniciativa.md && grep -q "diagnostico" $T/iniciativa.md || fail "iniciativa.md não documenta natureza melhoria|diagnostico"

for s in "Observação" "Evidência"; do grep -q "## $s" $T/dor.md || fail "dor.md sem seção '$s'"; done
for s in "Hipótese de causa" "Evidências" "Contraevidências" "Técnica aplicada"; do grep -q "## $s" $T/insight.md || fail "insight.md sem seção '$s'"; done
[ "$(grep -c '^## ' $T/output.md)" -eq 0 ] || fail "output.md não deve padronizar corpo (decisão D7)"

for t in proposta decisao resultado; do
  [ ! -e "$T/$t.md" ] || fail "template legado $t.md ainda existe (absorvido pela iniciativa)"
done
echo "PASS"
