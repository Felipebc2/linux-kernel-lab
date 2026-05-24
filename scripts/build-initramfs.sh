#!/usr/bin/env bash
set -euo pipefail

WORKDIR=${WORKDIR:-$(cd "$(dirname "$0")/.." && pwd)}

RAMFS="$WORKDIR/initramfs"
BUSYBOX_INSTALL="$WORKDIR/busybox/_install"

echo "==> Verificando dependências..."
if [ ! -d "$BUSYBOX_INSTALL" ]; then
    echo "ERRO: BusyBox não compilado. Rode: bash scripts/build-busybox.sh"
    exit 1
fi
if [ ! -f "$WORKDIR/sysinfo_call.c" ]; then
    echo "ERRO: sysinfo_call.c não encontrado em $WORKDIR/"
    exit 1
fi

echo "==> Criando estrutura de diretórios..."
mkdir -p "$RAMFS"/{bin,dev,proc,sys,tmp,etc}

echo "==> Copiando BusyBox..."
cp -a "$BUSYBOX_INSTALL/bin/." "$RAMFS/bin/"
cp -a "$BUSYBOX_INSTALL/sbin/." "$RAMFS/bin/" 2>/dev/null || true

echo "==> Compilando sysinfo_call.c (static)..."
gcc -static -o "$RAMFS/bin/sysinfo_call" "$WORKDIR/sysinfo_call.c"
echo "    $(file "$RAMFS/bin/sysinfo_call")"

echo "==> Configurando init..."
chmod +x "$RAMFS/init"

echo "==> Empacotando initramfs.cpio.gz..."
(cd "$RAMFS" && find . | cpio -H newc -o 2>/dev/null | gzip -9 > "$WORKDIR/initramfs.cpio.gz")

SIZE=$(du -sh "$WORKDIR/initramfs.cpio.gz" | cut -f1)
echo ""
echo "initramfs.cpio.gz pronto: $SIZE"
echo ""
echo "Boot com:"
echo "  qemu-system-x86_64 \\"
echo "    -kernel $WORKDIR/linux-stable/arch/x86/boot/bzImage \\"
echo "    -initrd $WORKDIR/initramfs.cpio.gz \\"
echo "    -nographic \\"
echo "    -append \"console=ttyS0 loglevel=3\""
