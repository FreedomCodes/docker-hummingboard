# This docker configuration builds a full software stack (fs + bootloader) for
# the Hummingboard (imx6)

# Use Ubuntu as base image
from ubuntu:15.04

# Set root directory
workdir /root/

# Install required buildgear build system dependencies
run apt-get update -y && apt-get upgrade -y && apt-get install -y build-essential libcurl4-gnutls-dev libncurses5-dev unzip wget git texinfo gperf flex bison gawk libtool libexpat1-dev automake unzip gawk bison flex gperf texinfo libtool g++ libncurses5-dev libexpat1-dev gettext libglib2.0-dev xsltproc libxml2-utils docbook-xml intltool groff docbook-xsl

# Install required hummingboard build system dependencies
run apt-get install -y unzip groff bison flex gperf texinfo xsltproc libtool libtool-bin libncurses5-dev gawk libexpat1-dev gettext u-boot-tools libglib2.0-dev intltool libxml2-utils docbook-xml cmake g++ pixz lzop u-boot-tools docbook-xml ruby

# Reconfigure default shell to bash
run ln -sf bash /bin/sh

# Install buildgear
run wget http://buildgear.io/release/buildgear-0.9.24.tar.xz && tar -xvf buildgear-0.9.24.tar.xz && cd buildgear-0.9.24 && ./configure --prefix=/usr && make install

# Get hummingboard buildfile repository
run git clone --recursive https://github.com/mini-distribution/hummingboard.git
workdir /root/hummingboard

# Configure terminal
env TERM xterm

# Configure buildgear
run buildgear config parallel_builds 2

# Build hummingboard distribution
run buildgear build --no-fakeroot u-boot
#run buildgear build --no-fakeroot fs
