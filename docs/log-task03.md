# Log — TASK-03: Kernel 6.6.87 clonado e configurado

## O que foi feito

- Clonado `git://git.kernel.org/.../linux-stable.git` com `--depth 1 --branch v6.6.87`
- Commit verificado: `814637ca257f4faf57a73fd4e38888cce88b5911` (tag `v6.6.87`)
- Rodado `make x86_64_defconfig` para gerar configuração base
- Configurações aplicadas via `scripts/config`:

| Config | Valor | Motivo |
|--------|-------|--------|
| `CONFIG_BLK_DEV_INITRD` | `y` | suporte a initramfs (PDF §2.4) |
| `CONFIG_64BIT` | `y` | kernel 64-bit (PDF §2.4) |
| `CONFIG_DEVTMPFS` | `y` | monta /dev automaticamente (PDF §2.4) |
| `CONFIG_DEVTMPFS_MOUNT` | `y` | automonta após rootfs (PDF §2.4) |
| `SYSTEM_TRUSTED_KEYS` | desabilitado | sem verificação de assinatura (PDF §2.4.1) |
| `SYSTEM_REVOCATION_KEYS` | desabilitado | idem |
| `CONFIG_LOCALVERSION` | `"37"` | **CRÍTICO**: versão final = `6.6.837` |
| `CONFIG_LOCALVERSION_AUTO` | `not set` | **CRÍTICO**: impede git de adicionar sufixo |

**Validação:**
```
CONFIG_BLK_DEV_INITRD=y       ✅
CONFIG_DEVTMPFS=y              ✅
CONFIG_LOCALVERSION="37"       ✅
# CONFIG_LOCALVERSION_AUTO is not set  ✅
```

## Como funciona

O kernel é configurado antes de compilar. O `make x86_64_defconfig` gera um `.config`
base adequado para x86-64. Em seguida, `scripts/config` ajusta opções específicas
sem precisar de interface interativa (`make menuconfig`).

**Por que `CONFIG_LOCALVERSION="37"` é crítico:**
O patch do aluno lê `uts->release[5]` e `uts->release[6]` para calcular a resposta.
Com `LOCALVERSION="37"`, a versão final é `6.6.837`:
- `release[5] = '3'` (0x33)
- `release[6] = '7'` (0x37)

Esses valores são necessários para o assembly do patch produzir a resposta correta.
`LOCALVERSION_AUTO=n` impede que o git adicione sufixos (ex: `+`, hash) que corromperiam
as posições 5 e 6.

## O que falta

- [ ] TASK-04 — Patch do aluno aplicado
- [ ] TASK-05 — bzImage compilado
- [ ] TASK-06 — initramfs montado
- [ ] TASK-07 — sysinfo_call.c compilado estático
- [ ] TASK-08 — initramfs.cpio.gz empacotado
- [ ] TASK-09 — Boot QEMU + resposta coletada
- [ ] TASK-10 — README final + docs

## Artefatos desta TASK

| Arquivo | Descrição |
|---------|-----------|
| `scripts/build-kernel.sh` | Script de clone, config e build (com flag `--compile`) |
| `linux-stable/` | Código-fonte do kernel (ignorado pelo git) |
| `linux-stable/.config` | Configuração gerada (ignorada pelo git) |
