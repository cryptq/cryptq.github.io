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
-- CompareFxp
--
--------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.p_fxp.all;


entity CompareFxp is
    generic
    (
        dataInAWL        :     natural;
        dataInAIWL       :     integer;
        dataInASGN       :     natural;
        dataInBWL        :     natural;
        dataInBIWL       :     integer;
        dataInBSGN       :     natural;
        dataOutWL        :     natural;
        CompareOperation :     natural
    );
    port(
        dataInA          : in  std_logic_vector(dataInAWL-1 downto 0);
        dataInB          : in  std_logic_vector(dataInBWL-1 downto 0);
        dataOut          : out std_logic
    );
end CompareFxp;

architecture CompareFxp_A of CompareFxp is


    constant dataInAFWL : integer := dataInAWL - dataInAIWL;
    constant dataInBFWL : integer := dataInBWL - dataInBIWL;

    constant internalIWL : integer := max(dataInAIWL, dataInBIWL);
    constant internalFWL : natural := max(dataInAFWL, dataInBFWL);
    constant internalWL  : natural := internalIWL + internalFWL;
    constant internalSGN : boolean := to_boolean(dataInASGN) or to_boolean(dataInBSGN);

    -- dataIns converted to equivalent higher precision to perform summation
    signal InHighPrec1 : std_logic_vector(internalWL-1 downto 0);
    signal InHighPrec2 : std_logic_vector(internalWL-1 downto 0);

begin

    InHighPrec1 <= FxpConvert(dataInA,
                       (dataInAWL, dataInAIWL, to_boolean(dataInASGN)),
                       (internalWL, internalIWL, internalSGN),
                       QZN_TRN, OVF_WRAP, 0);

    InHighPrec2 <= FxpConvert(dataInB,
                       (dataInBWL, dataInBIWL, to_boolean(dataInBSGN)),
                       (internalWL, internalIWL, internalSGN),
                       QZN_TRN, OVF_WRAP, 0);


    process(InHighPrec1, InHighPrec2)
    begin
        if (internalSGN) then
            case CompareOperation is
                when 0         =>
                if (signed(InHighPrec1) = signed(InHighPrec2)) then
                    dataOut        <= '1';
                else
                    dataOut        <= '0';
                end if;
                when 1    =>
                if (signed(InHighPrec1)/=signed(InHighPrec2)) then
                    dataOut        <= '1';
                else
                    dataOut        <= '0';
                end if;
                when 2 =>
                if (signed(InHighPrec1) < signed(InHighPrec2)) then
                    dataOut        <= '1';
                else
                    dataOut        <= '0';
                end if;
                when 3     =>
                if (signed(InHighPrec1) <= signed(InHighPrec2)) then
                    dataOut        <= '1';
                else
                    dataOut        <= '0';
                end if;
                when 4    =>
                if (signed(InHighPrec1) > signed(InHighPrec2)) then
                    dataOut        <= '1';
                else
                    dataOut        <= '0';
                end if;
                when 5         =>
                if (signed(InHighPrec1) >= signed(InHighPrec2)) then
                    dataOut        <= '1';
                else
                    dataOut        <= '0';
                end if;
                when others          => null;
            end case;
        else
            case CompareOperation is
                when 0         =>
                if (unsigned(InHighPrec1) = unsigned(InHighPrec2)) then
                    dataOut          <= '1';
                else
                    dataOut          <= '0';
                end if;
                when 1    =>
                if (unsigned(InHighPrec1)/=unsigned(InHighPrec2)) then
                    dataOut          <= '1';
                else
                    dataOut          <= '0';
                end if;
                when 2 =>
                if (unsigned(InHighPrec1) < unsigned(InHighPrec2)) then
                    dataOut          <= '1';
                else
                    dataOut          <= '0';
                end if;
                when 3     =>
                if (unsigned(InHighPrec1) <= unsigned(InHighPrec2)) then
                    dataOut          <= '1';
                else
                    dataOut          <= '0';
                end if;
                when 4    =>
                if (unsigned(InHighPrec1) > unsigned(InHighPrec2)) then
                    dataOut          <= '1';
                else
                    dataOut          <= '0';
                end if;
                when 5         =>
                if (unsigned(InHighPrec1) >= unsigned(InHighPrec2)) then
                    dataOut          <= '1';
                else
                    dataOut          <= '0';
                end if;
                when others          => null;
            end case;
            end if;
    end process;
end CompareFxp_A;

