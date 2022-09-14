# Dorothy TUI
Dorothy (named after the protagonist of Frank Baum's Oz novels) is a Docker image for interacting with Oz programs and running the Mozart OPI within a containerised runtime environment.

#### TUI?
This is the TUI (Text User Interface) branch of Dorothy, replacing the X11-based GUI with an interface based on the Emacs editor.

For those unfamiliar with Emacs or text-based user interfaces in general, the following documentation may be helpful:

[Official GNU Emacs Manual](https://www.gnu.org/software/emacs/manual/emacs.html)

[Oz-Emacs Cheat Sheet ](https://github.com/richarah/oz-tui-cheat-sheet) (work in progress)

# Building Dorothy TUI

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
docker build -t dorothy-tui .
```

#### Non-x64 architectures
When building for architectures other than the default `x64`, please set the `ARCH` environment variable to suit your machine's architecture, else the software may not work as intended.

# Running Dorothy TUI
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
