#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET="${1:-$SCRIPT_DIR/../catalisa-pru}"

if [ -e "$TARGET" ] && [ -n "$(ls -A "$TARGET" 2>/dev/null)" ]; then
  echo "Erro: o alvo '$TARGET' já existe e não está vazio. Escolha outro diretório ou remova o conteúdo existente." >&2
  exit 1
fi

mkdir -p "$TARGET"
cp -r "$SCRIPT_DIR/templates/vault/." "$TARGET/"

version=$(grep -o '"version"[^,}]*' "$SCRIPT_DIR/catalisa.json" | grep -o '[0-9][0-9.]*')
instalado_em=$(date -Iseconds)

cat > "$TARGET/.catalisa-version.json" <<EOF
{"version": "$version", "instalado_em": "$instalado_em"}
EOF

git -C "$TARGET" init -q
git -C "$TARGET" add -A
git -C "$TARGET" -c user.name="Catalisa Installer" -c user.email="catalisa@localhost" commit -q -m "chore: scaffold catalisa-pru v0 from catalisa templates"

echo "Instância criada com sucesso em: $TARGET"
