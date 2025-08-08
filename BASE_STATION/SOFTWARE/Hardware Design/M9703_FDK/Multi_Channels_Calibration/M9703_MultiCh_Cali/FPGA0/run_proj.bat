cd /d "C:\Ben\EEsof\FPGA\MPO\M9703\201410_release\Example\MultiChannel_Cali_with_InterFPGA\M9703_MultiCh_Cali\FPGA0\project\SystemVueCore"
"C:\Xilinx\14.7\ISE_DS\ISE\bin\nt64\xtclsh.exe" systemvuecore.tcl axis_1x1_interconnect run_coregen
"C:\Xilinx\14.7\ISE_DS\ISE\bin\nt64\xtclsh.exe" systemvuecore.tcl rebuild_project
cd ..
"C:\Xilinx\14.7\ISE_DS\ISE\bin\nt64\xtclsh.exe" m9703_fdk_top.tcl rebuild_project
"C:\Xilinx\14.7\ISE_DS\ISE\bin\nt64\data2mem.exe" -bm src/rom/m9703_fdk_top_bd.bmm -bt m9703_fdk_top.bit -bd src/rom/pcie_bufid_base.mem tag pcie_bufid_rom_0 -o b temp.bit
"C:\Xilinx\14.7\ISE_DS\ISE\bin\nt64\data2mem.exe" -bm src/rom/m9703_fdk_top_bd.bmm -bt temp.bit -bd src/rom/pcie_bufid_high.mem tag pcie_bufid_rom_1 -o b ../bitfiles/M9703ADPULX2FDK.bit
del temp.bit
