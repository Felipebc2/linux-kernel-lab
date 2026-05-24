# Log — TASK-08: initramfs.cpio.gz empacotado

## O que foi feito

- Executado `bash scripts/build-initramfs.sh` em `~/repo/kernel/so-t01`
- Script criou estrutura de diretórios, copiou BusyBox e `sysinfo_call`, criou device nodes e empacotou

**Output de validação:**
```
-rw-r--r-- 1 felipebc2 felipebc2 1.6M May 24 14:11 initramfs.cpio.gz

bin/sysinfo_call
sbin/run-init
sbin/init
init
```

## Como funciona

O `build-initramfs.sh` executa as seguintes etapas:

1. **Estrutura de diretórios** — cria `bin/`, `sbin/`, `dev/`, `proc/`, `sys/`, etc.
2. **BusyBox** — copia `busybox/_install/*` → provê `sh`, `ls`, `mount`, `grep`, `dmesg`, etc.
3. **sysinfo_call** — copia o binário estático compilado na TASK-07 para `bin/`
4. **Device nodes** (root):
   - `mount -n -t tmpfs none dev` → tmpfs sobre `/dev`
   - `mknod` cria `console`, `null`, `zero`, `ptmx`, `tty`, `random`, `urandom`
5. **Empacotamento** — `find . | cpio --format=newc | gzip -9 > initramfs.cpio.gz`

O QEMU recebe o `.cpio.gz` via `-initrd` e o kernel o extrai em RAM, usando como
rootfs. O kernel então executa `/init` como PID 1.

## O que falta

- [ ] TASK-09 — Boot QEMU + resposta coletada
- [ ] TASK-10 — README final + docs

## Artefatos desta TASK

| Arquivo | Descrição |
|---------|-----------|
| `initramfs.cpio.gz` | Imagem do initramfs empacotada (ignorada pelo git) |
| `scripts/build-initramfs.sh` | Script executado (criado na TASK-06) |
