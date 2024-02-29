#! /bin/bash
#
# This demo shows the built binary being run on the ev3.

set -e

. common.sh

# Note that cmake and make are running with the $BUILD_DIR working directory in the container.
armel_cmake build ..
armel_make all

scp "$BUILD_LOCAL/bin/hello_world" "${EV3_USER}@${EV3_ADDRESS}:/home/${EV3_USER}/hello_world"
ssh -t "${EV3_USER}@${EV3_ADDRESS}" "chmod +x ~/hello_world && ~/hello_world && rm ~/hello_world"
