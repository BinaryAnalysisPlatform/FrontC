struct Scope {
    // Anonymous union
    union {
        char alpha;
        int num;
    };
};

struct Scope2
{
    // Anonymous structure
    struct
    {
        char alpha;
        int num;
    };
};
