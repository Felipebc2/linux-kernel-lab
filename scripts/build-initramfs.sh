#!/usr/bin/env bash
set -euo pipefail

WORKDIR=${WORKDIR:-$(cd "$(dirname "$0")/.." && pwd)}

echo "==> Criando estrutura de diretórios do initramfs..."
mkdir -p "$WORKDIR/initramfs"/{bin,sbin,etc,proc,sys,dev,usr/bin,usr/sbin}

echo "==> Copiando BusyBox para initramfs..."
cp -a "$WORKDIR/busybox/_install/"* "$WORKDIR/initramfs/"

echo "==> Copiando sysinfo_call para initramfs/bin/..."
cp "$WORKDIR/sysinfo_call" "$WORKDIR/initramfs/bin/"
chmod +x "$WORKDIR/initramfs/bin/sysinfo_call"

echo "==> Criando device nodes (requer root)..."
cd "$WORKDIR/initramfs"
sudo bash -c '
    mount -n -t tmpfs none dev 2>/dev/null || true
    mknod -m 622 dev/console c 5 1 2>/dev/null || true
    mknod -m 666 dev/null    c 1 3 2>/dev/null || true
    mknod -m 666 dev/zero    c 1 5 2>/dev/null || true
    mknod -m 666 dev/ptmx    c 5 2 2>/dev/null || true
    mknod -m 666 dev/tty     c 5 0 2>/dev/null || true
    mknod -m 444 dev/random  c 1 8 2>/dev/null || true
    mknod -m 444 dev/urandom c 1 9 2>/dev/null || true
    chown root:tty dev/console dev/ptmx dev/tty 2>/dev/null || true
'

echo "==> Empacotando initramfs.cpio.gz..."
find . -print0 | cpio --null -ov --format=newc | gzip -9 > "$WORKDIR/initramfs.cpio.gz"

echo ""
echo "✅ initramfs gerado: $WORKDIR/initramfs.cpio.gz"
du -sh "$WORKDIR/initramfs.cpio.gz"
