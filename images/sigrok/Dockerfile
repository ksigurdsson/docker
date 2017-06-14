FROM base

# Install required packages
RUN apt-get -y update && \
    apt-get -y upgrade && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install \
    git-core \
    gcc \
    g++ \
    make \
    cmake \
    autoconf \
    autoconf-archive \
    automake \
    libtool \
    pkg-config \
    libglib2.0-dev \
    libglibmm-2.4-dev \
    libzip-dev \
    libusb-1.0-0-dev \
    libftdi-dev \
    check \
    doxygen \
    python-numpy \
    python-dev \
    python-gi-dev \
    python-setuptools \
    swig \
    default-jdk \
    python3-dev \
    libqt4-dev \
    libboost-test-dev \
    libboost-thread-dev \
    libboost-filesystem-dev \
    libboost-system-dev \
    qt5-default \
    libqt5svg5-dev \
    sudo \
    sdcc \
    usbutils \
    xorg && \
    rm -rf /var/lib/apt/lists/

# Download and build
RUN mkdir /install && \
    \
    cd /install && \
    git clone git://sigrok.org/libserialport && \
    cd libserialport && \
    ./autogen.sh && \
    ./configure && \
    make && \
    sudo make install && \
    \
    cd /install && \
    git clone git://sigrok.org/libsigrok && \
    cd libsigrok && \
    ./autogen.sh && \
    ./configure && \
    make && \
    sudo make install && \
    \
    cd /install && \
    git clone git://sigrok.org/libsigrokdecode && \
    cd libsigrokdecode && \
    ./autogen.sh && \
    ./configure && \
    make && \
    sudo make install && \
    \
    cd /install && \
    git clone git://sigrok.org/sigrok-cli && \
    cd sigrok-cli && \
    ./autogen.sh && \
    ./configure && \
    make && \
    sudo make install && \
    \
    cd /install && \
    git clone git://sigrok.org/pulseview && \
    cd pulseview && \
    cmake . && \
    make && \
    sudo make install && \
    \
    cd /install && \
    git clone git://sigrok.org/sigrok-firmware-fx2lafw && \
    cd sigrok-firmware-fx2lafw && \
    ./autogen.sh && \
    ./configure && \
    make && \
    make install && \
    \
    cd / && \
    ldconfig /usr/local/lib


#   rm -rf /install

#   ldconfig /usr/local/lib
    
