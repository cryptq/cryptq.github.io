@ECHO OFF
set PATH=C:\Program Files\Keysight\SystemVue2020Update1\Tools\CMake\bin\;%PATH%;
@ECHO ON
mkdir build-win64
cd build-win64
cmake -DCMAKE_INSTALL_PREFIX=../output -G "Visual Studio 15 Win64" ../
cd ..
pause
