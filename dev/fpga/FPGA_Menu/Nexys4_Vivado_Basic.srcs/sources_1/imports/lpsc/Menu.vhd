LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL; 
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;
--use work.Fir_index_package.all;
--use work.Package_FPDj.all;
-- to do, need to keep the bar enable for the rest of the image when detected

ENTITY Menu IS  
    
   port(
    Clk_i                   : in std_logic;
    Reset_i                 : in std_logic;
    -- FPGA inputs
    BTN_i                   : in std_logic_vector (4 downto 0);
    SW_i                    : in  std_logic_vector (15 downto 0);
   
    -- fpga outputs
    LED_o                   : out std_logic_vector(15 downto 0);    
    SSEG_CA_o 		        : out  STD_LOGIC_VECTOR (7 downto 0);
    SSEG_AN_o		        : out  STD_LOGIC_VECTOR (7 downto 0)
    
    -- user interface
    --enable_sound_o          : out std_logic
);
END Menu;

ARCHITECTURE behavior OF Menu IS
  signal reset_s                : std_logic;
  signal BTN_debounce_s         : std_logic_vector (4 downto 0);
  signal BTN_debounce_delay_s : std_logic_vector (4 downto 0);
  signal BTN_Rising_edge_s : std_logic_vector (4 downto 0);
  
  signal compteur_7seg  : std_logic_vector (31 downto 0);
  signal next_7seg  	  : std_logic;
  signal SSEG_AN_s 		        : STD_LOGIC_VECTOR (7 downto 0);
  
  
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
  constant seg_A_s : std_logic_vector (7 downto 0):= "10001000"; -- A
  constant seg_C_s : std_logic_vector (7 downto 0):= "11000110"; -- C
  constant seg_D_s : std_logic_vector (7 downto 0):= "10100001"; -- D
  constant seg_E_s : std_logic_vector (7 downto 0):= "10000110"; -- F
  constant seg_F_s : std_logic_vector (7 downto 0):= "10001110"; -- F
  constant seg_H_s : std_logic_vector (7 downto 0):= "10001001"; -- H
  constant seg_J_s : std_logic_vector (7 downto 0):= "11110001";  --J
  constant seg_L_s : std_logic_vector (7 downto 0):= "11000111"; -- L
  constant seg_N_s : std_logic_vector (7 downto 0):= "11001000";  --N
  constant seg_O_s : std_logic_vector (7 downto 0):= "11000000"; -- O
  constant seg_P_s : std_logic_vector (7 downto 0):= "10001100";  --P
  constant seg_S_s : std_logic_vector (7 downto 0):= "10010010";  --S
  constant seg_V_s : std_logic_vector (7 downto 0):= "11000001";  --V
  constant seg_null_s : std_logic_vector (7 downto 0):= "11111111";  -- rien
  
  signal Text_7seg : std_logic_vector ((8*8)-1 downto 0);
  
  type sub_menu is (Demarrage, menu_0, menu_0_1, menu_1, menu_2);
  signal active_menu :sub_menu;  
  
  -- registers
 -- affichage 7 segments
 signal Demarrage_Display_title_s   : std_logic; 
 -- actions
 signal enable_sound_s         : std_logic;
 signal menu_0_enable_sound_s  :std_logic;
 --volume
 signal  volume_amp_s: STD_LOGIC_VECTOR (7 downto 0);
 signal  volume_digits: STD_LOGIC_VECTOR (7 downto 0);
 
