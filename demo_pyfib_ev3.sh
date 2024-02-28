#! /bin/bash

. common.sh

ssh -t "${EV3_USER}@${EV3_ADDRESS}" "mkdir ~/pyfib"
scp fib.py test_pyfib.py "${EV3_USER}@${EV3_ADDRESS}:/home/${EV3_USER}/pyfib"
ssh -t "${EV3_USER}@${EV3_ADDRESS}" "cd pyfib && chmod +x test_pyfib.py && brickrun -- ./test_pyfib.py && cd .. && rm -rf ~/pyfib"