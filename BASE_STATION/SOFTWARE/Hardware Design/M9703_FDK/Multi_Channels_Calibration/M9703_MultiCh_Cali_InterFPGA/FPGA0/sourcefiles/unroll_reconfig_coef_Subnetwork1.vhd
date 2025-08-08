-------------------------------------------------------------------------------
-- Automatically generated VHDL code for non-primitive component
-- unroll_reconfig_coef_Subnetwork1.vhd
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library work;
use work.p_fxp.all;


entity unroll_reconfig_coef_Subnetwork1 is
    port (
        addr   : in  std_logic_vector(4 downto 0);
        ce1    : in  std_logic;
        clk    : in  std_logic;
        coef0  : out std_logic_vector(15 downto 0);
        coef1  : out std_logic_vector(15 downto 0);
        coef10 : out std_logic_vector(15 downto 0);
        coef11 : out std_logic_vector(15 downto 0);
        coef12 : out std_logic_vector(15 downto 0);
        coef13 : out std_logic_vector(15 downto 0);
        coef14 : out std_logic_vector(15 downto 0);
        coef15 : out std_logic_vector(15 downto 0);
        coef16 : out std_logic_vector(15 downto 0);
        coef17 : out std_logic_vector(15 downto 0);
        coef18 : out std_logic_vector(15 downto 0);
        coef19 : out std_logic_vector(15 downto 0);
        coef2  : out std_logic_vector(15 downto 0);
        coef20 : out std_logic_vector(15 downto 0);
        coef21 : out std_logic_vector(15 downto 0);
        coef22 : out std_logic_vector(15 downto 0);
        coef23 : out std_logic_vector(15 downto 0);
        coef24 : out std_logic_vector(15 downto 0);
        coef25 : out std_logic_vector(15 downto 0);
        coef26 : out std_logic_vector(15 downto 0);
        coef27 : out std_logic_vector(15 downto 0);
        coef28 : out std_logic_vector(15 downto 0);
        coef29 : out std_logic_vector(15 downto 0);
        coef3  : out std_logic_vector(15 downto 0);
        coef30 : out std_logic_vector(15 downto 0);
        coef31 : out std_logic_vector(15 downto 0);
        coef4  : out std_logic_vector(15 downto 0);
        coef5  : out std_logic_vector(15 downto 0);
        coef6  : out std_logic_vector(15 downto 0);
        coef7  : out std_logic_vector(15 downto 0);
        coef8  : out std_logic_vector(15 downto 0);
        coef9  : out std_logic_vector(15 downto 0);
        data   : in  std_logic_vector(15 downto 0);
        rst    : in  std_logic);
end unroll_reconfig_coef_Subnetwork1;


