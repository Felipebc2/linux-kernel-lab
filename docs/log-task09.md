# Log — TASK-09: Boot QEMU + resposta coletada

## O que foi feito

- Executado `bash scripts/run-qemu.sh`
- Sistema bootou com sucesso em 1.67 segundos
- Dentro do QEMU, rodado `/bin/sysinfo_call`
- Resposta coletada via `dmesg | grep SOLUCAO`
- Resposta submetida e **aceita no Moodle**

**Output de validação:**
```
~ # /bin/sysinfo_call
[sysinfo_call] Invocando syscall sysinfo(2)...
[   43.808294] [+] SOLUCAO: 123D5F799ABCDEF0
[sysinfo_call] OK. Uptime: 44 segundos

~ # dmesg | grep SOLUCAO
[   43.808294] [+] SOLUCAO: 123D5F799ABCDEF0
```

**Resposta final (aceita no Moodle): `123D5F799ABCDEF0`**

## Como funciona

O fluxo completo da syscall modificada:

1. `/bin/sysinfo_call` executa `sysinfo(&info)` → instrução `syscall` com `rax=99`
2. CPU entra em kernel mode via entry point SYSCALL
3. Kernel roteia para `do_sysinfo()` em `kernel/sys.c` (modificado pelo patch)
4. Patch verifica `uts->release` — com versão `6.6.837+`:
   - `release[0]='6'`, `release[2]='6'`, `release[5]='3'`, `release[6]='7'`
   - Produto: 54 × 54 × 51 × 55 = 8.179.380 = 037147264 ✅
5. Assembly inline calcula `so_out = 0x123D5F799ABCDEF0`
6. `printk("[+] SOLUCAO: %llX\n", so_out)` escreve no kernel ring buffer
7. `dmesg | grep SOLUCAO` exibe a resposta

## O que falta

- [ ] TASK-10 — README final + docs (polish do portfólio)

## Artefatos desta TASK

| Arquivo | Descrição |
|---------|-----------|
| `scripts/run-qemu.sh` | Script para iniciar o QEMU |
