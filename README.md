# Dorothy
Dorothy (named after the protagonist of Frank Baum's Oz novels) is a Docker image for running the Oz Programming Interface within a containerised runtime environment.

# Setup
When building for architectures other than the default `x64`, please set the `ARCH` environment variable to suit your machine's architecture, else the software may not work as intended.
```
git clone https://github.com/richarah/dorothy.git
cd dorothy
docker build --build-arg user=$USER --build-arg uid=$(id -u) --build-arg gid=$(id -g) -t x11-dorothy .
```

# Running Dorothy
Once the Docker build finishes, Dorothy may be run with the following command. The `-it` flag is necessary to interact with the container:
```
docker run -e DISPLAY=unix$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v /tmp/.docker.xauth:/tmp/.docker.xauth:rw -e XAUTHORITY=/tmp/.docker.xauth x11-docker
```
#### Bind mounts
Bind mounts may be attached to the container at runtime using the `-v` flag, replacing `/path/to/dir` with the path to the host directory one wishes to mount, and `/docker` with the path to access this directory from within the container:
```
-v /path/to/dir:/docker -it dorothy
```
