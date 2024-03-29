# Pybricks EV3 FFI Demo

This project contains a demo of using Micropython's FFI functionality
on the Lego EV3 system with Pybricks. This example project takes you
through all the steps of getting the `ffi` module working on pybricks
on EV3.

This project is not supported. The current version seems to work fine
on a Raspberry Pi 4 build host connected to an EV3 via bluetooth.

## Requirements

* SSH/SCP
* Python
* `arm-linux-gnueabi-gcc` and `arm-linux-gnueabi-g++` are on `PATH`

## Tour

* `common.sh` contains common functions and definitions used throughout
  the project to build the example code. It also contains hacks for
  working out of WSL, which I did in a previous version of this work.
* `demo_helloworld_ev3.sh` takes the previous example a step further
  and demonstrates the program running on the EV3 brick.
* `demo_pyfib_ev3.sh` demonstrates running some simple Fibonacci sequence 
  calcuations on the EV3 brick in pybricks-micropython.
* `demo_cfib_ev3.sh` demonstrates building, loading, and running Fibonacci
  sequence calculations implemented in C on the EV3 brick, loaded via the
  `ffi` module, in pybricks-micropython.

## Benchmark

On my EV3 brick:

| Implementation  | Time  |
|-----------------|-------|
| Python          | 155ms |
| C               |   6ms |

Given that micropython's Viper code generator is said to be ~4x as fast as plain 
micropython, this suggests that writing in C can give you approximately an 
additional 8x speedup compared to Viper. Probably the exact speedup depends on the
project.

## Next Steps

* C++?
* Optimizer flags?

## Conclusion

I hope this is helpful to anyone who wants to use C to speed up their CPU-intensive
micropython programs. I suspect this would also work for C++ libraries and I may
later enhance this test to show that as well.
