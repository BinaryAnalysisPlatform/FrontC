#include <stdio.h>


int main(void) {
    while (1) {
        int c = getchar();
        if (c == 'A') {
            puts("access granted");
            return 0;
        }
        if (c <= 0) {
            return 1;
        }
        if (c == '\n') {
            continue;
        }
    }
}
