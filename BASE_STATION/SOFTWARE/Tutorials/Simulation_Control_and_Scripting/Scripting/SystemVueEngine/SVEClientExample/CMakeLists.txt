cmake_minimum_required( VERSION 2.8.10 )
project( SVEClientExample )

set( SYSTEMVUE_ROOT "C:/Program Files/Keysight/SystemVue2017" )
include_directories( "${SYSTEMVUE_ROOT}/Modelbuilder/include" )
if( WIN32 )
	if( CMAKE_SIZEOF_VOID_P EQUAL 8 )
		set( SYSTEMVUE_ARCH "Win64" )
	elseif( CMAKE_SIZEOF_VOID_P EQUAL 4 )
		set( SYSTEMVUE_ARCH "Win32" )
	endif()
endif()

if( NOT SYSTEMVUE_ARCH )
	message( FATAL_ERROR "Unknown architecture." )
endif()

find_library( SVECLIENT_LIB SVEClient "${SYSTEMVUE_ROOT}/Modelbuilder/lib/${SYSTEMVUE_ARCH}" )

add_executable( SVEClientExample
	SVEClientExample.cpp
	PassThroughExampleSimulator.cpp
	PassThroughExampleSimulator.h
)

target_link_libraries( SVEClientExample ${SVECLIENT_LIB} )
if(not WIN32)
	target_link_libraries(SVEClientExample stdc++fs)
endif()
