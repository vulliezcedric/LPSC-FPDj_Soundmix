
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL; 
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;
use work.Fir_index_package.all;
use work.Package_FPDj.all;

entity Intensity_Bands_Format is
port(
    Clk_i                               : in std_logic;
    Reset_i                             : in std_logic;      
    Bar_intensity_i                     : in  BarIndex_intensity_array;
    Data_Ready_i                        : in std_logic;
    Bar_intensity_o                     : out  BarIndex_intensity_array;
    Data_Ready_o                        : out std_logic    
);
end Intensity_Bands_Format;

architecture behevioral of Intensity_Bands_Format is


signal Bar_intensity_s                      : BarIndex_intensity_array;
signal bar_scaled                           : BarIndex_intensity_array;
signal Bar_intensity_Average_s             : BarIndex_intensity_array;
constant BarIntensity_PipeLength: integer:= 24;
type Bar_intensity_array is array (0 to BarIntensity_PipeLength-1) of BarIndex_intensity_array;
signal Bar_intensity_pipe : Bar_intensity_array;
signal Bar_intensity_counter_s: std_logic_vector (9 downto 0);
signal Data_Ready_s: std_logic;
constant bit_high_C : integer:= 28;
constant bit_noise_C : integer:= 17;

--type contstant_table_array is array ( 0 to 29 ) of std_logic_vector(bit_high_C downto bit_noise_C);

-- constant intensity_add_C :contstant_table_array:=(
-- (bit_high_C=>'1', bit_high_C-1=>'1', others=>'0'),
-- (bit_high_C=>'1', bit_high_C-1=>'0', others=>'0'),
-- (bit_high_C-1=>'1', bit_high_C-2=>'1', others=>'0'),
-- (bit_high_C-1=>'1', bit_high_C-2=>'0', others=>'0'),
-- (bit_high_C-2=>'1', bit_high_C-3=>'1', others=>'0'),
-- (bit_high_C-2=>'1', bit_high_C-3=>'0', others=>'0'),
-- (bit_high_C-3=>'1', bit_high_C-4=>'1', others=>'0'),
-- (bit_high_C-3=>'1', bit_high_C-4=>'0', others=>'0'),
-- (bit_high_C-4=>'1', bit_high_C-5=>'1', others=>'0'),
-- (bit_high_C-4=>'1', bit_high_C-5=>'0', others=>'0'),
 -- (bit_high_C-5=>'1', bit_high_C-6=>'1', others=>'0'),
 -- (bit_high_C-5=>'1', bit_high_C-6=>'0', others=>'0'),
 -- (bit_high_C-6=>'1', bit_high_C-7=>'1', others=>'0'),
 -- (bit_high_C-6=>'1', bit_high_C-7=>'0', others=>'0'),
 -- (bit_high_C-7=>'1', bit_high_C-8=>'1', others=>'0'),
 -- (bit_high_C-7=>'1', bit_high_C-8=>'0', others=>'0'),

 -- (bit_high_C-8=>'1', bit_high_C-9=>'1', others=>'0'),
 -- (bit_high_C-8=>'1', bit_high_C-9=>'0', others=>'0'),
 -- (bit_high_C-9=>'1', bit_high_C-10=>'1', others=>'0'),
 -- (bit_high_C-9=>'1', bit_high_C-10=>'0', others=>'0'),
 -- (bit_high_C-10=>'1', bit_high_C-11=>'1', others=>'0'),
 -- (bit_high_C-10=>'1', bit_high_C-11=>'0', others=>'0'),
 -- (bit_high_C-11=>'1', bit_high_C-12=>'1', others=>'0'),
 -- (bit_high_C-11=>'1', bit_high_C-12=>'0', others=>'0'),
 -- (bit_high_C-12=>'1', bit_high_C-13=>'1', others=>'0'),
 -- (bit_high_C-12=>'1', bit_high_C-13=>'0', others=>'0'),
 -- (bit_high_C-13=>'1', bit_high_C-14=>'1', others=>'0'),
 -- (bit_high_C-13=>'1', bit_high_C-14=>'0', others=>'0'),
 -- (bit_high_C-14=>'1', bit_high_C-15=>'1', others=>'0'),
 -- (bit_high_C-14=>'1', bit_high_C-15=>'0', others=>'0')
-- );








