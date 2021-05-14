#include <stdio.h>

unsigned int crc32(unsigned char *message) {
    int i, j;
    unsigned int byte, crc, mask;

    i = 0;
    crc = 0xFFFFFFFF;
    while (message[i] != 0) {
        byte = message[i];
        crc = crc ^ byte;
        for (j = 7; j >= 0; j--) {
            mask = -(crc & 1);
            crc = (crc >> 1) ^ (0xEDB88320 & mask);
        }
        i = i + 1;
    }
    return ~crc;
}

int main(void) {
    char buf1[16];
    char buf2[16];
    if (fgets(buf1,sizeof(buf1),stdin) && fgets(buf2,sizeof(buf2),stdin)) {
        if (crc32(buf1) == crc32(buf2)) {
            puts("access granted");
        }
    }
}
