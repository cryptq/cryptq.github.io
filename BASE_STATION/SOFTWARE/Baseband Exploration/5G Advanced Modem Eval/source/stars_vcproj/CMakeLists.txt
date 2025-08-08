cmake_minimum_required(VERSION 2.8.10)

include ( ${SystemVueInstallDirectory}/ModelBuilder/CMake/CodeGeneration.cmake )
include ( BEL.cmake )

include_directories( ${CMAKE_CURRENT_SOURCE_DIR} )

set( MODELBUILDER_LIBRARY_NAME 5GAdvancedModem_BEL_Eval )

set ( Source_Files
	../stars_vcproj/GetModelLibraryVersion.cpp
	../stars_vcproj/LibraryProperties.cpp
)

set ( SDF_Header_Files
	../stars/SDF_MIMO_Encoder.h
)

set ( SDF_Source_Files
	../stars/SDF_MIMO_Encoder.cpp

)


GET_FILENAME_COMPONENT(RESOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/../resources ABSOLUTE)

set ( RESOURCE_FILES
	../resources/5GAdvancedModem_BEL_Eval.qrc
)

source_group( Resource\ Files FILES ${RESOURCE_FILES} )
source_group( SDF\ Source\ Files FILES ${SDF_Source_Files} )
source_group( SDF\ Source\ Headers FILES ${SDF_Header_Files} )
source_group( Headers\ Files FILES ${Source_Files} )

SVU_ADD_MODELBUILDER_LIBRARY_FOR_BEL(
	${MODELBUILDER_LIBRARY_NAME}
	${RESOURCE_FILES}
	${SDF_Header_Files}
	${SDF_Source_Files}
	${Source_Files}
)