begin



-- Bar_scaling: for i in 0 to Nbbars_C-1 generate
-- begin
-- bar_scaled(i)<= (30=>'1', others=>'0') when Bar_intensity_s(i)(bit_high_C downto bit_noise_C)=intensity_add_C(0) else
                -- (29=>'1', others=>'0') when Bar_intensity_s(i)(bit_high_C downto bit_noise_C)=intensity_add_C(1) else
                -- (28=>'1', others=>'0') when Bar_intensity_s(i)(bit_high_C downto bit_noise_C)=intensity_add_C(2) else
                -- (27=>'1', others=>'0') when Bar_intensity_s(i)(bit_high_C downto bit_noise_C)=intensity_add_C(3) else
                -- (26=>'1', others=>'0') when Bar_intensity_s(i)(bit_high_C downto bit_noise_C)=intensity_add_C(4) else
                -- (25=>'1', others=>'0') when Bar_intensity_s(i)(bit_high_C downto bit_noise_C)=intensity_add_C(5) else
                -- (24=>'1', others=>'0') when Bar_intensity_s(i)(bit_high_C downto bit_noise_C)=intensity_add_C(6) else
                -- (23=>'1', others=>'0') when Bar_intensity_s(i)(bit_high_C downto bit_noise_C)=intensity_add_C(7) else
                -- (22=>'1', others=>'0') when Bar_intensity_s(i)(bit_high_C downto bit_noise_C)=intensity_add_C(8) else
                -- (21=>'1', others=>'0') when Bar_intensity_s(i)(bit_high_C downto bit_noise_C)=intensity_add_C(9) else
                -- (20=>'1', others=>'0') when Bar_intensity_s(i)(bit_high_C downto bit_noise_C)=intensity_add_C(10) else
                -- (19=>'1', others=>'0') when Bar_intensity_s(i)(bit_high_C downto bit_noise_C)=intensity_add_C(11) else
                -- (18=>'1', others=>'0') when Bar_intensity_s(i)(bit_high_C downto bit_noise_C)=intensity_add_C(12) else
                -- (17=>'1', others=>'0') when Bar_intensity_s(i)(bit_high_C downto bit_noise_C)=intensity_add_C(13) else
                -- (16=>'1', others=>'0') when Bar_intensity_s(i)(bit_high_C downto bit_noise_C)=intensity_add_C(14) else
                -- (15=>'1', others=>'0') when Bar_intensity_s(i)(bit_high_C downto bit_noise_C)=intensity_add_C(15) else
                -- (14=>'1', others=>'0') when Bar_intensity_s(i)(bit_high_C downto bit_noise_C)=intensity_add_C(16) else
                -- (13=>'1', others=>'0') when Bar_intensity_s(i)(bit_high_C downto bit_noise_C)=intensity_add_C(17) else
                -- (12=>'1', others=>'0') when Bar_intensity_s(i)(bit_high_C downto bit_noise_C)=intensity_add_C(18) else
                -- (11=>'1', others=>'0') when Bar_intensity_s(i)(bit_high_C downto bit_noise_C)=intensity_add_C(19) else
                -- (10=>'1', others=>'0') when Bar_intensity_s(i)(bit_high_C downto bit_noise_C)=intensity_add_C(20) else
                -- (9=>'1', others=>'0') when Bar_intensity_s(i)(bit_high_C downto bit_noise_C)=intensity_add_C(21) else
                -- (8=>'1', others=>'0') when Bar_intensity_s(i)(bit_high_C downto bit_noise_C)=intensity_add_C(22) else
                -- (7=>'1', others=>'0') when Bar_intensity_s(i)(bit_high_C downto bit_noise_C)=intensity_add_C(23) else
                -- (6=>'1', others=>'0') when Bar_intensity_s(i)(bit_high_C downto bit_noise_C)=intensity_add_C(24) else
                -- (5=>'1', others=>'0') when Bar_intensity_s(i)(bit_high_C downto bit_noise_C)=intensity_add_C(25) else
                -- (4=>'1', others=>'0') when Bar_intensity_s(i)(bit_high_C downto bit_noise_C)=intensity_add_C(26) else
                -- (3=>'1', others=>'0') when Bar_intensity_s(i)(bit_high_C downto bit_noise_C)=intensity_add_C(27) else
                -- (2=>'1', others=>'0') when Bar_intensity_s(i)(bit_high_C downto bit_noise_C)=intensity_add_C(28) else
                -- (1=>'1', others=>'0') when Bar_intensity_s(i)(bit_high_C downto bit_noise_C)=intensity_add_C(29) else
                -- (others=>'0');
