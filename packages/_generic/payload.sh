#!/bin/bash

PKG=$1
TARGET=/usr/src/target
TMP=/tmp

pip wheel -vvv --wheel-dir ${TMP}/wheel/ ${PKG}
auditwheel repair --wheel-dir=${TARGET} ${TMP}/wheel/*
