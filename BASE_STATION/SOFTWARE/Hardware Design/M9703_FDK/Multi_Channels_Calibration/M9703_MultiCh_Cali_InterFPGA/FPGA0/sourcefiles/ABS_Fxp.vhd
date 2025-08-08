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
-- ABS_Fxp
--
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.p_fxp.all;

-------------------------------------------------------------------------------
-- ABS_Fxp entity declaration
-------------------------------------------------------------------------------

entity ABS_Fxp is

    generic
    (
        dataInWL  : natural;
        dataInIWL : integer;
        dataInSGN : natural;

        dataOutWL  : natural;
        dataOutIWL : integer;
        dataOutSGN : natural;

        Overflow       : natural;
        Quantization   : natural;
        SaturationBits : integer
    );

    port
    (
        dataIn  : in  std_logic_vector(dataInWL-1 downto 0);
        dataOut : out std_logic_vector(dataOutWL-1 downto 0)
    );

end ABS_Fxp;

-------------------------------------------------------------------------------
-- ABS_Fxp architecture
-------------------------------------------------------------------------------

architecture ABS_Fxp_Arch of ABS_Fxp is

begin

    process (dataIn)

        variable dataInExt : std_logic_vector(dataIn'length downto 0);

    begin

        if to_boolean(dataInSGN) then

            -- input data is signed so sign extend by one bit, negate if necessary,
            -- then cast to output type

            if dataIn(dataInWL-1) = '1' then
                -- value is negative so negate it
                dataInExt := std_logic_vector(-resize(signed(dataIn), dataInExt'length));
            else
                dataInExt := std_logic_vector(resize(signed(dataIn), dataInExt'length));
            end if;

            -- now convert extended value to output type
            dataOut <= FxpConvert(dataInExt,
                                  (dataInWL + 1, dataInIWL + 1, true),
                                  (dataOutWL, dataOutIWL, to_boolean(dataOutSGN)),
                                  ToFxpQznModeT(Quantization), ToFxpOvfModeT(Overflow), SaturationBits);

        else

            -- input data is unsigned so simply convert to output type
            dataOut <= FxpConvert(dataIn,
                                  (dataInWL, dataInIWL, false),
                                  (dataOutWL, dataOutIWL, to_boolean(dataOutSGN)),
                                  ToFxpQznModeT(Quantization), ToFxpOvfModeT(Overflow), SaturationBits);

        end if;

    end process;

end ABS_Fxp_Arch;


