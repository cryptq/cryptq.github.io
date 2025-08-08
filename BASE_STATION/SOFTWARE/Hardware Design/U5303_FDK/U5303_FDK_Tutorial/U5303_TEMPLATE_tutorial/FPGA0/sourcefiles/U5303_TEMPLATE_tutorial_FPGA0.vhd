-------------------------------------------------------------------------------
-- Automatically generated VHDL code for non-primitive component
-- U5303_TEMPLATE_tutorial_FPGA0.vhd
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library work;
use work.p_fxp.all;


entity U5303_TEMPLATE_tutorial_FPGA0 is
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
end U5303_TEMPLATE_tutorial_FPGA0;


architecture U5303_TEMPLATE_tutorial_FPGA0_Arch of U5303_TEMPLATE_tutorial_FPGA0 is
    
    component BitMergeFxp
        generic (
            Overflow            : integer;
            Quantization        : integer;
            SaturationBits      : integer;
            UseInputWordlengths : integer;
            dataLSWL            : integer;
            dataMSWL            : integer;
            dataOutIWL          : integer;
            dataOutSGN          : integer;
            dataOutWL           : integer);
        port (
            dataLS  : in  std_logic_vector(dataLSWL-1 downto 0);
            dataMS  : in  std_logic_vector(dataMSWL-1 downto 0);
            dataOut : out std_logic_vector(dataOutWL-1 downto 0));
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
    
    component FIR_Fxp1
        generic (
            AccumulatorIntegerWordlength : integer;
            AccumulatorIsSigned          : integer;
            AccumulatorWordlength        : integer;
            DecimationFactor             : integer;
            FxpCoeff                     : string;
            InterpolationFactor          : integer;
            OutputOverflow               : integer;
            OutputQuantization           : integer;
            OutputSaturationBits         : integer;
            dataInIWL                    : integer;
            dataInSGN                    : integer;
            dataInWL                     : integer;
            dataOutIWL                   : integer;
            dataOutSGN                   : integer;
            dataOutWL                    : integer);
        port (
            CE      : in  std_logic;
            CLK     : in  std_logic;
            RDY     : out std_logic;
            RST     : in  std_logic;
            dataIn  : in  std_logic_vector(dataInWL-1 downto 0);
            dataOut : out std_logic_vector(dataOutWL-1 downto 0));
    end component;
    
    component FIR_Fxp2
        generic (
            AccumulatorIntegerWordlength : integer;
            AccumulatorIsSigned          : integer;
            AccumulatorWordlength        : integer;
            DecimationFactor             : integer;
            FxpCoeff                     : string;
            InterpolationFactor          : integer;
            OutputOverflow               : integer;
            OutputQuantization           : integer;
            OutputSaturationBits         : integer;
            dataInIWL                    : integer;
            dataInSGN                    : integer;
            dataInWL                     : integer;
            dataOutIWL                   : integer;
            dataOutSGN                   : integer;
            dataOutWL                    : integer);
        port (
            CE      : in  std_logic;
            CLK     : in  std_logic;
            RDY     : out std_logic;
            RST     : in  std_logic;
            dataIn  : in  std_logic_vector(dataInWL-1 downto 0);
            dataOut : out std_logic_vector(dataOutWL-1 downto 0));
    end component;
    
    component FIR_Fxp3
        generic (
            AccumulatorIntegerWordlength : integer;
            AccumulatorIsSigned          : integer;
            AccumulatorWordlength        : integer;
            DecimationFactor             : integer;
            FxpCoeff                     : string;
            InterpolationFactor          : integer;
            OutputOverflow               : integer;
            OutputQuantization           : integer;
            OutputSaturationBits         : integer;
            dataInIWL                    : integer;
            dataInSGN                    : integer;
            dataInWL                     : integer;
            dataOutIWL                   : integer;
            dataOutSGN                   : integer;
            dataOutWL                    : integer);
        port (
            CE      : in  std_logic;
            CLK     : in  std_logic;
            RDY     : out std_logic;
            RST     : in  std_logic;
            dataIn  : in  std_logic_vector(dataInWL-1 downto 0);
            dataOut : out std_logic_vector(dataOutWL-1 downto 0));
    end component;
    
    component FIR_Fxp4
        generic (
            AccumulatorIntegerWordlength : integer;
            AccumulatorIsSigned          : integer;
            AccumulatorWordlength        : integer;
            DecimationFactor             : integer;
            FxpCoeff                     : string;
            InterpolationFactor          : integer;
            OutputOverflow               : integer;
            OutputQuantization           : integer;
            OutputSaturationBits         : integer;
            dataInIWL                    : integer;
            dataInSGN                    : integer;
            dataInWL                     : integer;
            dataOutIWL                   : integer;
            dataOutSGN                   : integer;
            dataOutWL                    : integer);
        port (
            CE      : in  std_logic;
            CLK     : in  std_logic;
            RDY     : out std_logic;
            RST     : in  std_logic;
            dataIn  : in  std_logic_vector(dataInWL-1 downto 0);
            dataOut : out std_logic_vector(dataOutWL-1 downto 0));
    end component;
    
    component ADCConvert_16To8_Subnetwork1
        port (
            ADCIn1    : in  std_logic_vector(15 downto 0);
            ADCIn10   : in  std_logic_vector(15 downto 0);
            ADCIn11   : in  std_logic_vector(15 downto 0);
            ADCIn12   : in  std_logic_vector(15 downto 0);
            ADCIn13   : in  std_logic_vector(15 downto 0);
            ADCIn14   : in  std_logic_vector(15 downto 0);
            ADCIn15   : in  std_logic_vector(15 downto 0);
            ADCIn16   : in  std_logic_vector(15 downto 0);
            ADCIn2    : in  std_logic_vector(15 downto 0);
            ADCIn3    : in  std_logic_vector(15 downto 0);
            ADCIn4    : in  std_logic_vector(15 downto 0);
            ADCIn5    : in  std_logic_vector(15 downto 0);
            ADCIn6    : in  std_logic_vector(15 downto 0);
            ADCIn7    : in  std_logic_vector(15 downto 0);
            ADCIn8    : in  std_logic_vector(15 downto 0);
            ADCIn9    : in  std_logic_vector(15 downto 0);
            ADCOut1   : out std_logic_vector(15 downto 0);
            ADCOut2   : out std_logic_vector(15 downto 0);
            ADCOut3   : out std_logic_vector(15 downto 0);
            ADCOut4   : out std_logic_vector(15 downto 0);
            ADCOut5   : out std_logic_vector(15 downto 0);
            ADCOut6   : out std_logic_vector(15 downto 0);
            ADCOut7   : out std_logic_vector(15 downto 0);
            ADCOut8   : out std_logic_vector(15 downto 0);
            ADC_Valid : in  std_logic_vector(0 downto 0);
            ce1       : in  std_logic;
            clk       : in  std_logic;
            rst       : in  std_logic);
    end component;
    
    component ADCConvert_16To8_Subnetwork2
        port (
            ADCIn1    : in  std_logic_vector(15 downto 0);
            ADCIn10   : in  std_logic_vector(15 downto 0);
            ADCIn11   : in  std_logic_vector(15 downto 0);
            ADCIn12   : in  std_logic_vector(15 downto 0);
            ADCIn13   : in  std_logic_vector(15 downto 0);
            ADCIn14   : in  std_logic_vector(15 downto 0);
            ADCIn15   : in  std_logic_vector(15 downto 0);
            ADCIn16   : in  std_logic_vector(15 downto 0);
            ADCIn2    : in  std_logic_vector(15 downto 0);
            ADCIn3    : in  std_logic_vector(15 downto 0);
            ADCIn4    : in  std_logic_vector(15 downto 0);
            ADCIn5    : in  std_logic_vector(15 downto 0);
            ADCIn6    : in  std_logic_vector(15 downto 0);
            ADCIn7    : in  std_logic_vector(15 downto 0);
            ADCIn8    : in  std_logic_vector(15 downto 0);
            ADCIn9    : in  std_logic_vector(15 downto 0);
            ADCOut1   : out std_logic_vector(15 downto 0);
            ADCOut2   : out std_logic_vector(15 downto 0);
            ADCOut3   : out std_logic_vector(15 downto 0);
            ADCOut4   : out std_logic_vector(15 downto 0);
            ADCOut5   : out std_logic_vector(15 downto 0);
            ADCOut6   : out std_logic_vector(15 downto 0);
            ADCOut7   : out std_logic_vector(15 downto 0);
            ADCOut8   : out std_logic_vector(15 downto 0);
            ADC_Valid : in  std_logic_vector(0 downto 0);
            ce1       : in  std_logic;
            clk       : in  std_logic;
            rst       : in  std_logic);
    end component;
    
    signal B12_dataOut         : std_logic_vector(0 downto 0);
    signal B1_dataOut          : std_logic_vector(0 downto 0);
    signal B2_dataOut          : std_logic_vector(0 downto 0);
    signal B4_dataOut          : std_logic_vector(1 downto 0);
    signal B5_dataOut          : std_logic_vector(1 downto 0);
    signal D13_dataOut         : std_logic_vector(15 downto 0);
    signal D5_dataOut          : std_logic_vector(15 downto 0);
    signal D6_dataOut          : std_logic_vector(15 downto 0);
    signal D7_dataOut          : std_logic_vector(15 downto 0);
    signal D8_dataOut          : std_logic_vector(15 downto 0);
    signal D9_dataOut          : std_logic_vector(15 downto 0);
    signal F1_dataOut          : std_logic_vector(15 downto 0);
    signal F2_dataOut          : std_logic_vector(15 downto 0);
    signal F3_dataOut          : std_logic_vector(15 downto 0);
    signal F4_dataOut          : std_logic_vector(15 downto 0);
    signal M1_dataOut          : std_logic_vector(15 downto 0);
    signal M2_dataOut          : std_logic_vector(15 downto 0);
    signal Subnetwork1_ADCOut1 : std_logic_vector(15 downto 0);
    signal Subnetwork2_ADCOut1 : std_logic_vector(15 downto 0);

