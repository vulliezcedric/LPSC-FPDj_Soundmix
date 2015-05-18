LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL; 
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;
use work.Fir_index_package.all;
use work.Package_FPDj.all;
-- to do, need to keep the bar enable for the rest of the image when detected

ENTITY vga_Manager IS  
    generic (
        horiztonal_size      : INTEGER:= 1280;
        vertical_size        : INTEGER:= 1024
    );
   port(
    Clk_i                       : in std_logic;
    Reset_i                     : in std_logic;
    -- user interface
    Bar_intensity_i             : in  BarIndex_intensity_array;
    Data_Ready_i                : in std_logic;
    --  VGA interface
    column_i                    : in  INTEGER;    --horizontal pixel coordinate
    row_i                       : in  INTEGER;    --vertical pixel coordinate
    h_sync_i                    : in std_logic;
    v_sync_i                    : in std_logic;
    Display_EN_i                : in std_logic;
    -- VGA output
    VGA_Red_o                   : out std_logic_vector (3 downto 0);
    VGA_Green_o                 : out std_logic_vector (3 downto 0);
    VGA_Blue_o                  : out std_logic_vector (3 downto 0);
    VGA_h_sync_o                : out std_logic;
    VGA_v_sync_o                : out std_logic
);
END vga_Manager;

ARCHITECTURE behavior OF vga_Manager IS
 
 
  
-- cut the horizontal pixels into the number of bars wanted 
constant Bars_Horizontal_length : integer:= horiztonal_size/Nbbars_C;
constant Bars_Horizontal_gap : integer:= 10; -- in pixels

constant Bars_starting_bit_intensity :integer:=32; 
constant Bars_lowerbits_removed :integer:=4;

-- takes half the screen and put 30 bars
constant Bars_Starting_Row : integer:= vertical_size/2;
constant Title_starting_row : integer:= 40;
constant Bars_vertical_length : integer:= Bars_Starting_Row/((Bars_starting_bit_intensity-Bars_lowerbits_removed+1));
constant Bars_vertical_gap : integer:= 5; -- in pixels


-- for simulation
-- constant Bars_Starting_Row : integer:= 5; -- for simulation
-- constant Bars_vertical_length : integer:= 5;
-- constant Bars_vertical_gap : integer:= 2; -- in pixels
 
 
signal Next_active_color_Red                : std_logic_vector (3 downto 0);
signal Next_active_color_Green              : std_logic_vector (3 downto 0);
signal Next_active_color_Blue               : std_logic_vector (3 downto 0);
signal active_color_Red                     : std_logic_vector (3 downto 0);
signal active_color_Green                   : std_logic_vector (3 downto 0);
signal active_color_Blue                    : std_logic_vector (3 downto 0);
    
signal Bar_display_enable                   : std_logic;

signal Bar_horizontal_counter_s             : std_logic_vector (7 downto 0);
signal Bar_vertical_counter_s               : std_logic_vector (7 downto 0);
signal Bar_selector_vertical_counter_s      : std_logic_vector (7 downto 0);
signal Bar_selector_horizontal_counter_s    : std_logic_vector (7 downto 0);    
 
signal hsync_delay_s                        : std_logic;
signal hsync_rising_edge_s                  : std_logic;         
     
type state_machine is (idle, display_bar, display_title); 
signal state: state_machine;
signal colorincrement_enable : std_logic;

signal bar_vector_enable : std_logic_vector (Nbbars_C-1 downto 0);


type ColorStateMachine is (Red_to_yellow, yellow_to_green, Wait_end_frame);
signal colorState : ColorStateMachine;

signal title_counter : std_logic_vector(15 downto 0);
signal Title_enable : std_logic;
 signal Title_pixels  : std_logic_vector(11 downto 0);
BEGIN

process( Clk_i , Reset_i) 
begin
    if Reset_i='1' then
       Title_pixels <= (others=>'0');
    elsif rising_edge (Clk_i) then
        if  Title_enable='1' then
            --Title_pixels<= FPDJ_Title(conv_integer(Title_counter));
            Title_pixels  <= (others=>'0');
         else
            Title_pixels <= Title_pixels;
        end if;
    end if;
