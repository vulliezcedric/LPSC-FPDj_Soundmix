
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL; 
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;
use work.Fir_index_package.all;
use work.Package_FPDj.all;
library xil_defaultlib;

entity Frequency_Analysis_top is
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
end Frequency_Analysis_top;

architecture behevioral of Frequency_Analysis_top is


component xfft_0 IS
  PORT (
    aclk : IN STD_LOGIC;
    aclken : IN STD_LOGIC;
    s_axis_config_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axis_config_tvalid : IN STD_LOGIC;
    s_axis_config_tready : OUT STD_LOGIC;
    s_axis_data_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axis_data_tvalid : IN STD_LOGIC;
    s_axis_data_tready : OUT STD_LOGIC;
    s_axis_data_tlast : IN STD_LOGIC;
    m_axis_data_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    m_axis_data_tuser : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    m_axis_data_tvalid : OUT STD_LOGIC;
    m_axis_data_tlast : OUT STD_LOGIC;
    event_frame_started : OUT STD_LOGIC;
    event_tlast_unexpected : OUT STD_LOGIC;
    event_tlast_missing : OUT STD_LOGIC;
    event_data_in_channel_halt : OUT STD_LOGIC
  );
END component;

component FFT_Manager is
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
end component;


 component mult_gen_1 IS
  PORT (
    CLK : IN STD_LOGIC;
    A : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    B : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    P : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
  
  end component;
  
constant FFT_scale_sch_C        : std_logic_vector (9 downto 0):= "01" & "10"  & "10"  & "10"  & "11";
constant FFT_Direction_C        : std_logic:='1'; -- 1=forward, 0=inverse
Constant FFT_config_tdata_C     : std_logic_vector (31 downto 0):=  "00000" & FFT_scale_sch_C &  FFT_Direction_C & x"0000";

signal FFT_Output_s             : std_logic_vector (31 downto 0);
signal FFT_Output_Index_s       : std_logic_vector (15 downto 0);
signal FFT_data_valid_s         : std_logic;
signal FFT_data_Last_s          : std_logic;
signal FFT_Frame_started_s      : std_logic;
signal FFT_input_Data_s         : std_logic_vector (31 downto 0);
signal FFT_data_tlast_s         : std_logic;
signal FFT_data_ready_s         : std_logic;
signal FFT_audio_Valid_s        : std_logic;
    
signal FFT_Real_s               : std_logic_vector (15 downto 0);
signal FFT_Im_s                 : std_logic_vector (15 downto 0);

-- Mult
signal Imsquare_s               : std_logic_vector (31 downto 0);
signal Realsquare_s             : std_logic_vector (31 downto 0);
signal FFT_Result_s             : std_logic_vector (31 downto 0);
constant Multlatency_C          : integer:= 4; -- 3+1

Type latencyRecord is record
    frame_started       : STD_LOGIC;
    data_tvalid         : STD_LOGIC;
    data_tlast          : STD_LOGIC;
    data_index          : STD_LOGIC_VECTOR(15 DOWNTO 0);
end record;

type latencyPipe is array (0 to Multlatency_C-1) of latencyRecord;
signal Mult_latency_pipe: latencyPipe;
signal Bar_intensity_s                      : BarIndex_intensity_array;   
signal Data_Ready_s                         : std_logic;


-- constant BarIntensity_PipeLength: integer:= 3;
-- type Bar_intensity_array is array (0 to BarIntensity_PipeLength-1) of BarIndex_intensity_array;
-- signal Bar_intensity_pipe : Bar_intensity_array;
-- signal Bar_intensity_counter_s: std_logic_vector (1 downto 0);

begin


FFT_input_Data_s(31 downto 16) <=  Audio_Left_Channel_i;
FFT_input_Data_s(15 downto 0)  <=  Audio_Right_Channel_i;


FFT_Real_s  <= FFT_Output_s(15 downto 0);
FFT_Im_s    <= FFT_Output_s(31 downto 16);


--=========================
FFT_controler: FFT_Manager 
--=========================
generic map (
        FFT_depth => 8190 --8192 -1
    )
port map(
    Clk_i                   => Clk_i,       
    Reset_i                 => Reset_i,     
    -- FFT interface            
    FFT_DataReady_i         => FFT_data_ready_s,      
    FFT_DataValid_o         => FFT_audio_Valid_s,     
    FFT_DataLast_o          => FFT_data_tlast_s,  
    FFT_Frame_start_i       => FFT_Frame_started_s,
    -- Audio interface          
    Audio_Data_Valid_i      => Audio_Data_Valid_i     
);


--=================
FFT_Block: xfft_0 
--=================
  PORT  MAP(
    aclk                        => Clk_i,     
    aclken                      => FFT_audio_Valid_s, --'1', 
    s_axis_config_tdata         => FFT_config_tdata_C,                        
    s_axis_config_tvalid        => '1',                    
    s_axis_config_tready        => open,                         
    s_axis_data_tdata           => FFT_input_Data_s,                       
    s_axis_data_tvalid          => '1' ,                      
    s_axis_data_tready          => FFT_data_ready_s,                        
    s_axis_data_tlast           => FFT_data_tlast_s,                        
    m_axis_data_tdata           => FFT_Output_s,                        
    m_axis_data_tuser           => FFT_Output_Index_s,                         
    m_axis_data_tvalid          => FFT_data_valid_s,                        
    m_axis_data_tlast           => FFT_data_Last_s,                        
    event_frame_started         => FFT_Frame_started_s,                       
    event_tlast_unexpected      => open,                         
    event_tlast_missing         => open,                       
    event_data_in_channel_halt  => open                        
  );

  
  
  
  
  
--=====================  
 Mult_real :mult_gen_1 
 --=====================
  PORT map(
    CLK     => Clk_i,                
    A       => FFT_Real_s,               
    B       => FFT_Real_s,              
    P       => Realsquare_s                
  );
 --=====================
  Mult_im :mult_gen_1
 --=====================  
  PORT map(
    CLK     => Clk_i,                
    A       => FFT_Im_s,               
    B       => FFT_Im_s,              
    P       => Imsquare_s                
  );
  
  
process ( Clk_i, Reset_i)
begin
    if Reset_i='1' then
        FFT_Result_s <= (others=>'0');
        for i in 0 to Multlatency_C-1 loop
            Mult_latency_pipe(i).frame_started <='0';
            Mult_latency_pipe(i).data_tvalid   <='0';
            Mult_latency_pipe(i).data_tlast    <='0';
            Mult_latency_pipe(i).data_index    <=(others=>'0');
        end loop;    
    elsif rising_edge(Clk_i) then
        FFT_Result_s <= Realsquare_s + Imsquare_s;
       
        Mult_latency_pipe(0).frame_started <= FFT_Frame_started_s;
        Mult_latency_pipe(0).data_tvalid   <= FFT_data_valid_s;
        Mult_latency_pipe(0).data_tlast    <= FFT_data_Last_s;
        Mult_latency_pipe(0).data_index    <= FFT_Output_Index_s;
         
        for i in 1 to Multlatency_C-1 loop
            Mult_latency_pipe(i)<= Mult_latency_pipe(i-1);            
        end loop;        
        
    end if;
end process;

  
  
  
  
--========================================
FFT_Intensity: Intensity_Bands_Extraction 
--========================================
port map (
    Clk_i                               => Clk_i,                     
    Reset_i                             => Reset_i,                    
    -- fft interface                                       
    Frame_Index_i                       => Mult_latency_pipe(Multlatency_C-1).data_index,                   
    Frame_start_i                       => Mult_latency_pipe(Multlatency_C-1).frame_started,                 
    Frame_end_i                         => Mult_latency_pipe(Multlatency_C-1).data_tlast,                    
    Frame_Data_valid_i                  => Mult_latency_pipe(Multlatency_C-1).data_tvalid, 
    Frame_Data_i                        => FFT_Result_s,    
    -- user Interface                                      
    Bar_intensity_o                     => Bar_intensity_o, --Bar_intensity_s,                    
    Data_Ready_o                        => Data_Ready_o                    
);
-- --========================================
-- intensity_formating:Intensity_Bands_Format 
-- --========================================
-- port map(
    -- Clk_i                               => Clk_i,               
    -- Reset_i                             => Reset_i,             
    -- Bar_intensity_i                     => Bar_intensity_s,     
    -- Data_Ready_i                        => Data_Ready_s,        
    -- Bar_intensity_o                     => open,     
    -- Data_Ready_o                        => Data_Ready_o         
-- );




-- -- average the Bar intensity through time
-- process ( Clk_i, Reset_i)
-- begin
    -- if Reset_i='1' then
        -- for i in 0 to BarIntensity_PipeLength-1 loop            
            -- Bar_intensity_pipe (i) <= BarIndex_intensity_Reset_c;
        -- end loop;
        -- Data_Ready_o <='0';
        -- Bar_intensity_o <=BarIndex_intensity_Reset_c;
        -- Bar_intensity_counter_s <= (others=>'0');
    -- elsif rising_edge(Clk_i) then
        -- if Data_Ready_s='1' then
            -- Bar_intensity_pipe (0) <= Bar_intensity_s;            
            -- for i in 1 to BarIntensity_PipeLength-1 loop            
                -- for j in 0 to Nbbars_C-1 loop
                    -- Bar_intensity_pipe (i)(j) <=  Bar_intensity_pipe (i-1)(j) +Bar_intensity_s(j) ;
                -- end loop;              
            -- end loop;
            
            -- if Bar_intensity_counter_s ="11" then
                -- Bar_intensity_o <=Bar_intensity_pipe(BarIntensity_PipeLength-1);
                -- Bar_intensity_counter_s <= (others=>'0');
            -- else
                -- Bar_intensity_counter_s <=Bar_intensity_counter_s+1;
            -- end if;   
            
        -- end if;
        
    -- end if;
-- end process;


end behevioral;