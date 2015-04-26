@echo off
set xv_path=F:\\Xilinx\\Vivado\\2014.4\\bin
call %xv_path%/xsim Frequency_Analysis_TB_behav -key {Behavioral:sim_1:Functional:Frequency_Analysis_TB} -tclbatch Frequency_Analysis_TB.tcl -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
