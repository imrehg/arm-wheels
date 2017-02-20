pythons="3.4 3.5 3.6"
for python in $pythons; do
 docker run \
  --rm \
  --detach \
  -v $PWD/target:/usr/src/target \
  imrehg/armv7hf-python-pillow:$python $1
done
