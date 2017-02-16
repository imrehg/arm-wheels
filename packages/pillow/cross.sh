docker run \
  --rm \
  --detach \
  -v $PWD/target:/usr/src/target \
  imrehg/armv7hf-python-pillow:$1 $2
