cmake_minimum_required(VERSION 2.8.10)

# SystemVueInstallDirectory defined in ../CMakeLists.txt
include ( ${SystemVueInstallDirectory}/ModelBuilder/CMake/CodeGeneration.cmake )

# Change content below as necessary. For example, add more files, etc.

SVU_ADD_CG_MODELBUILDER_LIBRARY(
	LTE_BEL_Eval
	LTE_CRC.cc
	LTE_CRC.h
	LTE_DFParams.cpp
	LTE_DFParams.h
	LTE_RangeCheck.cpp
	LTE_RangeCheck.h
	SDFLTE_CRCEncoder.cpp
	SDFLTE_CRCEncoder.h
)

# SVU_INSTALL_MODELBUILDER_LIBRARY( LTE_BEL_Eval )
