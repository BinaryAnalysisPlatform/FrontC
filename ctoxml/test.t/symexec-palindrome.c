#include <stdio.h>
#include <string.h>

int main(void) {
    char buf[8];
    if (fgets(buf, sizeof(buf), stdin)) {
        int i;
        int n = strlen(buf)-1;
        for (i = 0; n > 2 && i <= n/2 && buf[i] == buf[n-i-1];i++);
        if (i > n/2) {
            puts("access granted!");
        }
    }
}
