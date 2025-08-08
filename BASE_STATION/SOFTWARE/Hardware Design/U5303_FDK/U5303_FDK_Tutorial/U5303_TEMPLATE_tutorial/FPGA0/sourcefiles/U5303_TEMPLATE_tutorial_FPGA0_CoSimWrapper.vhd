-------------------------------------------------------------------------------
-- Automatically generated VHDL code for non-primitive component
-- U5303_TEMPLATE_tutorial_FPGA0_CoSimWrapper.vhd
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library work;
use work.p_fxp.all;


entity U5303_TEMPLATE_tutorial_FPGA0_CoSimWrapper is
    port (
        ADC1       : in  std_logic_vector(15 downto 0);
        ADC10      : in  std_logic_vector(15 downto 0);
        ADC11      : in  std_logic_vector(15 downto 0);
        ADC12      : in  std_logic_vector(15 downto 0);
        ADC13      : in  std_logic_vector(15 downto 0);
        ADC14      : in  std_logic_vector(15 downto 0);
        ADC15      : in  std_logic_vector(15 downto 0);
        ADC16      : in  std_logic_vector(15 downto 0);
        ADC17      : in  std_logic_vector(15 downto 0);
        ADC18      : in  std_logic_vector(15 downto 0);
        ADC19      : in  std_logic_vector(15 downto 0);
        ADC2       : in  std_logic_vector(15 downto 0);
        ADC20      : in  std_logic_vector(15 downto 0);
        ADC21      : in  std_logic_vector(15 downto 0);
        ADC22      : in  std_logic_vector(15 downto 0);
        ADC23      : in  std_logic_vector(15 downto 0);
        ADC24      : in  std_logic_vector(15 downto 0);
        ADC25      : in  std_logic_vector(15 downto 0);
        ADC26      : in  std_logic_vector(15 downto 0);
        ADC27      : in  std_logic_vector(15 downto 0);
        ADC28      : in  std_logic_vector(15 downto 0);
        ADC29      : in  std_logic_vector(15 downto 0);
        ADC3       : in  std_logic_vector(15 downto 0);
        ADC30      : in  std_logic_vector(15 downto 0);
        ADC31      : in  std_logic_vector(15 downto 0);
        ADC32      : in  std_logic_vector(15 downto 0);
        ADC4       : in  std_logic_vector(15 downto 0);
        ADC5       : in  std_logic_vector(15 downto 0);
        ADC6       : in  std_logic_vector(15 downto 0);
        ADC7       : in  std_logic_vector(15 downto 0);
        ADC8       : in  std_logic_vector(15 downto 0);
        ADC9       : in  std_logic_vector(15 downto 0);
        ADCValidIn : in  std_logic_vector(0 downto 0);
        DataOut1   : out std_logic_vector(15 downto 0);
        DataOut2   : out std_logic_vector(15 downto 0);
        ReadyIn1   : in  std_logic_vector(0 downto 0);
        Register1  : in  std_logic_vector(0 downto 0);
        ValidOut1  : out std_logic_vector(0 downto 0);
        ce         : in  std_logic;
        clk        : in  std_logic;
        rst        : in  std_logic);
end U5303_TEMPLATE_tutorial_FPGA0_CoSimWrapper;


