onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix decimal /decoder5to32_testbench/registerSelect
add wave -noupdate /decoder5to32_testbench/registerWrite
add wave -noupdate /decoder5to32_testbench/whichReg
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {286 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 231
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {24 ps}
