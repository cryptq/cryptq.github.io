-------------------------------------------------------------------------------
-- Automatically generated VHDL code for non-primitive component
-- trig_gen_Subnetwork24.vhd
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library work;
use work.p_fxp.all;


entity trig_gen_Subnetwork24 is
    port (
        In0       : in  std_logic_vector(15 downto 0);
        In1       : in  std_logic_vector(15 downto 0);
        In10      : in  std_logic_vector(15 downto 0);
        In11      : in  std_logic_vector(15 downto 0);
        In12      : in  std_logic_vector(15 downto 0);
        In13      : in  std_logic_vector(15 downto 0);
        In14      : in  std_logic_vector(15 downto 0);
        In15      : in  std_logic_vector(15 downto 0);
        In2       : in  std_logic_vector(15 downto 0);
        In3       : in  std_logic_vector(15 downto 0);
        In4       : in  std_logic_vector(15 downto 0);
        In5       : in  std_logic_vector(15 downto 0);
        In6       : in  std_logic_vector(15 downto 0);
        In7       : in  std_logic_vector(15 downto 0);
        In8       : in  std_logic_vector(15 downto 0);
        In9       : in  std_logic_vector(15 downto 0);
        ce1       : in  std_logic;
        ce2       : in  std_logic;
        clk       : in  std_logic;
        ena       : in  std_logic_vector(0 downto 0);
        rst       : in  std_logic;
        start_pos : out std_logic_vector(7 downto 0);
        threshold : in  std_logic_vector(15 downto 0);
        trig_out  : out std_logic_vector(0 downto 0));
end trig_gen_Subnetwork24;


