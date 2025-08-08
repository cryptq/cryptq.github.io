#include this if you want to use MKL in your model library

macro( SVU_LINK_MKL_SUB_FUNC _TARGET_NAME _SVU_MKL_DIR )
	set_target_properties( ${_TARGET_NAME} PROPERTIES
		COMPILE_FLAGS -I"${_SVU_MKL_DIR}/include"
	)

	
	if ( NOT SYSTEMVUE_BUILD_WITH_WIRELESS )
		if ( UNIX )
			target_link_libraries( ${_TARGET_NAME} ${SystemVueInstallDirectory}/ModelBuilder/lib/${SVU_ARCH}/libSystemVueMath.so )
		else ()
			target_link_libraries( ${_TARGET_NAME} ${SystemVueInstallDirectory}/ModelBuilder/lib/${SVU_ARCH}/SystemVueMath.lib )
		endif ()
	else()
		target_link_libraries(  ${_TARGET_NAME}  SystemVueMath )
	endif()

	if ( CMAKE_CXX_SIZEOF_DATA_PTR EQUAL 8 )
		# 64-bit project
		if (UNIX)
		#TARGET_LINK_LIBRARIES( ${_TARGET_NAME}
		#	${_SVU_MKL_DIR}/lib/intel64/libmkl_intel_lp64.so
		#	${_SVU_MKL_DIR}/lib/intel64/libmkl_sequential.so
		#	${_SVU_MKL_DIR}/lib/intel64/libmkl_core.so	
		#)
		#TARGET_LINK_LIBRARIES(  ${_TARGET_NAME}  SystemVueMath )
		else ()
		#TARGET_LINK_LIBRARIES( ${_TARGET_NAME}
		#	${_SVU_MKL_DIR}/lib/intel64/mkl_intel_lp64.lib
		#	${_SVU_MKL_DIR}/lib/intel64/mkl_sequential.lib
		#	${_SVU_MKL_DIR}/lib/intel64/mkl_core.lib
		#)
		#TARGET_LINK_LIBRARIES(  ${_TARGET_NAME}  SystemVueMath )
		endif ()
	else ()
		# 32-bit project

		if( MSVC11 )
			set_target_properties( ${_TARGET_NAME} PROPERTIES
				LINK_FLAGS  " /SAFESEH:NO"
			)
		endif()

		#TARGET_LINK_LIBRARIES( ${_TARGET_NAME}
		#	${_SVU_MKL_DIR}/lib/ia32/mkl_intel_c.lib
		#	${_SVU_MKL_DIR}/lib/ia32/mkl_sequential.lib
		#	${_SVU_MKL_DIR}/lib/ia32/mkl_core.lib
		#)
		#TARGET_LINK_LIBRARIES(  ${_TARGET_NAME}  SystemVueMath )
	endif ( CMAKE_CXX_SIZEOF_DATA_PTR EQUAL 8 )
endmacro( SVU_LINK_MKL_SUB_FUNC _TARGET_NAME _SVU_MKL_DIR )

macro( SVU_LINK_MKL _TARGET_NAME)
	if(DEFINED ENV{SV_EXTERNAL_DIR})
		set( EXTERNAL_DIR $ENV{SV_EXTERNAL_DIR})
	else()
		set( EXTERNAL_DIR ${WIRELESS_SOURCE_DIRECTORY}/../External)
	endif()

	if (UNIX)
		SVU_LINK_MKL_SUB_FUNC( ${_TARGET_NAME}
			${EXTERNAL_DIR}/IntelMKL/11.0.2.146
		)
	else ()
		SVU_LINK_MKL_SUB_FUNC( ${_TARGET_NAME}
			${EXTERNAL_DIR}/IntelMKL/11.0.2.149
		)
	endif ()
endmacro( SVU_LINK_MKL _TARGET_NAME)

macro( SVU_LINK_MKL_COMMERCIAL _TARGET_NAME)
  #please install Intel_MKL in the default directory; otherwise we need to modify the cmake file manually here
	if(EXISTS "C:/Program Files/Intel/MKL")
	  set( MKL_INSTALL_DIR "C:/Program Files/Intel/MKL/11.0.2.149")
	else()
		set( MKL_INSTALL_DIR "C:/Program Files (x86)/Intel/MKL/11.0.2.149")
	endif()

		SVU_LINK_MKL_SUB_FUNC( ${_TARGET_NAME}
			${EXTERNAL_DIR} ${MKL_INSTALL_DIR}
		)
endmacro( SVU_LINK_MKL_COMMERCIAL _TARGET_NAME)
