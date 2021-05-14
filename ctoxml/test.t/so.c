
static void foo(int a);
extern void bar(int a);

static void foo(int a) {
    bar(a);
}

extern void bar(int a) {
    foo(a);
}