-- end generate;

-- add multiple Bar intensity through time and reduce how many times it's updated
process ( Clk_i, Reset_i)
begin
    if Reset_i='1' then
        for i in 0 to BarIntensity_PipeLength-1 loop            
            Bar_intensity_pipe (i) <= BarIndex_intensity_Reset_c;
        end loop;
        Data_Ready_s <='0';
        Bar_intensity_s <=BarIndex_intensity_Reset_c;
        Bar_intensity_counter_s <= (others=>'0');
    elsif rising_edge(Clk_i) then
        Data_Ready_s <='0';
        if Data_Ready_i='1' then
            -- Bar_intensity_pipe (0) <= Bar_intensity_i;            
            for i in 1 to BarIntensity_PipeLength-1 loop            
                for j in 0 to Nbbars_C/2 loop                
                    Bar_intensity_pipe (0)(j)(34 downto bit_noise_C) <= Bar_intensity_i(j)(34 downto bit_noise_C);
                    Bar_intensity_pipe (i)(j) <=  Bar_intensity_pipe (i-1)(j) +Bar_intensity_i(j)(34 downto bit_noise_C);
                end loop; 

                for j in (Nbbars_C/2)+1 to Nbbars_C-1 loop           
                    Bar_intensity_pipe (0)(j)(34 downto bit_noise_C-2) <= Bar_intensity_i(j)(34 downto bit_noise_C-2);
                    Bar_intensity_pipe (i)(j) <=  Bar_intensity_pipe (i-1)(j) +Bar_intensity_i(j)(34 downto bit_noise_C-2);
                end loop; 
                
            end loop;
            
            if Bar_intensity_counter_s(1) ='1' then
                Bar_intensity_s <=Bar_intensity_pipe(BarIntensity_PipeLength-1);
                Bar_intensity_counter_s <= (others=>'0');
                Data_Ready_s <='1';
            else
                Bar_intensity_counter_s <=Bar_intensity_counter_s+1;                
            end if;   
            
        end if;        
    end if;
end process;

-- process and format the bars. Removes unwanted noise bits and scale for 30 bars

process ( Clk_i, Reset_i)
begin
    if Reset_i='1' then
        Bar_intensity_o <= BarIndex_intensity_Reset_c;
        Data_Ready_o  <='0';    
    elsif rising_edge(Clk_i) then
        Data_Ready_o  <='0';    
        if Data_Ready_s='1' then
            --Bar_intensity_o <= bar_scaled;
            for j in 0 to Nbbars_C-1 loop           
                Bar_intensity_Average_s(j) <=Bar_intensity_Average_s(j)(Bar_intensity_Average_s(j)'high downto 1) +Bar_intensity_s(j)(Bar_intensity_s(j)'high downto 1);                   
            end loop;
           
            Bar_intensity_o <=Bar_intensity_s;
            Data_Ready_o  <='1';
        end if;
        
    end if;
end process;

end behevioral;