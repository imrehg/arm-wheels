# arm-wheels

Work in progress project to provide a basis for Python wheels
for ARM devices (mostly ARMv7 and AARCH64 in the future), and
thus help with the installation of Python packages, which otherwise
might be compiled for a long time on the device.

Useing a Docker image to create a environment to cross-compile on an x86
machine for ARM.

## Supported packages

At the moment these packages were tested

* _generic_: a generic package to compile libraries that have no extra dependencies 
* numpy
* scipy
* pillow

The current packages are distributed at [`https://gergely.imreh.net/wheels/`](https://gergely.imreh.net/wheels/),
and you can use those packages by running:

```
pip install --extra-index-url=https://gergely.imreh.net/wheels/ <packagename>
```

Require an up-to-date version of `pip`, so you might need to run `pip install -U pip`
to upgrade first.

## License

Copyright 2017 Gergely Imreh <imrehg@gmail.com>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