architecture unroll_reconfig_coef_Subnetwork1_Arch of unroll_reconfig_coef_Subnetwork1 is
    
    component CompareConstFxp
        generic (
            CompareOperation       : integer;
            ConstIntegerWordlength : integer;
            ConstIsSigned          : integer;
            ConstWordlength        : integer;
            FxpConstant            : integer;
            dataInAIWL             : integer;
            dataInASGN             : integer;
            dataInAWL              : integer;
            dataOutWL              : integer);
        port (
            dataInA : in  std_logic_vector(dataInAWL-1 downto 0);
            dataOut : out std_logic);
    end component;
    
    component DelayFxp
        generic (
            Delay        : integer;
            FxpInitValue : integer;
            dataInWL     : integer;
            dataOutSGN   : integer;
            dataOutWL    : integer);
        port (
            CE      : in  std_logic;
            CLK     : in  std_logic;
            RDY     : out std_logic;
            RST     : in  std_logic;
            dataIn  : in  std_logic_vector(dataInWL-1 downto 0);
            dataOut : out std_logic_vector(dataOutWL-1 downto 0));
    end component;
    
    component LatchFxp
        generic (
            LatchMode : integer;
            dataInWL  : integer;
            dataOutWL : integer);
        port (
            CE      : in  std_logic;
            CLK     : in  std_logic;
            RDY     : out std_logic;
            RST     : in  std_logic;
            dataIn  : in  std_logic_vector(dataInWL-1 downto 0);
            dataOut : out std_logic_vector(dataOutWL-1 downto 0);
            latch   : in  std_logic);
    end component;
    
    signal C10_dataOut : std_logic_vector(0 downto 0);
    signal C11_dataOut : std_logic_vector(0 downto 0);
    signal C12_dataOut : std_logic_vector(0 downto 0);
    signal C13_dataOut : std_logic_vector(0 downto 0);
    signal C14_dataOut : std_logic_vector(0 downto 0);
    signal C15_dataOut : std_logic_vector(0 downto 0);
    signal C16_dataOut : std_logic_vector(0 downto 0);
    signal C17_dataOut : std_logic_vector(0 downto 0);
    signal C18_dataOut : std_logic_vector(0 downto 0);
    signal C19_dataOut : std_logic_vector(0 downto 0);
    signal C1_dataOut  : std_logic_vector(0 downto 0);
    signal C20_dataOut : std_logic_vector(0 downto 0);
    signal C21_dataOut : std_logic_vector(0 downto 0);
    signal C22_dataOut : std_logic_vector(0 downto 0);
    signal C23_dataOut : std_logic_vector(0 downto 0);
    signal C24_dataOut : std_logic_vector(0 downto 0);
    signal C25_dataOut : std_logic_vector(0 downto 0);
    signal C26_dataOut : std_logic_vector(0 downto 0);
    signal C27_dataOut : std_logic_vector(0 downto 0);
    signal C28_dataOut : std_logic_vector(0 downto 0);
    signal C29_dataOut : std_logic_vector(0 downto 0);
    signal C2_dataOut  : std_logic_vector(0 downto 0);
    signal C30_dataOut : std_logic_vector(0 downto 0);
    signal C31_dataOut : std_logic_vector(0 downto 0);
    signal C32_dataOut : std_logic_vector(0 downto 0);
    signal C3_dataOut  : std_logic_vector(0 downto 0);
    signal C4_dataOut  : std_logic_vector(0 downto 0);
    signal C5_dataOut  : std_logic_vector(0 downto 0);
    signal C6_dataOut  : std_logic_vector(0 downto 0);
    signal C7_dataOut  : std_logic_vector(0 downto 0);
    signal C8_dataOut  : std_logic_vector(0 downto 0);
    signal C9_dataOut  : std_logic_vector(0 downto 0);
    signal D10_dataOut : std_logic_vector(15 downto 0);
    signal D11_dataOut : std_logic_vector(4 downto 0);
    signal D12_dataOut : std_logic_vector(0 downto 0);
    signal D13_dataOut : std_logic_vector(0 downto 0);
    signal D14_dataOut : std_logic_vector(0 downto 0);
    signal D15_dataOut : std_logic_vector(0 downto 0);
    signal D16_dataOut : std_logic_vector(0 downto 0);
    signal D17_dataOut : std_logic_vector(0 downto 0);
    signal D18_dataOut : std_logic_vector(0 downto 0);
    signal D19_dataOut : std_logic_vector(4 downto 0);
    signal D1_dataOut  : std_logic_vector(15 downto 0);
    signal D20_dataOut : std_logic_vector(0 downto 0);
    signal D21_dataOut : std_logic_vector(15 downto 0);
    signal D22_dataOut : std_logic_vector(4 downto 0);
    signal D23_dataOut : std_logic_vector(0 downto 0);
    signal D24_dataOut : std_logic_vector(0 downto 0);
    signal D25_dataOut : std_logic_vector(0 downto 0);
    signal D26_dataOut : std_logic_vector(0 downto 0);
    signal D27_dataOut : std_logic_vector(0 downto 0);
    signal D28_dataOut : std_logic_vector(0 downto 0);
    signal D29_dataOut : std_logic_vector(0 downto 0);
    signal D2_dataOut  : std_logic_vector(0 downto 0);
    signal D30_dataOut : std_logic_vector(0 downto 0);
    signal D31_dataOut : std_logic_vector(15 downto 0);
    signal D32_dataOut : std_logic_vector(4 downto 0);
    signal D33_dataOut : std_logic_vector(0 downto 0);
    signal D34_dataOut : std_logic_vector(0 downto 0);
    signal D35_dataOut : std_logic_vector(0 downto 0);
    signal D36_dataOut : std_logic_vector(0 downto 0);
    signal D37_dataOut : std_logic_vector(0 downto 0);
    signal D38_dataOut : std_logic_vector(0 downto 0);
    signal D39_dataOut : std_logic_vector(0 downto 0);
    signal D3_dataOut  : std_logic_vector(0 downto 0);
    signal D40_dataOut : std_logic_vector(0 downto 0);
    signal D4_dataOut  : std_logic_vector(0 downto 0);
    signal D5_dataOut  : std_logic_vector(0 downto 0);
    signal D6_dataOut  : std_logic_vector(0 downto 0);
    signal D7_dataOut  : std_logic_vector(0 downto 0);
    signal D8_dataOut  : std_logic_vector(0 downto 0);
    signal D9_dataOut  : std_logic_vector(0 downto 0);
    signal L10_dataOut : std_logic_vector(15 downto 0);
    signal L11_dataOut : std_logic_vector(15 downto 0);
    signal L12_dataOut : std_logic_vector(15 downto 0);
    signal L13_dataOut : std_logic_vector(15 downto 0);
    signal L14_dataOut : std_logic_vector(15 downto 0);
    signal L15_dataOut : std_logic_vector(15 downto 0);
    signal L16_dataOut : std_logic_vector(15 downto 0);
    signal L17_dataOut : std_logic_vector(15 downto 0);
    signal L18_dataOut : std_logic_vector(15 downto 0);
    signal L19_dataOut : std_logic_vector(15 downto 0);
    signal L1_dataOut  : std_logic_vector(15 downto 0);
    signal L20_dataOut : std_logic_vector(15 downto 0);
    signal L21_dataOut : std_logic_vector(15 downto 0);
    signal L22_dataOut : std_logic_vector(15 downto 0);
    signal L23_dataOut : std_logic_vector(15 downto 0);
    signal L24_dataOut : std_logic_vector(15 downto 0);
    signal L25_dataOut : std_logic_vector(15 downto 0);
    signal L26_dataOut : std_logic_vector(15 downto 0);
    signal L27_dataOut : std_logic_vector(15 downto 0);
    signal L28_dataOut : std_logic_vector(15 downto 0);
    signal L29_dataOut : std_logic_vector(15 downto 0);
    signal L2_dataOut  : std_logic_vector(15 downto 0);
    signal L30_dataOut : std_logic_vector(15 downto 0);
    signal L31_dataOut : std_logic_vector(15 downto 0);
    signal L32_dataOut : std_logic_vector(15 downto 0);
    signal L3_dataOut  : std_logic_vector(15 downto 0);
    signal L4_dataOut  : std_logic_vector(15 downto 0);
    signal L5_dataOut  : std_logic_vector(15 downto 0);
    signal L6_dataOut  : std_logic_vector(15 downto 0);
    signal L7_dataOut  : std_logic_vector(15 downto 0);
    signal L8_dataOut  : std_logic_vector(15 downto 0);
    signal L9_dataOut  : std_logic_vector(15 downto 0);

