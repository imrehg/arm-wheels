#!/bin/bash

if [[ $# -eq 0 ]] ; then
  TARGET=master
else
  TARGET=$1
fi
echo "Building ${TARGET}"

git clone https://github.com/pimoroni/rpi_ws281x-python.git
cd rpi_ws281x-python
git checkout -b build ${TARGET}
git submodule update --init --recursive
cd library
pip wheel -vvv --wheel-dir=/usr/src/target .
