#!/usr/bin/env bash
set -euo pipefail

WORKDIR=${WORKDIR:-$(cd "$(dirname "$0")/.." && pwd)}
JOBS=${JOBS:-$(nproc)}

# --- TASK-03: clonar e configurar ---

echo "==> Clonando Kernel Linux 6.6.87 (PDF §2.4)..."
if [ ! -d "$WORKDIR/linux-stable" ]; then
    git clone --depth 1 --branch v6.6.87 \
        git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git \
        "$WORKDIR/linux-stable"
fi

cd "$WORKDIR/linux-stable"

echo "==> Aplicando configuração base x86_64..."
make x86_64_defconfig

echo "==> Habilitando initramfs (PDF §2.4)..."
scripts/config --enable CONFIG_BLK_DEV_INITRD

echo "==> Habilitando kernel 64-bit (PDF §2.4)..."
scripts/config --enable CONFIG_64BIT

echo "==> Habilitando devtmpfs (PDF §2.4)..."
scripts/config --enable CONFIG_DEVTMPFS
scripts/config --enable CONFIG_DEVTMPFS_MOUNT

echo "==> Desabilitando assinatura de drivers (PDF §2.4.1)..."
scripts/config --disable SYSTEM_TRUSTED_KEYS
scripts/config --disable SYSTEM_REVOCATION_KEYS

# CRÍTICO: CONFIG_LOCALVERSION="37" → versão final = 6.6.837
# release[5]='3', release[6]='7' — necessário para o patch calcular a resposta correta
echo "==> Configurando LOCALVERSION (CRÍTICO para o patch)..."
scripts/config --set-str CONFIG_LOCALVERSION "37"
scripts/config --disable CONFIG_LOCALVERSION_AUTO

echo "✅ Kernel configurado."
echo "   Aplique o patch (TASK-04) e depois compile com: bash scripts/build-kernel.sh --compile"

# --- TASK-05: compilar bzImage (chamado com --compile) ---

if [[ "${1:-}" == "--compile" ]]; then
    echo "==> Compilando bzImage com $JOBS processos (pode levar 15-40 min)..."
    make -j"$JOBS" bzImage 2>&1 | tee /tmp/kernel-build.log

    echo ""
    echo "==> Verificando versão embutida no bzImage (CRÍTICO)..."
    strings arch/x86/boot/bzImage | grep "^6\." | head -3

    echo ""
    echo "✅ bzImage gerado:"
    file arch/x86/boot/bzImage
fi
