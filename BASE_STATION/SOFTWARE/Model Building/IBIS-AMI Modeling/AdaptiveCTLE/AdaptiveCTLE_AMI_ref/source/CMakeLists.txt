cmake_minimum_required(VERSION 2.8.10)

if( NOT UNIX )
	#Path to SystemVue installer directory on Windows.
	set( SystemVueInstallDirectory "C:/Program Files/Keysight/SystemVue2020Update1/")
else()
	#Path to SystemVue code generation libraries Linux.
	set( SystemVueInstallDirectory "$ENV{HOME}/SystemVue/2020")
endif()

include ( ${SystemVueInstallDirectory}/ModelBuilder/CMake/CodeGeneration.cmake )

project( AdaptiveCTLE_AMI )

add_subdirectory( AMI-RxAdaptiveCTLE )
