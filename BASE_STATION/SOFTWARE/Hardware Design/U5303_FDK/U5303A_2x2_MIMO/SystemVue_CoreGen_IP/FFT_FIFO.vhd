--------------------------------------------------------------------------------
-- Copyright (c) 1995-2012 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor: Xilinx
-- \   \   \/     Version: P.49d
--  \   \         Application: netgen
--  /   /         Filename: xfft_v8_0.vhd
-- /___/   /\     Timestamp: Thu Dec 18 19:31:12 2014
-- \   \  /  \ 
--  \___\/\___\
--             
-- Command	: -w -sim -ofmt vhdl C:/Ben/EEsof/FPGA/MPO/M9703/apps/MIMO_OFDM_11ac/SystemVue_CoreGen_IP/tmp/_cg/xfft_v8_0.ngc C:/Ben/EEsof/FPGA/MPO/M9703/apps/MIMO_OFDM_11ac/SystemVue_CoreGen_IP/tmp/_cg/xfft_v8_0.vhd 
-- Device	: 6vlx195tff1156-2
-- Input file	: C:/Ben/EEsof/FPGA/MPO/M9703/apps/MIMO_OFDM_11ac/SystemVue_CoreGen_IP/tmp/_cg/xfft_v8_0.ngc
-- Output file	: C:/Ben/EEsof/FPGA/MPO/M9703/apps/MIMO_OFDM_11ac/SystemVue_CoreGen_IP/tmp/_cg/xfft_v8_0.vhd
-- # of Entities	: 1
-- Design Name	: xfft_v8_0
-- Xilinx	: C:\Xilinx\14.4\ISE_DS\ISE\
--             
-- Purpose:    
--     This VHDL netlist is a verification model and uses simulation 
--     primitives which may not represent the true implementation of the 
--     device, however the netlist is functionally correct and should not 
--     be modified. This file cannot be synthesized and should only be used 
--     with supported simulation tools.
--             
-- Reference:  
--     Command Line Tools User Guide, Chapter 23
--     Synthesis and Simulation Design Guide, Chapter 6
--             
--------------------------------------------------------------------------------



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
use UNISIM.VPKG.ALL;

entity FFT_FIFO is
  port (
    aclk : in STD_LOGIC := 'X'; 
    arst : in STD_LOGIC := 'X'; 
    s_axis_data_tvalid : in STD_LOGIC := 'X';  
    s_axis_data_tready : out STD_LOGIC; 
    FIFO_empty_n : out STD_LOGIC;  
    FIFO_RdEn : in STD_LOGIC;
    s_axis_config_tdata : in STD_LOGIC_VECTOR ( 15 downto 0 ); 
    s_axis_data_tdata : in STD_LOGIC_VECTOR ( 47 downto 0 ); 
    FIFO_OutData : out STD_LOGIC_VECTOR ( 35 downto 0 );
    FFT_In_Ready : out std_logic;
    event_fft_overflow : out STD_LOGIC;
    demod_start : out std_logic
  );
end FFT_FIFO;

architecture STRUCTURE of FFT_FIFO is
  
  signal FIFO_full : STD_LOGIC;  
  signal FIFO_WREn : STD_LOGIC;
  signal FFT_OutData : out STD_LOGIC_VECTOR ( 47 downto 0 );
  signal FIFO_InData : out STD_LOGIC_VECTOR ( 35 downto 0 );
  
  component fifo_generator_v9_3 is
  PORT (
    clk : IN STD_LOGIC;
    srst : IN STD_LOGIC;
    din : IN STD_LOGIC_VECTOR(35 DOWNTO 0);
    wr_en : IN STD_LOGIC;
    rd_en : IN STD_LOGIC;
    dout : OUT STD_LOGIC_VECTOR(35 DOWNTO 0);
    full : OUT STD_LOGIC;
    empty : OUT STD_LOGIC
  );
  end component;
  
  component xfft_v8_0 is
  PORT (
    aclk : in STD_LOGIC := 'X'; 
    aresetn : in STD_LOGIC := 'X'; 
    s_axis_config_tvalid : in STD_LOGIC := 'X'; 
    s_axis_data_tvalid : in STD_LOGIC := 'X'; 
    s_axis_data_tlast : in STD_LOGIC := 'X'; 
    m_axis_data_tready : in STD_LOGIC := 'X'; 
    m_axis_status_tready : in STD_LOGIC := 'X'; 
    s_axis_config_tready : out STD_LOGIC; 
    s_axis_data_tready : out STD_LOGIC; 
    m_axis_data_tvalid : out STD_LOGIC; 
    m_axis_data_tlast : out STD_LOGIC; 
    m_axis_status_tvalid : out STD_LOGIC; 
    event_frame_started : out STD_LOGIC; 
    event_tlast_unexpected : out STD_LOGIC; 
    event_tlast_missing : out STD_LOGIC; 
    event_fft_overflow : out STD_LOGIC; 
    event_status_channel_halt : out STD_LOGIC; 
    event_data_in_channel_halt : out STD_LOGIC; 
    event_data_out_channel_halt : out STD_LOGIC; 
    s_axis_config_tdata : in STD_LOGIC_VECTOR ( 15 downto 0 ); 
    s_axis_data_tdata : in STD_LOGIC_VECTOR ( 47 downto 0 ); 
    m_axis_data_tdata : out STD_LOGIC_VECTOR ( 47 downto 0 ); 
    m_axis_data_tuser : out STD_LOGIC_VECTOR ( 7 downto 0 ); 
    m_axis_status_tdata : out STD_LOGIC_VECTOR ( 7 downto 0 ) 
  );
  end component;
  
begin

  FIFO_InData <= FFT_OutData(41 downto 24) & FFT_OutData(17 downto 0);
  
  inst_FIFO : fifo_generator_v9_3
  port map (
    clk => aclk,
    srst => arst,
    din => FIFO_InData,
    wr_en => FIFO_WREn,
    rd_en => ,
    dout => FIFO_OutData,
    full => FIFO_full,
    empty => 
  );
  
  inst_FFT : xfft_v8_0
  port map (
    aclk => aclk,
    aresetn => not arst,
    s_axis_config_tvalid => s_axis_config_tvalid,
    s_axis_data_tvalid => s_axis_data_tvalid,
    s_axis_data_tlast => '1',
    m_axis_data_tready => not FIFO_full,
    m_axis_status_tready => '1',
    s_axis_config_tready => open,
    s_axis_data_tready => FFT_In_Ready,
    m_axis_data_tvalid => FIFO_WREn,
    m_axis_data_tlast => open,
    m_axis_status_tvalid => open, 
    event_frame_started => open,
    event_tlast_unexpected => open, 
    event_tlast_missing => open,
    event_fft_overflow => event_fft_overflow,
    event_status_channel_halt => open,
    event_data_in_channel_halt => open, 
    event_data_out_channel_halt => open,
    s_axis_config_tdata => s_axis_config_tdata,
    s_axis_data_tdata => s_axis_data_tdata,
    m_axis_data_tdata => FFT_OutData,
    m_axis_data_tuser => ,
    m_axis_status_tdata => 
  );
  
end STRUCTURE;

