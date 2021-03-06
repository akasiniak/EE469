# Create work library
vlib work

# Compile Verilog
#     All Verilog files that are part of this design should have
#     their own "vlog" line below.
vlog "./math.sv"
vlog "./mux2to1.sv"
vlog "./adder64Bit.sv"
vlog "./full_adder.sv"
vlog "./programCounter.sv"
vlog "./instructmem.sv"
vlog "./signExtend.sv"
vlog "./instructionGet.sv"
vlog "./alu.sv"
vlog "./execution.sv"
vlog "./mux4to1.sv"
vlog "./CPUControl.sv"
vlog "./nor64to1.sv"
vlog "./MOVUNIT.sv"
vlog "./nor16to1.sv"
vlog "./MOVCntrl.sv"
vlog "./SingleCycleCPU.sv"
vlog "./flags.sv"

# Call vsim to invoke simulator
#     Make sure the last item on the line is the name of the
#     testbench module you want to execute.
vsim -voptargs="+acc" -t 1ps -lib work SingleCycleCPU_testbench

# Source the wave do file
#     This should be the file that sets up the signal window for
#     the module you are testing.
do SingleCycleCPU.do

# Set the window types
view wave
view structure
view signals

run -all

# End
