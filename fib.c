// A naive implementation of the fibonacci sequence, to compare with python's.
#include <stdint.h>

extern int32_t fib(int32_t n) {
  if (n == 0) return 0;
  if (n == 1) return 1;
  return fib(n - 1) + fib(n - 2);
}
