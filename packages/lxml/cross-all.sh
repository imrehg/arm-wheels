pythons="2.7 3.3 3.4 3.5 3.6"
package=`basename $PWD`
for python in $pythons; do
 docker run \
  --rm \
  --detach \
  -v ${PWD}/target:/usr/src/target \
  imrehg/armv7hf-python-${package}:${python} $1
done
