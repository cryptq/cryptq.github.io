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
-- DownSampleFxp
--
-- Downsamples a signal by a given factor. The sample phase can be selected
-- and the output is registered so always introduces a delay of between
-- one input sample period and one output sample period depending on the phase.
--
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DownSampleFxp is

    generic(
        dataOutWL : integer := 16;
        dataInWL  : integer := 16;
        Factor    : integer := 2;
        Phase     : integer := 1);
    port(
        rst     : in  std_logic;
        clk     : in  std_logic;
        ce      : in  std_logic;
        dataIn  : in  std_logic_vector(dataInWL-1 downto 0);
        dataOut : out std_logic_vector(dataOutWL-1 downto 0)
    );

end DownSampleFxp;

architecture DownSampleFxp_Arch of DownSampleFxp is
    
    signal counter : integer range 0 to Factor-1;

begin

    -- counter to generate control signals
    process (clk)
    begin
        if clk'event and clk = '1' then
            if rst = '1' then
                counter <= 0;
            elsif ce = '1' then
                if counter = Factor-1 then
                    counter <= 0;
                else
                    counter <= counter + 1;
                end if;
            end if;
        end if;
    end process;

    -- register input signal on specified sampling phase
    process (clk)
    begin
        if clk'event and clk = '1' then
            if rst = '1' then
                dataOut <= (others => '0');
            elsif ce = '1' and counter = Phase then
                dataOut <= dataIn;
            end if;
        end if;
    end process;

end DownSampleFxp_Arch;
