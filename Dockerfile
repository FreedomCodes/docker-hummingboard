from ubuntu:14.04
maintainer "Elis Popescu"

workdir /root/
run apt-get update -y &&  apt-get upgrade -y && apt-get install -y build-essential libcurl4-gnutls-dev libncurses5-dev unzip wget git texinfo gperf flex bison gawk libtool libexpat1-dev automake unzip gawk bison flex gperf texinfo libtool g++ libncurses5-dev libexpat1-dev gettext libglib2.0-dev xsltproc libxml2-utils docbook-xml intltool groff docbook-xsl

run wget http://buildgear.io/release/buildgear-0.9.24.tar.xz && tar -xvf buildgear-0.9.24.tar.xz && cd buildgear-0.9.24 && ./configure && make install

workdir /root/
run git clone https://github.com/mini-distribution/raspberrypi.git && cd raspberrypi && git submodule update --init && buildgear build bootloader
