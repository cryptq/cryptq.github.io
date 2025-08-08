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
-- FxpNot
--			 
--------------------------------------------------------------------------------

library ieee ;
use ieee.std_logic_1164.all;

entity Not_Fxp is
    generic( dataOutWL :    integer := 16;
			 dataInWL :     integer := 16
            );
    port( 
          -- Port: dataIns

          dataIn  : in     std_logic_vector(dataInWL-1 downto 0);

          -- Port: dataOuts

          dataOut : out    std_logic_vector(dataOutWL-1 downto 0) 
        );
end Not_Fxp;
architecture FxpNot_Arch of Not_Fxp is
begin
	dataOut <= not dataIn;
end FxpNot_Arch;




