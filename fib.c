// A naive implementation of the fibonacci sequence, to compare with python's.
#include <stdint.h>

int32_t fibonacci(int32_t n) {
  if (n == 0) return 0;
  if (n == 1) return 1;
  return fibonacci(n - 1) + fibonacci(n - 2);
}
