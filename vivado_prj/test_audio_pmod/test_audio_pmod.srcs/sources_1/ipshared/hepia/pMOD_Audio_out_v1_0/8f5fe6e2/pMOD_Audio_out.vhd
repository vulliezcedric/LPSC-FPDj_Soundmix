----------------------------------------------------------------------------------
-- Company: hepia // HES-SO
-- 
-- Create Date: 31.03.2015 10:02:17
-- Design Name: pMOD_Audio_out
-- Module Name: pMOD_Audio_out - arch
-- Project Name: pMOD_Audio_out
-- Target Devices: Nexy 4 board - Artix 7 xc7a100tcsg324-1  
-- Tool Versions: 2014.4
-- Description: Interface for the audio output pMOD designed by Digilent
-- 
-- Dependencies: 
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
use IEEE.NUMERIC_STD.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pMOD_Audio_out is
  port (clk       : in  std_logic;
         rst      : in  std_logic;
         audio_in : in  std_logic_vector(15 downto 0);
         done     : out std_logic;
         SDOUT    : out std_logic;
         SCLK     : out std_logic;
         MCLK     : out std_logic;
         LRCK     : out std_logic);
end pMOD_Audio_out;

architecture arch of pMOD_Audio_out is

  signal div_cnt        : unsigned(9 downto 0);           -- 50 MHZ / 8K 
  signal shift_reg_load : std_logic;
  signal shift_reg_en   : std_logic;
  signal shift_reg      : std_logic_vector(15 downto 0);  -- 50 MHZ / 8K 

begin

------------------------------------    
---------- serial transmission -----
------------------------------------

-- generate LRCK and MCLK

  process(clk)
  begin
    if rising_edge(clk) then
      if rst = '1' then
        div_cnt <= (others => '0');
      else
        div_cnt <= div_cnt + 1;
      end if;
    end if;
  end process;

  MCLK <= div_cnt(3);                   -- 50MHz / 16
  LRCK <= div_cnt(9);                   -- 50MHz / 1024

  shift_reg_load <= '1' when div_cnt(8 downto 0) = 0
                    else '0';

  done         <= shift_reg_load;
  shift_reg_en <= '1' when div_cnt(4 downto 0) = 0
                  else '0';
  SCLK <= div_cnt(4);

  SDOUT <= shift_reg(15);

  process(clk)
  begin
    if rising_edge(clk) then
      if rst = '1' then
        shift_reg <= (others => '0');
      elsif shift_reg_load = '1' then
        shift_reg(15 downto 0) <= std_logic_vector(unsigned(audio_in));
      elsif shift_reg_en = '1' then
        shift_reg <= shift_reg(14 downto 0) & '0';
      end if;
    end if;
  end process;
  
end arch;
