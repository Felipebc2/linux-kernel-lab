# Log — TASK-06: Estrutura do initramfs montada

> Gerado em: 2026-05-24

---

## ✅ O que foi feito

- `initramfs/init` criado: script de boot que monta `/proc`, `/sys`, `/dev`, invoca `/bin/sysinfo_call` e cai em shell
- `scripts/build-initramfs.sh` criado: cria a estrutura de diretórios, copia BusyBox de `busybox/_install/`, compila `sysinfo_call.c` estático, empacota em `initramfs.cpio.gz`
- Diretórios criados dentro de `initramfs/`: `bin/`, `dev/`, `proc/`, `sys/`, `tmp/`, `etc/`

---

## ⚙️ Como funciona

O initramfs (initial RAM filesystem) é um filesystem comprimido em formato `cpio.gz` que o kernel extrai para a RAM durante o boot, antes de montar qualquer disco. O arquivo `init` na raiz do cpio é executado como PID 1 pelo kernel. Ele é responsável por montar os pseudo-filesystems (`/proc`, `/sys`, `/dev`) e inicializar o ambiente mínimo. Com `CONFIG_DEVTMPFS_MOUNT=y` o kernel já tenta montar devtmpfs em `/dev` automaticamente, mas o `mount` manual no init garante que funcione mesmo se o auto-mount falhar.

---

## 📋 O que falta

- [ ] TASK-07 — `sysinfo_call.c` compilado estático
- [ ] TASK-08 — `initramfs.cpio.gz` empacotado
- [ ] TASK-09 — Boot no QEMU + resposta coletada
- [ ] TASK-10 — README final + `docs/architecture.md`

---

## 🔗 Artefatos desta TASK

| Arquivo | Tipo | Descrição |
|---------|------|-----------|
| `initramfs/init` | criado | Script de boot PID 1 |
| `scripts/build-initramfs.sh` | criado | Script que monta e empacota o initramfs |
| `docs/log-task06.md` | criado | Este arquivo |
