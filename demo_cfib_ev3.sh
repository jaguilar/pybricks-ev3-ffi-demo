#! /bin/bash

. common.sh

armel_cmake -DCMAKE_BUILD_TYPE=Release build ..
armel_make fib
echo $(pwd)
ssh -t "${EV3_USER}@${EV3_ADDRESS}" "mkdir ~/cfib"
scp $BUILD_LOCAL/lib/libfib.so test_cfib.py "${EV3_USER}@${EV3_ADDRESS}:/home/${EV3_USER}/cfib"
ssh -t "${EV3_USER}@${EV3_ADDRESS}" "cd cfib && chmod +x test_cfib.py && brickrun -- ./test_cfib.py"