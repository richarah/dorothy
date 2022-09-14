# Dorothy
Dorothy (named after the protagonist of Frank Baum's Oz novels) is a Docker image for interacting with Oz programs and running the Mozart OPI within a containerised runtime environment.

#### Note on Apple silicon and X11 issues
Due to XQuartz' present incompatibility with Apple silicon, the TUI (Text User Interface) branch of Dorothy is recommended for Mac users experiencing issues with the X11 GUI version of Dorothy.

This branch may be cloned with the following command.
```
git clone https://github.com/richarah/dorothy.git -b tui
```

**Note: The textmode version of Dorothy uses a simplified build process and a different tagging nomenclature to differentiate it from its X11 counterpart. Please refer to the README file of the `tui` branch for further information.**

#### Motivation
Oz in its current state is known for compatibility issues on certain machines and OSes, meaning that programs may not run or compile as they do on other systems (the infamous "it works on my machine")

# Building Dorothy

#### Dependencies
Before proceeding, please ensure that you have Docker installed on your machine. Next, clone the repository as follows:
```
git clone https://github.com/richarah/dorothy.git
```

Once the repository has been cloned, the Docker image may be built without further configuration via the provided `build.sh`:
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

When building Dorothy this way, one also has to set the necessary `xauth` permissions:
```
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f /tmp/.docker.xauth nmerge -
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
