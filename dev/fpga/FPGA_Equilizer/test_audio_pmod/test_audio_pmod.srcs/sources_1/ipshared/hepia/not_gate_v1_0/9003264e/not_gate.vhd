----------------------------------------------------------------------------------
-- Company: hepia // HES-SO
-- 
-- Create Date: 31.03.2015 09:38:28
-- Design Name: not_gate
-- Module Name: not_gate - Behavioral
-- Project Name: not_gate
-- Target Devices: Nexy 4 board - Artix 7 xc7a100tcsg324-1  
-- Tool Versions: 2014.4
-- Description: Invert a bit
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity not_gate is
  port (
    I : in std_logic;
    O : out std_logic
  );
end not_gate;

architecture arch of not_gate is

begin

    O <= not I;

end arch;
