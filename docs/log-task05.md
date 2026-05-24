# Log — TASK-05: bzImage compilado

## O que foi feito

- Rodado `bash scripts/build-kernel.sh --compile` dentro de `linux-stable/`
- Compilação com `make -j$(nproc) bzImage` (build #2)
- Versão embutida verificada via `strings arch/x86/boot/bzImage | grep "^6\." | head -1`

**Output de validação:**
```
6.6.837+ (felipebc2@Nebula) #2 SMP PREEMPT_DYNAMIC Sun May 24 14:01:46 -03 2026

arch/x86/boot/bzImage: Linux kernel x86 boot executable bzImage,
  version 6.6.837+ (felipebc2@Nebula) #2 SMP PREEMPT_DYNAMIC Sun May 24 14:01:46 -03 2026,
  RO-rootFS, swap_dev 0XC, Normal VGA
```

**Correção aplicada nesta TASK:**
- `linux-stable/Makefile`: `SUBLEVEL = 87` → `SUBLEVEL = 8`
- Sem essa correção a versão seria `6.6.8737`, não `6.6.837`

**Por que a versão termina em `+`:**
O script `scripts/setlocalversion` detecta que o repositório `linux-stable` tem
arquivos modificados sem commit (o patch foi aplicado via `git apply`) e adiciona
o sufixo `+`. O `+` fica em `release[7]` — o patch só verifica `release[5]` e
`release[6]`, então não afeta o cálculo.

## Como funciona

O `bzImage` é o kernel comprimido no formato de boot x86. O processo:

1. `make x86_64_defconfig` gera `.config` base para x86-64
2. Configs críticas ajustadas via `scripts/config` (LOCALVERSION, initramfs, devtmpfs)
3. `make bzImage` compila o kernel completo e empacota em formato auto-extraível
4. O QEMU carrega o `bzImage` diretamente via `-kernel` — sem bootloader

A versão `6.6.837` é composta por:
- `VERSION=6`, `PATCHLEVEL=6`, `SUBLEVEL=8` → base `6.6.8`
- `CONFIG_LOCALVERSION="37"` → sufixo → `6.6.8` + `37` = `6.6.837`

## O que falta

- [ ] TASK-06 — initramfs montado (estrutura de diretórios + script init)
- [ ] TASK-07 — sysinfo_call.c compilado estático
- [ ] TASK-08 — initramfs.cpio.gz empacotado
- [ ] TASK-09 — Boot QEMU + resposta coletada
- [ ] TASK-10 — README final + docs

## Artefatos desta TASK

| Arquivo | Descrição |
|---------|-----------|
| `linux-stable/Makefile` | Corrigido: `SUBLEVEL = 8` (era 87) |
| `linux-stable/arch/x86/boot/bzImage` | Kernel compilado, versão `6.6.837+` |
