library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use ieee.std_logic_unsigned.all;
library xil_defaultlib;
use work.Fir_index_package.all;
use work.Package_FPDj.all;


entity Display_TB is

end Display_TB;

architecture behevioral of Display_TB is

 -----------------------------------------------------------------------
  -- Timing constants
  -----------------------------------------------------------------------
  constant CLOCK_PERIOD : time := 5 ns;
  constant T_HOLD       : time := 10 ns;
  constant T_STROBE     : time := CLOCK_PERIOD - (1 ns);

  -- General signals
  signal aclk                           : std_logic := '0';  -- the master clock
 signal Reset_s                         : std_logic := '0'; 
  -----------------------------------------------------------------------
  -- Constants, types and functions to create input data
  -----------------------------------------------------------------------

  constant IP_WIDTH    : integer := 16;
  constant MAX_SAMPLES : integer := 2**14;  -- maximum number of samples in a frame
  type T_IP_SAMPLE is record
    re : std_logic_vector(IP_WIDTH-1 downto 0);
    im : std_logic_vector(IP_WIDTH-1 downto 0);
  end record;
  type T_IP_TABLE is array (0 to MAX_SAMPLES-1) of T_IP_SAMPLE;

  -- Zeroed input data table, for reset and initialization
  constant IP_TABLE_CLEAR : T_IP_TABLE := (others => (re => (others => '0'),
                                                      im => (others => '0')));

  -- Function to generate input data table
  -- Data is a complex sinusoid exp(-jwt) with a frequency 2.6 times the frame size
  -- added to another with a lower magnitude and a higher frequency
  function create_ip_table return T_IP_TABLE is
    variable result : T_IP_TABLE;
    variable theta  : real;
    variable theta2 : real;
    variable theta3: real;
    variable re_real : real;
    variable im_real : real;
    variable re_int : integer;
    variable im_int : integer;
    constant DATA_WIDTH : integer := 14;
  begin
    for i in 0 to MAX_SAMPLES-1 loop
      theta   := real(i) / real(MAX_SAMPLES) * 6.0 * 2.0 * MATH_PI;
      re_real := cos(-theta);
      im_real := sin(-theta);
      theta2  := real(i) / real(MAX_SAMPLES) * 50.0 * 2.0 * MATH_PI;
      theta3  := real(i) / real(MAX_SAMPLES) * 166.0 * 2.0 * MATH_PI;
      re_real := re_real + (cos(-theta2) / 4.0) + (cos(-theta3) / 3.0);
      im_real := im_real + (sin(-theta2) / 4.0);
      re_int  := integer(round(re_real * real(2**(DATA_WIDTH))));
      im_int  := integer(round(im_real * real(2**(DATA_WIDTH))));
      result(i).re := std_logic_vector(to_signed(re_int, IP_WIDTH));
      result(i).im := std_logic_vector(to_signed(im_int, IP_WIDTH));
    end loop;
    return result;
  end function create_ip_table;

  -- Call the function to create the input data
  constant IP_DATA : T_IP_TABLE := create_ip_table;


component Frequency_Analysis_top is
generic (
        ADC_Width: integer:= 12
    );
port(
    Clk_i                               : in std_logic;
    Reset_i                             : in std_logic;
    -- Audio interface
    Audio_Left_Channel_i                : in std_logic_vector (ADC_Width-1 downto 0);
    Audio_Right_Channel_i               : in std_logic_vector (ADC_Width-1 downto 0);
    Audio_Data_Valid_i                  : in std_logic;
    -- user Interface
    Bar_intensity_o                     : out  BarIndex_intensity_array;
    Data_Ready_o                        : out std_logic
);
end component;
 
component Display_manager IS
generic (
        horiztonal_size      : INTEGER:= 1280;
        vertical_size        : INTEGER:= 1024
);
    port (
        Clk_i               : in std_logic;
        Reset_i             : in std_logic;        
        Bar_intensity_i     : in  BarIndex_intensity_array;
        Data_Ready_i        : in std_logic;
        
         -- VGA output                                   
        VGA_Red_o           : out std_logic_vector(3 downto 0);                        
        VGA_Green_o         : out std_logic_vector(3 downto 0);                       
        VGA_Blue_o          : out std_logic_vector(3 downto 0);                       
        VGA_h_sync_o        : out std_logic;                       
        VGA_v_sync_o        : out std_logic                       
);
END component; 

signal Audio_Left_Channel_s                : std_logic_vector (15 downto 0);
signal Audio_Right_Channel_s               : std_logic_vector (15 downto 0);
signal Data_Ready_s                         : std_logic;
signal Data_valid_s                         : std_logic;

signal Bar_intensity_s                     : BarIndex_intensity_array;

