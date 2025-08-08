cmake_minimum_required(VERSION 2.8.10)

set( SystemVueInstallDirectory "C:/Program Files/Keysight/SystemVue2020Update1/")

include ( ${SystemVueInstallDirectory}/ModelBuilder/CMake/CodeGeneration.cmake )

project( LTE_BEL )

add_subdirectory( LTE_BEL_Eval )

