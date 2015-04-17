proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000

start_step init_design
set rc [catch {
  create_msg_db init_design.pb
  set_param gui.test TreeTableDev
  debug::add_scope template.lib 1
  set_property design_mode GateLvl [current_fileset]
  set_property webtalk.parent_dir /home/laurent/Projects/MSE_LPSC/Audio/vivado_prj/test_audio_pmod/test_audio_pmod.cache/wt [current_project]
  set_property parent.project_path /home/laurent/Projects/MSE_LPSC/Audio/vivado_prj/test_audio_pmod/test_audio_pmod.xpr [current_project]
  set_property ip_repo_paths {
  /home/laurent/Projects/MSE_LPSC/Audio/vivado_prj/test_audio_pmod/test_audio_pmod.cache/ip
  /home/laurent/Projects/MSE_LPSC/Audio/vivado_prj
} [current_project]
  set_property ip_output_repo /home/laurent/Projects/MSE_LPSC/Audio/vivado_prj/test_audio_pmod/test_audio_pmod.cache/ip [current_project]
  add_files -quiet /home/laurent/Projects/MSE_LPSC/Audio/vivado_prj/test_audio_pmod/test_audio_pmod.runs/synth_1/test_pmod_audio.dcp
  read_xdc -prop_thru_buffers -ref test_pmod_audio_design_clk_wiz_0_0 -cells U0 /home/laurent/Projects/MSE_LPSC/Audio/vivado_prj/test_audio_pmod/test_audio_pmod.srcs/sources_1/bd/test_pmod_audio_design/ip/test_pmod_audio_design_clk_wiz_0_0/test_pmod_audio_design_clk_wiz_0_0_board.xdc
  set_property processing_order EARLY [get_files /home/laurent/Projects/MSE_LPSC/Audio/vivado_prj/test_audio_pmod/test_audio_pmod.srcs/sources_1/bd/test_pmod_audio_design/ip/test_pmod_audio_design_clk_wiz_0_0/test_pmod_audio_design_clk_wiz_0_0_board.xdc]
  read_xdc -ref test_pmod_audio_design_clk_wiz_0_0 -cells U0 /home/laurent/Projects/MSE_LPSC/Audio/vivado_prj/test_audio_pmod/test_audio_pmod.srcs/sources_1/bd/test_pmod_audio_design/ip/test_pmod_audio_design_clk_wiz_0_0/test_pmod_audio_design_clk_wiz_0_0.xdc
  set_property processing_order EARLY [get_files /home/laurent/Projects/MSE_LPSC/Audio/vivado_prj/test_audio_pmod/test_audio_pmod.srcs/sources_1/bd/test_pmod_audio_design/ip/test_pmod_audio_design_clk_wiz_0_0/test_pmod_audio_design_clk_wiz_0_0.xdc]
  read_xdc /home/laurent/Projects/MSE_LPSC/Audio/vivado_prj/test_audio_pmod/test_audio_pmod.srcs/constrs_1/new/constraints.xdc
  link_design -top test_pmod_audio -part xc7a100tcsg324-1
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
}

start_step opt_design
set rc [catch {
  create_msg_db opt_design.pb
  catch {write_debug_probes -quiet -force debug_nets}
  opt_design 
  write_checkpoint -force test_pmod_audio_opt.dcp
  catch {report_drc -file test_pmod_audio_drc_opted.rpt}
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
}

start_step place_design
set rc [catch {
  create_msg_db place_design.pb
  place_design 
  write_checkpoint -force test_pmod_audio_placed.dcp
  catch { report_io -file test_pmod_audio_io_placed.rpt }
  catch { report_clock_utilization -file test_pmod_audio_clock_utilization_placed.rpt }
  catch { report_utilization -file test_pmod_audio_utilization_placed.rpt -pb test_pmod_audio_utilization_placed.pb }
  catch { report_control_sets -verbose -file test_pmod_audio_control_sets_placed.rpt }
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
}

start_step route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  write_checkpoint -force test_pmod_audio_routed.dcp
  catch { report_drc -file test_pmod_audio_drc_routed.rpt -pb test_pmod_audio_drc_routed.pb }
  catch { report_timing_summary -warn_on_violation -max_paths 10 -file test_pmod_audio_timing_summary_routed.rpt -rpx test_pmod_audio_timing_summary_routed.rpx }
  catch { report_power -file test_pmod_audio_power_routed.rpt -pb test_pmod_audio_power_summary_routed.pb }
  catch { report_route_status -file test_pmod_audio_route_status.rpt -pb test_pmod_audio_route_status.pb }
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
}

start_step write_bitstream
set rc [catch {
  create_msg_db write_bitstream.pb
  write_bitstream -force test_pmod_audio.bit 
  if { [file exists /home/laurent/Projects/MSE_LPSC/Audio/vivado_prj/test_audio_pmod/test_audio_pmod.runs/synth_1/test_pmod_audio.hwdef] } {
    catch { write_sysdef -hwdef /home/laurent/Projects/MSE_LPSC/Audio/vivado_prj/test_audio_pmod/test_audio_pmod.runs/synth_1/test_pmod_audio.hwdef -bitfile test_pmod_audio.bit -meminfo test_pmod_audio.mmi -file test_pmod_audio.sysdef }
  }
  close_msg_db -file write_bitstream.pb
} RESULT]
if {$rc} {
  step_failed write_bitstream
  return -code error $RESULT
} else {
  end_step write_bitstream
}

