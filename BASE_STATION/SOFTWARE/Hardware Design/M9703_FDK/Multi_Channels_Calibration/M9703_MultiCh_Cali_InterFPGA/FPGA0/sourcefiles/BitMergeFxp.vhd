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

-------------------------------------------------------------------------------
--
-- BitMergeFxp
--
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.p_fxp.all;

-------------------------------------------------------------------------------
-- Bitwise Merge entity declaration 
-------------------------------------------------------------------------------

entity BitMergeFxp is

    generic
    (
        dataLSWL  : natural;
        dataMSWL  : natural;
		dataOutWL  : natural;
        dataOutIWL : integer;
        dataOutSGN : natural;

        Overflow       : natural;
        Quantization   : natural;
        SaturationBits : integer;
        
        UseInputWordlengths : natural 
    );
    
    port
    (
        dataLS       : in  std_logic_vector(dataLSWL-1 downto 0);
        dataMS       : in  std_logic_vector(dataMSWL-1 downto 0);
        dataOut    	 : out std_logic_vector(dataOutWL-1 downto 0)
    );
    
end BitMergeFxp;

-------------------------------------------------------------------------------
-- Bitwise Merge architecture
-------------------------------------------------------------------------------

architecture FxpBitMerge_Arch of BitMergeFxp is

	constant ConcatWL : integer := dataLSWL + dataMSWL;
    signal Concat : std_logic_vector(ConcatWL-1 downto 0);

begin

	Concat <= dataMS&dataLS;

    
    use_input_WL : if (UseInputWordlengths = 0) generate
        dataOut <= Concat;
    end generate;
    
    use_defined_WL : if (UseInputWordlengths = 1) generate
    	dataOut <= FxpConvert(Concat,
                             (ConcatWL, ConcatWL, false),
                             (dataOutWL, dataOutIWL, to_boolean(dataOutSGN)),
                             ToFxpQznModeT(Quantization), ToFxpOvfModeT(Overflow), SaturationBits);
	end generate;
    
end FxpBitMerge_Arch;





