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
-- ConstFxp
--
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-------------------------------------------------------------------------------
-- ConstFxp entity declaration
-------------------------------------------------------------------------------

entity ConstFxp is
    generic (
        FxpValue   : integer;
        dataOutWL  : natural;
        dataOutSGN : natural);
    port (
        dataOut : out std_logic_vector(dataOutWL-1 downto 0));
end ConstFxp;

-------------------------------------------------------------------------------
-- ConstantFxp architecture
-------------------------------------------------------------------------------

architecture ConstFxpArch of ConstFxp is
begin

    with dataOutSGN select
    dataOut <=
    std_logic_vector(to_unsigned(FxpValue, dataOutWL)) when 0,
    std_logic_vector(to_signed(FxpValue, dataOutWL))   when others;

end ConstFxpArch;

