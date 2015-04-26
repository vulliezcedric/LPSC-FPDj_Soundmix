// Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2014.4 (win64) Build 1071353 Tue Nov 18 18:24:04 MST 2014
// Date        : Fri Apr 17 02:58:03 2015
// Host        : RagingZen-PC running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode synth_stub
//               D:/MASTER/LPSC/git/LPSC-FPDj_Soundmix/dev/fpga/Vivado_Frequency/Frequency_Analysis/Frequency_Analysis.srcs/sources_1/ip/xfft_0/xfft_0_stub.v
// Design      : xfft_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a200tfbg676-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "xfft_v9_0,Vivado 2014.4" *)
module xfft_0(aclk, s_axis_config_tdata, s_axis_config_tvalid, s_axis_config_tready, s_axis_data_tdata, s_axis_data_tvalid, s_axis_data_tready, s_axis_data_tlast, m_axis_data_tdata, m_axis_data_tuser, m_axis_data_tvalid, m_axis_data_tlast, event_frame_started, event_tlast_unexpected, event_tlast_missing, event_data_in_channel_halt)
/* synthesis syn_black_box black_box_pad_pin="aclk,s_axis_config_tdata[31:0],s_axis_config_tvalid,s_axis_config_tready,s_axis_data_tdata[31:0],s_axis_data_tvalid,s_axis_data_tready,s_axis_data_tlast,m_axis_data_tdata[31:0],m_axis_data_tuser[15:0],m_axis_data_tvalid,m_axis_data_tlast,event_frame_started,event_tlast_unexpected,event_tlast_missing,event_data_in_channel_halt" */;
  input aclk;
  input [31:0]s_axis_config_tdata;
  input s_axis_config_tvalid;
  output s_axis_config_tready;
  input [31:0]s_axis_data_tdata;
  input s_axis_data_tvalid;
  output s_axis_data_tready;
  input s_axis_data_tlast;
  output [31:0]m_axis_data_tdata;
  output [15:0]m_axis_data_tuser;
  output m_axis_data_tvalid;
  output m_axis_data_tlast;
  output event_frame_started;
  output event_tlast_unexpected;
  output event_tlast_missing;
  output event_data_in_channel_halt;
endmodule
