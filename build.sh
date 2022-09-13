#!/bin/sh
# cd to script location
cd "${0%/*}"
docker build -t dorothy .
