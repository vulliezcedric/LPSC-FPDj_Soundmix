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
USE IEEE.STD_LOGIC_1164.ALL; 
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;
use work.Fir_index_package.all;
use work.Package_FPDj.all;
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
    -- Buttons in
    BTN_i           : in std_logic_vector (4 downto 0);
    -- Debug LEDs
    LED : out std_logic_vector(15 downto 0);    
    -- VGA output                                   
    VGA_Red_o           : out std_logic_vector(3 downto 0);                        
    VGA_Green_o         : out std_logic_vector(3 downto 0);                       
    VGA_Blue_o          : out std_logic_vector(3 downto 0);                       
    VGA_h_sync_o        : out std_logic;                       
    VGA_v_sync_o        : out std_logic                 
    
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
  
  signal Audio_input_s      : std_logic_vector (11 downto 0);
  signal Audio_extention_s  : std_logic_vector (3 downto 0);
  signal Audio_output_s     : std_logic_vector (15 downto 0);
  signal Enable_s           : std_logic;
  signal Audio_output_echo_s: std_logic_vector (15 downto 0);
  signal Clk_50Mhz_s : std_logic; 
  signal Clk_108Mhz_s : std_logic;
  
  signal BTN_debounce_s     : std_logic_vector (4 downto 0);
  signal BTN_debounce_delay_s : std_logic_vector (4 downto 0);
  signal BTN_Rising_edge_s : std_logic_vector (4 downto 0);
  signal volume_amp_s : std_logic_vector (7 downto 0);
  signal Audio_amplified_s: std_logic_vector (23 downto 0);
  signal Audio_amplified_normalized_s: std_logic_vector (15 downto 0);
  signal Audio_input_16_s: std_logic_vector (15 downto 0);
  signal BarIndex_intensity_s : BarIndex_intensity_array;
  signal BarIndex_intensity_input_s : BarIndex_intensity_array;
  signal sample_count_s: std_logic_vector (15 downto 0);
  signal Enable_48k_s : std_logic;
  signal Enable_counter: std_logic_vector (1 downto 0);
  signal Data_Ready_s : std_logic;
  
  
  
  
  
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
    Clk_i   : in std_logic;
    Reset_i : in std_logic;
    Enable_i : in std_logic;
    Audio_i : in std_logic_vector ( 11 downto 0 );
    Audio_o : out std_logic_vector ( 15 downto 0 )  
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

begin

  reset <= not resetn_i;
  
 -- leds_o(0) <= reset;
 -- leds_o(1) <= locked;
  Audio_output_s <=  Audio_output_echo_s; 
 Audio_amplified_normalized_s <= Audio_amplified_s(18 downto 3); -- removing 3 fraction bits
   
 --   LED(15 downto 0) <=Audio_input_16_s;
 -- LED(7 downto 0) <= Audio_input_s(11 downto 4);
 -- LED(15 downto 8) <= Audio_amplified_normalized_s(15 downto 8);
 LED(15 downto 0)<= BarIndex_intensity_s(1)(15 downto 0);
 -- frequency check/ divider
process (Clk_50Mhz_s,reset)
begin
    if reset='1' then
        sample_count_s <=(others=>'0');
        --LED(15 downto 0)<=(others=>'0');
        Enable_48k_s <='0';
        Enable_counter<= "00";
    elsif rising_edge(Clk_50Mhz_s) then
        if Enable_s='1' then
            Enable_counter <=Enable_counter+1;
        end if;   
         
        if Enable_counter="01" then
            Enable_48k_s <='1';
            Enable_counter <="00";
        else
            Enable_48k_s <='0';
        end if;
        
        if  Enable_48k_s ='1' then
            sample_count_s  <=(others=>'0');
           -- LED(15 downto 0) <=sample_count_s;
        else
            sample_count_s <= sample_count_s+1;
        end if;
    end if;
    
end process;

 
  --===============================================================
