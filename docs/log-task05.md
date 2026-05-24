# Log — TASK-05: Kernel 6.6.87 compilado (bzImage)

> Gerado em: 2026-05-24

---

## ✅ O que foi feito

- Kernel compilado com `make -j$(nproc) bzImage` em `linux-stable/`
- Compilação concluída com sucesso: `Kernel: arch/x86/boot/bzImage is ready (#1)`
- Arquivo gerado: `linux-stable/arch/x86/boot/bzImage` — 13 MB

---

## ⚙️ Como funciona

O `bzImage` (big zImage) é o formato comprimido do kernel Linux para x86-64. O processo de build compila todos os arquivos `.c` do kernel (incluindo `kernel/sys.c` já modificado pelo patch) e linka tudo em um único binário comprimido que o QEMU pode carregar diretamente via `-kernel`. O `(#1)` no output indica que é o primeiro build desta configuração. A compilação é paralela via `-j$(nproc)` para usar todos os cores disponíveis.

---

## 📋 O que falta

- [ ] TASK-06 — Estrutura do initramfs montada
- [ ] TASK-07 — `sysinfo_call.c` compilado estático
- [ ] TASK-08 — `initramfs.cpio.gz` empacotado
- [ ] TASK-09 — Boot no QEMU + resposta coletada
- [ ] TASK-10 — README final + `docs/architecture.md`

---

## 🔗 Artefatos desta TASK

| Arquivo | Tipo | Descrição |
|---------|------|-----------|
| `linux-stable/arch/x86/boot/bzImage` | gerado (não commitado) | Kernel compilado, 13 MB |
| `docs/log-task05.md` | criado | Este arquivo |
