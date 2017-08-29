
create_clock -period 20 [get_ports clk_i]
# create_clock [get_ports clk_i]
# create_generated_clock -name clk -source [get_ports {clk_i}] -divide_by 50000 [get_registers {clk}]

derive_pll_clocks

derive_clock_uncertainty

