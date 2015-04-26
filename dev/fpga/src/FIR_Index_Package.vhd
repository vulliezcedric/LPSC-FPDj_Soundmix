-- Spec: 25 Hz to 20kHz
-- Sample frequency: 48kHz
-- Depth needed for min 4 samples at 20Hz: 2400*4= 9600

-- Depth to take 16384 or 8192

-- with FIR Depth at 16384 (2^14) and 16 bars:
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library work;

package FIR_Index_Package is


Constant Nbbars_C : integer:= 16;
Type BarIndex_intensity_array is Array (0 to Nbbars_C-1) of std_logic_vector (34 downto 0);
Type FIR_index_array is Array (0 to Nbbars_C-1) of std_logic_vector (15 downto 0);


Constant FIR_Index_to_Bar : FIR_index_array :=(

    conv_std_logic_vector (8,  16),
    conv_std_logic_vector (13, 16),
    conv_std_logic_vector (21, 16),
    conv_std_logic_vector (54, 16),
    conv_std_logic_vector (85, 16),
    conv_std_logic_vector (136, 16),
    conv_std_logic_vector (216, 16),
    conv_std_logic_vector (341, 16),
    -- to be define still        
    conv_std_logic_vector (400, 16),
    conv_std_logic_vector (500, 16),
    conv_std_logic_vector (600, 16),
    conv_std_logic_vector (700, 16),
    conv_std_logic_vector (800, 16),
    conv_std_logic_vector (900, 16),
    conv_std_logic_vector (1000, 16),
    conv_std_logic_vector (1200, 16)
    
    );


   end package;
   