end process;
    
VGA_Red_o       <=  Title_pixels (11 downto 8) when Title_enable='1'                else                    
                    active_color_Red          when Bar_display_enable ='1'        else 
                    (others=>'0');
                    
VGA_Green_o     <=  Title_pixels(7 downto 4) when Title_enable='1'               else                    
                    active_color_Green       when Bar_display_enable ='1'        else 
                    (others=>'0');  
                    
VGA_Blue_o       <= Title_pixels(3 downto 0) when Title_enable='1'               else                    
                    active_color_Blue        when Bar_display_enable ='1'         else 
                    (others=>'0');   
    
      

VGA_h_sync_o    <= h_sync_i; 
VGA_v_sync_o    <= v_sync_i;            


process( Clk_i , Reset_i) 
begin
    if Reset_i='1' then
        active_color_Green  <= x"0";
        active_color_Red    <= x"f";
        active_color_Blue   <= x"0";
    elsif rising_edge (Clk_i) then
        case colorState is
        
            when Red_to_yellow =>
            
                if colorincrement_enable ='1' then
                    active_color_Green <= active_color_Green +1;
                    active_color_Red    <= active_color_Red;
                    active_color_Blue   <= active_color_Blue;
                    if active_color_Green=x"f" then
                        active_color_Green <= x"f";
                        active_color_Red    <= active_color_Red-1;
                        active_color_Blue   <= active_color_Blue;
                        colorState <= yellow_to_green;
                    end if;                
                end if;    
            when yellow_to_green =>
                if colorincrement_enable ='1' then
                    active_color_Green <= active_color_Green;
                    active_color_Red    <= active_color_Red-1;
                    active_color_Blue   <= active_color_Blue;
                    if active_color_Red=x"0" then
                        active_color_Green <= x"f";
                        active_color_Red    <= active_color_Red;
                        active_color_Blue   <= active_color_Blue;
                        colorState <= Wait_end_frame;
                    end if;
                end if;
            when Wait_end_frame =>        
                if v_sync_i='1' then
                    colorState <= Red_to_yellow;  
                    active_color_Green  <= x"0";
                    active_color_Red    <= x"f";
                    active_color_Blue   <= x"0";
                end if;
            when others=>
                colorState <= Red_to_yellow;  
                active_color_Green  <= x"0";
                active_color_Red    <= x"f";
                active_color_Blue   <= x"0";    

        end case;         
        if v_sync_i='1' then
                    colorState <= Red_to_yellow;  
                    active_color_Green  <= x"0";
                    active_color_Red    <= x"f";
                    active_color_Blue   <= x"0";
                end if;            
    end if;
end process;

process( Clk_i , Reset_i) 
begin
    if Reset_i='1' then
        hsync_delay_s   <='0';
        hsync_rising_edge_s      <='0';
    elsif rising_edge (Clk_i) then
        hsync_delay_s <= h_sync_i;
        if h_sync_i='1' and hsync_delay_s='0' then
          hsync_rising_edge_s        <='1';
        else
            hsync_rising_edge_s      <='0';
        end if;
        
    end if;
end process;






