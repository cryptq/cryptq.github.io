-------------------------------------------------------------------------------
-- Automatically generated VHDL code for non-primitive component
-- ADCConvert_16To8_Subnetwork2.vhd
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library work;
use work.p_fxp.all;


entity ADCConvert_16To8_Subnetwork2 is
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
end ADCConvert_16To8_Subnetwork2;


architecture ADCConvert_16To8_Subnetwork2_Arch of ADCConvert_16To8_Subnetwork2 is
    
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
    
    signal D10_dataOut : std_logic_vector(15 downto 0);
    signal D11_dataOut : std_logic_vector(15 downto 0);
    signal D12_dataOut : std_logic_vector(15 downto 0);
    signal D13_dataOut : std_logic_vector(15 downto 0);
    signal D14_dataOut : std_logic_vector(15 downto 0);
    signal D21_dataOut : std_logic_vector(15 downto 0);
    signal D22_dataOut : std_logic_vector(15 downto 0);
    signal D23_dataOut : std_logic_vector(15 downto 0);
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
    signal L1_dataOut  : std_logic_vector(15 downto 0);
    signal L2_dataOut  : std_logic_vector(15 downto 0);
    signal L3_dataOut  : std_logic_vector(15 downto 0);
    signal L4_dataOut  : std_logic_vector(15 downto 0);
    signal L5_dataOut  : std_logic_vector(15 downto 0);
    signal L6_dataOut  : std_logic_vector(15 downto 0);
    signal L7_dataOut  : std_logic_vector(15 downto 0);
    signal L8_dataOut  : std_logic_vector(15 downto 0);
    signal L9_dataOut  : std_logic_vector(15 downto 0);
    signal M2_dataOut  : std_logic_vector(15 downto 0);
    signal M3_dataOut  : std_logic_vector(15 downto 0);
    signal M4_dataOut  : std_logic_vector(15 downto 0);
    signal M5_dataOut  : std_logic_vector(15 downto 0);
    signal M6_dataOut  : std_logic_vector(15 downto 0);
    signal M7_dataOut  : std_logic_vector(15 downto 0);
    signal M8_dataOut  : std_logic_vector(15 downto 0);
    signal M9_dataOut  : std_logic_vector(15 downto 0);

begin
    
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
        dataIn  => M5_dataOut,
        dataOut => D10_dataOut);
    
    
    D11 : DelayFxp
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
        dataIn  => M6_dataOut,
        dataOut => D11_dataOut);
    
    
    D12 : DelayFxp
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
        dataIn  => M7_dataOut,
        dataOut => D12_dataOut);
    
    
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
        dataIn  => M8_dataOut,
        dataOut => D13_dataOut);
    
    
    D14 : DelayFxp
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
        dataIn  => M9_dataOut,
        dataOut => D14_dataOut);
    
    
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
        dataIn  => M2_dataOut,
        dataOut => D21_dataOut);
    
    
    D22 : DelayFxp
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
        dataIn  => M3_dataOut,
        dataOut => D22_dataOut);
    
    
    D23 : DelayFxp
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
        dataIn  => M4_dataOut,
        dataOut => D23_dataOut);
    
    
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
        dataIn  => ADC_Valid,
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
        dataIn  => ADC_Valid,
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
        dataIn  => ADC_Valid,
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
        dataIn  => ADCIn1,
        dataOut => L1_dataOut,
        latch   => D7_dataOut(0));
    
    
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
        dataIn  => ADCIn13,
        dataOut => L10_dataOut,
        latch   => D8_dataOut(0));
    
    
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
        dataIn  => ADCIn6,
        dataOut => L11_dataOut,
        latch   => D7_dataOut(0));
    
    
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
        dataIn  => ADCIn14,
        dataOut => L12_dataOut,
        latch   => D8_dataOut(0));
    
    
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
        dataIn  => ADCIn7,
        dataOut => L13_dataOut,
        latch   => D7_dataOut(0));
    
    
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
        dataIn  => ADCIn15,
        dataOut => L14_dataOut,
        latch   => D8_dataOut(0));
    
    
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
        dataIn  => ADCIn8,
        dataOut => L15_dataOut,
        latch   => D7_dataOut(0));
    
    
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
        dataIn  => ADCIn16,
        dataOut => L16_dataOut,
        latch   => D8_dataOut(0));
    
    
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
        dataIn  => ADCIn9,
        dataOut => L2_dataOut,
        latch   => D8_dataOut(0));
    
    
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
        dataIn  => ADCIn2,
        dataOut => L3_dataOut,
        latch   => D7_dataOut(0));
    
    
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
        dataIn  => ADCIn10,
        dataOut => L4_dataOut,
        latch   => D8_dataOut(0));
    
    
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
        dataIn  => ADCIn3,
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
        dataIn  => ADCIn11,
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
        dataIn  => ADCIn4,
        dataOut => L7_dataOut,
        latch   => D7_dataOut(0));
    
    
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
        dataIn  => ADCIn12,
        dataOut => L8_dataOut,
        latch   => D8_dataOut(0));
    
    
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
        dataIn  => ADCIn5,
        dataOut => L9_dataOut,
        latch   => D7_dataOut(0));
    
    
    with to_integer(unsigned(D9_dataOut)) select
    M2_dataOut <=
        L1_dataOut when 0,
        L2_dataOut when 1,
        (others => '0') when others;
    
    
    
    
    with to_integer(unsigned(D9_dataOut)) select
    M3_dataOut <=
        L3_dataOut when 0,
        L4_dataOut when 1,
        (others => '0') when others;
    
    
    
    
    with to_integer(unsigned(D9_dataOut)) select
    M4_dataOut <=
        L5_dataOut when 0,
        L6_dataOut when 1,
        (others => '0') when others;
    
    
    
    
    with to_integer(unsigned(D9_dataOut)) select
    M5_dataOut <=
        L7_dataOut when 0,
        L8_dataOut when 1,
        (others => '0') when others;
    
    
    
    
    with to_integer(unsigned(D9_dataOut)) select
    M6_dataOut <=
        L9_dataOut when 0,
        L10_dataOut when 1,
        (others => '0') when others;
    
    
    
    
    with to_integer(unsigned(D9_dataOut)) select
    M7_dataOut <=
        L11_dataOut when 0,
        L12_dataOut when 1,
        (others => '0') when others;
    
    
    
    
    with to_integer(unsigned(D9_dataOut)) select
    M8_dataOut <=
        L13_dataOut when 0,
        L14_dataOut when 1,
        (others => '0') when others;
    
    
    
    
    with to_integer(unsigned(D9_dataOut)) select
    M9_dataOut <=
        L15_dataOut when 0,
        L16_dataOut when 1,
        (others => '0') when others;
    
    
    
    
    ADCOut1 <= D21_dataOut;
    ADCOut2 <= D22_dataOut;
    ADCOut3 <= D23_dataOut;
    ADCOut4 <= D10_dataOut;
    ADCOut5 <= D11_dataOut;
    ADCOut6 <= D12_dataOut;
    ADCOut7 <= D13_dataOut;
    ADCOut8 <= D14_dataOut;

end ADCConvert_16To8_Subnetwork2_Arch;


