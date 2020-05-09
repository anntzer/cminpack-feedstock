#!/bin/bash
USE_BLAS=OFF
if [ ! -z "$blas_impl" ] && [ "$blas_impl" != "noblas" ]; then
  USE_BLAS=ON
fi

mkdir build-single
(
  cd build-single

  cmake -Wno-dev -G "Ninja" \
    -D CMAKE_BUILD_TYPE=RelWithDebInfo \
    -D BUILD_SHARED_LIBS:BOOL=ON \
    -D CMAKE_PREFIX_PATH=$PREFIX \
    -D CMAKE_INSTALL_PREFIX:PATH=$PREFIX \
    -D CMINPACK_LIB_INSTALL_DIR="lib" \
    -D USE_BLAS:BOOL=$USE_BLAS \
    -D CMAKE_C_FLAGS=-D__cminpack_float__ \
    -D CMAKE_RELWITHDEBINFO_POSTFIX=s \
    ..

  ninja
  ninja install
)

mkdir build-double
(
  cd build-double

  cmake -Wno-dev -G "Ninja" \
    -D CMAKE_BUILD_TYPE=RelWithDebInfo \
    -D BUILD_SHARED_LIBS:BOOL=ON \
    -D CMAKE_PREFIX_PATH=$PREFIX \
    -D CMAKE_INSTALL_PREFIX:PATH=$PREFIX \
    -D CMINPACK_LIB_INSTALL_DIR="lib" \
    -D USE_BLAS:BOOL=$USE_BLAS \
    ..

  ninja
  ninja install

  ctest --output-on-failure
)
