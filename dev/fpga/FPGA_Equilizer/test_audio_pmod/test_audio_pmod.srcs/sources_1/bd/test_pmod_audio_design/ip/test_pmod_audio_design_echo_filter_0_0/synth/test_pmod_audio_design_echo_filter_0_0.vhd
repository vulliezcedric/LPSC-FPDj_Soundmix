-- (c) Copyright 1995-2015 Xilinx, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
-- 
-- DO NOT MODIFY THIS FILE.

-- IP VLNV: xilinx.com:ip:echo_filter:1.0
-- IP Revision: 3

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY test_pmod_audio_design_echo_filter_0_0 IS
  PORT (
    Clk_i : IN STD_LOGIC;
    Data_o : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
    Enable_i : IN STD_LOGIC;
    Reset_i : IN STD_LOGIC;
    data_in : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
    fifo_count_o : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
    fifo_read_EN_i : IN STD_LOGIC
  );
END test_pmod_audio_design_echo_filter_0_0;

ARCHITECTURE test_pmod_audio_design_echo_filter_0_0_arch OF test_pmod_audio_design_echo_filter_0_0 IS
  ATTRIBUTE DowngradeIPIdentifiedWarnings : string;
  ATTRIBUTE DowngradeIPIdentifiedWarnings OF test_pmod_audio_design_echo_filter_0_0_arch: ARCHITECTURE IS "yes";

  COMPONENT echo IS
    PORT (
      Clk_i : IN STD_LOGIC;
      Data_o : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
      Enable_i : IN STD_LOGIC;
      Reset_i : IN STD_LOGIC;
      data_in : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
      fifo_count_o : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
      fifo_read_EN_i : IN STD_LOGIC
    );
  END COMPONENT echo;
  ATTRIBUTE X_CORE_INFO : STRING;
  ATTRIBUTE X_CORE_INFO OF test_pmod_audio_design_echo_filter_0_0_arch: ARCHITECTURE IS "echo,Vivado 2014.4";
  ATTRIBUTE CHECK_LICENSE_TYPE : STRING;
  ATTRIBUTE CHECK_LICENSE_TYPE OF test_pmod_audio_design_echo_filter_0_0_arch : ARCHITECTURE IS "test_pmod_audio_design_echo_filter_0_0,echo,{}";
  ATTRIBUTE CORE_GENERATION_INFO : STRING;
  ATTRIBUTE CORE_GENERATION_INFO OF test_pmod_audio_design_echo_filter_0_0_arch: ARCHITECTURE IS "test_pmod_audio_design_echo_filter_0_0,echo,{x_ipProduct=Vivado 2014.4,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=echo_filter,x_ipVersion=1.0,x_ipCoreRevision=3,x_ipLanguage=VHDL,x_ipSimLanguage=MIXED}";
  ATTRIBUTE X_INTERFACE_INFO : STRING;
  ATTRIBUTE X_INTERFACE_INFO OF Clk_i: SIGNAL IS "xilinx.com:signal:clock:1.0 CLK.Clk_i CLK";
  ATTRIBUTE X_INTERFACE_INFO OF Data_o: SIGNAL IS "xilinx.com:signal:data:1.0 DATA.Data_o DATA";
  ATTRIBUTE X_INTERFACE_INFO OF Reset_i: SIGNAL IS "xilinx.com:signal:reset:1.0 RST.Reset_i RST";
  ATTRIBUTE X_INTERFACE_INFO OF data_in: SIGNAL IS "xilinx.com:signal:data:1.0 DATA.data_in DATA";
  ATTRIBUTE X_INTERFACE_INFO OF fifo_count_o: SIGNAL IS "xilinx.com:signal:data:1.0 DATA.fifo_count_o DATA";
  ATTRIBUTE X_INTERFACE_INFO OF fifo_read_EN_i: SIGNAL IS "xilinx.com:signal:data:1.0 DATA.fifo_read_EN_i DATA";
BEGIN
  U0 : echo
    PORT MAP (
      Clk_i => Clk_i,
      Data_o => Data_o,
      Enable_i => Enable_i,
      Reset_i => Reset_i,
      data_in => data_in,
      fifo_count_o => fifo_count_o,
      fifo_read_EN_i => fifo_read_EN_i
    );
END test_pmod_audio_design_echo_filter_0_0_arch;
