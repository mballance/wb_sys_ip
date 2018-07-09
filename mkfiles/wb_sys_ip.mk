
WB_SYS_IP_MKFILES_DIR := $(dir $(lastword $(MAKEFILE_LIST)))
WB_SYS_IP_DIR := $(abspath $(WB_SYS_IP_MKFILES_DIR)/..)

ifneq (1,$(RULES))

WB_SYS_IP_JAR := $(WB_SYS_IP_DIR)/lib/wb_sys_ip_lib.jar
WB_SYS_IP_DEPS = $(STD_PROTOCOL_IF_JARS) $(CHISELLIB_JARS)
WB_SYS_IP_JARS = $(WB_SYS_IP_JAR) $(WB_SYS_IP_DEPS)

define WB_SYS_IP_LIB_GEN_WISHBONE_IC
$(CHISELG) $(foreach l,$(WB_SYS_IP_LIBS),-L$(l)) wb_sys_ip.WishboneInterconnectDriver \
  +N_MASTERS=$(strip $(1)) +N_SLAVES=$(strip $(2)) +ADDR_WIDTH=$(strip $(3)) +DATA_WIDTH=$(strip $(4))
endef

define WB_SYS_IP_LIB_GEN_WISHBONE_TESTMASTER
$(CHISELG) $(foreach l,$(WB_SYS_IP_LIBS),-L$(l)) wb_sys_ip.WishboneTestMasterDriver \
  +N_SLAVES=$(strip $(1)) +ADDR_WIDTH=$(strip $(2)) +DATA_WIDTH=$(strip $(3))
endef

else # Rules

$(WB_SYS_IP_LIB) : $(WB_SYS_IP_SRC) $(STD_PROTOCOL_IF_LIB) $(CHISELLIB_JAR)
	$(Q)$(CHISELC) -o $@ $(WB_SYS_IP_SRC) -L$(CHISELLIB_JAR) -L$(STD_PROTOCOL_IF_LIB)

wishbone_ic_%.v : $(WB_SYS_IP_LIBS)
	$(CHISELG) $(foreach l,$(WB_SYS_IP_LIBS),-L$(l)) wb_sys_ip.WishboneInterconnectDriver \
                +TOPOLOGY=$(strip $*)

endif

