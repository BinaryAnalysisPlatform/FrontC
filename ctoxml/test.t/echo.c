#include <stdio.h>
#include <stdlib.h>
#include <string.h>

const char *strv[] = {
    "Now we will print some random stuff.",
    "Be not afraid of greatness:",
    "some are born great, some achieve greatness",
    "and some have greatness thrust upon them",
    "To thine own self be true, and it must follow",
    "as the night the day, thou canst not",
    "then be false to any man",
    "The course of true love never did run smooth"
};

void print_endline(const char *msg) {
    char *p = msg;
    while (*p) putchar(*p++);
    putchar('\n');
}


void print_strings(const char **strings) {
    const char **p;
    for (p = strings; *p; p++) {
        print_endline(*p);
    }
}

int main(int argc, const char **argv) {
    int i,j;
    const int strc = sizeof(strv) / sizeof(*strv);
    const int size = argc + strc + 1;
    char *strings[size];

    for (i = 0; i < argc; i++) {
        strings[i] = strcpy(malloc(strlen(argv[i]) + 1), argv[i]);
    }

    for (j = 0; j < strc; j++, i++) {
        char *b = strchr(strv[j], ' ') + 1;
        char *e = strchr(b, ' ');
        int size = e-b+1;
        char *dst = malloc(size);
        memmove(dst, b, size);
        dst[size-1] = NULL;
        strings[i] = dst;
    }

    strings[size-1] = NULL;

    print_strings(strings);

    for (i = 0; i < size; i++) {
        free(strings[i]);
    }
    return 0;
}
