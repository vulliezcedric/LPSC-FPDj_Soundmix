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
echo "xvhdl -m64 -prj tb_test_pmod_audio_vhdl.prj"
ExecStep $xv_path/bin/xvhdl -m64 -prj tb_test_pmod_audio_vhdl.prj 2>&1 | tee compile.log
