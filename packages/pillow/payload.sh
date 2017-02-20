#!/bin/bash

PKG=$1
TARGET=/usr/src/target
TMP=/tmp

pip wheel -vvv --wheel-dir ${TMP} ${PKG}
for f in ${TMP}/*linux*.whl; do
	auditwheel repair --wheel-dir=${TARGET} ${f}
done
