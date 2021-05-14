struct point {
  int    x;
  int    y;
};

struct point3d {
  int    x;
  int    y;
  int    z;
};

int main() {
  struct point p = { .y = 2, .x = 1 };
  struct point3d p2 = { .z = 2, .x = 1, 5 }; // mixing both styles
}
