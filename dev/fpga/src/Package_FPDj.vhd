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

component Intensity_Bands_Format is
port(
    Clk_i                               : in std_logic;
    Reset_i                             : in std_logic;      
    Bar_intensity_i                     : in  BarIndex_intensity_array;
    Data_Ready_i                        : in std_logic;
    Bar_intensity_o                     : out  BarIndex_intensity_array;
    Data_Ready_o                        : out std_logic    
);
end component;
--------------------------------------------------
component blk_mem_gen_Title IS
  PORT (
    clka : IN STD_LOGIC;
    ena : IN STD_LOGIC;
    addra : IN STD_LOGIC_VECTOR(16 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
  );
END component;

  
  component Scope is
    generic(
        Horizontal_length : integer :=1280
    );
    port(
        Clk_i                               : in std_logic;
        Reset_i                             : in std_logic;      
        Audio_i                             : in std_logic_vector (15 downto 0); 
        Audio_Valid_i                       : in std_logic;  
        first_Row_i                         : in std_logic;     
        --BRAM Read interface
        clkb_i                              : IN STD_LOGIC;
        enb_i                               : IN STD_LOGIC;
        web_i                               : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
        addrb_i                             : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
        dinb_i                              : IN STD_LOGIC_VECTOR(30 DOWNTO 0);
        doutb_o                             : OUT STD_LOGIC_VECTOR(30 DOWNTO 0)
    );
end component;

 --------------------------------------------------------------------
 type Color_type is record    
        Red     : std_logic_vector(3 downto 0);
        Green   : std_logic_vector(3 downto 0);
        Blue    : std_logic_vector(3 downto 0);
end record;


 
end package;