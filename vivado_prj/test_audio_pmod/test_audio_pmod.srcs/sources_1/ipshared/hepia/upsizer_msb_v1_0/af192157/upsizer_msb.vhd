----------------------------------------------------------------------------------
-- Company: hepia // HES-SO
-- 
-- Create Date: 31.03.2015 10:19:57
-- Design Name: 
-- Module Name: upsizer_msb - arch
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

entity upsizer_msb is
  generic (
    IN_WIDTH : integer := 16;
    OUT_WIDTH : integer := 32
  );
  port (
    data_in : in std_logic_vector((IN_WIDTH - 1) downto 0);
    data_out : out std_logic_vector((OUT_WIDTH - 1) downto 0)
  );
end upsizer_msb;

architecture arch of upsizer_msb is

begin

  data_out <= data_in & (OUT_WIDTH - IN_WIDTH - 1 downto 0 => '0');

end arch;
