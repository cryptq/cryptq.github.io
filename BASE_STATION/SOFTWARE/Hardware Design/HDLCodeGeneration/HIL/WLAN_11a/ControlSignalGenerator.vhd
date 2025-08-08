----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/04/2015 11:54:48 AM
-- Design Name: 
-- Module Name: Control_Signal_Generator - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Control_Signal_Generator is
    port ( 
			ce : in STD_LOGIC;  
			signal_no_ce : in std_logic;
			rst : in STD_LOGIC;  
			signal_with_ce : out STD_LOGIC;			
			a_resetn : out STD_LOGIC);			
end Control_Signal_Generator;

architecture Behavioral of Control_Signal_Generator is

begin

signal_with_ce <= signal_no_ce and ce;
a_resetn <= not rst;

end Behavioral;
