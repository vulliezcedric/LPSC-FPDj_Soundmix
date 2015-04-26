@echo off
set xv_path=F:\\Xilinx\\Vivado\\2014.4\\bin
call %xv_path%/xelab  -wto cd8151cb527c4c0cad679fc7965ef4bf -m64 --debug typical --relax -L xbip_utils_v3_0 -L xbip_pipe_v3_0 -L xbip_bram18k_v3_0 -L mult_gen_v12_0 -L xil_defaultlib -L axi_utils_v2_0 -L c_reg_fd_v12_0 -L xbip_dsp48_wrapper_v3_0 -L xbip_dsp48_addsub_v3_0 -L xbip_addsub_v3_0 -L c_addsub_v12_0 -L c_mux_bit_v12_0 -L c_shift_ram_v12_0 -L cmpy_v6_0 -L floating_point_v7_0 -L xfft_v9_0 -L work -L secureip --snapshot Frequency_Analysis_TB_behav work.Frequency_Analysis_TB -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
