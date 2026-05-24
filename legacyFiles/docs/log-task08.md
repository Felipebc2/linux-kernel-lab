# Log — TASK-08: initramfs.cpio.gz empacotado

> Gerado em: 2026-05-24

---

## ✅ O que foi feito

- `bash scripts/build-initramfs.sh` executado com sucesso
- Estrutura completa montada em `initramfs/`: BusyBox + `sysinfo_call` + `init`
- `initramfs.cpio.gz` gerado: 1,6 MB
- Validado: binário `sysinfo_call` é ELF 64-bit statically linked

---

## ⚙️ Como funciona

O `cpio` (copy-in/copy-out) é o formato de arquivo usado pelo kernel para initramfs. O comando `find . | cpio -H newc -o | gzip -9` lista todos os arquivos do diretório, os empacota no formato `newc` (new ASCII with CRC) e comprime com gzip. O kernel descomprime e extrai esse arquivo durante o boot, recriando o filesystem em RAM. O formato `newc` é o único suportado pelo kernel Linux para initramfs embutido ou passado via `-initrd`.

---

## 📋 O que falta

- [ ] TASK-09 — Boot no QEMU + resposta coletada
- [ ] TASK-10 — README final + `docs/architecture.md`

---

## 🔗 Artefatos desta TASK

| Arquivo | Tipo | Descrição |
|---------|------|-----------|
| `initramfs.cpio.gz` | gerado (não commitado) | Filesystem em RAM, 1,6 MB |
| `docs/log-task08.md` | criado | Este arquivo |
