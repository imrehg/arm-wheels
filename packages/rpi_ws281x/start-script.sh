#!/bin/bash

if [[ $# -eq 0 ]] ; then
	VERSION=master
else
	VERSION=$1
fi
echo "Building ${VERSION}"

TARGET=/usr/src/target
TMP=/tmp



git clone https://github.com/pimoroni/rpi_ws281x-python.git
cd rpi_ws281x-python
git checkout -b build ${VERSION}
git submodule update --init --recursive
cd library
pip wheel -vvv --wheel-dir ${TMP} .
for f in ${TMP}/*linux*.whl; do
	auditwheel repair --wheel-dir=${TARGET} ${f}
done
