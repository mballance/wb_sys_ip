
+incdir+${SIM_DIR_A}/../tb
+incdir+${SIM_DIR_A}/../tests

-f ${SV_BFMS}/api/sv/sv.f

-f ${STD_PROTOCOL_IF}/rtl/wb/wb.f
-f ${STD_PROTOCOL_IF}/rtl/memory/memory.f
-f ${WB_SYS_IP}/rtl/rtl.f
-f ${MEMORY_PRIMITIVES}/rtl/rtl_w.f
// -f ${MEMORY_PRIMITIVES}/rtl/sim/sim.f
+define+GENERIC_SRAM_BYTE_EN_BFM_NAME=generic_sram_byte_en
-f ${SV_BFMS}/generic_sram_byte_en/sv.f
-f ${SV_BFMS}/generic_sram_byte_en/uvm/uvm.f


-f ${SV_BFMS}/wb/uvm/uvm.f
-f ${SV_BFMS}/wb/wb.f

${WB_SYS_IP}/wishbone_ic_32_32_2x4.v

${SIM_DIR_A}/../tb/wb_ic_env_pkg.sv

${SIM_DIR_A}/../tests/wb_ic_tests_pkg.sv

${SIM_DIR_A}/../tb/wb_ic_tb.sv


