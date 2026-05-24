# Linux Kernel Syscall — T01 Sistemas Operacionais

> Compilação de um Kernel Linux 6.6.87 customizado, montagem de initramfs com BusyBox e execução
> de syscall modificada via patch. Projeto prático da disciplina de Sistemas Operacionais — IDP 2025/2.

## Objetivo

Compilar e bootar um kernel Linux modificado por um patch personalizado dentro do QEMU,
executar um programa C estático que invoca a syscall `sysinfo`, e capturar a string
injetada pelo patch no kernel ring buffer via `dmesg`.

## Arquitetura

```
┌─────────────────────────────────────┐
│           QEMU (x86-64)             │
│  ┌───────────────────────────────┐  │
│  │  initramfs (BusyBox + init)   │  │
│  │  ┌─────────────────────────┐  │  │
│  │  │  sysinfo_call (C static)│  │  │
│  │  │  syscall 99 → kernel    │  │  │
│  │  └──────────┬──────────────┘  │  │
│  └─────────────┼─────────────────┘  │
│                ▼                    │
│  ┌─────────────────────────────────┐│
│  │  Kernel 6.6.87 + patch aluno    ││
│  │  sysinfo() → printk(secret)     ││
│  │  dmesg → RESPOSTA               ││
│  └─────────────────────────────────┘│
└─────────────────────────────────────┘
```

## Estrutura do Repositório

```
.
├── sysinfo_call.c          # Programa userspace que invoca sysinfo(2)
├── initramfs/
│   └── init                # Script de boot do sistema mínimo
├── scripts/
│   ├── setup.sh            # Instala dependências do sistema
│   ├── build-busybox.sh    # Compila BusyBox 1.36.1 estático
│   ├── build-kernel.sh     # Configura e compila o kernel
│   ├── build-initramfs.sh  # Monta e empacota o initramfs
│   └── run-qemu.sh         # Inicia o QEMU com kernel + initramfs
├── docs/
│   └── architecture.md     # Notas técnicas e aprendizados
└── README.md
```

## Pré-requisitos

- WSL2 + Ubuntu 24.04 (ou Ubuntu nativo)
- ~10 GB de espaço livre em disco

## Como reproduzir

### 0. Variáveis de ambiente

```bash
export MATRICULA="2311292"
export JOBS=$(nproc)
```

### 1. Dependências
```bash
bash scripts/setup.sh
```

### 2. BusyBox
```bash
bash scripts/build-busybox.sh
```

### 3. Kernel
```bash
bash scripts/build-kernel.sh
```

### 4. initramfs
```bash
bash scripts/build-initramfs.sh
```

### 5. Rodar no QEMU
```bash
bash scripts/run-qemu.sh
```

Dentro do shell:
```sh
/bin/sysinfo_call
dmesg | grep SOLUCAO
```

## Status das Etapas

| Etapa | Status |
|-------|--------|
| Ambiente e dependências | ✅ concluído |
| BusyBox 1.36.1 compilado | ✅ concluído |
| Kernel 6.6.87 configurado | ✅ concluído |
| Patch aplicado | ✅ concluído |
| Kernel compilado | ✅ concluído |
| initramfs montado | ✅ concluído |
| sysinfo_call.c compilado | ✅ concluído |
| Boot no QEMU | ✅ concluído |
| Resposta coletada | ✅ concluído |

## Conceitos Demonstrados

- **Compilação do Kernel Linux** — configuração via `make defconfig`, flags de build, bzImage
- **System calls no x86-64** — número de syscall (99 = sysinfo), convenção de registradores
- **initramfs** — filesystem em RAM, estrutura mínima, BusyBox como userland
- **Kernel ring buffer** — `printk` levels, `dmesg`
- **Linking estático** — por que o binário precisa ser estático num ambiente sem libc
- **QEMU** — emulação de hardware, boot com kernel + initrd customizados

## Referências

- [Linux Kernel Documentation](https://docs.kernel.org/)
- [BusyBox](https://busybox.net/)
- [man 2 sysinfo](https://man7.org/linux/man-pages/man2/sysinfo.2.html)
- Tanenbaum, A. S. — *Sistemas Operacionais Modernos*, 3ª ed.
- Arpaci-Dusseau — *Operating Systems: Three Easy Pieces*
