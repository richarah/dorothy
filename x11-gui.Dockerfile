FROM dorothy-common AS dorothy-x11-gui

# X11 deps
RUN apt-get install apt-transport-https -y && \
    apt-get install apt-utils x11-apps -y

WORKDIR /docker

CMD oz && /bin/bash
