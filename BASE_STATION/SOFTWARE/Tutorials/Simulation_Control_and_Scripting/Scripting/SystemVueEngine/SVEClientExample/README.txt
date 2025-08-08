To build (assuming you already have Visual Studio 2015):

1. Install CMake 2.8.10 or higher.

2. In the CMakeLists.txt and the SVEClientExample.cpp, update the path to your SystemVue installation, if needed.
   Make sure to only use forward slashes, e.g. C:/Program Files/Keysight/SystemVue2017

3. Run CMake to generate a build area from this source directory. It's a good practice to create a subdirectory
   for CMake generated files and not mix them with the source files. E.g. create a subdirectory named "SVEClientBuild".
   From the Windows Command Prompt (or Visual Studio's Developer Command Prompt) cd to this source directory and run

   mkdir SVEClientBuild
   cd SVEClientBuild
   cmake -G "Visual Studio 14 Win64" ..

   CMake will generate its files inside the current directory. -G "Visual Studio 14 Win64" tells it to create a 64-bit
   Visual Studio 2015 project, and .. points to the source directory, which is above the current directory SVEClientBuild.

   Alternatively, you can use the CMake GUI to generate the project. Please see CMake documentation for details.

4. Build SVEClientExample.exe. One way to do it is to run CMake with the -build option.

   cmake --build .

   The default configuration is Debug. To build Release add it as an option.

   cmake --build . --config Release

   SVEClientExample.exe will be found under Debug or Release subdirectory, depending on the build configuration.

   Or you can simply open the generated solution SVEClientExample.sln in Visual Studio and build it there.

To run:

1. Set PATH to include the "bin" directory inside your SystemVue installation, e.g.

   set PATH=C:\Program Files\Keysight\SystemVue2017\bin;%PATH%;

   If running Visual Studio, open the project properties and in the Debugging section set Environment to
   
   PATH=C:\Program Files\Keysight\SystemVue2017\bin;%PATH%;

2. Run SVEClientExample.exe.
