onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /CPUControl_testbench/Reg2Loc
add wave -noupdate /CPUControl_testbench/MemtoReg
add wave -noupdate /CPUControl_testbench/ALUSrc
add wave -noupdate /CPUControl_testbench/RegWrite
add wave -noupdate /CPUControl_testbench/MemWrite
add wave -noupdate /CPUControl_testbench/BrTaken
add wave -noupdate /CPUControl_testbench/UncondBr
add wave -noupdate /CPUControl_testbench/LDURB
add wave -noupdate /CPUControl_testbench/STURB
add wave -noupdate /CPUControl_testbench/MOVZ
add wave -noupdate /CPUControl_testbench/MOVK
add wave -noupdate /CPUControl_testbench/ALUCntrl
add wave -noupdate /CPUControl_testbench/zero
add wave -noupdate /CPUControl_testbench/negative
add wave -noupdate /CPUControl_testbench/OPCode
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 269
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {11050 ps} {11883 ps}
