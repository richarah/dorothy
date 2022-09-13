#!/bin/sh

# Create xauth file and set the appropriate permissions
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f /tmp/.docker.xauth nmerge -

# cd to script location
cd "${0%/*}"

# Make interactive, add bind mounts & X11 compat
docker run \
-it \
-e DISPLAY=unix$DISPLAY \
-e XAUTHORITY=/tmp/.docker.xauth \
-v /tmp/.X11-unix:/tmp/.X11-unix \
-v /tmp/.docker.xauth:/tmp/.docker.xauth:rw \
-v /home/$USER:/home/$USER \
x11-dorothy
