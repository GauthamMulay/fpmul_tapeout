# generated by get_cup_sdc.py
# Date: 2023/06/20

### Note:
# - input clock transition and latency are set for wb_clk_i port.
#   If your design is using the user_clock2, update the clock constraints to reflect that and use usr_* variables.
# - IO ports are assumed to be asynchronous. If they're synchronous to the clock, update the variable IO_SYNC to 1.
#   As well, update in_ext_delay and out_ext_delay with the required I/O external delays.

#------------------------------------------#
# Pre-defined Constraints
#------------------------------------------#

# Clock network
if {[info exists ::env(CLOCK_PORT)] && $::env(CLOCK_PORT) != ""} {
	set clk_input $::env(CLOCK_PORT)
	create_clock [get_ports $clk_input] -name clk -period $::env(CLOCK_PERIOD)
	puts "\[INFO\]: Creating clock {clk} for port $clk_input with period: $::env(CLOCK_PERIOD)"
} else {
	set clk_input __VIRTUAL_CLK__
	create_clock -name clk -period $::env(CLOCK_PERIOD)
	puts "\[INFO\]: Creating virtual clock with period: $::env(CLOCK_PERIOD)"
}
if { ![info exists ::env(SYNTH_CLK_DRIVING_CELL)] } {
	set ::env(SYNTH_CLK_DRIVING_CELL) $::env(SYNTH_DRIVING_CELL)
}
if { ![info exists ::env(SYNTH_CLK_DRIVING_CELL_PIN)] } {
	set ::env(SYNTH_CLK_DRIVING_CELL_PIN) $::env(SYNTH_DRIVING_CELL_PIN)
}

# Clock non-idealities
set_propagated_clock [all_clocks]
set_clock_uncertainty $::env(SYNTH_CLOCK_UNCERTAINTY) [get_clocks {clk}]
puts "\[INFO\]: Setting clock uncertainity to: $::env(SYNTH_CLOCK_UNCERTAINTY)"
set_clock_transition $::env(SYNTH_CLOCK_TRANSITION) [get_clocks {clk}]
puts "\[INFO\]: Setting clock transition to: $::env(SYNTH_CLOCK_TRANSITION)"

# Maximum transition time for the design nets
set_max_transition $::env(MAX_TRANSITION_CONSTRAINT) [current_design]
puts "\[INFO\]: Setting maximum transition to: $::env(MAX_TRANSITION_CONSTRAINT)"

# Maximum fanout
set_max_fanout $::env(MAX_FANOUT_CONSTRAINT) [current_design]
puts "\[INFO\]: Setting maximum fanout to: $::env(MAX_FANOUT_CONSTRAINT)"

# Timing paths delays derate
set_timing_derate -early [expr {1-$::env(SYNTH_TIMING_DERATE)}]
set_timing_derate -late [expr {1+$::env(SYNTH_TIMING_DERATE)}]
puts "\[INFO\]: Setting timing derate to: [expr {$::env(SYNTH_TIMING_DERATE) * 100}] %"

# Reset input delay
#set_input_delay [expr $::env(CLOCK_PERIOD) * 0.5] -clock [get_clocks {clk}] [get_ports {wb_rst_i}]

# Multicycle paths
#set_multicycle_path -setup 2 -through [get_ports {wbs_ack_o}]
#set_multicycle_path -hold 1  -through [get_ports {wbs_ack_o}]
#set_multicycle_path -setup 2 -through [get_ports {wbs_cyc_i}]
#set_multicycle_path -hold 1  -through [get_ports {wbs_cyc_i}]
#set_multicycle_path -setup 2 -through [get_ports {wbs_stb_i}]
#set_multicycle_path -hold 1  -through [get_ports {wbs_stb_i}]

#------------------------------------------#
# Retrieved Constraints
#------------------------------------------#

# Clock source latency
set usr_clk_max_latency 4.57
set usr_clk_min_latency 4.11
set clk_max_latency 5.57
set clk_min_latency 4.65
set_clock_latency -source -max $clk_max_latency [get_clocks {clk}]
set_clock_latency -source -min $clk_min_latency [get_clocks {clk}]
puts "\[INFO\]: Setting clock latency range: $clk_min_latency : $clk_max_latency"

# Clock input Transition
set usr_clk_tran 0.13
set clk_tran 0.61
set_input_transition $clk_tran [get_ports $clk_input]
puts "\[INFO\]: Setting clock transition: $clk_tran"

