#! /usr/bin/env pybricks-micropython

from pybricks.tools import StopWatch

import fib

sw = StopWatch()
sum = 0
for _ in range(10):
    for i in range(10):
        sum += fib.fib(i)
print(sw.time())
print(sum)