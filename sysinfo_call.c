/*
 * sysinfo_call.c
 *
 * Invoca a syscall sysinfo(2) no kernel modificado pelo patch do T01.
 * O patch injeta printk() na implementação da syscall, que escreve
 * uma string no kernel ring buffer — visível via dmesg.
 *
 * Compilado estaticamente para rodar em initramfs sem libc disponível.
 *
 * Syscall sysinfo no x86-64: número 99
 * Registrador rax = 99 (número da syscall)
 * Registrador rdi = ponteiro para struct sysinfo
 */

#include <sys/sysinfo.h>
#include <stdio.h>

int main(void) {
    struct sysinfo info;

    printf("[sysinfo_call] Invocando syscall sysinfo(2)...\n");

    if (sysinfo(&info) != 0) {
        printf("[sysinfo_call] ERRO: sysinfo() retornou erro.\n");
        return 1;
    }

    printf("[sysinfo_call] OK. Uptime: %ld segundos\n", info.uptime);
    printf("[sysinfo_call] Confira a saida do patch com: dmesg | grep SOLUCAO\n");

    return 0;
}
