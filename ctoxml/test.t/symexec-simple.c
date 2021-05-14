#include <stdio.h>
#include <unistd.h>
#include <string.h>

int main(void) {
    char buf[16];
    int bytes_read = read(0, buf, sizeof(buf) - 1);
    if (bytes_read != -1) {
        buf[bytes_read] = 0;
        if (strcmp(buf, "backdoor") == 0) {
            puts("access granted!");
        }
    }
}
