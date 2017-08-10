/**
 * Filelist: sve.F
 */
 
+incdir+${UVM_HOME}/src
${UVM_HOME}/src/uvm_pkg.sv 

-f ./rtl/rtl.f

-f ./std_protocol_if/rtl/rtl.f
-F ./ve/wb_ic_uvm/sve.F
-f ./ve/sv_bfms/sve.f

-f ${MEMORY_PRIMITIVES}/rtl/rtl_w.f
-f ${MEMORY_PRIMITIVES}/rtl/sim/sim.f

${WB_SYS_IP}/wishbone_ic_32_32_2x4.v
