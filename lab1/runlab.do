# Create work library
vlib work

# Compile Verilog
#     All Verilog files that are part of this design should have
#     their own "vlog" line below.
vlog "./mux2to1.sv"
vlog "./mux4to1.sv"
vlog "./mux8to1.sv"
vlog "./mux16to1.sv"
vlog "./mux32to1.sv"
vlog "./register.sv"
vlog "./D_FF_Enable.sv"
vlog "./D_FF.sv"
vlog "./decoder2to4.sv"
vlog "./decoder3to8.sv"
vlog "./decoder5to32.sv"
vlog "./regFile.sv"
# Call vsim to invoke simulator
#     Make sure the last item on the line is the name of the
#     testbench module you want to execute.
vsim -voptargs="+acc" -t 1ps -lib work regstim

# Source the wave do file
#     This should be the file that sets up the signal window for
#     the module you are testing.
do regfile.do

# Set the window types
view wave
view structure
view signals

# End
