--Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2014.4 (win64) Build 1071353 Tue Nov 18 18:24:04 MST 2014
--Date        : Fri May 22 19:56:01 2015
--Host        : RagingZen-PC running 64-bit Service Pack 1  (build 7601)
--Command     : generate_target test_pmod_audio_design.bd
--Design      : test_pmod_audio_design
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity test_pmod_audio_design is
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
end test_pmod_audio_design;

architecture STRUCTURE of test_pmod_audio_design is
  component test_pmod_audio_design_clk_wiz_0_0 is
  port (
    clk_in1 : in STD_LOGIC;
    clk_out1 : out STD_LOGIC;
    clk_out2 : out STD_LOGIC;
    reset : in STD_LOGIC;
    locked : out STD_LOGIC
  );
  end component test_pmod_audio_design_clk_wiz_0_0;
  component test_pmod_audio_design_pMOD_Audio_in_0_0 is
  port (
    CLK : in STD_LOGIC;
    RST : in STD_LOGIC;
    SDATA : in STD_LOGIC;
    SCLK : out STD_LOGIC;
    nCS : out STD_LOGIC;
    DATA : out STD_LOGIC_VECTOR ( 11 downto 0 );
    START : in STD_LOGIC;
    DONE : out STD_LOGIC
  );
  end component test_pmod_audio_design_pMOD_Audio_in_0_0;
  component test_pmod_audio_design_pMOD_Audio_out_0_0 is
  port (
    clk : in STD_LOGIC;
    rst : in STD_LOGIC;
    audio_in : in STD_LOGIC_VECTOR ( 15 downto 0 );
    done : out STD_LOGIC;
    SDOUT : out STD_LOGIC;
    SCLK : out STD_LOGIC;
    MCLK : out STD_LOGIC;
    LRCK : out STD_LOGIC
  );
  end component test_pmod_audio_design_pMOD_Audio_out_0_0;
  component test_pmod_audio_design_not_gate_0_0 is
  port (
    I : in STD_LOGIC;
    O : out STD_LOGIC
  );
  end component test_pmod_audio_design_not_gate_0_0;
  signal Audio_output_i_1 : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal SDATA_1 : STD_LOGIC;
  signal clk_in1_1 : STD_LOGIC;
  signal clk_wiz_0_clk_out1 : STD_LOGIC;
  signal clk_wiz_0_clk_out2 : STD_LOGIC;
  signal clk_wiz_0_locked : STD_LOGIC;
  signal not_gate_0_O : STD_LOGIC;
  signal pMOD_Audio_in_0_DATA : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal pMOD_Audio_in_0_SCLK : STD_LOGIC;
  signal pMOD_Audio_in_0_nCS : STD_LOGIC;
  signal pMOD_Audio_out_0_LRCK : STD_LOGIC;
  signal pMOD_Audio_out_0_MCLK : STD_LOGIC;
  signal pMOD_Audio_out_0_SCLK : STD_LOGIC;
  signal pMOD_Audio_out_0_SDOUT : STD_LOGIC;
  signal pMOD_Audio_out_0_done : STD_LOGIC;
  signal reset_1 : STD_LOGIC;
  signal NLW_pMOD_Audio_in_0_DONE_UNCONNECTED : STD_LOGIC;
begin
  AudioInput_o(11 downto 0) <= pMOD_Audio_in_0_DATA(11 downto 0);
  Audio_output_i_1(15 downto 0) <= Audio_output_i(15 downto 0);
  Clk_50Mhz_o <= clk_wiz_0_clk_out1;
  Enable_o <= pMOD_Audio_out_0_done;
  SDATA_1 <= audio_in_SDATA;
  audio_in_SCLK <= pMOD_Audio_in_0_SCLK;
  audio_in_nCS <= pMOD_Audio_in_0_nCS;
  audio_out_LRCK <= pMOD_Audio_out_0_LRCK;
  audio_out_MCLK <= pMOD_Audio_out_0_MCLK;
  audio_out_SCLK <= pMOD_Audio_out_0_SCLK;
  audio_out_SDOUT <= pMOD_Audio_out_0_SDOUT;
  clk_108Mhz_o <= clk_wiz_0_clk_out2;
  clk_in1_1 <= clk_in;
  locked <= clk_wiz_0_locked;
  reset_1 <= reset;
clk_wiz_0: component test_pmod_audio_design_clk_wiz_0_0
    port map (
      clk_in1 => clk_in1_1,
      clk_out1 => clk_wiz_0_clk_out1,
      clk_out2 => clk_wiz_0_clk_out2,
      locked => clk_wiz_0_locked,
      reset => reset_1
    );
not_gate_0: component test_pmod_audio_design_not_gate_0_0
    port map (
      I => clk_wiz_0_locked,
      O => not_gate_0_O
    );
pMOD_Audio_in_0: component test_pmod_audio_design_pMOD_Audio_in_0_0
    port map (
      CLK => clk_wiz_0_clk_out1,
      DATA(11 downto 0) => pMOD_Audio_in_0_DATA(11 downto 0),
      DONE => NLW_pMOD_Audio_in_0_DONE_UNCONNECTED,
      RST => not_gate_0_O,
      SCLK => pMOD_Audio_in_0_SCLK,
      SDATA => SDATA_1,
      START => pMOD_Audio_out_0_done,
      nCS => pMOD_Audio_in_0_nCS
    );
pMOD_Audio_out_0: component test_pmod_audio_design_pMOD_Audio_out_0_0
    port map (
      LRCK => pMOD_Audio_out_0_LRCK,
      MCLK => pMOD_Audio_out_0_MCLK,
      SCLK => pMOD_Audio_out_0_SCLK,
      SDOUT => pMOD_Audio_out_0_SDOUT,
      audio_in(15 downto 0) => Audio_output_i_1(15 downto 0),
      clk => clk_wiz_0_clk_out1,
      done => pMOD_Audio_out_0_done,
      rst => not_gate_0_O
    );
end STRUCTURE;