begin

 -----------------------------------------------------------------------
  -- Generate clock
  -----------------------------------------------------------------------

  clock_gen : process
  begin
    aclk <= '0';
    wait for CLOCK_PERIOD;
    loop
      aclk <= '0';
      wait for CLOCK_PERIOD/2;
      aclk <= '1';
      wait for CLOCK_PERIOD/2;
    end loop;
  end process clock_gen;

  -----------------------------------------------------------------------
  -- Generate Reset
  -----------------------------------------------------------------------

  Reset_gen : process
  begin
    Reset_s <= '1';
    wait for 400 ns;
    Reset_s<= '0';
    wait;
  end process Reset_gen;
 
 
 
-- -- time signals
  -- process(sClock)
  -- begin
    -- if rising_edge(sClock) then
      -- tReal <= tReal + 1.0/clockFrequency;
    -- end if;
  -- end process;

  -- outReal <= outAmplitude * ( sin(2.0*math_pi*sineFrequency*tReal) + 1.0) / 2.0;

  -- process(outReal)
  -- begin
  
        -- X_o <= outReal*4.0;
        -- Y_o <= outReal*2.0;
        -- Z_o <= outReal;
    
  -- end process;
  
  
  
  
  
  -----------------------------------------------------------------------
  -- Generate data slave channel inputs
  -----------------------------------------------------------------------

  data_stimuli : process

    -- Variables for random number generation
    variable seed1, seed2 : positive;
    variable rand         : real;

    -- Procedure to drive an input sample with specific data
    -- data is the data value to drive on the tdata signal
    -- last is the bit value to drive on the tlast signal
    -- valid_mode defines how to drive TVALID: 0 = TVALID always high, 1 = TVALID low occasionally
    procedure drive_sample ( data       : std_logic_vector(31 downto 0);
                             last       : std_logic;
                             valid_mode : integer := 0 ) is
    begin
      -- Audio_Left_Channel_s  <= data(11 downto 0);
      -- Audio_Right_Channel_s  <= (others=>'0');
      --s_axis_data_tlast  <= last;

      if valid_mode = 1 then
        uniform(seed1, seed2, rand);  -- generate random number
        if rand < 0.25 then
          Data_valid_s <= '0';
        else
          Data_valid_s <= '1';
        end if;
      else
        Data_valid_s <= '1';
      end if;
      loop
        wait until rising_edge(aclk);
        -- exit when s_axis_data_tready = '1';
      end loop;
      wait for T_HOLD;
      Data_valid_s <= '0';
    end procedure drive_sample;

    -- Procedure to drive an input frame with a table of data
    -- data is the data table containing input data
    -- valid_mode defines how to drive TVALID: 0 = TVALID always high, 1 = TVALID low occasionally
    procedure drive_frame ( data         : T_IP_TABLE;
                            valid_mode   : integer := 0 ) is
      variable samples : integer;
      variable index   : integer;
      variable sample_data : std_logic_vector(31 downto 0);
      variable sample_last : std_logic;
    begin
      samples := data'length;
      index  := 0;
      while index < data'length loop
        -- Look up sample data in data table, construct TDATA value
        sample_data(15 downto 0)  := data(index).re;                  -- real data
        sample_data(31 downto 16) := data(index).im;                  -- imaginary data
        -- Construct TLAST's value
        index := index + 1;
        if index >= data'length then
          sample_last := '1';
        else
          sample_last := '0';
        end if;
        -- Drive the sample
        drive_sample(sample_data, sample_last, valid_mode);
      end loop;
    end procedure drive_frame;

   -- variable op_data_saved : T_IP_TABLE;  -- to save a copy of recorded output data


  
     variable index   : integer;
   
   
    
    
  begin

    -- Drive inputs T_HOLD time after rising edge of clock
    Data_valid_s <= '1';
    Audio_Left_Channel_s  <= (others=>'0');
    Audio_Right_Channel_s <= (others=>'0');
    wait until Reset_s ='0';
    loop 
    index  := 0;
        while index < IP_DATA'length loop
            wait until rising_edge(aclk);         
            Audio_Left_Channel_s  <= IP_DATA(index).re;                  -- real data
            Audio_Right_Channel_s  <= (others=>'0');
            index := index +1;
        end loop;
    end loop;

    -- Drive a frame of input data
   
    -- drive_frame(IP_DATA);

    -- -- Allow the result to emerge
    -- wait until Data_Ready_s = '1';
    -- wait until rising_edge(aclk);
    -- wait for T_HOLD;
   -- drive_frame(IP_DATA);
     -- -- Allow the result to emerge
    -- wait until Data_Ready_s = '1';
    -- wait until rising_edge(aclk);
    -- wait ;
  end process data_stimuli;





--======================
Display: Display_manager 
--======================
    generic map (
        horiztonal_size    => 1280,
        vertical_size      => 1024
    )
    port map (
        Clk_i               => aclk,           
        Reset_i             => Reset_s,             
        Bar_intensity_i     => BarIndex_intensity_dummy_C,           
        Data_Ready_i        => Data_Ready_s,
        -- VGA output                                   
        VGA_Red_o           => open,                              
        VGA_Green_o         => open,                             
        VGA_Blue_o          => open,                             
        VGA_h_sync_o        => open,            
        VGA_v_sync_o        => open   
    );

end behevioral;