cmake_minimum_required(VERSION 2.8.10)

# SystemVueInstallDirectory defined in ../CMakeLists.txt
include ( ${SystemVueInstallDirectory}/ModelBuilder/CMake/CodeGeneration.cmake )

# SystemVue code generation maintains this variable, do not add files to this variable
set ( SVU_GENERATED_FILES
	RxAdaptiveCTLE_AMI.h
	RxAdaptiveCTLE_AMI.cpp
	RxAdaptiveCTLE.ami
	RxAdaptiveCTLE.h
	RxAdaptiveCTLE.cpp
	../../../AdaptiveCTLE_Models/source/CTLE_BPF.cpp
	../../../AdaptiveCTLE_Models/source/CTLE_BPF.h
	../../../AdaptiveCTLE_Models/source/CTLE_Control.cpp
	../../../AdaptiveCTLE_Models/source/CTLE_Control.h
	../../../AdaptiveCTLE_Models/source/CTLE_Detection.cpp
	../../../AdaptiveCTLE_Models/source/CTLE_Detection.h
	../../../AdaptiveCTLE_Models/source/CTLE_FIR.cpp
	../../../AdaptiveCTLE_Models/source/CTLE_FIR.h
	../../../AdaptiveCTLE_Models/source/VtCTLE_FIR.cpp
	../../../AdaptiveCTLE_Models/source/VtCTLE_FIR.h
)

# Change content below as necessary. For example, add more files, etc.

# Uncomment the lines below to customize the version information for your DLL.
# On the PC the info will show either by mousing-over your DLL or right
# clicking on the DLL and inspecting Properties -> Details.  On Linux, use the
# "ident" command to see the information.
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
	TARGET_TYPE "IBIS-AMI Model"
)

# Uncomment lines below to customize compiler version, file version,
# platforms, and company name for the auto-generated IBS file. Do NOT 
# update the TX_MODEL_NAME, RX_MODEL_NAME, IBS_FILE_NAME lines as 
# these are maintained by SystemVue Code Generation.
#
# If you want to turn off the IBS file generation comment or 
# delete the SVU_CREATE_IBS_FILE macro as well as the line 
# referencing the .ibs file inside the SVU_ADD_AMI_LIBRARY 
# macro further down in this file.
#
# If you turn off IBS file generation, you will have to 
# provide your own IBS file.
SVU_CREATE_IBS_FILE (
	# TX_MODEL_NAME TxModelName
	RX_MODEL_NAME RxAdaptiveCTLE
	IBS_FILE_NAME RxAdaptiveCTLE.ibs
	# MSVC_VERSION 19.16.27030.1		# VS 2017
	# GCC_VERSION 4.9.2
	# FILE_VERSION 1.0
	# PLATFORMS Win64 Linux64
	# COMPANY_NAME "My Company Name"
)

SVU_ADD_AMI_LIBRARY(
	AMI-RxAdaptiveCTLE
	${SVU_GENERATED_FILES}
	${CUSTOM_LIB_SOURCES}
	${VERSION_FILE}
	${CMAKE_CURRENT_BINARY_DIR}/RxAdaptiveCTLE.ibs
)

SVU_INSTALL_AMI_MODEL( AMI-RxAdaptiveCTLE )
