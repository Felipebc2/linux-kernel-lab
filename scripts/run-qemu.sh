#!/usr/bin/env bash
set -euo pipefail

WORKDIR=${WORKDIR:-$(cd "$(dirname "$0")/.." && pwd)}

qemu-system-x86_64 \
    -kernel "$WORKDIR/linux-stable/arch/x86/boot/bzImage" \
    -initrd "$WORKDIR/initramfs.cpio.gz" \
    -nographic \
    -append "console=ttyS0 loglevel=7"
