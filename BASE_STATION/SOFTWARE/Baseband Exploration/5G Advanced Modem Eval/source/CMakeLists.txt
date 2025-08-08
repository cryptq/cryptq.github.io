cmake_minimum_required(VERSION 2.8.10)

if( NOT UNIX )
	#please install SystemVue in the default directory; otherwise we need to modify the cmake file manually here
	#Path to SystemVue installer directory on Windows.
	set( SystemVueInstallDirectory "C:/Program Files/Keysight/SystemVue2020Update1/")
else()
	#Path to SystemVue code generation libraries Linux.
	set( SystemVueInstallDirectory "$ENV{HOME}/SystemVue/2020/linux_x86_64/")
endif()

include ( ${SystemVueInstallDirectory}/ModelBuilder/CMake/CodeGeneration.cmake )

project( 5GAdvancedModem_BEL_Eval )

add_subdirectory( stars_vcproj )