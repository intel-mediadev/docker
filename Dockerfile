FROM ubuntu:18.04

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
    curl -o libva.zip -sSL https://github.com/intel/libva/archive/master.zip && \
    unzip libva.zip && \
    cd libva-master && \
    ./autogen.sh --prefix=/usr --libdir=/usr/lib/x86_64-linux-gnu && \
    make -j4 && \
    make install

RUN cd /opt/src && \
    curl -o gmmlib.zip -sSL https://github.com/intel/gmmlib/archive/master.zip && \
    unzip gmmlib.zip && \
    cd gmmlib-master && \
    mkdir build && cd build && \
    cmake .. && \
    make -j8 && \
    make install

RUN cd /opt/src && \
    curl -o media-driver.zip -sSL https://github.com/intel/media-driver/archive/master.zip && \
    unzip media-driver.zip && \
    mkdir build_media && cd build_media && \
    cmake ../media-driver-master && \
    make -j8 && \
    make install

RUN cd /opt/src && \
    curl -o libva-utils.zip -sSL https://github.com/intel/libva-utils/archive/master.zip && \
    unzip libva-utils.zip && \
    cd libva-utils-master && \
    ./autogen.sh && \
    ./configure --prefix=/usr && \
    make -j4 && \
    make install && \
    make check

   
RUN cd /opt/src && \
    curl -o MediaSDK.zip -sSL https://github.com/Intel-Media-SDK/MediaSDK/archive/master.zip && \
    unzip MediaSDK.zip && \
    cd MediaSDK-master && \
    mkdir build && cd build && \
    cmake .. && \
    make && \
    make install

