#!/bin/bash

# The lib directory
LIB_ROOT=$PWD

# Ensure this is adjusted to your local emsdk path
EMSCRIPTEN_DIR=~/emsdk/upstream/emscripten

# Emscripten cmake
EMSCRIPTEN_CMAKE_DIR=$EMSCRIPTEN_DIR/cmake/Modules/Platform/Emscripten.cmake

# Sets the compile flags. [SIMD, THREADS, DEFAULT]
BUILD_TYPE="DEFAULT"

if [ $BUILD_TYPE = "SIMD" ]; then
  echo "Compiling with SIMD enabled"
  INSTALL_DIR=$LIB_ROOT/build_simd
  BUILD_FLAGS="-O3 -std=c++17 -msimd128";
  CONF_OPENCV="--simd";
elif [ $BUILD_TYPE = "THREADS" ]; then
  echo "Compiling with THREADS enabled"
  INSTALL_DIR=$LIB_ROOT/build_threads
  BUILD_FLAGS="-O3 -std=c++17 -s USE_PTHREADS=1 -s PTHREAD_POOL_SIZE=4";
  CONF_OPENCV="--threads";
else
  echo "Compiling with DEFAULT settings"
  INSTALL_DIR=$LIB_ROOT/build
  BUILD_FLAGS="-O3 -std=c++17";
  CONF_OPENCV="";
fi

build_OPENCV() {
  # To enable opencv_contrib-4.x modules add the following line to opencv/platforms/js/build_js.py -> def get_cmake_cmd(self):
  # "-DOPENCV_EXTRA_MODULES_PATH=[YOUR_PATH_TO_OPENCV_CONTRIB_DIR]/opencv_contrib-4.x/modules",
  # For more options look here: https://docs.opencv.org/4.x/d4/da1/tutorial_js_setup.html

  rm -rf $INSTALL_DIR/opencv/
  rm -rf $LIB_ROOT/opencv/build

  # you need to have python>=2.7 installed
  # here I installed it with anaconda (but it seems still using /usr/bin/python2.7 ...)
  conda activate python2

  python $LIB_ROOT/opencv/platforms/js/build_js.py $LIB_ROOT/opencv/build --build_wasm $CONF_OPENCV --emscripten_dir $EMSCRIPTEN_DIR
  cp -r $LIB_ROOT/opencv/build $INSTALL_DIR/opencv/
}



build() {
    array=($@)
    length=${#array[@]}

    BL='\033[1;34m'
    NC='\033[0m'

    for (( i=0; i<length; i++ ));
    do
      echo -e "${BL}Step $(($i+1))/$length -------------------------------- Start building: ${array[$i]} ${NC}"
      build_${array[$i]}
      echo -e "${BL}Step $(($i+1))/$length -------------------------------- Complete ${NC}\n\n"
    done
}

# e.g. libsToBuild=( "EIGEN" "OPENCV" "OBINDEX2" "IBOW_LCD" "SOPHUS" "CERES" "OPENGV" )
libsToBuild=( "OPENCV" )

build ${libsToBuild[@]}