test_pmod_audio_design_i: component test_pmod_audio_design_wrapper
 --===============================================================
    port map (
      AudioInput_o => Audio_input_s,
      Audio_output_i => Audio_amplified_normalized_s ,--Audio_amplified_normalized_s, --Audio_output_s,
      audio_in_SCLK => s_audio_in_SCLK,
      Enable_o => Enable_s,
      Clk_50Mhz_o => Clk_50Mhz_s,
      clk_108Mhz_o => Clk_108Mhz_s,
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

-- Volume

process (Clk_50Mhz_s,reset)
begin
    if reset='1' then
        volume_amp_s <="10000000";
    elsif rising_edge(Clk_50Mhz_s) then
        if BTN_Rising_edge_s(2)='1' then
            volume_amp_s <= volume_amp_s + "00000001";
    
        elsif BTN_Rising_edge_s(4)='1' then
            volume_amp_s <= volume_amp_s - "00000001";
        end if;
    end if;
    
end process;



Audio_input_16_s <= "0000" & Audio_input_s(Audio_input_s'high downto 1) &'0';
-- 16_0 * 5_3= 20_4
--
--====================== 
    Input_Volume : mult_gen_0
--======================

  PORT map(
    CLK     => Clk_50Mhz_s,       
    A       => Audio_input_16_s,       
    B       => volume_amp_s,        
    P       => Audio_amplified_s
  );










    
-- --=========================
  -- Filtre_Echo: echo_filter
-- --=========================
-- generic map (
    -- Delay => 4000
    -- )

  -- port map(
    -- Clk_i       => Clk_50Mhz_s,
    -- Reset_i     => reset,        
    -- Enable_i    => Enable_s,        
    -- Audio_i     => Audio_amplified_normalized_s,        
    -- Audio_o     => Audio_output_echo_s        
  -- );
      
   
      
     
      
      
      
   -- invert all the I/O of the pMOD interface
   -- (the pMOD IPs have been initially written to be used with a tool which does the inversion automatically)
   audio_in_SCLK <= NOT s_audio_in_SCLK;
   audio_in_nCS <= NOT s_audio_in_nCS;
   s_audio_in_SDATA <= NOT audio_in_SDATA;
	
   audio_out_LRCK <= NOT s_audio_out_LRCK;
   audio_out_MCLK <= NOT s_audio_out_MCLK;
   audio_out_SDOUT <= NOT s_audio_out_SDOUT;
   audio_out_SCLK <= NOT s_audio_out_SCLK;

   
   Button_debounce: for i in 0 to 4 generate
        --=============================
        Debounce_Button: debouncer
        --=============================        
        Generic map( 
            DEBNC_CLOCKS => 2000,
            PORT_WIDTH => 1
            )
        Port map( 
            SIGNAL_I => BTN_i(i downto i),
            CLK_I => Clk_50Mhz_s,
            SIGNAL_O => BTN_debounce_s(i downto i)
        );

    process ( Clk_50Mhz_s)
    begin
        if rising_edge (Clk_50Mhz_s) then
            BTN_debounce_delay_s(i) <= BTN_debounce_s(i);
            if BTN_debounce_s(i)='0'and BTN_debounce_delay_s(i) ='1' then
                BTN_Rising_edge_s (i) <='1';
            else
                BTN_Rising_edge_s (i) <='0';
            end if;
        end if;
   end process;
   
   end generate;
   
   

 

BarIndex_intensity_input_s <= BarIndex_intensity_dummy_C when BTN_i (0)='1' else
                            BarIndex_intensity_s;

--======================
Display: Display_manager 
--======================
    generic map (
        horiztonal_size    => 1280,
        vertical_size      => 1024
    )
    port map (
        Clk_i               => Clk_108Mhz_s,           
        Reset_i             => reset,             
        Bar_intensity_i     => BarIndex_intensity_input_s, --BarIndex_intensity_dummy_C           
        Data_Ready_i        => '0',
        -- VGA output                                   
        VGA_Red_o           => VGA_Red_o,                              
        VGA_Green_o         => VGA_Green_o,                             
        VGA_Blue_o          => VGA_Blue_o,                             
        VGA_h_sync_o        => VGA_h_sync_o,            
        VGA_v_sync_o        => VGA_v_sync_o   
    );
    


--===========================================
Frequencey_analysis : Frequency_Analysis_top
--===========================================
generic map (
        ADC_Width=> 16
    )
port map(
    Clk_i                               => Clk_50Mhz_s,   
    Reset_i                             => reset,         
    -- Audio interface                        
    Audio_Left_Channel_i                => Audio_amplified_normalized_s,           
    Audio_Right_Channel_i               => x"0000",      
    Audio_Data_Valid_i                  => Enable_s , --Enable_48k_s,            
    -- user Interface                           
    Bar_intensity_o                     => BarIndex_intensity_s,            
    Data_Ready_o                        => Data_Ready_s
);


end arch;