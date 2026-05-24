# Log — TASK-06: initramfs montado

## O que foi feito

- Criado `initramfs/init` — script de boot do sistema mínimo
- Criado `scripts/build-initramfs.sh` — script que monta e empacota o initramfs

O `build-initramfs.sh` ainda não foi executado nesta TASK (a execução final acontece na TASK-08, após compilar `sysinfo_call`).

## Como funciona

O **initramfs** (initial RAM filesystem) é um filesystem empacotado em formato `cpio + gzip` que o kernel carrega diretamente da memória no boot. É o "sistema de arquivos raiz mínimo" usado antes de montar um disco real — ou, neste projeto, o sistema completo.

Estrutura do initramfs:
```
initramfs/
├── init          ← script PID 1: monta proc/sys, inicia shell
├── bin/          ← BusyBox + sysinfo_call
├── sbin/         ← BusyBox sbin
├── dev/          ← device nodes (console, null, tty...)
├── proc/         ← mountpoint para procfs
├── sys/          ← mountpoint para sysfs
└── ...
```

**`init`:** É o primeiro processo executado pelo kernel (PID 1). Ele:
1. Monta `/proc` e `/sys` (necessários para ferramentas como `uptime`)
2. Cria o device node `/dev/ttyS0` (serial console do QEMU)
3. Inicia um shell interativo via `setsid cttyhack sh`

**`build-initramfs.sh`:**
1. Copia BusyBox (`_install/`) para o initramfs → provê todos os comandos Unix
2. Copia `sysinfo_call` para `/bin/` → binário que invoca a syscall
3. Cria device nodes com `mknod` (requer root)
4. Empacota com `find | cpio | gzip` → `initramfs.cpio.gz`

O QEMU carrega o `.cpio.gz` via `-initrd` e o kernel o desempacota em RAM.

## O que falta

- [ ] TASK-07 — sysinfo_call.c escrito e compilado estático
- [ ] TASK-08 — initramfs.cpio.gz empacotado (executar build-initramfs.sh)
- [ ] TASK-09 — Boot QEMU + resposta coletada
- [ ] TASK-10 — README final + docs

## Artefatos desta TASK

| Arquivo | Descrição |
|---------|-----------|
| `initramfs/init` | Script PID 1 do boot mínimo |
| `scripts/build-initramfs.sh` | Script de montagem e empacotamento do initramfs |
