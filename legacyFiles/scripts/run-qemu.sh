#!/usr/bin/env bash
set -euo pipefail

WORKDIR=${WORKDIR:-$(cd "$(dirname "$0")/.." && pwd)}

BZIMAGE="$WORKDIR/linux-stable/arch/x86/boot/bzImage"
INITRD="$WORKDIR/initramfs.cpio.gz"

if [ ! -f "$BZIMAGE" ]; then
    echo "ERRO: bzImage não encontrado. Rode: bash scripts/build-kernel.sh"
    exit 1
fi
if [ ! -f "$INITRD" ]; then
    echo "ERRO: initramfs.cpio.gz não encontrado. Rode: bash scripts/build-initramfs.sh"
    exit 1
fi

echo "==> Iniciando QEMU..."
echo "    Dentro do shell, rode: /bin/sysinfo_call && dmesg | tail -30"
echo "    Para sair: Ctrl-A depois X"
echo ""

qemu-system-x86_64 \
    -kernel "$BZIMAGE" \
    -initrd "$INITRD" \
    -nographic \
    -append "console=ttyS0 loglevel=3"
