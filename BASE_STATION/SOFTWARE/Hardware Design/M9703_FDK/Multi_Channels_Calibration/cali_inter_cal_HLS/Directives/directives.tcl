############################################################
## This file is generated automatically by Vivado HLS.
## Please DO NOT edit it.
## Copyright (C) 2014 Xilinx Inc. All rights reserved.
############################################################
set_directive_reset "InterFPGA_cali" FreqSampleIndex
set_directive_resource -core RAM_1P_LUTRAM "InterFPGA_cali" ImbalanceOut
set_directive_interface -mode axis "InterFPGA_cali" InFromUpFPGA
set_directive_interface -mode axis "InterFPGA_cali" InFromLocalFPGA
set_directive_interface -mode axis "InterFPGA_cali" OutToDownFPGA
set_directive_resource -core RAM_1P_BRAM "InterFPGA_cali" UpFPGADataFIFO
set_directive_pipeline "InterFPGA_cali/for3"
set_directive_pipeline "InterFPGA_cali/for4"
set_directive_interface -mode ap_none "InterFPGA_cali" IsSourceFPGA
set_directive_resource -core RAM_1P_BRAM "InterFPGA_cali" LocalFPGADataFIFO
set_directive_interface -mode ap_none "InterFPGA_cali" IsEndFPGA
