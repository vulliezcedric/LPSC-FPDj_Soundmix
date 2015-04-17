--Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2014.4 (lin64) Build 1071353 Tue Nov 18 16:47:07 MST 2014
--Date        : Tue Mar 31 13:58:40 2015
--Host        : arrow-platform running 64-bit Ubuntu 13.10
--Command     : generate_target test_pmod_audio_design_wrapper.bd
--Design      : test_pmod_audio_design_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity test_pmod_audio_design_wrapper is
  port (
    audio_in_SCLK : out STD_LOGIC;
    audio_in_SDATA : in STD_LOGIC;
    audio_in_nCS : out STD_LOGIC;
    audio_out_LRCK : out STD_LOGIC;
    audio_out_MCLK : out STD_LOGIC;
    audio_out_SCLK : out STD_LOGIC;
    audio_out_SDOUT : out STD_LOGIC;
    clk_in : in STD_LOGIC;
    locked : out STD_LOGIC;
    reset : in STD_LOGIC
  );
end test_pmod_audio_design_wrapper;

architecture STRUCTURE of test_pmod_audio_design_wrapper is
  component test_pmod_audio_design is
  port (
    clk_in : in STD_LOGIC;
    reset : in STD_LOGIC;
    locked : out STD_LOGIC;
    audio_in_SDATA : in STD_LOGIC;
    audio_out_SDOUT : out STD_LOGIC;
    audio_out_SCLK : out STD_LOGIC;
    audio_out_MCLK : out STD_LOGIC;
    audio_out_LRCK : out STD_LOGIC;
    audio_in_SCLK : out STD_LOGIC;
    audio_in_nCS : out STD_LOGIC
  );
  end component test_pmod_audio_design;
begin
test_pmod_audio_design_i: component test_pmod_audio_design
    port map (
      audio_in_SCLK => audio_in_SCLK,
      audio_in_SDATA => audio_in_SDATA,
      audio_in_nCS => audio_in_nCS,
      audio_out_LRCK => audio_out_LRCK,
      audio_out_MCLK => audio_out_MCLK,
      audio_out_SCLK => audio_out_SCLK,
      audio_out_SDOUT => audio_out_SDOUT,
      clk_in => clk_in,
      locked => locked,
      reset => reset
    );
end STRUCTURE;
