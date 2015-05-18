--Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2014.4 (win64) Build 1071353 Tue Nov 18 18:24:04 MST 2014
--Date        : Fri May 15 00:47:21 2015
--Host        : RagingZen-PC running 64-bit Service Pack 1  (build 7601)
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
    AudioInput_o : out STD_LOGIC_VECTOR ( 11 downto 0 );
    Audio_output_i : in STD_LOGIC_VECTOR ( 15 downto 0 );
    Clk_50Mhz_o : out STD_LOGIC;
    Enable_o : out STD_LOGIC;
    audio_in_SCLK : out STD_LOGIC;
    audio_in_SDATA : in STD_LOGIC;
    audio_in_nCS : out STD_LOGIC;
    audio_out_LRCK : out STD_LOGIC;
    audio_out_MCLK : out STD_LOGIC;
    audio_out_SCLK : out STD_LOGIC;
    audio_out_SDOUT : out STD_LOGIC;
    clk_108Mhz_o : out STD_LOGIC;
    clk_in : in STD_LOGIC;
    locked : out STD_LOGIC;
    reset : in STD_LOGIC
  );
end test_pmod_audio_design_wrapper;

architecture STRUCTURE of test_pmod_audio_design_wrapper is
  component test_pmod_audio_design is
  port (
    clk_in : in STD_LOGIC;
    Clk_50Mhz_o : out STD_LOGIC;
    locked : out STD_LOGIC;
    audio_in_SDATA : in STD_LOGIC;
    Enable_o : out STD_LOGIC;
    audio_out_SDOUT : out STD_LOGIC;
    audio_out_SCLK : out STD_LOGIC;
    audio_out_MCLK : out STD_LOGIC;
    audio_out_LRCK : out STD_LOGIC;
    audio_in_SCLK : out STD_LOGIC;
    audio_in_nCS : out STD_LOGIC;
    reset : in STD_LOGIC;
    AudioInput_o : out STD_LOGIC_VECTOR ( 11 downto 0 );
    Audio_output_i : in STD_LOGIC_VECTOR ( 15 downto 0 );
    clk_108Mhz_o : out STD_LOGIC
  );
  end component test_pmod_audio_design;
begin
test_pmod_audio_design_i: component test_pmod_audio_design
    port map (
      AudioInput_o(11 downto 0) => AudioInput_o(11 downto 0),
      Audio_output_i(15 downto 0) => Audio_output_i(15 downto 0),
      Clk_50Mhz_o => Clk_50Mhz_o,
      Enable_o => Enable_o,
      audio_in_SCLK => audio_in_SCLK,
      audio_in_SDATA => audio_in_SDATA,
      audio_in_nCS => audio_in_nCS,
      audio_out_LRCK => audio_out_LRCK,
      audio_out_MCLK => audio_out_MCLK,
      audio_out_SCLK => audio_out_SCLK,
      audio_out_SDOUT => audio_out_SDOUT,
      clk_108Mhz_o => clk_108Mhz_o,
      clk_in => clk_in,
      locked => locked,
      reset => reset
    );
end STRUCTURE;
