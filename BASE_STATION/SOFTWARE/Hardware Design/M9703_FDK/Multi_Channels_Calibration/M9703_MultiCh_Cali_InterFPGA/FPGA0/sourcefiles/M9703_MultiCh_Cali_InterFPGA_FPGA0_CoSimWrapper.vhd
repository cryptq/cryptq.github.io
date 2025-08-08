-------------------------------------------------------------------------------
-- Automatically generated VHDL code for non-primitive component
-- M9703_MultiCh_Cali_InterFPGA_FPGA0_CoSimWrapper.vhd
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library work;
use work.p_fxp.all;


entity M9703_MultiCh_Cali_InterFPGA_FPGA0_CoSimWrapper is
    port (
        ADC1          : in  std_logic_vector(15 downto 0);
        ADC10         : in  std_logic_vector(15 downto 0);
        ADC11         : in  std_logic_vector(15 downto 0);
        ADC12         : in  std_logic_vector(15 downto 0);
        ADC13         : in  std_logic_vector(15 downto 0);
        ADC14         : in  std_logic_vector(15 downto 0);
        ADC15         : in  std_logic_vector(15 downto 0);
        ADC16         : in  std_logic_vector(15 downto 0);
        ADC17         : in  std_logic_vector(15 downto 0);
        ADC18         : in  std_logic_vector(15 downto 0);
        ADC19         : in  std_logic_vector(15 downto 0);
        ADC2          : in  std_logic_vector(15 downto 0);
        ADC20         : in  std_logic_vector(15 downto 0);
        ADC21         : in  std_logic_vector(15 downto 0);
        ADC22         : in  std_logic_vector(15 downto 0);
        ADC23         : in  std_logic_vector(15 downto 0);
        ADC24         : in  std_logic_vector(15 downto 0);
        ADC25         : in  std_logic_vector(15 downto 0);
        ADC26         : in  std_logic_vector(15 downto 0);
        ADC27         : in  std_logic_vector(15 downto 0);
        ADC28         : in  std_logic_vector(15 downto 0);
        ADC29         : in  std_logic_vector(15 downto 0);
        ADC3          : in  std_logic_vector(15 downto 0);
        ADC30         : in  std_logic_vector(15 downto 0);
        ADC31         : in  std_logic_vector(15 downto 0);
        ADC32         : in  std_logic_vector(15 downto 0);
        ADC4          : in  std_logic_vector(15 downto 0);
        ADC5          : in  std_logic_vector(15 downto 0);
        ADC6          : in  std_logic_vector(15 downto 0);
        ADC7          : in  std_logic_vector(15 downto 0);
        ADC8          : in  std_logic_vector(15 downto 0);
        ADC9          : in  std_logic_vector(15 downto 0);
        ADCValidIn    : in  std_logic_vector(0 downto 0);
        BlockRegAddr1 : out std_logic_vector(4 downto 0);
        BlockRegAddr2 : out std_logic_vector(4 downto 0);
        BlockRegData1 : in  std_logic_vector(15 downto 0);
        BlockRegData2 : in  std_logic_vector(15 downto 0);
        BlockRegRd1   : out std_logic_vector(0 downto 0);
        BlockRegRd2   : out std_logic_vector(0 downto 0);
        DataOut1      : out std_logic_vector(43 downto 0);
        DownInDataP   : in  std_logic_vector(63 downto 0);
        DownInValidP  : in  std_logic_vector(0 downto 0);
        DownOutDataP  : out std_logic_vector(63 downto 0);
        DownOutReadyP : in  std_logic_vector(0 downto 0);
        DownOutValidP : out std_logic_vector(0 downto 0);
        ReadyIn1      : in  std_logic_vector(0 downto 0);
        Register1     : in  std_logic_vector(15 downto 0);
        Register10    : in  std_logic_vector(31 downto 0);
        Register11    : in  std_logic_vector(0 downto 0);
        Register12    : in  std_logic_vector(0 downto 0);
        Register2     : in  std_logic_vector(0 downto 0);
        Register3     : in  std_logic_vector(31 downto 0);
        Register4     : in  std_logic_vector(31 downto 0);
        Register5     : in  std_logic_vector(31 downto 0);
        Register6     : in  std_logic_vector(31 downto 0);
        Register7     : in  std_logic_vector(31 downto 0);
        Register8     : in  std_logic_vector(31 downto 0);
        Register9     : in  std_logic_vector(31 downto 0);
        UpInDataP     : in  std_logic_vector(63 downto 0);
        UpInValidP    : in  std_logic_vector(0 downto 0);
        UpOutDataP    : out std_logic_vector(63 downto 0);
        UpOutReadyP   : in  std_logic_vector(0 downto 0);
        UpOutValidP   : out std_logic_vector(0 downto 0);
        ValidOut1     : out std_logic_vector(0 downto 0);
        ce            : in  std_logic;
        clk           : in  std_logic;
        rst           : in  std_logic);