begin
    
    C1 : CompareConstFxp
    generic map (
        CompareOperation       => 0,
        ConstIntegerWordlength => 5,
        ConstIsSigned          => 0,
        ConstWordlength        => 5,
        FxpConstant            => 1,
        dataInAIWL             => 5,
        dataInASGN             => 0,
        dataInAWL              => 5,
        dataOutWL              => 1)
    port map (
        dataInA => D19_dataOut,
        dataOut => C1_dataOut(0));
    
    
    C10 : CompareConstFxp
    generic map (
        CompareOperation       => 0,
        ConstIntegerWordlength => 5,
        ConstIsSigned          => 0,
        ConstWordlength        => 5,
        FxpConstant            => 10,
        dataInAIWL             => 5,
        dataInASGN             => 0,
        dataInAWL              => 5,
        dataOutWL              => 1)
    port map (
        dataInA => D11_dataOut,
        dataOut => C10_dataOut(0));
    
    
    C11 : CompareConstFxp
    generic map (
        CompareOperation       => 0,
        ConstIntegerWordlength => 5,
        ConstIsSigned          => 0,
        ConstWordlength        => 5,
        FxpConstant            => 11,
        dataInAIWL             => 5,
        dataInASGN             => 0,
        dataInAWL              => 5,
        dataOutWL              => 1)
    port map (
        dataInA => D11_dataOut,
        dataOut => C11_dataOut(0));
    
    
    C12 : CompareConstFxp
    generic map (
        CompareOperation       => 0,
        ConstIntegerWordlength => 5,
        ConstIsSigned          => 0,
        ConstWordlength        => 5,
        FxpConstant            => 8,
        dataInAIWL             => 5,
        dataInASGN             => 0,
        dataInAWL              => 5,
        dataOutWL              => 1)
    port map (
        dataInA => D11_dataOut,
        dataOut => C12_dataOut(0));
    
    
    C13 : CompareConstFxp
    generic map (
        CompareOperation       => 0,
        ConstIntegerWordlength => 5,
        ConstIsSigned          => 0,
        ConstWordlength        => 5,
        FxpConstant            => 12,
        dataInAIWL             => 5,
        dataInASGN             => 0,
        dataInAWL              => 5,
        dataOutWL              => 1)
    port map (
        dataInA => D11_dataOut,
        dataOut => C13_dataOut(0));
    
    
    C14 : CompareConstFxp
    generic map (
        CompareOperation       => 0,
        ConstIntegerWordlength => 5,
        ConstIsSigned          => 0,
        ConstWordlength        => 5,
        FxpConstant            => 13,
        dataInAIWL             => 5,
        dataInASGN             => 0,
        dataInAWL              => 5,
        dataOutWL              => 1)
    port map (
        dataInA => D11_dataOut,
        dataOut => C14_dataOut(0));
    
    
    C15 : CompareConstFxp
    generic map (
        CompareOperation       => 0,
        ConstIntegerWordlength => 5,
        ConstIsSigned          => 0,
        ConstWordlength        => 5,
        FxpConstant            => 14,
        dataInAIWL             => 5,
        dataInASGN             => 0,
        dataInAWL              => 5,
        dataOutWL              => 1)
    port map (
        dataInA => D11_dataOut,
        dataOut => C15_dataOut(0));
    
    
    C16 : CompareConstFxp
    generic map (
        CompareOperation       => 0,
        ConstIntegerWordlength => 5,
        ConstIsSigned          => 0,
        ConstWordlength        => 5,
        FxpConstant            => 15,
        dataInAIWL             => 5,
        dataInASGN             => 0,
        dataInAWL              => 5,
        dataOutWL              => 1)
    port map (
        dataInA => D11_dataOut,
        dataOut => C16_dataOut(0));
    
    
    C17 : CompareConstFxp
    generic map (
        CompareOperation       => 0,
        ConstIntegerWordlength => 5,
        ConstIsSigned          => 0,
        ConstWordlength        => 5,
        FxpConstant            => 17,
        dataInAIWL             => 5,
        dataInASGN             => 0,
        dataInAWL              => 5,
        dataOutWL              => 1)
    port map (
        dataInA => D22_dataOut,
        dataOut => C17_dataOut(0));
    
    
    C18 : CompareConstFxp
    generic map (
        CompareOperation       => 0,
        ConstIntegerWordlength => 5,
        ConstIsSigned          => 0,
        ConstWordlength        => 5,
        FxpConstant            => 18,
        dataInAIWL             => 5,
        dataInASGN             => 0,
        dataInAWL              => 5,
        dataOutWL              => 1)
    port map (
        dataInA => D22_dataOut,
        dataOut => C18_dataOut(0));
    
    
    C19 : CompareConstFxp
    generic map (
        CompareOperation       => 0,
        ConstIntegerWordlength => 5,
        ConstIsSigned          => 0,
        ConstWordlength        => 5,
        FxpConstant            => 19,
        dataInAIWL             => 5,
        dataInASGN             => 0,
        dataInAWL              => 5,
        dataOutWL              => 1)
    port map (
        dataInA => D22_dataOut,
        dataOut => C19_dataOut(0));
    
    
    C2 : CompareConstFxp
    generic map (
        CompareOperation       => 0,
        ConstIntegerWordlength => 5,
        ConstIsSigned          => 0,
        ConstWordlength        => 5,
        FxpConstant            => 2,
        dataInAIWL             => 5,
        dataInASGN             => 0,
        dataInAWL              => 5,
        dataOutWL              => 1)
    port map (
        dataInA => D19_dataOut,
        dataOut => C2_dataOut(0));
    
    
    C20 : CompareConstFxp
    generic map (
        CompareOperation       => 0,
        ConstIntegerWordlength => 5,
        ConstIsSigned          => 0,
        ConstWordlength        => 5,
        FxpConstant            => 16,
        dataInAIWL             => 5,
        dataInASGN             => 0,
        dataInAWL              => 5,
        dataOutWL              => 1)
    port map (
        dataInA => D22_dataOut,
        dataOut => C20_dataOut(0));
    
    
    C21 : CompareConstFxp
    generic map (
        CompareOperation       => 0,
        ConstIntegerWordlength => 5,
        ConstIsSigned          => 0,
        ConstWordlength        => 5,
        FxpConstant            => 20,
        dataInAIWL             => 5,
        dataInASGN             => 0,
        dataInAWL              => 5,
        dataOutWL              => 1)
    port map (
        dataInA => D22_dataOut,
        dataOut => C21_dataOut(0));
    
    
    C22 : CompareConstFxp
    generic map (
        CompareOperation       => 0,
        ConstIntegerWordlength => 5,
        ConstIsSigned          => 0,
        ConstWordlength        => 5,
        FxpConstant            => 21,
        dataInAIWL             => 5,
        dataInASGN             => 0,
        dataInAWL              => 5,
        dataOutWL              => 1)
    port map (
        dataInA => D22_dataOut,
        dataOut => C22_dataOut(0));
    
    
    C23 : CompareConstFxp
    generic map (
        CompareOperation       => 0,
        ConstIntegerWordlength => 5,
        ConstIsSigned          => 0,
        ConstWordlength        => 5,
        FxpConstant            => 22,
        dataInAIWL             => 5,
        dataInASGN             => 0,
        dataInAWL              => 5,
        dataOutWL              => 1)
    port map (
        dataInA => D22_dataOut,
        dataOut => C23_dataOut(0));
    
    
    C24 : CompareConstFxp
    generic map (
        CompareOperation       => 0,
        ConstIntegerWordlength => 5,
        ConstIsSigned          => 0,
        ConstWordlength        => 5,
        FxpConstant            => 23,
        dataInAIWL             => 5,
        dataInASGN             => 0,
        dataInAWL              => 5,
        dataOutWL              => 1)
    port map (
        dataInA => D22_dataOut,
        dataOut => C24_dataOut(0));
    
    
    C25 : CompareConstFxp
    generic map (
        CompareOperation       => 0,
        ConstIntegerWordlength => 5,
        ConstIsSigned          => 0,
        ConstWordlength        => 5,
        FxpConstant            => 25,
        dataInAIWL             => 5,
        dataInASGN             => 0,
        dataInAWL              => 5,
        dataOutWL              => 1)
    port map (
        dataInA => D32_dataOut,
        dataOut => C25_dataOut(0));
    
    
    C26 : CompareConstFxp
    generic map (
        CompareOperation       => 0,
        ConstIntegerWordlength => 5,
        ConstIsSigned          => 0,
        ConstWordlength        => 5,
        FxpConstant            => 26,
        dataInAIWL             => 5,
        dataInASGN             => 0,
        dataInAWL              => 5,
        dataOutWL              => 1)
    port map (
        dataInA => D32_dataOut,
        dataOut => C26_dataOut(0));
    
    
    C27 : CompareConstFxp
    generic map (
        CompareOperation       => 0,
        ConstIntegerWordlength => 5,
        ConstIsSigned          => 0,
        ConstWordlength        => 5,
        FxpConstant            => 27,
        dataInAIWL             => 5,
        dataInASGN             => 0,
        dataInAWL              => 5,
        dataOutWL              => 1)
    port map (
        dataInA => D32_dataOut,
        dataOut => C27_dataOut(0));
    
    
    C28 : CompareConstFxp
    generic map (
        CompareOperation       => 0,
        ConstIntegerWordlength => 5,
        ConstIsSigned          => 0,
        ConstWordlength        => 5,
        FxpConstant            => 24,
        dataInAIWL             => 5,
        dataInASGN             => 0,
        dataInAWL              => 5,
        dataOutWL              => 1)
    port map (
        dataInA => D32_dataOut,
        dataOut => C28_dataOut(0));
    
    
    C29 : CompareConstFxp
    generic map (
        CompareOperation       => 0,
        ConstIntegerWordlength => 5,
        ConstIsSigned          => 0,
        ConstWordlength        => 5,
        FxpConstant            => 28,
        dataInAIWL             => 5,
        dataInASGN             => 0,
        dataInAWL              => 5,
        dataOutWL              => 1)
    port map (
        dataInA => D32_dataOut,
        dataOut => C29_dataOut(0));
    
    
    C3 : CompareConstFxp
    generic map (
        CompareOperation       => 0,
        ConstIntegerWordlength => 5,
        ConstIsSigned          => 0,
        ConstWordlength        => 5,
        FxpConstant            => 3,
        dataInAIWL             => 5,
        dataInASGN             => 0,
        dataInAWL              => 5,
        dataOutWL              => 1)
    port map (
        dataInA => D19_dataOut,
        dataOut => C3_dataOut(0));
    
    
    C30 : CompareConstFxp
    generic map (
        CompareOperation       => 0,
        ConstIntegerWordlength => 5,
        ConstIsSigned          => 0,
        ConstWordlength        => 5,
        FxpConstant            => 29,
        dataInAIWL             => 5,
        dataInASGN             => 0,
        dataInAWL              => 5,
        dataOutWL              => 1)
    port map (
        dataInA => D32_dataOut,
        dataOut => C30_dataOut(0));
    
    
    C31 : CompareConstFxp
    generic map (
        CompareOperation       => 0,
        ConstIntegerWordlength => 5,
        ConstIsSigned          => 0,
        ConstWordlength        => 5,
        FxpConstant            => 30,
        dataInAIWL             => 5,
        dataInASGN             => 0,
        dataInAWL              => 5,
        dataOutWL              => 1)
    port map (
        dataInA => D32_dataOut,
        dataOut => C31_dataOut(0));
    
    
    C32 : CompareConstFxp
    generic map (
        CompareOperation       => 0,
        ConstIntegerWordlength => 5,
        ConstIsSigned          => 0,
        ConstWordlength        => 5,
        FxpConstant            => 31,
        dataInAIWL             => 5,
        dataInASGN             => 0,
        dataInAWL              => 5,
        dataOutWL              => 1)
    port map (
        dataInA => D32_dataOut,
        dataOut => C32_dataOut(0));
    
    
    C4 : CompareConstFxp
    generic map (
        CompareOperation       => 0,
        ConstIntegerWordlength => 5,
        ConstIsSigned          => 0,
        ConstWordlength        => 5,
        FxpConstant            => 0,
        dataInAIWL             => 5,
        dataInASGN             => 0,
        dataInAWL              => 5,
        dataOutWL              => 1)
    port map (
        dataInA => D19_dataOut,
        dataOut => C4_dataOut(0));
    
    
    C5 : CompareConstFxp
    generic map (
        CompareOperation       => 0,
        ConstIntegerWordlength => 5,
        ConstIsSigned          => 0,
        ConstWordlength        => 5,
        FxpConstant            => 4,
        dataInAIWL             => 5,
        dataInASGN             => 0,
        dataInAWL              => 5,
        dataOutWL              => 1)
    port map (
        dataInA => D19_dataOut,
        dataOut => C5_dataOut(0));
    
    
    C6 : CompareConstFxp
    generic map (
        CompareOperation       => 0,
        ConstIntegerWordlength => 5,
        ConstIsSigned          => 0,
        ConstWordlength        => 5,
        FxpConstant            => 5,
        dataInAIWL             => 5,
        dataInASGN             => 0,
        dataInAWL              => 5,
        dataOutWL              => 1)
    port map (
        dataInA => D19_dataOut,
        dataOut => C6_dataOut(0));
    
    
    C7 : CompareConstFxp
    generic map (
        CompareOperation       => 0,
        ConstIntegerWordlength => 5,
        ConstIsSigned          => 0,
        ConstWordlength        => 5,
        FxpConstant            => 6,
        dataInAIWL             => 5,
        dataInASGN             => 0,
        dataInAWL              => 5,
        dataOutWL              => 1)
    port map (
        dataInA => D19_dataOut,
        dataOut => C7_dataOut(0));
    
    
    C8 : CompareConstFxp
    generic map (
        CompareOperation       => 0,
        ConstIntegerWordlength => 5,
        ConstIsSigned          => 0,
        ConstWordlength        => 5,
        FxpConstant            => 7,
        dataInAIWL             => 5,
        dataInASGN             => 0,
        dataInAWL              => 5,
        dataOutWL              => 1)
    port map (
        dataInA => D19_dataOut,
        dataOut => C8_dataOut(0));
    
    
    C9 : CompareConstFxp
    generic map (
        CompareOperation       => 0,
        ConstIntegerWordlength => 5,
        ConstIsSigned          => 0,
        ConstWordlength        => 5,
        FxpConstant            => 9,
        dataInAIWL             => 5,
        dataInASGN             => 0,
        dataInAWL              => 5,
        dataOutWL              => 1)
    port map (
        dataInA => D11_dataOut,
        dataOut => C9_dataOut(0));
    
    
    D1 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 1,
        dataOutWL    => 16)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => data,
        dataOut => D1_dataOut);
    
    
    D10 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 1,
        dataOutWL    => 16)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => data,
        dataOut => D10_dataOut);
    
    
    D11 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 5,
        dataOutSGN   => 0,
        dataOutWL    => 5)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => addr,
        dataOut => D11_dataOut);
    
    
    D12 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 1,
        dataOutSGN   => 0,
        dataOutWL    => 1)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => C12_dataOut,
        dataOut => D12_dataOut);
    
    
    D13 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 1,
        dataOutSGN   => 0,
        dataOutWL    => 1)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => C9_dataOut,
        dataOut => D13_dataOut);
    
    
    D14 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 1,
        dataOutSGN   => 0,
        dataOutWL    => 1)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => C10_dataOut,
        dataOut => D14_dataOut);
    
    
    D15 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 1,
        dataOutSGN   => 0,
        dataOutWL    => 1)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => C11_dataOut,
        dataOut => D15_dataOut);
    
    
    D16 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 1,
        dataOutSGN   => 0,
        dataOutWL    => 1)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => C13_dataOut,
        dataOut => D16_dataOut);
    
    
    D17 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 1,
        dataOutSGN   => 0,
        dataOutWL    => 1)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => C14_dataOut,
        dataOut => D17_dataOut);
    
    
    D18 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 1,
        dataOutSGN   => 0,
        dataOutWL    => 1)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => C15_dataOut,
        dataOut => D18_dataOut);
    
    
    D19 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 5,
        dataOutSGN   => 0,
        dataOutWL    => 5)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => addr,
        dataOut => D19_dataOut);
    
    
    D2 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 1,
        dataOutSGN   => 0,
        dataOutWL    => 1)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => C4_dataOut,
        dataOut => D2_dataOut);
    
    
    D20 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 1,
        dataOutSGN   => 0,
        dataOutWL    => 1)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => C16_dataOut,
        dataOut => D20_dataOut);
    
    
    D21 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 1,
        dataOutWL    => 16)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => data,
        dataOut => D21_dataOut);
    
    
    D22 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 5,
        dataOutSGN   => 0,
        dataOutWL    => 5)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => addr,
        dataOut => D22_dataOut);
    
    
    D23 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 1,
        dataOutSGN   => 0,
        dataOutWL    => 1)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => C20_dataOut,
        dataOut => D23_dataOut);
    
    
    D24 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 1,
        dataOutSGN   => 0,
        dataOutWL    => 1)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => C17_dataOut,
        dataOut => D24_dataOut);
    
    
    D25 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 1,
        dataOutSGN   => 0,
        dataOutWL    => 1)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => C18_dataOut,
        dataOut => D25_dataOut);
    
    
    D26 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 1,
        dataOutSGN   => 0,
        dataOutWL    => 1)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => C19_dataOut,
        dataOut => D26_dataOut);
    
    
    D27 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 1,
        dataOutSGN   => 0,
        dataOutWL    => 1)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => C21_dataOut,
        dataOut => D27_dataOut);
    
    
    D28 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 1,
        dataOutSGN   => 0,
        dataOutWL    => 1)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => C22_dataOut,
        dataOut => D28_dataOut);
    
    
    D29 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 1,
        dataOutSGN   => 0,
        dataOutWL    => 1)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => C23_dataOut,
        dataOut => D29_dataOut);
    
    
    D3 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 1,
        dataOutSGN   => 0,
        dataOutWL    => 1)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => C1_dataOut,
        dataOut => D3_dataOut);
    
    
    D30 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 1,
        dataOutSGN   => 0,
        dataOutWL    => 1)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => C24_dataOut,
        dataOut => D30_dataOut);
    
    
    D31 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 1,
        dataOutWL    => 16)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => data,
        dataOut => D31_dataOut);
    
    
    D32 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 5,
        dataOutSGN   => 0,
        dataOutWL    => 5)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => addr,
        dataOut => D32_dataOut);
    
    
    D33 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 1,
        dataOutSGN   => 0,
        dataOutWL    => 1)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => C28_dataOut,
        dataOut => D33_dataOut);
    
    
    D34 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 1,
        dataOutSGN   => 0,
        dataOutWL    => 1)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => C25_dataOut,
        dataOut => D34_dataOut);
    
    
    D35 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 1,
        dataOutSGN   => 0,
        dataOutWL    => 1)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => C26_dataOut,
        dataOut => D35_dataOut);
    
    
    D36 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 1,
        dataOutSGN   => 0,
        dataOutWL    => 1)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => C27_dataOut,
        dataOut => D36_dataOut);
    
    
    D37 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 1,
        dataOutSGN   => 0,
        dataOutWL    => 1)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => C29_dataOut,
        dataOut => D37_dataOut);
    
    
    D38 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 1,
        dataOutSGN   => 0,
        dataOutWL    => 1)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => C30_dataOut,
        dataOut => D38_dataOut);
    
    
    D39 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 1,
        dataOutSGN   => 0,
        dataOutWL    => 1)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => C31_dataOut,
        dataOut => D39_dataOut);
    
    
    D4 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 1,
        dataOutSGN   => 0,
        dataOutWL    => 1)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => C2_dataOut,
        dataOut => D4_dataOut);
    
    
    D40 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 1,
        dataOutSGN   => 0,
        dataOutWL    => 1)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => C32_dataOut,
        dataOut => D40_dataOut);
    
    
    D5 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 1,
        dataOutSGN   => 0,
        dataOutWL    => 1)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => C3_dataOut,
        dataOut => D5_dataOut);
    
    
    D6 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 1,
        dataOutSGN   => 0,
        dataOutWL    => 1)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => C5_dataOut,
        dataOut => D6_dataOut);
    
    
    D7 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 1,
        dataOutSGN   => 0,
        dataOutWL    => 1)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => C6_dataOut,
        dataOut => D7_dataOut);
    
    
    D8 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 1,
        dataOutSGN   => 0,
        dataOutWL    => 1)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => C7_dataOut,
        dataOut => D8_dataOut);
    
    
    D9 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 1,
        dataOutSGN   => 0,
        dataOutWL    => 1)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => C8_dataOut,
        dataOut => D9_dataOut);
    
    
    L1 : LatchFxp
    generic map (
        LatchMode => 1,
        dataInWL  => 16,
        dataOutWL => 16)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => D1_dataOut,
        dataOut => L1_dataOut,
        latch   => D3_dataOut(0));
    
    
    L10 : LatchFxp
    generic map (
        LatchMode => 1,
        dataInWL  => 16,
        dataOutWL => 16)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => D10_dataOut,
        dataOut => L10_dataOut,
        latch   => D14_dataOut(0));
    
    
    L11 : LatchFxp
    generic map (
        LatchMode => 1,
        dataInWL  => 16,
        dataOutWL => 16)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => D10_dataOut,
        dataOut => L11_dataOut,
        latch   => D15_dataOut(0));
    
    
    L12 : LatchFxp
    generic map (
        LatchMode => 1,
        dataInWL  => 16,
        dataOutWL => 16)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => D10_dataOut,
        dataOut => L12_dataOut,
        latch   => D16_dataOut(0));
    
    
    L13 : LatchFxp
    generic map (
        LatchMode => 1,
        dataInWL  => 16,
        dataOutWL => 16)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => D10_dataOut,
        dataOut => L13_dataOut,
        latch   => D17_dataOut(0));
    
    
    L14 : LatchFxp
    generic map (
        LatchMode => 1,
        dataInWL  => 16,
        dataOutWL => 16)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => D10_dataOut,
        dataOut => L14_dataOut,
        latch   => D18_dataOut(0));
    
    
    L15 : LatchFxp
    generic map (
        LatchMode => 1,
        dataInWL  => 16,
        dataOutWL => 16)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => D10_dataOut,
        dataOut => L15_dataOut,
        latch   => D20_dataOut(0));
    
    
    L16 : LatchFxp
    generic map (
        LatchMode => 1,
        dataInWL  => 16,
        dataOutWL => 16)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => D21_dataOut,
        dataOut => L16_dataOut,
        latch   => D24_dataOut(0));
    
    
    L17 : LatchFxp
    generic map (
        LatchMode => 1,
        dataInWL  => 16,
        dataOutWL => 16)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => D1_dataOut,
        dataOut => L17_dataOut,
        latch   => D2_dataOut(0));
    
    
    L18 : LatchFxp
    generic map (
        LatchMode => 1,
        dataInWL  => 16,
        dataOutWL => 16)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => D21_dataOut,
        dataOut => L18_dataOut,
        latch   => D23_dataOut(0));
    
    
    L19 : LatchFxp
    generic map (
        LatchMode => 1,
        dataInWL  => 16,
        dataOutWL => 16)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => D21_dataOut,
        dataOut => L19_dataOut,
        latch   => D25_dataOut(0));
    
    
    L2 : LatchFxp
    generic map (
        LatchMode => 1,
        dataInWL  => 16,
        dataOutWL => 16)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => D1_dataOut,
        dataOut => L2_dataOut,
        latch   => D4_dataOut(0));
    
    
    L20 : LatchFxp
    generic map (
        LatchMode => 1,
        dataInWL  => 16,
        dataOutWL => 16)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => D21_dataOut,
        dataOut => L20_dataOut,
        latch   => D26_dataOut(0));
    
    
    L21 : LatchFxp
    generic map (
        LatchMode => 1,
        dataInWL  => 16,
        dataOutWL => 16)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => D21_dataOut,
        dataOut => L21_dataOut,
        latch   => D27_dataOut(0));
    
    
    L22 : LatchFxp
    generic map (
        LatchMode => 1,
        dataInWL  => 16,
        dataOutWL => 16)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => D21_dataOut,
        dataOut => L22_dataOut,
        latch   => D28_dataOut(0));
    
    
    L23 : LatchFxp
    generic map (
        LatchMode => 1,
        dataInWL  => 16,
        dataOutWL => 16)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => D21_dataOut,
        dataOut => L23_dataOut,
        latch   => D29_dataOut(0));
    
    
    L24 : LatchFxp
    generic map (
        LatchMode => 1,
        dataInWL  => 16,
        dataOutWL => 16)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => D21_dataOut,
        dataOut => L24_dataOut,
        latch   => D30_dataOut(0));
    
    
    L25 : LatchFxp
    generic map (
        LatchMode => 1,
        dataInWL  => 16,
        dataOutWL => 16)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => D31_dataOut,
        dataOut => L25_dataOut,
        latch   => D34_dataOut(0));
    
    
    L26 : LatchFxp
    generic map (
        LatchMode => 1,
        dataInWL  => 16,
        dataOutWL => 16)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => D31_dataOut,
        dataOut => L26_dataOut,
        latch   => D33_dataOut(0));
    
    
    L27 : LatchFxp
    generic map (
        LatchMode => 1,
        dataInWL  => 16,
        dataOutWL => 16)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => D31_dataOut,
        dataOut => L27_dataOut,
        latch   => D35_dataOut(0));
    
    
    L28 : LatchFxp
    generic map (
        LatchMode => 1,
        dataInWL  => 16,
        dataOutWL => 16)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => D31_dataOut,
        dataOut => L28_dataOut,
        latch   => D36_dataOut(0));
    
    
    L29 : LatchFxp
    generic map (
        LatchMode => 1,
        dataInWL  => 16,
        dataOutWL => 16)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => D31_dataOut,
        dataOut => L29_dataOut,
        latch   => D37_dataOut(0));
    
    
    L3 : LatchFxp
    generic map (
        LatchMode => 1,
        dataInWL  => 16,
        dataOutWL => 16)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => D1_dataOut,
        dataOut => L3_dataOut,
        latch   => D5_dataOut(0));
    
    
    L30 : LatchFxp
    generic map (
        LatchMode => 1,
        dataInWL  => 16,
        dataOutWL => 16)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => D31_dataOut,
        dataOut => L30_dataOut,
        latch   => D38_dataOut(0));
    
    
    L31 : LatchFxp
    generic map (
        LatchMode => 1,
        dataInWL  => 16,
        dataOutWL => 16)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => D31_dataOut,
        dataOut => L31_dataOut,
        latch   => D39_dataOut(0));
    
    
    L32 : LatchFxp
    generic map (
        LatchMode => 1,
        dataInWL  => 16,
        dataOutWL => 16)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => D31_dataOut,
        dataOut => L32_dataOut,
        latch   => D40_dataOut(0));
    
    
    L4 : LatchFxp
    generic map (
        LatchMode => 1,
        dataInWL  => 16,
        dataOutWL => 16)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => D1_dataOut,
        dataOut => L4_dataOut,
        latch   => D6_dataOut(0));
    
    
    L5 : LatchFxp
    generic map (
        LatchMode => 1,
        dataInWL  => 16,
        dataOutWL => 16)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => D1_dataOut,
        dataOut => L5_dataOut,
        latch   => D7_dataOut(0));
    
    
    L6 : LatchFxp
    generic map (
        LatchMode => 1,
        dataInWL  => 16,
        dataOutWL => 16)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => D1_dataOut,
        dataOut => L6_dataOut,
        latch   => D8_dataOut(0));
    
    
    L7 : LatchFxp
    generic map (
        LatchMode => 1,
        dataInWL  => 16,
        dataOutWL => 16)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => D1_dataOut,
        dataOut => L7_dataOut,
        latch   => D9_dataOut(0));
    
    
    L8 : LatchFxp
    generic map (
        LatchMode => 1,
        dataInWL  => 16,
        dataOutWL => 16)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => D10_dataOut,
        dataOut => L8_dataOut,
        latch   => D13_dataOut(0));
    
    
    L9 : LatchFxp
    generic map (
        LatchMode => 1,
        dataInWL  => 16,
        dataOutWL => 16)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => D10_dataOut,
        dataOut => L9_dataOut,
        latch   => D12_dataOut(0));
    
    
    coef0  <= L17_dataOut;
    coef1  <= L1_dataOut;
    coef10 <= L10_dataOut;
    coef11 <= L11_dataOut;
    coef12 <= L12_dataOut;
    coef13 <= L13_dataOut;
    coef14 <= L14_dataOut;
    coef15 <= L15_dataOut;
    coef16 <= L18_dataOut;
    coef17 <= L16_dataOut;
    coef18 <= L19_dataOut;
    coef19 <= L20_dataOut;
    coef2  <= L2_dataOut;
    coef20 <= L21_dataOut;
    coef21 <= L22_dataOut;
    coef22 <= L23_dataOut;
    coef23 <= L24_dataOut;
    coef24 <= L26_dataOut;
    coef25 <= L25_dataOut;
    coef26 <= L27_dataOut;
    coef27 <= L28_dataOut;
    coef28 <= L29_dataOut;
    coef29 <= L30_dataOut;
    coef3  <= L3_dataOut;
    coef30 <= L31_dataOut;
    coef31 <= L32_dataOut;
    coef4  <= L4_dataOut;
    coef5  <= L5_dataOut;
    coef6  <= L6_dataOut;
    coef7  <= L7_dataOut;
    coef8  <= L9_dataOut;
    coef9  <= L8_dataOut;

end unroll_reconfig_coef_Subnetwork1_Arch;


