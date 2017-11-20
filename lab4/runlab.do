# Create work library
vlib work

# Compile Verilog
#     All Verilog files that are part of this design should have
#     their own "vlog" line below.
vlog "./forwardingUnit.sv"
vlog "./PipelinedProcessor.sv"
vlog "./CPUControl.sv"
vlog "./IFETCH.sv"
vlog "./REGDEC.sv"
vlog "./EX.sv"
vlog "./MEM.sv"
vlog "./instructmem.sv"
vlog "./regfile.sv"

# Call vsim to invoke simulator
#     Make sure the last item on the line is the name of the
#     testbench module you want to execute.
vsim -voptargs="+acc" -t 1ps -lib work PipelinedProcessor_testbench

# Source the wave do file
#     This should be the file that sets up the signal window for
#     the module you are testing.
do PipelinedProcessor.do

# Set the window types
view wave
view structure
view signals

run -all

# End
