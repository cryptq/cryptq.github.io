cd /d "F:\Ben\EEsof\FPGA\M9703\Workspace_201608\U5303\U5303_2x2MIMO\FPGA0\project\SystemVueCore"

cd ..\Implementation

"C:\Xilinx\14.7\ISE_DS\ISE\bin\nt64\data2mem.exe" -bm src/rom/u53xx_fdk_top_bd.bmm -bt u53xx_fdk_top.bit -bd src/rom/fwid.mem tag id_rom -o b temp0.bit
"C:\Xilinx\14.7\ISE_DS\ISE\bin\nt64\data2mem.exe" -bm src/rom/u53xx_fdk_top_bd.bmm -bt temp0.bit -bd src/rom/u5303_fdk-pcie_csr.mem tag pcie_csr_rom -o b temp1.bit
"C:\Xilinx\14.7\ISE_DS\ISE\bin\nt64\data2mem.exe" -bm src/rom/u53xx_fdk_top_bd.bmm -bt temp1.bit -bd src/rom/pcie_bufid_base.mem tag pcie_bufid_rom_0 -o b temp2.bit
"C:\Xilinx\14.7\ISE_DS\ISE\bin\nt64\data2mem.exe" -bm src/rom/u53xx_fdk_top_bd.bmm -bt temp2.bit -bd src/rom/pcie_bufid_high.mem tag pcie_bufid_rom_1 -o b ../../bitfiles/U5303ADPULX2FDK.bit
del temp0.bit temp1.bit temp2.bit
