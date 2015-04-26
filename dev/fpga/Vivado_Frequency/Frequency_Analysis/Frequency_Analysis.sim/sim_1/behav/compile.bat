@echo off
set xv_path=F:\\Xilinx\\Vivado\\2014.4\\bin
echo "xvhdl -m64 -prj Frequency_Analysis_TB_vhdl.prj"
call %xv_path%/xvhdl  -m64 -prj Frequency_Analysis_TB_vhdl.prj -log compile.log
if "%errorlevel%"=="1" goto END
if "%errorlevel%"=="0" goto SUCCESS
:END
exit 1
:SUCCESS
exit 0
