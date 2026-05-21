#!/usr/bin/env bash
set -euo pipefail

echo "==> Atualizando sistema..."
sudo apt-get update -y

echo "==> Instalando dependências de build do kernel..."
sudo apt-get install -y \
    build-essential libncurses-dev bison flex \
    libssl-dev libelf-dev pahole cpio git wget

echo "==> Instalando QEMU (x86)..."
sudo apt-get install -y qemu-system qemu-utils qemu-system-x86

echo "==> Verificando instalações..."
qemu-system-x86_64 --version
gcc --version
make --version
pahole --version

echo "Dependências instaladas com sucesso."
