----------------------------------------------------------------------------------
-- Company: hepia // HES-SO
-- 
-- Create Date: 31.03.2015 09:38:28
-- Design Name: tb_test_pmod_audio
-- Module Name: tb_test_pmod_audio - Behavioral
-- Project Name: tb_test_pmod_audio
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

entity tb_test_pmod_audio is
end tb_test_pmod_audio;

architecture Behavioral of tb_test_pmod_audio is

  component test_pmod_audio
    port (
      clk_i           : in  std_logic;
      resetn_i        : in  std_logic;
      audio_in_SDATA  : in  std_logic;
      audio_in_SCLK   : out std_logic;
      audio_in_nCS    : out std_logic;
      audio_out_SDOUT : out std_logic;
      audio_out_SCLK  : out std_logic;
      audio_out_MCLK  : out std_logic;
      audio_out_LRCK  : out std_logic;
      leds_o : out std_logic_vector(1 downto 0)
      );
  end component;

  signal clk_i    : std_logic := '1';
  signal resetn_i : std_logic := '0';

  signal audio_in_SDATA : std_logic := '0';
  signal audio_in_SCLK  : std_logic;
  signal audio_in_nCS   : std_logic;

  signal audio_out_SDOUT : std_logic;
  signal audio_out_SCLK  : std_logic;
  signal audio_out_MCLK  : std_logic;
  signal audio_out_LRCK  : std_logic;
  
  signal leds_o : std_logic_vector(1 downto 0);

  constant clk_i_period : time := 10 ns;
  
begin

  clk_i <= not clk_i after clk_i_period / 2;


  test_pmod_audio_1 : test_pmod_audio
    port map (
      clk_i           => clk_i,
      resetn_i        => resetn_i,
      audio_in_SDATA  => audio_in_SDATA,
      audio_in_SCLK   => audio_in_SCLK,
      audio_in_nCS    => audio_in_nCS,
      audio_out_SDOUT => audio_out_SDOUT,
      audio_out_SCLK  => audio_out_SCLK,
      audio_out_MCLK  => audio_out_MCLK,
      audio_out_LRCK  => audio_out_LRCK,
      leds_o          => leds_o
      );

  
  waveform_proc : process
  begin  -- process waveform_proc

    -- hold reset
    resetn_i <= '0';
    wait for clk_i_period * 20;
    resetn_i <= '1';

    -- send random data
    wait until audio_in_nCS = '0';
    wait for clk_i_period;
    audio_in_SDATA <= '1';

    wait until audio_in_nCS = '0';
    wait for clk_i_period;
    audio_in_SDATA <= '0';

    wait until audio_in_nCS = '0';
    wait for clk_i_period;
    audio_in_SDATA <= '0';
    
    wait until audio_in_nCS = '0';
    wait for clk_i_period;
    audio_in_SDATA <= '0';
    
    wait until audio_in_nCS = '0';
    wait for clk_i_period;
    audio_in_SDATA <= '0';
    
    wait until audio_in_nCS = '0';
    wait for clk_i_period;
    audio_in_SDATA <= '1';
    wait for clk_i_period * 20;
    audio_in_SDATA <= '0';
    wait for clk_i_period * 10;
    audio_in_SDATA <= '1';
    wait for clk_i_period * 20;
    audio_in_SDATA <= '0';
    wait for clk_i_period * 15;
    audio_in_SDATA <= '1';
    wait for clk_i_period * 20;
    audio_in_SDATA <= '0';
            
    wait until audio_in_nCS = '1';
    wait for clk_i_period;
    audio_in_SDATA <= '0';
    
    wait until audio_in_nCS = '1';
    wait for clk_i_period;
    audio_in_SDATA <= '0';
    
    wait until audio_in_nCS = '1';
    wait for clk_i_period;
    audio_in_SDATA <= '0';
    
    wait until audio_in_nCS = '1';
    wait for clk_i_period;
    audio_in_SDATA <= '1';
    
    wait until audio_in_nCS = '1';
    wait for clk_i_period;
    audio_in_SDATA <= '1';
    
    wait until audio_in_nCS = '1';
    wait for clk_i_period;
    audio_in_SDATA <= '0';
        
    wait;
  end process waveform_proc;

end Behavioral;
