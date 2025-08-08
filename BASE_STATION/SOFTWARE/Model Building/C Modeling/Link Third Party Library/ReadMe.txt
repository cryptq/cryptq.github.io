========================================================================
   Build SystemVue Model Builder project to create RemezLPF model
========================================================================
Here are the steps to build the model DLL
(1) Copy the Link Third Party Library directory into another directory.
(2) Run Configure-for-win64-vs2017.bat
(3) In the directory build-win64-vs2017 open the solution RemezLPF.sln in
	Visual Studio, right click on INSTALL and select Build from the dropdown menu.
(4) RemezLPF.dll will be located under the "output" directory
	that will be created after the successful build.
(5) In SystemVue use Library Manager to add RemezLPF.dll and make RemezLPF
	model available in the Part Selector.

Note: this example illustrates using a third party library to build your
custom model. The project was created in SystemVue following the usual process
and then an Open Source remez library was added to the source. In a typical
directory structure there is an include folder with the header files, and
separate folders for link libraries for different platforms, such as Windows and
Linux in this example. Those items must be listed in source/SystemVue/CMakeLists.txt.

The line
	include_directories( "${CMAKE_SOURCE_DIR}/remez/include" )
adds the include folder so that the include files can be just added to the code
with the #include directive.

The lines
	if (WIN32)
		target_link_libraries( SystemVue-RemezLPF PRIVATE "${CMAKE_SOURCE_DIR}/remez/windows/remez.lib" )
	else ()
		target_link_libraries( SystemVue-RemezLPF PUBLIC "${CMAKE_SOURCE_DIR}/remez/linux/libremez.so" )
	endif ()
add appropriate link libraries for each platform. Windows libraries must have PRIVATE
qualifier and Linux libraries must have PUBLIC qualifier.

In the source code the header "remez.h" is included. Since the third party library
was compiled as a C library, it needs extern "C" around the #include directive. If
it were a C++ library then extern "C" would not be added.

The model code simply prepares the arguments and calls
	remez(h, numtaps, numband, bands, des, weight, BANDPASS)
to design a lowpass filter. The CMake commands added to source/SystemVue/CMakeLists.txt
make it possible to build the model and then you need to make sure the model
library is in the search path. In this case remez.dll is already in the SystemVue
bin directory so it doesn't need to be added, but if it weren't then its path would need
to be added to the PATH variable before SystemVue is started.
