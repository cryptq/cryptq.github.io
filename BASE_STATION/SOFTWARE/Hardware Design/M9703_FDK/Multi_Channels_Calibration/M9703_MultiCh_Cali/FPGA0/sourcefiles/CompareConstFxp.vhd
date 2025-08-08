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
-- CompareConstFxp
--
--------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library work;
use work.p_fxp.all;

entity CompareConstFxp is
    generic
	( 
		FxpConstant :	integer;
        dataInAWL  	:	natural;
        dataInAIWL  	:	natural;
        dataInASGN 	:	natural;
        dataOutWL 	:	natural;
        ConstWordLength  	:	natural;
        ConstIntegerWordLength	:	natural;
        ConstIsSigned 	:	natural;
		CompareOperation	:	integer
    );
    port( 
          -- Port: dataInAs

          dataInA : in     std_logic_vector(dataInAWL-1 downto 0);

          -- Port: dataOuts

          dataOut  : out    std_logic

        );
end CompareConstFxp;

architecture CompareConstFxp_A of CompareConstFxp is

	signal ConstantValue : std_logic_vector(ConstWordLength  -1 downto 0);
    
    constant dataInAFWL : integer := dataInAWL - dataInAIWL;
    constant constFWL : integer := ConstWordLength - ConstIntegerWordLength;

    constant internalIWL : integer := max(dataInAIWL, ConstIntegerWordLength)+1;
    constant internalFWL : natural := max(dataInAFWL, constFWL);
    constant internalWL  : natural := internalIWL + internalFWL;
    constant internalSGN : boolean := to_boolean(dataInASGN) or to_boolean(ConstIsSigned);

    -- dataInAs converted to equivalent higher precision to perform summation
    signal InHighPrec : std_logic_vector(internalWL-1 downto 0);
    signal ConstHighPrec : std_logic_vector(internalWL-1 downto 0);

begin
	
	with ConstIsSigned select
    ConstantValue <=
    std_logic_vector(to_unsigned(FxpConstant, ConstWordLength)) when 0,
    std_logic_vector(to_signed(FxpConstant, ConstWordLength))   when others;
	
	
    InHighPrec <= FxpConvert(dataInA,
                       (dataInAWL, dataInAIWL, to_boolean(dataInASGN)),
                       (internalWL, internalIWL, internalSGN),
                       QZN_TRN, OVF_WRAP, 0);

    ConstHighPrec <= FxpConvert(ConstantValue,
                       (ConstWordLength, ConstIntegerWordLength, to_boolean(ConstIsSigned)),
                       (internalWL, internalIWL, internalSGN),
                       QZN_TRN, OVF_WRAP, 0);
                       

    process(InHighPrec, ConstHighPrec)
    begin
        if (internalSGN) then
            case CompareOperation is
                when 0         =>
                if (signed(InHighPrec) = signed(ConstHighPrec)) then
                    dataOut        <= '1';
                else
                    dataOut        <= '0';
                end if;
                when 1    =>
                if (signed(InHighPrec)/=signed(ConstHighPrec)) then
                    dataOut        <= '1';
                else
                    dataOut        <= '0';
                end if;
                when 2 =>
                if (signed(InHighPrec) < signed(ConstHighPrec)) then
                    dataOut        <= '1';
                else
                    dataOut        <= '0';
                end if;
                when 3     =>
                if (signed(InHighPrec) <= signed(ConstHighPrec)) then
                    dataOut        <= '1';
                else
                    dataOut        <= '0';
                end if;
                when 4    =>
                if (signed(InHighPrec) > signed(ConstHighPrec)) then
                    dataOut        <= '1';
                else
                    dataOut        <= '0';
                end if;
                when 5         =>
                if (signed(InHighPrec) >= signed(ConstHighPrec)) then
                    dataOut        <= '1';
                else
                    dataOut        <= '0';
                end if;
                when others          => null;  
            end case;
        else
            case CompareOperation is
                when 0         =>
                if (unsigned(InHighPrec) = unsigned(ConstHighPrec)) then
                    dataOut          <= '1';
                else
                    dataOut          <= '0';
                end if;
                when 1    =>
                if (unsigned(InHighPrec)/=unsigned(ConstHighPrec)) then
                    dataOut          <= '1';
                else
                    dataOut          <= '0';
                end if;
                when 2 =>
                if (unsigned(InHighPrec) < unsigned(ConstHighPrec)) then
                    dataOut          <= '1';
                else
                    dataOut          <= '0';
                end if;
                when 3     =>
                if (unsigned(InHighPrec) <= unsigned(ConstHighPrec)) then
                    dataOut          <= '1';
                else
                    dataOut          <= '0';
                end if;
                when 4    =>
                if (unsigned(InHighPrec) > unsigned(ConstHighPrec)) then
                    dataOut          <= '1';
                else
                    dataOut          <= '0';
                end if;
                when 5         =>
                if (unsigned(InHighPrec) >= unsigned(ConstHighPrec)) then
                    dataOut          <= '1';
                else
                    dataOut          <= '0';
                end if;
                when others          => null;  
            end case;
        end if;
		
	end process;
end CompareConstFxp_A;