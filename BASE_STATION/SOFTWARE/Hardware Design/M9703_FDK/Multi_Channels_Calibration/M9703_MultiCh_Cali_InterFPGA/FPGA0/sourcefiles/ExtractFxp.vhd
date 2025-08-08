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
-- ExtractFXP
--
-- Extracts bits from a bus.
--
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ExtractFxp is

    generic
    (
        dataInWL : integer := 16;
        dataInIWL : integer := 1;

        dataOutWL : integer := 16;
        dataOutIWL : integer := 1;

        MSB : integer := 1;
        LSB : integer := 1
    );

    port
    (
        dataIn  : in  std_logic_vector(dataInWL-1 downto 0);
        dataOut : out std_logic_vector(dataOutWL-1 downto 0)
    );

end ExtractFxp;

architecture ExtractFxpArch of ExtractFxp is

    signal extractBits : std_logic_vector(MSB-LSB downto 0);
    
begin

    extractBits <= dataIn(MSB+(dataInWL-dataInIWL) downto LSB+(dataInWL-dataInIWL));
    dataOut <= std_logic_vector(resize(unsigned(extractBits),dataOutWL));
    
end ExtractFxpArch;

