#!/usr/bin/env bash
set -euo pipefail

WORKDIR=${WORKDIR:-/home/felipebc2/repo/kernel/so-t01}
JOBS=${JOBS:-$(nproc)}

echo "==> Clonando BusyBox 1.36.1..."
if [ ! -d "$WORKDIR/busybox" ]; then
    git clone https://github.com/mirror/busybox.git "$WORKDIR/busybox"
fi

cd "$WORKDIR/busybox"
git checkout 1_36_1

echo "==> Gerando configuração padrão..."
make defconfig

echo "==> Desabilitando 'tc' (incompatível com kernel 6.6)..."
sed -i 's/CONFIG_TC=y/# CONFIG_TC is not set/' .config

echo "==> Habilitando static binary..."
sed -i 's/# CONFIG_STATIC is not set/CONFIG_STATIC=y/' .config

echo "==> Aplicando configurações..."
yes "" | make oldconfig

echo "==> Compilando BusyBox com $JOBS processos..."
make -j"$JOBS"

echo "==> Instalando em _install/..."
make install

echo "BusyBox compilado. Binário em: $WORKDIR/busybox/_install"
