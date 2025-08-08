-------------------------------------------------------------------------------
-- Automatically generated VHDL code for non-primitive component
-- M9703_MultiCh_Cali_InterFPGA_FPGA0_CE.vhd
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library work;
use work.p_fxp.all;


entity M9703_MultiCh_Cali_InterFPGA_FPGA0_CE is
    port (
        ce1      : out std_logic;
        ce100006 : out std_logic;
        ce2      : out std_logic;
        clk      : in  std_logic;
        en       : in  std_logic;
        rst      : in  std_logic);
end M9703_MultiCh_Cali_InterFPGA_FPGA0_CE;


architecture M9703_MultiCh_Cali_InterFPGA_FPGA0_CE_Arch of M9703_MultiCh_Cali_InterFPGA_FPGA0_CE is
    
    component EnableGenerator
        generic (
            DivisionFactor : integer);
        port (
            ce  : out std_logic;
            clk : in  std_logic;
            en  : in  std_logic;
            rst : in  std_logic);
    end component;
    

begin
    
    EnableGenerator1 : EnableGenerator
    generic map (
        DivisionFactor => 1)
    port map (
        ce  => ce1,
        clk => clk,
        en  => en,
        rst => rst);
    
    
    EnableGenerator100006 : EnableGenerator
    generic map (
        DivisionFactor => 100006)
    port map (
        ce  => ce100006,
        clk => clk,
        en  => en,
        rst => rst);
    
    
    EnableGenerator2 : EnableGenerator
    generic map (
        DivisionFactor => 2)
    port map (
        ce  => ce2,
        clk => clk,
        en  => en,
        rst => rst);
    

end M9703_MultiCh_Cali_InterFPGA_FPGA0_CE_Arch;


