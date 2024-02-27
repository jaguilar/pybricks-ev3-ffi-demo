#! /bin/bash
#
# This builds the docker image described by armel.dockerfile

# The following environment variables must be visible:
# CR_PAT: a github personal access token with at least packages:read
#         permissions. Create one here: https://github.com/settings/tokens
# GITHUB_USERNAME: your username on github
if [ -e ./.secrets.sh ]; then
  . ./.secrets.sh
fi

echo "$CR_PAT" | docker login ghcr.io -u "$GITHUB_USERNAME" --password-stdin

IMAGE_NAME="ghcr.io/pybricks/pybricks-micropython/pybricks-ev3dev-armel:latest"
CONTAINER_NAME="ev3build"

# Note that we pull this image rather than building from source, because Debian's
# stretch repositories are no longer available and it is no longer possible to
# build this image from the armel.dockerfile in the pybricks-micropython sources.
docker pull "$IMAGE_NAME"
docker rm --force "$CONTAINER_NAME" >/dev/null 2>&1 || true

SRC_DIR=$(pwd)
docker run \
    --volume "$SRC_DIR:/src" \
    --workdir "/src" \
    --name "$CONTAINER_NAME" \
    --env "TERM=${TERM}" \
    --env "DESTDIR=/build/dist" \
    --env "MICROPY_MPYCROSS=/src/micropython/mpy-cross/build-armel/mpy-cross" \
    --user $(id -u):$(id -g) \
    --tty \
    --detach \
    "$IMAGE_NAME" tail

echo "Done. You can run commands in the container using docker exec --tty $CONTAINER_NAME <command>"
