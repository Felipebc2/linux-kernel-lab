#!/usr/bin/env bash
set -euo pipefail

WORKDIR=${WORKDIR:-$(cd "$(dirname "$0")/.." && pwd)}
JOBS=${JOBS:-$(nproc)}

echo "==> Clonando BusyBox 1.36.1..."
if [ ! -d "$WORKDIR/busybox" ]; then
    git clone https://github.com/mirror/busybox.git "$WORKDIR/busybox"
fi

cd "$WORKDIR/busybox"
git checkout 1_36_1

echo "==> Gerando configuração padrão..."
make defconfig

echo "==> Desabilitando 'tc' (PDF §2.3 — não suportado no kernel 6.6)..."
sed -i 's/^CONFIG_TC=y/# CONFIG_TC is not set/' .config

echo "==> Habilitando static binary (PDF §2.3 — Settings → Build Options)..."
sed -i 's/^# CONFIG_STATIC is not set/CONFIG_STATIC=y/' .config

echo "==> Compilando BusyBox com $JOBS processos..."
make -j"$JOBS"

echo "==> Instalando em _install/..."
make install

echo "✅ BusyBox compilado. Binários em: $WORKDIR/busybox/_install/"
file "$WORKDIR/busybox/busybox"
