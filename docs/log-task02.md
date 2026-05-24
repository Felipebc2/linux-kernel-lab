# Log — TASK-02: BusyBox 1.36.1 compilado

## O que foi feito

- Clonado `https://github.com/mirror/busybox.git` em `busybox/`
- Alternado para tag `1_36_1` (commit `1a64f6a20aaf6ea4dbba68bbfa8cc1ab7e5c57c4`)
- Rodado `make defconfig` para gerar `.config` base
- Desabilitado `CONFIG_TC` via sed (ferramenta `tc` incompatível com kernel 6.6)
- Habilitado `CONFIG_STATIC` via sed (binary estático, sem dependência de libc)
- Compilado com `make -j$(nproc)` e instalado com `make install`

**Output de validação:**
```
/home/felipebc2/repo/kernel/so-t01/busybox/busybox:
  ELF 64-bit LSB executable, x86-64, statically linked
```

**Nota:** `scripts/config` não existe no BusyBox (é ferramenta do kernel Linux).
Usar `sed -i` diretamente no `.config` é a forma correta para BusyBox.

## Como funciona

O BusyBox combina centenas de utilitários Unix (`sh`, `ls`, `mount`, `grep`, etc.)
em um único executável estático. Cada ferramenta é acessada via symlink apontando
para o binário principal.

Compilado com `CONFIG_STATIC=y`, o binário inclui toda a libc internamente — essencial
para rodar no initramfs, que não possui bibliotecas dinâmicas disponíveis.

O `_install/` gerado pelo `make install` contém a estrutura de diretórios pronta
(`bin/`, `sbin/`, `usr/`) que será copiada para o initramfs na TASK-06.

## O que falta

- [ ] TASK-03 — Kernel 6.6.87 clonado e configurado
- [ ] TASK-04 — Patch do aluno aplicado
- [ ] TASK-05 — bzImage compilado (com `CONFIG_LOCALVERSION="37"` e `AUTO=n`)
- [ ] TASK-06 — initramfs montado
- [ ] TASK-07 — sysinfo_call.c compilado estático
- [ ] TASK-08 — initramfs.cpio.gz empacotado
- [ ] TASK-09 — Boot QEMU + resposta coletada
- [ ] TASK-10 — README final + docs

## Artefatos desta TASK

| Arquivo | Descrição |
|---------|-----------|
| `scripts/build-busybox.sh` | Script de clone, config e build |
| `busybox/busybox` | Executável compilado (ignorado pelo git) |
| `busybox/_install/` | Binários instalados (ignorado pelo git) |
