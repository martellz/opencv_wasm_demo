#!/bin/bash

mkdir -p build
cd build
rm -rf ./*
emcmake cmake ..
emmake make install