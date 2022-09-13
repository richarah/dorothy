# Dorothy
Dorothy (named after the protagonist of Frank Baum's Oz novels) is a Docker image for interacting with Oz programs and running the Mozart OPI within a containerised runtime environment.

#### Note on macOS compatibility and X11 issues
Due to the macOS implementation of Docker having problems with X11, the TUI (Text User Interface) branch of Dorothy is recommended for Mac users. This branch may be cloned with the following command:
```
git clone https://github.com/richarah/dorothy.git -b tui
```

#### Motivation
Oz in its current state is marred by compatibility issues on certain machines and OSes, meaning that programs may not run or compile as they do on other systems (the infamous "it works on my machine")

This project aims to resolve these issues by isolating Oz, the OPI and their respective dependencies from their host environment, providing a standardised container that runs identically on a wide variety of different machines.

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
docker build -t dorothy .
```

#### Non-x64 architectures
When building for architectures other than the default `x64`, please set the `ARCH` environment variable to suit your machine's architecture, else the software may not work as intended.

# Running Dorothy
Once the Docker build finishes, Dorothy may be run with `./dorothy-tui.sh` or via Docker command, as follows:
```
docker run -it -v /home/$USER:/home/$USER dorothy-tui
```
#### Bind mounts
By default, Dorothy binds the user's home directory to the home directory within the container. However, some users may wish to append additional bind mounts or forgo this altogether.

Additional bind mounts may be attached using the `-v` flag, replacing `/path/to/dir` with the path to the host directory one wishes to mount, and `/docker` with the path to access this directory from within the container.
The syntax is as follows:
```
-v /path/to/host/dir:/path/to/container/dir
```
