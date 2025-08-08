@ECHO OFF
set PATH=C:/Program Files/Keysight/SystemVue2020Update1/Tools/CMake/bin;%PATH%
@ECHO ON
mkdir build-win64-vs2017
cd build-win64-vs2017
cmake -DCMAKE_INSTALL_PREFIX=../output-vs2017 -G "Visual Studio 15 Win64" ../source
cd ..
pause
