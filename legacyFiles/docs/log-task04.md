# Log — TASK-04: Patch do aluno aplicado ao kernel

> Gerado em: 2026-05-24

---

## ✅ O que foi feito

- Professor disponibilizou `patch-2311292.patch` (arquivo específico para matrícula 2311292)
- Arquivo colocado em `patch/patch-2311292.patch` dentro do repositório
- `scripts/apply-patch.sh` reescrito para buscar o patch localmente em `patch/patch-${MATRICULA}.patch`
- Patch aplicado com `git apply` em `linux-stable/`
- Arquivo modificado pelo patch: `kernel/sys.c` (32 linhas inseridas em `do_sysinfo`)

---

## ⚙️ Como funciona

O patch modifica a função `do_sysinfo()` em `kernel/sys.c`, que é o handler interno da syscall `sysinfo` (número 99 no x86-64). A modificação lê caracteres da string de versão do kernel (`utsname()->release`) e executa um bloco de assembly inline com bytes obfuscados, calculando um valor que é então impresso no kernel ring buffer via `printk("[+] SOLUCAO: %llX\n", so_out)`. A saída só aparece no `dmesg` — não no console, pois `loglevel=3` suprime mensagens de nível < KERN_CRIT.

---

## 📋 O que falta

- [ ] TASK-05 — `bzImage` compilado com o patch
- [ ] TASK-06 — Estrutura do initramfs montada
- [ ] TASK-07 — `sysinfo_call.c` compilado estático
- [ ] TASK-08 — `initramfs.cpio.gz` empacotado
- [ ] TASK-09 — Boot no QEMU + resposta coletada
- [ ] TASK-10 — README final + `docs/architecture.md`

---

## 🔗 Artefatos desta TASK

| Arquivo | Tipo | Descrição |
|---------|------|-----------|
| `patch/patch-2311292.patch` | criado | Patch personalizado recebido do professor |
| `scripts/apply-patch.sh` | modificado | Adaptado para patch local em `patch/` |
| `docs/log-task04.md` | criado | Este arquivo |