process( Clk_i , Reset_i) 
begin
    if Reset_i='1' then      
    
        Bar_horizontal_counter_s            <= (others=>'0');
        Bar_vertical_counter_s              <= (others=>'0');
        Bar_selector_vertical_counter_s     <= (others=>'0');
        Bar_selector_horizontal_counter_s   <= (others=>'0');
        Bar_display_enable                  <='0';
        bar_vector_enable                   <= (others=>'0');   
        colorincrement_enable               <='0';     
        Title_counter                       <= (others=>'0'); 
        Title_enable                        <= '0';
    elsif rising_edge (Clk_i) then    
        colorincrement_enable <='0';    
        case state is       
            when idle =>
                if row_i= Title_starting_row then               
                    if Display_EN_i='1' then
                        state           <= display_title;                       
                       -- Title_enable    <='1';
                    end if;
                end if;
            when  display_title =>
                -- if Display_EN_i='1' then                        
                    -- Title_enable <='1';
                    -- Title_counter <= Title_counter+1;
                -- else
                    -- Title_enable <='0';
                -- end if;        
       
                -- waits to be at a starting row before beginning
                if row_i=Bars_Starting_Row then
                    state                               <= display_bar;
                    Bar_horizontal_counter_s            <= (others=>'0');
                    Bar_selector_horizontal_counter_s   <= (others=>'0');
                    Bar_vertical_counter_s              <= (others=>'0');
                    bar_vector_enable                   <= (others=>'0');
                    Title_enable                        <= '0'; 
                    Title_counter                       <= (others=>'0');     
                    Bar_selector_vertical_counter_s     <= (others=>'0');                    
                end if;
            when display_bar =>
                if Display_EN_i='1' then
                    
                    Bar_horizontal_counter_s <= Bar_horizontal_counter_s+1; -- increment the column sub-counter
                    
                    
                    if Bar_horizontal_counter_s <=  (Bars_Horizontal_length -Bars_Horizontal_gap) then -- in the bar
                        -- the bar needs to be displayed
                        if ((Bar_intensity_i(conv_integer(Bar_selector_vertical_counter_s))(Bars_starting_bit_intensity-conv_integer(Bar_selector_horizontal_counter_s(Bar_selector_horizontal_counter_s'high downto 0)))='1')  or( bar_vector_enable(conv_integer(Bar_selector_vertical_counter_s))='1') or( (Bar_intensity_i(conv_integer(Bar_selector_vertical_counter_s))(34 downto Bars_starting_bit_intensity)/=0  ))) then -- enough intensity  
                            
                            Bar_display_enable <='1'; 
                            bar_vector_enable(conv_integer(Bar_selector_vertical_counter_s)) <= '1';
                        else
                            Bar_display_enable <='0'; 
                        end if;
                    
                    else   -- in the gap
                        Bar_display_enable <='0'; 
                        if Bar_horizontal_counter_s = Bars_Horizontal_length-1 then -- at the limit of the current bar, we pass on the next
                            if Bar_selector_vertical_counter_s /=Nbbars_C-1 then
                                Bar_selector_vertical_counter_s     <= Bar_selector_vertical_counter_s+1;
                            end if;
                            Bar_horizontal_counter_s            <= (others=>'0');  
                        end if;
                        
                        -- if the last Bar is reached and we are in the gap, we pass directly to idle, to avoid pixels at edge
                        if Bar_selector_vertical_counter_s=Nbbars_C-1 then
                            Bar_horizontal_counter_s <= Bar_horizontal_counter_s;
                           -- state               <= idle;
                            Bar_display_enable  <='0'; 
                        end if;
                    end if;
                else
                    Bar_horizontal_counter_s            <= (others=>'0');
                    --Bar_vertical_counter_s              <= (others=>'0');
                     Bar_display_enable <='0'; 
                end if;
                
                -- passing in another row
                if hsync_rising_edge_s ='1' then   
                    Bar_selector_vertical_counter_s    <= (others=>'0');               
                    Bar_vertical_counter_s <= Bar_vertical_counter_s+1;
                    if Bar_vertical_counter_s = Bars_vertical_length then
                        Bar_display_enable      <='0'; 
                        Bar_vertical_counter_s  <= (others=>'0');
                        if Bar_selector_horizontal_counter_s<= Bars_starting_bit_intensity -Bars_lowerbits_removed then
                            Bar_selector_horizontal_counter_s <= Bar_selector_horizontal_counter_s +1;
                         else -- reached the last row of the bars to display
                            Bar_display_enable <='0'; 
                        end if;
                        colorincrement_enable <='1';
                    end if;   
                end if;
                if  Bar_vertical_counter_s >= (Bars_vertical_length - Bars_vertical_gap) then
                        Bar_display_enable <='0'; 
                end if;
                if v_sync_i='1' then
                    state   <= idle;
                     Bar_display_enable <='0'; 
                    title_counter <=(others=>'0');
                end if;
            when others=>
                state   <= idle;
        end case;
    end if;
end process;



END behavior;
