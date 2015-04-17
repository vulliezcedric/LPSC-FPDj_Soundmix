#!/bin/sh -f
xv_path="/opt/Xilinx/Vivado/2014.4"
ExecStep()
{
"$@"
RETVAL=$?
if [ $RETVAL -ne 0 ]
then
exit $RETVAL
fi
}
ExecStep $xv_path/bin/xsim tb_test_pmod_audio_behav -key {Behavioral:sim_1:Functional:tb_test_pmod_audio} -tclbatch tb_test_pmod_audio.tcl -view /home/laurent/Projects/MSE_LPSC/Audio/vivado_prj/test_audio_pmod/tb_test_pmod_audio_behav.wcfg -view /home/laurent/Projects/MSE_LPSC/Audio/vivado_prj/test_audio_pmod/tb_test_pmod_audio_behav.wcfg -view /home/laurent/Projects/MSE_LPSC/Audio/vivado_prj/test_audio_pmod/tb_test_pmod_audio_behav.wcfg -log simulate.log
