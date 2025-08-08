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
-- FxpUpSample
--
-- Description: Upsamples a signal by either inserting zeros, or holding
-- the previous input sample.
--
-- Factor - specifies the upsampling factor.
--
-- ClockDivFactor - specifies the decimation factor of the input relative
-- to the clock rate (i.e. there are ClockDivFactor clock cycles between
-- each dataOut sample).
--
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UpSampleFxp is

    generic(
        dataOutWL      : integer := 16;
        dataInWL       : integer := 16;
        Factor         : integer := 2;
        ClockDivFactor : integer := 4;
        Phase          : integer := 4;
        Mode           : integer := 0   -- 0 for insert zeros, 1 for hold
    );

    port(
        rst     : in  std_logic;
        clk     : in  std_logic;
        ceA     : in  std_logic;
        dataIn  : in  std_logic_vector(dataInWL-1 downto 0);
        ceB     : in  std_logic;
        dataOut : out std_logic_vector(dataOutWL-1 downto 0)
    );

end entity;

architecture FxpUpSample_Arch of UpSampleFxp is

    signal dataReg : std_logic_vector(dataOutWL-1 downto 0);

    signal phaseCount : integer range 0 to Factor-1;
    signal phaseEn    : std_logic;

begin

    -- generate the phase count
    phaseCounter : process(clk)
    begin
        if clk'event and clk = '1' then
            if rst = '1' then
                phaseCount <= 0;
            elsif ceB = '1' then
                if phaseCount = Factor-1 then
                    phaseCount <= 0;
                else
                    phaseCount <= phaseCount + 1;
                end if;
            end if;
        end if;
    end process;

    -- register the input for later use
    inputRegister : process(clk)
    begin
        if clk'event and clk = '1' then
            if rst = '1' then
                dataReg <= (others => '0');
            elsif ceA = '1' then
                dataReg <= dataIn;
            end if;
        end if;
    end process;

    phaseEn <= '1' when (phaseCount = phase) else '0';

    ----------------------------------------------------------------------------
    -- zero fill mode
    ----------------------------------------------------------------------------

    zero_fill : if Mode = 0 generate

        zero_fill_phase0 : if Phase = 0 generate
            dataOut <= dataIn when phaseEn = '1' else (others => '0');
        end generate;

        zero_fill_other : if Phase > 0 generate
            dataOut <= dataReg when phaseEn = '1' else (others => '0');
        end generate;
        
    end generate;

    ----------------------------------------------------------------------------
    -- repeat fill mode
    ----------------------------------------------------------------------------

    repeat_fill : if Mode = 1 generate

        repeat_fill_factor1 : if Factor = 1 generate
            dataOut <= dataIn;
        end generate;

        repeat_fill_other : if Factor > 1 generate
            dataOut <= dataIn when phaseCount = 0 else dataReg;
        end generate;
        
    end generate;

end architecture;



