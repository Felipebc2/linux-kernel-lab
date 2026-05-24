# Log — TASK-07: sysinfo_call.c compilado

## O que foi feito

- Criado `sysinfo_call.c` — programa C que invoca `sysinfo(2)`
- Compilado com `gcc -static -O2 -o sysinfo_call sysinfo_call.c`

**Output de validação:**
```
sysinfo_call: ELF 64-bit LSB executable, x86-64, version 1 (GNU/Linux),
  statically linked, BuildID[sha1]=6316af77ed89c97d11f7a58aa0a8dfd109900377,
  for GNU/Linux 3.2.0, not stripped
```

## Como funciona

`sysinfo(2)` é uma syscall Linux (número 99 no x86-64) que retorna informações
sobre o sistema — uptime, memória livre, carga do processador, etc.

O patch do T01 modifica a implementação de `sysinfo` no kernel (`kernel/sys.c`,
função `do_sysinfo`): antes de executar a lógica original, injeta um `printk()`
que escreve a string `[+] SOLUCAO: %llX` no kernel ring buffer.

**Por que compilar estático (`-static`)?**
O initramfs mínimo com BusyBox não possui bibliotecas dinâmicas (`.so`). Um binário
dinâmico dependeria de `ld-linux.so` e `libc.so.6` — que não existem. Com `-static`,
todo o código necessário é incluído no executável, tornando-o autossuficiente.

**Fluxo:**
```
/bin/sysinfo_call  →  syscall rax=99  →  do_sysinfo() no kernel
                                          ↓
                                    printk("[+] SOLUCAO: %llX")
                                          ↓
                                    kernel ring buffer
                                          ↓
                               dmesg | grep SOLUCAO  →  RESPOSTA
```

## O que falta

- [ ] TASK-08 — initramfs.cpio.gz empacotado (executar build-initramfs.sh)
- [ ] TASK-09 — Boot QEMU + resposta coletada
- [ ] TASK-10 — README final + docs

## Artefatos desta TASK

| Arquivo | Descrição |
|---------|-----------|
| `sysinfo_call.c` | Código-fonte do programa userspace |
| `sysinfo_call` | Binário ELF 64-bit estático (ignorado pelo git) |
