#----------------------------------------------------------------
# Nexys4
#----------------------------------------------------------------

#----------------------------------------------------------------
# Clock
set_property PACKAGE_PIN E3 [get_ports clk_i]
set_property IOSTANDARD LVCMOS33 [get_ports clk_i]

create_clock -period 10.000 -name sys_clk_i -waveform {0.000 5.000} -add [get_ports clk_i]

#----------------------------------------------------------------
# Resetn
set_property PACKAGE_PIN C12 [get_ports resetn_i]
set_property IOSTANDARD LVCMOS33 [get_ports resetn_i]

#----------------------------------------------------------------
# Debug LEDs
#----------------------------------------------------------------
# LED 0
set_property PACKAGE_PIN T8 [get_ports {leds_o[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds_o[0]}]
# LED 1
set_property PACKAGE_PIN V9 [get_ports {leds_o[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds_o[1]}]

#----------------------------------------------------------------
# PMOD Audio IN
#----------------------------------------------------------------
set_property PACKAGE_PIN J4 [get_ports audio_in_SCLK]
set_property IOSTANDARD LVCMOS33 [get_ports audio_in_SCLK]

set_property PACKAGE_PIN J3 [get_ports audio_in_SDATA]
set_property IOSTANDARD LVCMOS33 [get_ports audio_in_SDATA]

set_property PACKAGE_PIN K2 [get_ports audio_in_nCS]
set_property IOSTANDARD LVCMOS33 [get_ports audio_in_nCS]

#----------------------------------------------------------------
# PMOD Audio OUT
#----------------------------------------------------------------
set_property PACKAGE_PIN B13 [get_ports audio_out_MCLK]
set_property IOSTANDARD LVCMOS33 [get_ports audio_out_MCLK]

set_property PACKAGE_PIN F14 [get_ports audio_out_LRCK]
set_property IOSTANDARD LVCMOS33 [get_ports audio_out_LRCK]

set_property PACKAGE_PIN D17 [get_ports audio_out_SCLK]
set_property IOSTANDARD LVCMOS33 [get_ports audio_out_SCLK]

set_property PACKAGE_PIN E17 [get_ports audio_out_SDOUT]
set_property IOSTANDARD LVCMOS33 [get_ports audio_out_SDOUT]