architecture U5303_TEMPLATE_tutorial_FPGA0_CoSimWrapper_Arch of U5303_TEMPLATE_tutorial_FPGA0_CoSimWrapper is
    
    component U5303_TEMPLATE_tutorial_FPGA0_CE
        port (
            ce1 : out std_logic;
            clk : in  std_logic;
            en  : in  std_logic;
            rst : in  std_logic);
    end component;
    
    component U5303_TEMPLATE_tutorial_FPGA0
        port (
            ADC1       : in  std_logic_vector(15 downto 0);
            ADC10      : in  std_logic_vector(15 downto 0);
            ADC11      : in  std_logic_vector(15 downto 0);
            ADC12      : in  std_logic_vector(15 downto 0);
            ADC13      : in  std_logic_vector(15 downto 0);
            ADC14      : in  std_logic_vector(15 downto 0);
            ADC15      : in  std_logic_vector(15 downto 0);
            ADC16      : in  std_logic_vector(15 downto 0);
            ADC17      : in  std_logic_vector(15 downto 0);
            ADC18      : in  std_logic_vector(15 downto 0);
            ADC19      : in  std_logic_vector(15 downto 0);
            ADC2       : in  std_logic_vector(15 downto 0);
            ADC20      : in  std_logic_vector(15 downto 0);
            ADC21      : in  std_logic_vector(15 downto 0);
            ADC22      : in  std_logic_vector(15 downto 0);
            ADC23      : in  std_logic_vector(15 downto 0);
            ADC24      : in  std_logic_vector(15 downto 0);
            ADC25      : in  std_logic_vector(15 downto 0);
            ADC26      : in  std_logic_vector(15 downto 0);
            ADC27      : in  std_logic_vector(15 downto 0);
            ADC28      : in  std_logic_vector(15 downto 0);
            ADC29      : in  std_logic_vector(15 downto 0);
            ADC3       : in  std_logic_vector(15 downto 0);
            ADC30      : in  std_logic_vector(15 downto 0);
            ADC31      : in  std_logic_vector(15 downto 0);
            ADC32      : in  std_logic_vector(15 downto 0);
            ADC4       : in  std_logic_vector(15 downto 0);
            ADC5       : in  std_logic_vector(15 downto 0);
            ADC6       : in  std_logic_vector(15 downto 0);
            ADC7       : in  std_logic_vector(15 downto 0);
            ADC8       : in  std_logic_vector(15 downto 0);
            ADC9       : in  std_logic_vector(15 downto 0);
            ADCValidIn : in  std_logic_vector(0 downto 0);
            DataOut1   : out std_logic_vector(15 downto 0);
            DataOut2   : out std_logic_vector(15 downto 0);
            ReadyIn1   : in  std_logic_vector(0 downto 0);
            Register1  : in  std_logic_vector(0 downto 0);
            ValidOut1  : out std_logic_vector(0 downto 0);
            ce1        : in  std_logic;
            clk        : in  std_logic;
            rst        : in  std_logic);
    end component;
    
    signal ce1 : std_logic;

begin
    
    U5303_TEMPLATE_tutorial_FPGA0_CE_inst : U5303_TEMPLATE_tutorial_FPGA0_CE
    port map (
        ce1 => ce1,
        clk => clk,
        en  => ce,
        rst => rst);
    
    
    U5303_TEMPLATE_tutorial_FPGA0_inst : U5303_TEMPLATE_tutorial_FPGA0
    port map (
        ADC1       => ADC1,
        ADC10      => ADC10,
        ADC11      => ADC11,
        ADC12      => ADC12,
        ADC13      => ADC13,
        ADC14      => ADC14,
        ADC15      => ADC15,
        ADC16      => ADC16,
        ADC17      => ADC17,
        ADC18      => ADC18,
        ADC19      => ADC19,
        ADC2       => ADC2,
        ADC20      => ADC20,
        ADC21      => ADC21,
        ADC22      => ADC22,
        ADC23      => ADC23,
        ADC24      => ADC24,
        ADC25      => ADC25,
        ADC26      => ADC26,
        ADC27      => ADC27,
        ADC28      => ADC28,
        ADC29      => ADC29,
        ADC3       => ADC3,
        ADC30      => ADC30,
        ADC31      => ADC31,
        ADC32      => ADC32,
        ADC4       => ADC4,
        ADC5       => ADC5,
        ADC6       => ADC6,
        ADC7       => ADC7,
        ADC8       => ADC8,
        ADC9       => ADC9,
        ADCValidIn => ADCValidIn,
        DataOut1   => DataOut1,
        DataOut2   => DataOut2,
        ReadyIn1   => ReadyIn1,
        Register1  => Register1,
        ValidOut1  => ValidOut1,
        ce1        => ce1,
        clk        => clk,
        rst        => rst);
    

end U5303_TEMPLATE_tutorial_FPGA0_CoSimWrapper_Arch;


