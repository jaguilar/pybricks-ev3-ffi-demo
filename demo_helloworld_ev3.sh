#! /bin/bash
#
# This demo shows the built binary being run on the ev3.

set -e

. common.sh

cmake --build .
runc make VERBOSE=1 all
scp ./bin/hello_world "${EV3_USER}@${EV3_ADDRESS}:/home/${EV3_USER}/hello_world"
ssh -t "${EV3_USER}@${EV3_ADDRESS}" "chmod +x ~/hello_world && ~/hello_world"
