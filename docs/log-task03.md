# Log — TASK-03: Kernel Linux 6.6.87 configurado

> Gerado em: 2026-05-21

---

## ✅ O que foi feito

- Clonado `linux-stable` com `--depth 1 --branch v6.6.87` em `linux-stable/`
- Commit verificado: `814637ca257f4faf57a73fd4e38888cce88b5911` ✅
- `make x86_64_defconfig` gerou configuração base para x86-64
- Ajustes via `scripts/config`:
  - `CONFIG_BLK_DEV_INITRD=y` — suporte a initramfs
  - `CONFIG_64BIT=y` — kernel 64-bit
  - `CONFIG_DEVTMPFS=y` — monta `/dev` automaticamente
  - `CONFIG_DEVTMPFS_MOUNT=y` — automonta devtmpfs após rootfs
  - `SYSTEM_TRUSTED_KEYS` desabilitado — sem verificação de assinatura de módulos
  - `SYSTEM_REVOCATION_KEYS` desabilitado — idem
- `make olddefconfig` aplicou os ajustes sem interação
- Validação: initramfs ✅ devtmpfs ✅ 64-bit ✅

---

## ⚙️ Como funciona

O kernel precisa ser configurado antes de compilar. `x86_64_defconfig` aplica defaults razoáveis para x86-64. Os ajustes adicionais garantem que o kernel saiba carregar o initramfs (sistema de arquivos em RAM), monte `/dev` automaticamente via devtmpfs, e não trave esperando por assinaturas de módulos que não existem no ambiente de desenvolvimento.

O `detached HEAD` que aparece no output é esperado — clonamos direto na tag `v6.6.87`, não em uma branch. Não afeta a compilação.

**Importante:** o kernel ainda não foi compilado. O patch `aluno-2311292.patch` deve ser aplicado antes da compilação.

---

## 📋 O que falta

- [ ] TASK-04 — Patch `aluno-2311292.patch` aplicado
- [ ] TASK-05 — `bzImage` compilado (~15–40 min)
- [ ] TASK-06 — Estrutura do initramfs montada
- [ ] TASK-07 — `sysinfo_call.c` compilado estático
- [ ] TASK-08 — `initramfs.cpio.gz` empacotado
- [ ] TASK-09 — Boot no QEMU + resposta coletada
- [ ] TASK-10 — README final + `docs/architecture.md`

---

## 🔗 Artefatos desta TASK

| Arquivo | Tipo | Descrição |
|---------|------|-----------|
| `scripts/build-kernel.sh` | criado | Clona, configura e valida o kernel |
| `README.md` | modificado | Status "Kernel 6.6.87 configurado" → ✅ |
| `docs/log-task03.md` | criado | Este arquivo |
