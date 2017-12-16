/****************************************************************************
 * wb_uart_uex_drv.c
 ****************************************************************************/
#include "wb_uart_uex_drv.h"
#include "uex.h"

void wb_uart_uex_drv_init(
		wb_uart_uex_drv_t		*drv,
		void					*base,
		uint32_t				clk_div) {
	uint8_t val;
	memset(drv, 0, sizeof(wb_uart_uex_drv_t));
	drv->base = (uint8_t *)uex_ioremap(base, 16, 0);

	val = uex_ioread8(drv->base+3); // read LCR
	val |= 0x80;
	uex_iowrite8(val, drv->base+3);

	uex_iowrite8((clk_div >> 8), drv->base+1); // DL MSB
	uex_iowrite8(clk_div, drv->base); // DL LSB 14=115200

	val &= (~0x80);
	uex_iowrite8(val, drv->base+3);

}

void wb_uart_uex_drv_putc(wb_uart_uex_drv_t *drv, int c) {
	uint8_t val;

	do {
		val = uex_ioread8(drv->base+5); // read LSR;
	} while ((val & 0x40) == 0);

	uex_iowrite8(c, drv->base);
}

int wb_uart_uex_drv_getc(wb_uart_uex_drv_t *drv) {
	uint8_t val;

	do {
		val = uex_ioread8(drv->base+5);
	} while ((val & 1) == 0);

	val = uex_ioread8(drv->base);

	return val;
}
