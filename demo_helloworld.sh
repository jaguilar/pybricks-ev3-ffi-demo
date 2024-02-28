#! /bin/bash
#
# This program demonstrates building and running a hello, world binary
# on the docker container.

. common.sh

container_cmake --configure ..
container_make all
docker exec --tty "${CONTAINER_NAME}" $BUILD_DIR/bin/hello_world