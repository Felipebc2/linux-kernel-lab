#!/usr/bin/env bash
set -euo pipefail

WORKDIR=${WORKDIR:-$(cd "$(dirname "$0")/.." && pwd)}

if [ -z "${MATRICULA:-}" ]; then
    read -rp "Matrícula: " MATRICULA
fi

PATCH_REPO="$WORKDIR/so-2025-02-t-01"
PATCH_FILE="aluno-${MATRICULA}.patch"

echo "==> Clonando repositório de patches do IDP..."
if [ ! -d "$PATCH_REPO" ]; then
    gh repo clone idp-edu/so-2025-02-t-01 "$PATCH_REPO"
fi

cd "$PATCH_REPO"
git switch "aluno-${MATRICULA}.patch"

echo ""
echo "==> Conteúdo do patch (leia antes de aplicar):"
echo "----------------------------------------------------"
cat "$PATCH_FILE"
echo "----------------------------------------------------"
echo ""

read -rp "Aplicar o patch no kernel? [s/N] " CONFIRM
if [[ ! "$CONFIRM" =~ ^[sS]$ ]]; then
    echo "Cancelado."
    exit 0
fi

echo "==> Aplicando patch em $WORKDIR/linux-stable..."
cd "$WORKDIR/linux-stable"
git apply "$PATCH_REPO/$PATCH_FILE"

echo ""
echo "==> Arquivos modificados pelo patch:"
git diff HEAD --stat

echo ""
echo "Patch aplicado. Compile o kernel agora com:"
echo "  cd $WORKDIR/linux-stable && make -j\$(nproc) bzImage"
