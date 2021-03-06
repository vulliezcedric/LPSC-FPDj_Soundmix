
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL; 
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;
use work.Fir_index_package.all;
use work.Package_FPDj.all;

entity Intensity_Bands_Extraction is
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
end Intensity_Bands_Extraction;

architecture behevioral of Intensity_Bands_Extraction is

type state_machine is (IDLE, Intensity_Acc,Wait_end_of_frame);
signal State: state_machine;

signal Intensity_Threshold_s                : std_logic_vector (15 downto 0);    
signal Intensity_accumulator_s              : std_logic_vector(34 downto 0); -- must be high enough not to have an overflow
signal Bar_intensity_s                      : BarIndex_intensity_array;
signal BarCounter_s                         : std_logic_vector (5 downto 0);
begin




process (Clk_i, Reset_i)
begin

    if Reset_i='1' then
        State                   <= IDLE; 
        Intensity_accumulator_s <= (others=>'0');
        BarCounter_s            <= (others=>'0');
        Intensity_Threshold_s   <= (others=>'0'); 
        for i in 0 to Nbbars_C-1 loop
            Bar_intensity_s (i) <= (others=>'0');
            Bar_intensity_o (i) <= (others=>'0');
        end loop;
         Data_Ready_o           <='0';
    elsif rising_edge(Clk_i) then
        Data_Ready_o    <='0';
        case State is
        
            when IDLE =>
                BarCounter_s            <= (others=>'0');
                if Frame_start_i='1' then
                    Intensity_accumulator_s <= (others=>'0');
                    BarCounter_s            <= (others=>'0');
                    Intensity_Threshold_s   <= FIR_Index_to_Bar(0);
                    State                   <= intensity_Acc; 
                end if;
            when intensity_Acc=>
                -- only increment if the data is valid
                if Frame_Data_valid_i='1' then                   
                    
                    if Frame_Index_i = Intensity_Threshold_s  then
                        if BarCounter_s<Nbbars_C -1 then 
                         Intensity_Threshold_s   <= FIR_Index_to_Bar(conv_integer (BarCounter_s+1));                 -- loads the next ThresHold
                        end if;
                        
                        if BarCounter_s<=Nbbars_C -1 then
                            Bar_intensity_s (conv_integer (BarCounter_s)) <= Intensity_accumulator_s + Frame_Data_i(31 downto 10);    -- Saves the Accumulator high part
                            Intensity_accumulator_s <= (others=>'0');                                                 -- Resets the Accumulator                                             
                            BarCounter_s            <= BarCounter_s +1;                                                -- increment the Array Index                                          
                        end if;
                        
                    else
                        if Frame_Index_i> x"0003" then -- don't record the 3 lower frequencies
                            Intensity_accumulator_s <= Intensity_accumulator_s + Frame_Data_i(31 downto 10);                          -- Increment the Accumulator
                        end if;
                    end if;
                end if;
                
                if BarCounter_s=Nbbars_C then
                    State           <= Wait_end_of_frame;
                    Bar_intensity_o <= Bar_intensity_s;
                    Data_Ready_o    <='1';
                end if;
            when Wait_end_of_frame =>
                if Frame_end_i ='1' then
                    Intensity_accumulator_s <= (others=>'0');
                    BarCounter_s            <= (others=>'0');
                    Intensity_Threshold_s   <= FIR_Index_to_Bar(0);
                    State                   <= intensity_Acc; 
                end if;
             
            when others =>
                State <= IDLE;
        end case;
        
    
    end if;
end process;



end behevioral;