architecture trig_gen_Subnetwork24_Arch of trig_gen_Subnetwork24 is
    
    component AddFxp
        generic (
            Overflow       : integer;
            Quantization   : integer;
            SaturationBits : integer;
            dataIn1IWL     : integer;
            dataIn1SGN     : integer;
            dataIn1WL      : integer;
            dataIn2IWL     : integer;
            dataIn2SGN     : integer;
            dataIn2WL      : integer;
            dataOutIWL     : integer;
            dataOutSGN     : integer;
            dataOutWL      : integer);
        port (
            dataIn1 : in  std_logic_vector(dataIn1WL-1 downto 0);
            dataIn2 : in  std_logic_vector(dataIn2WL-1 downto 0);
            dataOut : out std_logic_vector(dataOutWL-1 downto 0));
    end component;
    
    component ABS_Fxp
        generic (
            Overflow       : integer;
            Quantization   : integer;
            SaturationBits : integer;
            dataInIWL      : integer;
            dataInSGN      : integer;
            dataInWL       : integer;
            dataOutIWL     : integer;
            dataOutSGN     : integer;
            dataOutWL      : integer);
        port (
            dataIn  : in  std_logic_vector(dataInWL-1 downto 0);
            dataOut : out std_logic_vector(dataOutWL-1 downto 0));
    end component;
    
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
    
    component CompareFxp
        generic (
            CompareOperation : integer;
            dataInAIWL       : integer;
            dataInASGN       : integer;
            dataInAWL        : integer;
            dataInBIWL       : integer;
            dataInBSGN       : integer;
            dataInBWL        : integer;
            dataOutWL        : integer);
        port (
            dataInA : in  std_logic_vector(dataInAWL-1 downto 0);
            dataInB : in  std_logic_vector(dataInBWL-1 downto 0);
            dataOut : out std_logic);
    end component;
    
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
    
    component CounterFxp
        generic (
            Direction      : integer;
            FxpInitValue   : integer;
            Overflow       : integer;
            Quantization   : integer;
            SaturationBits : integer;
            StepFxp        : integer;
            dataOutIWL     : integer;
            dataOutSGN     : integer;
            dataOutWL      : integer);
        port (
            ce      : in  std_logic;
            clk     : in  std_logic;
            dataOut : out std_logic_vector(dataOutWL-1 downto 0);
            enable  : in  std_logic;
            rdy     : out std_logic;
            reset   : in  std_logic;
            rst     : in  std_logic);
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
    
    component DownSampleFxp
        generic (
            Factor    : integer;
            Phase     : integer;
            dataInWL  : integer;
            dataOutWL : integer);
        port (
            ce      : in  std_logic;
            clk     : in  std_logic;
            dataIn  : in  std_logic_vector(dataInWL-1 downto 0);
            dataOut : out std_logic_vector(dataOutWL-1 downto 0);
            rst     : in  std_logic);
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
    
    component NOT_Fxp
        generic (
            dataInWL  : integer;
            dataOutWL : integer);
        port (
            dataIn  : in  std_logic_vector(dataInWL-1 downto 0);
            dataOut : out std_logic_vector(dataOutWL-1 downto 0));
    end component;
    
    signal A10_dataOut : std_logic_vector(15 downto 0);
    signal A11_dataOut : std_logic_vector(15 downto 0);
    signal A12_dataOut : std_logic_vector(15 downto 0);
    signal A13_dataOut : std_logic_vector(15 downto 0);
    signal A14_dataOut : std_logic_vector(15 downto 0);
    signal A15_dataOut : std_logic_vector(15 downto 0);
    signal A16_dataOut : std_logic_vector(15 downto 0);
    signal A17_dataOut : std_logic_vector(15 downto 0);
    signal A18_dataOut : std_logic_vector(15 downto 0);
    signal A19_dataOut : std_logic_vector(15 downto 0);
    signal A1_dataOut  : std_logic_vector(15 downto 0);
    signal A20_dataOut : std_logic_vector(15 downto 0);
    signal A21_dataOut : std_logic_vector(15 downto 0);
    signal A22_dataOut : std_logic_vector(15 downto 0);
    signal A23_dataOut : std_logic_vector(15 downto 0);
    signal A24_dataOut : std_logic_vector(15 downto 0);
    signal A25_dataOut : std_logic_vector(15 downto 0);
    signal A26_dataOut : std_logic_vector(15 downto 0);
    signal A27_dataOut : std_logic_vector(15 downto 0);
    signal A28_dataOut : std_logic_vector(15 downto 0);
    signal A29_dataOut : std_logic_vector(15 downto 0);
    signal A2_dataOut  : std_logic_vector(15 downto 0);
    signal A30_dataOut : std_logic_vector(15 downto 0);
    signal A31_dataOut : std_logic_vector(15 downto 0);
    signal A32_dataOut : std_logic_vector(15 downto 0);
    signal A33_dataOut : std_logic_vector(15 downto 0);
    signal A34_dataOut : std_logic_vector(15 downto 0);
    signal A35_dataOut : std_logic_vector(15 downto 0);
    signal A36_dataOut : std_logic_vector(15 downto 0);
    signal A37_dataOut : std_logic_vector(15 downto 0);
    signal A38_dataOut : std_logic_vector(15 downto 0);
    signal A39_dataOut : std_logic_vector(15 downto 0);
    signal A3_dataOut  : std_logic_vector(15 downto 0);
    signal A40_dataOut : std_logic_vector(15 downto 0);
    signal A41_dataOut : std_logic_vector(15 downto 0);
    signal A42_dataOut : std_logic_vector(15 downto 0);
    signal A43_dataOut : std_logic_vector(15 downto 0);
    signal A44_dataOut : std_logic_vector(15 downto 0);
    signal A45_dataOut : std_logic_vector(15 downto 0);
    signal A46_dataOut : std_logic_vector(15 downto 0);
    signal A47_dataOut : std_logic_vector(15 downto 0);
    signal A48_dataOut : std_logic_vector(15 downto 0);
    signal A49_dataOut : std_logic_vector(15 downto 0);
    signal A4_dataOut  : std_logic_vector(15 downto 0);
    signal A50_dataOut : std_logic_vector(15 downto 0);
    signal A51_dataOut : std_logic_vector(15 downto 0);
    signal A52_dataOut : std_logic_vector(15 downto 0);
    signal A53_dataOut : std_logic_vector(15 downto 0);
    signal A54_dataOut : std_logic_vector(0 downto 0);
    signal A55_dataOut : std_logic_vector(0 downto 0);
    signal A5_dataOut  : std_logic_vector(15 downto 0);
    signal A6_dataOut  : std_logic_vector(15 downto 0);
    signal A7_dataOut  : std_logic_vector(15 downto 0);
    signal A8_dataOut  : std_logic_vector(15 downto 0);
    signal A9_dataOut  : std_logic_vector(15 downto 0);
    signal B10_dataOut : std_logic_vector(3 downto 0);
    signal B11_dataOut : std_logic_vector(3 downto 0);
    signal B12_dataOut : std_logic_vector(3 downto 0);
    signal B13_dataOut : std_logic_vector(7 downto 0);
    signal B14_dataOut : std_logic_vector(7 downto 0);
    signal B15_dataOut : std_logic_vector(15 downto 0);
    signal B16_dataOut : std_logic_vector(0 downto 0);
    signal B17_dataOut : std_logic_vector(0 downto 0);
    signal B18_dataOut : std_logic_vector(0 downto 0);
    signal B1_dataOut  : std_logic_vector(1 downto 0);
    signal B2_dataOut  : std_logic_vector(1 downto 0);
    signal B3_dataOut  : std_logic_vector(1 downto 0);
    signal B4_dataOut  : std_logic_vector(1 downto 0);
    signal B5_dataOut  : std_logic_vector(1 downto 0);
    signal B6_dataOut  : std_logic_vector(1 downto 0);
    signal B7_dataOut  : std_logic_vector(1 downto 0);
    signal B8_dataOut  : std_logic_vector(1 downto 0);
    signal B9_dataOut  : std_logic_vector(3 downto 0);
    signal C10_dataOut : std_logic_vector(0 downto 0);
    signal C11_dataOut : std_logic_vector(0 downto 0);
    signal C12_dataOut : std_logic_vector(0 downto 0);
    signal C13_dataOut : std_logic_vector(0 downto 0);
    signal C14_dataOut : std_logic_vector(0 downto 0);
    signal C15_dataOut : std_logic_vector(0 downto 0);
    signal C16_dataOut : std_logic_vector(0 downto 0);
    signal C17_dataOut : std_logic_vector(0 downto 0);
    signal C18_dataOut : std_logic_vector(7 downto 0);
    signal C1_dataOut  : std_logic_vector(0 downto 0);
    signal C2_dataOut  : std_logic_vector(0 downto 0);
    signal C3_dataOut  : std_logic_vector(0 downto 0);
    signal C4_dataOut  : std_logic_vector(0 downto 0);
    signal C5_dataOut  : std_logic_vector(0 downto 0);
    signal C6_dataOut  : std_logic_vector(0 downto 0);
    signal C7_dataOut  : std_logic_vector(0 downto 0);
    signal C8_dataOut  : std_logic_vector(0 downto 0);
    signal C9_dataOut  : std_logic_vector(0 downto 0);
    signal D10_dataOut : std_logic_vector(15 downto 0);
    signal D11_dataOut : std_logic_vector(15 downto 0);
    signal D12_dataOut : std_logic_vector(15 downto 0);
    signal D13_dataOut : std_logic_vector(15 downto 0);
    signal D14_dataOut : std_logic_vector(15 downto 0);
    signal D15_dataOut : std_logic_vector(15 downto 0);
    signal D16_dataOut : std_logic_vector(15 downto 0);
    signal D17_dataOut : std_logic_vector(15 downto 0);
    signal D18_dataOut : std_logic_vector(15 downto 0);
    signal D19_dataOut : std_logic_vector(15 downto 0);
    signal D1_dataOut  : std_logic_vector(15 downto 0);
    signal D20_dataOut : std_logic_vector(15 downto 0);
    signal D21_dataOut : std_logic_vector(15 downto 0);
    signal D22_dataOut : std_logic_vector(15 downto 0);
    signal D23_dataOut : std_logic_vector(15 downto 0);
    signal D24_dataOut : std_logic_vector(15 downto 0);
    signal D25_dataOut : std_logic_vector(15 downto 0);
    signal D26_dataOut : std_logic_vector(15 downto 0);
    signal D27_dataOut : std_logic_vector(15 downto 0);
    signal D28_dataOut : std_logic_vector(15 downto 0);
    signal D29_dataOut : std_logic_vector(15 downto 0);
    signal D2_dataOut  : std_logic_vector(15 downto 0);
    signal D30_dataOut : std_logic_vector(15 downto 0);
    signal D31_dataOut : std_logic_vector(15 downto 0);
    signal D32_dataOut : std_logic_vector(15 downto 0);
    signal D33_dataOut : std_logic_vector(15 downto 0);
    signal D34_dataOut : std_logic_vector(15 downto 0);
    signal D35_dataOut : std_logic_vector(15 downto 0);
    signal D36_dataOut : std_logic_vector(15 downto 0);
    signal D37_dataOut : std_logic_vector(15 downto 0);
    signal D38_dataOut : std_logic_vector(15 downto 0);
    signal D39_dataOut : std_logic_vector(15 downto 0);
    signal D3_dataOut  : std_logic_vector(15 downto 0);
    signal D40_dataOut : std_logic_vector(15 downto 0);
    signal D41_dataOut : std_logic_vector(15 downto 0);
    signal D42_dataOut : std_logic_vector(15 downto 0);
    signal D43_dataOut : std_logic_vector(15 downto 0);
    signal D44_dataOut : std_logic_vector(15 downto 0);
    signal D45_dataOut : std_logic_vector(15 downto 0);
    signal D46_dataOut : std_logic_vector(15 downto 0);
    signal D47_dataOut : std_logic_vector(15 downto 0);
    signal D48_dataOut : std_logic_vector(15 downto 0);
    signal D49_dataOut : std_logic_vector(15 downto 0);
    signal D4_dataOut  : std_logic_vector(15 downto 0);
    signal D50_dataOut : std_logic_vector(15 downto 0);
    signal D51_dataOut : std_logic_vector(15 downto 0);
    signal D52_dataOut : std_logic_vector(15 downto 0);
    signal D53_dataOut : std_logic_vector(15 downto 0);
    signal D54_dataOut : std_logic_vector(15 downto 0);
    signal D55_dataOut : std_logic_vector(15 downto 0);
    signal D56_dataOut : std_logic_vector(15 downto 0);
    signal D57_dataOut : std_logic_vector(15 downto 0);
    signal D58_dataOut : std_logic_vector(15 downto 0);
    signal D59_dataOut : std_logic_vector(15 downto 0);
    signal D5_dataOut  : std_logic_vector(15 downto 0);
    signal D60_dataOut : std_logic_vector(15 downto 0);
    signal D61_dataOut : std_logic_vector(15 downto 0);
    signal D62_dataOut : std_logic_vector(15 downto 0);
    signal D63_dataOut : std_logic_vector(15 downto 0);
    signal D64_dataOut : std_logic_vector(15 downto 0);
    signal D65_dataOut : std_logic_vector(15 downto 0);
    signal D66_dataOut : std_logic_vector(15 downto 0);
    signal D67_dataOut : std_logic_vector(15 downto 0);
    signal D68_dataOut : std_logic_vector(15 downto 0);
    signal D69_dataOut : std_logic_vector(15 downto 0);
    signal D6_dataOut  : std_logic_vector(15 downto 0);
    signal D70_dataOut : std_logic_vector(15 downto 0);
    signal D71_dataOut : std_logic_vector(15 downto 0);
    signal D72_dataOut : std_logic_vector(15 downto 0);
    signal D73_dataOut : std_logic_vector(15 downto 0);
    signal D74_dataOut : std_logic_vector(15 downto 0);
    signal D75_dataOut : std_logic_vector(0 downto 0);
    signal D76_dataOut : std_logic_vector(0 downto 0);
    signal D77_dataOut : std_logic_vector(0 downto 0);
    signal D78_dataOut : std_logic_vector(0 downto 0);
    signal D79_dataOut : std_logic_vector(15 downto 0);
    signal D7_dataOut  : std_logic_vector(15 downto 0);
    signal D80_dataOut : std_logic_vector(15 downto 0);
    signal D81_dataOut : std_logic_vector(15 downto 0);
    signal D82_dataOut : std_logic_vector(15 downto 0);
    signal D83_dataOut : std_logic_vector(15 downto 0);
    signal D84_dataOut : std_logic_vector(15 downto 0);
    signal D85_dataOut : std_logic_vector(15 downto 0);
    signal D86_dataOut : std_logic_vector(15 downto 0);
    signal D87_dataOut : std_logic_vector(15 downto 0);
    signal D88_dataOut : std_logic_vector(15 downto 0);
    signal D89_dataOut : std_logic_vector(15 downto 0);
    signal D8_dataOut  : std_logic_vector(15 downto 0);
    signal D90_dataOut : std_logic_vector(15 downto 0);
    signal D91_dataOut : std_logic_vector(15 downto 0);
    signal D92_dataOut : std_logic_vector(15 downto 0);
    signal D93_dataOut : std_logic_vector(15 downto 0);
    signal D94_dataOut : std_logic_vector(15 downto 0);
    signal D95_dataOut : std_logic_vector(15 downto 0);
    signal D9_dataOut  : std_logic_vector(15 downto 0);
    signal L1_dataOut  : std_logic_vector(0 downto 0);
    signal L2_dataOut  : std_logic_vector(7 downto 0);
    signal N1_dataOut  : std_logic_vector(0 downto 0);

