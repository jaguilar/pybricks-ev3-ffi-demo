#! /bin/bash
#
# This script is designed to be sourced from other scripts in this projects.
# It defines common elements.

if [ -e ./.secrets.sh ]; then
    . .secrets.sh
fi

if [ -z "${GH_TOKEN}" -o -z "${GH_USERNAME}" -o -z "${EV3_ADDRESS}" -o -z "${EV3_USER}" ]; then
    echo "Create a .secrets.sh file exporting the following environment variables: "
    echo "  GH_TOKEN: a personal access token from Github with package:read capability"
    echo "  GH_USERNAME: your github username"
    echo "  EV3_ADDRESS: the address of your EV3 brick"
    echo "  EV3_USER: your username on the EV3 (defaults to \"robot\""
    exit 1
fi

export IMAGE_NAME="ghcr.io/pybricks/pybricks-micropython/pybricks-ev3dev-armel:latest"
export CONTAINER_NAME="ev3build"


# Runs a command inside the container.
find . | grep ev3build | xargs rm -rf

# Note: BUILD_DIR is in the docker container, not the host.
export BUILD_DIRNAME="$(mktemp -d ev3build.XXXXXX)"
export BUILD_LOCAL="$(pwd)/${BUILD_DIRNAME}"
export BUILD_DIR="/src/${BUILD_DIRNAME}"

armel_cmake () {
    ( cd $BUILD_LOCAL && cmake -DCMAKE_TOOLCHAIN_FILE=../armel.cmake "$@" )
    # docker exec -w "${BUILD_DIR}" --tty "${CONTAINER_NAME}" cmake -DCMAKE_TOOLCHAIN_FILE=/home/compiler/toolchain-armel.cmake "$@"
}

armel_make () {
    ( cd $BUILD_LOCAL && make "$@" )
    # docker exec -w "${BUILD_DIR}" --tty "${CONTAINER_NAME}" make "$@"
}

# If we're running in WSL2:
if uname -a | grep -qEi "microsoft.*WSL2" &> /dev/null; then
    # Use the Windows ssh and scp programs. The ev3 over bluetooth will only 
    # be connected via a link-local interface to the Windows host. I have not been
    # able to figure out how to make this interface available from inside the WSL2
    # container.
    ssh() {
        ssh.exe "$@"
    }
    scp() {
        scp.exe "$@"
    }
fi