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
    LED             : out std_logic_vector(15 downto 0); 
    SW_i            : in  std_logic_vector (15 downto 0);
    SSEG_CA_o       : out  STD_LOGIC_VECTOR (7 downto 0);
    SSEG_AN_o       : out  STD_LOGIC_VECTOR (7 downto 0);
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
  signal enable_sound_s : std_logic;
  
  signal Filter_Echo_EN_s: std_logic;
  signal Echo_delay_s: std_logic_vector(15 downto 0);


begin

  reset <= not resetn_i;
  
 -- leds_o(0) <= reset;
 -- leds_o(1) <= locked;

 Audio_amplified_normalized_s <=  Audio_amplified_s(18 downto 3) when enable_sound_s='1' else (15=>'1', others=>'0'); -- removing 3 fraction bits
   
 --   LED(15 downto 0) <=Audio_input_16_s;
 -- LED(7 downto 0) <= Audio_input_s(11 downto 4);
 -- LED(15 downto 8) <= Audio_amplified_normalized_s(15 downto 8);
 --LED(15 downto 0)<= BarIndex_intensity_s(1)(15 downto 0);
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

 
 
 -- audio output MUX
 audio_output_s <=  (15=>'1', others=>'0') when enable_sound_s ='0' else    -- no sound
                    Audio_output_echo_s when Filter_Echo_EN_s='1' else      -- echo sound 
                    Audio_amplified_normalized_s ;                          -- normal sound
 
              
                 

 
  --===============================================================
test_pmod_audio_design_i: component test_pmod_audio_design_wrapper
 --===============================================================
    port map (
      AudioInput_o => Audio_input_s,
      Audio_output_i => audio_output_s ,--Audio_amplified_normalized_s, --Audio_output_s,
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

-- process (Clk_50Mhz_s,reset)
-- begin
    -- if reset='1' then
        -- volume_amp_s <="10000000";
    -- elsif rising_edge(Clk_50Mhz_s) then
        -- if BTN_Rising_edge_s(2)='1' then
            -- volume_amp_s <= volume_amp_s + "00000001";
    
        -- elsif BTN_Rising_edge_s(4)='1' then
            -- volume_amp_s <= volume_amp_s - "00000001";
        -- end if;
    -- end if;
    
-- end process;


-- passing from 12 bits signed to 16 bit signed
Audio_input_16_s <= "0000" & Audio_input_s when Audio_input_s(Audio_input_s'high)='0' else
                    "1111" & Audio_input_s;

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










    
--=========================
  Filtre_Echo: echo_filter
--=========================
generic map (
    Delay => 4000
    )

  port map(
    Clk_i       => Clk_50Mhz_s,
    Reset_i     => reset,        
    Enable_i    => Enable_s,  
    Echo_delay_i=> Echo_delay_s,     
    Audio_i     => Audio_amplified_normalized_s,        
    Audio_o     => Audio_output_echo_s        
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
         -- audio in
        Clk_50Mhz_i         => Clk_50Mhz_s, 
        Audio_i             => Audio_amplified_normalized_s, 
        Audio_valid_i       => Enable_s, 
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






--=======================
Interface_menu : Menu
 --=======================   
   port map(
        Clk_i                  => Clk_50Mhz_s,        
        Reset_i                => reset,      
        -- FPGA inputs                
        BTN_i                  => BTN_i,       
        SW_i                   => SW_i,     
                                    
        -- fpga outputs                
        LED_o                  => LED,            
        SSEG_CA_o 		       => SSEG_CA_o,       
        SSEG_AN_o		       => SSEG_AN_o,        
        
        -- user interface
        enable_sound_o        => enable_sound_s,
        volume_o              => volume_amp_s,   
        Filter_Echo_EN_o      => Filter_Echo_EN_s, 
        Filter_Echo_delay_o   => Echo_delay_s,
        Filter_1_Addaptive_EN_o    => open, 
        Filter_2_Addaptive_EN_o    => open, 
        -- display               
        Display_Title_EN_o         => open, 
        Display_Scope_EN_o         => open, 
        Display_Bars_EN_o          => open 
);


  





end arch;


