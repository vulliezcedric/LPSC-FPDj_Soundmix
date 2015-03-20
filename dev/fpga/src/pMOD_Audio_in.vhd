

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity PmodMICRefComp is
  Port    (    
  --General usage
    CLK      : in std_logic;
    RST      : in std_logic;
     
  --Pmod interface signals
    SDATA    : in std_logic;
    SCLK     : out std_logic;
    nCS      : out std_logic;
        
  --User interface signals
    DATA     : out std_logic_vector(11 downto 0);
    START    : in std_logic; 
    DONE     : out std_logic
    
            );

end PmodMICRefComp;

architecture PmodMic of PmodMICRefComp is


type states is (Idle,
                ShiftIn, 
                SyncData);

          signal current_state : states;
          signal next_state    : states;
                     
          signal temp          : unsigned(15 downto 0);
          signal clk_div       : std_logic;      
          signal clk_counter   : unsigned(1 downto 0);    
          signal shiftCounter  : unsigned(3 downto 0) := x"0"; 
          signal enShiftCounter: std_logic;
          signal enParalelLoad : std_logic;
          signal synch_START, started_ok : std_logic;
          signal DATA_s    : std_logic_vector(11 downto 0);

begin

        clock_divide : process(rst,clk)
        begin
            if rst = '1' then
                clk_counter <= "00";
            elsif (clk = '1' and clk'event) then
                clk_counter <= clk_counter + 1;
                     synch_start <= (start or synch_start) and not started_ok;
            end if;
        end process;
          
        clk_div <= clk_counter(1);
        SCLK <=  not clk_counter(1);


counter : process(clk_div, enParalelLoad, enShiftCounter)
        begin
            if (clk_div = '1' and clk_div'event) then
               
                if (enShiftCounter = '1') then 
                   temp <= temp(14 downto 0) & SDATA; 
                    shiftCounter <= shiftCounter + 1;
                elsif (enParalelLoad = '1') then
                   shiftCounter <= "0000";
                  -- DATA <= temp(11 downto 0);
                  --DATA_s <= std_logic_vector(temp-"100000000000");
                  DATA_s <= std_logic_vector(temp(11 downto 0));
                end if;
            end if;
        end process;
        
        DATA <= DATA_s ;
        
-----------------------------------------    
SYNC_PROC: process (clk_div, rst)
   begin
      if (clk_div'event and clk_div = '1') then
         if (rst = '1') then
            current_state <= Idle;
         else
            current_state <= next_state;
         end if;        
      end if;
   end process;
    

-----------------------------------------------------------------------------------        
OUTPUT_DECODE: process (current_state)
   begin
      if current_state = Idle then
            enShiftCounter <='0';
            DONE <='1';
            --nCS <='1';
            nCS <='0';
            enParalelLoad <= '0';
        elsif current_state = ShiftIn then
            enShiftCounter <='1';
            DONE <='0';
            --nCS <='0';
            nCS <='1';
            enParalelLoad <= '0';
        else --if current_state = SyncData then
            enShiftCounter <='0';
            DONE <='0';            
            --nCS <='1';
            nCS <='0';
            enParalelLoad <= '1';
        end if;
   end process;    
    

-----------------------------------------------------------------------------------    
    NEXT_STATE_DECODE: process (current_state, START, shiftCounter)
   begin
      
      next_state <= current_state;  -- default is to stay in current state
      started_ok <= '0';
      case (current_state) is
         when Idle =>
            if synch_START = '1' then
               next_state <= ShiftIn;
            end if;
         when ShiftIn =>
                started_ok <= '1';
            if shiftCounter = 15 then
               next_state <= SyncData;
            end if;
         when SyncData =>
            if START = '0' then
            next_state <= Idle;
            end if;
         when others =>
            next_state <= Idle;
      end case;      
   end process;


end PmodMic;