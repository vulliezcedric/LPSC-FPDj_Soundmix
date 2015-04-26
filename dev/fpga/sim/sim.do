#!/usr/bin/tclsh

# Main proc at the end #

#------------------------------------------------------------------------------
proc vhdl_compil { } {
  global Path_VHDL

  puts "\nVHDL compilation :"
  
#------- VHDL files-------
vcom xfft_0.vhd
#vcom $Path_VHDL./src/LCD_fake.vhd

#------- Simulation files -------
vcom tb_xfft_0.vhd  



  
  
}



#------------------------------------------------------------------------------
proc sv_compil { } {
  puts "\nSV compilation :"
  puts "\nNot that much to do right now"
}

#------------------------------------------------------------------------------
proc sim_start { } {
  
  vsim -t 1ns -novopt work.tb_xfft_0
  do wave.do
 # add wave -r *
 # wave refresh
  #run -all
  run 150 us
  wave zoomfull
}

#------------------------------------------------------------------------------
proc do_all { } {
  vhdl_compil
  sv_compil
  sim_start
}

#------------------------------------------------------------------------------
proc set_arg { } {
  global cmd
  global cmd_quit cmd_vhdl cmd_sv cmd_sim cmd_all
  
  set cmd_quit 0
  set cmd_all  1
  set cmd_vhdl 2
  set cmd_sv   3
  set cmd_sim  4

  while { 1 } {
    puts "\nList of operations :\n"
    puts "  $cmd_all  : do all"
    puts "  $cmd_vhdl  : vhdl compilation"
    puts "  $cmd_sv  : sv   compilation"
    puts "  $cmd_sim  : simulation"
    puts ""
    puts "  $cmd_quit  : exit\n"  
    puts -nonewline " enter your choice number => "
    
    set cmd [gets stdin]
  #  if {$cmd == 10} {
  #    break
  #  } else
    if { $cmd <0 || $cmd > 3 } {
      puts "\n Incorrect Value \n"
      set cmd -1
    } else {
      break
    }
  }
  
}

## MAIN #######################################################################
  
# Compile folder ----------------------------------------------------
if {[file exists work] == 0} {
  vlib work
}

puts -nonewline "  Path_VHDL => "
set Path_VHDL     "."

global Path_VHDL

# start of sequence -------------------------------------------------
  
if {$argc==1} {
  if {[string compare $1 "all"] == 0} {
    do_all
  } elseif {[string compare $1 "comp_vhdl"] == 0} {
    vhdl_compil
  } elseif {[string compare $1 "comp_sv"] == 0} {
    sv_compil
  } elseif {[string compare $1 "sim"] == 0} {
    sim_start
  }
  
} else {
  set_arg

  if {$cmd == $cmd_all} {
    do_all
  } elseif {$cmd == $cmd_vhdl} {
    vhdl_compil
  } elseif {$cmd == $cmd_sv} {
    sv_compil
  } elseif {$cmd == $cmd_sim} {
    sim_start
  }
}
