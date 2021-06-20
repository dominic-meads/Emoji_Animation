## Clock Signal
set_property -dict { PACKAGE_PIN H16    IOSTANDARD LVCMOS33 } [get_ports { i_clk_125MHz_0 }]; #IO_L13P_T2_MRCC_35 Sch=SYSCLK
create_clock -add -name sys_clk_pin -period 8.00 -waveform {0 4} [get_ports { i_clk_125MHz_0 }];#set

## Pmod ports for PmodVGA
# Pmod Header JA
set_property -dict { PACKAGE_PIN Y18   IOSTANDARD LVCMOS33 } [get_ports { o_red_0[0] }]; #IO_L17P_T2_34 Sch=JA1_P  PIN 1
set_property -dict { PACKAGE_PIN Y19   IOSTANDARD LVCMOS33 } [get_ports { o_red_0[1] }]; #IO_L17N_T2_34 Sch=JA1_N  PIN 2
set_property -dict { PACKAGE_PIN Y16   IOSTANDARD LVCMOS33 } [get_ports { o_red_0[2] }]; #IO_L7P_T1_34 Sch=JA2_P   PIN 3
set_property -dict { PACKAGE_PIN Y17   IOSTANDARD LVCMOS33 } [get_ports { o_red_0[3] }]; #IO_L7N_T1_34 Sch=JA2_N   PIN 4
set_property -dict { PACKAGE_PIN U18   IOSTANDARD LVCMOS33 } [get_ports { o_blue_0[0] }]; #IO_L12P_T1_MRCC_34 Sch=JA3_P  PIN 7
set_property -dict { PACKAGE_PIN U19   IOSTANDARD LVCMOS33 } [get_ports { o_blue_0[1] }]; #IO_L12N_T1_MRCC_34 Sch=JA3_N  PIN 8
set_property -dict { PACKAGE_PIN W18   IOSTANDARD LVCMOS33 } [get_ports { o_blue_0[2] }]; #IO_L22P_T3_34 Sch=JA4_P  PIN 9
set_property -dict { PACKAGE_PIN W19   IOSTANDARD LVCMOS33 } [get_ports { o_blue_0[3] }]; #IO_L22N_T3_34 Sch=JA4_N  PIN 10

# Pmod Header JB
set_property -dict { PACKAGE_PIN W14   IOSTANDARD LVCMOS33 } [get_ports { o_green_0[0] }]; #IO_L8P_T1_34 Sch=JB1_P  PIN 1
set_property -dict { PACKAGE_PIN Y14   IOSTANDARD LVCMOS33 } [get_ports { o_green_0[1] }]; #IO_L8N_T1_34 Sch=JB1_N  PIN 2
set_property -dict { PACKAGE_PIN T11   IOSTANDARD LVCMOS33 } [get_ports { o_green_0[2] }]; #IO_L1P_T0_34 Sch=JB2_P  PIN 3
set_property -dict { PACKAGE_PIN T10   IOSTANDARD LVCMOS33 } [get_ports { o_green_0[3] }]; #IO_L1N_T0_34 Sch=JB2_N  PIN 4
set_property -dict { PACKAGE_PIN V16   IOSTANDARD LVCMOS33 } [get_ports { o_hsync_0 }]; #IO_L18P_T2_34 Sch=JB3_P  PIN 7
set_property -dict { PACKAGE_PIN W16   IOSTANDARD LVCMOS33 } [get_ports { o_vsync_0 }]; #IO_L18N_T2_34 Sch=JB3_N  PIN 8 
