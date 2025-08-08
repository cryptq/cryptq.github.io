-------------------------------------------------------------------------------
-- Automatically generated VHDL code for non-primitive component
-- U5303_TEMPLATE_tutorial_FPGA0_CE.vhd
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library work;
use work.p_fxp.all;


entity U5303_TEMPLATE_tutorial_FPGA0_CE is
    port (
        ce1 : out std_logic;
        clk : in  std_logic;
        en  : in  std_logic;
        rst : in  std_logic);
end U5303_TEMPLATE_tutorial_FPGA0_CE;


architecture U5303_TEMPLATE_tutorial_FPGA0_CE_Arch of U5303_TEMPLATE_tutorial_FPGA0_CE is
    
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
    

end U5303_TEMPLATE_tutorial_FPGA0_CE_Arch;


