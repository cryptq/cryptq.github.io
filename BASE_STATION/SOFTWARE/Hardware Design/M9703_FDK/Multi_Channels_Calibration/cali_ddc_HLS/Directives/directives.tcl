############################################################
## This file is generated automatically by Vivado HLS.
## Please DO NOT edit it.
## Copyright (C) 2014 Xilinx Inc. All rights reserved.
############################################################
set_directive_array_reshape -type complete -dim 1 "DownResample" input
set_directive_array_partition -type complete -dim 1 "DownResample" DDC_freq_norm
set_directive_interface -mode ap_ovld -register "DownResample" output
set_directive_pipeline "DownResample"
set_directive_interface -mode ap_ctrl_none "DownResample"
set_directive_inline -recursive "DownResample"
set_directive_array_reshape -type complete -dim 1 "DownResample" output
set_directive_reset "DDC" phaseAcc
set_directive_array_partition -type complete -dim 1 "DownResample" reconfigcoef
