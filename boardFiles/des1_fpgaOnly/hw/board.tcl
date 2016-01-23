
################################################################
# This is a generated script based on design: arty_ctrl
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2015.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   puts "ERROR: This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source arty_ctrl_script.tcl

# If you do not already have a project created,
# you can create a project using the following command:
#    create_project project_1 myproj -part xc7a35ticsg324-1L
#    set_property BOARD_PART digilentinc.com:arty:part0:1.1 [current_project]

# CHECKING IF PROJECT EXISTS
if { [get_projects -quiet] eq "" } {
   puts "ERROR: Please open or create a project!"
   return 1
}



# CHANGE DESIGN NAME HERE
set design_name arty_ctrl

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "ERROR: Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      puts "INFO: Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   puts "INFO: Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "ERROR: Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "ERROR: Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   puts "INFO: Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   puts "INFO: Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

puts "INFO: Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   puts $errMsg
   return $nRet
}

##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: microblaze_0_local_memory
proc create_hier_cell_microblaze_0_local_memory { parentCell nameHier } {

  if { $parentCell eq "" || $nameHier eq "" } {
     puts "ERROR: create_hier_cell_microblaze_0_local_memory() - Empty argument(s)!"
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     puts "ERROR: Unable to find parent cell <$parentCell>!"
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     puts "ERROR: Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode MirroredMaster -vlnv xilinx.com:interface:lmb_rtl:1.0 DLMB
  create_bd_intf_pin -mode MirroredMaster -vlnv xilinx.com:interface:lmb_rtl:1.0 ILMB

  # Create pins
  create_bd_pin -dir I -type clk LMB_Clk
  create_bd_pin -dir I -from 0 -to 0 -type rst SYS_Rst

  # Create instance: dlmb_bram_if_cntlr, and set properties
  set dlmb_bram_if_cntlr [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 dlmb_bram_if_cntlr ]
  set_property -dict [ list CONFIG.C_ECC {0}  ] $dlmb_bram_if_cntlr

  # Create instance: dlmb_v10, and set properties
  set dlmb_v10 [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 dlmb_v10 ]

  # Create instance: ilmb_bram_if_cntlr, and set properties
  set ilmb_bram_if_cntlr [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 ilmb_bram_if_cntlr ]
  set_property -dict [ list CONFIG.C_ECC {0}  ] $ilmb_bram_if_cntlr

  # Create instance: ilmb_v10, and set properties
  set ilmb_v10 [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 ilmb_v10 ]

  # Create instance: lmb_bram, and set properties
  set lmb_bram [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.2 lmb_bram ]
  set_property -dict [ list CONFIG.Memory_Type {True_Dual_Port_RAM} CONFIG.use_bram_block {BRAM_Controller}  ] $lmb_bram

  # Create interface connections
  connect_bd_intf_net -intf_net microblaze_0_dlmb [get_bd_intf_pins DLMB] [get_bd_intf_pins dlmb_v10/LMB_M]
  connect_bd_intf_net -intf_net microblaze_0_dlmb_bus [get_bd_intf_pins dlmb_bram_if_cntlr/SLMB] [get_bd_intf_pins dlmb_v10/LMB_Sl_0]
  connect_bd_intf_net -intf_net microblaze_0_dlmb_cntlr [get_bd_intf_pins dlmb_bram_if_cntlr/BRAM_PORT] [get_bd_intf_pins lmb_bram/BRAM_PORTA]
  connect_bd_intf_net -intf_net microblaze_0_ilmb [get_bd_intf_pins ILMB] [get_bd_intf_pins ilmb_v10/LMB_M]
  connect_bd_intf_net -intf_net microblaze_0_ilmb_bus [get_bd_intf_pins ilmb_bram_if_cntlr/SLMB] [get_bd_intf_pins ilmb_v10/LMB_Sl_0]
  connect_bd_intf_net -intf_net microblaze_0_ilmb_cntlr [get_bd_intf_pins ilmb_bram_if_cntlr/BRAM_PORT] [get_bd_intf_pins lmb_bram/BRAM_PORTB]

  # Create port connections
  connect_bd_net -net SYS_Rst_1 [get_bd_pins SYS_Rst] [get_bd_pins dlmb_bram_if_cntlr/LMB_Rst] [get_bd_pins dlmb_v10/SYS_Rst] [get_bd_pins ilmb_bram_if_cntlr/LMB_Rst] [get_bd_pins ilmb_v10/SYS_Rst]
  connect_bd_net -net microblaze_0_Clk [get_bd_pins LMB_Clk] [get_bd_pins dlmb_bram_if_cntlr/LMB_Clk] [get_bd_pins dlmb_v10/LMB_Clk] [get_bd_pins ilmb_bram_if_cntlr/LMB_Clk] [get_bd_pins ilmb_v10/LMB_Clk]
  
  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: wrapper
proc create_hier_cell_wrapper { parentCell nameHier } {

  if { $parentCell eq "" || $nameHier eq "" } {
     puts "ERROR: create_hier_cell_wrapper() - Empty argument(s)!"
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     puts "ERROR: Unable to find parent cell <$parentCell>!"
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     puts "ERROR: Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M00_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M01_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M02_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M03_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M04_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M05_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M06_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M07_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M08_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M09_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M10_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M11_AXI
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S00_AXI

  # Create pins
  create_bd_pin -dir I -from 0 -to 0 -type rst ARESETN
  create_bd_pin -dir I -from 0 -to 0 -type rst M00_ARESETN
  create_bd_pin -dir I -type clk S00_ACLK

  # Create instance: microblaze_0_axi_periph, and set properties
  set microblaze_0_axi_periph [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 microblaze_0_axi_periph ]
  set_property -dict [ list CONFIG.NUM_MI {12}  ] $microblaze_0_axi_periph

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins M07_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M07_AXI]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins M03_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M03_AXI]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins M04_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M04_AXI]
  connect_bd_intf_net -intf_net Conn4 [get_bd_intf_pins M05_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M05_AXI]
  connect_bd_intf_net -intf_net Conn5 [get_bd_intf_pins M02_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M02_AXI]
  connect_bd_intf_net -intf_net Conn6 [get_bd_intf_pins M06_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M06_AXI]
  connect_bd_intf_net -intf_net Conn7 [get_bd_intf_pins M01_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M01_AXI]
  connect_bd_intf_net -intf_net Conn8 [get_bd_intf_pins M00_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M00_AXI]
  connect_bd_intf_net -intf_net Conn9 [get_bd_intf_pins S00_AXI] [get_bd_intf_pins microblaze_0_axi_periph/S00_AXI]
  connect_bd_intf_net -intf_net Conn10 [get_bd_intf_pins M08_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M08_AXI]
  connect_bd_intf_net -intf_net Conn11 [get_bd_intf_pins M09_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M09_AXI]
  connect_bd_intf_net -intf_net Conn12 [get_bd_intf_pins M10_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M10_AXI]
  connect_bd_intf_net -intf_net Conn13 [get_bd_intf_pins M11_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M11_AXI]

  # Create port connections
  connect_bd_net -net ARESETN_1 [get_bd_pins ARESETN] [get_bd_pins microblaze_0_axi_periph/ARESETN]
  connect_bd_net -net M00_ARESETN_1 [get_bd_pins M00_ARESETN] [get_bd_pins microblaze_0_axi_periph/M00_ARESETN] [get_bd_pins microblaze_0_axi_periph/M01_ARESETN] [get_bd_pins microblaze_0_axi_periph/M02_ARESETN] [get_bd_pins microblaze_0_axi_periph/M03_ARESETN] [get_bd_pins microblaze_0_axi_periph/M04_ARESETN] [get_bd_pins microblaze_0_axi_periph/M05_ARESETN] [get_bd_pins microblaze_0_axi_periph/M06_ARESETN] [get_bd_pins microblaze_0_axi_periph/M07_ARESETN] [get_bd_pins microblaze_0_axi_periph/M08_ARESETN] [get_bd_pins microblaze_0_axi_periph/M09_ARESETN] [get_bd_pins microblaze_0_axi_periph/M10_ARESETN] [get_bd_pins microblaze_0_axi_periph/M11_ARESETN] [get_bd_pins microblaze_0_axi_periph/S00_ARESETN]
  connect_bd_net -net S00_ACLK_1 [get_bd_pins S00_ACLK] [get_bd_pins microblaze_0_axi_periph/ACLK] [get_bd_pins microblaze_0_axi_periph/M00_ACLK] [get_bd_pins microblaze_0_axi_periph/M01_ACLK] [get_bd_pins microblaze_0_axi_periph/M02_ACLK] [get_bd_pins microblaze_0_axi_periph/M03_ACLK] [get_bd_pins microblaze_0_axi_periph/M04_ACLK] [get_bd_pins microblaze_0_axi_periph/M05_ACLK] [get_bd_pins microblaze_0_axi_periph/M06_ACLK] [get_bd_pins microblaze_0_axi_periph/M07_ACLK] [get_bd_pins microblaze_0_axi_periph/M08_ACLK] [get_bd_pins microblaze_0_axi_periph/M09_ACLK] [get_bd_pins microblaze_0_axi_periph/M10_ACLK] [get_bd_pins microblaze_0_axi_periph/M11_ACLK] [get_bd_pins microblaze_0_axi_periph/S00_ACLK]
  
  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: uBlaze
proc create_hier_cell_uBlaze { parentCell nameHier } {

  if { $parentCell eq "" || $nameHier eq "" } {
     puts "ERROR: create_hier_cell_uBlaze() - Empty argument(s)!"
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     puts "ERROR: Unable to find parent cell <$parentCell>!"
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     puts "ERROR: Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI_DP
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi

  # Create pins
  create_bd_pin -dir I -type clk Clk
  create_bd_pin -dir O -type rst Debug_SYS_Rst
  create_bd_pin -dir I -type rst Reset
  create_bd_pin -dir I -from 0 -to 0 -type rst SYS_Rst
  create_bd_pin -dir I -from 8 -to 0 -type intr intr
  create_bd_pin -dir I -from 0 -to 0 -type rst s_axi_aresetn

  # Create instance: mdm_1, and set properties
  set mdm_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:mdm:3.2 mdm_1 ]

  # Create instance: microblaze_0, and set properties
  set microblaze_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:9.5 microblaze_0 ]
  set_property -dict [ list CONFIG.C_CACHE_BYTE_SIZE {8192} CONFIG.C_DCACHE_BYTE_SIZE {8192} CONFIG.C_DEBUG_ENABLED {1} CONFIG.C_D_AXI {1} CONFIG.C_D_LMB {1} CONFIG.C_I_LMB {1} CONFIG.C_USE_DCACHE {0} CONFIG.C_USE_ICACHE {0}  ] $microblaze_0

  # Create instance: microblaze_0_axi_intc, and set properties
  set microblaze_0_axi_intc [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 microblaze_0_axi_intc ]
  set_property -dict [ list CONFIG.C_HAS_FAST {1}  ] $microblaze_0_axi_intc

  # Create instance: microblaze_0_local_memory
  create_hier_cell_microblaze_0_local_memory $hier_obj microblaze_0_local_memory

  # Create interface connections
  connect_bd_intf_net -intf_net microblaze_0_axi_dp [get_bd_intf_pins M_AXI_DP] [get_bd_intf_pins microblaze_0/M_AXI_DP]
  connect_bd_intf_net -intf_net microblaze_0_debug [get_bd_intf_pins mdm_1/MBDEBUG_0] [get_bd_intf_pins microblaze_0/DEBUG]
  connect_bd_intf_net -intf_net microblaze_0_dlmb_1 [get_bd_intf_pins microblaze_0/DLMB] [get_bd_intf_pins microblaze_0_local_memory/DLMB]
  connect_bd_intf_net -intf_net microblaze_0_ilmb_1 [get_bd_intf_pins microblaze_0/ILMB] [get_bd_intf_pins microblaze_0_local_memory/ILMB]
  connect_bd_intf_net -intf_net microblaze_0_intc_axi [get_bd_intf_pins s_axi] [get_bd_intf_pins microblaze_0_axi_intc/s_axi]
  connect_bd_intf_net -intf_net microblaze_0_interrupt [get_bd_intf_pins microblaze_0/INTERRUPT] [get_bd_intf_pins microblaze_0_axi_intc/interrupt]

  # Create port connections
  connect_bd_net -net mdm_1_debug_sys_rst [get_bd_pins Debug_SYS_Rst] [get_bd_pins mdm_1/Debug_SYS_Rst]
  connect_bd_net -net microblaze_0_Clk [get_bd_pins Clk] [get_bd_pins microblaze_0/Clk] [get_bd_pins microblaze_0_axi_intc/processor_clk] [get_bd_pins microblaze_0_axi_intc/s_axi_aclk] [get_bd_pins microblaze_0_local_memory/LMB_Clk]
  connect_bd_net -net microblaze_0_intr [get_bd_pins intr] [get_bd_pins microblaze_0_axi_intc/intr]
  connect_bd_net -net rst_clk_wiz_1_100M_bus_struct_reset [get_bd_pins SYS_Rst] [get_bd_pins microblaze_0_local_memory/SYS_Rst]
  connect_bd_net -net rst_clk_wiz_1_100M_mb_reset [get_bd_pins Reset] [get_bd_pins microblaze_0/Reset] [get_bd_pins microblaze_0_axi_intc/processor_rst]
  connect_bd_net -net rst_clk_wiz_1_100M_peripheral_aresetn [get_bd_pins s_axi_aresetn] [get_bd_pins microblaze_0_axi_intc/s_axi_aresetn]
  
  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: ioBlocks
proc create_hier_cell_ioBlocks { parentCell nameHier } {

  if { $parentCell eq "" || $nameHier eq "" } {
     puts "ERROR: create_hier_cell_ioBlocks() - Empty argument(s)!"
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     puts "ERROR: Unable to find parent cell <$parentCell>!"
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     puts "ERROR: Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 IIC
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M00_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 MDIO
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 MII
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S00_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 dip_switches_4bits
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 led_4bits
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 pushbuttons
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 rgb_led
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 uart_01
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 uart_03
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 uart_cano
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 usb_uart

  # Create pins
  create_bd_pin -dir I -from 0 -to 0 -type rst ARESETN
  create_bd_pin -dir O -from 8 -to 0 dout
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir I -from 0 -to 0 -type rst s_axi_aresetn

  # Create instance: axi_ethernetlite_0, and set properties
  set axi_ethernetlite_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernetlite:3.0 axi_ethernetlite_0 ]
  set_property -dict [ list CONFIG.MDIO_BOARD_INTERFACE {eth_mdio_mdc} CONFIG.MII_BOARD_INTERFACE {eth_mii} CONFIG.USE_BOARD_FLOW {true}  ] $axi_ethernetlite_0

  # Create instance: axi_gpio_0, and set properties
  set axi_gpio_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_0 ]
  set_property -dict [ list CONFIG.C_INTERRUPT_PRESENT {1} CONFIG.GPIO_BOARD_INTERFACE {dip_switches_4bits} CONFIG.USE_BOARD_FLOW {true}  ] $axi_gpio_0

  # Create instance: axi_gpio_1, and set properties
  set axi_gpio_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_1 ]
  set_property -dict [ list CONFIG.C_ALL_INPUTS {0} CONFIG.C_ALL_OUTPUTS {1} CONFIG.C_GPIO_WIDTH {12} CONFIG.GPIO_BOARD_INTERFACE {rgb_led} CONFIG.USE_BOARD_FLOW {true}  ] $axi_gpio_1

  # Create instance: axi_gpio_2, and set properties
  set axi_gpio_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_2 ]
  set_property -dict [ list CONFIG.C_ALL_INPUTS {0} CONFIG.C_ALL_OUTPUTS {1} CONFIG.GPIO_BOARD_INTERFACE {led_4bits} CONFIG.USE_BOARD_FLOW {true}  ] $axi_gpio_2

  # Create instance: axi_gpio_3, and set properties
  set axi_gpio_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_3 ]
  set_property -dict [ list CONFIG.C_ALL_INPUTS {1} CONFIG.C_GPIO_WIDTH {4} CONFIG.C_INTERRUPT_PRESENT {1} CONFIG.GPIO_BOARD_INTERFACE {push_buttons_4bits}  ] $axi_gpio_3

  # Create instance: axi_iic_0, and set properties
  set axi_iic_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.0 axi_iic_0 ]
  set_property -dict [ list CONFIG.IIC_BOARD_INTERFACE {i2c} CONFIG.USE_BOARD_FLOW {true}  ] $axi_iic_0

  # Create instance: axi_timer_0, and set properties
  set axi_timer_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_timer:2.0 axi_timer_0 ]

  # Create instance: axi_uartlite_0, and set properties
  set axi_uartlite_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 axi_uartlite_0 ]
  set_property -dict [ list CONFIG.UARTLITE_BOARD_INTERFACE {usb_uart} CONFIG.USE_BOARD_FLOW {true}  ] $axi_uartlite_0

  # Create instance: axi_uartlite_1, and set properties
  set axi_uartlite_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 axi_uartlite_1 ]
  set_property -dict [ list CONFIG.UARTLITE_BOARD_INTERFACE {Custom} CONFIG.USE_BOARD_FLOW {true}  ] $axi_uartlite_1

  # Create instance: axi_uartlite_2, and set properties
  set axi_uartlite_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 axi_uartlite_2 ]
  set_property -dict [ list CONFIG.UARTLITE_BOARD_INTERFACE {Custom} CONFIG.USE_BOARD_FLOW {true}  ] $axi_uartlite_2

  # Create instance: axi_uartlite_3, and set properties
  set axi_uartlite_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 axi_uartlite_3 ]
  set_property -dict [ list CONFIG.C_BAUDRATE {115200} CONFIG.UARTLITE_BOARD_INTERFACE {Custom} CONFIG.USE_BOARD_FLOW {true}  ] $axi_uartlite_3

  # Create instance: microblaze_0_xlconcat, and set properties
  set microblaze_0_xlconcat [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 microblaze_0_xlconcat ]
  set_property -dict [ list CONFIG.NUM_PORTS {9}  ] $microblaze_0_xlconcat

  # Create instance: wrapper
  create_hier_cell_wrapper $hier_obj wrapper

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins dip_switches_4bits] [get_bd_intf_pins axi_gpio_0/GPIO]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins rgb_led] [get_bd_intf_pins axi_gpio_1/GPIO]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins led_4bits] [get_bd_intf_pins axi_gpio_2/GPIO]
  connect_bd_intf_net -intf_net Conn7 [get_bd_intf_pins IIC] [get_bd_intf_pins axi_iic_0/IIC]
  connect_bd_intf_net -intf_net axi_ethernetlite_0_MDIO [get_bd_intf_pins MDIO] [get_bd_intf_pins axi_ethernetlite_0/MDIO]
  connect_bd_intf_net -intf_net axi_ethernetlite_0_MII [get_bd_intf_pins MII] [get_bd_intf_pins axi_ethernetlite_0/MII]
  connect_bd_intf_net -intf_net axi_gpio_3_GPIO [get_bd_intf_pins pushbuttons] [get_bd_intf_pins axi_gpio_3/GPIO]
  connect_bd_intf_net -intf_net axi_uartlite_0_UART [get_bd_intf_pins usb_uart] [get_bd_intf_pins axi_uartlite_0/UART]
  connect_bd_intf_net -intf_net axi_uartlite_1_UART [get_bd_intf_pins uart_01] [get_bd_intf_pins axi_uartlite_1/UART]
  connect_bd_intf_net -intf_net axi_uartlite_2_UART [get_bd_intf_pins uart_cano] [get_bd_intf_pins axi_uartlite_2/UART]
  connect_bd_intf_net -intf_net axi_uartlite_3_UART [get_bd_intf_pins uart_03] [get_bd_intf_pins axi_uartlite_3/UART]
  connect_bd_intf_net -intf_net s_axi_1 [get_bd_intf_pins M00_AXI] [get_bd_intf_pins wrapper/M00_AXI]
  connect_bd_intf_net -intf_net uBlaze_M_AXI_DP [get_bd_intf_pins S00_AXI] [get_bd_intf_pins wrapper/S00_AXI]
  connect_bd_intf_net -intf_net wrapper_M01_AXI [get_bd_intf_pins axi_uartlite_0/S_AXI] [get_bd_intf_pins wrapper/M01_AXI]
  connect_bd_intf_net -intf_net wrapper_M02_AXI [get_bd_intf_pins axi_gpio_1/S_AXI] [get_bd_intf_pins wrapper/M02_AXI]
  connect_bd_intf_net -intf_net wrapper_M03_AXI [get_bd_intf_pins axi_gpio_0/S_AXI] [get_bd_intf_pins wrapper/M03_AXI]
  connect_bd_intf_net -intf_net wrapper_M04_AXI [get_bd_intf_pins axi_gpio_2/S_AXI] [get_bd_intf_pins wrapper/M04_AXI]
  connect_bd_intf_net -intf_net wrapper_M05_AXI [get_bd_intf_pins axi_uartlite_1/S_AXI] [get_bd_intf_pins wrapper/M05_AXI]
  connect_bd_intf_net -intf_net wrapper_M06_AXI [get_bd_intf_pins axi_timer_0/S_AXI] [get_bd_intf_pins wrapper/M06_AXI]
  connect_bd_intf_net -intf_net wrapper_M07_AXI [get_bd_intf_pins axi_ethernetlite_0/S_AXI] [get_bd_intf_pins wrapper/M07_AXI]
  connect_bd_intf_net -intf_net wrapper_M08_AXI [get_bd_intf_pins axi_uartlite_3/S_AXI] [get_bd_intf_pins wrapper/M08_AXI]
  connect_bd_intf_net -intf_net wrapper_M09_AXI [get_bd_intf_pins axi_uartlite_2/S_AXI] [get_bd_intf_pins wrapper/M09_AXI]
  connect_bd_intf_net -intf_net wrapper_M10_AXI [get_bd_intf_pins axi_iic_0/S_AXI] [get_bd_intf_pins wrapper/M10_AXI]
  connect_bd_intf_net -intf_net wrapper_M11_AXI [get_bd_intf_pins axi_gpio_3/S_AXI] [get_bd_intf_pins wrapper/M11_AXI]

  # Create port connections
  connect_bd_net -net axi_ethernetlite_0_ip2intc_irpt [get_bd_pins axi_ethernetlite_0/ip2intc_irpt] [get_bd_pins microblaze_0_xlconcat/In3]
  connect_bd_net -net axi_gpio_0_ip2intc_irpt [get_bd_pins axi_gpio_0/ip2intc_irpt] [get_bd_pins microblaze_0_xlconcat/In4]
  connect_bd_net -net axi_gpio_3_ip2intc_irpt [get_bd_pins axi_gpio_3/ip2intc_irpt] [get_bd_pins microblaze_0_xlconcat/In8]
  connect_bd_net -net axi_iic_0_iic2intc_irpt [get_bd_pins axi_iic_0/iic2intc_irpt] [get_bd_pins microblaze_0_xlconcat/In7]
  connect_bd_net -net axi_timer_0_interrupt [get_bd_pins axi_timer_0/interrupt] [get_bd_pins microblaze_0_xlconcat/In2]
  connect_bd_net -net axi_uartlite_0_interrupt [get_bd_pins axi_uartlite_0/interrupt] [get_bd_pins microblaze_0_xlconcat/In0]
  connect_bd_net -net axi_uartlite_1_interrupt [get_bd_pins axi_uartlite_1/interrupt] [get_bd_pins microblaze_0_xlconcat/In1]
  connect_bd_net -net axi_uartlite_2_interrupt [get_bd_pins axi_uartlite_2/interrupt] [get_bd_pins microblaze_0_xlconcat/In6]
  connect_bd_net -net axi_uartlite_3_interrupt [get_bd_pins axi_uartlite_3/interrupt] [get_bd_pins microblaze_0_xlconcat/In5]
  connect_bd_net -net microblaze_0_Clk [get_bd_pins s_axi_aclk] [get_bd_pins axi_ethernetlite_0/s_axi_aclk] [get_bd_pins axi_gpio_0/s_axi_aclk] [get_bd_pins axi_gpio_1/s_axi_aclk] [get_bd_pins axi_gpio_2/s_axi_aclk] [get_bd_pins axi_gpio_3/s_axi_aclk] [get_bd_pins axi_iic_0/s_axi_aclk] [get_bd_pins axi_timer_0/s_axi_aclk] [get_bd_pins axi_uartlite_0/s_axi_aclk] [get_bd_pins axi_uartlite_1/s_axi_aclk] [get_bd_pins axi_uartlite_2/s_axi_aclk] [get_bd_pins axi_uartlite_3/s_axi_aclk] [get_bd_pins wrapper/S00_ACLK]
  connect_bd_net -net microblaze_0_intr [get_bd_pins dout] [get_bd_pins microblaze_0_xlconcat/dout]
  connect_bd_net -net rst_clk_wiz_1_100M_interconnect_aresetn [get_bd_pins ARESETN] [get_bd_pins wrapper/ARESETN]
  connect_bd_net -net rst_clk_wiz_1_100M_peripheral_aresetn [get_bd_pins s_axi_aresetn] [get_bd_pins axi_ethernetlite_0/s_axi_aresetn] [get_bd_pins axi_gpio_0/s_axi_aresetn] [get_bd_pins axi_gpio_1/s_axi_aresetn] [get_bd_pins axi_gpio_2/s_axi_aresetn] [get_bd_pins axi_gpio_3/s_axi_aresetn] [get_bd_pins axi_iic_0/s_axi_aresetn] [get_bd_pins axi_timer_0/s_axi_aresetn] [get_bd_pins axi_uartlite_0/s_axi_aresetn] [get_bd_pins axi_uartlite_1/s_axi_aresetn] [get_bd_pins axi_uartlite_2/s_axi_aresetn] [get_bd_pins axi_uartlite_3/s_axi_aresetn] [get_bd_pins wrapper/M00_ARESETN]
  
  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: clkReset
