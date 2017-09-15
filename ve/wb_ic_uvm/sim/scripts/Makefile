
include $(SIMSCRIPTS_DIR)/mkfiles/plusargs.mk

TB=wb_ic_tb

MK_INCLUDES += $(WB_SYS_IP)/rules_defs.mk
MK_INCLUDES += $(WB_SYS_IP)/std_protocol_if/rules_defs.mk
MK_INCLUDES += $(WB_SYS_IP)/chisellib/rules_defs.mk
MK_INCLUDES += $(WB_SYS_IP)/chiselscripts/mkfiles/rules_defs.mk

BUILD_PRECOMPILE_TARGETS += $(foreach s,2 3 4, wishbone_ic_32_32_2x$(s).v)
# BUILD_PRECOMPILE_TARGETS += wishbone_ic_32_32_2x4.v
BUILD_PRECOMPILE_TARGETS += wishbone_test_master_32_32_4.v

include $(SIMSCRIPTS_DIR)/mkfiles/common_sim.mk

#wishbone_ic_32_32_2x2.v : $(WB_SYS_IP_LIBS)
#	$(call WB_SYS_IP_LIB_GEN_WISHBONE_IC, 2, 2, 32, 32)
#wishbone_ic_32_32_2x3.v : $(WB_SYS_IP_LIBS)
#	$(call WB_SYS_IP_LIB_GEN_WISHBONE_IC, 2, 3, 32, 32)
#wishbone_ic_32_32_2x4.v : $(WB_SYS_IP_LIBS)
#	$(call WB_SYS_IP_LIB_GEN_WISHBONE_IC, 2, 4, 32, 32)

wishbone_test_master_32_32_4.v : $(WB_SYS_IP_LIBS)
	$(call WB_SYS_IP_LIB_GEN_WISHBONE_TESTMASTER, 4, 32, 32)
