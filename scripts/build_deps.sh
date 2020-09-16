#!/bin/sh
set -e -x

# Dependencies
if [ ! -d deps ]
then
  mkdir deps

  cd /device-bacnet-c/deps

  # install libcbor used for building the SDK
  git clone --branch v0.7.0 https://github.com/PJK/libcbor
  cd libcbor
  cmake -DCMAKE_BUILD_TYPE=Release -DCBOR_CUSTOM_ALLOC=ON -DCMAKE_INSTALL_LIBDIR=lib .
  make
  make install

# get c-sdk from edgexfoundry
  wget https://github.com/edgexfoundry/device-sdk-c/archive/v1.2.2.zip
  unzip v1.2.2.zip
  cd device-sdk-c-1.2.2
  ./scripts/build.sh
  cp -rf include/* /usr/include/
  cp build/release/c/libcsdk.so /usr/lib/
  mkdir -p /usr/share/doc/edgex-csdk
  cp Attribution.txt /usr/share/doc/edgex-csdk
  cp LICENSE /usr/share/doc/edgex-csdk
  rm -rf /device-bacnet-c/deps
fi
