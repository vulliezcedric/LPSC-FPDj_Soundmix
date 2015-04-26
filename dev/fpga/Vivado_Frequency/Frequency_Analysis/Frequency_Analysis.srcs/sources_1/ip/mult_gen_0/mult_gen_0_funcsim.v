// Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2014.4 (win64) Build 1071353 Tue Nov 18 18:24:04 MST 2014
// Date        : Fri Apr 17 02:16:34 2015
// Host        : RagingZen-PC running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode funcsim
//               D:/MASTER/LPSC/git/LPSC-FPDj_Soundmix/dev/fpga/Vivado_Frequency/Frequency_Analysis/Frequency_Analysis.srcs/sources_1/ip/mult_gen_0/mult_gen_0_funcsim.v
// Design      : mult_gen_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a200tfbg676-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "mult_gen_v12_0,Vivado 2014.4" *) (* CHECK_LICENSE_TYPE = "mult_gen_0,mult_gen_v12_0,{}" *) 
(* core_generation_info = "mult_gen_0,mult_gen_v12_0,{x_ipProduct=Vivado 2014.4,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=mult_gen,x_ipVersion=12.0,x_ipCoreRevision=6,x_ipLanguage=VHDL,x_ipSimLanguage=VHDL,C_VERBOSITY=0,C_MODEL_TYPE=0,C_OPTIMIZE_GOAL=1,C_XDEVICEFAMILY=artix7,C_HAS_CE=0,C_HAS_SCLR=0,C_LATENCY=1,C_A_WIDTH=16,C_A_TYPE=0,C_B_WIDTH=16,C_B_TYPE=0,C_OUT_HIGH=31,C_OUT_LOW=0,C_MULT_TYPE=1,C_CE_OVERRIDES_SCLR=0,C_CCM_IMP=0,C_B_VALUE=10000001,C_HAS_ZERO_DETECT=0,C_ROUND_OUTPUT=0,C_ROUND_PT=0}" *) 
(* NotValidForBitStream *)
module mult_gen_0
   (CLK,
    A,
    B,
    P);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) input CLK;
  input [15:0]A;
  input [15:0]B;
  output [31:0]P;

  wire [15:0]A;
  wire [15:0]B;
  wire CLK;
  wire [31:0]P;
  wire [47:0]NLW_U0_PCASC_UNCONNECTED;
  wire [1:0]NLW_U0_ZERO_DETECT_UNCONNECTED;

