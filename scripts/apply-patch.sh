#!/usr/bin/env bash
set -euo pipefail

WORKDIR=${WORKDIR:-$(cd "$(dirname "$0")/.." && pwd)}

if [ -z "${MATRICULA:-}" ]; then
    read -rp "Matrícula: " MATRICULA
fi

# Aceita caminho explícito ou usa o padrão: patch/patch-{MATRICULA}.patch
PATCH_FILE="${1:-$WORKDIR/patch/patch-${MATRICULA}.patch}"

if [ ! -f "$PATCH_FILE" ]; then
    echo "ERRO: patch não encontrado em: $PATCH_FILE"
    echo "Coloque o arquivo do professor em: $WORKDIR/patch/patch-${MATRICULA}.patch"
    echo "Ou passe o caminho diretamente: bash scripts/apply-patch.sh /caminho/para/patch.patch"
    exit 1
fi

echo "==> Patch encontrado: $PATCH_FILE"
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
git apply "$PATCH_FILE"

echo ""
echo "==> Arquivos modificados pelo patch:"
git diff HEAD --stat

echo ""
echo "Patch aplicado com sucesso."
echo "Compile o kernel agora com:"
echo "  cd $WORKDIR/linux-stable && make -j\$(nproc) bzImage"
