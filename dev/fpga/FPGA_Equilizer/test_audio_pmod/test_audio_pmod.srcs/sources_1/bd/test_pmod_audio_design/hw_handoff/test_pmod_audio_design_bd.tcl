
################################################################
# This is a generated script based on design: test_pmod_audio_design
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2014.4
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   puts "ERROR: This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source test_pmod_audio_design_script.tcl

# If you do not already have a project created,
# you can create a project using the following command:
#    create_project project_1 myproj -part xc7a100tcsg324-1


# CHANGE DESIGN NAME HERE
set design_name test_pmod_audio_design

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# CHECKING IF PROJECT EXISTS
if { [get_projects -quiet] eq "" } {
   puts "ERROR: Please open or create a project!"
   return 1
}


# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "ERROR: Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      puts "INFO: Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   puts "INFO: Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "ERROR: Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "ERROR: Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   puts "INFO: Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   puts "INFO: Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

puts "INFO: Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   puts $errMsg
   return $nRet
}

##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     puts "ERROR: Unable to find parent cell <$parentCell>!"
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     puts "ERROR: Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports

  # Create ports
  set AudioInput_o [ create_bd_port -dir O -from 11 -to 0 -type data AudioInput_o ]
  set Audio_output_i [ create_bd_port -dir I -from 15 -to 0 -type data Audio_output_i ]
  set Clk_50Mhz_o [ create_bd_port -dir O -type clk Clk_50Mhz_o ]
  set Enable_o [ create_bd_port -dir O Enable_o ]
  set audio_in_SCLK [ create_bd_port -dir O audio_in_SCLK ]
  set audio_in_SDATA [ create_bd_port -dir I audio_in_SDATA ]
  set audio_in_nCS [ create_bd_port -dir O audio_in_nCS ]
  set audio_out_LRCK [ create_bd_port -dir O audio_out_LRCK ]
  set audio_out_MCLK [ create_bd_port -dir O audio_out_MCLK ]
  set audio_out_SCLK [ create_bd_port -dir O audio_out_SCLK ]
  set audio_out_SDOUT [ create_bd_port -dir O audio_out_SDOUT ]
  set clk_108Mhz_o [ create_bd_port -dir O clk_108Mhz_o ]
  set clk_in [ create_bd_port -dir I -type clk clk_in ]
  set locked [ create_bd_port -dir O locked ]
  set reset [ create_bd_port -dir I -type rst reset ]
  set_property -dict [ list CONFIG.POLARITY {ACTIVE_HIGH}  ] $reset

  # Create instance: clk_wiz_0, and set properties
  set clk_wiz_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:5.1 clk_wiz_0 ]
  set_property -dict [ list CONFIG.CLKOUT1_JITTER {116.371} CONFIG.CLKOUT1_PHASE_ERROR {79.592} CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {50.000} CONFIG.CLKOUT2_JITTER {101.304} CONFIG.CLKOUT2_PHASE_ERROR {79.592} CONFIG.CLKOUT2_REQUESTED_OUT_FREQ {108.000} CONFIG.CLKOUT2_USED {true} CONFIG.MMCM_CLKFBOUT_MULT_F {14} CONFIG.MMCM_CLKOUT0_DIVIDE_F {28} CONFIG.MMCM_CLKOUT1_DIVIDE {13} CONFIG.MMCM_DIVCLK_DIVIDE {1} CONFIG.NUM_OUT_CLKS {2} CONFIG.PRIMITIVE {PLL}  ] $clk_wiz_0

  # Create instance: not_gate_0, and set properties
  set not_gate_0 [ create_bd_cell -type ip -vlnv hepia:user:not_gate:1.0 not_gate_0 ]

  # Create instance: pMOD_Audio_in_0, and set properties
  set pMOD_Audio_in_0 [ create_bd_cell -type ip -vlnv hepia:user:pMOD_Audio_in:1.0 pMOD_Audio_in_0 ]

  # Create instance: pMOD_Audio_out_0, and set properties
  set pMOD_Audio_out_0 [ create_bd_cell -type ip -vlnv hepia:user:pMOD_Audio_out:1.0 pMOD_Audio_out_0 ]

  # Create port connections
  connect_bd_net -net Audio_output_i_1 [get_bd_ports Audio_output_i] [get_bd_pins pMOD_Audio_out_0/audio_in]
  connect_bd_net -net SDATA_1 [get_bd_ports audio_in_SDATA] [get_bd_pins pMOD_Audio_in_0/SDATA]
  connect_bd_net -net clk_in1_1 [get_bd_ports clk_in] [get_bd_pins clk_wiz_0/clk_in1]
  connect_bd_net -net clk_wiz_0_clk_out1 [get_bd_ports Clk_50Mhz_o] [get_bd_pins clk_wiz_0/clk_out1] [get_bd_pins pMOD_Audio_in_0/CLK] [get_bd_pins pMOD_Audio_out_0/clk]
  connect_bd_net -net clk_wiz_0_clk_out2 [get_bd_ports clk_108Mhz_o] [get_bd_pins clk_wiz_0/clk_out2]
  connect_bd_net -net clk_wiz_0_locked [get_bd_ports locked] [get_bd_pins clk_wiz_0/locked] [get_bd_pins not_gate_0/I]
  connect_bd_net -net not_gate_0_O [get_bd_pins not_gate_0/O] [get_bd_pins pMOD_Audio_in_0/RST] [get_bd_pins pMOD_Audio_out_0/rst]
  connect_bd_net -net pMOD_Audio_in_0_DATA [get_bd_ports AudioInput_o] [get_bd_pins pMOD_Audio_in_0/DATA]
  connect_bd_net -net pMOD_Audio_in_0_SCLK [get_bd_ports audio_in_SCLK] [get_bd_pins pMOD_Audio_in_0/SCLK]
  connect_bd_net -net pMOD_Audio_in_0_nCS [get_bd_ports audio_in_nCS] [get_bd_pins pMOD_Audio_in_0/nCS]
  connect_bd_net -net pMOD_Audio_out_0_LRCK [get_bd_ports audio_out_LRCK] [get_bd_pins pMOD_Audio_out_0/LRCK]
  connect_bd_net -net pMOD_Audio_out_0_MCLK [get_bd_ports audio_out_MCLK] [get_bd_pins pMOD_Audio_out_0/MCLK]
  connect_bd_net -net pMOD_Audio_out_0_SCLK [get_bd_ports audio_out_SCLK] [get_bd_pins pMOD_Audio_out_0/SCLK]
  connect_bd_net -net pMOD_Audio_out_0_SDOUT [get_bd_ports audio_out_SDOUT] [get_bd_pins pMOD_Audio_out_0/SDOUT]
  connect_bd_net -net pMOD_Audio_out_0_done [get_bd_ports Enable_o] [get_bd_pins pMOD_Audio_in_0/START] [get_bd_pins pMOD_Audio_out_0/done]
  connect_bd_net -net reset_1 [get_bd_ports reset] [get_bd_pins clk_wiz_0/reset]

  # Create address segments
  

  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