(* C_A_TYPE = "0" *) 
   (* C_A_WIDTH = "16" *) 
   (* C_B_TYPE = "0" *) 
   (* C_B_VALUE = "10000001" *) 
   (* C_B_WIDTH = "16" *) 
   (* C_CCM_IMP = "0" *) 
   (* C_CE_OVERRIDES_SCLR = "0" *) 
   (* C_HAS_CE = "0" *) 
   (* C_HAS_SCLR = "0" *) 
   (* C_HAS_ZERO_DETECT = "0" *) 
   (* C_LATENCY = "1" *) 
   (* C_MODEL_TYPE = "0" *) 
   (* C_MULT_TYPE = "1" *) 
   (* C_OPTIMIZE_GOAL = "1" *) 
   (* C_OUT_HIGH = "31" *) 
   (* C_OUT_LOW = "0" *) 
   (* C_ROUND_OUTPUT = "0" *) 
   (* C_ROUND_PT = "0" *) 
   (* C_VERBOSITY = "0" *) 
   (* C_XDEVICEFAMILY = "artix7" *) 
   (* DONT_TOUCH *) 
   (* downgradeipidentifiedwarnings = "yes" *) 
   mult_gen_0_mult_gen_v12_0__parameterized0 U0
       (.A(A),
        .B(B),
        .CE(1'b1),
        .CLK(CLK),
        .P(P),
        .PCASC(NLW_U0_PCASC_UNCONNECTED[47:0]),
        .SCLR(1'b0),
        .ZERO_DETECT(NLW_U0_ZERO_DETECT_UNCONNECTED[1:0]));
endmodule

(* ORIG_REF_NAME = "mult_gen_v12_0" *) (* C_VERBOSITY = "0" *) (* C_MODEL_TYPE = "0" *) 
(* C_OPTIMIZE_GOAL = "1" *) (* C_XDEVICEFAMILY = "artix7" *) (* C_HAS_CE = "0" *) 
(* C_HAS_SCLR = "0" *) (* C_LATENCY = "1" *) (* C_A_WIDTH = "16" *) 
(* C_A_TYPE = "0" *) (* C_B_WIDTH = "16" *) (* C_B_TYPE = "0" *) 
(* C_OUT_HIGH = "31" *) (* C_OUT_LOW = "0" *) (* C_MULT_TYPE = "1" *) 
(* C_CE_OVERRIDES_SCLR = "0" *) (* C_CCM_IMP = "0" *) (* C_B_VALUE = "10000001" *) 
(* C_HAS_ZERO_DETECT = "0" *) (* C_ROUND_OUTPUT = "0" *) (* C_ROUND_PT = "0" *) 
(* downgradeipidentifiedwarnings = "yes" *) 
module mult_gen_0_mult_gen_v12_0__parameterized0
   (CLK,
    A,
    B,
    CE,
    SCLR,
    ZERO_DETECT,
    P,
    PCASC);
  input CLK;
  input [15:0]A;
  input [15:0]B;
  input CE;
  input SCLR;
  output [1:0]ZERO_DETECT;
  output [31:0]P;
  output [47:0]PCASC;

  wire [15:0]A;
  wire [15:0]B;
  wire CE;
  wire CLK;
  wire [31:0]P;
  wire [47:0]PCASC;
  wire SCLR;
  wire [1:0]ZERO_DETECT;

(* C_A_TYPE = "0" *) 
   (* C_A_WIDTH = "16" *) 
   (* C_B_TYPE = "0" *) 
   (* C_B_VALUE = "10000001" *) 
   (* C_B_WIDTH = "16" *) 
   (* C_CCM_IMP = "0" *) 
   (* C_CE_OVERRIDES_SCLR = "0" *) 
   (* C_HAS_CE = "0" *) 
   (* C_HAS_SCLR = "0" *) 
   (* C_HAS_ZERO_DETECT = "0" *) 
   (* C_LATENCY = "1" *) 
   (* C_MODEL_TYPE = "0" *) 
   (* C_MULT_TYPE = "1" *) 
   (* C_OPTIMIZE_GOAL = "1" *) 
   (* C_OUT_HIGH = "31" *) 
   (* C_OUT_LOW = "0" *) 
   (* C_ROUND_OUTPUT = "0" *) 
   (* C_ROUND_PT = "0" *) 
   (* C_VERBOSITY = "0" *) 
   (* C_XDEVICEFAMILY = "artix7" *) 
   (* downgradeipidentifiedwarnings = "yes" *) 
   mult_gen_0_mult_gen_v12_0_viv__parameterized0 i_mult
       (.A(A),
        .B(B),
        .CE(CE),
        .CLK(CLK),
        .P(P),
        .PCASC(PCASC),
        .SCLR(SCLR),
        .ZERO_DETECT(ZERO_DETECT));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2014"
`pragma protect key_keyowner = "Cadence Design Systems.", key_keyname= "cds_rsa_key", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 64)
`pragma protect key_block
UyXQwkUObVrGCrQeWBRDzNzHSmxz0+tXmCDiikEzuwG7p+MOvi5now6c6XhFQHhRDLZqrTCJWGVY
uVMi7GoGag==


`pragma protect key_keyowner = "Mentor Graphics Corporation", key_keyname= "MGC-VERIF-SIM-RSA-1", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 128)
`pragma protect key_block
i5kFZPoOW4AbrHICVt04gLioHJ/lXQCVR+36ZomPa7Uhk2VGKJwiH+6I59ia5ib443IW5VCbmy/r
gnO5lAmOjOXrf+28RyOfxhyCRgHKh6mRiH0tlgZUxbFCb24jFd8F2ON6eZARrIbx4Vu5v/7L6X5o
oTd41gw6CHpypaHAd88=


`pragma protect key_keyowner = "Xilinx", key_keyname= "xilinx_2014_03", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
d4UDVzST4F/GIUQK7Q/mgyckJ8hrUJmJYmR7IrVlH2X6hv2uAAk4gpmfB6E2dVAnuOOE4STY1OeO
4QqPqvp/zC7S/aYld/u+eRjgH778AqwHmdMBU3BX1e3j2lWzDCoDQianx13lD0Ihcvv2hpUg3My9
R2dUGaAs/YrnckB0Xsyif1gPs12BFskCvSBa0HZidrW6UXqeUc5Y+Y18oAX2L10OimzYS3Jo+han
FbcTbpApf4PkFyRzckA+yzqct0XOkXLsuWu6dE34gxuaUw9BCMtj5rnbQ0G0Xote0ldMp+AIN/vj
bJafuR2HkqxTvqwCTed3PqEy4xVdmr/ecywIlw==


`pragma protect key_keyowner = "Synopsys", key_keyname= "SNPS-VCS-RSA-1", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 128)
`pragma protect key_block
ZzJe3CosxBQtdtXIXPjUB1PIjPHRzRe+TcPVuazVXoOV6QQ4DY8D8TRP6/DZEeIUzxe5gMRXz2yf
RclEq20zSfPMaB3h6L9uECxIUPiPZJ03aglicg+QjHFDLo1XgOo1ItxSaGSam80SUko6TFrRjWV7
DlVH8SFB0gTLxJpXLeU=


`pragma protect key_keyowner = "Aldec", key_keyname= "ALDEC08_001", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
k0pB4lrRLLpdtNnVRXv7qxU15dyKF9BuJVYUlIA955FRzEtgaMMCmzDybCNTUJh5QGLsvLYdRVSK
VcBOlgtImwe2FJEsDE/buKE8+W7HPOSiP0Elo4jDRWfwpueOq6VQ4zL5XMAGi+70gMxxGQr7Z5E8
4lvDxjOzkqAIn3EC1esPBOdcmzCt1V55YsxrHdN/eAnUWBvEPaGJfoZKGT4IZ1fx0hJCdrrnel+V
0HuJqYSPOCB8SJpuoB2p3Y1d93yF5xcy8wSWeVWgM3E2z++VHQIjT4DTFlyqNFbe2YxMhMTY8SGk
pV+7oyzvQjUyYpAt0GiJuzwTVRTBCgpo3qFmbw==


`pragma protect key_keyowner = "Mentor Graphics Corporation", key_keyname= "MGC-PREC-RSA", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
GudvFIF1LJpYJM0m/TFop7CidVgjy9fN6Ey6sfUtoVP/ExlZFIIva5TU9Y3O6BQLI3w2Bduh0cyw
4NcbEs/zGII6wdxa6MMJ7igFrm1fbOXMVufmW5JNAMwdeyy0o8wr7FRwhcGdL0QPHwmkfZz9r1Hk
QKBbvVOBByxZ5DnFb7ksN8pk4JyBLGgdQvLvOsn9lChiBl7tj/DagCu6VQqgoWzqwhAPZH7VLSHS
EXz43jhomwTTbusYFqDUBT4lAICjK0dAg2pOnroIWiq28IF0acN9O8i229eMa1uOnjLTi67iqZ3u
QQc7rE/7+bK1tttJbNdqc9PsfjPILNssyLpuzQ==


`pragma protect key_keyowner = "Synplicity", key_keyname= "SYNP05_001", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
uekaTxR+n55Hl3alM3upNnIm+fzb2P7kjyYoHG3kEyYFzNH9SJzP5ZG/ywxtal/q/DBSScOpj44z
RlDdaMpzCGS88gh6dEl3yFyWw2qnX5V8c9OhCkB2j5ppj8jnlVJKDxjvryMrpwg12LvtnHrNnImW
7Ae1yRZ88xjoh0Kp3ojHMH0k+IYPNTc8YMfAnzd5VmzlxcHa4dI9WPAjLvAiKKLbj/GutRinjGze
HVzuVSC6xec9COMeBVpfnSG1+zQB1etOjhJAxzXbDN8camKPk2sLWPb+WOKwirt490KDP69WIGaC
15X3U3axMPjiPLon3XBMFcwMU3FaIA16lcjHdg==


`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 7184)
`pragma protect data_block
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
yNU=
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
