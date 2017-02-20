versions="3.4 3.5 3.6"
for version in $versions; do
  docker build . -f Dockerfile-${version} -t imrehg/armv7hf-python-numpy:${version}
done
