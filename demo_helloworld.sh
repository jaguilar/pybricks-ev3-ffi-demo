#! /bin/bash
#
# This program demonstrates building and running a hello, world binary
# on the docker container.

. ./common.sh

cmake --build .
runc make all
runc "/src/$BUILD_DIR/bin/hello_world"