LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL; 
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;
use work.Fir_index_package.all;
use work.Package_FPDj.all;
-- to do, need to keep the bar enable for the rest of the image when detected

ENTITY Menu IS  
    generic (
        horiztonal_size      : INTEGER:= 1280;
        vertical_size        : INTEGER:= 1024
    );
   port(
    Clk_i                   : in std_logic;
    Reset_i                 : in std_logic;
    -- FPGA inputs
    BTN_i                   : in std_logic_vector (4 downto 0);
    SW_i                    : in  std_logic_vector (15 downto 0);
   
    -- fpga outputs
    LED                     : out std_logic_vector(15 downto 0);    
    SSEG_CA 		        : out  STD_LOGIC_VECTOR (7 downto 0);
    SSEG_AN 		        : out  STD_LOGIC_VECTOR (7 downto 0);
    
    -- user interface
    enable_sound_o          : out std_logic;
);
END Menu;

ARCHITECTURE behavior OF Menu IS
 
  signal BTN_debounce_s     : std_logic_vector (4 downto 0);
  signal BTN_debounce_delay_s : std_logic_vector (4 downto 0);
  signal BTN_Rising_edge_s : std_logic_vector (4 downto 0);
  
  
  type sub_menu is (Demarrage, menu_0, menu_0_1, menu_1, menu_2);
  signal active_menu :sub_menu;  
  
  -- registers
 -- affichage 7 segments
 signal Demarrage_Display_title_s   : std_logic; 
 -- actions
 signal enable_sound_s       : std_logic;
 
 
 
 
 
 
  
  begin
  -- outputs
  enable_sound_o <=enable_sound_s;
  
  
  
  
  
  active_menu <= menu_0_1 when (SW_i(15)='1'and  SW_i(14)='1') else  
                 menu_0 when SW_i(15)='1' else                
                 menu_1 when SW_i(14)='1' else
                 Demarrage ;
  
  

     
process( Clk_i , Reset_i) 
begin
    if Reset_i='1' then
        Demarrage_Display_title_s  <= '0';
        menu_0_enable_sound_s      <= '0';  
    elsif rising_edge (Clk_i) then       
        Demarrage_Display_title_s <='0';
         enable_sound_s      <= '1';
        if active_menu=Demarrage then
            Demarrage_Display_title_s   <='1';
            enable_sound_s              <= '0';
        elsif active_menu=menu_0 then
            enable_sound_s      <= '1';        
        end if;  
     
    end if;
    
    
end process;
  
  
  
  
  with affichage_s select
	SSEG_CA <=    "11000000" when "0000", -- 0
				  "11111001" when "0001", -- 1
				  "10100100" when "0010",  --2
				  "10110000" when "0011",  --3
				  "10011001" when "0100",  --4
				  "10010010" when "0101",  --5
				  "10000010" when "0110",  --6
				  "11111000" when "0111",  --7
				  "10000000" when "1000",  --8
				  "10010000" when "1001",  --9
				  "11111111" when others;

  
  
  constant seg_0_s : std_logic_vector (7 downto 0):= "11000000"; -- 0
  constant seg_1_s : std_logic_vector (7 downto 0):= "11111001"; -- 1
  constant seg_2_s : std_logic_vector (7 downto 0):= "10100100";  --2
  constant seg_3_s : std_logic_vector (7 downto 0):= "10110000";  --3
  constant seg_4_s : std_logic_vector (7 downto 0):= "10011001";  --4
  constant seg_5_s : std_logic_vector (7 downto 0):= "10010010";  --5
  constant seg_6_s : std_logic_vector (7 downto 0):= "10000010";  --6
  constant seg_7_s : std_logic_vector (7 downto 0):= "11111000";  --7
  constant seg_8_s : std_logic_vector (7 downto 0):= "10000000";  --8
  constant seg_9_s : std_logic_vector (7 downto 0):= "10010000";  --9
  
   
  
  
  
  
  
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
            CLK_I => Clk_i,
            SIGNAL_O => BTN_debounce_s(i downto i)
        );

        
        
    process ( Clk_i)
    begin
        if rising_edge (Clk_i) then
            BTN_debounce_delay_s(i) <= BTN_debounce_s(i);
            if BTN_debounce_s(i)='0'and BTN_debounce_delay_s(i) ='1' then
                BTN_Rising_edge_s (i) <='1';
            else
                BTN_Rising_edge_s (i) <='0';
            end if;
        end if;
   end process;
end generate;
   
   









END behavior;
