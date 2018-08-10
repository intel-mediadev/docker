FROM ubuntu:16.04

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
    apt-get install -y \
    autoconf \
    curl \
    libdrm-dev \
    libgl1-mesa-glx \
    libgl1-mesa-dev \
    libtool \
    libx11-dev \
    openbox \
    unzip \
    xorg \
    xorg-dev \
    && apt-get clean all

RUN mkdir /opt/src && \
    cd /opt/src && \
    curl -sSLO https://cmake.org/files/v3.8/cmake-3.8.2-Linux-x86_64.sh && \
    sh cmake-3.8.2-Linux-x86_64.sh --prefix=/usr/local --exclude-subdir && \
    rm cmake-3.8.2-Linux-x86_64.sh

RUN cd /opt/src && \
    curl -o libva-master.zip -sSL https://github.com/01org/libva/archive/master.zip && \
    unzip libva-master.zip && \
    cd libva-master && \
    ./autogen.sh --prefix=/usr --libdir=/usr/lib/x86_64-linux-gnu && \
    make -j2 && \
    make install

RUN cd /opt/src && \
    curl -sSLO https://www.samba.org/ftp/ccache/ccache-3.2.8.tar.bz2 && \
    tar xf ccache-3.2.8.tar.bz2 && \
    cd ccache-3.2.8 && \
    ./configure --prefix=/usr && \
    make && \
    make install

RUN mkdir -p /usr/lib/ccache && \
    cd /usr/lib/ccache && \
    ln -sf /usr/bin/ccache gcc && \
    ln -sf /usr/bin/ccache g++ && \
    ln -sf /usr/bin/ccache cc && \
    ln -sf /usr/bin/ccache c++ && \
    ln -sf /usr/bin/ccache clang && \
    ln -sf /usr/bin/ccache clang++ && \
    ln -sf /usr/bin/ccache clang-4.0 && \
    ln -sf /usr/bin/ccache clang++-4.0

ENV PATH /usr/lib/ccache:$PATH
