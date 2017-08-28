
-f ${MEMORY_PRIMITIVES}/rtl/fpga/altsyncram/rtl.f
-f ${MEMORY_PRIMITIVES}/rtl/rtl_w.f
-f ${STD_PROTOCOL_IF}/rtl/wb/wb.f
-f ${STD_PROTOCOL_IF}/rtl/memory/memory.f

-f ${WB_SYS_IP}/rtl/rtl.f

// -f ${MOR1KX_SOC}/rtl/rtl.f

${WB_SYS_IP}/wishbone_ic_32_32_2x4.v
${WB_SYS_IP}/wishbone_test_master_32_32_4.v
${SYNTH_DIR_A}/wb_stub_sys.sv

/**
 * Port mapping
 */
-assign-pin clk_i PIN_K14
-assign-pin led0 PIN_AF10
-assign-pin led1 PIN_AD10
-assign-pin led2 PIN_AE11
-assign-pin led3 PIN_AD7

/**
 * Voltage
 */
-io-standard clk_i "3.3-V LVTTL"
-io-standard led0 "3.3-V LVTTL"
-io-standard led1 "3.3-V LVTTL"
-io-standard led2 "3.3-V LVTTL"
-io-standard led3 "3.3-V LVTTL"

