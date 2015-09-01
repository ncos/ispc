#!/bin/bash


TARGET=avx1-i32x16

echo "$(rm -rf case.run case.ispc.o case.ispc.h case.bc case.ll)"

echo "$(ispc -v)"
echo "$(../ispc case.ispc -o case.bc --arch=x86-64 --target=$TARGET --emit-llvm )"
echo "$(llvm-dis case.bc )"
echo "$(rm-rf case.bc )"

echo "$(../ispc case.ispc -o case.ispc.o --arch=x86-64 --target=$TARGET -h case.ispc.h )"

echo "$(clang++ -O2 -I. -m64  case.cpp case.ispc.o -o case.run)"
echo ""


