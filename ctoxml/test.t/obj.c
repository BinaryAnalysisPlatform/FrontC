int sum_internal_1(int a, int b) {
    return a + b;
}

int sum_internal_3(int a, int b);

int sum_internal_2(int a, int b) {
    int c = sum_internal_3(a, 42);
    return sum_internal_1(a, b) + c;
}

extern int sum_external(int a, int b);

int sum_internal_3(int a, int b) {
    if (a > b) {
        int c = a + b;
        return sum_internal_1(c, b);
    } else
        if (a < b)
            return sum_external(a, b);
        else return sum_internal_2(a, b);
}
