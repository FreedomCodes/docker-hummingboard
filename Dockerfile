from ubuntu:15.04

workdir /root/

# Install required buildgear build system dependencies
run apt-get update -y && apt-get upgrade -y && apt-get install -y build-essential libcurl4-gnutls-dev libncurses5-dev unzip wget git texinfo gperf flex bison gawk libtool libexpat1-dev automake unzip gawk bison flex gperf texinfo libtool g++ libncurses5-dev libexpat1-dev gettext libglib2.0-dev xsltproc libxml2-utils docbook-xml intltool groff docbook-xsl

# Install required hummingboard build system dependencies
run apt-get install -y libtool-bin

# Reconfigure default shell to bash
run ln -sf bash /bin/sh

# Install buildgear
run wget http://buildgear.io/release/buildgear-0.9.24.tar.xz && tar -xvf buildgear-0.9.24.tar.xz && cd buildgear-0.9.24 && ./configure --prefix=/usr && make install

# Build hummingboard distribution
workdir /root/
run git clone --recursive https://github.com/mini-distribution/hummingboard.git && cd hummingboard
workdir /root/hummingboard
run buildgear build u-boot
