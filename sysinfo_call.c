#include <sys/syscall.h>
#include <sys/sysinfo.h>
#include <unistd.h>
#include <stdio.h>

int main(void) {
    struct sysinfo info;
    long ret = syscall(SYS_sysinfo, &info);
    if (ret == 0)
        printf("sysinfo: uptime=%ld s, freeram=%lu\n", info.uptime, info.freeram);
    return (int)ret;
}
