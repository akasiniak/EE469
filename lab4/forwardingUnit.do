onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /forwardingUnit_testbench/ForwardMuxControlB
add wave -noupdate /forwardingUnit_testbench/ForwardMuxControlA
add wave -noupdate /forwardingUnit_testbench/REGDECOPCode
add wave -noupdate /forwardingUnit_testbench/MEMOPWriteReg
add wave -noupdate /forwardingUnit_testbench/EXOPWriteReg
add wave -noupdate /forwardingUnit_testbench/RdOrRm
add wave -noupdate /forwardingUnit_testbench/Rn
add wave -noupdate /forwardingUnit_testbench/EXRegWrite
add wave -noupdate /forwardingUnit_testbench/MEMRegWrite
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {338 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 190
configure wave -valuecolwidth 216
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
WaveRestoreZoom {0 ps} {1680 ps}