end M9703_MultiCh_Cali_InterFPGA_FPGA0_CoSimWrapper;


architecture M9703_MultiCh_Cali_InterFPGA_FPGA0_CoSimWrapper_Arch of M9703_MultiCh_Cali_InterFPGA_FPGA0_CoSimWrapper is
    
    component M9703_MultiCh_Cali_InterFPGA_FPGA0_CE
        port (
            ce1      : out std_logic;
            ce100006 : out std_logic;
            ce2      : out std_logic;
            clk      : in  std_logic;
            en       : in  std_logic;
            rst      : in  std_logic);
    end component;
    
    component M9703_MultiCh_Cali_InterFPGA_FPGA0
        port (
            ADC1          : in  std_logic_vector(15 downto 0);
            ADC10         : in  std_logic_vector(15 downto 0);
            ADC11         : in  std_logic_vector(15 downto 0);
            ADC12         : in  std_logic_vector(15 downto 0);
            ADC13         : in  std_logic_vector(15 downto 0);
            ADC14         : in  std_logic_vector(15 downto 0);
            ADC15         : in  std_logic_vector(15 downto 0);
            ADC16         : in  std_logic_vector(15 downto 0);
            ADC17         : in  std_logic_vector(15 downto 0);
            ADC18         : in  std_logic_vector(15 downto 0);
            ADC19         : in  std_logic_vector(15 downto 0);
            ADC2          : in  std_logic_vector(15 downto 0);
            ADC20         : in  std_logic_vector(15 downto 0);
            ADC21         : in  std_logic_vector(15 downto 0);
            ADC22         : in  std_logic_vector(15 downto 0);
            ADC23         : in  std_logic_vector(15 downto 0);
            ADC24         : in  std_logic_vector(15 downto 0);
            ADC25         : in  std_logic_vector(15 downto 0);
            ADC26         : in  std_logic_vector(15 downto 0);
            ADC27         : in  std_logic_vector(15 downto 0);
            ADC28         : in  std_logic_vector(15 downto 0);
            ADC29         : in  std_logic_vector(15 downto 0);
            ADC3          : in  std_logic_vector(15 downto 0);
            ADC30         : in  std_logic_vector(15 downto 0);
            ADC31         : in  std_logic_vector(15 downto 0);
            ADC32         : in  std_logic_vector(15 downto 0);
            ADC4          : in  std_logic_vector(15 downto 0);
            ADC5          : in  std_logic_vector(15 downto 0);
            ADC6          : in  std_logic_vector(15 downto 0);
            ADC7          : in  std_logic_vector(15 downto 0);
            ADC8          : in  std_logic_vector(15 downto 0);
            ADC9          : in  std_logic_vector(15 downto 0);
            ADCValidIn    : in  std_logic_vector(0 downto 0);
            BlockRegAddr1 : out std_logic_vector(4 downto 0);
            BlockRegAddr2 : out std_logic_vector(4 downto 0);
            BlockRegData1 : in  std_logic_vector(15 downto 0);
            BlockRegData2 : in  std_logic_vector(15 downto 0);
            BlockRegRd1   : out std_logic_vector(0 downto 0);
            BlockRegRd2   : out std_logic_vector(0 downto 0);
            DataOut1      : out std_logic_vector(43 downto 0);
            DownInDataP   : in  std_logic_vector(63 downto 0);
            DownInValidP  : in  std_logic_vector(0 downto 0);
            DownOutDataP  : out std_logic_vector(63 downto 0);
            DownOutReadyP : in  std_logic_vector(0 downto 0);
            DownOutValidP : out std_logic_vector(0 downto 0);
            ReadyIn1      : in  std_logic_vector(0 downto 0);
            Register1     : in  std_logic_vector(15 downto 0);
            Register10    : in  std_logic_vector(31 downto 0);
            Register11    : in  std_logic_vector(0 downto 0);
            Register12    : in  std_logic_vector(0 downto 0);
            Register2     : in  std_logic_vector(0 downto 0);
            Register3     : in  std_logic_vector(31 downto 0);
            Register4     : in  std_logic_vector(31 downto 0);
            Register5     : in  std_logic_vector(31 downto 0);
            Register6     : in  std_logic_vector(31 downto 0);
            Register7     : in  std_logic_vector(31 downto 0);
            Register8     : in  std_logic_vector(31 downto 0);
            Register9     : in  std_logic_vector(31 downto 0);
            UpInDataP     : in  std_logic_vector(63 downto 0);
            UpInValidP    : in  std_logic_vector(0 downto 0);
            UpOutDataP    : out std_logic_vector(63 downto 0);
            UpOutReadyP   : in  std_logic_vector(0 downto 0);
            UpOutValidP   : out std_logic_vector(0 downto 0);
            ValidOut1     : out std_logic_vector(0 downto 0);
            ce1           : in  std_logic;
            ce2           : in  std_logic;
            clk           : in  std_logic;
            rst           : in  std_logic);
    end component;
    
    signal ce1 : std_logic;
    signal ce2 : std_logic;

