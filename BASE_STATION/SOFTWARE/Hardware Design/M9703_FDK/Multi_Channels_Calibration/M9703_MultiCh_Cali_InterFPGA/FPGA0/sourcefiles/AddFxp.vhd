-------------------------------------------------------------------------------
--
-- FXPLib - VHDL source
--
-- Copyright (C) 2008-2015 Steepest Ascent Ltd.
-- www.steepestascent.com
--
-- This source code is provided on an "as-is",
-- unsupported basis. You may include this source
-- code in your project providing this copyright
-- message is included, unaltered.
--
-------------------------------------------------------------------------------

--------------------------------------------------------------------------------
--
-- AddFxp
--
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.p_fxp.all;

-------------------------------------------------------------------------------
-- AddFxp entity declaration
-------------------------------------------------------------------------------

entity AddFxp is

    generic
    (
        dataIn1WL  : natural;
        dataIn1IWL : integer;
        dataIn1SGN : natural;

        dataIn2WL  : natural;
        dataIn2IWL : integer;
        dataIn2SGN : natural;

        dataOutWL  : natural;
        dataOutIWL : integer;
        dataOutSGN : natural;

        Overflow       : natural;
        Quantization   : natural;
        SaturationBits : integer
    );

    port
    (
        dataIn1 : in  std_logic_vector(dataIn1WL-1 downto 0);
        dataIn2 : in  std_logic_vector(dataIn2WL-1 downto 0);
        dataOut : out std_logic_vector(dataOutWL-1 downto 0)
    );

end AddFxp;

-------------------------------------------------------------------------------
-- AddFxp architecture
-------------------------------------------------------------------------------

architecture AddFxpArch of AddFxp is

    constant dataIn1FWL : integer := dataIn1WL - dataIn1IWL;
    constant dataIn2FWL : integer := dataIn2WL - dataIn2IWL;

    constant SumIWL : integer := max(dataIn1IWL, dataIn2IWL)+2;
    constant SumFWL : natural := max(dataIn1FWL, dataIn2FWL);
    constant SumWL  : natural := SumIWL + SumFWL;
    constant SumSGN : boolean := to_boolean(dataIn1SGN) or to_boolean(dataIn2SGN);

    -- dataIns converted to equivalent higher precision to perform summation
    signal InHighPrec1 : std_logic_vector(SumWL-1 downto 0);
    signal InHighPrec2 : std_logic_vector(SumWL-1 downto 0);

    -- high precition dataOut, prior to final dataOut conversion
    signal Sum  : std_logic_vector(SumWL-1 downto 0);

begin

    InHighPrec1 <= FxpConvert(dataIn1,
                       (dataIn1WL, dataIn1IWL, to_boolean(dataIn1SGN)),
                       (SumWL, SumIWL, SumSGN),
                       QZN_TRN, OVF_WRAP, 0);

    InHighPrec2 <= FxpConvert(dataIn2,
                       (dataIn2WL, dataIn2IWL, to_boolean(dataIn2SGN)),
                       (SumWL, SumIWL, SumSGN),
                       QZN_TRN, OVF_WRAP, 0);

    -- perform unsigned addition
    Sum <= std_logic_vector( unsigned(InHighPrec1) + unsigned(InHighPrec2) );

    -- convert to desired dataOut type
    dataOut <= FxpConvert(Sum,
                         (SumWL, SumIWL, SumSGN),
                         (dataOutWL, dataOutIWL, to_boolean(dataOutSGN)),
                         ToFxpQznModeT(Quantization), ToFxpOvfModeT(Overflow), SaturationBits);

    --    dataOut <= std_logic_vector(resize(unsigned(Sum),dataOut_WL));

end AddFxpArch;

