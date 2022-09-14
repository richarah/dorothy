FROM ubuntu:latest

# Build for AMD64
# Please modify this to suit your architecture
ARG ARCH=x64

# Noninteractive frontend had to be specified again and again
# as some versions of Docker tend to "forget"
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \ 
    DEBIAN_FRONTEND=noninteractive apt-get upgrade -y && \ 
    DEBIAN_FRONTEND=noninteractive apt-get install -y \ 
    	git subversion \ 
    	python3 python3-dev python-tk tk tk-dev tcl tcl-dev tclsh \ 
    	gcc libboost-all-dev build-essential g++ make cmake \ 
    	openjdk-11-jre-headless \ 
    	emacs

WORKDIR /build

RUN git clone --recursive https://github.com/mozart/mozart2 && \
    cd mozart2 && mkdir build && cd build && \
    cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER_ARCHITECTURE_ID=$ARCH ..  && \
    make && make install

WORKDIR /
RUN rm -rfv /build

RUN apt-get install apt-transport-https -y && \
    apt-get install apt-utils x11-apps -y

# Add user with credentials from cmdline
ARG user
ARG uid
ARG gid

ENV USERNAME ${user}
RUN useradd -m $USERNAME && \
        echo "$USERNAME:$USERNAME" | chpasswd && \
        usermod --shell /bin/bash $USERNAME && \
        usermod  --uid ${uid} $USERNAME && \
        groupmod --gid ${gid} $USERNAME
USER ${user}

WORKDIR /home/${user}

# Nasty hack to ensure the bash prompt actually shows
CMD oz && /bin/bash
