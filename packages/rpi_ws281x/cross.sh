docker run \
  --rm \
  --detach \
  -v $PWD/target:/usr/src/target \
  imrehg/armv7hf-python-rpi_ws281x:$1 $2

