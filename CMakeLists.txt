cmake_minimum_required(VERSION 3.7.2)

project(pybricks_ev3_ffi_demo)

MESSAGE(STATUS "Using toolchain file: ${CMAKE_TOOLCHAIN_FILE}")
MESSAGE(STATUS "Binary dir: ${CMAKE_BINARY_DIR}")

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

add_executable(hello_world helloworld.c)
add_library(fib SHARED fib.c)

# Link statically to avoid depending on version of libraries
# that may not be present on the EV3. If we were compiling
# using the EV3 stretch docker image, this would not be
# needed. However, the docker image that exists only exists
# for AMD64, and can't be rebuilt, since the debian stretch
# archives have gone away. Additionally, I'm trying to run
# this build on my Raspberry Pi, which is an ARM machine,
# which means that the docker image can't run.
#
# Therefore, we're accepting the need to link statically,
# which is probably a bit safer anyway.
target_link_libraries(hello_world -static)
target_link_libraries(fib -static)