onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /execution_testbench/clk
add wave -noupdate /execution_testbench/OPCode
add wave -noupdate /execution_testbench/Reg2Loc
add wave -noupdate /execution_testbench/MemWrite
add wave -noupdate /execution_testbench/LDURB
add wave -noupdate /execution_testbench/MemtoReg
add wave -noupdate /execution_testbench/MOVZ
add wave -noupdate /execution_testbench/MOVK
add wave -noupdate /execution_testbench/RegWrite
add wave -noupdate /execution_testbench/reset
add wave -noupdate /execution_testbench/read_enable
add wave -noupdate /execution_testbench/ALUSrc
add wave -noupdate /execution_testbench/ALUCntrl
add wave -noupdate /execution_testbench/xfer_size
add wave -noupdate /execution_testbench/zero
add wave -noupdate /execution_testbench/negative
add wave -noupdate /execution_testbench/carryOut
add wave -noupdate /execution_testbench/overflow
add wave -noupdate /execution_testbench/Da
add wave -noupdate /execution_testbench/Db
add wave -noupdate /execution_testbench/Daddr9SE
add wave -noupdate /execution_testbench/Imm12SE
add wave -noupdate /execution_testbench/ALUSrcMuxOut
add wave -noupdate /execution_testbench/ALUOut
add wave -noupdate /execution_testbench/MemOut
add wave -noupdate /execution_testbench/LDURBzp
add wave -noupdate /execution_testbench/LDURBMuxOut
add wave -noupdate /execution_testbench/MemtoRegMuxOut
add wave -noupdate /execution_testbench/MOVResult
add wave -noupdate /execution_testbench/MOVMuxOut
add wave -noupdate /execution_testbench/Reg2LocMuxOut
add wave -noupdate /execution_testbench/negFlag
add wave -noupdate /execution_testbench/overFlag
add wave -noupdate /execution_testbench/carryFlag
add wave -noupdate /execution_testbench/MOVOROut
add wave -noupdate /execution_testbench/BrTaken
add wave -noupdate /execution_testbench/UncondBr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3364003 ps} 0}
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {24150 ns}
