package=`basename $PWD`
docker run \
  --rm \
  --detach \
  -v ${PWD}/target:/usr/src/target \
  imrehg/armv7hf-python-${package}:$1 $2
