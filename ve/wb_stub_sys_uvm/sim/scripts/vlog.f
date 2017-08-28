
+incdir+${SIM_DIR_A}/../tb
+incdir+${SIM_DIR_A}/../tests

${WB_SYS_IP}/synth/wb_stub_sys/wb_stub_sys.sv
${WB_SYS_IP}/wishbone_ic_32_32_2x4.v
${WB_SYS_IP}/wishbone_test_master_32_32_4.v

-f ${STD_PROTOCOL_IF}/rtl/wb/wb.f
-f ${STD_PROTOCOL_IF}/rtl/memory/memory.f

-f ${MEMORY_PRIMITIVES}/rtl/rtl_w.f
-f ${MEMORY_PRIMITIVES}/rtl/sim/sim.f
-f ${WB_SYS_IP}/rtl/rtl.f

${SIM_DIR_A}/../tb/wb_stub_sys_env_pkg.sv

${SIM_DIR_A}/../tests/wb_stub_sys_tests_pkg.sv

${SIM_DIR_A}/../tb/wb_stub_sys_tb.sv


