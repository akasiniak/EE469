onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /EX_testbench/CLOCK_PERIOD
add wave -noupdate -radix decimal /EX_testbench/ALUOut
add wave -noupdate -radix decimal /EX_testbench/Db
add wave -noupdate -radix decimal /EX_testbench/OPCode
add wave -noupdate /EX_testbench/MemWrite
add wave -noupdate /EX_testbench/MOVZ
add wave -noupdate /EX_testbench/MOVK
add wave -noupdate /EX_testbench/LDURB
add wave -noupdate /EX_testbench/Mem2Reg
add wave -noupdate /EX_testbench/RegWrite
add wave -noupdate /EX_testbench/read_enable
add wave -noupdate /EX_testbench/negative
add wave -noupdate /EX_testbench/overflow
add wave -noupdate /EX_testbench/xfer_size
add wave -noupdate /EX_testbench/clk
add wave -noupdate /EX_testbench/reset
add wave -noupdate /EX_testbench/MemWriteIn
add wave -noupdate /EX_testbench/MOVZIn
add wave -noupdate /EX_testbench/MOVKIn
add wave -noupdate /EX_testbench/LDURBIn
add wave -noupdate /EX_testbench/Mem2RegIn
add wave -noupdate /EX_testbench/RegWriteIn
add wave -noupdate /EX_testbench/read_enableIn
add wave -noupdate /EX_testbench/NOOPIn
add wave -noupdate /EX_testbench/xfer_sizeIn
add wave -noupdate /EX_testbench/ALUCntrlIn
add wave -noupdate -radix decimal /EX_testbench/ALUA
add wave -noupdate -radix decimal /EX_testbench/ALUB
add wave -noupdate -radix decimal /EX_testbench/DbIn
add wave -noupdate -radix decimal /EX_testbench/OPCodeIn
add wave -noupdate /EX_testbench/dut/flagRegister/in
add wave -noupdate /EX_testbench/dut/flagRegister/out
add wave -noupdate /EX_testbench/dut/ahloo/A
add wave -noupdate /EX_testbench/dut/ahloo/B
add wave -noupdate /EX_testbench/dut/ahloo/cntrl
add wave -noupdate /EX_testbench/dut/ahloo/result
add wave -noupdate /EX_testbench/dut/ahloo/negative
add wave -noupdate /EX_testbench/dut/ahloo/zero
add wave -noupdate /EX_testbench/dut/ahloo/overflow
add wave -noupdate /EX_testbench/dut/ahloo/carry_out
add wave -noupdate /EX_testbench/dut/ahloo/adder_out
add wave -noupdate /EX_testbench/dut/ahloo/carryLogic
add wave -noupdate /EX_testbench/dut/ahloo/negSelectMux
add wave -noupdate /EX_testbench/dut/ahloo/muxLogic
add wave -noupdate /EX_testbench/dut/overFlowFromFlag
add wave -noupdate /EX_testbench/dut/negativeFromFlag
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {516816 ps} 0} {{Cursor 2} {24378 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {735 ns}
