-------------------------------------------------------------------------------
--
-- FXPLib - VHDL source
--
-- Copyright (C) 2008-2014 Steepest Ascent Ltd.
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
-- CounterFxp
--
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.p_fxp.all;

entity CounterFxp is

    generic(
        dataOutWL  : natural;
        dataOutIWL : integer;
        dataOutSGN : natural;

        Overflow       : natural;
        Quantization   : natural;
        SaturationBits : integer;

        FxpInitValue : integer := 16;
        StepFxp      : integer := 2;
        Direction    : integer := 0
    );
    port(
        -- Port: Inputs
        rst    : in std_logic;
        clk    : in std_logic;
        ce     : in std_logic;
        ENABLE : in std_logic;
        RESET  : in std_logic;

        -- Port: Outputs
        RDY     : out std_logic;
        dataOut : out std_logic_vector(dataOutWL-1 downto 0)
    );

end CounterFxp;

architecture CounterFxp_Arch of CounterFxp is

    signal countExt      : std_logic_vector (dataOutWL downto 0);
    signal count         : std_logic_vector (dataOutWL-1 downto 0);
    constant internalSGN : boolean := (dataOutSGN = 0 and Direction = 1) or dataOutSGN = 1;

begin

    count <= FxpConvert(countExt,
                        (dataOutWL+1, dataOutIWL+1, internalSGN),
                        (dataOutWL, dataOutIWL, to_boolean(dataOutSGN)),
                        ToFxpQznModeT(Quantization), ToFxpOvfModeT(Overflow), SaturationBits);

    process (CLK)
    begin
        if CLK'event and clk = '1' then
            if rst = '1' then
                if dataOutSGN = 1 then
                    countExt <= std_logic_vector(to_signed(FxpInitValue, (dataOutWL+1)));
                else
                    countExt <= std_logic_vector(to_unsigned(FxpInitValue, (dataOutWL+1)));
                end if;
            else
                if CE = '1' then
                    if RESET = '1'then
                        if dataOutSGN = 1 then
                            countExt <= std_logic_vector(to_signed(FxpInitValue, (dataOutWL+1)));
                        else
                            countExt <= std_logic_vector(to_unsigned(FxpInitValue, (dataOutWL+1)));
                        end if;
                    elsif ENABLE = '1' then
                        if Direction = 0 then
                            if dataOutSGN = 1 then
                                countExt <= std_logic_vector(signed(count) + to_signed(StepFxp, dataOutWL+1));
                            else
                                countExt <= std_logic_vector(unsigned(count) + to_unsigned(StepFxp, dataOutWL+1));
                            end if;
                        else
                            if dataOutSGN = 1 then
                                countExt <= std_logic_vector(signed(count) - to_signed(StepFxp, dataOutWL+1));
                            else
                                countExt <= std_logic_vector(unsigned(count) - to_unsigned(StepFxp, dataOutWL+1));
                            end if;
                        end if;
                    end if;
                end if;
            end if;
        end if;
    end process;

    dataOut <= count;
    rdy     <= CE;
    

end CounterFxp_Arch;
