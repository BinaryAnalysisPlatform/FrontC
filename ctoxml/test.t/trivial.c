#include <stdio.h>
#include <stdlib.h>

int main(int argc, const char *argv[]) {
    int i;
    for (i = 0; i < argc; i++) {
        puts(argv[i]);
    }
    abort();
}
