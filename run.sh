#!/bin/sh

# cd to script location
cd "${0%/*}"
docker run \
-it \
-e DISPLAY=unix$DISPLAY \
-e XAUTHORITY=/tmp/.docker.xauth \
-v /tmp/.X11-unix:/tmp/.X11-unix \
-v /tmp/.docker.xauth:/tmp/.docker.xauth:rw \
--entrypoint nohup oz & /bin/bash \
x11-dorothy