VERBOSE := true

MK_INCLUDES += $(MOR1KX_SOC)/rtl/mor1kx_mod/fw/mor1kx.mk
MK_INCLUDES += $(MOR1KX_SOC)/rtl/mor1kx_mod/fw/rules_defs.mk
MK_INCLUDES += $(MOR1KX_SOC)/sw/fw/rules_defs.mk

RULES := 0

include $(MK_INCLUDES)

RULES := 1

$(BUILD_DIR)/rom.ihex : mor1kx_soc_fw.elf
	$(Q)$(OBJCOPY) $^ -O ihex $@
#	echo "TODO: build rom.ihex"

$(BUILD_DIR)/%.hex : $(BUILD_DIR)/%.ihex
	$(Q)objcopy_ihex2quartus_filter.pl $^ $@
	
$(BUILD_DIR)/%.ihex : $(BUILD_DIR)/%.elf
	$(Q)$(OBJCOPY) $^ -O ihex $@

#$(BUILD_DIR)/%.elf : $(MOR1KX_SOC)/synth/rom.S
#	$(Q)if test ! -d `dirname $@`; then mkdir -p `dirname $@`; fi
#	$(Q)$(AS) -c -o rom.o $(ASFLAGS) $^
#	$(Q)$(LD) -o $@ rom.o -T $(SYNTH_DIR)/rom.lds

include $(MK_INCLUDES)

	