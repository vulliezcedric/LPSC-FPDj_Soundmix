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
ExecStep $xv_path/bin/xelab -wto e8c0e5a7bc6a41a3aaf1f6aeda107647 -m64 --debug typical --relax -L xil_defaultlib -L secureip --snapshot tb_test_pmod_audio_behav xil_defaultlib.tb_test_pmod_audio -log elaborate.log