proc create_hier_cell_clkReset { parentCell nameHier } {

  if { $parentCell eq "" || $nameHier eq "" } {
     puts "ERROR: create_hier_cell_clkReset() - Empty argument(s)!"
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     puts "ERROR: Unable to find parent cell <$parentCell>!"
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     puts "ERROR: Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins

  # Create pins
  create_bd_pin -dir O -from 0 -to 0 -type rst bus_struct_reset
  create_bd_pin -dir O -type clk clk_100m
  create_bd_pin -dir O -type clk clk_166m667
  create_bd_pin -dir O -type clk clk_200m
  create_bd_pin -dir I -type clk clk_in1
  create_bd_pin -dir O eth_ref_clk
  create_bd_pin -dir I -type rst ext_reset_in
  create_bd_pin -dir O -from 0 -to 0 -type rst interconnect_aresetn
  create_bd_pin -dir I -type rst mb_debug_sys_rst
  create_bd_pin -dir O -type rst mb_reset
  create_bd_pin -dir O -from 0 -to 0 -type rst peripheral_aresetn

  # Create instance: clk_wiz_1, and set properties
  set clk_wiz_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:5.1 clk_wiz_1 ]
  set_property -dict [ list CONFIG.CLKOUT2_JITTER {118.758} \
CONFIG.CLKOUT2_PHASE_ERROR {98.575} CONFIG.CLKOUT2_REQUESTED_OUT_FREQ {166.667} \
CONFIG.CLKOUT2_USED {true} CONFIG.CLKOUT3_JITTER {114.829} \
CONFIG.CLKOUT3_PHASE_ERROR {98.575} CONFIG.CLKOUT3_REQUESTED_OUT_FREQ {200} \
CONFIG.CLKOUT3_USED {true} CONFIG.CLKOUT4_JITTER {175.402} \
CONFIG.CLKOUT4_PHASE_ERROR {98.575} CONFIG.CLKOUT4_REQUESTED_OUT_FREQ {25} \
CONFIG.CLKOUT4_USED {true} CONFIG.CLK_IN1_BOARD_INTERFACE {sys_clock} \
CONFIG.MMCM_CLKIN1_PERIOD {10.0} CONFIG.MMCM_CLKOUT1_DIVIDE {6} \
CONFIG.MMCM_CLKOUT2_DIVIDE {5} CONFIG.MMCM_CLKOUT3_DIVIDE {40} \
CONFIG.MMCM_DIVCLK_DIVIDE {1} CONFIG.NUM_OUT_CLKS {4} \
CONFIG.PRIM_SOURCE {Single_ended_clock_capable_pin} CONFIG.RESET_BOARD_INTERFACE {reset} \
CONFIG.RESET_PORT {resetn} CONFIG.RESET_TYPE {ACTIVE_LOW} \
CONFIG.USE_BOARD_FLOW {true}  ] $clk_wiz_1

  # Create instance: rst_clk_wiz_1_100M, and set properties
  set rst_clk_wiz_1_100M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_clk_wiz_1_100M ]
  set_property -dict [ list CONFIG.RESET_BOARD_INTERFACE {reset} CONFIG.USE_BOARD_FLOW {true}  ] $rst_clk_wiz_1_100M

  # Create port connections
  connect_bd_net -net clkReset_clk_166m667 [get_bd_pins clk_166m667] [get_bd_pins clk_wiz_1/clk_out2]
  connect_bd_net -net clkReset_clk_200m [get_bd_pins clk_200m] [get_bd_pins clk_wiz_1/clk_out3]
  connect_bd_net -net clk_wiz_1_clk_out4 [get_bd_pins eth_ref_clk] [get_bd_pins clk_wiz_1/clk_out4]
  connect_bd_net -net clk_wiz_1_locked [get_bd_pins clk_wiz_1/locked] [get_bd_pins rst_clk_wiz_1_100M/dcm_locked]
  connect_bd_net -net mdm_1_debug_sys_rst [get_bd_pins mb_debug_sys_rst] [get_bd_pins rst_clk_wiz_1_100M/mb_debug_sys_rst]
  connect_bd_net -net microblaze_0_Clk [get_bd_pins clk_100m] [get_bd_pins clk_wiz_1/clk_out1] [get_bd_pins rst_clk_wiz_1_100M/slowest_sync_clk]
  connect_bd_net -net reset_1 [get_bd_pins ext_reset_in] [get_bd_pins clk_wiz_1/resetn] [get_bd_pins rst_clk_wiz_1_100M/ext_reset_in]
  connect_bd_net -net rst_clk_wiz_1_100M_bus_struct_reset [get_bd_pins bus_struct_reset] [get_bd_pins rst_clk_wiz_1_100M/bus_struct_reset]
  connect_bd_net -net rst_clk_wiz_1_100M_interconnect_aresetn [get_bd_pins interconnect_aresetn] [get_bd_pins rst_clk_wiz_1_100M/interconnect_aresetn]
  connect_bd_net -net rst_clk_wiz_1_100M_mb_reset [get_bd_pins mb_reset] [get_bd_pins rst_clk_wiz_1_100M/mb_reset]
  connect_bd_net -net rst_clk_wiz_1_100M_peripheral_aresetn [get_bd_pins peripheral_aresetn] [get_bd_pins rst_clk_wiz_1_100M/peripheral_aresetn]
  connect_bd_net -net sys_clock_1 [get_bd_pins clk_in1] [get_bd_pins clk_wiz_1/clk_in1]
  
  # Restore current instance
  current_bd_instance $oldCurInst
}


# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     puts "ERROR: Unable to find parent cell <$parentCell>!"
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     puts "ERROR: Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set IIC [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 IIC ]
  set dip_switches_4bits [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 dip_switches_4bits ]
  set eth_mdio_mdc [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 eth_mdio_mdc ]
  set eth_mii [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 eth_mii ]
  set led_4bits [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 led_4bits ]
  set pushbuttons [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 pushbuttons ]
  set rgb_led [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 rgb_led ]
  set uart_01 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 uart_01 ]
  set uart_03 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 uart_03 ]
  set uart_cano [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 uart_cano ]
  set usb_uart [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 usb_uart ]

  # Create ports
  set eth_ref_clk [ create_bd_port -dir O -type clk eth_ref_clk ]
  set reset [ create_bd_port -dir I -type rst reset ]
  set_property -dict [ list CONFIG.POLARITY {ACTIVE_LOW}  ] $reset
  set sys_clock [ create_bd_port -dir I -type clk sys_clock ]
  set_property -dict [ list CONFIG.FREQ_HZ {100000000} CONFIG.PHASE {0.000}  ] $sys_clock
  set wake_sw [ create_bd_port -dir O -from 0 -to 0 wake_sw ]

  # Create instance: clkReset
  create_hier_cell_clkReset [current_bd_instance .] clkReset

  # Create instance: ioBlocks
  create_hier_cell_ioBlocks [current_bd_instance .] ioBlocks

  # Create instance: uBlaze
  create_hier_cell_uBlaze [current_bd_instance .] uBlaze

  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net axi_ethernetlite_0_MDIO [get_bd_intf_ports eth_mdio_mdc] [get_bd_intf_pins ioBlocks/MDIO]
  connect_bd_intf_net -intf_net axi_ethernetlite_0_MII [get_bd_intf_ports eth_mii] [get_bd_intf_pins ioBlocks/MII]
  connect_bd_intf_net -intf_net axi_uartlite_0_UART [get_bd_intf_ports usb_uart] [get_bd_intf_pins ioBlocks/usb_uart]
  connect_bd_intf_net -intf_net ioBlocks_GPIO [get_bd_intf_ports dip_switches_4bits] [get_bd_intf_pins ioBlocks/dip_switches_4bits]
  connect_bd_intf_net -intf_net ioBlocks_GPIO1 [get_bd_intf_ports rgb_led] [get_bd_intf_pins ioBlocks/rgb_led]
  connect_bd_intf_net -intf_net ioBlocks_GPIO2 [get_bd_intf_ports led_4bits] [get_bd_intf_pins ioBlocks/led_4bits]
  connect_bd_intf_net -intf_net ioBlocks_GPIO_1 [get_bd_intf_ports pushbuttons] [get_bd_intf_pins ioBlocks/pushbuttons]
  connect_bd_intf_net -intf_net ioBlocks_IIC [get_bd_intf_ports IIC] [get_bd_intf_pins ioBlocks/IIC]
  connect_bd_intf_net -intf_net ioBlocks_UART1 [get_bd_intf_ports uart_01] [get_bd_intf_pins ioBlocks/uart_01]
  connect_bd_intf_net -intf_net ioBlocks_UART2 [get_bd_intf_ports uart_cano] [get_bd_intf_pins ioBlocks/uart_cano]
  connect_bd_intf_net -intf_net ioBlocks_UART3 [get_bd_intf_ports uart_03] [get_bd_intf_pins ioBlocks/uart_03]
  connect_bd_intf_net -intf_net s_axi_1 [get_bd_intf_pins ioBlocks/M00_AXI] [get_bd_intf_pins uBlaze/s_axi]
  connect_bd_intf_net -intf_net uBlaze_M_AXI_DP [get_bd_intf_pins ioBlocks/S00_AXI] [get_bd_intf_pins uBlaze/M_AXI_DP]

  # Create port connections
  connect_bd_net -net clkReset_clk_166m667 -boundary_type upper [get_bd_pins clkReset/clk_166m667]
  connect_bd_net -net clkReset_clk_200m -boundary_type upper [get_bd_pins clkReset/clk_200m]
  connect_bd_net -net clkReset_eth_ref_clk [get_bd_ports eth_ref_clk] [get_bd_pins clkReset/eth_ref_clk]
  connect_bd_net -net mdm_1_debug_sys_rst [get_bd_pins clkReset/mb_debug_sys_rst] [get_bd_pins uBlaze/Debug_SYS_Rst]
  connect_bd_net -net microblaze_0_Clk [get_bd_pins clkReset/clk_100m] [get_bd_pins ioBlocks/s_axi_aclk] [get_bd_pins uBlaze/Clk]
  connect_bd_net -net microblaze_0_intr [get_bd_pins ioBlocks/dout] [get_bd_pins uBlaze/intr]
  connect_bd_net -net reset_1 [get_bd_ports reset] [get_bd_pins clkReset/ext_reset_in]
  connect_bd_net -net rst_clk_wiz_1_100M_bus_struct_reset [get_bd_pins clkReset/bus_struct_reset] [get_bd_pins uBlaze/SYS_Rst]
  connect_bd_net -net rst_clk_wiz_1_100M_interconnect_aresetn [get_bd_pins clkReset/interconnect_aresetn] [get_bd_pins ioBlocks/ARESETN]
  connect_bd_net -net rst_clk_wiz_1_100M_mb_reset [get_bd_pins clkReset/mb_reset] [get_bd_pins uBlaze/Reset]
  connect_bd_net -net rst_clk_wiz_1_100M_peripheral_aresetn [get_bd_pins clkReset/peripheral_aresetn] [get_bd_pins ioBlocks/s_axi_aresetn] [get_bd_pins uBlaze/s_axi_aresetn]
  connect_bd_net -net sys_clock_1 [get_bd_ports sys_clock] [get_bd_pins clkReset/clk_in1]
  connect_bd_net -net xlconstant_0_dout [get_bd_ports wake_sw] [get_bd_pins xlconstant_0/dout]

  # Create address segments
  create_bd_addr_seg -range 0x10000 -offset 0x40E00000 [get_bd_addr_spaces uBlaze/microblaze_0/Data] [get_bd_addr_segs ioBlocks/axi_ethernetlite_0/S_AXI/Reg] SEG_axi_ethernetlite_0_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x40000000 [get_bd_addr_spaces uBlaze/microblaze_0/Data] [get_bd_addr_segs ioBlocks/axi_gpio_0/S_AXI/Reg] SEG_axi_gpio_0_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x40010000 [get_bd_addr_spaces uBlaze/microblaze_0/Data] [get_bd_addr_segs ioBlocks/axi_gpio_1/S_AXI/Reg] SEG_axi_gpio_1_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x40020000 [get_bd_addr_spaces uBlaze/microblaze_0/Data] [get_bd_addr_segs ioBlocks/axi_gpio_2/S_AXI/Reg] SEG_axi_gpio_2_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x40030000 [get_bd_addr_spaces uBlaze/microblaze_0/Data] [get_bd_addr_segs ioBlocks/axi_gpio_3/S_AXI/Reg] SEG_axi_gpio_3_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x40800000 [get_bd_addr_spaces uBlaze/microblaze_0/Data] [get_bd_addr_segs ioBlocks/axi_iic_0/S_AXI/Reg] SEG_axi_iic_0_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x41C00000 [get_bd_addr_spaces uBlaze/microblaze_0/Data] [get_bd_addr_segs ioBlocks/axi_timer_0/S_AXI/Reg] SEG_axi_timer_0_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x40600000 [get_bd_addr_spaces uBlaze/microblaze_0/Data] [get_bd_addr_segs ioBlocks/axi_uartlite_0/S_AXI/Reg] SEG_axi_uartlite_0_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x40610000 [get_bd_addr_spaces uBlaze/microblaze_0/Data] [get_bd_addr_segs ioBlocks/axi_uartlite_1/S_AXI/Reg] SEG_axi_uartlite_1_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x40620000 [get_bd_addr_spaces uBlaze/microblaze_0/Data] [get_bd_addr_segs ioBlocks/axi_uartlite_2/S_AXI/Reg] SEG_axi_uartlite_2_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x40630000 [get_bd_addr_spaces uBlaze/microblaze_0/Data] [get_bd_addr_segs ioBlocks/axi_uartlite_3/S_AXI/Reg] SEG_axi_uartlite_3_Reg
  create_bd_addr_seg -range 0x20000 -offset 0x0 [get_bd_addr_spaces uBlaze/microblaze_0/Data] [get_bd_addr_segs uBlaze/microblaze_0_local_memory/dlmb_bram_if_cntlr/SLMB/Mem] SEG_dlmb_bram_if_cntlr_Mem
  create_bd_addr_seg -range 0x20000 -offset 0x0 [get_bd_addr_spaces uBlaze/microblaze_0/Instruction] [get_bd_addr_segs uBlaze/microblaze_0_local_memory/ilmb_bram_if_cntlr/SLMB/Mem] SEG_ilmb_bram_if_cntlr_Mem
  create_bd_addr_seg -range 0x10000 -offset 0x41200000 [get_bd_addr_spaces uBlaze/microblaze_0/Data] [get_bd_addr_segs uBlaze/microblaze_0_axi_intc/s_axi/Reg] SEG_microblaze_0_axi_intc_Reg
  

  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


