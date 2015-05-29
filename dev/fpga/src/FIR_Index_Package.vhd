-- Spec: 25 Hz to 20kHz
-- Sample frequency: 48kHz
-- Depth needed for min 4 samples at 20Hz: 2400*4= 9600

-- Depth to take 16384 or 8192

-- with FIR Depth at 16384 (2^14) and 16 bars:
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library work;

package FIR_Index_Package is


Constant Nbbars_C : integer:= 22;
Type BarIndex_intensity_array is Array (0 to Nbbars_C-1) of std_logic_vector (34 downto 0);
Type FIR_index_array is Array (0 to Nbbars_C-1) of std_logic_vector (15 downto 0);


-- Constant FIR_Index_to_Bar : FIR_index_array :=(
  
    -- conv_std_logic_vector (13/2, 16),
    -- conv_std_logic_vector (21/2, 16),
    -- conv_std_logic_vector (34/2, 16),
    -- conv_std_logic_vector (54/2, 16),
    -- conv_std_logic_vector (85/2, 16),
    -- conv_std_logic_vector (136/2, 16),
    -- conv_std_logic_vector (215/2, 16),
    -- conv_std_logic_vector (341/2, 16),    
    
    -- conv_std_logic_vector (546/2, 16),                      
    -- conv_std_logic_vector (853/2, 16),                      
    -- conv_std_logic_vector (1365/2, 16),                     
    -- conv_std_logic_vector (2150/2, 16),                     
    -- conv_std_logic_vector (2730/2, 16),                     
    -- conv_std_logic_vector (4266/2, 16),                     
    -- conv_std_logic_vector (6826/2, 16),                     
    -- conv_std_logic_vector (7509/2, 16)                      
                                                          
    -- );                                                    


    Constant FIR_Index_to_Bar : FIR_index_array :=(
  
        conv_std_logic_vector (14, 16),
        conv_std_logic_vector (17, 16),
        conv_std_logic_vector (21, 16),
        conv_std_logic_vector (27, 16),
        conv_std_logic_vector (34, 16),
        conv_std_logic_vector (43, 16),
        conv_std_logic_vector (54, 16),
        conv_std_logic_vector (68, 16),    
                               
        conv_std_logic_vector (85, 16),                      
        conv_std_logic_vector (107, 16),                      
        conv_std_logic_vector (137, 16),                     
        conv_std_logic_vector (171, 16),                     
        conv_std_logic_vector (213, 16),                     
        conv_std_logic_vector (269, 16),                     
        conv_std_logic_vector (341, 16),                     
        conv_std_logic_vector (427, 16),                      
         
        conv_std_logic_vector (538, 16) , 
        conv_std_logic_vector (683, 16),  
        conv_std_logic_vector (853, 16) , 
        conv_std_logic_vector (1067, 16) , 
        conv_std_logic_vector (1365, 16) , 
        conv_std_logic_vector (1707, 16) 
    );  
    
    
    
    
  constant BarIndex_intensity_dummy_C : BarIndex_intensity_array:=(
    conv_std_logic_vector (1073741824   /(2**0),  35),  
    conv_std_logic_vector (1073741824   /(2**2),  35),  
    conv_std_logic_vector (1073741824   /(2**4),  35),                          
    conv_std_logic_vector (1073741824   /(2**6),  35),  
    conv_std_logic_vector (1073741824   /(2**8),  35),  
    conv_std_logic_vector (1073741824   /(2**10), 35), 
    conv_std_logic_vector (1073741824   /(2**12), 35),  
    conv_std_logic_vector (1073741824   /(2**14), 35),                          
    conv_std_logic_vector (1073741824   /(2**16), 35),  
    conv_std_logic_vector (1073741824   /(2**18), 35),  
    conv_std_logic_vector (1073741824   /(2**20), 35), 
    conv_std_logic_vector (1073741824   /(2**22), 35), 
    conv_std_logic_vector (1073741824   /(2**18), 35),  
    conv_std_logic_vector (1073741824   /(2**16), 35),  
    conv_std_logic_vector (1073741824   /(2**14), 35),  
    conv_std_logic_vector (1073741824   /(2**12), 35),  
    conv_std_logic_vector (1073741824   /(2**10), 35),                          
    conv_std_logic_vector (1073741824   /(2**8),  35),  
    conv_std_logic_vector (1073741824   /(2**6),  35),  
    conv_std_logic_vector (1073741824   /(2**4),  35), 
    conv_std_logic_vector (1073741824   /(2**2),  35),  
    conv_std_logic_vector (1073741824   /(2**0),  35)
    );
    
    
    constant BarIndex_intensity_Reset_c : BarIndex_intensity_array:=(
    conv_std_logic_vector (0,  35), 
    conv_std_logic_vector (0,  35),  
    conv_std_logic_vector (0,  35),
    conv_std_logic_vector (0,  35),
    conv_std_logic_vector (0,  35),
    conv_std_logic_vector (0,  35),
    conv_std_logic_vector (0,  35),
    conv_std_logic_vector (0,  35),
    conv_std_logic_vector (0,  35),
    conv_std_logic_vector (0,  35),
    conv_std_logic_vector (0,  35),
    conv_std_logic_vector (0,  35),
    conv_std_logic_vector (0,  35),
    conv_std_logic_vector (0,  35),
    conv_std_logic_vector (0,  35),
    conv_std_logic_vector (0,  35),
    conv_std_logic_vector (0,  35),
    conv_std_logic_vector (0,  35),
    conv_std_logic_vector (0,  35),
    conv_std_logic_vector (0,  35),
    conv_std_logic_vector (0,  35),
    conv_std_logic_vector (0,  35)
    );  
    
   end package;
   