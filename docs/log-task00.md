# Log — TASK-00: Bootstrap

> Gerado em: 2026-05-21

---

## ✅ O que foi feito

- Criada estrutura de diretórios em `/home/felipebc2/repo/kernel/so-t01/`:
  - `scripts/` — scripts de build
  - `docs/` — logs e documentação técnica
  - `initramfs/dev/` — estrutura base do sistema de arquivos RAM
- Criado `.gitignore` excluindo: `linux-stable/`, `busybox/`, `so-2025-02-t-01/`, binários gerados e patches
- Criado `README.md` com arquitetura do projeto, estrutura de diretórios, instruções de reprodução e tabela de status

---

## ⚙️ Como funciona

O repositório é o ponto central do projeto. Ele não contém os fontes de terceiros (kernel, BusyBox) nem artefatos binários — apenas os scripts de automação, o programa `sysinfo_call.c` e a documentação. Isso mantém o repositório leve e focado no que o aluno produziu. O `.gitignore` exclui os ~2 GB de código-fonte do kernel e os binários gerados pelo build.

---

## 📋 O que falta

- [ ] TASK-01 — Dependências do sistema (falta `pahole`)
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
| `.gitignore` | criado | Exclui fontes de terceiros e binários |
| `README.md` | criado | Documentação principal do projeto |
| `scripts/` | criado | Diretório dos scripts de build |
| `docs/` | criado | Diretório de logs e documentação |
| `initramfs/dev/` | criado | Estrutura base do initramfs |
| `docs/log-task00.md` | criado | Este arquivo |
