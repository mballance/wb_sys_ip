/**
 * Filelist: sve.F
 */
 
+incdir+${UVM_HOME}/src
${UVM_HOME}/src/uvm_pkg.sv 

-F ${STD_PROTOCOL_IF}/sve.F
-F ./ve/wb_ic_uvm/sve.F
-F ./ve/wb_test_master_uvm/sve.F
-F ./ve/wb_stub_sys_uvm/sve.F
-F ${SV_BFMS}/sve.f
-f ./rtl/rtl.f

./synth/wb_stub_sys/wb_stub_sys.sv

-f ${MEMORY_PRIMITIVES}/rtl/rtl_w.f
-f ${MEMORY_PRIMITIVES}/rtl/sim/sim.f

${WB_SYS_IP}/wishbone_ic_32_32_2x4.v
${WB_SYS_IP}/wishbone_test_master_32_32_4.v
