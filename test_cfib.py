#! /usr/bin/env pybricks-micropython

from pybricks.tools import StopWatch

import ffi

libfib = ffi.open("./libfib.so")  # Note: use "./" otherwise it will search the library path and find nothing.
fib = libfib.func("l", "fib", "l")

sw = StopWatch()
sum = 0
for _ in range(10):
    for i in range(10):
        sum += fib(i)
print(sw.time())
print(sum)
