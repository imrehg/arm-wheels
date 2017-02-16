#!/bin/bash
set -e

PYTHON2_PATH="/usr/lib/python2.7/dist-packages:/usr/lib/python2.7/site-packages"
PYTHON3_PATH_debian="/usr/lib/python3/dist-packages"
PYTHON3_PATH_alpine="/usr/lib/python3.5/site-packages"
PYTHON3_PATH_fedora="/usr/lib/python3.5/site-packages"
PYTHON2_ARGS="-DBUILDSWIGNODE=OFF"
PYTHON3_ARGS="-DBUILDSWIGNODE=OFF -DBUILDPYTHON3=ON -DPYTHON_INCLUDE_DIR=/usr/local/include/python3.5m/ -DPYTHON_LIBRARY=/usr/local/lib/libpython3.so"

# set PYTHONPATH to point to dist-packages
# $1: base version
# $2: path
# $3: variants
# $4: distro
set_pythonpath() {
	for va in $3; do

		if [ $va == 'base' ]; then
			tmp_path=$2
		else
			tmp_path="$2/$va"
		fi

		if [ $1 != "2.7" ]; then
			PPATH="PYTHON3_PATH_$4"
			echo "ENV PYTHONPATH ${!PPATH}:\$PYTHONPATH" >> $tmp_path/Dockerfile
		else
			echo "ENV PYTHONPATH $PYTHON2_PATH:\$PYTHONPATH" >> $tmp_path/Dockerfile
		fi
	done
}

devices='armv7hf'
pythonVersions='2.7.12 3.3.6 3.4.4 3.5.2 3.6.0'
binary_url="http://resin-packages.s3.amazonaws.com/python/v\$PYTHON_VERSION/Python-\$PYTHON_VERSION.linux-#{TARGET_ARCH}.tar.gz"

for device in $devices; do
	case "$device" in
	'armv7hf')
		binary_arch='armv7hf'
	esac
	for pythonVersion in $pythonVersions; do
		if [ $pythonVersion != "2.7.12" ]; then
			template='Dockerfile.python3.tpl'
		else
			template='Dockerfile.tpl'
		fi
		baseVersion=$(expr match "$pythonVersion" '\([0-9]*\.[0-9]*\)')

		# Debian
		# Extract checksum
		checksum=$(grep " Python-$pythonVersion.linux-$binary_arch.tar.gz" SHASUMS256.txt)

		debian_dockerfilePath=$device/$baseVersion
		mkdir -p $debian_dockerfilePath
		sed -e s~#{FROM}~"resin/$device-buildpack-deps:wheezy"~g \
				-e s~#{PYTHON_VERSION}~"$pythonVersion"~g \
				-e s~#{PYTHON_BASE_VERSION}~"$baseVersion"~g \
				-e s~#{BINARY_URL}~"$binary_url"~g \
				-e s~#{CHECKSUM}~"$checksum"~g \
				-e s~#{TARGET_ARCH}~"$binary_arch"~g $template > $debian_dockerfilePath/Dockerfile

		set_pythonpath "$baseVersion" "$debian_dockerfilePath" "base" "debian"
	done
done
