# Opencv Wasm Demo

this repo is about using emcmake to build c++ codes into wasm, with opencv as 3rd party library.

## Reference

this repo is highly referenced from [AlvaAR](https://github.com/alanross/AlvaAR)

## Build

### Prerequisites

#### Emscripten
Ensure [Emscripten](https://emscripten.org/docs/getting_started/Tutorial.html) is installed and activated in your session.

```
    $: source [PATH]/emsdk/emsdk_env.sh
    $: emcc -v
```

#### C++11 or Higher
Alva makes use of C++11 features and should thus be compiled with a C++11 or higher flag.

### Opencv 4.x

use opencv-4.5.0 as an example, you should download it and unzip it to src/libs/opencv

#### Build opencv
For convenience, a copy of all required libraries has been included in the libs/ folder. Run the following script to compile all libraries to wasm modules which can be linked into the main project.

notice: you may need to install python2(>=2.7)

```
    $: cd ./src/libs/
    $: ./build.sh
```

#### Build Project

Run the following in your shell before invoking emcmake or emmake:

```
    $: [PATH]/emsdk/emsdk_env.sh
```

Then, run the following:

```
    $: cd ./src/demo
    $: mkdir build/
    $: cd build/
    $: emcmake cmake ..
    $: emmake make install
```
