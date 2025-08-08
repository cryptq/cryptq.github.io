cmake_minimum_required(VERSION 3.1.1)

set( SystemVueInstallDirectory "C:/Program Files/Keysight/SystemVue2020Update1/")

include ( ${SystemVueInstallDirectory}/ModelBuilder/CMake/ModelBuilder.cmake )

project( CustomUIModel )

add_subdirectory( SystemVue )
