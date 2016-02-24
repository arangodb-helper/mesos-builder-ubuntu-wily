FROM ubuntu:15.10

RUN apt-get update && \
  apt-get install -y \
  tar wget git \
  openjdk-7-jdk autoconf libtool \
  build-essential python-dev python-boto \
  libcurl4-nss-dev libsasl2-dev libsasl2-modules maven libapr1-dev libsvn-dev

RUN apt-get install -y zlib1g-dev

RUN wget http://www.apache.org/dist/mesos/0.27.1/mesos-0.27.1.tar.gz && \
  tar -zxf mesos-0.27.1.tar.gz && \
  cd mesos-0.27.1 && \
  mkdir build && \
  cd build && \
  ../configure && \
  make -j8
