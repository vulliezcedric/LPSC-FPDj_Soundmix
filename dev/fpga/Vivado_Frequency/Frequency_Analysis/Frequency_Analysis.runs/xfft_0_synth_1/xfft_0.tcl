# 
# Synthesis run script generated by Vivado
# 

set_param gui.test TreeTableDev
set_param simulator.modelsimInstallPath F:/Altera/modelsim_ase/win32aloem
debug::add_scope template.lib 1
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
set_msg_config -id {Synth 8-256} -limit 10000
set_msg_config -id {Synth 8-638} -limit 10000

create_project -in_memory -part xc7a200tfbg676-2
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir D:/MASTER/LPSC/git/LPSC-FPDj_Soundmix/dev/fpga/Vivado_Frequency/Frequency_Analysis/Frequency_Analysis.cache/wt [current_project]
set_property parent.project_path D:/MASTER/LPSC/git/LPSC-FPDj_Soundmix/dev/fpga/Vivado_Frequency/Frequency_Analysis/Frequency_Analysis.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
set_property board_part xilinx.com:ac701:part0:1.1 [current_project]
read_ip D:/MASTER/LPSC/git/LPSC-FPDj_Soundmix/dev/fpga/Vivado_Frequency/Frequency_Analysis/Frequency_Analysis.srcs/sources_1/ip/xfft_0/xfft_0.xci
set_property used_in_implementation false [get_files -all d:/MASTER/LPSC/git/LPSC-FPDj_Soundmix/dev/fpga/Vivado_Frequency/Frequency_Analysis/Frequency_Analysis.srcs/sources_1/ip/xfft_0/xfft_0.dcp]
set_property is_locked true [get_files D:/MASTER/LPSC/git/LPSC-FPDj_Soundmix/dev/fpga/Vivado_Frequency/Frequency_Analysis/Frequency_Analysis.srcs/sources_1/ip/xfft_0/xfft_0.xci]

read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]
catch { write_hwdef -file xfft_0.hwdef }
synth_design -top xfft_0 -part xc7a200tfbg676-2 -mode out_of_context
rename_ref -prefix_all xfft_0_
write_checkpoint -noxdef xfft_0.dcp
catch { report_utilization -file xfft_0_utilization_synth.rpt -pb xfft_0_utilization_synth.pb }
if { [catch {
  file copy -force D:/MASTER/LPSC/git/LPSC-FPDj_Soundmix/dev/fpga/Vivado_Frequency/Frequency_Analysis/Frequency_Analysis.runs/xfft_0_synth_1/xfft_0.dcp D:/MASTER/LPSC/git/LPSC-FPDj_Soundmix/dev/fpga/Vivado_Frequency/Frequency_Analysis/Frequency_Analysis.srcs/sources_1/ip/xfft_0/xfft_0.dcp
} _RESULT ] } { 
  error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
}
if { [catch {
  write_verilog -force -mode synth_stub D:/MASTER/LPSC/git/LPSC-FPDj_Soundmix/dev/fpga/Vivado_Frequency/Frequency_Analysis/Frequency_Analysis.srcs/sources_1/ip/xfft_0/xfft_0_stub.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a Verilog synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}
if { [catch {
  write_vhdl -force -mode synth_stub D:/MASTER/LPSC/git/LPSC-FPDj_Soundmix/dev/fpga/Vivado_Frequency/Frequency_Analysis/Frequency_Analysis.srcs/sources_1/ip/xfft_0/xfft_0_stub.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a VHDL synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}
if { [catch {
  write_verilog -force -mode funcsim D:/MASTER/LPSC/git/LPSC-FPDj_Soundmix/dev/fpga/Vivado_Frequency/Frequency_Analysis/Frequency_Analysis.srcs/sources_1/ip/xfft_0/xfft_0_funcsim.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the Verilog functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}
if { [catch {
  write_vhdl -force -mode funcsim D:/MASTER/LPSC/git/LPSC-FPDj_Soundmix/dev/fpga/Vivado_Frequency/Frequency_Analysis/Frequency_Analysis.srcs/sources_1/ip/xfft_0/xfft_0_funcsim.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the VHDL functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}
