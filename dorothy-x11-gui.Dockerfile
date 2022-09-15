FROM dorothy-tui

# X11 deps
RUN apt-get install apt-transport-https -y && \
    apt-get install apt-utils x11-apps -y

WORKDIR /docker

# Nasty hack to ensure the bash prompt actually shows
CMD oz && /bin/bash
