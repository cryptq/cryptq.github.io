
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity DualDownResample is
port (
    ap_clk : IN STD_LOGIC;
    ap_rst : IN STD_LOGIC;
    
    input_V : IN STD_LOGIC_VECTOR (35 downto 0);
    input_V_ap_vld : IN STD_LOGIC;
    output_real_V_address0 : OUT STD_LOGIC_VECTOR (0 downto 0);
    output_real_V_ce0 : OUT STD_LOGIC;
    output_real_V_we0 : OUT STD_LOGIC;
    output_real_V_d0 : OUT STD_LOGIC_VECTOR (17 downto 0);
    output_imag_V_address0 : OUT STD_LOGIC_VECTOR (0 downto 0);
    output_imag_V_ce0 : OUT STD_LOGIC;
    output_imag_V_we0 : OUT STD_LOGIC;
    output_imag_V_d0 : OUT STD_LOGIC_VECTOR (17 downto 0);
    
    input_V_2 : IN STD_LOGIC_VECTOR (35 downto 0);
    input_V_ap_vld_2 : IN STD_LOGIC;
    output_real_V_address0_2 : OUT STD_LOGIC_VECTOR (0 downto 0);
    output_real_V_ce0_2 : OUT STD_LOGIC;
    output_real_V_we0_2 : OUT STD_LOGIC;
    output_real_V_d0_2 : OUT STD_LOGIC_VECTOR (17 downto 0);
    output_imag_V_address0_2 : OUT STD_LOGIC_VECTOR (0 downto 0);
    output_imag_V_ce0_2 : OUT STD_LOGIC;
    output_imag_V_we0_2 : OUT STD_LOGIC;
    output_imag_V_d0_2 : OUT STD_LOGIC_VECTOR (17 downto 0);
    
    DDC_freq_norm_0_V : IN STD_LOGIC_VECTOR (31 downto 0);
    DDC_freq_norm_1_V : IN STD_LOGIC_VECTOR (31 downto 0);
    FreqOffsetIn_V : IN STD_LOGIC_VECTOR (24 downto 0) );
end;


architecture behav of DualDownResample is 

    component DownResample IS
    port (
        ap_clk : IN STD_LOGIC;
    ap_rst : IN STD_LOGIC;
    input_V : IN STD_LOGIC_VECTOR (35 downto 0);
    input_V_ap_vld : IN STD_LOGIC;
    output_real_V_address0 : OUT STD_LOGIC_VECTOR (0 downto 0);
    output_real_V_ce0 : OUT STD_LOGIC;
    output_real_V_we0 : OUT STD_LOGIC;
    output_real_V_d0 : OUT STD_LOGIC_VECTOR (17 downto 0);
    output_imag_V_address0 : OUT STD_LOGIC_VECTOR (0 downto 0);
    output_imag_V_ce0 : OUT STD_LOGIC;
    output_imag_V_we0 : OUT STD_LOGIC;
    output_imag_V_d0 : OUT STD_LOGIC_VECTOR (17 downto 0);
    DDC_freq_norm_0_V : IN STD_LOGIC_VECTOR (31 downto 0);
    DDC_freq_norm_1_V : IN STD_LOGIC_VECTOR (31 downto 0);
    FreqOffsetIn_V : IN STD_LOGIC_VECTOR (24 downto 0) );
    end component;


begin
    
    Inst_DownResample_1 : component DownResample
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst,
        
        input_V => input_V,
        input_V_ap_vld => input_V_ap_vld,
        output_real_V_address0 => output_real_V_address0,
        output_real_V_ce0 => output_real_V_ce0,
        output_real_V_we0 => output_real_V_we0,
        output_real_V_d0 => output_real_V_d0,
        output_imag_V_address0 => output_imag_V_address0,
        output_imag_V_ce0 => output_imag_V_ce0,
        output_imag_V_we0 => output_imag_V_we0,
        output_imag_V_d0 => output_imag_V_d0,
        
        DDC_freq_norm_0_V => DDC_freq_norm_0_V,
        DDC_freq_norm_1_V => DDC_freq_norm_1_V,
        FreqOffsetIn_V => FreqOffsetIn_V);
        
    Inst_DownResample_2 : component DownResample
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst,
        
        input_V => input_V_2,
        input_V_ap_vld => input_V_ap_vld_2,
        output_real_V_address0 => output_real_V_address0_2,
        output_real_V_ce0 => output_real_V_ce0_2,
        output_real_V_we0 => output_real_V_we0_2,
        output_real_V_d0 => output_real_V_d0_2,
        output_imag_V_address0 => output_imag_V_address0_2,
        output_imag_V_ce0 => output_imag_V_ce0_2,
        output_imag_V_we0 => output_imag_V_we0_2,
        output_imag_V_d0 => output_imag_V_d0_2,
        
        DDC_freq_norm_0_V => DDC_freq_norm_0_V,
        DDC_freq_norm_1_V => DDC_freq_norm_1_V,
        FreqOffsetIn_V => FreqOffsetIn_V);
        
end behav;