begin
    
    M9703_MultiCh_Cali_InterFPGA_FPGA0_CE_inst : M9703_MultiCh_Cali_InterFPGA_FPGA0_CE
    port map (
        ce1      => ce1,
        ce100006 => open,
        ce2      => ce2,
        clk      => clk,
        en       => ce,
        rst      => rst);
    
    
    M9703_MultiCh_Cali_InterFPGA_FPGA0_inst : M9703_MultiCh_Cali_InterFPGA_FPGA0
    port map (
        ADC1          => ADC1,
        ADC10         => ADC10,
        ADC11         => ADC11,
        ADC12         => ADC12,
        ADC13         => ADC13,
        ADC14         => ADC14,
        ADC15         => ADC15,
        ADC16         => ADC16,
        ADC17         => ADC17,
        ADC18         => ADC18,
        ADC19         => ADC19,
        ADC2          => ADC2,
        ADC20         => ADC20,
        ADC21         => ADC21,
        ADC22         => ADC22,
        ADC23         => ADC23,
        ADC24         => ADC24,
        ADC25         => ADC25,
        ADC26         => ADC26,
        ADC27         => ADC27,
        ADC28         => ADC28,
        ADC29         => ADC29,
        ADC3          => ADC3,
        ADC30         => ADC30,
        ADC31         => ADC31,
        ADC32         => ADC32,
        ADC4          => ADC4,
        ADC5          => ADC5,
        ADC6          => ADC6,
        ADC7          => ADC7,
        ADC8          => ADC8,
        ADC9          => ADC9,
        ADCValidIn    => ADCValidIn,
        BlockRegAddr1 => BlockRegAddr1,
        BlockRegAddr2 => BlockRegAddr2,
        BlockRegData1 => BlockRegData1,
        BlockRegData2 => BlockRegData2,
        BlockRegRd1   => BlockRegRd1,
        BlockRegRd2   => BlockRegRd2,
        DataOut1      => DataOut1,
        DownInDataP   => DownInDataP,
        DownInValidP  => DownInValidP,
        DownOutDataP  => DownOutDataP,
        DownOutReadyP => DownOutReadyP,
        DownOutValidP => DownOutValidP,
        ReadyIn1      => ReadyIn1,
        Register1     => Register1,
        Register10    => Register10,
        Register11    => Register11,
        Register12    => Register12,
        Register2     => Register2,
        Register3     => Register3,
        Register4     => Register4,
        Register5     => Register5,
        Register6     => Register6,
        Register7     => Register7,
        Register8     => Register8,
        Register9     => Register9,
        UpInDataP     => UpInDataP,
        UpInValidP    => UpInValidP,
        UpOutDataP    => UpOutDataP,
        UpOutReadyP   => UpOutReadyP,
        UpOutValidP   => UpOutValidP,
        ValidOut1     => ValidOut1,
        ce1           => ce1,
        ce2           => ce2,
        clk           => clk,
        rst           => rst);
    

end M9703_MultiCh_Cali_InterFPGA_FPGA0_CoSimWrapper_Arch;


