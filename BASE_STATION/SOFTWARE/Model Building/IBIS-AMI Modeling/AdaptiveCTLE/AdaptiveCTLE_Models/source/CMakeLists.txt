cmake_minimum_required(VERSION 2.8.10)

if( NOT UNIX )
	#Path to SystemVue installer directory on Windows.
	set( SystemVueInstallDirectory "C:/Program Files/Keysight/SystemVue2020Update1/")
else()
	#Path to SystemVue code generation libraries Linux.
	set( SystemVueInstallDirectory "$ENV{HOME}/SystemVue/2020")
endif()

# SystemVueInstallDirectory defined in ../CMakeLists.txt
include ( ${SystemVueInstallDirectory}/ModelBuilder/CMake/CodeGeneration.cmake )

# SystemVue code generation maintains this variable, do not add files to this variable
set ( SVU_GENERATED_FILES
	CTLE_Control.h
	CTLE_Control.cpp
	LibraryProperties.cpp
)

# Change content below as necessary. For example, add more files, etc.

# Add a new model easily from a template by using the SVU_CREATE_MODEL macro as commented
# out below.  See the documentation for more details.
# You will need to add the generated source as shown in the commented out files below inside
# the SVU_ADD_MODELBUILDER_LIBRARY area.
# SVU_CREATE_MODEL ( MyCustomModel )

# Uncomment the lines below to customize the version information for your DLL.
# On the PC the info will show either by mousing-over your DLL or right
# clicking on the DLL and inspecting Properties -> Details.  
#
# The version numbers below, can be up to 4 integers separated by periods.  For
# example, "1.20.22.3".   For more details, refer to the SystemVue documentation.
SVU_CREATE_VERSION_FILE(
	VERSION_FILE
	# FILE_VERSION 1.0
	# COMPANY_NAME "My Company Name"
	# COPYRIGHT "(c) My Company Name, "
	# PRODUCT_NAME "My Product Name"
	# PRODUCT_VERSION 1.0
	TARGET_TYPE "Model Library"
)

SVU_ADD_CG_MODELBUILDER_LIBRARY(
	SystemVue-AdaptiveCTLE
	${SVU_GENERATED_FILES}
	${VERSION_FILE}
	CTLE_BPF.h
	CTLE_BPF.cpp
	CTLE_Detection.h
	CTLE_Detection.cpp
	CTLE_FIR.h
	CTLE_FIR.cpp
	VtCTLE_FIR.h
	VtCTLE_FIR.cpp
)

SVU_INSTALL_MODELBUILDER_LIBRARY( SystemVue-AdaptiveCTLE )
