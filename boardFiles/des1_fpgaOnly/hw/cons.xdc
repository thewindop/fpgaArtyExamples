set_property -dict { PACKAGE_PIN R15   IOSTANDARD LVCMOS33 } [get_ports { uart_cano_rxd }]; #IO_L13N_T2_MRCC_14 Sch=ck_io[32]
set_property -dict { PACKAGE_PIN P15   IOSTANDARD LVCMOS33 } [get_ports { uart_cano_txd }]; #IO_L13P_T2_MRCC_14 Sch=ck_io[33]
set_property -dict { PACKAGE_PIN G18   IOSTANDARD LVCMOS33 } [get_ports { eth_ref_clk   }]; #IO_L22P_T3_A17_15 Sch=eth_ref_clk

set_property -dict { PACKAGE_PIN R16   IOSTANDARD LVCMOS33 } [get_ports { uart_01_rxd }]; # #IO_L15P_T2_DQS_RDWR_B_14 Sch=ck_io[34]
set_property -dict { PACKAGE_PIN N16   IOSTANDARD LVCMOS33 } [get_ports { uart_01_txd }]; # #IO_L11N_T1_SRCC_14 Sch=ck_io[35]
set_property -dict { PACKAGE_PIN N14   IOSTANDARD LVCMOS33 } [get_ports { uart_03_rxd }]; # #IO_L8P_T1_D11_14 Sch=ck_io[36]
set_property -dict { PACKAGE_PIN U17   IOSTANDARD LVCMOS33 } [get_ports { uart_03_txd }]; # #IO_L17P_T2_A14_D30_14 Sch=ck_io[37]

set_property -dict { PACKAGE_PIN T18   IOSTANDARD LVCMOS33 } [get_ports { wake_sw }]; #IO_L7N_T1_D10_14 Sch=ck_io[38]
