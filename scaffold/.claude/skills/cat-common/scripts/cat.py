#!/usr/bin/env python3
"""Estado e validação das entidades do vault Catalisa (stdlib only).

Uso: cat.py estado [VAULT] [--rito NOME] | cat.py validar [VAULT]
Os estados válidos vêm dos comentários `<!-- estados: ... -->` de .catalisa/templates.
"""
import re
import sys
from datetime import date, timedelta
from pathlib import Path

ENTIDADES = ("dor", "insight", "iniciativa", "output")
IGNORAR = {".catalisa", ".claude", ".obsidian", ".git"}
NATUREZAS = {"melhoria", "diagnostico"}
DESFECHOS = {"perseverar", "pivotar", "encerrar"}
DATA_RE = re.compile(r"^\d{4}-\d{2}-\d{2}$")


def frontmatter(texto):
    linhas = texto.splitlines()
    if not linhas or linhas[0].strip() != "---":
        return {}
    fm, chave = {}, None
    for linha in linhas[1:]:
        if linha.strip() == "---":
            break
        item = re.match(r"^\s+-\s*(.*)$", linha)
        if item and chave:
            fm[chave].append(item.group(1).strip().strip("\"'"))
            continue
        par = re.match(r"^([A-Za-z_]+):\s*(.*)$", linha)
        if not par:
            continue
        chave, valor = par.group(1), par.group(2).strip()
        if valor.startswith("[") and valor.endswith("]"):
            fm[chave] = [v.strip().strip("\"'") for v in valor[1:-1].split(",") if v.strip()]
        elif valor == "":
            fm[chave] = []
        else:
            fm[chave] = valor.strip("\"'")
    return fm


def vazio(v):
    return not v or v == []


def estados_validos(vault):
    estados = {}
    for t in ENTIDADES:
        m = re.search(r"<!-- estados: ([^>]*)-->", (vault / ".catalisa/templates" / f"{t}.md").read_text(encoding="utf-8"))
        estados[t] = [s.strip() for s in m.group(1).split("|")]
    return estados


def entidades(vault):
    for p in sorted(vault.rglob("*.md")):
        rel = p.relative_to(vault)
        if rel.parts[0] in IGNORAR:
            continue
        fm = frontmatter(p.read_text(encoding="utf-8"))
        if fm.get("tipo") in ENTIDADES:
            yield str(rel), fm


def erros(rel, fm, estados):
    t, s = fm["tipo"], fm.get("status", "")
    e = []
    if s not in estados[t]:
        e.append(f"estado '{s}' inválido para {t} (válidos: {' | '.join(estados[t])})")
    if not DATA_RE.match(str(fm.get("data", ""))):
        e.append("data ausente ou não renderizada (esperado YYYY-MM-DD)")
    if t == "dor" and s not in ("capturada", "descartada") and vazio(fm.get("evidencia")):
        e.append(f"dor em '{s}' exige evidencia")
    if t == "insight" and vazio(fm.get("dores")):
        e.append("insight exige ao menos 1 wikilink em dores")
    if t == "iniciativa":
        if fm.get("natureza") not in NATUREZAS:
            e.append(f"natureza '{fm.get('natureza', '')}' inválida (válidas: melhoria | diagnostico)")
        if s != "proposta" and vazio(fm.get("criterio_sucesso")):
            e.append(f"iniciativa em '{s}' exige criterio_sucesso")
        if s == "resolvida" and fm.get("desfecho") not in DESFECHOS:
            e.append("iniciativa resolvida exige desfecho (perseverar | pivotar | encerrar)")
    return [f"{rel}: {m}" for m in e]


def validar(vault):
    estados = estados_validos(vault)
    falhas = [m for rel, fm in entidades(vault) for m in erros(rel, fm, estados)]
    for m in falhas:
        print(m)
    print(f"{len(falhas)} erro(s)")
    return 1 if falhas else 0


def estado(vault, rito=None):
    ents = [(r, fm) for r, fm in entidades(vault) if not rito or rito in str(fm.get("rito_origem", ""))]
    print("## Contagem")
    contagem = {}
    for _, fm in ents:
        k = (fm["tipo"], fm.get("status", ""))
        contagem[k] = contagem.get(k, 0) + 1
    for (t, s), n in sorted(contagem.items()):
        print(f"- {t} | {s} | {n}")

    limite = (date.today() - timedelta(days=30)).isoformat()
    lacunas = {
        "Dores sem evidência": lambda fm: fm["tipo"] == "dor" and fm.get("status") == "capturada" and vazio(fm.get("evidencia")),
        "Dores aguardando síntese": lambda fm: fm["tipo"] == "dor" and fm.get("status") == "confirmada",
        "Insights parados (> 30 dias em hipotese)": lambda fm: fm["tipo"] == "insight" and fm.get("status") == "hipotese" and str(fm.get("data", "9999")) < limite,
        "Iniciativas abertas": lambda fm: fm["tipo"] == "iniciativa" and fm.get("status") != "resolvida",
        "Iniciativas sem critério de sucesso": lambda fm: fm["tipo"] == "iniciativa" and fm.get("status") != "proposta" and vazio(fm.get("criterio_sucesso")),
        "Iniciativas resolvidas sem desfecho": lambda fm: fm["tipo"] == "iniciativa" and fm.get("status") == "resolvida" and vazio(fm.get("desfecho")),
        "Outputs pendentes": lambda fm: fm["tipo"] == "output" and fm.get("status") != "apresentado",
    }
    for titulo, cond in lacunas.items():
        itens = [(r, fm) for r, fm in ents if cond(fm)]
        print(f"\n## {titulo} ({len(itens)})")
        for r, fm in itens:
            print(f"- {r} | {fm.get('status', '')} | {fm.get('data', '')} | {fm.get('rito_origem', '')}")
    return 0


def main(argv):
    if not argv or argv[0] not in ("estado", "validar"):
        print(__doc__.strip())
        return 2
    rito = None
    if "--rito" in argv:
        i = argv.index("--rito")
        rito = argv[i + 1]
        argv = argv[:i] + argv[i + 2:]
    vault = Path(argv[1] if len(argv) > 1 else ".").resolve()
    return validar(vault) if argv[0] == "validar" else estado(vault, rito)


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
