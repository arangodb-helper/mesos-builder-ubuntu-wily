FROM ubuntu:xenial

RUN apt-get update && \
  apt-get install -y \
  tar wget git \
  openjdk-8-jdk autoconf libtool \
  build-essential python-dev python-boto \
  libcurl4-nss-dev libsasl2-dev libsasl2-modules maven libapr1-dev libsvn-dev

RUN apt-get install -y zlib1g-dev cmake

RUN git clone --single-branch --branch 1.4.x https://github.com/apache/mesos.git && \
  cd mesos && \
  mkdir build

RUN sed -ie "s/\(add_library.*\) SHARED/\1 STATIC/g" /mesos/3rdparty/libprocess/src/CMakeLists.txt

RUN cd mesos/build && \
  CXXFLAGS=-fPIC cmake -DBUILD_SHARED_LIBS=Off -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_INSTALL_PREFIX:PATH=/usr/local .. && \
  make -j8
