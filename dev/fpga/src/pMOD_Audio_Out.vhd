
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity Speakerctrl is
    Port ( clk      : in  STD_LOGIC;
           rst      : in  STD_LOGIC;
       --audio_in : in STD_LOGIC_VECTOR(15 downto 0);
           audio_in : in STD_LOGIC_VECTOR(7 downto 0);
           done     : out std_logic;
           SDOUT    : out  STD_LOGIC;
           SCLK     : out  STD_LOGIC;
           MCLK     : out  STD_LOGIC;
           LRCK     : out  STD_LOGIC);
end Speakerctrl;

architecture Behavioral of Speakerctrl is

signal div_cnt: unsigned(9 downto 0);  -- 50 MHZ / 8K 
signal shift_reg_load: std_logic;
signal shift_reg_en: std_logic;
signal shift_reg: std_logic_vector(15 downto 0);  -- 50 MHZ / 8K 

begin

------------------------------------    
---------- serial transmission -----
------------------------------------

-- generate LRCK and MCLK

    process(clk)
    begin
        if rising_edge(clk) then
            if rst='1' then
                div_cnt<= (others=>'0');
            else
                div_cnt<= div_cnt + 1;
            end if;
        end if;
    end process;
    
    MCLK <= div_cnt(3);   -- 50MHz / 16
    LRCK <= div_cnt(9);    -- 50MHz / 1024
    
    shift_reg_load <= '1' when div_cnt(8 downto 0) = 0 
                            else '0';

    done <= shift_reg_load;
    shift_reg_en <= '1' when div_cnt(4 downto 0) = 0 
                            else '0';
    SCLK <= div_cnt(4);
    
    SDOUT <= shift_reg(15);
    
    process(clk)
    begin
        if rising_edge(clk) then
            if rst='1' then
                shift_reg<= (others=>'0');
            elsif shift_reg_load = '1' then
                --shift_reg(15 downto 8) <= std_logic_vector(unsigned(audio_in)+128);
                shift_reg(15 downto 8) <= std_logic_vector(unsigned(audio_in));
                shift_reg(7 downto 0) <= (others => '0');
            elsif    shift_reg_en = '1' then
                shift_reg <= shift_reg(14 downto 0) & '0'; 
            end if;
        end if;
    end process;
    
end Behavioral;
