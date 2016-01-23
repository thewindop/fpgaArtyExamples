set PROJ_BASE C:/arty/
set SRC_BASE  ${PROJ_BASE}/boardFiles/des1_fpgaOnly/hw
set PROJ_NAME arty_3
set TOP_LEVEL arty_ctrl

# Proc to create an Arty project, call the board.tcl  
proc full_arty_build {PROJ_BASE SRC_BASE PROJ_NAME TOP_LEVEL} {
  create_project ${PROJ_NAME} ${PROJ_BASE}/${PROJ_NAME} -part xc7a35ticsg324-1L
  set_property board_part digilentinc.com:arty:part0:1.1 [current_project]
  source ${SRC_BASE}/board.tcl
  add_files -fileset constrs_1 -norecurse ${SRC_BASE}/cons.xdc
  save_bd_design
  validate_bd_design
  make_wrapper -files [get_files ${PROJ_BASE}/${PROJ_NAME}/${PROJ_NAME}.srcs/sources_1/bd/${TOP_LEVEL}/${TOP_LEVEL}.bd] -top
  add_files -norecurse ${PROJ_BASE}/${PROJ_NAME}/${PROJ_NAME}.srcs/sources_1/bd/${TOP_LEVEL}/hdl/${TOP_LEVEL}_wrapper.v
  update_compile_order -fileset sources_1
  update_compile_order -fileset sim_1
  launch_runs impl_1 -to_step write_bitstream
  wait_on_run impl_1
}

# change into base dir
cd $PROJ_BASE
# Call the build function
full_arty_build $PROJ_BASE $SRC_BASE $PROJ_NAME $TOP_LEVEL

