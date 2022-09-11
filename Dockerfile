FROM ubuntu:latest

# Build for AMD64
# Please modify this to suit your architecture
ARG ARCH=x64

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \ 
    DEBIAN_FRONTEND=noninteractive apt-get upgrade -y && \ 
    DEBIAN_FRONTEND=noninteractive apt-get install -y \ 
    	git subversion \ 
    	python3 python3-dev python-tk tk tk-dev tcl tcl-dev tclsh \ 
    	gcc libboost-all-dev build-essential g++ make cmake \ 
    	openjdk-11-jre-headless \ 
    	emacs

RUN mkdir docker && cd docker && \
    git clone --recursive https://github.com/mozart/mozart2 && \
    cd mozart2 && mkdir build && cd build && \
    cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER_ARCHITECTURE_ID=$ARCH ..  && \
    make && make install

# Bugfix: this command does not only set CWD, but creates one if it does not exist
WORKDIR /docker

# Now allows OPI exit to shell without shutdown
CMD nohup oz & /bin/sh
