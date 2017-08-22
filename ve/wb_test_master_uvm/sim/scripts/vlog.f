
+incdir+${SIM_DIR_A}/../tb
+incdir+${SIM_DIR_A}/../tests

-f ${STD_PROTOCOL_IF}/rtl/wb/wb.f
-f ${STD_PROTOCOL_IF}/rtl/memory/memory.f
-f ${WB_SYS_IP}/rtl/rtl.f
-f ${MEMORY_PRIMITIVES}/rtl/rtl_w.f
-f ${MEMORY_PRIMITIVES}/rtl/sim/sim.f

${WB_SYS_IP}/wishbone_test_master_32_32_4.v

${SIM_DIR_A}/../tb/wb_test_master_env_pkg.sv

${SIM_DIR_A}/../tests/wb_test_master_tests_pkg.sv

${SIM_DIR_A}/../tb/wb_test_master_tb.sv


