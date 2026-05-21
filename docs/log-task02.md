# Log — TASK-02: BusyBox 1.36.1 compilado estático

> Gerado em: 2026-05-21

---

## ✅ O que foi feito

- Clonado BusyBox do mirror GitHub em `busybox/`, checkout da tag `1_36_1`
- `make defconfig` gerou configuração padrão
- `CONFIG_TC` desabilitado via `sed` no `.config` (incompatível com kernel 6.6)
- `CONFIG_STATIC=y` habilitado via `sed` no `.config`
- `make olddefconfig` aplicou as alterações sem prompts interativos
- Compilado com `make -j$(nproc)`
- Instalado com `make install` → gerou `_install/` com 93 symlinks em `bin/`
- Validado: `file busybox/busybox` → `ELF 64-bit LSB executable, statically linked`

---

## ⚙️ Como funciona

BusyBox combina centenas de utilitários Unix (`sh`, `ls`, `mount`, `dmesg`, `cttyhack`…) em um único executável de ~2 MB. Cada utilitário é um symlink apontando para o binário principal — o BusyBox detecta pelo `argv[0]` qual função executar.

Compilado estaticamente porque o initramfs mínimo não possui `ld-linux.so` nem `libc.so.6`. O binário precisa carregar tudo consigo — daí o `-static`.

`CONFIG_TC` foi desabilitado porque o código de traffic control usa APIs de rede removidas no kernel 6.6, causando erro de compilação. Não afeta o funcionamento do projeto.

---

## 📋 O que falta

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
| `scripts/build-busybox.sh` | criado | Script de build do BusyBox |
| `README.md` | modificado | Status BusyBox → ✅ |
| `docs/log-task02.md` | criado | Este arquivo |
