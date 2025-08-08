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
-- DelayFxp
--
-- Description: Implements a sample delay.
-- The delay is implemented by a shift register which cannot be set or reset.
-- Zeros are multiplexed onto the dataOut signal until the first
-- samples appear at the dataOut. This allows the delay itself to be implemented
-- using shift register on some FPGAs since the shift register does not require
-- a reset.
--
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DelayFxp is
    generic(
        Delay        : integer;
        FxpInitValue : integer := 0;
        dataInWL     : natural;
        dataOutWL    : natural;
        dataOutSGN   : natural := 0
    );

    port(
        RST     : in  std_logic;
        CLK     : in  std_logic;
        CE      : in  std_logic;
        dataIn  : in  std_logic_vector(dataInWL-1 downto 0);  -- dataIn
        RDY     : out std_logic;
        dataOut : out std_logic_vector(dataOutWL-1 downto 0)  -- dataOut
    );
end DelayFxp;

-------------------------------------------------------------------------------
-- architecture
-------------------------------------------------------------------------------

architecture DelayFxp_Arch of DelayFxp is

    -- calculate length of shift register
    -- required to ensure that the shift register range is valid
    function shiftRegLength (Delay : integer) return integer is
    begin
        if Delay <= 1 then
            return 1;
        else
            return Delay-1;
        end if;
    end function;

    -- delay line
    type   shiftReg_T is array (natural range <>) of std_logic_vector(dataIn'range);
    signal shiftReg : shiftReg_T(shiftRegLength(Delay)-1 downto 0);

    signal counter       : integer range 0 to shiftReg'length;
    signal counterEn     : std_logic;
    signal initialOutput : std_logic_vector(dataIn'range);

begin

    initialOutput <= std_logic_vector(to_unsigned(FxpInitValue, dataOutWL)) when dataOutSGN = 0
    else std_logic_vector(to_signed(FxpInitValue, dataOutWL));

    RDY <= CE;

    -- no delay, just pass input straight to output    
    no_delay : if (Delay = 0) generate
        dataOut <= dataIn;
    end generate;

    -- delay of one sample, implemented by a single register stage with reset
    one_delay : if (Delay = 1) generate

        process (clk)
        begin
            if clk'event and clk = '1' then
                if rst = '1' then
                    dataOut <= initialOutput;
                elsif ce = '1' then
                    dataOut <= dataIn;
                end if;
            end if;
        end process;

    end generate;

    -- more than one delay ...
    -- In this case only the last register stage has reset logic. Since the
    -- other stages don't have reset logic this can significantly reduce
    -- resource utilization on some technologies.
    -- A counter is used to hold the output stage in reset until
    -- the input propogates to the shift register output. 
    more_than_one_delay : if (Delay > 1) generate

        -- shift register stages, without reset 
        process (clk)
        begin
            if clk'event and clk = '1' then
                if ce = '1' then
                    shiftReg(0) <= dataIn;
                    if (shiftReg'length >= 2) then
                        shiftReg(shiftReg'left downto 1) <= shiftReg(shiftReg'left-1 downto 0);
                    end if;
                end if;
            end if;
        end process;

        -- counter to control output stage reset
        process (clk)
        begin
            if clk'event and clk = '1' then
                if rst = '1' then
                    counterEn <= '1';
                    counter   <= 0;
                elsif ce = '1' and counterEn = '1' then
                    if counter = Delay-2 then
                        counterEn <= '0';
                    else
                        counter <= counter + 1;
                    end if;
                end if;
            end if;
        end process;

        -- output stage, with reset based on counter
        process (clk)
        begin
            if clk'event and clk = '1' then
                if rst = '1' then
                    dataOut <= initialOutput;
                elsif ce = '1' and counterEn = '0' then
                    dataOut <= shiftReg(shiftReg'left);
                end if;
            end if;
        end process;

    end generate;

end DelayFxp_Arch;


