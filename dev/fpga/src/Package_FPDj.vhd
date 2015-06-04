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



  component test_pmod_audio_design_wrapper is
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
end component;


  component echo_filter is
generic (
    Delay : integer:= 4000
    );

  port (
    Clk_i           : in std_logic;
    Reset_i         : in std_logic;
    Enable_i        : in std_logic;
    Echo_delay_i    : in std_logic_vector (15 downto 0 );
    Audio_i         : in std_logic_vector (15 downto 0 );
    Audio_o         : out std_logic_vector (15 downto 0 )  
  );
end component;


component mult_gen_0 IS
  PORT (
    CLK : IN STD_LOGIC;
    A : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    B : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    P : OUT STD_LOGIC_VECTOR(23 DOWNTO 0)
  );
END component;


component debouncer is
    Generic ( DEBNC_CLOCKS : INTEGER range 2 to (INTEGER'high) := 2**16;
              PORT_WIDTH : INTEGER range 1 to (INTEGER'high) := 5);
    Port ( SIGNAL_I : in  STD_LOGIC_VECTOR ((PORT_WIDTH - 1) downto 0);
           CLK_I : in  STD_LOGIC;
           SIGNAL_O : out  STD_LOGIC_VECTOR ((PORT_WIDTH - 1) downto 0));
end component;
component Display_manager IS
generic (
        horiztonal_size      : INTEGER:= 800;
        vertical_size        : INTEGER:= 600
);
    port (
        Clk_i               : in std_logic;
        Reset_i             : in std_logic;        
        Bar_intensity_i     : in  BarIndex_intensity_array;
        Data_Ready_i        : in std_logic;
          -- audio in
        Clk_50Mhz_i        : in std_logic;
        Audio_i            : in std_logic_vector(15 downto 0);  
        Audio_valid_i      : in std_logic;
         -- VGA output                                   
        VGA_Red_o           : out std_logic_vector(3 downto 0);                        
        VGA_Green_o         : out std_logic_vector(3 downto 0);                       
        VGA_Blue_o          : out std_logic_vector(3 downto 0);                       
        VGA_h_sync_o        : out std_logic;                       
        VGA_v_sync_o        : out std_logic                       
);
END component;

component Frequency_Analysis_top is
generic (
        ADC_Width: integer:= 12
    );
port(
    Clk_i                               : in std_logic;
    Reset_i                             : in std_logic;
    -- Audio interface
    Audio_Left_Channel_i                : in std_logic_vector (ADC_Width-1 downto 0);
    Audio_Right_Channel_i               : in std_logic_vector (ADC_Width-1 downto 0);
    Audio_Data_Valid_i                  : in std_logic;
    -- user Interface
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

component Menu IS  
    
   port(
    Clk_i                       : in std_logic;
    Reset_i                     : in std_logic;
    -- FPGA inputs  
    BTN_i                       : in std_logic_vector (4 downto 0);
    SW_i                        : in  std_logic_vector (15 downto 0);
    
    -- fpga outputs 
    LED_o                       : out std_logic_vector(15 downto 0);    
    SSEG_CA_o 		            : out  STD_LOGIC_VECTOR (7 downto 0);
    SSEG_AN_o		            : out  STD_LOGIC_VECTOR (7 downto 0);
    
    -- user interface
    enable_sound_o              : out std_logic;
    volume_o                    : out  STD_LOGIC_VECTOR (7 downto 0);    
    Filter_Echo_EN_o            : out std_logic;
    Filter_Echo_delay_o         : out  STD_LOGIC_VECTOR (15 downto 0); 
    Filter_1_Addaptive_EN_o     : out std_logic;
    Filter_2_Addaptive_EN_o     : out std_logic;
    -- display                   
    Display_Title_EN_o          : out std_logic;
    Display_Scope_EN_o          : out std_logic;
    Display_Bars_EN_o           : out std_logic
);
END component;


 --------------------------------------------------------------------
 type Color_type is record    
        Red     : std_logic_vector(3 downto 0);
        Green   : std_logic_vector(3 downto 0);
        Blue    : std_logic_vector(3 downto 0);
end record;


 
end package;