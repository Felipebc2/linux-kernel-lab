#!/usr/bin/env bash
set -euo pipefail

echo "==> Atualizando sistema..."
sudo apt-get update -y

echo "==> Instalando ferramentas básicas (PDF §2.1)..."
sudo apt-get install -y \
    build-essential \
    libncurses-dev \
    bison \
    flex \
    libssl-dev \
    libelf-dev \
    pahole \
    cpio

echo "==> Instalando QEMU x86-64 (PDF §2.2)..."
sudo apt-get install -y qemu-system qemu-utils qemu-system-x86

echo "==> Verificando instalações..."
qemu-system-x86_64 --version
gcc --version | head -1
make --version | head -1

echo "✅ Dependências instaladas com sucesso."
