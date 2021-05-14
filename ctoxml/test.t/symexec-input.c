#include <stdio.h>
#include <unistd.h>
#include <string.h>

int main(void) {
    char buf[16];
    FILE *input;
    (input = fopen("passwd", "r"))   &&
    fgets(buf, sizeof(buf), input)   &&
    strncmp(buf, "backdoor", 8) == 0 &&
    puts("access granted");
}
