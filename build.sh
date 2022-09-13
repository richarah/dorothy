#!/bin/sh
# cd to script location
cd "${0%/*}"
docker build --build-arg user=$USER --build-arg uid=$(id -u) --build-arg gid=$(id -g) -t x11-dorothy .
