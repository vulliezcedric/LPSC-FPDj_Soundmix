# 
# Synthesis run script generated by Vivado
# 

set_param gui.test TreeTableDev
debug::add_scope template.lib 1
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000

create_project -in_memory -part xc7a100tcsg324-1
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir /home/laurent/Projects/MSE_LPSC/Audio/vivado_prj/test_audio_pmod/test_audio_pmod.cache/wt [current_project]
set_property parent.project_path /home/laurent/Projects/MSE_LPSC/Audio/vivado_prj/test_audio_pmod/test_audio_pmod.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
set_property ip_repo_paths /home/laurent/Projects/MSE_LPSC/Audio/vivado_prj [current_project]
add_files /home/laurent/Projects/MSE_LPSC/Audio/vivado_prj/test_audio_pmod/test_audio_pmod.srcs/sources_1/bd/test_pmod_audio_design/test_pmod_audio_design.bd
set_property used_in_implementation false [get_files -all /home/laurent/Projects/MSE_LPSC/Audio/vivado_prj/test_audio_pmod/test_audio_pmod.srcs/sources_1/bd/test_pmod_audio_design/ip/test_pmod_audio_design_clk_wiz_0_0/test_pmod_audio_design_clk_wiz_0_0_board.xdc]
set_property used_in_implementation false [get_files -all /home/laurent/Projects/MSE_LPSC/Audio/vivado_prj/test_audio_pmod/test_audio_pmod.srcs/sources_1/bd/test_pmod_audio_design/ip/test_pmod_audio_design_clk_wiz_0_0/test_pmod_audio_design_clk_wiz_0_0.xdc]
set_property used_in_implementation false [get_files -all /home/laurent/Projects/MSE_LPSC/Audio/vivado_prj/test_audio_pmod/test_audio_pmod.srcs/sources_1/bd/test_pmod_audio_design/ip/test_pmod_audio_design_clk_wiz_0_0/test_pmod_audio_design_clk_wiz_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/laurent/Projects/MSE_LPSC/Audio/vivado_prj/test_audio_pmod/test_audio_pmod.srcs/sources_1/bd/test_pmod_audio_design/test_pmod_audio_design_ooc.xdc]
set_property is_locked true [get_files /home/laurent/Projects/MSE_LPSC/Audio/vivado_prj/test_audio_pmod/test_audio_pmod.srcs/sources_1/bd/test_pmod_audio_design/test_pmod_audio_design.bd]

read_vhdl -library xil_defaultlib /home/laurent/Projects/MSE_LPSC/Audio/vivado_prj/test_audio_pmod/test_audio_pmod.srcs/sources_1/new/test_pmod_audio.vhd
read_xdc /home/laurent/Projects/MSE_LPSC/Audio/vivado_prj/test_audio_pmod/test_audio_pmod.srcs/constrs_1/new/constraints.xdc
set_property used_in_implementation false [get_files /home/laurent/Projects/MSE_LPSC/Audio/vivado_prj/test_audio_pmod/test_audio_pmod.srcs/constrs_1/new/constraints.xdc]

read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]
catch { write_hwdef -file test_pmod_audio.hwdef }
synth_design -top test_pmod_audio -part xc7a100tcsg324-1
write_checkpoint -noxdef test_pmod_audio.dcp
catch { report_utilization -file test_pmod_audio_utilization_synth.rpt -pb test_pmod_audio_utilization_synth.pb }
