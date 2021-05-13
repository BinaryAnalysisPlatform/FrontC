typedef struct {
    long long foo __attribute__((__aligned__(__alignof__(long long))));
} max_align_t;
