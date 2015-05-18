--Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2014.4 (win64) Build 1071353 Tue Nov 18 18:24:04 MST 2014
--Date        : Fri May 01 15:59:18 2015
--Host        : RagingZen-PC running 64-bit Service Pack 1  (build 7601)
--Command     : generate_target test_pmod_audio_design_wrapper.bd
--Design      : test_pmod_audio_design_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
USE IEEE.STD_LOGIC_1164.ALL; 
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity echo_filter is
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
end echo_filter;

architecture STRUCTURE of echo_filter is


component fifo_generator_0 IS  
    PORT (
    clk         : IN STD_LOGIC;
    rst         : IN STD_LOGIC;
    din         : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
    wr_en       : IN STD_LOGIC;
    rd_en       : IN STD_LOGIC;
    dout        : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
    full        : OUT STD_LOGIC;
    empty       : OUT STD_LOGIC;
    data_count  : OUT STD_LOGIC_VECTOR(12 DOWNTO 0)
  );
END component;
  


signal FIFO_Data_out_s      : STD_LOGIC_VECTOR(11 DOWNTO 0);
signal feedback_sound_s     : STD_LOGIC_VECTOR(11 DOWNTO 0);
signal FIFO_Read_EN_s       : std_logic;
signal data_count_s         : STD_LOGIC_VECTOR(12 DOWNTO 0);



begin
 
 --================
 echo_fifo: fifo_generator_0
 --===============
    PORT MAP (
    clk         => Clk_i,           
    rst         => Reset_i,          
    din         => feedback_sound_s,        
    wr_en       => Enable_i,          
    rd_en       => FIFO_Read_EN_s,           
    dout        => FIFO_Data_out_s,         
    full        => open,           
    empty       => open,          
    data_count  => data_count_s       
  );

 
  FIFO_Read_EN_s <= '1' when data_count_s>=Delay and Enable_i='1' else '0';
  
Process (Clk_i, Reset_i)
    begin
        if Reset_i ='1' then
            feedback_sound_s <= (others => '0');
        elsif rising_edge(Clk_i) then
            feedback_sound_s<= Audio_i + ('0' & FIFO_Data_out_s(10 downto 0)); -- 0.25* FIFO_Data_out_s
            Audio_o <=  "0000" & Audio_i + ("00000" & FIFO_Data_out_s(10 downto 0));
        end if;      
    end process;
  
  

  
  
end STRUCTURE;
