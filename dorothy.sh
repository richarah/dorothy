#!/bin/sh

# CD to script location
cd "${0%/*}"

# Make interactive, add bind mounts
docker run \
-it \
-v /home/$USER:/home/$USER \
x11-dorothy
