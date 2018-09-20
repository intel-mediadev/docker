FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install -y \
    autoconf \
    git \
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

RUN cd /opt/src && \
    git clone https://github.com/intel/libva && \
    cd libva && \
    git checkout 2.2.1.pre1-20180921 && \
    ./autogen.sh --prefix=/usr --libdir=/usr/lib/x86_64-linux-gnu && \
    make -j8 && \
    make install

RUN cd /opt/src && \
    git clone https://github.com/intel/gmmlib && \
    cd gmmlib && \
    git checkout intel-gmmlib-18.3.pre1 && \
    mkdir ../build_gmmlib && \
    cd ../build_gmmlib && \
    cmake ../gmmlib && \
    make -j8 && \
    make install

RUN cd /opt/src && \
    git clone https://github.com/intel/media-driver && \
    cd media-driver && \
    git checkout intel-media-18.3.pre3 && \
    mkdir ../build_media && cd ../build_media && \
    cmake ../media-driver && \
    make -j8 && \
    make install

RUN cd /opt/src && \
    git clone https://github.com/intel/libva-utils && \
    cd libva-utils && \
    git checkout 2.2.1.pre1-20180921 && \
    ./autogen.sh && \
    ./configure --prefix=/usr && \
    make -j8 && \
    make install && \
    make check

RUN cd /opt/src && \
    git clone https://github.com/Intel-Media-SDK/MediaSDK && \
    mkdir build_msdk && \
    cd build_msdk && \
    cmake ../MediaSDK && \
    make -j8 && \
    make install

ADD Tools/docker/ubuntu_export.sh /opt/src/ubuntu_export.sh