begin
    
    B1_dataOut <= "1";
    
    
    
    B12_dataOut <= "1";
    
    
    
    B2_dataOut <= "1";
    
    
    
    B4 : BitMergeFxp
    generic map (
        Overflow            => 3,
        Quantization        => 5,
        SaturationBits      => 0,
        UseInputWordlengths => 0,
        dataLSWL            => 1,
        dataMSWL            => 1,
        dataOutIWL          => 2,
        dataOutSGN          => 0,
        dataOutWL           => 2)
    port map (
        dataLS  => B1_dataOut,
        dataMS  => ADCValidIn,
        dataOut => B4_dataOut);
    
    
    B5 : BitMergeFxp
    generic map (
        Overflow            => 3,
        Quantization        => 5,
        SaturationBits      => 0,
        UseInputWordlengths => 0,
        dataLSWL            => 1,
        dataMSWL            => 1,
        dataOutIWL          => 2,
        dataOutSGN          => 0,
        dataOutWL           => 2)
    port map (
        dataLS  => B2_dataOut,
        dataMS  => Register1,
        dataOut => B5_dataOut);
    
    
    D13 : DelayFxp
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
        dataIn  => M2_dataOut,
        dataOut => D13_dataOut);
    
    
    D2 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 2,
        dataOutSGN   => 0,
        dataOutWL    => 2)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => B4_dataOut,
        dataOut => open);
    
    
    D4 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 2,
        dataOutSGN   => 0,
        dataOutWL    => 2)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => B5_dataOut,
        dataOut => open);
    
    
    D5 : DelayFxp
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
        dataIn  => M1_dataOut,
        dataOut => D5_dataOut);
    
    
    D6 : DelayFxp
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
        dataIn  => F1_dataOut,
        dataOut => D6_dataOut);
    
    
    D7 : DelayFxp
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
        dataIn  => F2_dataOut,
        dataOut => D7_dataOut);
    
    
    D8 : DelayFxp
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
        dataIn  => F3_dataOut,
        dataOut => D8_dataOut);
    
    
    D9 : DelayFxp
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
        dataIn  => F4_dataOut,
        dataOut => D9_dataOut);
    
    
    F1 : FIR_Fxp1
    generic map (
        AccumulatorIntegerWordlength => 2,
        AccumulatorIsSigned          => 1,
        AccumulatorWordlength        => 32,
        DecimationFactor             => 1,
        FxpCoeff                     => "",
        InterpolationFactor          => 1,
        OutputOverflow               => 3,
        OutputQuantization           => 5,
        OutputSaturationBits         => 0,
        dataInIWL                    => 1,
        dataInSGN                    => 1,
        dataInWL                     => 16,
        dataOutIWL                   => 2,
        dataOutSGN                   => 1,
        dataOutWL                    => 16)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => Subnetwork1_ADCOut1,
        dataOut => F1_dataOut);
    
    
    F2 : FIR_Fxp2
    generic map (
        AccumulatorIntegerWordlength => 2,
        AccumulatorIsSigned          => 1,
        AccumulatorWordlength        => 32,
        DecimationFactor             => 1,
        FxpCoeff                     => "",
        InterpolationFactor          => 1,
        OutputOverflow               => 3,
        OutputQuantization           => 5,
        OutputSaturationBits         => 0,
        dataInIWL                    => 1,
        dataInSGN                    => 1,
        dataInWL                     => 16,
        dataOutIWL                   => 2,
        dataOutSGN                   => 1,
        dataOutWL                    => 16)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => Subnetwork2_ADCOut1,
        dataOut => F2_dataOut);
    
    
    F3 : FIR_Fxp3
    generic map (
        AccumulatorIntegerWordlength => 2,
        AccumulatorIsSigned          => 1,
        AccumulatorWordlength        => 32,
        DecimationFactor             => 1,
        FxpCoeff                     => "",
        InterpolationFactor          => 1,
        OutputOverflow               => 3,
        OutputQuantization           => 5,
        OutputSaturationBits         => 0,
        dataInIWL                    => 1,
        dataInSGN                    => 1,
        dataInWL                     => 16,
        dataOutIWL                   => 2,
        dataOutSGN                   => 1,
        dataOutWL                    => 16)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => Subnetwork1_ADCOut1,
        dataOut => F3_dataOut);
    
    
    F4 : FIR_Fxp4
    generic map (
        AccumulatorIntegerWordlength => 2,
        AccumulatorIsSigned          => 1,
        AccumulatorWordlength        => 32,
        DecimationFactor             => 1,
        FxpCoeff                     => "",
        InterpolationFactor          => 1,
        OutputOverflow               => 3,
        OutputQuantization           => 5,
        OutputSaturationBits         => 0,
        dataInIWL                    => 1,
        dataInSGN                    => 1,
        dataInWL                     => 16,
        dataOutIWL                   => 2,
        dataOutSGN                   => 1,
        dataOutWL                    => 16)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => Subnetwork2_ADCOut1,
        dataOut => F4_dataOut);
    
    
    with to_integer(unsigned(Register1)) select
    M1_dataOut <=
        D6_dataOut when 0,
        D8_dataOut when 1,
        (others => '0') when others;
    
    
    
    
    with to_integer(unsigned(Register1)) select
    M2_dataOut <=
        D7_dataOut when 0,
        D9_dataOut when 1,
        (others => '0') when others;
    
    
    
    
    Subnetwork1 : ADCConvert_16To8_Subnetwork1
    port map (
        ADCIn1    => ADC1,
        ADCIn10   => ADC10,
        ADCIn11   => ADC11,
        ADCIn12   => ADC12,
        ADCIn13   => ADC13,
        ADCIn14   => ADC14,
        ADCIn15   => ADC15,
        ADCIn16   => ADC16,
        ADCIn2    => ADC2,
        ADCIn3    => ADC3,
        ADCIn4    => ADC4,
        ADCIn5    => ADC5,
        ADCIn6    => ADC6,
        ADCIn7    => ADC7,
        ADCIn8    => ADC8,
        ADCIn9    => ADC9,
        ADCOut1   => Subnetwork1_ADCOut1,
        ADCOut2   => open,
        ADCOut3   => open,
        ADCOut4   => open,
        ADCOut5   => open,
        ADCOut6   => open,
        ADCOut7   => open,
        ADCOut8   => open,
        ADC_Valid => ADCValidIn,
        ce1       => ce1,
        clk       => clk,
        rst       => rst);
    
    
    Subnetwork2 : ADCConvert_16To8_Subnetwork2
    port map (
        ADCIn1    => ADC17,
        ADCIn10   => ADC26,
        ADCIn11   => ADC27,
        ADCIn12   => ADC28,
        ADCIn13   => ADC29,
        ADCIn14   => ADC30,
        ADCIn15   => ADC31,
        ADCIn16   => ADC32,
        ADCIn2    => ADC18,
        ADCIn3    => ADC19,
        ADCIn4    => ADC20,
        ADCIn5    => ADC21,
        ADCIn6    => ADC22,
        ADCIn7    => ADC23,
        ADCIn8    => ADC24,
        ADCIn9    => ADC25,
        ADCOut1   => Subnetwork2_ADCOut1,
        ADCOut2   => open,
        ADCOut3   => open,
        ADCOut4   => open,
        ADCOut5   => open,
        ADCOut6   => open,
        ADCOut7   => open,
        ADCOut8   => open,
        ADC_Valid => ADCValidIn,
        ce1       => ce1,
        clk       => clk,
        rst       => rst);
    
    
    DataOut1  <= D5_dataOut;
    DataOut2  <= D13_dataOut;
    ValidOut1 <= B12_dataOut;

end U5303_TEMPLATE_tutorial_FPGA0_Arch;


