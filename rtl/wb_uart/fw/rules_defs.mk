
ifneq (1,$(RULES))

WB_UART_FW_DIR := $(dir $(lastword $(MAKEFILE_LIST)))

WB_UART_UEX_FW_SRC = \
  wb_uart_uex_drv.c
  
LIBWB_UART_UEX_FW := libwb_uart_uex_fw.o

SRC_DIRS += $(WB_UART_FW_DIR)

else

$(LIBWB_UART_UEX_FW) : $(WB_UART_UEX_FW_SRC:.c=.o)
	$(Q)rm -f $@
	$(Q)$(LD) -r -o $@ $^

endif