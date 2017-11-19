onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /IFETCH_testbench/OPCode
add wave -noupdate /IFETCH_testbench/clk
add wave -noupdate /IFETCH_testbench/reset
add wave -noupdate /IFETCH_testbench/UncondBr
add wave -noupdate /IFETCH_testbench/BrTaken
add wave -noupdate /IFETCH_testbench/dut/PCOut
add wave -noupdate /IFETCH_testbench/dut/BrTakenMuxOut
add wave -noupdate /IFETCH_testbench/dut/PCPlus4
add wave -noupdate /IFETCH_testbench/OPCode
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {917000 ps} 0}
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
WaveRestoreZoom {0 ps} {997500 ps}
