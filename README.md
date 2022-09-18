# Dorothy
Dorothy (named after the protagonist of Frank Baum's Oz novels) is a Docker image for running Mozart-Oz and the OPI from within a container, either standalone or as part of a CDE (Containerised Development Environment) - e.g. using VSCode's [Remote - Containers](https://code.visualstudio.com/docs/remote/containers) extension.

#### What it's for

Mozart has been known to suffer serious compatibility flaws on certain systems - notably code that compiles and runs flawlessly on other machines failing to compile on those running non-Debianesque Linux distros or macOS.

By packaging Mozart within the self-contained, standardised environment of a Docker container, the Dorothy project aims to resolve these machine- and platform-specific issues.

#### Mac users: Apple silicon and X11 issues

Due to trouble interfacing with X11 on machines powered by Apple silicon, the TUI (Text User Interface) version of Dorothy is recommended for Mac users experiencing issues with the X11 GUI.


---


## Pull and run Docker image

#### Graphical User Interface (X11, Linux only)

```
# Pull image and edit tag
docker pull ghcr.io/richarah/dorothy-x11-gui:latest && \
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
dorothy-x11-gui
```

#### Text User Interface (Linux & macOS)
```
# Pull image and edit tag
docker pull ghcr.io/richarah/dorothy-tui:latest && \
docker tag ghcr.io/richarah/dorothy-tui:latest dorothy-tui

# Run (no X11 tinkering necessary)
docker run --rm -it -v /home/$USER:/docker dorothy-tui
```

For those unfamiliar with the Emacs editor or text-based user interfaces in general, the following documentation may be helpful:

[Official GNU Emacs Manual](https://www.gnu.org/software/emacs/manual/emacs.html)

[Oz-Emacs Cheat Sheet ](https://github.com/richarah/oz-tui-cheat-sheet) (work in progress)

#### A note on {Browse} and graphics on Dorothy TUI

Due to the TUI version of Dorothy omitting X11, code that requires a window manager or makes use of graphics libraries may not run as intended. Thus, e.g. instead of `{Browse}` , text-mode users are encouraged to use alternatives such as `{Show}`.



## Set an alias (optional)

**Will I have to enter that obscenely long `docker run` command every time I want Oz?**

Not necessarily: the process can be simplified by setting an `alias`, a shortcut that references a command - in this case, our `docker run` command and its parameters.

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


---


## Building Dorothy

Before building, please ensure that you have Git and Docker installed on your machine.

Next, clone and `cd` into the repository:

```
git clone https://github.com/richarah/dorothy.git
cd dorothy
```

Build the `dorothy-common` image, forming the basis for both the GUI and textmode versions:
```
docker-compose build common
```

The final image(s) may now be built with `docker-compose`:
```
# Textmode
docker-compose build tui
# X11 GUI
docker-compose build x11-gui
```
#### Non-x64 architectures
When building for architectures other than the default `x64`, please set the `ARCH` environment variable to suit your machine's architecture, else the software may not work as intended.

