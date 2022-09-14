# Dorothy
Dorothy (named after the protagonist of Frank Baum's Oz novels) is a Docker image for interacting with Oz programs and running the Mozart OPI within a containerised runtime environment.

#### Mac users: Apple silicon and X11 issues

Due to XQuartz' present incompatibility with Apple silicon, the TUI (Text User Interface) of Dorothy is recommended for Mac users experiencing issues with the X11 GUI version of Dorothy.



## Pull and run Docker image

#### Graphical User Interface (X11, Linux only)

```
# Pull image and edit tag
docker pull ghcr.io/richarah/dorothy-x11-gui:latest
docker tag ghcr.io/richarah/dorothy-x11-gui dorothy-x11-gui

# Set xauth permissions and run Dorothy
xhost +SI:localuser:root && \
docker run \
--rm \
-it \
-e DISPLAY=:0 \
-e XAUTHORITY=/tmp/.docker.xauth \
-v /tmp/.X11-unix:/tmp/.X11-unix \
-v /tmp/.docker.xauth:/tmp/.docker.xauth:rw \
-v /home/$USER:/docker \
dorothy
```

#### Text User Interface (Emacs)
```
docker pull ghcr.io/richarah/dorothy-tui:latest
docker tag ghcr.io/richarah/dorothy-tui:latest dorothy-tui
docker run --rm -it -v /home/$USER:/docker dorothy-tui
```

For those unfamiliar with the Emacs editor or text-based user interfaces in general, the following documentation may be helpful:

[Official GNU Emacs Manual](https://www.gnu.org/software/emacs/manual/emacs.html)

[Oz-Emacs Cheat Sheet ](https://github.com/richarah/oz-tui-cheat-sheet) (work in progress)

#### A note on {Browse} and graphics on Dorothy TUI

Due to the TUI version of Dorothy omitting X11, code that requires a window manager or makes use of graphics libraries may not run as intended. Thus, e.g. instead of `{Browse}` , text-mode users are encouraged to use alternatives such as `{Show}`.



## Setting up an alias (optional)

#### Will I have to enter that obscenely long `docker run` command every time I want Oz?

Not necessarily. This could be resolved by setting an `alias`, a shortcut that references a command - in this case, our `docker run` command and its parameters.

After executing the following commands, you should be able to start Dorothy simply by entering `dorothy` in the command line.

If the changes do not take effect immediately, please restart the machine and try again.

#### X11 GUI (Linux)

```bash
echo "alias dorothy='xhost +SI:localuser:root && docker run --rm -it -e DISPLAY=:0 -e XAUTHORITY=/tmp/.docker.xauth -v /tmp/.X11-unix:/tmp/.X11-unix -v /tmp/.docker.xauth:/tmp/.docker.xauth:rw -v /home/$USER:/docker dorothy-x11-gui'" >> ~/.bashrc
source ~/.bashrc
```

#### Emacs TUI (Linux and older macOS)

```bash
echo "alias dorothy='docker run --rm -it -v /home/$USER:/docker dorothy-tui'" >> ~/.bashrc
source ~/.bashrc
```

#### Emacs TUI (macOS Catalina and newer)

```bash
echo "alias dorothy='docker run --rm -it -v /home/$USER:/docker dorothy-tui'" >> ~/.zshrc
source ~/.zshrc
```


## Modify bind mounts (optional)
By default, Dorothy binds the user's home directory to the `/docker` directory within the container. However, some users may wish to append additional bind mounts or forgo these altogether.

Additional bind mounts may be attached using the `-v` flag, replacing `/path/to/dir` with the path to the host directory one wishes to mount, and `/docker` with the path to access this directory from within the container.
The syntax is as follows:
```
-v /path/to/host/dir:/path/to/container/dir
```



## Building Dorothy (advanced)

#### Dependencies
Before proceeding, please ensure that you have Docker installed on your machine. Next, clone the repository as follows:
```
git clone https://github.com/richarah/dorothy.git
```
The Docker image may then be built with the following command:
```
cd dorothy
docker build -t dorothy .
```
Set the necessary `xauth` permissions for the X11 GUI to work:
```
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f /tmp/.docker.xauth nmerge -
```

#### Non-x64 architectures
When building for architectures other than the default `x64`, please set the `ARCH` environment variable to suit your machine's architecture, else the software may not work as intended.

Once the Docker build finishes, Dorothy may be run as follows:

```
docker run \
--rm \
-it \
-e DISPLAY=unix$DISPLAY \
-e XAUTHORITY=/tmp/.docker.xauth \
-v /tmp/.X11-unix:/tmp/.X11-unix \
-v /tmp/.docker.xauth:/tmp/.docker.xauth:rw \
-v /home/$USER:/docker \
dorothy
``
