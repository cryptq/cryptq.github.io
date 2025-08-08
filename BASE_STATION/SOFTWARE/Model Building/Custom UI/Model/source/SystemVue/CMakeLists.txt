cmake_minimum_required(VERSION 3.1.1)

# SystemVueInstallDirectory defined in ../CMakeLists.txt
include ( ${SystemVueInstallDirectory}/ModelBuilder/CMake/ModelBuilder.cmake )

# SystemVue code generation maintains this variable, do not add files to this variable
set ( SVU_GENERATED_FILES 
	CMakeLists.txt
	LibraryProperties.cpp
)

# Change content below as necessary. For example, add more files, etc.

# Add a new model easily from a template by using the SVU_CREATE_MODEL macro as commented
# out below.  See the documentation for more details.
# You will need to add the generated source as shown in the commented out files below inside
# the SVU_ADD_MODELBUILDER_LIBRARY area.

#SVU_CREATE_MODEL ( MyCustomModel )

SVU_ADD_MODELBUILDER_LIBRARY(
	SystemVue-CustomUIModel
	${SVU_GENERATED_FILES}
	SineGenerator.h
	SineGenerator.cpp
)

SVU_INSTALL_MODELBUILDER_LIBRARY( SystemVue-CustomUIModel )
