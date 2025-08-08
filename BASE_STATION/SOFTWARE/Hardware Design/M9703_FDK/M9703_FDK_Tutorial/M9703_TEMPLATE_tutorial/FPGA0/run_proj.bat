cd /d "F:\Ben\EEsof\FPGA\M9703\Workspace_201608\M9703\M9703_TEMPLATE_tutorial\FPGA0\project\SystemVueCore"
"C:\Xilinx\14.7\ISE_DS\ISE\bin\nt64\xtclsh.exe" systemvuecore.tcl axis_1x1_interconnect run_coregen
"C:\Xilinx\14.7\ISE_DS\ISE\bin\nt64\xtclsh.exe" systemvuecore.tcl rebuild_project
copy /y "SystemVue_core_wrapper.ngc" "SystemVue_core_wrapper_256_64_256_64.ngc"
cd ..\Implementation
"C:\Xilinx\14.7\ISE_DS\ISE\bin\nt64\xtclsh.exe" m9703_fdk_top-LX2-SR2-EXTIO_2.tcl rebuild_project
"C:\Xilinx\14.7\ISE_DS\ISE\bin\nt64\data2mem.exe" -bm src/rom/m97xx_fdk_top_bd.bmm -bt m97XX_fdk_top.bit -bd src/rom/fwid.mem tag id_rom -o b temp0.bit
"C:\Xilinx\14.7\ISE_DS\ISE\bin\nt64\data2mem.exe" -bm src/rom/m97xx_fdk_top_bd.bmm -bt temp0.bit -bd src/rom/pcie_bufid_base.mem tag pcie_bufid_rom_0 -o b temp1.bit
"C:\Xilinx\14.7\ISE_DS\ISE\bin\nt64\data2mem.exe" -bm src/rom/m97xx_fdk_top_bd.bmm -bt temp1.bit -bd src/rom/pcie_bufid_high.mem tag pcie_bufid_rom_1 -o b ../../bitfiles/M9703ADPULX2FDK.bit
del temp0.bit temp1.bit
