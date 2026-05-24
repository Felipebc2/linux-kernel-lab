# Notas Técnicas — T01 Sistemas Operacionais

## Fluxo completo da syscall modificada

```
Userspace                    Kernel (6.6.837+)
─────────────────────────────────────────────────────────
/bin/sysinfo_call
  │
  ├─ sysinfo(&info)
  │    │  rax = 99 (NR_sysinfo)
  │    │  rdi = &info
  │    └─ instrução SYSCALL
  │                           do_sysinfo() em kernel/sys.c
  │                             │
  │                             ├─ [PATCH] verifica release[0,2,5,6]
  │                             ├─ [PATCH] assembly calcula so_out
  │                             ├─ [PATCH] printk("[+] SOLUCAO: %llX")
  │                             │            └─ kernel ring buffer
  │                             └─ preenche struct sysinfo
  │
  └─ retorna uptime, memória, etc.

dmesg | grep SOLUCAO  →  lê ring buffer  →  exibe resposta
```

## Por que a versão do kernel importa

O patch do T01 lê `uts->release` para calcular a resposta. A versão
`6.6.837` é construída assim:

| Parâmetro | Valor | Contribuição |
|-----------|-------|-------------|
| `VERSION` | 6 | `release[0]` = '6' |
| `PATCHLEVEL` | 6 | `release[2]` = '6' |
| `SUBLEVEL` | 8 | base `6.6.8` |
| `CONFIG_LOCALVERSION` | "37" | `release[5]`='3', `release[6]`='7' |

O patch verifica: `release[0] × release[2] × release[5] × release[6]`
= 54 × 54 × 51 × 55 = 8.179.380 = `037147264` (octal) ✅

## Por que BusyBox?

Sistemas embarcados e initramfs mínimos usam BusyBox porque ele combina
centenas de utilitários Unix (`sh`, `ls`, `mount`, `grep`, `dmesg`, etc.)
em um único executável estático de ~1MB, via symlinks. Alternativas como
GNU coreutils separadas ocupariam dezenas de MB.

## Por que compilar `sysinfo_call` estático?

O initramfs mínimo não possui bibliotecas dinâmicas (`.so`). Um binário
dinâmico dependeria de `ld-linux.so` e `libc.so.6` — que não existem no
ambiente. Com `gcc -static`, todo o código necessário é incluído no
executável, tornando-o autossuficiente.

## Por que initramfs e não rootfs em disco?

O initramfs (initial RAM filesystem) é carregado pelo bootloader junto
com o kernel e reside inteiramente em RAM. É usado para ambientes de boot
mínimos e exatamente este caso: testar um kernel modificado sem precisar
de imagem de disco completa.

## Configurações críticas do kernel

| Config | Valor | Motivo |
|--------|-------|--------|
| `CONFIG_LOCALVERSION` | `"37"` | versão final = `6.6.837` (posições [5],[6] do patch) |
| `CONFIG_LOCALVERSION_AUTO` | `not set` | impede sufixo git corrompendo a versão |
| `CONFIG_BLK_DEV_INITRD` | `y` | suporte a initramfs |
| `CONFIG_DEVTMPFS` | `y` | monta `/dev` automaticamente |
| `CONFIG_DEVTMPFS_MOUNT` | `y` | automonta devtmpfs após rootfs |
| `SYSTEM_TRUSTED_KEYS` | `""` | desabilita verificação de assinatura de módulos |

## Kernel Ring Buffer e dmesg

O kernel mantém um buffer circular de mensagens chamado *ring buffer*.
`printk()` escreve nesse buffer com diferentes níveis de prioridade
(`KERN_INFO`, `KERN_DEBUG`, etc.). `dmesg` lê e exibe esse buffer —
é a forma padrão de inspecionar mensagens do kernel, incluindo as
injetadas pelo patch na syscall `sysinfo`.
