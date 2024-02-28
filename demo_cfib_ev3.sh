#! /bin/bash

. common.sh

container_cmake --configure ..
container_make fib

ssh -t "${EV3_USER}@${EV3_ADDRESS}" "mkdir ~/cfib"
scp $BUILD_LOCAL/lib/libfib.so test_cfib.py "${EV3_USER}@${EV3_ADDRESS}:/home/${EV3_USER}/cfib"
ssh -t "${EV3_USER}@${EV3_ADDRESS}" "cd cfib && chmod +x test_cfib.py && brickrun -- ./test_cfib.py"