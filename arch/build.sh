arches="armv7hf"
pythons="2.7 3.3 3.4 3.5 3.6"
SRC_DIR=$PWD
for arch in $arches; do
  cd $arch
  for python in $pythons; do
    cd $python
    docker build . -t imrehg/$arch-python:$python
    cd ..
  done
  cd ..
done
