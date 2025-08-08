LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_arith.ALL;



ENTITY MapperVHDLTop IS
  PORT(
    dataIn : IN STD_LOGIC_VECTOR (5 DOWNTO 0);
    realOut : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
    imagOut : OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
  );
END MapperVHDLTop;


architecture top of MapperVHDLTop is 

component MapperVerilog is 
  PORT(
    dataIn : IN STD_LOGIC_VECTOR (5 DOWNTO 0);
    realOut : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
    imagOut : OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
  );
  END component;

begin
  
  U1: MapperVerilog port map(dataIn, realOut, imagOut);
end top;
