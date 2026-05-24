#!/usr/bin/env bash
set -euo pipefail

WORKDIR=${WORKDIR:-$(cd "$(dirname "$0")/.." && pwd)}
JOBS=${JOBS:-$(nproc)}

echo "==> Clonando Kernel Linux 6.6.87 (pode demorar alguns minutos)..."
if [ ! -d "$WORKDIR/linux-stable" ]; then
    git clone --depth 1 --branch v6.6.87 \
        git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git \
        "$WORKDIR/linux-stable"
fi

cd "$WORKDIR/linux-stable"

echo "==> Verificando commit..."
COMMIT=$(git rev-parse HEAD)
echo "    Commit: $COMMIT"
if [ "$COMMIT" != "814637ca257f4faf57a73fd4e38888cce88b5911" ]; then
    echo "AVISO: commit inesperado: $COMMIT"
fi

echo "==> Aplicando configuração base x86_64..."
make x86_64_defconfig

echo "==> Ajustando opções obrigatórias..."
scripts/config --enable  CONFIG_BLK_DEV_INITRD
scripts/config --enable  CONFIG_64BIT
scripts/config --enable  CONFIG_DEVTMPFS
scripts/config --enable  CONFIG_DEVTMPFS_MOUNT
scripts/config --disable SYSTEM_TRUSTED_KEYS
scripts/config --disable SYSTEM_REVOCATION_KEYS

echo "==> Aplicando configurações sem interação..."
make olddefconfig

echo "==> Validando configs críticas..."
grep -q "CONFIG_BLK_DEV_INITRD=y" .config && echo "  initramfs: OK" || echo "  initramfs: FALHOU"
grep -q "CONFIG_DEVTMPFS=y"       .config && echo "  devtmpfs:  OK" || echo "  devtmpfs:  FALHOU"
grep -q "CONFIG_64BIT=y"          .config && echo "  64-bit:    OK" || echo "  64-bit:    FALHOU"

echo "Kernel configurado. Aplique o patch antes de compilar."
