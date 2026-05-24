# Log — TASK-04: Patch do aluno aplicado

## O que foi feito

- Aplicado `patch/patch-2311292.patch` no kernel com `git apply`
- Arquivo modificado: `kernel/sys.c` (+32 linhas, função `do_sysinfo`)

**Output de validação:**
```
kernel/sys.c | 32 insertions(+)
```

## Como funciona

O patch injeta código no início de `do_sysinfo()` em `kernel/sys.c`.
A lógica é:

1. Lê 4 bytes da string de versão do kernel (`uts->release`):
   - `b0 = release[0]` → '6' (54)
   - `b1 = release[2]` → '6' (54)
   - `b2 = release[5]` → '3' (51) — depende de LOCALVERSION
   - `b3 = release[6]` → '7' (55) — depende de LOCALVERSION

2. Verifica se `b0 × b1 × b2 × b3 == 037147264` (octal):
   - Com versão `6.6.837`: 54 × 54 × 51 × 55 = 8.179.380 = 037147264 ✅

3. Se a condição passa, executa assembly inline que calcula `so_out`

4. Sempre executa: `printk("[+] SOLUCAO: %llX\n", so_out)`

**Por que LOCALVERSION="37" é obrigatório:**
Sem ele, as posições 5 e 6 da string de versão seriam diferentes,
o produto não bateria com 037147264, e `so_out = -1 = 0xFFFFFFFFFFFFFFFF`.

## O que falta

- [ ] TASK-05 — bzImage compilado (com patch aplicado)
- [ ] TASK-06 — initramfs montado
- [ ] TASK-07 — sysinfo_call.c compilado estático
- [ ] TASK-08 — initramfs.cpio.gz empacotado
- [ ] TASK-09 — Boot QEMU + resposta coletada
- [ ] TASK-10 — README final + docs

## Artefatos desta TASK

| Arquivo | Descrição |
|---------|-----------|
| `patch/patch-2311292.patch` | Patch do professor (referência, ignorado pelo git) |
| `linux-stable/kernel/sys.c` | Modificado pelo patch (ignorado pelo git) |
