# Log — TASK-07: sysinfo_call.c escrito e compilado

> Gerado em: 2026-05-24

---

## ✅ O que foi feito

- `sysinfo_call.c` criado: chama `syscall(SYS_sysinfo, &info)` diretamente e imprime uptime
- Compilado estaticamente pelo `build-initramfs.sh` com `gcc -static`
- Binário instalado em `initramfs/bin/sysinfo_call`
- Validado: `ELF 64-bit LSB executable, x86-64, statically linked`

---

## ⚙️ Como funciona

O programa invoca `sysinfo` via `syscall(SYS_sysinfo, &info)` — número 99 no x86-64. Isso dispara o handler `do_sysinfo()` no kernel, que agora inclui o código do patch: o assembly obfuscado calcula um valor a partir dos caracteres da string de versão do kernel e o imprime com `printk("[+] SOLUCAO: %llX\n", so_out)`. O resultado fica no kernel ring buffer e é lido com `dmesg`. O binário é compilado com `-static` porque o initramfs não possui `libc.so` nem `ld-linux.so` — todo o código da biblioteca precisa estar embutido no executável.

---

## 📋 O que falta

- [ ] TASK-08 — `initramfs.cpio.gz` empacotado
- [ ] TASK-09 — Boot no QEMU + resposta coletada
- [ ] TASK-10 — README final + `docs/architecture.md`

---

## 🔗 Artefatos desta TASK

| Arquivo | Tipo | Descrição |
|---------|------|-----------|
| `sysinfo_call.c` | criado | Programa userspace que invoca syscall 99 |
| `initramfs/bin/sysinfo_call` | gerado (não commitado) | Binário estático |
| `docs/log-task07.md` | criado | Este arquivo |
