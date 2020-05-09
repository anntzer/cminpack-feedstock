mkdir build-single-static
cd build-single-static

cmake -Wno-dev -G "NMake Makefiles" ^
  -DCMAKE_BUILD_TYPE=RelWithDebInfo ^
  -DBUILD_SHARED_LIBS:BOOL=OFF ^
  -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX% ^
  -DCMAKE_INSTALL_PREFIX:PATH=%LIBRARY_PREFIX% ^
  -DUSE_BLAS:BOOL=OFF ^
  -DCMAKE_C_FLAGS=/D__cminpack_float__ ^
  -DCMAKE_RELWITHDEBINFO_POSTFIX=s_s ^
  .. || goto :eof

cmake --build . --config Release --target install || goto :eof
cd ..

mkdir build-double-static
cd build-double-static

cmake -Wno-dev -G "NMake Makefiles" ^
  -DCMAKE_BUILD_TYPE=RelWithDebInfo ^
  -DBUILD_SHARED_LIBS:BOOL=OFF ^
  -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX% ^
  -DCMAKE_INSTALL_PREFIX:PATH=%LIBRARY_PREFIX% ^
  -DUSE_BLAS:BOOL=OFF ^
  -DCMAKE_RELWITHDEBINFO_POSTFIX=_s ^
  .. || goto :eof

cmake --build . --config Release --target install || goto :eof
cd ..

mkdir build-single-shared
cd build-single-shared

cmake -Wno-dev -G "NMake Makefiles" ^
  -DCMAKE_BUILD_TYPE=RelWithDebInfo ^
  -DBUILD_SHARED_LIBS:BOOL=ON ^
  -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX% ^
  -DCMAKE_INSTALL_PREFIX:PATH=%LIBRARY_PREFIX% ^
  -DUSE_BLAS:BOOL=OFF ^
  -DCMAKE_C_FLAGS=/D__cminpack_float__ ^
  -DCMAKE_RELWITHDEBINFO_POSTFIX=s ^
  .. || goto :eof

cmake --build . --config Release --target install || goto :eof
cd ..

mkdir build-double-shared
cd build-double-shared

cmake -Wno-dev -G "NMake Makefiles" ^
  -DCMAKE_BUILD_TYPE=RelWithDebInfo ^
  -DBUILD_SHARED_LIBS:BOOL=ON ^
  -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX% ^
  -DCMAKE_INSTALL_PREFIX:PATH=%LIBRARY_PREFIX% ^
  -DUSE_BLAS:BOOL=OFF ^
  .. || goto :eof

cmake --build . --config Release --target install || goto :eof
cd ..

rem cd build-double-shared
rem unix2dos ../examples/ref/*.ref
rem ctest --output-on-failure