# Input delays
#set_input_delay -max 1.87 -clock [get_clocks {clk}] [get_ports {la_data_in[*]}]
#set_input_delay -max 1.89 -clock [get_clocks {clk}] [get_ports {la_oenb[*]}]
#set_input_delay -max 3.17 -clock [get_clocks {clk}] [get_ports {wbs_sel_i[*]}]
#set_input_delay -max 3.74 -clock [get_clocks {clk}] [get_ports {wbs_we_i}]
#set_input_delay -max 3.89 -clock [get_clocks {clk}] [get_ports {wbs_adr_i[*]}]
#set_input_delay -max 4.13 -clock [get_clocks {clk}] [get_ports {wbs_stb_i}]
#set_input_delay -max 4.61 -clock [get_clocks {clk}] [get_ports {wbs_dat_i[*]}]
#set_input_delay -max 4.74 -clock [get_clocks {clk}] [get_ports {wbs_cyc_i}]
#set_input_delay -min 0.18 -clock [get_clocks {clk}] [get_ports {la_data_in[*]}]
#set_input_delay -min 0.3  -clock [get_clocks {clk}] [get_ports {la_oenb[*]}]
#set_input_delay -min 0.79 -clock [get_clocks {clk}] [get_ports {wbs_adr_i[*]}]
#set_input_delay -min 1.04 -clock [get_clocks {clk}] [get_ports {wbs_dat_i[*]}]
#set_input_delay -min 1.19 -clock [get_clocks {clk}] [get_ports {wbs_sel_i[*]}]
#set_input_delay -min 1.65 -clock [get_clocks {clk}] [get_ports {wbs_we_i}]
#set_input_delay -min 1.69 -clock [get_clocks {clk}] [get_ports {wbs_cyc_i}]
#set_input_delay -min 1.86 -clock [get_clocks {clk}] [get_ports {wbs_stb_i}]
if { $::env(IO_SYNC) } {
	set in_ext_delay 4
	puts "\[INFO\]: Setting input ports external delay to: $in_ext_delay"
	set_input_delay -max [expr $in_ext_delay + 4.55] -clock [get_clocks {clk}] [get_ports {io_in[*]}]
	set_input_delay -min [expr $in_ext_delay + 1.26] -clock [get_clocks {clk}] [get_ports {io_in[*]}]
}

# Input Transition
#set_input_transition -max 0.14  [get_ports {wbs_we_i}]
#set_input_transition -max 0.15  [get_ports {wbs_stb_i}]
#set_input_transition -max 0.17  [get_ports {wbs_cyc_i}]
#set_input_transition -max 0.18  [get_ports {wbs_sel_i[*]}]
set_input_transition -max 0.38  [get_ports {io_in[*]}]
#set_input_transition -max 0.84  [get_ports {wbs_dat_i[*]}]
#set_input_transition -max 0.86  [get_ports {la_data_in[*]}]
#set_input_transition -max 0.92  [get_ports {wbs_adr_i[*]}]
#set_input_transition -max 0.97  [get_ports {la_oenb[*]}]
set_input_transition -min 0.05  [get_ports {io_in[*]}]
#set_input_transition -min 0.06  [get_ports {la_oenb[*]}]
#set_input_transition -min 0.07  [get_ports {la_data_in[*]}]
#set_input_transition -min 0.07  [get_ports {wbs_adr_i[*]}]
#set_input_transition -min 0.07  [get_ports {wbs_dat_i[*]}]
#set_input_transition -min 0.09  [get_ports {wbs_cyc_i}]
#set_input_transition -min 0.09  [get_ports {wbs_sel_i[*]}]
#set_input_transition -min 0.09  [get_ports {wbs_we_i}]
#set_input_transition -min 0.15  [get_ports {wbs_stb_i}]

# Output delays
#set_output_delay -max 0.7  -clock [get_clocks {clk}] [get_ports {user_irq[*]}]
#set_output_delay -max 1.0  -clock [get_clocks {clk}] [get_ports {la_data_out[*]}]
#set_output_delay -max 3.62 -clock [get_clocks {clk}] [get_ports {wbs_dat_o[*]}]
#set_output_delay -max 8.41 -clock [get_clocks {clk}] [get_ports {wbs_ack_o}]
#set_output_delay -min 0    -clock [get_clocks {clk}] [get_ports {la_data_out[*]}]
#set_output_delay -min 0    -clock [get_clocks {clk}] [get_ports {user_irq[*]}]
#set_output_delay -min 1.13 -clock [get_clocks {clk}] [get_ports {wbs_dat_o[*]}]
#set_output_delay -min 1.37 -clock [get_clocks {clk}] [get_ports {wbs_ack_o}]
if { $::env(IO_SYNC) } {
	set out_ext_delay 4
	puts "\[INFO\]: Setting output ports external delay to: $out_ext_delay"
	set_output_delay -max [expr $out_ext_delay + 9.12] -clock [get_clocks {clk}] [get_ports {io_out[*]}]
	#set_output_delay -max [expr $out_ext_delay + 9.32] -clock [get_clocks {clk}] [get_ports {io_oeb[*]}]
	#set_output_delay -min [expr $out_ext_delay + 2.34] -clock [get_clocks {clk}] [get_ports {io_oeb[*]}]
	set_output_delay -min [expr $out_ext_delay + 3.9]  -clock [get_clocks {clk}] [get_ports {io_out[*]}]
}

# Output loads
set_load 0.19 [all_outputs]
