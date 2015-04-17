----------------------------------------------------------------------------------
-- Company: hepia // HES-SO
-- 
-- Create Date: 31.03.2015 09:38:28
-- Design Name: test_pmod_audio
-- Module Name: test_pmod_audio - arch
-- Project Name: test_pmod_audio
-- Target Devices: Nexy 4 board - Artix 7 xc7a100tcsg324-1  
-- Tool Versions: 2014.4
-- Description: Interface for the audio input pMOD designed by hepia
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test_pmod_audio is
  port (
    clk_i           : in  std_logic;
    resetn_i        : in  std_logic;
    -- PMOD audio in
    audio_in_SDATA  : in  std_logic;
    audio_in_SCLK   : out std_logic;
    audio_in_nCS    : out std_logic;
    -- PMOD audio out
    audio_out_SDOUT : out std_logic;
    audio_out_SCLK  : out std_logic;
    audio_out_MCLK  : out std_logic;
    audio_out_LRCK  : out std_logic;
    -- Debug LEDs
    leds_o : out std_logic_vector(1 downto 0)
    );
end test_pmod_audio;


architecture arch of test_pmod_audio is

  --------------------------------
  -- PMOD audio out module
  --------------------------------
  component pMOD_Audio_out
    port (
      clk      : in  std_logic;
      rst      : in  std_logic;
      audio_in : in  std_logic_vector(15 downto 0);
      done     : out std_logic;
      SDOUT    : out std_logic;
      SCLK     : out std_logic;
      MCLK     : out std_logic;
      LRCK     : out std_logic);
  end component;

  signal s_clk : std_logic;
  signal locked  : std_logic;
  signal reset : std_logic := '0';

  -- PMOD interface
  signal s_audio_in_SDATA  : std_logic;
  signal s_audio_in_SCLK   : std_logic;
  signal s_audio_in_nCS    : std_logic;
    
  -- PMOD interface
  signal s_audio_out_SDOUT : std_logic;
  signal s_audio_out_SCLK  : std_logic;
  signal s_audio_out_MCLK  : std_logic;
  signal s_audio_out_LRCK  : std_logic;
  
  component test_pmod_audio_design is
  port (
    clk_in : in STD_LOGIC;
    reset : in STD_LOGIC;
    locked : out STD_LOGIC;
    audio_in_SCLK : out STD_LOGIC;
    audio_in_nCS : out STD_LOGIC;
    audio_in_SDATA : in STD_LOGIC;
    audio_out_SDOUT : out STD_LOGIC;
    audio_out_SCLK : out STD_LOGIC;
    audio_out_MCLK : out STD_LOGIC;
    audio_out_LRCK : out STD_LOGIC
  );
  end component test_pmod_audio_design;
  
begin

  reset <= not resetn_i;
  
  leds_o(0) <= reset;
  leds_o(1) <= locked;

test_pmod_audio_design_i: component test_pmod_audio_design
    port map (
      audio_in_SCLK => s_audio_in_SCLK,
      audio_in_SDATA => audio_in_SDATA,
      audio_in_nCS => s_audio_in_nCS,
      --
      audio_out_LRCK => s_audio_out_LRCK,
      audio_out_MCLK => s_audio_out_MCLK,
      audio_out_SCLK => s_audio_out_SCLK,
      audio_out_SDOUT => s_audio_out_SDOUT,
      --
      clk_in => clk_i,
      locked => locked,
      reset => reset
    );
      

   -- invert all the I/O of the pMOD interface
   -- (the pMOD IPs have been initially written to be used with a tool which does the inversion automatically)
   audio_in_SCLK <= NOT s_audio_in_SCLK;
   audio_in_nCS <= NOT s_audio_in_nCS;
   s_audio_in_SDATA <= NOT audio_in_SDATA;
	
   audio_out_LRCK <= NOT s_audio_out_LRCK;
   audio_out_MCLK <= NOT s_audio_out_MCLK;
   audio_out_SDOUT <= NOT s_audio_out_SDOUT;
   audio_out_SCLK <= NOT s_audio_out_SCLK;

end arch;
