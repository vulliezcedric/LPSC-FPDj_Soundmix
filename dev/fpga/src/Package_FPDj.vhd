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
use work.Fir_index_package.all;



package Package_FPDj is


component Intensity_Bands_Extraction is
port(
    Clk_i                               : in std_logic;
    Reset_i                             : in std_logic;
    -- fft interface
    Frame_Index_i                       : in std_logic_vector (15 downto 0);
    Frame_start_i                       : in std_logic;
    Frame_end_i                         : in std_logic;
    Frame_Data_i                        : in std_logic_vector (31 downto 0);
    Frame_Data_valid_i                  : in std_logic;
    -- user Interface
    Bar_intensity_o                     : out  BarIndex_intensity_array;
    Data_Ready_o                        : out std_logic
);
end component;

 
 
 
 
 
end package;