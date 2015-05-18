
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL; 
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;
use work.Fir_index_package.all;
use work.Package_FPDj.all;
library xil_defaultlib;

entity FFT_Manager is
generic (
        FFT_depth: integer:= 8192
    );
port(
    Clk_i                               : in std_logic;
    Reset_i                             : in std_logic;
    -- FFT interface
    FFT_DataReady_i                     : in std_logic;
    FFT_DataValid_o                     : out std_logic;
    FFT_DataLast_o                      : out std_logic;
    FFT_Frame_start_i                   : in std_logic;
    -- Audio interface   
    Audio_Data_Valid_i                  : in std_logic   
);
end FFT_Manager;

architecture behevioral of FFT_Manager is
  
  
type state_machine is (Idle, senddata, waitFrame,wait_to_start);
signal state            : state_machine;
signal data_counter_s   : std_logic_vector (31 downto 0);
signal FFT_DataValid_s: std_logic;


begin
 
process ( Clk_i, Reset_i)
begin
    if Reset_i='1' then
        state           <= Idle;    
        data_counter_s  <= (others=>'0');             
        FFT_DataValid_s <= '0';     
    elsif rising_edge(Clk_i) then
        case state is
            when Idle =>
                data_counter_s <= (others=>'0');    
                if FFT_DataReady_i ='1' then 
                    state <= wait_to_start;  
                end if;
            when wait_to_start =>
                data_counter_s  <= data_counter_s +1; 
                if data_counter_s = 100 then
                   data_counter_s  <= (others=>'0');   
                    state <= waitFrame;                      
                end if;     
               
            when waitFrame => 
                FFT_DataValid_s <= Audio_Data_Valid_i;  
                if FFT_DataReady_i ='1' and FFT_DataValid_s='1' then                        
                    data_counter_s  <= (others=>'0'); 
                    state <= senddata;  
                end if;
            when senddata =>  
                FFT_DataValid_s <= Audio_Data_Valid_i;     
                if FFT_DataReady_i ='1' and FFT_DataValid_s='1' then            
                    FFT_DataValid_s <= Audio_Data_Valid_i;         
                    if data_counter_s = FFT_depth then
                       data_counter_s  <= (others=>'0');        
                       
                    else
                        data_counter_s <= data_counter_s+1;
                      
                    end if;
                end if;
            when others=>
                state <= Idle;               
        end case;        
    end if;
end process;

FFT_DataLast_o <= '1' when data_counter_s = FFT_depth else '0';
FFT_DataValid_o <= FFT_DataValid_s;
end behevioral;