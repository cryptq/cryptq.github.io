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
-- LatchFxp
--
--------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity LatchFxp is

    generic(dataInWL  : integer := 16;
            dataOutWL : integer := 16;
            LatchMode : integer := 0
    );

    port(CLK : in std_logic;
         RST : in std_logic;

         -- Port: dataIns
         CE     : in std_logic;
         Latch  : in std_logic;
         dataIn : in std_logic_vector(dataInWL-1 downto 0);

         -- Port: dataOuts
         dataOut : out std_logic_vector(dataOutWL-1 downto 0);
         RDY     : out std_logic
    );

end LatchFxp;

architecture LatchFxp_Arch of LatchFxp is

begin

    RDY <= CE;

    process(CLK)
        variable latchReg : std_logic;
    begin
        if CLK'event and CLK = '1' then
            if RST = '1' then
                dataOut  <= (others => '0');
                latchReg := '0';
            elsif CE = '1' then
                if (LatchMode = 0) then
                    -- positive edge
                    -- latch when Latch has changed from 0 to 1
                    if Latch = '1' and latchReg = '0' then
                        dataOut <= dataIn;
                    end if;
                    latchReg := Latch;
                else
                    -- latch on high
                    if Latch = '1' then
                        dataOut <= dataIn;
                    end if;
                end if;                
            end if;
        end if;
    end process;


end LatchFxp_Arch;
