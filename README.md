# Dorothy
Dorothy (named after the protagonist of Frank Baum's Oz novels) is a Docker image for running the Oz Programming Interface within a containerised runtime environment.

# Building Dorothy

#### Dependencies
Before proceeding, please ensure that you have Docker installed on your machine. Next, clone the repository as follows:
```
git clone https://github.com/richarah/dorothy.git
```

Once the repository has been cloned, the Docker image may be built without any further configuration via the provided `build.sh`:
#### Via build.sh (recommended for most users)
```
cd dorothy
./build.sh
```
Depending on your machine and Internet connection, this may take anywhere from 15 minutes to two hours.

#### Via Docker command
The Dorothy image may also be built 'manually' via Docker command, which may be useful for non-standard configurations (see below)
```
docker build --build-arg user=$USER --build-arg uid=$(id -u) --build-arg gid=$(id -g) -t dorothy .
```

#### Non-x64 architectures
When building for architectures other than the default `x64`, please set the `ARCH` environment variable to suit your machine's architecture, else the software may not work as intended.

# Running Dorothy
Once the Docker build finishes, Dorothy may be run with `./dorothy.sh` or via Docker command, as follows:
```
docker run -it -e DISPLAY=unix$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v /tmp/.docker.xauth:/tmp/.docker.xauth:rw -e XAUTHORITY=/tmp/.docker.xauth dorothy
```
#### Bind mounts
By default, Dorothy binds the user's home directory to the home directory within the container. However, some users may wish to append additional bind mounts or forgo this altogether.

Additional bind mounts may be attached using the `-v` flag, replacing `/path/to/dir` with the path to the host directory one wishes to mount, and `/docker` with the path to access this directory from within the container.
The syntax is as follows:
```
-v /path/to/host/dir:/path/to/container/dir
```
