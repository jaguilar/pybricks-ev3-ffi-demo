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

export BUILD_DIR="/src/$(mktemp -d ev3build.XXXXXX)"
echo "Building in $BUILD_DIR"

# Runs a command inside the container.
runc () {
    docker exec --tty $CONTAINER_NAME "$@"
}

runc rm -rf "/src/ev3build*"

cmake () {
    runc -w "/src/${BUILD_DIR}" --cmake -DCMAKE_TOOLCHAIN_FILE=/home/compiler/toolchain-armel.cmake ../ "$@"
}

make () {
    runc -w "/src/${BUILD_DIR}" make "$@"
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