begin
    
    A1 : AddFxp
    generic map (
        Overflow       => 3,
        Quantization   => 5,
        SaturationBits => 0,
        dataIn1IWL     => 2,
        dataIn1SGN     => 0,
        dataIn1WL      => 16,
        dataIn2IWL     => 2,
        dataIn2SGN     => 0,
        dataIn2WL      => 16,
        dataOutIWL     => 3,
        dataOutSGN     => 0,
        dataOutWL      => 16)
    port map (
        dataIn1 => D34_dataOut,
        dataIn2 => D13_dataOut,
        dataOut => A1_dataOut);
    
    
    A10 : ABS_Fxp
    generic map (
        Overflow       => 3,
        Quantization   => 5,
        SaturationBits => 0,
        dataInIWL      => 1,
        dataInSGN      => 1,
        dataInWL       => 16,
        dataOutIWL     => 1,
        dataOutSGN     => 0,
        dataOutWL      => 16)
    port map (
        dataIn  => D3_dataOut,
        dataOut => A10_dataOut);
    
    
    A11 : ABS_Fxp
    generic map (
        Overflow       => 3,
        Quantization   => 5,
        SaturationBits => 0,
        dataInIWL      => 1,
        dataInSGN      => 1,
        dataInWL       => 16,
        dataOutIWL     => 1,
        dataOutSGN     => 0,
        dataOutWL      => 16)
    port map (
        dataIn  => D4_dataOut,
        dataOut => A11_dataOut);
    
    
    A12 : ABS_Fxp
    generic map (
        Overflow       => 3,
        Quantization   => 5,
        SaturationBits => 0,
        dataInIWL      => 1,
        dataInSGN      => 1,
        dataInWL       => 16,
        dataOutIWL     => 1,
        dataOutSGN     => 0,
        dataOutWL      => 16)
    port map (
        dataIn  => D6_dataOut,
        dataOut => A12_dataOut);
    
    
    A13 : AddFxp
    generic map (
        Overflow       => 3,
        Quantization   => 5,
        SaturationBits => 0,
        dataIn1IWL     => 1,
        dataIn1SGN     => 0,
        dataIn1WL      => 16,
        dataIn2IWL     => 1,
        dataIn2SGN     => 0,
        dataIn2WL      => 16,
        dataOutIWL     => 2,
        dataOutSGN     => 0,
        dataOutWL      => 16)
    port map (
        dataIn1 => D30_dataOut,
        dataIn2 => D11_dataOut,
        dataOut => A13_dataOut);
    
    
    A14 : AddFxp
    generic map (
        Overflow       => 3,
        Quantization   => 5,
        SaturationBits => 0,
        dataIn1IWL     => 1,
        dataIn1SGN     => 0,
        dataIn1WL      => 16,
        dataIn2IWL     => 1,
        dataIn2SGN     => 0,
        dataIn2WL      => 16,
        dataOutIWL     => 2,
        dataOutSGN     => 0,
        dataOutWL      => 16)
    port map (
        dataIn1 => D33_dataOut,
        dataIn2 => D30_dataOut,
        dataOut => A14_dataOut);
    
    
    A15 : AddFxp
    generic map (
        Overflow       => 3,
        Quantization   => 5,
        SaturationBits => 0,
        dataIn1IWL     => 1,
        dataIn1SGN     => 0,
        dataIn1WL      => 16,
        dataIn2IWL     => 1,
        dataIn2SGN     => 0,
        dataIn2WL      => 16,
        dataOutIWL     => 2,
        dataOutSGN     => 0,
        dataOutWL      => 16)
    port map (
        dataIn1 => D15_dataOut,
        dataIn2 => D33_dataOut,
        dataOut => A15_dataOut);
    
    
    A16 : AddFxp
    generic map (
        Overflow       => 3,
        Quantization   => 5,
        SaturationBits => 0,
        dataIn1IWL     => 1,
        dataIn1SGN     => 0,
        dataIn1WL      => 16,
        dataIn2IWL     => 1,
        dataIn2SGN     => 0,
        dataIn2WL      => 16,
        dataOutIWL     => 2,
        dataOutSGN     => 0,
        dataOutWL      => 16)
    port map (
        dataIn1 => D15_dataOut,
        dataIn2 => D18_dataOut,
        dataOut => A16_dataOut);
    
    
    A17 : ABS_Fxp
    generic map (
        Overflow       => 3,
        Quantization   => 5,
        SaturationBits => 0,
        dataInIWL      => 1,
        dataInSGN      => 1,
        dataInWL       => 16,
        dataOutIWL     => 1,
        dataOutSGN     => 0,
        dataOutWL      => 16)
    port map (
        dataIn  => D25_dataOut,
        dataOut => A17_dataOut);
    
    
    A18 : ABS_Fxp
    generic map (
        Overflow       => 3,
        Quantization   => 5,
        SaturationBits => 0,
        dataInIWL      => 1,
        dataInSGN      => 1,
        dataInWL       => 16,
        dataOutIWL     => 1,
        dataOutSGN     => 0,
        dataOutWL      => 16)
    port map (
        dataIn  => D26_dataOut,
        dataOut => A18_dataOut);
    
    
    A19 : ABS_Fxp
    generic map (
        Overflow       => 3,
        Quantization   => 5,
        SaturationBits => 0,
        dataInIWL      => 1,
        dataInSGN      => 1,
        dataInWL       => 16,
        dataOutIWL     => 1,
        dataOutSGN     => 0,
        dataOutWL      => 16)
    port map (
        dataIn  => D28_dataOut,
        dataOut => A19_dataOut);
    
    
    A2 : ABS_Fxp
    generic map (
        Overflow       => 3,
        Quantization   => 5,
        SaturationBits => 0,
        dataInIWL      => 1,
        dataInSGN      => 1,
        dataInWL       => 16,
        dataOutIWL     => 1,
        dataOutSGN     => 0,
        dataOutWL      => 16)
    port map (
        dataIn  => D16_dataOut,
        dataOut => A2_dataOut);
    
    
    A20 : AddFxp
    generic map (
        Overflow       => 3,
        Quantization   => 5,
        SaturationBits => 0,
        dataIn1IWL     => 1,
        dataIn1SGN     => 0,
        dataIn1WL      => 16,
        dataIn2IWL     => 1,
        dataIn2SGN     => 0,
        dataIn2WL      => 16,
        dataOutIWL     => 2,
        dataOutSGN     => 0,
        dataOutWL      => 16)
    port map (
        dataIn1 => D42_dataOut,
        dataIn2 => D18_dataOut,
        dataOut => A20_dataOut);
    
    
    A21 : AddFxp
    generic map (
        Overflow       => 3,
        Quantization   => 5,
        SaturationBits => 0,
        dataIn1IWL     => 1,
        dataIn1SGN     => 0,
        dataIn1WL      => 16,
        dataIn2IWL     => 1,
        dataIn2SGN     => 0,
        dataIn2WL      => 16,
        dataOutIWL     => 2,
        dataOutSGN     => 0,
        dataOutWL      => 16)
    port map (
        dataIn1 => D49_dataOut,
        dataIn2 => D42_dataOut,
        dataOut => A21_dataOut);
    
    
    A22 : AddFxp
    generic map (
        Overflow       => 3,
        Quantization   => 5,
        SaturationBits => 0,
        dataIn1IWL     => 1,
        dataIn1SGN     => 0,
        dataIn1WL      => 16,
        dataIn2IWL     => 1,
        dataIn2SGN     => 0,
        dataIn2WL      => 16,
        dataOutIWL     => 2,
        dataOutSGN     => 0,
        dataOutWL      => 16)
    port map (
        dataIn1 => D35_dataOut,
        dataIn2 => D49_dataOut,
        dataOut => A22_dataOut);
    
    
    A23 : AddFxp
    generic map (
        Overflow       => 3,
        Quantization   => 5,
        SaturationBits => 0,
        dataIn1IWL     => 1,
        dataIn1SGN     => 0,
        dataIn1WL      => 16,
        dataIn2IWL     => 1,
        dataIn2SGN     => 0,
        dataIn2WL      => 16,
        dataOutIWL     => 2,
        dataOutSGN     => 0,
        dataOutWL      => 16)
    port map (
        dataIn1 => D35_dataOut,
        dataIn2 => D36_dataOut,
        dataOut => A23_dataOut);
    
    
    A24 : ABS_Fxp
    generic map (
        Overflow       => 3,
        Quantization   => 5,
        SaturationBits => 0,
        dataInIWL      => 1,
        dataInSGN      => 1,
        dataInWL       => 16,
        dataOutIWL     => 1,
        dataOutSGN     => 0,
        dataOutWL      => 16)
    port map (
        dataIn  => D29_dataOut,
        dataOut => A24_dataOut);
    
    
    A25 : ABS_Fxp
    generic map (
        Overflow       => 3,
        Quantization   => 5,
        SaturationBits => 0,
        dataInIWL      => 1,
        dataInSGN      => 1,
        dataInWL       => 16,
        dataOutIWL     => 1,
        dataOutSGN     => 0,
        dataOutWL      => 16)
    port map (
        dataIn  => D7_dataOut,
        dataOut => A25_dataOut);
    
    
    A26 : ABS_Fxp
    generic map (
        Overflow       => 3,
        Quantization   => 5,
        SaturationBits => 0,
        dataInIWL      => 1,
        dataInSGN      => 1,
        dataInWL       => 16,
        dataOutIWL     => 1,
        dataOutSGN     => 0,
        dataOutWL      => 16)
    port map (
        dataIn  => D22_dataOut,
        dataOut => A26_dataOut);
    
    
    A27 : ABS_Fxp
    generic map (
        Overflow       => 3,
        Quantization   => 5,
        SaturationBits => 0,
        dataInIWL      => 1,
        dataInSGN      => 1,
        dataInWL       => 16,
        dataOutIWL     => 1,
        dataOutSGN     => 0,
        dataOutWL      => 16)
    port map (
        dataIn  => D23_dataOut,
        dataOut => A27_dataOut);
    
    
    A28 : AddFxp
    generic map (
        Overflow       => 3,
        Quantization   => 5,
        SaturationBits => 0,
        dataIn1IWL     => 1,
        dataIn1SGN     => 0,
        dataIn1WL      => 16,
        dataIn2IWL     => 1,
        dataIn2SGN     => 0,
        dataIn2WL      => 16,
        dataOutIWL     => 2,
        dataOutSGN     => 0,
        dataOutWL      => 16)
    port map (
        dataIn1 => D36_dataOut,
        dataIn2 => D46_dataOut,
        dataOut => A28_dataOut);
    
    
    A29 : AddFxp
    generic map (
        Overflow       => 3,
        Quantization   => 5,
        SaturationBits => 0,
        dataIn1IWL     => 1,
        dataIn1SGN     => 0,
        dataIn1WL      => 16,
        dataIn2IWL     => 1,
        dataIn2SGN     => 0,
        dataIn2WL      => 16,
        dataOutIWL     => 2,
        dataOutSGN     => 0,
        dataOutWL      => 16)
    port map (
        dataIn1 => D46_dataOut,
        dataIn2 => D47_dataOut,
        dataOut => A29_dataOut);
    
    
    A3 : ABS_Fxp
    generic map (
        Overflow       => 3,
        Quantization   => 5,
        SaturationBits => 0,
        dataInIWL      => 1,
        dataInSGN      => 1,
        dataInWL       => 16,
        dataOutIWL     => 1,
        dataOutSGN     => 0,
        dataOutWL      => 16)
    port map (
        dataIn  => D17_dataOut,
        dataOut => A3_dataOut);
    
    
    A30 : AddFxp
    generic map (
        Overflow       => 3,
        Quantization   => 5,
        SaturationBits => 0,
        dataIn1IWL     => 1,
        dataIn1SGN     => 0,
        dataIn1WL      => 16,
        dataIn2IWL     => 1,
        dataIn2SGN     => 0,
        dataIn2WL      => 16,
        dataOutIWL     => 2,
        dataOutSGN     => 0,
        dataOutWL      => 16)
    port map (
        dataIn1 => D40_dataOut,
        dataIn2 => D47_dataOut,
        dataOut => A30_dataOut);
    
    
    A31 : ABS_Fxp
    generic map (
        Overflow       => 3,
        Quantization   => 5,
        SaturationBits => 0,
        dataInIWL      => 1,
        dataInSGN      => 1,
        dataInWL       => 16,
        dataOutIWL     => 1,
        dataOutSGN     => 0,
        dataOutWL      => 16)
    port map (
        dataIn  => D24_dataOut,
        dataOut => A31_dataOut);
    
    
    A32 : AddFxp
    generic map (
        Overflow       => 3,
        Quantization   => 5,
        SaturationBits => 0,
        dataIn1IWL     => 1,
        dataIn1SGN     => 0,
        dataIn1WL      => 16,
        dataIn2IWL     => 1,
        dataIn2SGN     => 0,
        dataIn2WL      => 16,
        dataOutIWL     => 2,
        dataOutSGN     => 0,
        dataOutWL      => 16)
    port map (
        dataIn1 => D40_dataOut,
        dataIn2 => D41_dataOut,
        dataOut => A32_dataOut);
    
    
    A33 : ABS_Fxp
    generic map (
        Overflow       => 3,
        Quantization   => 5,
        SaturationBits => 0,
        dataInIWL      => 1,
        dataInSGN      => 1,
        dataInWL       => 16,
        dataOutIWL     => 1,
        dataOutSGN     => 0,
        dataOutWL      => 16)
    port map (
        dataIn  => D5_dataOut,
        dataOut => A33_dataOut);
    
    
    A34 : ABS_Fxp
    generic map (
        Overflow       => 3,
        Quantization   => 5,
        SaturationBits => 0,
        dataInIWL      => 1,
        dataInSGN      => 1,
        dataInWL       => 16,
        dataOutIWL     => 1,
        dataOutSGN     => 0,
        dataOutWL      => 16)
    port map (
        dataIn  => D8_dataOut,
        dataOut => A34_dataOut);
    
    
    A35 : ABS_Fxp
    generic map (
        Overflow       => 3,
        Quantization   => 5,
        SaturationBits => 0,
        dataInIWL      => 1,
        dataInSGN      => 1,
        dataInWL       => 16,
        dataOutIWL     => 1,
        dataOutSGN     => 0,
        dataOutWL      => 16)
    port map (
        dataIn  => D19_dataOut,
        dataOut => A35_dataOut);
    
    
    A36 : AddFxp
    generic map (
        Overflow       => 3,
        Quantization   => 5,
        SaturationBits => 0,
        dataIn1IWL     => 1,
        dataIn1SGN     => 0,
        dataIn1WL      => 16,
        dataIn2IWL     => 1,
        dataIn2SGN     => 0,
        dataIn2WL      => 16,
        dataOutIWL     => 2,
        dataOutSGN     => 0,
        dataOutWL      => 16)
    port map (
        dataIn1 => D55_dataOut,
        dataIn2 => D41_dataOut,
        dataOut => A36_dataOut);
    
    
    A37 : AddFxp
    generic map (
        Overflow       => 3,
        Quantization   => 5,
        SaturationBits => 0,
        dataIn1IWL     => 1,
        dataIn1SGN     => 0,
        dataIn1WL      => 16,
        dataIn2IWL     => 1,
        dataIn2SGN     => 0,
        dataIn2WL      => 16,
        dataOutIWL     => 2,
        dataOutSGN     => 0,
        dataOutWL      => 16)
    port map (
        dataIn1 => D51_dataOut,
        dataIn2 => D55_dataOut,
        dataOut => A37_dataOut);
    
    
    A38 : AddFxp
    generic map (
        Overflow       => 3,
        Quantization   => 5,
        SaturationBits => 0,
        dataIn1IWL     => 1,
        dataIn1SGN     => 0,
        dataIn1WL      => 16,
        dataIn2IWL     => 1,
        dataIn2SGN     => 0,
        dataIn2WL      => 16,
        dataOutIWL     => 2,
        dataOutSGN     => 0,
        dataOutWL      => 16)
    port map (
        dataIn1 => D51_dataOut,
        dataIn2 => D52_dataOut,
        dataOut => A38_dataOut);
    
    
    A39 : AddFxp
    generic map (
        Overflow       => 3,
        Quantization   => 5,
        SaturationBits => 0,
        dataIn1IWL     => 2,
        dataIn1SGN     => 0,
        dataIn1WL      => 16,
        dataIn2IWL     => 2,
        dataIn2SGN     => 0,
        dataIn2WL      => 16,
        dataOutIWL     => 3,
        dataOutSGN     => 0,
        dataOutWL      => 16)
    port map (
        dataIn1 => D12_dataOut,
        dataIn2 => D14_dataOut,
        dataOut => A39_dataOut);
    
    
    A4 : ABS_Fxp
    generic map (
        Overflow       => 3,
        Quantization   => 5,
        SaturationBits => 0,
        dataInIWL      => 1,
        dataInSGN      => 1,
        dataInWL       => 16,
        dataOutIWL     => 1,
        dataOutSGN     => 0,
        dataOutWL      => 16)
    port map (
        dataIn  => D31_dataOut,
        dataOut => A4_dataOut);
    
    
    A40 : AddFxp
    generic map (
        Overflow       => 3,
        Quantization   => 5,
        SaturationBits => 0,
        dataIn1IWL     => 2,
        dataIn1SGN     => 0,
        dataIn1WL      => 16,
        dataIn2IWL     => 2,
        dataIn2SGN     => 0,
        dataIn2WL      => 16,
        dataOutIWL     => 3,
        dataOutSGN     => 0,
        dataOutWL      => 16)
    port map (
        dataIn1 => D20_dataOut,
        dataIn2 => D14_dataOut,
        dataOut => A40_dataOut);
    
    
    A41 : AddFxp
    generic map (
        Overflow       => 3,
        Quantization   => 5,
        SaturationBits => 0,
        dataIn1IWL     => 2,
        dataIn1SGN     => 0,
        dataIn1WL      => 16,
        dataIn2IWL     => 2,
        dataIn2SGN     => 0,
        dataIn2WL      => 16,
        dataOutIWL     => 3,
        dataOutSGN     => 0,
        dataOutWL      => 16)
    port map (
        dataIn1 => D21_dataOut,
        dataIn2 => D34_dataOut,
        dataOut => A41_dataOut);
    
    
    A42 : AddFxp
    generic map (
        Overflow       => 3,
        Quantization   => 5,
        SaturationBits => 0,
        dataIn1IWL     => 2,
        dataIn1SGN     => 0,
        dataIn1WL      => 16,
        dataIn2IWL     => 2,
        dataIn2SGN     => 0,
        dataIn2WL      => 16,
        dataOutIWL     => 3,
        dataOutSGN     => 0,
        dataOutWL      => 16)
    port map (
        dataIn1 => D20_dataOut,
        dataIn2 => D27_dataOut,
        dataOut => A42_dataOut);
    
    
    A43 : AddFxp
    generic map (
        Overflow       => 3,
        Quantization   => 5,
        SaturationBits => 0,
        dataIn1IWL     => 2,
        dataIn1SGN     => 0,
        dataIn1WL      => 16,
        dataIn2IWL     => 2,
        dataIn2SGN     => 0,
        dataIn2WL      => 16,
        dataOutIWL     => 3,
        dataOutSGN     => 0,
        dataOutWL      => 16)
    port map (
        dataIn1 => D21_dataOut,
        dataIn2 => D50_dataOut,
        dataOut => A43_dataOut);
    
    
    A44 : AddFxp
    generic map (
        Overflow       => 3,
        Quantization   => 5,
        SaturationBits => 0,
        dataIn1IWL     => 2,
        dataIn1SGN     => 0,
        dataIn1WL      => 16,
        dataIn2IWL     => 2,
        dataIn2SGN     => 0,
        dataIn2WL      => 16,
        dataOutIWL     => 3,
        dataOutSGN     => 0,
        dataOutWL      => 16)
    port map (
        dataIn1 => D37_dataOut,
        dataIn2 => D27_dataOut,
        dataOut => A44_dataOut);
    
    
    A45 : AddFxp
    generic map (
        Overflow       => 3,
        Quantization   => 5,
        SaturationBits => 0,
        dataIn1IWL     => 2,
        dataIn1SGN     => 0,
        dataIn1WL      => 16,
        dataIn2IWL     => 2,
        dataIn2SGN     => 0,
        dataIn2WL      => 16,
        dataOutIWL     => 3,
        dataOutSGN     => 0,
        dataOutWL      => 16)
    port map (
        dataIn1 => D50_dataOut,
        dataIn2 => D38_dataOut,
        dataOut => A45_dataOut);
    
    
    A46 : AddFxp
    generic map (
        Overflow       => 3,
        Quantization   => 5,
        SaturationBits => 0,
        dataIn1IWL     => 2,
        dataIn1SGN     => 0,
        dataIn1WL      => 16,
        dataIn2IWL     => 2,
        dataIn2SGN     => 0,
        dataIn2WL      => 16,
        dataOutIWL     => 3,
        dataOutSGN     => 0,
        dataOutWL      => 16)
    port map (
        dataIn1 => D37_dataOut,
        dataIn2 => D39_dataOut,
        dataOut => A46_dataOut);
    
    
    A47 : AddFxp
    generic map (
        Overflow       => 3,
        Quantization   => 5,
        SaturationBits => 0,
        dataIn1IWL     => 2,
        dataIn1SGN     => 0,
        dataIn1WL      => 16,
        dataIn2IWL     => 2,
        dataIn2SGN     => 0,
        dataIn2WL      => 16,
        dataOutIWL     => 3,
        dataOutSGN     => 0,
        dataOutWL      => 16)
    port map (
        dataIn1 => D48_dataOut,
        dataIn2 => D38_dataOut,
        dataOut => A47_dataOut);
    
    
    A48 : AddFxp
    generic map (
        Overflow       => 3,
        Quantization   => 5,
        SaturationBits => 0,
        dataIn1IWL     => 2,
        dataIn1SGN     => 0,
        dataIn1WL      => 16,
        dataIn2IWL     => 2,
        dataIn2SGN     => 0,
        dataIn2WL      => 16,
        dataOutIWL     => 3,
        dataOutSGN     => 0,
        dataOutWL      => 16)
    port map (
        dataIn1 => D43_dataOut,
        dataIn2 => D39_dataOut,
        dataOut => A48_dataOut);
    
    
    A49 : AddFxp
    generic map (
        Overflow       => 3,
        Quantization   => 5,
        SaturationBits => 0,
        dataIn1IWL     => 2,
        dataIn1SGN     => 0,
        dataIn1WL      => 16,
        dataIn2IWL     => 2,
        dataIn2SGN     => 0,
        dataIn2WL      => 16,
        dataOutIWL     => 3,
        dataOutSGN     => 0,
        dataOutWL      => 16)
    port map (
        dataIn1 => D44_dataOut,
        dataIn2 => D48_dataOut,
        dataOut => A49_dataOut);
    
    
    A5 : ABS_Fxp
    generic map (
        Overflow       => 3,
        Quantization   => 5,
        SaturationBits => 0,
        dataInIWL      => 1,
        dataInSGN      => 1,
        dataInWL       => 16,
        dataOutIWL     => 1,
        dataOutSGN     => 0,
        dataOutWL      => 16)
    port map (
        dataIn  => D32_dataOut,
        dataOut => A5_dataOut);
    
    
    A50 : AddFxp
    generic map (
        Overflow       => 3,
        Quantization   => 5,
        SaturationBits => 0,
        dataIn1IWL     => 2,
        dataIn1SGN     => 0,
        dataIn1WL      => 16,
        dataIn2IWL     => 2,
        dataIn2SGN     => 0,
        dataIn2WL      => 16,
        dataOutIWL     => 3,
        dataOutSGN     => 0,
        dataOutWL      => 16)
    port map (
        dataIn1 => D43_dataOut,
        dataIn2 => D45_dataOut,
        dataOut => A50_dataOut);
    
    
    A51 : AddFxp
    generic map (
        Overflow       => 3,
        Quantization   => 5,
        SaturationBits => 0,
        dataIn1IWL     => 2,
        dataIn1SGN     => 0,
        dataIn1WL      => 16,
        dataIn2IWL     => 2,
        dataIn2SGN     => 0,
        dataIn2WL      => 16,
        dataOutIWL     => 3,
        dataOutSGN     => 0,
        dataOutWL      => 16)
    port map (
        dataIn1 => D44_dataOut,
        dataIn2 => D53_dataOut,
        dataOut => A51_dataOut);
    
    
    A52 : AddFxp
    generic map (
        Overflow       => 3,
        Quantization   => 5,
        SaturationBits => 0,
        dataIn1IWL     => 2,
        dataIn1SGN     => 0,
        dataIn1WL      => 16,
        dataIn2IWL     => 2,
        dataIn2SGN     => 0,
        dataIn2WL      => 16,
        dataOutIWL     => 3,
        dataOutSGN     => 0,
        dataOutWL      => 16)
    port map (
        dataIn1 => D56_dataOut,
        dataIn2 => D45_dataOut,
        dataOut => A52_dataOut);
    
    
    A53 : AddFxp
    generic map (
        Overflow       => 3,
        Quantization   => 5,
        SaturationBits => 0,
        dataIn1IWL     => 2,
        dataIn1SGN     => 0,
        dataIn1WL      => 16,
        dataIn2IWL     => 2,
        dataIn2SGN     => 0,
        dataIn2WL      => 16,
        dataOutIWL     => 3,
        dataOutSGN     => 0,
        dataOutWL      => 16)
    port map (
        dataIn1 => D53_dataOut,
        dataIn2 => D54_dataOut,
        dataOut => A53_dataOut);
    
    
    A54_dataOut <= D75_dataOut and D78_dataOut;
    
    
    
    A55_dataOut <= ena and C17_dataOut;
    
    
    
    A6 : AddFxp
    generic map (
        Overflow       => 3,
        Quantization   => 5,
        SaturationBits => 0,
        dataIn1IWL     => 1,
        dataIn1SGN     => 0,
        dataIn1WL      => 16,
        dataIn2IWL     => 1,
        dataIn2SGN     => 0,
        dataIn2WL      => 16,
        dataOutIWL     => 2,
        dataOutSGN     => 0,
        dataOutWL      => 16)
    port map (
        dataIn1 => D2_dataOut,
        dataIn2 => D9_dataOut,
        dataOut => A6_dataOut);
    
    
    A7 : AddFxp
    generic map (
        Overflow       => 3,
        Quantization   => 5,
        SaturationBits => 0,
        dataIn1IWL     => 1,
        dataIn1SGN     => 0,
        dataIn1WL      => 16,
        dataIn2IWL     => 1,
        dataIn2SGN     => 0,
        dataIn2WL      => 16,
        dataOutIWL     => 2,
        dataOutSGN     => 0,
        dataOutWL      => 16)
    port map (
        dataIn1 => D9_dataOut,
        dataIn2 => D10_dataOut,
        dataOut => A7_dataOut);
    
    
    A8 : AddFxp
    generic map (
        Overflow       => 3,
        Quantization   => 5,
        SaturationBits => 0,
        dataIn1IWL     => 1,
        dataIn1SGN     => 0,
        dataIn1WL      => 16,
        dataIn2IWL     => 1,
        dataIn2SGN     => 0,
        dataIn2WL      => 16,
        dataOutIWL     => 2,
        dataOutSGN     => 0,
        dataOutWL      => 16)
    port map (
        dataIn1 => D10_dataOut,
        dataIn2 => D11_dataOut,
        dataOut => A8_dataOut);
    
    
    A9 : ABS_Fxp
    generic map (
        Overflow       => 3,
        Quantization   => 5,
        SaturationBits => 0,
        dataInIWL      => 1,
        dataInSGN      => 1,
        dataInWL       => 16,
        dataOutIWL     => 1,
        dataOutSGN     => 0,
        dataOutWL      => 16)
    port map (
        dataIn  => D1_dataOut,
        dataOut => A9_dataOut);
    
    
    B1 : BitMergeFxp
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
        dataLS  => C2_dataOut,
        dataMS  => C1_dataOut,
        dataOut => B1_dataOut);
    
    
    B10 : BitMergeFxp
    generic map (
        Overflow            => 3,
        Quantization        => 5,
        SaturationBits      => 0,
        UseInputWordlengths => 0,
        dataLSWL            => 2,
        dataMSWL            => 2,
        dataOutIWL          => 4,
        dataOutSGN          => 0,
        dataOutWL           => 4)
    port map (
        dataLS  => B4_dataOut,
        dataMS  => B3_dataOut,
        dataOut => B10_dataOut);
    
    
    B11 : BitMergeFxp
    generic map (
        Overflow            => 3,
        Quantization        => 5,
        SaturationBits      => 0,
        UseInputWordlengths => 0,
        dataLSWL            => 2,
        dataMSWL            => 2,
        dataOutIWL          => 4,
        dataOutSGN          => 0,
        dataOutWL           => 4)
    port map (
        dataLS  => B6_dataOut,
        dataMS  => B5_dataOut,
        dataOut => B11_dataOut);
    
    
    B12 : BitMergeFxp
    generic map (
        Overflow            => 3,
        Quantization        => 5,
        SaturationBits      => 0,
        UseInputWordlengths => 0,
        dataLSWL            => 2,
        dataMSWL            => 2,
        dataOutIWL          => 4,
        dataOutSGN          => 0,
        dataOutWL           => 4)
    port map (
        dataLS  => B8_dataOut,
        dataMS  => B7_dataOut,
        dataOut => B12_dataOut);
    
    
    B13 : BitMergeFxp
    generic map (
        Overflow            => 3,
        Quantization        => 5,
        SaturationBits      => 0,
        UseInputWordlengths => 0,
        dataLSWL            => 4,
        dataMSWL            => 4,
        dataOutIWL          => 8,
        dataOutSGN          => 0,
        dataOutWL           => 8)
    port map (
        dataLS  => B10_dataOut,
        dataMS  => B9_dataOut,
        dataOut => B13_dataOut);
    
    
    B14 : BitMergeFxp
    generic map (
        Overflow            => 3,
        Quantization        => 5,
        SaturationBits      => 0,
        UseInputWordlengths => 0,
        dataLSWL            => 4,
        dataMSWL            => 4,
        dataOutIWL          => 8,
        dataOutSGN          => 0,
        dataOutWL           => 8)
    port map (
        dataLS  => B12_dataOut,
        dataMS  => B11_dataOut,
        dataOut => B14_dataOut);
    
    
    B15 : BitMergeFxp
    generic map (
        Overflow            => 3,
        Quantization        => 5,
        SaturationBits      => 0,
        UseInputWordlengths => 0,
        dataLSWL            => 8,
        dataMSWL            => 8,
        dataOutIWL          => 16,
        dataOutSGN          => 0,
        dataOutWL           => 16)
    port map (
        dataLS  => B14_dataOut,
        dataMS  => B13_dataOut,
        dataOut => B15_dataOut);
    
    
    B16_dataOut <= "1";
    
    
    
    B17_dataOut <= "1";
    
    
    
    B18_dataOut <= "0";
    
    
    
    B2 : BitMergeFxp
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
        dataLS  => C4_dataOut,
        dataMS  => C3_dataOut,
        dataOut => B2_dataOut);
    
    
    B3 : BitMergeFxp
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
        dataLS  => C6_dataOut,
        dataMS  => C5_dataOut,
        dataOut => B3_dataOut);
    
    
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
        dataLS  => C8_dataOut,
        dataMS  => C7_dataOut,
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
        dataLS  => C10_dataOut,
        dataMS  => C9_dataOut,
        dataOut => B5_dataOut);
    
    
    B6 : BitMergeFxp
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
        dataLS  => C12_dataOut,
        dataMS  => C11_dataOut,
        dataOut => B6_dataOut);
    
    
    B7 : BitMergeFxp
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
        dataLS  => C14_dataOut,
        dataMS  => C13_dataOut,
        dataOut => B7_dataOut);
    
    
    B8 : BitMergeFxp
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
        dataLS  => C16_dataOut,
        dataMS  => C15_dataOut,
        dataOut => B8_dataOut);
    
    
    B9 : BitMergeFxp
    generic map (
        Overflow            => 3,
        Quantization        => 5,
        SaturationBits      => 0,
        UseInputWordlengths => 0,
        dataLSWL            => 2,
        dataMSWL            => 2,
        dataOutIWL          => 4,
        dataOutSGN          => 0,
        dataOutWL           => 4)
    port map (
        dataLS  => B2_dataOut,
        dataMS  => B1_dataOut,
        dataOut => B9_dataOut);
    
    
    C1 : CompareFxp
    generic map (
        CompareOperation => 2,
        dataInAIWL       => 3,
        dataInASGN       => 0,
        dataInAWL        => 16,
        dataInBIWL       => 3,
        dataInBSGN       => 0,
        dataInBWL        => 16,
        dataOutWL        => 1)
    port map (
        dataInA => D57_dataOut,
        dataInB => D73_dataOut,
        dataOut => C1_dataOut(0));
    
    
    C10 : CompareFxp
    generic map (
        CompareOperation => 2,
        dataInAIWL       => 3,
        dataInASGN       => 0,
        dataInAWL        => 16,
        dataInBIWL       => 3,
        dataInBSGN       => 0,
        dataInBWL        => 16,
        dataOutWL        => 1)
    port map (
        dataInA => D66_dataOut,
        dataInB => D73_dataOut,
        dataOut => C10_dataOut(0));
    
    
    C11 : CompareFxp
    generic map (
        CompareOperation => 2,
        dataInAIWL       => 3,
        dataInASGN       => 0,
        dataInAWL        => 16,
        dataInBIWL       => 3,
        dataInBSGN       => 0,
        dataInBWL        => 16,
        dataOutWL        => 1)
    port map (
        dataInA => D67_dataOut,
        dataInB => D73_dataOut,
        dataOut => C11_dataOut(0));
    
    
    C12 : CompareFxp
    generic map (
        CompareOperation => 2,
        dataInAIWL       => 3,
        dataInASGN       => 0,
        dataInAWL        => 16,
        dataInBIWL       => 3,
        dataInBSGN       => 0,
        dataInBWL        => 16,
        dataOutWL        => 1)
    port map (
        dataInA => D68_dataOut,
        dataInB => D73_dataOut,
        dataOut => C12_dataOut(0));
    
    
    C13 : CompareFxp
    generic map (
        CompareOperation => 2,
        dataInAIWL       => 3,
        dataInASGN       => 0,
        dataInAWL        => 16,
        dataInBIWL       => 3,
        dataInBSGN       => 0,
        dataInBWL        => 16,
        dataOutWL        => 1)
    port map (
        dataInA => D69_dataOut,
        dataInB => D73_dataOut,
        dataOut => C13_dataOut(0));
    
    
    C14 : CompareFxp
    generic map (
        CompareOperation => 2,
        dataInAIWL       => 3,
        dataInASGN       => 0,
        dataInAWL        => 16,
        dataInBIWL       => 3,
        dataInBSGN       => 0,
        dataInBWL        => 16,
        dataOutWL        => 1)
    port map (
        dataInA => D70_dataOut,
        dataInB => D73_dataOut,
        dataOut => C14_dataOut(0));
    
    
    C15 : CompareFxp
    generic map (
        CompareOperation => 2,
        dataInAIWL       => 3,
        dataInASGN       => 0,
        dataInAWL        => 16,
        dataInBIWL       => 3,
        dataInBSGN       => 0,
        dataInBWL        => 16,
        dataOutWL        => 1)
    port map (
        dataInA => D71_dataOut,
        dataInB => D73_dataOut,
        dataOut => C15_dataOut(0));
    
    
    C16 : CompareFxp
    generic map (
        CompareOperation => 2,
        dataInAIWL       => 3,
        dataInASGN       => 0,
        dataInAWL        => 16,
        dataInBIWL       => 3,
        dataInBSGN       => 0,
        dataInBWL        => 16,
        dataOutWL        => 1)
    port map (
        dataInA => D72_dataOut,
        dataInB => D73_dataOut,
        dataOut => C16_dataOut(0));
    
    
    C17 : CompareConstFxp
    generic map (
        CompareOperation       => 1,
        ConstIntegerWordlength => 16,
        ConstIsSigned          => 0,
        ConstWordlength        => 16,
        FxpConstant            => 0,
        dataInAIWL             => 16,
        dataInASGN             => 0,
        dataInAWL              => 16,
        dataOutWL              => 1)
    port map (
        dataInA => D74_dataOut,
        dataOut => C17_dataOut(0));
    
    
    C18 : CounterFxp
    generic map (
        Direction      => 0,
        FxpInitValue   => 0,
        Overflow       => 3,
        Quantization   => 5,
        SaturationBits => 0,
        StepFxp        => 1,
        dataOutIWL     => 8,
        dataOutSGN     => 0,
        dataOutWL      => 8)
    port map (
        ce      => ce2,
        clk     => clk,
        dataOut => C18_dataOut,
        enable  => B17_dataOut(0),
        rdy     => open,
        reset   => B18_dataOut(0),
        rst     => rst);
    
    
    C2 : CompareFxp
    generic map (
        CompareOperation => 2,
        dataInAIWL       => 3,
        dataInASGN       => 0,
        dataInAWL        => 16,
        dataInBIWL       => 3,
        dataInBSGN       => 0,
        dataInBWL        => 16,
        dataOutWL        => 1)
    port map (
        dataInA => D58_dataOut,
        dataInB => D73_dataOut,
        dataOut => C2_dataOut(0));
    
    
    C3 : CompareFxp
    generic map (
        CompareOperation => 2,
        dataInAIWL       => 3,
        dataInASGN       => 0,
        dataInAWL        => 16,
        dataInBIWL       => 3,
        dataInBSGN       => 0,
        dataInBWL        => 16,
        dataOutWL        => 1)
    port map (
        dataInA => D59_dataOut,
        dataInB => D73_dataOut,
        dataOut => C3_dataOut(0));
    
    
    C4 : CompareFxp
    generic map (
        CompareOperation => 2,
        dataInAIWL       => 3,
        dataInASGN       => 0,
        dataInAWL        => 16,
        dataInBIWL       => 3,
        dataInBSGN       => 0,
        dataInBWL        => 16,
        dataOutWL        => 1)
    port map (
        dataInA => D60_dataOut,
        dataInB => D73_dataOut,
        dataOut => C4_dataOut(0));
    
    
    C5 : CompareFxp
    generic map (
        CompareOperation => 2,
        dataInAIWL       => 3,
        dataInASGN       => 0,
        dataInAWL        => 16,
        dataInBIWL       => 3,
        dataInBSGN       => 0,
        dataInBWL        => 16,
        dataOutWL        => 1)
    port map (
        dataInA => D61_dataOut,
        dataInB => D73_dataOut,
        dataOut => C5_dataOut(0));
    
    
    C6 : CompareFxp
    generic map (
        CompareOperation => 2,
        dataInAIWL       => 3,
        dataInASGN       => 0,
        dataInAWL        => 16,
        dataInBIWL       => 3,
        dataInBSGN       => 0,
        dataInBWL        => 16,
        dataOutWL        => 1)
    port map (
        dataInA => D62_dataOut,
        dataInB => D73_dataOut,
        dataOut => C6_dataOut(0));
    
    
    C7 : CompareFxp
    generic map (
        CompareOperation => 2,
        dataInAIWL       => 3,
        dataInASGN       => 0,
        dataInAWL        => 16,
        dataInBIWL       => 3,
        dataInBSGN       => 0,
        dataInBWL        => 16,
        dataOutWL        => 1)
    port map (
        dataInA => D63_dataOut,
        dataInB => D73_dataOut,
        dataOut => C7_dataOut(0));
    
    
    C8 : CompareFxp
    generic map (
        CompareOperation => 2,
        dataInAIWL       => 3,
        dataInASGN       => 0,
        dataInAWL        => 16,
        dataInBIWL       => 3,
        dataInBSGN       => 0,
        dataInBWL        => 16,
        dataOutWL        => 1)
    port map (
        dataInA => D64_dataOut,
        dataInB => D73_dataOut,
        dataOut => C8_dataOut(0));
    
    
    C9 : CompareFxp
    generic map (
        CompareOperation => 2,
        dataInAIWL       => 3,
        dataInASGN       => 0,
        dataInAWL        => 16,
        dataInBIWL       => 3,
        dataInBSGN       => 0,
        dataInBWL        => 16,
        dataOutWL        => 1)
    port map (
        dataInA => D65_dataOut,
        dataInB => D73_dataOut,
        dataOut => C9_dataOut(0));
    
    
    D1 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 1,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => D83_dataOut,
        dataOut => D1_dataOut);
    
    
    D10 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 0,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => A4_dataOut,
        dataOut => D10_dataOut);
    
    
    D11 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 0,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => A5_dataOut,
        dataOut => D11_dataOut);
    
    
    D12 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 0,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => A6_dataOut,
        dataOut => D12_dataOut);
    
    
    D13 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 0,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => A7_dataOut,
        dataOut => D13_dataOut);
    
    
    D14 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 0,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => A8_dataOut,
        dataOut => D14_dataOut);
    
    
    D15 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 0,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => A11_dataOut,
        dataOut => D15_dataOut);
    
    
    D16 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 1,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => D79_dataOut,
        dataOut => D16_dataOut);
    
    
    D17 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 1,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => D80_dataOut,
        dataOut => D17_dataOut);
    
    
    D18 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 0,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => A12_dataOut,
        dataOut => D18_dataOut);
    
    
    D19 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 1,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => D31_dataOut,
        dataOut => D19_dataOut);
    
    
    D2 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 0,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => A2_dataOut,
        dataOut => D2_dataOut);
    
    
    D20 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 0,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => A14_dataOut,
        dataOut => D20_dataOut);
    
    
    D21 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 0,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => A15_dataOut,
        dataOut => D21_dataOut);
    
    
    D22 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 1,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => D92_dataOut,
        dataOut => D22_dataOut);
    
    
    D23 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 1,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => D93_dataOut,
        dataOut => D23_dataOut);
    
    
    D24 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 1,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => D94_dataOut,
        dataOut => D24_dataOut);
    
    
    D25 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 1,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => D87_dataOut,
        dataOut => D25_dataOut);
    
    
    D26 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 1,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => D88_dataOut,
        dataOut => D26_dataOut);
    
    
    D27 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 0,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => A16_dataOut,
        dataOut => D27_dataOut);
    
    
    D28 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 1,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => D89_dataOut,
        dataOut => D28_dataOut);
    
    
    D29 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 1,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => D90_dataOut,
        dataOut => D29_dataOut);
    
    
    D3 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 1,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => D84_dataOut,
        dataOut => D3_dataOut);
    
    
    D30 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 0,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => A9_dataOut,
        dataOut => D30_dataOut);
    
    
    D31 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 1,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => D81_dataOut,
        dataOut => D31_dataOut);
    
    
    D32 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 1,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => D82_dataOut,
        dataOut => D32_dataOut);
    
    
    D33 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 0,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => A10_dataOut,
        dataOut => D33_dataOut);
    
    
    D34 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 0,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => A13_dataOut,
        dataOut => D34_dataOut);
    
    
    D35 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 0,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => A19_dataOut,
        dataOut => D35_dataOut);
    
    
    D36 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 0,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => A24_dataOut,
        dataOut => D36_dataOut);
    
    
    D37 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 0,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => A21_dataOut,
        dataOut => D37_dataOut);
    
    
    D38 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 0,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => A22_dataOut,
        dataOut => D38_dataOut);
    
    
    D39 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 0,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => A23_dataOut,
        dataOut => D39_dataOut);
    
    
    D4 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 1,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => D85_dataOut,
        dataOut => D4_dataOut);
    
    
    D40 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 0,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => A27_dataOut,
        dataOut => D40_dataOut);
    
    
    D41 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 0,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => A31_dataOut,
        dataOut => D41_dataOut);
    
    
    D42 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 0,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => A17_dataOut,
        dataOut => D42_dataOut);
    
    
    D43 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 0,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => A29_dataOut,
        dataOut => D43_dataOut);
    
    
    D44 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 0,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => A30_dataOut,
        dataOut => D44_dataOut);
    
    
    D45 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 0,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => A32_dataOut,
        dataOut => D45_dataOut);
    
    
    D46 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 0,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => A25_dataOut,
        dataOut => D46_dataOut);
    
    
    D47 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 0,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => A26_dataOut,
        dataOut => D47_dataOut);
    
    
    D48 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 0,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => A28_dataOut,
        dataOut => D48_dataOut);
    
    
    D49 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 0,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => A18_dataOut,
        dataOut => D49_dataOut);
    
    
    D5 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 1,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => D16_dataOut,
        dataOut => D5_dataOut);
    
    
    D50 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 0,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => A20_dataOut,
        dataOut => D50_dataOut);
    
    
    D51 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 0,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => A34_dataOut,
        dataOut => D51_dataOut);
    
    
    D52 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 0,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => A35_dataOut,
        dataOut => D52_dataOut);
    
    
    D53 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 0,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => A36_dataOut,
        dataOut => D53_dataOut);
    
    
    D54 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 0,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => A38_dataOut,
        dataOut => D54_dataOut);
    
    
    D55 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 0,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => A33_dataOut,
        dataOut => D55_dataOut);
    
    
    D56 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 0,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => A37_dataOut,
        dataOut => D56_dataOut);
    
    
    D57 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 0,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => A39_dataOut,
        dataOut => D57_dataOut);
    
    
    D58 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 0,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => A1_dataOut,
        dataOut => D58_dataOut);
    
    
    D59 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 0,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => A40_dataOut,
        dataOut => D59_dataOut);
    
    
    D6 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 1,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => D86_dataOut,
        dataOut => D6_dataOut);
    
    
    D60 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 0,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => A41_dataOut,
        dataOut => D60_dataOut);
    
    
    D61 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 0,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => A42_dataOut,
        dataOut => D61_dataOut);
    
    
    D62 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 0,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => A43_dataOut,
        dataOut => D62_dataOut);
    
    
    D63 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 0,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => A44_dataOut,
        dataOut => D63_dataOut);
    
    
    D64 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 0,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => A45_dataOut,
        dataOut => D64_dataOut);
    
    
    D65 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 0,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => A46_dataOut,
        dataOut => D65_dataOut);
    
    
    D66 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 0,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => A47_dataOut,
        dataOut => D66_dataOut);
    
    
    D67 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 0,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => A48_dataOut,
        dataOut => D67_dataOut);
    
    
    D68 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 0,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => A49_dataOut,
        dataOut => D68_dataOut);
    
    
    D69 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 0,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => A50_dataOut,
        dataOut => D69_dataOut);
    
    
    D7 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 1,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => D91_dataOut,
        dataOut => D7_dataOut);
    
    
    D70 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 0,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => A51_dataOut,
        dataOut => D70_dataOut);
    
    
    D71 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 0,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => A52_dataOut,
        dataOut => D71_dataOut);
    
    
    D72 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 0,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => A53_dataOut,
        dataOut => D72_dataOut);
    
    
    D73 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 0,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => D95_dataOut,
        dataOut => D73_dataOut);
    
    
    D74 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 0,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => B15_dataOut,
        dataOut => D74_dataOut);
    
    
    D75 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 1,
        dataOutSGN   => 0,
        dataOutWL    => 1)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => N1_dataOut,
        dataOut => D75_dataOut);
    
    
    D76 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 1,
        dataOutSGN   => 0,
        dataOutWL    => 1)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => A54_dataOut,
        dataOut => D76_dataOut);
    
    
    D77 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 1,
        dataOutSGN   => 0,
        dataOutWL    => 1)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => A55_dataOut,
        dataOut => D77_dataOut);
    
    
    D78 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 1,
        dataOutSGN   => 0,
        dataOutWL    => 1)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => L1_dataOut,
        dataOut => D78_dataOut);
    
    
    D79 : DownSampleFxp
    generic map (
        Factor    => 2,
        Phase     => 0,
        dataInWL  => 16,
        dataOutWL => 16)
    port map (
        ce      => ce1,
        clk     => clk,
        dataIn  => In15,
        dataOut => D79_dataOut,
        rst     => rst);
    
    
    D8 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 1,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => D17_dataOut,
        dataOut => D8_dataOut);
    
    
    D80 : DownSampleFxp
    generic map (
        Factor    => 2,
        Phase     => 0,
        dataInWL  => 16,
        dataOutWL => 16)
    port map (
        ce      => ce1,
        clk     => clk,
        dataIn  => In14,
        dataOut => D80_dataOut,
        rst     => rst);
    
    
    D81 : DownSampleFxp
    generic map (
        Factor    => 2,
        Phase     => 0,
        dataInWL  => 16,
        dataOutWL => 16)
    port map (
        ce      => ce1,
        clk     => clk,
        dataIn  => In13,
        dataOut => D81_dataOut,
        rst     => rst);
    
    
    D82 : DownSampleFxp
    generic map (
        Factor    => 2,
        Phase     => 0,
        dataInWL  => 16,
        dataOutWL => 16)
    port map (
        ce      => ce1,
        clk     => clk,
        dataIn  => In12,
        dataOut => D82_dataOut,
        rst     => rst);
    
    
    D83 : DownSampleFxp
    generic map (
        Factor    => 2,
        Phase     => 0,
        dataInWL  => 16,
        dataOutWL => 16)
    port map (
        ce      => ce1,
        clk     => clk,
        dataIn  => In11,
        dataOut => D83_dataOut,
        rst     => rst);
    
    
    D84 : DownSampleFxp
    generic map (
        Factor    => 2,
        Phase     => 0,
        dataInWL  => 16,
        dataOutWL => 16)
    port map (
        ce      => ce1,
        clk     => clk,
        dataIn  => In10,
        dataOut => D84_dataOut,
        rst     => rst);
    
    
    D85 : DownSampleFxp
    generic map (
        Factor    => 2,
        Phase     => 0,
        dataInWL  => 16,
        dataOutWL => 16)
    port map (
        ce      => ce1,
        clk     => clk,
        dataIn  => In9,
        dataOut => D85_dataOut,
        rst     => rst);
    
    
    D86 : DownSampleFxp
    generic map (
        Factor    => 2,
        Phase     => 0,
        dataInWL  => 16,
        dataOutWL => 16)
    port map (
        ce      => ce1,
        clk     => clk,
        dataIn  => In8,
        dataOut => D86_dataOut,
        rst     => rst);
    
    
    D87 : DownSampleFxp
    generic map (
        Factor    => 2,
        Phase     => 0,
        dataInWL  => 16,
        dataOutWL => 16)
    port map (
        ce      => ce1,
        clk     => clk,
        dataIn  => In7,
        dataOut => D87_dataOut,
        rst     => rst);
    
    
    D88 : DownSampleFxp
    generic map (
        Factor    => 2,
        Phase     => 0,
        dataInWL  => 16,
        dataOutWL => 16)
    port map (
        ce      => ce1,
        clk     => clk,
        dataIn  => In6,
        dataOut => D88_dataOut,
        rst     => rst);
    
    
    D89 : DownSampleFxp
    generic map (
        Factor    => 2,
        Phase     => 0,
        dataInWL  => 16,
        dataOutWL => 16)
    port map (
        ce      => ce1,
        clk     => clk,
        dataIn  => In5,
        dataOut => D89_dataOut,
        rst     => rst);
    
    
    D9 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 0,
        dataOutWL    => 16)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => A3_dataOut,
        dataOut => D9_dataOut);
    
    
    D90 : DownSampleFxp
    generic map (
        Factor    => 2,
        Phase     => 0,
        dataInWL  => 16,
        dataOutWL => 16)
    port map (
        ce      => ce1,
        clk     => clk,
        dataIn  => In4,
        dataOut => D90_dataOut,
        rst     => rst);
    
    
    D91 : DownSampleFxp
    generic map (
        Factor    => 2,
        Phase     => 0,
        dataInWL  => 16,
        dataOutWL => 16)
    port map (
        ce      => ce1,
        clk     => clk,
        dataIn  => In3,
        dataOut => D91_dataOut,
        rst     => rst);
    
    
    D92 : DownSampleFxp
    generic map (
        Factor    => 2,
        Phase     => 0,
        dataInWL  => 16,
        dataOutWL => 16)
    port map (
        ce      => ce1,
        clk     => clk,
        dataIn  => In2,
        dataOut => D92_dataOut,
        rst     => rst);
    
    
    D93 : DownSampleFxp
    generic map (
        Factor    => 2,
        Phase     => 0,
        dataInWL  => 16,
        dataOutWL => 16)
    port map (
        ce      => ce1,
        clk     => clk,
        dataIn  => In1,
        dataOut => D93_dataOut,
        rst     => rst);
    
    
    D94 : DownSampleFxp
    generic map (
        Factor    => 2,
        Phase     => 0,
        dataInWL  => 16,
        dataOutWL => 16)
    port map (
        ce      => ce1,
        clk     => clk,
        dataIn  => In0,
        dataOut => D94_dataOut,
        rst     => rst);
    
    
    D95 : DownSampleFxp
    generic map (
        Factor    => 2,
        Phase     => 0,
        dataInWL  => 16,
        dataOutWL => 16)
    port map (
        ce      => ce1,
        clk     => clk,
        dataIn  => threshold,
        dataOut => D95_dataOut,
        rst     => rst);
    
    
    L1 : LatchFxp
    generic map (
        LatchMode => 1,
        dataInWL  => 1,
        dataOutWL => 1)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => B16_dataOut,
        dataOut => L1_dataOut,
        latch   => D77_dataOut(0));
    
    
    L2 : LatchFxp
    generic map (
        LatchMode => 1,
        dataInWL  => 8,
        dataOutWL => 8)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => C18_dataOut,
        dataOut => L2_dataOut,
        latch   => D76_dataOut(0));
    
    
    N1 : NOT_Fxp
    generic map (
        dataInWL  => 1,
        dataOutWL => 1)
    port map (
        dataIn  => D78_dataOut,
        dataOut => N1_dataOut);
    
    
    start_pos <= L2_dataOut;
    trig_out  <= D78_dataOut;

end trig_gen_Subnetwork24_Arch;