component debouncer is
    Generic ( DEBNC_CLOCKS : INTEGER range 2 to (INTEGER'high) := 2**16;
              PORT_WIDTH : INTEGER range 1 to (INTEGER'high) := 5);
    Port ( SIGNAL_I : in  STD_LOGIC_VECTOR ((PORT_WIDTH - 1) downto 0);
           CLK_I : in  STD_LOGIC;
           SIGNAL_O : out  STD_LOGIC_VECTOR ((PORT_WIDTH - 1) downto 0));
end component;
  
  begin
  -- outputs
 -- enable_sound_o <=enable_sound_s;
  
 
  SSEG_AN_o <= SSEG_AN_s;
 
  --LED_o  <= compteur_7seg( 15 downto 0);
  
  Reset_s <= not Reset_i;
  
  active_menu <= menu_0_1 when (SW_i(15)='1'and  SW_i(14)='1') else  
                 menu_0 when SW_i(15)='1' else                
                 menu_1 when SW_i(14)='1' else
				 menu_2 when SW_i(13)='1' else
                 Demarrage ;
  
     
process( Clk_i , Reset_s) 
begin
    if Reset_s='1' then
        Demarrage_Display_title_s  <= '0';
        menu_0_enable_sound_s      <= '0'; 
        Text_7seg <= (others=>'1');        
    elsif rising_edge (Clk_i) then       
        Demarrage_Display_title_s <='0';
        enable_sound_s      <= '1';
        Text_7seg <= (others=>'1');
        if active_menu=Demarrage then
            Demarrage_Display_title_s   <='1';
            Text_7seg <= seg_F_s & seg_P_s & seg_D_s & seg_J_s & seg_null_s & seg_S_s & seg_D_s &seg_null_s;
            enable_sound_s              <= '0';
             LED_o <= (others=>'1');
        elsif active_menu=menu_0 then
            enable_sound_s      <= '1';  
			Text_7seg <= seg_O_s & seg_P_s & seg_null_s & seg_0_s & seg_null_s & seg_S_s & seg_0_s &seg_N_s;
			 LED_o <= SW_i;
		elsif active_menu=menu_1 then
            enable_sound_s      <= '1';  
			Text_7seg <= seg_O_s & seg_P_s & seg_null_s & seg_1_s & seg_E_s & seg_C_s & seg_H_s &seg_O_s;
			 LED_o <= SW_i;
		elsif active_menu=menu_2 then
            enable_sound_s      <= '1';  
			Text_7seg <= seg_V_s & seg_O_s & seg_L_s & seg_null_s & volume_digits & seg_null_s & seg_null_s &seg_null_s;
			LED_o <= SW_i;
        end if;  
     
    end if;
    					
end process;
volume_digits <= seg_0_s when volume_amp_s (3 downto 0)="0000" else 
					 seg_1_s when volume_amp_s (3 downto 0)="0001" else 
					 seg_2_s when volume_amp_s (3 downto 0)="0010" else 
					 seg_3_s when volume_amp_s (3 downto 0)="0011" else 
					 seg_4_s when volume_amp_s (3 downto 0)="0100" else 
					 seg_5_s when volume_amp_s (3 downto 0)="0101" else 
					 seg_6_s when volume_amp_s (3 downto 0)="0110" else 
					 seg_7_s when volume_amp_s (3 downto 0)="0111" else 
					 seg_null_s;

process( Clk_i , Reset_s) 
begin
    if Reset_s='1' then
        compteur_7seg <= (others => '0');
		next_7seg <= '0';
		SSEG_AN_s <= "01111111";
  
    elsif rising_edge (Clk_i) then       
        compteur_7seg <= compteur_7seg + 1;
		if compteur_7seg = 100000 then  -- 1kHz
			compteur_7seg <= (others => '0');
			next_7seg <= '1';
		else 
			next_7seg <= '0';
			
		end if;
		if next_7seg ='1' then 
			 SSEG_AN_s <=  SSEG_AN_s (0) & SSEG_AN_s (7 downto 1);
		end if;
    end if;
    
    
end process;
  
  
 process( Clk_i , Reset_s) 
begin
    if Reset_s='1' then
        SSEG_CA_o  <= (others=>'0');  
    elsif rising_edge (Clk_i) then       
        case SSEG_AN_s(7 downto 0) is
            when "01111111" =>             
                SSEG_CA_o <= Text_7seg(63 downto 56);
            when "10111111" => 
                SSEG_CA_o <= Text_7seg(55 downto 48);
            when "11011111" => 
                SSEG_CA_o <= Text_7seg(47 downto 40);
            when "11101111" => 
                SSEG_CA_o <= Text_7seg(39 downto 32);
            when "11110111" => 
                SSEG_CA_o <= Text_7seg(31 downto 24);    
            when "11111011" => 
                SSEG_CA_o <= Text_7seg(23 downto 16); 
            when "11111101" => 
                SSEG_CA_o <= Text_7seg(15 downto 8);    
            when "11111110" => 
                SSEG_CA_o <= Text_7seg(7 downto 0);      
            when others=>
                SSEG_CA_o <=(others=>'0');
        end case;
    end if;   
end process;
 

    
    
  
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
  
process (Clk_i,Reset_s)
begin
    if Reset_s='1' then
        volume_amp_s <="10000000";
    elsif rising_edge(Clk_i) then
        if BTN_Rising_edge_s(2)='1' and  active_menu=menu_2 then
            volume_amp_s <= volume_amp_s + "00000001";
        elsif BTN_Rising_edge_s(4)='1'and active_menu=menu_2 then
			volume_amp_s <= volume_amp_s - "00000001";

        end if;

    end if;

    

end process;

  
   
   
 

END behavior;
