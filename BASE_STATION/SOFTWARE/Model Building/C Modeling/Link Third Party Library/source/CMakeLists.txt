cmake_minimum_required(VERSION 3.1.1)

if( NOT UNIX )
	#Path to SystemVue installer directory on Windows.
	set( SystemVueInstallDirectory "C:/Program Files/Keysight/SystemVue2020Update1/")
else()
	#Path to SystemVue code generation libraries Linux.
	set( SystemVueInstallDirectory "$ENV{HOME}/SystemVue/2020Update1")
endif()

include ( ${SystemVueInstallDirectory}/ModelBuilder/CMake/CodeGeneration.cmake )

project( RemezLPF )

add_subdirectory( SystemVue )
