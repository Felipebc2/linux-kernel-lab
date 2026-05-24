# Log — TASK-01: Dependências do sistema

> Gerado em: 2026-05-21

---

## ✅ O que foi feito

- Criado `scripts/setup.sh` com instalação de todas as dependências via `apt-get`
- Executado o script — todas as dependências validadas:
  - `qemu-system-x86_64` — já instalado
  - `gcc`, `make`, `cpio` — já instalados
  - `pahole v1.25` — instalado nesta etapa (necessário para debug info do kernel)
  - `libssl-dev`, `libelf-dev`, `libncurses-dev`, `bison`, `flex` — instalados

---

## ⚙️ Como funciona

O kernel Linux 6.6 exige um conjunto específico de ferramentas para compilar:
- `bison`/`flex` — parsers usados pelo sistema de build do kernel
- `libssl-dev` — para assinar módulos do kernel
- `libelf-dev` — manipulação de arquivos ELF (formato dos binários Linux)
- `pahole` — analisa struct layouts para BTF (BPF Type Format), necessário desde o kernel 5.2+
- `cpio` — empacota o initramfs no formato que o kernel entende

---

## 📋 O que falta

- [ ] TASK-02 — BusyBox 1.36.1 compilado estático
- [ ] TASK-03 — Kernel 6.6.87 clonado e configurado
- [ ] TASK-04 — Patch `aluno-2311292.patch` aplicado
- [ ] TASK-05 — `bzImage` compilado
- [ ] TASK-06 — Estrutura do initramfs montada
- [ ] TASK-07 — `sysinfo_call.c` compilado estático
- [ ] TASK-08 — `initramfs.cpio.gz` empacotado
- [ ] TASK-09 — Boot no QEMU + resposta coletada
- [ ] TASK-10 — README final + `docs/architecture.md`

---

## 🔗 Artefatos desta TASK

| Arquivo | Tipo | Descrição |
|---------|------|-----------|
| `scripts/setup.sh` | criado | Instala todas as dependências de build |
| `README.md` | modificado | Status "Ambiente e dependências" → ✅ |
| `docs/log-task01.md` | criado | Este arquivo |
