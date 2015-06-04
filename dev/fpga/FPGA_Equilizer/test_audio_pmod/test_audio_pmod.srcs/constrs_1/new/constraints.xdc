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
#set_property PACKAGE_PIN T8 [get_ports {leds_o[0]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {leds_o[0]}]
# LED 1
#set_property PACKAGE_PIN V9 [get_ports {leds_o[1]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {leds_o[1]}]

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





#Bank = 15, Pin name = IO_L11N_T1_SRCC_15,					Sch name = BTNC
set_property PACKAGE_PIN E16 [get_ports {BTN_i[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {BTN_i[0]}]
#Bank = 15, Pin name = IO_L14P_T2_SRCC_15,					Sch name = BTNU
set_property PACKAGE_PIN F15 [get_ports {BTN_i[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {BTN_i[1]}]
#Bank = CONFIG, Pin name = IO_L15N_T2_DQS_DOUT_CSO_B_14,	Sch name = BTNL
set_property PACKAGE_PIN T16 [get_ports {BTN_i[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {BTN_i[4]}]
#Bank = 14, Pin name = IO_25_14,							Sch name = BTNR
set_property PACKAGE_PIN R10 [get_ports {BTN_i[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {BTN_i[2]}]
#Bank = 14, Pin name = IO_L21P_T3_DQS_14,					Sch name = BTND
set_property PACKAGE_PIN V10 [get_ports {BTN_i[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {BTN_i[3]}]


# LEDs
#Bank = 34, Pin name = IO_L24N_T3_34,						Sch name = LED0
set_property PACKAGE_PIN T8 [get_ports {LED[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[0]}]
#Bank = 34, Pin name = IO_L21N_T3_DQS_34,					Sch name = LED1
set_property PACKAGE_PIN V9 [get_ports {LED[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[1]}]
#Bank = 34, Pin name = IO_L24P_T3_34,						Sch name = LED2
set_property PACKAGE_PIN R8 [get_ports {LED[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[2]}]
#Bank = 34, Pin name = IO_L23N_T3_34,						Sch name = LED3
set_property PACKAGE_PIN T6 [get_ports {LED[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[3]}]
#Bank = 34, Pin name = IO_L12P_T1_MRCC_34,					Sch name = LED4
set_property PACKAGE_PIN T5 [get_ports {LED[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[4]}]
#Bank = 34, Pin name = IO_L12N_T1_MRCC_34,					Sch	name = LED5
set_property PACKAGE_PIN T4 [get_ports {LED[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[5]}]
#Bank = 34, Pin name = IO_L22P_T3_34,						Sch name = LED6
set_property PACKAGE_PIN U7 [get_ports {LED[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[6]}]
#Bank = 34, Pin name = IO_L22N_T3_34,						Sch name = LED7
set_property PACKAGE_PIN U6 [get_ports {LED[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[7]}]
#Bank = 34, Pin name = IO_L10N_T1_34,						Sch name = LED8
set_property PACKAGE_PIN V4 [get_ports {LED[8]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[8]}]
#Bank = 34, Pin name = IO_L8N_T1_34,						Sch name = LED9
set_property PACKAGE_PIN U3 [get_ports {LED[9]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[9]}]
#Bank = 34, Pin name = IO_L7N_T1_34,						Sch name = LED10
set_property PACKAGE_PIN V1 [get_ports {LED[10]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[10]}]
#Bank = 34, Pin name = IO_L17P_T2_34,						Sch name = LED11
set_property PACKAGE_PIN R1 [get_ports {LED[11]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[11]}]
#Bank = 34, Pin name = IO_L13N_T2_MRCC_34,					Sch name = LED12
set_property PACKAGE_PIN P5 [get_ports {LED[12]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[12]}]
#Bank = 34, Pin name = IO_L7P_T1_34,						Sch name = LED13
set_property PACKAGE_PIN U1 [get_ports {LED[13]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[13]}]
#Bank = 34, Pin name = IO_L15N_T2_DQS_34,					Sch name = LED14
set_property PACKAGE_PIN R2 [get_ports {LED[14]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[14]}]
#Bank = 34, Pin name = IO_L15P_T2_DQS_34,					Sch name = LED15
set_property PACKAGE_PIN P2 [get_ports {LED[15]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[15]}]

## Switches
#Bank = 34, Pin name = IO_L21P_T3_DQS_34,					Sch name = SW0
set_property PACKAGE_PIN U9 [get_ports {SW_i[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SW_i[0]}]
#Bank = 34, Pin name = IO_25_34,							Sch name = SW1
set_property PACKAGE_PIN U8 [get_ports {SW_i[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SW_i[1]}]
#Bank = 34, Pin name = IO_L23P_T3_34,						Sch name = SW2
set_property PACKAGE_PIN R7 [get_ports {SW_i[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SW_i[2]}]
#Bank = 34, Pin name = IO_L19P_T3_34,						Sch name = SW3
set_property PACKAGE_PIN R6 [get_ports {SW_i[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SW_i[3]}]
#Bank = 34, Pin name = IO_L19N_T3_VREF_34,					Sch name = SW4
set_property PACKAGE_PIN R5 [get_ports {SW_i[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SW_i[4]}]
#Bank = 34, Pin name = IO_L20P_T3_34,						Sch name = SW5
set_property PACKAGE_PIN V7 [get_ports {SW_i[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SW_i[5]}]
#Bank = 34, Pin name = IO_L20N_T3_34,						Sch name = SW6
set_property PACKAGE_PIN V6 [get_ports {SW_i[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SW_i[6]}]
#Bank = 34, Pin name = IO_L10P_T1_34,						Sch name = SW7
set_property PACKAGE_PIN V5 [get_ports {SW_i[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SW_i[7]}]
#Bank = 34, Pin name = IO_L8P_T1-34,						Sch name = SW8
set_property PACKAGE_PIN U4 [get_ports {SW_i[8]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SW_i[8]}]
#Bank = 34, Pin name = IO_L9N_T1_DQS_34,					Sch name = SW9
set_property PACKAGE_PIN V2 [get_ports {SW_i[9]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SW_i[9]}]
#Bank = 34, Pin name = IO_L9P_T1_DQS_34,					Sch name = SW10
set_property PACKAGE_PIN U2 [get_ports {SW_i[10]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SW_i[10]}]
#Bank = 34, Pin name = IO_L11N_T1_MRCC_34,					Sch name = SW11
set_property PACKAGE_PIN T3 [get_ports {SW_i[11]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SW_i[11]}]
#Bank = 34, Pin name = IO_L17N_T2_34,						Sch name = SW12
set_property PACKAGE_PIN T1 [get_ports {SW_i[12]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SW_i[12]}]
#Bank = 34, Pin name = IO_L11P_T1_SRCC_34,					Sch name = SW13
set_property PACKAGE_PIN R3 [get_ports {SW_i[13]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SW_i[13]}]
#Bank = 34, Pin name = IO_L14N_T2_SRCC_34,					Sch name = SW14
set_property PACKAGE_PIN P3 [get_ports {SW_i[14]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SW_i[14]}]
#Bank = 34, Pin name = IO_L14P_T2_SRCC_34,					Sch name = SW15
set_property PACKAGE_PIN P4 [get_ports {SW_i[15]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SW_i[15]}]

##7 segment display
#Bank = 34, Pin name = IO_L2N_T0_34,						Sch name = CA
set_property PACKAGE_PIN L3 [get_ports {SSEG_CA_o[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SSEG_CA_o[0]}]
#Bank = 34, Pin name = IO_L3N_T0_DQS_34,					Sch name = CB
set_property PACKAGE_PIN N1 [get_ports {SSEG_CA_o[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SSEG_CA_o[1]}]
#Bank = 34, Pin name = IO_L6N_T0_VREF_34,					Sch name = CC
set_property PACKAGE_PIN L5 [get_ports {SSEG_CA_o[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SSEG_CA_o[2]}]
#Bank = 34, Pin name = IO_L5N_T0_34,						Sch name = CD
set_property PACKAGE_PIN L4 [get_ports {SSEG_CA_o[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SSEG_CA_o[3]}]
#Bank = 34, Pin name = IO_L2P_T0_34,						Sch name = CE
set_property PACKAGE_PIN K3 [get_ports {SSEG_CA_o[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SSEG_CA_o[4]}]
#Bank = 34, Pin name = IO_L4N_T0_34,						Sch name = CF
set_property PACKAGE_PIN M2 [get_ports {SSEG_CA_o[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SSEG_CA_o[5]}]
#Bank = 34, Pin name = IO_L6P_T0_34,						Sch name = CG
set_property PACKAGE_PIN L6 [get_ports {SSEG_CA_o[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SSEG_CA_o[6]}]

#Bank = 34, Pin name = IO_L16P_T2_34,						Sch name = DP
set_property PACKAGE_PIN M4 [get_ports {SSEG_CA_o[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SSEG_CA_o[7]}]

#Bank = 34, Pin name = IO_L18N_T2_34,						Sch name = AN0
set_property PACKAGE_PIN N6 [get_ports {SSEG_AN_o[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SSEG_AN_o[0]}]
#Bank = 34, Pin name = IO_L18P_T2_34,						Sch name = AN1
set_property PACKAGE_PIN M6 [get_ports {SSEG_AN_o[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SSEG_AN_o[1]}]
#Bank = 34, Pin name = IO_L4P_T0_34,						Sch name = AN2
set_property PACKAGE_PIN M3 [get_ports {SSEG_AN_o[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SSEG_AN_o[2]}]
#Bank = 34, Pin name = IO_L13_T2_MRCC_34,					Sch name = AN3
set_property PACKAGE_PIN N5 [get_ports {SSEG_AN_o[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SSEG_AN_o[3]}]
#Bank = 34, Pin name = IO_L3P_T0_DQS_34,					Sch name = AN4
set_property PACKAGE_PIN N2 [get_ports {SSEG_AN_o[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SSEG_AN_o[4]}]
#Bank = 34, Pin name = IO_L16N_T2_34,						Sch name = AN5
set_property PACKAGE_PIN N4 [get_ports {SSEG_AN_o[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SSEG_AN_o[5]}]
#Bank = 34, Pin name = IO_L1P_T0_34,						Sch name = AN6
set_property PACKAGE_PIN L1 [get_ports {SSEG_AN_o[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SSEG_AN_o[6]}]
#Bank = 34, Pin name = IO_L1N_T034,							Sch name = AN7
set_property PACKAGE_PIN M1 [get_ports {SSEG_AN_o[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SSEG_AN_o[7]}]


set_property PACKAGE_PIN A3 [get_ports {VGA_Red_o[0]}]
set_property PACKAGE_PIN B4 [get_ports {VGA_Red_o[1]}]
set_property PACKAGE_PIN C5 [get_ports {VGA_Red_o[2]}]
set_property PACKAGE_PIN A4 [get_ports {VGA_Red_o[3]}]
set_property PACKAGE_PIN C6 [get_ports {VGA_Green_o[0]}]
set_property PACKAGE_PIN A5 [get_ports {VGA_Green_o[1]}]
set_property PACKAGE_PIN B6 [get_ports {VGA_Green_o[2]}]
set_property PACKAGE_PIN A6 [get_ports {VGA_Green_o[3]}]
set_property PACKAGE_PIN B7 [get_ports {VGA_Blue_o[0]}]
set_property PACKAGE_PIN C7 [get_ports {VGA_Blue_o[1]}]
set_property PACKAGE_PIN D7 [get_ports {VGA_Blue_o[2]}]
set_property PACKAGE_PIN D8 [get_ports {VGA_Blue_o[3]}]
set_property PACKAGE_PIN B11 [get_ports VGA_h_sync_o]
set_property PACKAGE_PIN B12 [get_ports VGA_v_sync_o]
set_property IOSTANDARD LVCMOS33 [get_ports VGA_v_sync_o]
set_property IOSTANDARD LVCMOS33 [get_ports VGA_h_sync_o]
set_property IOSTANDARD LVCMOS33 [get_ports {VGA_Green_o[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {VGA_Green_o[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {VGA_Green_o[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {VGA_Green_o[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {VGA_Red_o[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {VGA_Red_o[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {VGA_Red_o[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {VGA_Red_o[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {VGA_Blue_o[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {VGA_Blue_o[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {VGA_Blue_o[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {VGA_Blue_o[0]}]
